Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3207ECB7E
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjKOTWm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjKOTWl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:22:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666BE12C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:22:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18648C433CD;
        Wed, 15 Nov 2023 19:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076155;
        bh=R+lCZF5VEdCtfwOzCTImvtp+uu7Sequ2khE2UyfhHHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iw4tCQq4b2Q0PKV+LleRuIG7YaJdC8gAPXqY8cEfel3eSyRWF1GYpOMVgUccfHEEm
         rsfjGWR9bF1/XLn9TQkgQmwkSjEpBYumO1L8pqLPRABoQ192xHZ6sqn57xzLNhXHJB
         qkiu9RKlbDsWbCbAUiI/IzhOzjswLZxMIzpAGm08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 108/550] can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()
Date:   Wed, 15 Nov 2023 14:11:32 -0500
Message-ID: <20231115191608.189736105@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 6841cab8c4504835e4011689cbdb3351dec693fd ]

This race condition was discovered while updating the at91_can driver
to use can_bus_off(). The following scenario describes how the
converted at91_can driver would behave.

When a CAN device goes into BUS-OFF state, the driver usually
stops/resets the CAN device and calls can_bus_off().

This function sets the netif carrier to off, and (if configured by
user space) schedules a delayed work that calls can_restart() to
restart the CAN device.

The can_restart() function first checks if the carrier is off and
triggers an error message if the carrier is OK.

Then it calls the driver's do_set_mode() function to restart the
device, then it sets the netif carrier to on. There is a race window
between these two calls.

The at91 CAN controller (observed on the sama5d3, a single core 32 bit
ARM CPU) has a hardware limitation. If the device goes into bus-off
while sending a CAN frame, there is no way to abort the sending of
this frame. After the controller is enabled again, another attempt is
made to send it.

If the bus is still faulty, the device immediately goes back to the
bus-off state. The driver calls can_bus_off(), the netif carrier is
switched off and another can_restart is scheduled. This occurs within
the race window before the original can_restart() handler marks the
netif carrier as OK. This would cause the 2nd can_restart() to be
called with an OK netif carrier, resulting in an error message.

The flow of the 1st can_restart() looks like this:

can_restart()
    // bail out if netif_carrier is OK

    netif_carrier_ok(dev)
    priv->do_set_mode(dev, CAN_MODE_START)
        // enable CAN controller
        // sama5d3 restarts sending old message

        // CAN devices goes into BUS_OFF, triggers IRQ

// IRQ handler start
    at91_irq()
        at91_irq_err_line()
            can_bus_off()
                netif_carrier_off()
                schedule_delayed_work()
// IRQ handler end

    netif_carrier_on()

The 2nd can_restart() will be called with an OK netif carrier and the
error message will be printed.

To close the race window, first set the netif carrier to on, then
restart the controller. In case the restart fails with an error code,
roll back the netif carrier to off.

Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
Link: https://lore.kernel.org/all/20231005-can-dev-fix-can-restart-v2-2-91b5c1fd922c@pengutronix.de
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev/dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index a5bbdfa9a2693..735d5de3caa0e 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -154,11 +154,12 @@ static void can_restart(struct net_device *dev)
 	priv->can_stats.restarts++;
 
 	/* Now restart the device */
-	err = priv->do_set_mode(dev, CAN_MODE_START);
-
 	netif_carrier_on(dev);
-	if (err)
+	err = priv->do_set_mode(dev, CAN_MODE_START);
+	if (err) {
 		netdev_err(dev, "Error %d during restart", err);
+		netif_carrier_off(dev);
+	}
 }
 
 static void can_restart_work(struct work_struct *work)
-- 
2.42.0



