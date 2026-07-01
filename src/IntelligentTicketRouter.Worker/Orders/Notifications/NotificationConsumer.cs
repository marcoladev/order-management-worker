using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace IntelligentTicketRouter.Worker.Orders.Notifications;


public class NotificationConsumer : BackgroundService
{
    private readonly IServiceScopeFactory _scopeFactory;

    public NotificationConsumer(IServiceScopeFactory scopeFactory)
    {
        _scopeFactory = scopeFactory;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        using var scope = _scopeFactory.CreateScope();
         
        /*
        var notificationHandler = scope.ServiceProvider
        .GetRequiredService<NotificationHandler>();

        await notificationHandler.HandleNotifications(stoppingToken);
        */
    }
}