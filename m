Return-Path: <stable+bounces-178000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE5B4771D
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 22:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A557B60F6
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4F926CE2C;
	Sat,  6 Sep 2025 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id20ptMY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32AC28468C
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757189963; cv=none; b=c3kJT3po2eMiWfa/vKbw7y2pcY8GOtgsouZlugqz3psTtBV0aVoz/yVwhaX+5NaCGcPDLPkXG6LThjSLHL/5YMX4gpwIZN9JthduB30ouqNVsGzoCr0hzxzvjTcx05UUgJaP3z1KM5dcvih5o88G0PkY+QPBCkU18xd5aonvMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757189963; c=relaxed/simple;
	bh=CNSqP+8Pv3shaGSAjCYQ/bucbwhARu27PNQjJus0GSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEnrxwuxYcBfEGm0E1+3N8sMPE6j3K23hcCrIuhPzUrqg3K9PdkitFHS7Dt+gtTwf3vz36mThjKipW/+DwrPHiH7eOup6LdpHESErVc8dlrUAHw9x5fPq1uEPsCDa+/g1a3yrn4XuV7be9ZtTGh1eJYuOT9MuH04Zy8bu3IcR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id20ptMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76FDC4CEE7;
	Sat,  6 Sep 2025 20:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757189963;
	bh=CNSqP+8Pv3shaGSAjCYQ/bucbwhARu27PNQjJus0GSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Id20ptMY4xRKek9a6DFud6Ht1iy0YvNCVmYVOPTRkDVIADqgSNgPkbUtycopzFgEV
	 5YhlRFn6QgDyxwkRjUK0Lh6qZ8YwQKi+foNZJMuN5rbCkTbL5uui4HKqrPyTuwO9xp
	 gNS85e2zhlxFxJ6Gui1btXg5bxm76K3TKTUs3JBawnk6dXgwulOqMDm169COdEbEvF
	 HuxfcQATcQXiVEP6lgvRNzt/6xjG/LnYSC5dXf7fRtLm3ytcVLIBxu9TZQ0nTiVtOm
	 mxQsq1eOLAp7259qi0RN2XNeuXPIMrPsz3snVSqtLfV/348+bxQsGdelDnhAhQ51XH
	 /WFvEmpQ7P/Mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] thermal/drivers/mediatek/lvts: Disable low offset IRQ for minimum threshold
Date: Sat,  6 Sep 2025 16:19:21 -0400
Message-ID: <20250906201921.261506-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041731-pellet-morale-d20d@gregkh>
References: <2025041731-pellet-morale-d20d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit fa17ff8e325a657c84be1083f06e54ee7eea82e4 ]

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
[ Adapted interrupt mask definitions ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 50 ++++++++++++++++++-------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 8d0ccf494ba22..603b37ce1eb8e 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -67,10 +67,14 @@
 #define LVTS_CALSCALE_CONF			0x300
 #define LVTS_MONINT_CONF			0x8300318C
 
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
@@ -308,23 +312,41 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 
 static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
 {
-	u32 masks[] = {
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
 
 	value = readl(LVTS_MONINT(lvts_ctrl->base));
 
-	for (i = 0; i < ARRAY_SIZE(masks); i++) {
+	for (i = 0; i < ARRAY_SIZE(high_offset_inten_masks); i++) {
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
-- 
2.51.0


