package Amazon::MWS::Orders;

=head1 NAME

Amazon::MWS::Orders - API order methods for Amazon Marketplace Web Services.

=head1 API methods

=head2 GetServiceStatus

=head2 ListOrders

=head2 ListOrdersByNextToken

=head2 GetOrder

=head2 ListOrderItems

=head2 ListOrderItemsByNextToken

=head1 Functions

=head2 convert_ListOrdersResult

=head2 convert_ListOrderItemsResult

=cut

use strict;
use warnings;

use Amazon::MWS::Routines qw(:all);

my $version = '2013-09-01';
my $orders_service = "/Orders/$version";

=head1 NAME

Amazon::MWS::Finances - API methods for finances

=cut

define_api_method GetServiceStatus =>
    raw_body => 0,
    service => "$orders_service",
    module_name => 'Amazon::MWS::Orders',
    parameters => {},
    respond => sub {
        my $root = shift;
        return $root->{Status};
   };

define_api_method ListOrders =>
    service => $orders_service,
    version => $version,
    parameters => {
        MarketplaceId => {
             required   =>      1,
             type       =>      'IdList',
        },
        OrderStatus             => { type => 'StatusList' },
        CreatedAfter            => { type => 'datetime' },
        CreatedBefore           => { type => 'datetime' },
        LastUpdatedAfter        => { type => 'datetime' },
        LastUpdatedBefore       => { type => 'datetime' },
        MaxResultsPerPage       => { type => 'nonNegativeInteger' },
    },
    respond => sub {
	my $root = shift;
        convert_ListOrdersResult($root);
        return $root;
    };

define_api_method ListOrdersByNextToken =>
    service => "$orders_service",
    version => $version,
    parameters => {
       NextToken => {
            type     => 'string',
            required => 1,
        },
    },
    respond => sub {
        my $root = shift;
        convert_ListOrdersResult($root);
        return $root;
    };

define_api_method GetOrder =>
    service => "$orders_service",
    version => $version,
    parameters => {
	AmazonOrderId => {
             required   =>      1,
             type       =>      'IdList',
        },
   },
    respond => sub {
        my $root = shift;
        convert_ListOrdersResult($root);
        return $root;
    };

define_api_method ListOrderItems =>
    service => "$orders_service",
    version => $version,
    parameters => {
        AmazonOrderId => {
             required   =>      1,
             type       =>      'string',
        },
    },
    respond => sub {
        my $root = shift;
        convert_ListOrderItemsResult($root);
        return $root;
    };

define_api_method ListOrderItemsByNextToken =>
    service => "$orders_service",
    version => $version,
    parameters => {
       NextToken => {
            type     => 'string',
            required => 1,
        },
    },
    respond => sub {
        my $root = shift;
        convert_ListOrderItemsResult($root);
        return $root;
    };

sub convert_ListOrdersResult {
    my $root = shift;
    Amazon::MWS::Routines::force_array($root->{Orders}, 'Order');
}

sub convert_ListOrderItemsResult {

    my $root = shift;
    Amazon::MWS::Routines::force_array($root->{OrderItems}, 'OrderItem');
}


1;
