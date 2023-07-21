Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7D375D2E4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjGUTEx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjGUTEw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:04:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5185830CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E472C61D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BD9C433CB;
        Fri, 21 Jul 2023 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966290;
        bh=n5XLZFzWVntRmT/3jjB39hsfqreFoRQ037OVWUVq/eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHGqRFL0o6HO4l4b4FA03/8V/wvruwnd8V+LqR6Q/KhZ4dmUHWzn+hkpXcdMuE9c6
         qiCzSA2EAKPCFB6oI3I7v1PeMZhmldGIoUqkkE8bKdEZ0tfxhjz6uOUg9kT4qY0Byu
         qfY1+vN9+SW11FoW24Tq0ubRS6NlHCA2lsyzhdKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 284/532] usb: hide unused usbfs_notify_suspend/resume functions
Date:   Fri, 21 Jul 2023 18:03:08 +0200
Message-ID: <20230721160629.828789379@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 8e6bd945e6dde64fbc60ec3fe252164493a8d3a2 ]

The declaration is in an #ifdef, which causes warnings when building
with 'make W=1' and without CONFIG_PM:

drivers/usb/core/devio.c:742:6: error: no previous prototype for 'usbfs_notify_suspend'
drivers/usb/core/devio.c:747:6: error: no previous prototype for 'usbfs_notify_resume'

Use the same #ifdef check around the function definitions to avoid
the warnings and slightly shrink the USB core.

Fixes: 7794f486ed0b ("usbfs: Add ioctls for runtime power management")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20230516202103.558301-1-arnd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/devio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 5e34986fac96f..5cd0a724b425e 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -735,6 +735,7 @@ static int driver_resume(struct usb_interface *intf)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 /* The following routines apply to the entire device, not interfaces */
 void usbfs_notify_suspend(struct usb_device *udev)
 {
@@ -753,6 +754,7 @@ void usbfs_notify_resume(struct usb_device *udev)
 	}
 	mutex_unlock(&usbfs_mutex);
 }
+#endif
 
 struct usb_driver usbfs_driver = {
 	.name =		"usbfs",
-- 
2.39.2



