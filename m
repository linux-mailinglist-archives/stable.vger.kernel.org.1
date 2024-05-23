Return-Path: <stable+bounces-45679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DB38CD238
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 14:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483AD283E55
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 12:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BA213E032;
	Thu, 23 May 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lSSUWMrs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791E1E481
	for <stable@vger.kernel.org>; Thu, 23 May 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466924; cv=none; b=XgiS3zftZU8So5sO2FMvC4m0bMWjWbsaEgadega6AAABsN/su4F56ND2yCbJIv1v+CDAf/2QJWw+LCMThB+yuT1jKFlFMv9Asm0/5gNQks+ObwGVZe/NZJTvQt/Q9Bg66t3+l3ZydNFW/d+hhqjPj4ssKiQZxFQId9Kg3D0kBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466924; c=relaxed/simple;
	bh=NVpMuECgQFHhRYDXnOVzNrRJbbNjSBNdcusrn6xzOIw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fn7HWddJNIBagR2yyRPR/wEsPt/svm3KrSn9hnE4W5ou1n/nGzAV4qRBcwJMisAlukt1crIChWFijfl2BY0sjx1ZdaxZcbdfIiexu818mw1Nou7RmnWsXER6F2D8kFlS0ZE/La4gMjVc+zKjFmt/MD2Cuq0+rS2J6OpRd2OmRNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lSSUWMrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F281C2BD10;
	Thu, 23 May 2024 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716466923;
	bh=NVpMuECgQFHhRYDXnOVzNrRJbbNjSBNdcusrn6xzOIw=;
	h=Subject:To:Cc:From:Date:From;
	b=lSSUWMrsUJ6nMZgzoel4er+qc1CE7hGmC7urIm3Q2Rs07OORhPX/KzHJh4wGolLyl
	 XDJ/YvRrD+L+CphnNy1dxrkLdtSDeQkUG0s3uZ++pGjZi0jEV/t2fk3Wi1XN6GTnVp
	 MLweBEU3vkwKD8ar0U/YcbXEacTpp9gkoJ4/V8FM=
Subject: FAILED: patch "[PATCH] usb: typec: tipd: fix event checking for tps6598x" failed to apply to 5.4-stable tree
To: javier.carrasco@wolfvision.net,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 May 2024 14:21:54 +0200
Message-ID: <2024052354-lustrous-corrode-977e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 409c1cfb5a803f3cf2d17aeaf75c25c4be951b07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052354-lustrous-corrode-977e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 409c1cfb5a803f3cf2d17aeaf75c25c4be951b07 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 29 Apr 2024 15:35:58 +0200
Subject: [PATCH] usb: typec: tipd: fix event checking for tps6598x

The current interrupt service routine of the tps6598x only reads the
first 64 bits of the INT_EVENT1 and INT_EVENT2 registers, which means
that any event above that range will be ignored, leaving interrupts
unattended. Moreover, those events will not be cleared, and the device
will keep the interrupt enabled.

This issue has been observed while attempting to load patches, and the
'ReadyForPatch' field (bit 81) of INT_EVENT1 was set.

Given that older versions of the tps6598x (1, 2 and 6) provide 8-byte
registers, a mechanism based on the upper byte of the version register
(0x0F) has been included. The manufacturer has confirmed [1] that this
byte is always 0 for older versions, and either 0xF7 (DH parts) or 0xF9
(DK parts) is returned in newer versions (7 and 8).

Read the complete INT_EVENT registers to handle all interrupts generated
by the device and account for the hardware version to select the
register size.

Link: https://e2e.ti.com/support/power-management-group/power-management/f/power-management-forum/1346521/tps65987d-register-command-to-distinguish-between-tps6591-2-6-and-tps65987-8 [1]
Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
Link: https://lore.kernel.org/r/20240429-tps6598x_fix_event_handling-v3-2-4e8e58dce489@wolfvision.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 7c2f01344860..191f86da283d 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -28,6 +28,7 @@
 #define TPS_REG_MODE			0x03
 #define TPS_REG_CMD1			0x08
 #define TPS_REG_DATA1			0x09
+#define TPS_REG_VERSION			0x0F
 #define TPS_REG_INT_EVENT1		0x14
 #define TPS_REG_INT_EVENT2		0x15
 #define TPS_REG_INT_MASK1		0x16
@@ -636,49 +637,67 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
+	int intev_len = TPS_65981_2_6_INTEVENT_LEN;
 	struct tps6598x *tps = data;
-	u64 event1 = 0;
-	u64 event2 = 0;
+	u64 event1[2] = { };
+	u64 event2[2] = { };
+	u32 version;
 	u32 status;
 	int ret;
 
 	mutex_lock(&tps->lock);
 
-	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
-	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
+	ret = tps6598x_read32(tps, TPS_REG_VERSION, &version);
+	if (ret)
+		dev_warn(tps->dev, "%s: failed to read version (%d)\n",
+			 __func__, ret);
+
+	if (TPS_VERSION_HW_VERSION(version) == TPS_VERSION_HW_65987_8_DH ||
+	    TPS_VERSION_HW_VERSION(version) == TPS_VERSION_HW_65987_8_DK)
+		intev_len = TPS_65987_8_INTEVENT_LEN;
+
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len);
+
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len);
 	if (ret) {
-		dev_err(tps->dev, "%s: failed to read events\n", __func__);
+		dev_err(tps->dev, "%s: failed to read event1\n", __func__);
 		goto err_unlock;
 	}
-	trace_tps6598x_irq(event1, event2);
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT2, event2, intev_len);
+	if (ret) {
+		dev_err(tps->dev, "%s: failed to read event2\n", __func__);
+		goto err_unlock;
+	}
+	trace_tps6598x_irq(event1[0], event2[0]);
 
-	if (!(event1 | event2))
+	if (!(event1[0] | event1[1] | event2[0] | event2[1]))
 		goto err_unlock;
 
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
 	/* Handle plug insert or removal */
-	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_PLUG_EVENT)
 		tps6598x_handle_plug_event(tps, status);
 
 err_clear_ints:
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event1, intev_len);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR2, event2, intev_len);
 
 err_unlock:
 	mutex_unlock(&tps->lock);
 
-	if (event1 | event2)
+	if (event1[0] | event1[1] | event2[0] | event2[1])
 		return IRQ_HANDLED;
+
 	return IRQ_NONE;
 }
 
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 89b24519463a..9b23e9017452 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -253,4 +253,15 @@
 #define TPS_PTCC_DEV				2
 #define TPS_PTCC_APP				3
 
+/* Version Register */
+#define TPS_VERSION_HW_VERSION_MASK            GENMASK(31, 24)
+#define TPS_VERSION_HW_VERSION(x)              TPS_FIELD_GET(TPS_VERSION_HW_VERSION_MASK, (x))
+#define TPS_VERSION_HW_65981_2_6               0x00
+#define TPS_VERSION_HW_65987_8_DH              0xF7
+#define TPS_VERSION_HW_65987_8_DK              0xF9
+
+/* Int Event Register length */
+#define TPS_65981_2_6_INTEVENT_LEN             8
+#define TPS_65987_8_INTEVENT_LEN               11
+
 #endif /* __TPS6598X_H__ */


