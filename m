Return-Path: <stable+bounces-203506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D105CE68F7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C08513008E9E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADAC30DD00;
	Mon, 29 Dec 2025 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UdtwYNNH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D0D30DD02
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008381; cv=none; b=AH4HwvTfI0EkLjSFbkUm63fmOqxwwRDYFhi7gXphH8Gmta6s0jT8BXDkXFsMWSWK29YQ/Np5ih1PxE1qS0m9UUQTTsovEdEtLVGAACX/ZCE/aQHnMyIvAcDlHPYevMXxMb2cWl+ojn89ejmicbs8LA23EQe5O1+ifuznXlEZ4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008381; c=relaxed/simple;
	bh=Qt+5lm8fH5Segndpskt6n768aklkbxjTdB02iEps6WM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DDXG2TO8BcBBeL8CkMkArGoQifHjFtHNsP6e+88L9KaY1XBbTq5ZP+AL6GkaePTFclOlyKUOUV/wRhiT93+QMK4QvWg5bkvoo+9PHXaIGgwZpJL12OmZkCsqob8Qq3UXg62/VAFl+RVUedOnKc8F1Av8tvOi7EjtqmweBftjy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UdtwYNNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA23C116C6;
	Mon, 29 Dec 2025 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008378;
	bh=Qt+5lm8fH5Segndpskt6n768aklkbxjTdB02iEps6WM=;
	h=Subject:To:Cc:From:Date:From;
	b=UdtwYNNH4g75by8BNFnlbYvzVo+Vo0DJc7a1nk+E2l7JGcmg1tMD/Er2WL45LtnC5
	 YVTiAvu3npHDOa4MDpL6aayPXK54dZoIOIJMsb2IWt0VzkoRjK6ea538KyR1xWvz4H
	 mO5ldKSmfOJIDkiCmX6lL4ftpaZUUKYsDaLGjJc4=
Subject: FAILED: patch "[PATCH] wifi: mt76: Fix DTS power-limits on little endian systems" failed to apply to 6.6-stable tree
To: se@simonwunderlich.de,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:39:36 +0100
Message-ID: <2025122936-python-fidgeting-f6f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 38b845e1f9e810869b0a0b69f202b877b7b7fb12
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122936-python-fidgeting-f6f4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38b845e1f9e810869b0a0b69f202b877b7b7fb12 Mon Sep 17 00:00:00 2001
From: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Date: Fri, 26 Sep 2025 11:32:54 +0200
Subject: [PATCH] wifi: mt76: Fix DTS power-limits on little endian systems

The power-limits for ru and mcs and stored in the devicetree as bytewise
array (often with sizes which are not a multiple of 4). These arrays have a
prefix which defines for how many modes a line is applied. This prefix is
also only a byte - but the code still tried to fix the endianness of this
byte with a be32 operation. As result, loading was mostly failing or was
sending completely unexpected values to the firmware.

Since the other rates are also stored in the devicetree as bytewise arrays,
just drop the u32 access + be32_to_cpu conversion and directly access them
as bytes arrays.

Cc: stable@vger.kernel.org
Fixes: 22b980badc0f ("mt76: add functions for parsing rate power limits from DT")
Fixes: a9627d992b5e ("mt76: extend DT rate power limits to support 11ax devices")
Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index a987c5e4eff6..6ce8e4af18fe 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -253,6 +253,19 @@ mt76_get_of_array(struct device_node *np, char *name, size_t *len, int min)
 	return prop->value;
 }
 
+static const s8 *
+mt76_get_of_array_s8(struct device_node *np, char *name, size_t *len, int min)
+{
+	struct property *prop = of_find_property(np, name, NULL);
+
+	if (!prop || !prop->value || prop->length < min)
+		return NULL;
+
+	*len = prop->length;
+
+	return prop->value;
+}
+
 struct device_node *
 mt76_find_channel_node(struct device_node *np, struct ieee80211_channel *chan)
 {
@@ -294,7 +307,7 @@ mt76_get_txs_delta(struct device_node *np, u8 nss)
 }
 
 static void
-mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const __be32 *data,
+mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const s8 *data,
 		       s8 target_power, s8 nss_delta, s8 *max_power)
 {
 	int i;
@@ -303,15 +316,14 @@ mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const __be32 *data,
 		return;
 
 	for (i = 0; i < pwr_len; i++) {
-		pwr[i] = min_t(s8, target_power,
-			       be32_to_cpu(data[i]) + nss_delta);
+		pwr[i] = min_t(s8, target_power, data[i] + nss_delta);
 		*max_power = max(*max_power, pwr[i]);
 	}
 }
 
 static void
 mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
-			     const __be32 *data, size_t len, s8 target_power,
+			     const s8 *data, size_t len, s8 target_power,
 			     s8 nss_delta, s8 *max_power)
 {
 	int i, cur;
@@ -319,8 +331,7 @@ mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
 	if (!data)
 		return;
 
-	len /= 4;
-	cur = be32_to_cpu(data[0]);
+	cur = data[0];
 	for (i = 0; i < pwr_num; i++) {
 		if (len < pwr_len + 1)
 			break;
@@ -335,7 +346,7 @@ mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
 		if (!len)
 			break;
 
-		cur = be32_to_cpu(data[0]);
+		cur = data[0];
 	}
 }
 
@@ -346,7 +357,7 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 {
 	struct mt76_dev *dev = phy->dev;
 	struct device_node *np;
-	const __be32 *val;
+	const s8 *val;
 	char name[16];
 	u32 mcs_rates = dev->drv->mcs_rates;
 	u32 ru_rates = ARRAY_SIZE(dest->ru[0]);
@@ -392,21 +403,21 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 
 	txs_delta = mt76_get_txs_delta(np, hweight16(phy->chainmask));
 
-	val = mt76_get_of_array(np, "rates-cck", &len, ARRAY_SIZE(dest->cck));
+	val = mt76_get_of_array_s8(np, "rates-cck", &len, ARRAY_SIZE(dest->cck));
 	mt76_apply_array_limit(dest->cck, ARRAY_SIZE(dest->cck), val,
 			       target_power, txs_delta, &max_power);
 
-	val = mt76_get_of_array(np, "rates-ofdm",
-				&len, ARRAY_SIZE(dest->ofdm));
+	val = mt76_get_of_array_s8(np, "rates-ofdm",
+				   &len, ARRAY_SIZE(dest->ofdm));
 	mt76_apply_array_limit(dest->ofdm, ARRAY_SIZE(dest->ofdm), val,
 			       target_power, txs_delta, &max_power);
 
-	val = mt76_get_of_array(np, "rates-mcs", &len, mcs_rates + 1);
+	val = mt76_get_of_array_s8(np, "rates-mcs", &len, mcs_rates + 1);
 	mt76_apply_multi_array_limit(dest->mcs[0], ARRAY_SIZE(dest->mcs[0]),
 				     ARRAY_SIZE(dest->mcs), val, len,
 				     target_power, txs_delta, &max_power);
 
-	val = mt76_get_of_array(np, "rates-ru", &len, ru_rates + 1);
+	val = mt76_get_of_array_s8(np, "rates-ru", &len, ru_rates + 1);
 	mt76_apply_multi_array_limit(dest->ru[0], ARRAY_SIZE(dest->ru[0]),
 				     ARRAY_SIZE(dest->ru), val, len,
 				     target_power, txs_delta, &max_power);


