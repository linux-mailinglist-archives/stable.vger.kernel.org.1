Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C19775778
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjHIKqY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjHIKqX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA6D1702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B92063118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89037C433C8;
        Wed,  9 Aug 2023 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577981;
        bh=+w5/Zduul5tnSgpVFEGA9PFKCeV/Xgi+eD0DUWXoz70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=foNwaT4ikoM1SYW9c68vIV83FayER8hNOPFdB7nU+Q0UYKrN2ulLsnFA85fTLfWwO
         BkGszNqAbfg46nzL0QgYau9trNN2TPzTNcf71WP+rNrFJNNjRTAmhwDAZ1PTvrZ+kC
         CAHv2gkpD3UDLVJ90ZRXZujJlHmDg4KKC5WBjo2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Duoming Zhou <duoming@zju.edu.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 062/165] net: usb: lan78xx: reorder cleanup operations to avoid UAF bugs
Date:   Wed,  9 Aug 2023 12:39:53 +0200
Message-ID: <20230809103644.851543936@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 1e7417c188d0a83fb385ba2dbe35fd2563f2b6f3 ]

The timer dev->stat_monitor can schedule the delayed work dev->wq and
the delayed work dev->wq can also arm the dev->stat_monitor timer.

When the device is detaching, the net_device will be deallocated. but
the net_device private data could still be dereferenced in delayed work
or timer handler. As a result, the UAF bugs will happen.

One racy situation is shown below:

      (Thread 1)                 |      (Thread 2)
lan78xx_stat_monitor()           |
 ...                             |  lan78xx_disconnect()
 lan78xx_defer_kevent()          |    ...
  ...                            |    cancel_delayed_work_sync(&dev->wq);
  schedule_delayed_work()        |    ...
  (wait some time)               |    free_netdev(net); //free net_device
  lan78xx_delayedwork()          |
  //use net_device private data  |
  dev-> //use                    |

Although we use cancel_delayed_work_sync() to cancel the delayed work
in lan78xx_disconnect(), it could still be scheduled in timer handler
lan78xx_stat_monitor().

Another racy situation is shown below:

      (Thread 1)                |      (Thread 2)
lan78xx_delayedwork             |
 mod_timer()                    |  lan78xx_disconnect()
                                |   cancel_delayed_work_sync()
 (wait some time)               |   if (timer_pending(&dev->stat_monitor))
             	                |       del_timer_sync(&dev->stat_monitor);
 lan78xx_stat_monitor()         |   ...
  lan78xx_defer_kevent()        |   free_netdev(net); //free
   //use net_device private data|
   dev-> //use                  |

Although we use del_timer_sync() to delete the timer, the function
timer_pending() returns 0 when the timer is activated. As a result,
the del_timer_sync() will not be executed and the timer could be
re-armed.

In order to mitigate this bug, We use timer_shutdown_sync() to shutdown
the timer and then use cancel_delayed_work_sync() to cancel the delayed
work. As a result, the net_device could be deallocated safely.

What's more, the dev->flags is set to EVENT_DEV_DISCONNECT in
lan78xx_disconnect(). But it could still be set to EVENT_STAT_UPDATE
in lan78xx_stat_monitor(). So this patch put the set_bit() behind
timer_shutdown_sync().

Fixes: 77dfff5bb7e2 ("lan78xx: Fix race condition in disconnect handling")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c458c030fadf6..59cde06aa7f60 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -4224,8 +4224,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	if (!dev)
 		return;
 
-	set_bit(EVENT_DEV_DISCONNECT, &dev->flags);
-
 	netif_napi_del(&dev->napi);
 
 	udev = interface_to_usbdev(intf);
@@ -4233,6 +4231,8 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 
 	unregister_netdev(net);
 
+	timer_shutdown_sync(&dev->stat_monitor);
+	set_bit(EVENT_DEV_DISCONNECT, &dev->flags);
 	cancel_delayed_work_sync(&dev->wq);
 
 	phydev = net->phydev;
@@ -4247,9 +4247,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 
 	usb_scuttle_anchored_urbs(&dev->deferred);
 
-	if (timer_pending(&dev->stat_monitor))
-		del_timer_sync(&dev->stat_monitor);
-
 	lan78xx_unbind(dev, intf);
 
 	lan78xx_free_tx_resources(dev);
-- 
2.40.1



