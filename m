Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6277614AC
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjGYLVl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjGYLVk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B15D13D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B1F615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A167BC433C7;
        Tue, 25 Jul 2023 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284099;
        bh=8l7XzQtqX4yokLfq9O14GJE+di7RNty3J2FSe+cOSuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCxJj2aPTPTKMUxqR6JhQZloeHREMXY0eWA/wXC1mt5Zl/L8b3PlGLxp3+CbMq71h
         20q3zpisrWqmLBujbqbeiHewEhkvALeIC8NxrnV+dW6qGEFBNKyhp4c+sqzF8primn
         vaiXJiaPJOHRC5cBYaf+h7KhupGE5QD3BemYkesE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 234/509] usb: hide unused usbfs_notify_suspend/resume functions
Date:   Tue, 25 Jul 2023 12:42:53 +0200
Message-ID: <20230725104604.474721965@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 2fe29319de441..1b95035d179f3 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -734,6 +734,7 @@ static int driver_resume(struct usb_interface *intf)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 /* The following routines apply to the entire device, not interfaces */
 void usbfs_notify_suspend(struct usb_device *udev)
 {
@@ -752,6 +753,7 @@ void usbfs_notify_resume(struct usb_device *udev)
 	}
 	mutex_unlock(&usbfs_mutex);
 }
+#endif
 
 struct usb_driver usbfs_driver = {
 	.name =		"usbfs",
-- 
2.39.2



