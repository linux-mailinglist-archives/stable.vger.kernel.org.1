Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3060A77009D
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHDM56 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 08:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjHDM54 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 08:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0AC11B
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 05:57:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49D7161FD1
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 12:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58319C433C7;
        Fri,  4 Aug 2023 12:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691153874;
        bh=OBatFf9f4fc89U2kcbEGj6cLOm5lMZAiOsYtdZGyEAg=;
        h=Subject:To:From:Date:From;
        b=ZlR/T4hokNGYBJCabt5j9h+jPVb/Zm22asMHHL+G/f2w6zaZ5kCQ+PXEcF+5ugBLQ
         62I5+zsSbyCU1GnQqzL5j0yXlaJpCbILvIITxutFQ3LF5hZT1YTtz0RPV5whoauGAC
         +f2FbA25yDLnk+fo2xZvyU1QLbUPbanprKscPENE=
Subject: patch "usb: common: usb-conn-gpio: Prevent bailing out if initial role is" added to usb-linus
To:     quic_prashk@quicinc.com, angelogioacchino.delregno@collabora.com,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 04 Aug 2023 14:57:40 +0200
Message-ID: <2023080439-handled-subatomic-44ac@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


This is a note to let you know that I've just added the patch titled

    usb: common: usb-conn-gpio: Prevent bailing out if initial role is

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 8e21a620c7e6e00347ade1a6ed4967b359eada5a Mon Sep 17 00:00:00 2001
From: Prashanth K <quic_prashk@quicinc.com>
Date: Tue, 1 Aug 2023 14:33:52 +0530
Subject: usb: common: usb-conn-gpio: Prevent bailing out if initial role is
 none

Currently if we bootup a device without cable connected, then
usb-conn-gpio won't call set_role() because last_role is same
as current role. This happens since last_role gets initialised
to zero during the probe.

To avoid this, add a new flag initial_detection into struct
usb_conn_info, which prevents bailing out during initial
detection.

Cc: <stable@vger.kernel.org> # 5.4
Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/1690880632-12588-1-git-send-email-quic_prashk@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/common/usb-conn-gpio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 766005d20bae..501e8bc9738e 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -42,6 +42,7 @@ struct usb_conn_info {
 
 	struct power_supply_desc desc;
 	struct power_supply *charger;
+	bool initial_detection;
 };
 
 /*
@@ -86,11 +87,13 @@ static void usb_conn_detect_cable(struct work_struct *work)
 	dev_dbg(info->dev, "role %s -> %s, gpios: id %d, vbus %d\n",
 		usb_role_string(info->last_role), usb_role_string(role), id, vbus);
 
-	if (info->last_role == role) {
+	if (!info->initial_detection && info->last_role == role) {
 		dev_warn(info->dev, "repeated role: %s\n", usb_role_string(role));
 		return;
 	}
 
+	info->initial_detection = false;
+
 	if (info->last_role == USB_ROLE_HOST && info->vbus)
 		regulator_disable(info->vbus);
 
@@ -258,6 +261,7 @@ static int usb_conn_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(&pdev->dev, true);
 
 	/* Perform initial detection */
+	info->initial_detection = true;
 	usb_conn_queue_dwork(info, 0);
 
 	return 0;
-- 
2.41.0


