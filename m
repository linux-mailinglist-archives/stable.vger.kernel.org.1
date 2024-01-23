Return-Path: <stable+bounces-13052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA7837A54
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1ED31F25357
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FEC12BF1F;
	Tue, 23 Jan 2024 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gKblk8ow"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216212BF1C;
	Tue, 23 Jan 2024 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968898; cv=none; b=TwzZI3R/DTYPARtAvGShvHNQpgDYXpe1aiXm8eTTf6sABgdjQ9sEJuTxk8/qzWP52szXjiVhX8fymHmGn1rbMLdRuriH+GUi4hmfqw75reInkQ9QHrTmt8VpA3yayabtdngPZxYGyWR+gimCiUGtTNCkg0AJnJGSrz7YMFA6hq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968898; c=relaxed/simple;
	bh=vLOtYcfuZ4qkjz7kKe/9Z9zBz+Z15qUXE0q3vDQf7nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvwCwaohZpnh4N7xUhpxXX7Au6DdkHvYvk0gAtEC2v+4+opFG3jH4dKF8o6uiOsRIMGgmkimzBd2d57bFfK5GjVFCZzODwJ1Uzs4/Sr3m98RFJ7YDUFhcabo+/pfV84Prrs1AFqiAHAbzxF5qKE9G2yX2msd7sIX+Fwjf3mPS8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gKblk8ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F26C43390;
	Tue, 23 Jan 2024 00:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968898;
	bh=vLOtYcfuZ4qkjz7kKe/9Z9zBz+Z15qUXE0q3vDQf7nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKblk8owPkg6RCRVfuECgiabp0qPsv/7fCuScBxfnFwnhzT8WgoMSQqHUH0s+tSWC
	 430E3jMriljXoEwh/6ifmVdHffKU27i1W6MAsb3sWJoAGjCrqlQ3ybbad8Nc6777ou
	 BzjqOdA86CmGtpzVd6EHgi9eehPlDA3CcBaVS/nM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Perches <joe@perches.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 087/194] rtlwifi: Use ffs in <foo>_phy_calculate_bit_shift
Date: Mon, 22 Jan 2024 15:56:57 -0800
Message-ID: <20240122235722.976097595@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Perches <joe@perches.com>

[ Upstream commit 6c1d61913570d4255548ac598cfbef6f1e3c3eee ]

Remove the loop and use the generic ffs instead.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/e2ab424d24b74901bc0c39f0c60f75e871adf2ba.camel@perches.com
Stable-dep-of: bc8263083af6 ("wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/realtek/rtlwifi/rtl8188ee/phy.c   | 18 ++++++------------
 .../realtek/rtlwifi/rtl8192c/phy_common.c      |  8 ++------
 .../wireless/realtek/rtlwifi/rtl8192de/phy.c   |  9 ++-------
 .../wireless/realtek/rtlwifi/rtl8192ee/phy.c   |  8 ++------
 .../wireless/realtek/rtlwifi/rtl8192se/phy.c   |  9 ++-------
 .../realtek/rtlwifi/rtl8723com/phy_common.c    |  8 ++------
 .../wireless/realtek/rtlwifi/rtl8821ae/phy.c   | 18 ++++++------------
 7 files changed, 22 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
index 96d8f25b120f..52b0fccc31f8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
@@ -16,7 +16,12 @@ static u32 _rtl88e_phy_rf_serial_read(struct ieee80211_hw *hw,
 static void _rtl88e_phy_rf_serial_write(struct ieee80211_hw *hw,
 					enum radio_path rfpath, u32 offset,
 					u32 data);
-static u32 _rtl88e_phy_calculate_bit_shift(u32 bitmask);
+static u32 _rtl88e_phy_calculate_bit_shift(u32 bitmask)
+{
+	u32 i = ffs(bitmask);
+
+	return i ? i - 1 : 32;
+}
 static bool _rtl88e_phy_bb8188e_config_parafile(struct ieee80211_hw *hw);
 static bool _rtl88e_phy_config_mac_with_headerfile(struct ieee80211_hw *hw);
 static bool phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
@@ -210,17 +215,6 @@ static void _rtl88e_phy_rf_serial_write(struct ieee80211_hw *hw,
 		 rfpath, pphyreg->rf3wire_offset, data_and_addr);
 }
 
-static u32 _rtl88e_phy_calculate_bit_shift(u32 bitmask)
-{
-	u32 i;
-
-	for (i = 0; i <= 31; i++) {
-		if (((bitmask >> i) & 0x1) == 1)
-			break;
-	}
-	return i;
-}
-
 bool rtl88e_phy_mac_config(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
index 0efd19aa4fe5..1145cb0ca4af 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
@@ -145,13 +145,9 @@ EXPORT_SYMBOL(_rtl92c_phy_rf_serial_write);
 
 u32 _rtl92c_phy_calculate_bit_shift(u32 bitmask)
 {
-	u32 i;
+	u32 i = ffs(bitmask);
 
-	for (i = 0; i <= 31; i++) {
-		if (((bitmask >> i) & 0x1) == 1)
-			break;
-	}
-	return i;
+	return i ? i - 1 : 32;
 }
 EXPORT_SYMBOL(_rtl92c_phy_calculate_bit_shift);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index 667578087af2..db4f8fde0f17 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -162,14 +162,9 @@ static u32 targetchnl_2g[TARGET_CHNL_NUM_2G] = {
 
 static u32 _rtl92d_phy_calculate_bit_shift(u32 bitmask)
 {
-	u32 i;
-
-	for (i = 0; i <= 31; i++) {
-		if (((bitmask >> i) & 0x1) == 1)
-			break;
-	}
+	u32 i = ffs(bitmask);
 
-	return i;
+	return i ? i - 1 : 32;
 }
 
 u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
index 222abc41669c..420f4984bfb9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
@@ -206,13 +206,9 @@ static void _rtl92ee_phy_rf_serial_write(struct ieee80211_hw *hw,
 
 static u32 _rtl92ee_phy_calculate_bit_shift(u32 bitmask)
 {
-	u32 i;
+	u32 i = ffs(bitmask);
 
-	for (i = 0; i <= 31; i++) {
-		if (((bitmask >> i) & 0x1) == 1)
-			break;
-	}
-	return i;
+	return i ? i - 1 : 32;
 }
 
 bool rtl92ee_phy_mac_config(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
index d5c0eb462315..9696fa3a08d9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
@@ -16,14 +16,9 @@
 
 static u32 _rtl92s_phy_calculate_bit_shift(u32 bitmask)
 {
-	u32 i;
-
-	for (i = 0; i <= 31; i++) {
-		if (((bitmask >> i) & 0x1) == 1)
-			break;
-	}
+	u32 i = ffs(bitmask);
 
-	return i;
+	return i ? i - 1 : 32;
 }
 
 u32 rtl92s_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
index aae14c68bf69..964292e82636 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
@@ -53,13 +53,9 @@ EXPORT_SYMBOL_GPL(rtl8723_phy_set_bb_reg);
 
 u32 rtl8723_phy_calculate_bit_shift(u32 bitmask)
 {
-	u32 i;
+	u32 i = ffs(bitmask);
 
-	for (i = 0; i <= 31; i++) {
-		if (((bitmask >> i) & 0x1) == 1)
-			break;
-	}
-	return i;
+	return i ? i - 1 : 32;
 }
 EXPORT_SYMBOL_GPL(rtl8723_phy_calculate_bit_shift);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index 8647db044366..11f31d006280 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -27,7 +27,12 @@ static u32 _rtl8821ae_phy_rf_serial_read(struct ieee80211_hw *hw,
 static void _rtl8821ae_phy_rf_serial_write(struct ieee80211_hw *hw,
 					   enum radio_path rfpath, u32 offset,
 					   u32 data);
-static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask);
+static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
+{
+	u32 i = ffs(bitmask);
+
+	return i ? i - 1 : 32;
+}
 static bool _rtl8821ae_phy_bb8821a_config_parafile(struct ieee80211_hw *hw);
 /*static bool _rtl8812ae_phy_config_mac_with_headerfile(struct ieee80211_hw *hw);*/
 static bool _rtl8821ae_phy_config_mac_with_headerfile(struct ieee80211_hw *hw);
@@ -274,17 +279,6 @@ static void _rtl8821ae_phy_rf_serial_write(struct ieee80211_hw *hw,
 		 rfpath, pphyreg->rf3wire_offset, data_and_addr);
 }
 
-static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
-{
-	u32 i;
-
-	for (i = 0; i <= 31; i++) {
-		if (((bitmask >> i) & 0x1) == 1)
-			break;
-	}
-	return i;
-}
-
 bool rtl8821ae_phy_mac_config(struct ieee80211_hw *hw)
 {
 	bool rtstatus = 0;
-- 
2.43.0




