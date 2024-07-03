Return-Path: <stable+bounces-57780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C754C925DFA
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F651F25BDE
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7977A176AB6;
	Wed,  3 Jul 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ag8p0+rf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A817622C;
	Wed,  3 Jul 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005912; cv=none; b=FFHsHsXDmIYAL/bTEZAbNvaAU52geV11JBIkeswcXzL3j/JgO+c+g0ip8qAjEuTpG/8RheicFRT7tkpoZgP/veBWOIuYL6KXbccrPGAdCPeiCfy869drxwY/jfQJ4EXAGfKE2LnWhxv+/vHnA/uNKkRR0lIymKOMoQHQlBH7LQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005912; c=relaxed/simple;
	bh=2kX2ZYIjIy4sfU5iD74ep2Va2NiIc6vFp2Ae8sKFyvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+H6l/dxH809qvbB4QDSVW4DtlwnJfHwhVp1mv0ktSVbwDL487Hl7rJ/InXEOJv/vx9SdNIxycdlrvtfmtMTOq4Wltj/tpe7sxF4TEc7sPA8bIaAQNQc4WRPYh8NJ9+6o4RqtC8hsxL04ShkDYW4x96K2UD7m1sZN3z20yzSEnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ag8p0+rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0D3C2BD10;
	Wed,  3 Jul 2024 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005912;
	bh=2kX2ZYIjIy4sfU5iD74ep2Va2NiIc6vFp2Ae8sKFyvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ag8p0+rf/+Tqmj8PUYYn5A97E9qlhY+P5bym78kj6i5M4HubKmeaPyEGcsCASIKcd
	 no3jL8+6tOndFr5AiEiJNSfZ1diLfm+fhbf30yKtxxSyk6HU+szqZU9+NI3Ug3FpmO
	 tEEX/EiauhpDn95pk0gXV6hLpoOnOxV700VnWPR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kees Cook <keescook@chromium.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 237/356] rtlwifi: rtl8192de: Style clean-ups
Date: Wed,  3 Jul 2024 12:39:33 +0200
Message-ID: <20240703102922.081052781@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 69831173fcbbfebb7aa2d76523deaf0b87b8eddd ]

Clean up some style issues:
- Use ARRAY_SIZE() even though it's a u8 array.
- Remove redundant CHANNEL_MAX_NUMBER_2G define.
Additionally fix some dead code WARNs.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://lore.kernel.org/lkml/57d0d1b6064342309f680f692192556c@realtek.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20211119192233.1021063-1-keescook@chromium.org
Stable-dep-of: de4d4be4fa64 ("wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/realtek/rtlwifi/rtl8192de/phy.c    | 17 +++++++----------
 drivers/net/wireless/realtek/rtlwifi/wifi.h     |  1 -
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index c3c07ca77614a..d835a27429f0f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -892,7 +892,7 @@ static u8 _rtl92c_phy_get_rightchnlplace(u8 chnl)
 	u8 place = chnl;
 
 	if (chnl > 14) {
-		for (place = 14; place < sizeof(channel5g); place++) {
+		for (place = 14; place < ARRAY_SIZE(channel5g); place++) {
 			if (channel5g[place] == chnl) {
 				place++;
 				break;
@@ -1359,7 +1359,7 @@ u8 rtl92d_get_rightchnlplace_for_iqk(u8 chnl)
 	u8 place;
 
 	if (chnl > 14) {
-		for (place = 14; place < sizeof(channel_all); place++) {
+		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
 			if (channel_all[place] == chnl)
 				return place - 13;
 		}
@@ -2417,7 +2417,7 @@ static bool _rtl92d_is_legal_5g_channel(struct ieee80211_hw *hw, u8 channel)
 
 	int i;
 
-	for (i = 0; i < sizeof(channel5g); i++)
+	for (i = 0; i < ARRAY_SIZE(channel5g); i++)
 		if (channel == channel5g[i])
 			return true;
 	return false;
@@ -2681,9 +2681,8 @@ void rtl92d_phy_reset_iqk_result(struct ieee80211_hw *hw)
 	u8 i;
 
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
-		"settings regs %d default regs %d\n",
-		(int)(sizeof(rtlphy->iqk_matrix) /
-		      sizeof(struct iqk_matrix_regs)),
+		"settings regs %zu default regs %d\n",
+		ARRAY_SIZE(rtlphy->iqk_matrix),
 		IQK_MATRIX_REG_NUM);
 	/* 0xe94, 0xe9c, 0xea4, 0xeac, 0xeb4, 0xebc, 0xec4, 0xecc */
 	for (i = 0; i < IQK_MATRIX_SETTINGS_NUM; i++) {
@@ -2850,16 +2849,14 @@ u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw)
 	case BAND_ON_5G:
 		/* Get first channel error when change between
 		 * 5G and 2.4G band. */
-		if (channel <= 14)
+		if (WARN_ONCE(channel <= 14, "rtl8192de: 5G but channel<=14\n"))
 			return 0;
-		WARN_ONCE((channel <= 14), "rtl8192de: 5G but channel<=14\n");
 		break;
 	case BAND_ON_2_4G:
 		/* Get first channel error when change between
 		 * 5G and 2.4G band. */
-		if (channel > 14)
+		if (WARN_ONCE(channel > 14, "rtl8192de: 2G but channel>14\n"))
 			return 0;
-		WARN_ONCE((channel > 14), "rtl8192de: 2G but channel>14\n");
 		break;
 	default:
 		WARN_ONCE(true, "rtl8192de: Invalid WirelessMode(%#x)!!\n",
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index a1f223c8848b9..0bac788ccd6e3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -108,7 +108,6 @@
 #define	CHANNEL_GROUP_IDX_5GM		6
 #define	CHANNEL_GROUP_IDX_5GH		9
 #define	CHANNEL_GROUP_MAX_5G		9
-#define CHANNEL_MAX_NUMBER_2G		14
 #define AVG_THERMAL_NUM			8
 #define AVG_THERMAL_NUM_88E		4
 #define AVG_THERMAL_NUM_8723BE		4
-- 
2.43.0




