Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C16790656
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351842AbjIBImT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 04:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbjIBImS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 04:42:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E6910F4
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 01:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21B5C60C25
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 08:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B33C433C8;
        Sat,  2 Sep 2023 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693644134;
        bh=Mn1iUMLxjlfXvmN8/gN4h8Z7wrYPmKoCg5/bZVDaCyQ=;
        h=Subject:To:Cc:From:Date:From;
        b=m4o0h0ZMhKXuRsxNdJwj8bJyCslC+eTUdAMz5EawrxvxcJlo7d8WsTQbn8PIxp6r+
         ivgX1ONgTddl9ChNctM3KyjXQOnNKxekNvxqddQbtviak3psl6OKliH9toDcIPh7tj
         H37zCAfuix9rI6kzrikmiGzOy0gSeOa2aDpDK+HE=
Subject: FAILED: patch "[PATCH] staging: rtl8712: fix race condition" failed to apply to 4.14-stable tree
To:     namcaov@gmail.com, gregkh@linuxfoundation.org, stable@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 02 Sep 2023 10:42:03 +0200
Message-ID: <2023090203-recovery-thespian-8971@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 1422b526fba994cf05fd288a152106563b875fce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090203-recovery-thespian-8971@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1422b526fba994cf05fd288a152106563b875fce Mon Sep 17 00:00:00 2001
From: Nam Cao <namcaov@gmail.com>
Date: Mon, 31 Jul 2023 13:06:20 +0200
Subject: [PATCH] staging: rtl8712: fix race condition

In probe function, request_firmware_nowait() is called to load firmware
asynchronously. At completion of firmware loading, register_netdev() is
called. However, a mutex needed by netdev is initialized after the call
to request_firmware_nowait(). Consequently, it can happen that
register_netdev() is called before the driver is ready.

Move the mutex initialization into r8712_init_drv_sw(), which is called
before request_firmware_nowait().

Reported-by: syzbot+b08315e8cf5a78eed03c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-staging/000000000000d9d4560601b8e0d7@google.com/T/#u
Fixes: 8c213fa59199 ("staging: r8712u: Use asynchronous firmware loading")
Cc: stable <stable@kernel.org>
Signed-off-by: Nam Cao <namcaov@gmail.com>
Link: https://lore.kernel.org/r/20230731110620.116562-1-namcaov@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index a2f3645be0cc..b18e6d9c832b 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -327,6 +327,7 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	mp871xinit(padapter);
 	init_default_value(padapter);
 	r8712_InitSwLeds(padapter);
+	mutex_init(&padapter->mutex_start);
 
 	return 0;
 
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 37364d3101e2..df05213f922f 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -567,7 +567,6 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 	if (rtl871x_load_fw(padapter))
 		goto deinit_drv_sw;
 	init_completion(&padapter->rx_filter_ready);
-	mutex_init(&padapter->mutex_start);
 	return 0;
 
 deinit_drv_sw:

