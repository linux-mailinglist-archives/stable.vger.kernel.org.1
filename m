Return-Path: <stable+bounces-133172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1BEA91E9F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38548A0EEB
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5323F420;
	Thu, 17 Apr 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PiEutXt+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F986358
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897751; cv=none; b=rxjzPo9EjYS8/WDjjGhkc3op4WUszX+wSx4HsIl6WEuzjzSKPD/rsVdcRAzboZtMIQ3gADNHndHCdB0ERHhvySxCv0ckPrJBRO6IWDjlo0WUIURYfGgLt0O9m7VnOkayekOp4xdDQbg0VfoRcvf4Azkg3liCSwRj18dA2IUODy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897751; c=relaxed/simple;
	bh=/5fE9nSBvillFchESTIt6O+IffjAvAo52Eu0E+5tH5c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qgLIPi598RfI7OM+ttE2ztY7l8gR0bYXu8DOEQ9frwgfLAGgHjwgx8/Xi/5AIjkgVl8vME3oTpX/mHNi/3LgBvfMPeR3McgYE4K9MQIg/ep5MGJMFT7B9UrqFatrW8JsK0WXJdi22D68gyyL5yRWTBldplt36nAw6oDFp4hfqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PiEutXt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8D3C4CEE4;
	Thu, 17 Apr 2025 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744897751;
	bh=/5fE9nSBvillFchESTIt6O+IffjAvAo52Eu0E+5tH5c=;
	h=Subject:To:Cc:From:Date:From;
	b=PiEutXt+WccutxG3xZTJDYqYLFm+UICLOdGis9z1jebbH+qRPMbE66kp7+9w6Juna
	 fQk78PhyEP1Zsg2gJ5Ow9q9Lo+F+/oTTNAarTf9sfZnV3CkNU2GB4Cu7U1oaUwbmfJ
	 TW73Mfeq5IgSmQb881eFDHkg0qXo3rNg6fNAx9dE=
Subject: FAILED: patch "[PATCH] thermal/drivers/mediatek/lvts: Disable low offset IRQ for" failed to apply to 6.14-stable tree
To: nfraprado@collabora.com,angelogioacchino.delregno@collabora.com,daniel.lezcano@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:49:08 +0200
Message-ID: <2025041708-pasta-coroner-1111@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x fa17ff8e325a657c84be1083f06e54ee7eea82e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041708-pasta-coroner-1111@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa17ff8e325a657c84be1083f06e54ee7eea82e4 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
Date: Mon, 13 Jan 2025 10:27:14 -0300
Subject: [PATCH] thermal/drivers/mediatek/lvts: Disable low offset IRQ for
 minimum threshold
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In order to get working interrupts, a low offset value needs to be
configured. The minimum value for it is 20 Celsius, which is what is
configured when there's no lower thermal trip (ie the thermal core
passes -INT_MAX as low trip temperature). However, when the temperature
gets that low and fluctuates around that value it causes an interrupt
storm.

Prevent that interrupt storm by not enabling the low offset interrupt if
the low threshold is the minimum one.

Cc: stable@vger.kernel.org
Fixes: 77354eaef821 ("thermal/drivers/mediatek/lvts_thermal: Don't leave threshold zeroed")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Link: https://lore.kernel.org/r/20250113-mt8192-lvts-filtered-suspend-fix-v2-3-07a25200c7c6@collabora.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0aaa44b734ca..04bfbfe93a71 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -67,10 +67,14 @@
 #define LVTS_CALSCALE_CONF			0x300
 #define LVTS_MONINT_CONF			0x0300318C
 
-#define LVTS_MONINT_OFFSET_SENSOR0		0xC
-#define LVTS_MONINT_OFFSET_SENSOR1		0x180
-#define LVTS_MONINT_OFFSET_SENSOR2		0x3000
-#define LVTS_MONINT_OFFSET_SENSOR3		0x3000000
+#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR0		BIT(3)
+#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR1		BIT(8)
+#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR2		BIT(13)
+#define LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR3		BIT(25)
+#define LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR0		BIT(2)
+#define LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR1		BIT(7)
+#define LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR2		BIT(12)
+#define LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR3		BIT(24)
 
 #define LVTS_INT_SENSOR0			0x0009001F
 #define LVTS_INT_SENSOR1			0x001203E0
@@ -326,11 +330,17 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 
 static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
 {
-	static const u32 masks[] = {
-		LVTS_MONINT_OFFSET_SENSOR0,
-		LVTS_MONINT_OFFSET_SENSOR1,
-		LVTS_MONINT_OFFSET_SENSOR2,
-		LVTS_MONINT_OFFSET_SENSOR3,
+	static const u32 high_offset_inten_masks[] = {
+		LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR0,
+		LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR1,
+		LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR2,
+		LVTS_MONINT_OFFSET_HIGH_INTEN_SENSOR3,
+	};
+	static const u32 low_offset_inten_masks[] = {
+		LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR0,
+		LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR1,
+		LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR2,
+		LVTS_MONINT_OFFSET_LOW_INTEN_SENSOR3,
 	};
 	u32 value = 0;
 	int i;
@@ -339,10 +349,22 @@ static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
 
 	for (i = 0; i < ARRAY_SIZE(masks); i++) {
 		if (lvts_ctrl->sensors[i].high_thresh == lvts_ctrl->high_thresh
-		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh)
-			value |= masks[i];
-		else
-			value &= ~masks[i];
+		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh) {
+			/*
+			 * The minimum threshold needs to be configured in the
+			 * OFFSETL register to get working interrupts, but we
+			 * don't actually want to generate interrupts when
+			 * crossing it.
+			 */
+			if (lvts_ctrl->low_thresh == -INT_MAX) {
+				value &= ~low_offset_inten_masks[i];
+				value |= high_offset_inten_masks[i];
+			} else {
+				value |= low_offset_inten_masks[i] | high_offset_inten_masks[i];
+			}
+		} else {
+			value &= ~(low_offset_inten_masks[i] | high_offset_inten_masks[i]);
+		}
 	}
 
 	writel(value, LVTS_MONINT(lvts_ctrl->base));


