Return-Path: <stable+bounces-204137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C226CE8316
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 22:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30E053010CC6
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 21:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EBA2E6CA0;
	Mon, 29 Dec 2025 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdSGTwFr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A227B336
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767042810; cv=none; b=NAkPICl1sj6fOMIN3qat1VTXANcHGBOl6+zALgbV0aaEggkKleZRFptc/Z8bo2aMmrLTh1YBEaDm+lUVNcnrkszh2bL0ghPtJDBRhuDbqgMR3rZ6WB6QvhPLk1gz0UBSZSluWJIkfaUK03JlpNCg28pgKDiBz7l7Ve8yLdmjOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767042810; c=relaxed/simple;
	bh=47wn4qbeUgws/VaRdK21B3QDm+QXKh9u1GsU6HmVl94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKqhLPVH+rWZDytkn4H+RAcs7zrgqylqJ4dQBUOxtr+yp+pidZnWtSaiQNc3yp1PKEPwbvq3Slh3oRP7rviK4JaFWh2gEtNWpF+PQdEiJt6ym4TrVKf7WF7ZPZddARRs0BSera3yDIgvB8wtlbgHbnIZlGeDE87wduBl1vUQPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdSGTwFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C616BC4CEF7;
	Mon, 29 Dec 2025 21:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767042810;
	bh=47wn4qbeUgws/VaRdK21B3QDm+QXKh9u1GsU6HmVl94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CdSGTwFrtyN5mUOHUkBOcnjn5pEsqi4s7hhrdhRyN8EUQDgPG0HL4Kxmu+PUlhlvQ
	 GH/EbrC/NKP/vespackHBh1Af+7EVCMUXb0lglzd2bTyn8tufq5H8Kf97d+oZeVC2o
	 kY8rOjQNlXhWGr9vWQvIrSfn2ZT/7bNbJis6AdiyalpGMPTHDywGq3gAl0tBRnjXsi
	 GWB9vRzY3eymHOK2ZON+IlDq7VI/Edi5QmhrVYwv5R/+aXIAVBQdPR8jEebYpfyM64
	 XnOXfh0kIERl7DuFA8RGinBgXH9SIQrSxuAQORMGlvv7IlE9RCiHLxvHZyw37IoNHg
	 oQxwmAWtB4NnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: mt76: Fix DTS power-limits on little endian systems
Date: Mon, 29 Dec 2025 16:13:28 -0500
Message-ID: <20251229211328.1711248-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122936-impotence-sandworm-9ea8@gregkh>
References: <2025122936-impotence-sandworm-9ea8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>

[ Upstream commit 38b845e1f9e810869b0a0b69f202b877b7b7fb12 ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 37 +++++++++++++--------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index d35f31378ac1..17741621aeb8 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -189,6 +189,19 @@ mt76_get_of_array(struct device_node *np, char *name, size_t *len, int min)
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
 static struct device_node *
 mt76_find_channel_node(struct device_node *np, struct ieee80211_channel *chan)
 {
@@ -228,7 +241,7 @@ mt76_get_txs_delta(struct device_node *np, u8 nss)
 }
 
 static void
-mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const __be32 *data,
+mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const s8 *data,
 		       s8 target_power, s8 nss_delta, s8 *max_power)
 {
 	int i;
@@ -237,15 +250,14 @@ mt76_apply_array_limit(s8 *pwr, size_t pwr_len, const __be32 *data,
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
@@ -253,8 +265,7 @@ mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
 	if (!data)
 		return;
 
-	len /= 4;
-	cur = be32_to_cpu(data[0]);
+	cur = data[0];
 	for (i = 0; i < pwr_num; i++) {
 		if (len < pwr_len + 1)
 			break;
@@ -269,7 +280,7 @@ mt76_apply_multi_array_limit(s8 *pwr, size_t pwr_len, s8 pwr_num,
 		if (!len)
 			break;
 
-		cur = be32_to_cpu(data[0]);
+		cur = data[0];
 	}
 }
 
@@ -280,7 +291,7 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 {
 	struct mt76_dev *dev = phy->dev;
 	struct device_node *np;
-	const __be32 *val;
+	const s8 *val;
 	char name[16];
 	u32 mcs_rates = dev->drv->mcs_rates;
 	u32 ru_rates = ARRAY_SIZE(dest->ru[0]);
@@ -326,21 +337,21 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 
 	txs_delta = mt76_get_txs_delta(np, hweight8(phy->antenna_mask));
 
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
-- 
2.51.0


