Return-Path: <stable+bounces-13093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691A837A77
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B061F23DA9
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A512CDB8;
	Tue, 23 Jan 2024 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PfhWs7xC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD912CDB3;
	Tue, 23 Jan 2024 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968967; cv=none; b=SalVoJt+DNcoywsXyu1HaFAivvdkNO6L42/9MpM7w0NwZFghsj/3a6r2um8fLvQDa7MELnW+qxZr6vlhZ250hHjymECtIqhTdooo/sA1Ix69kMkqrki852UEfyriALy+vWxlsqHaNBmxOLzrqlogr9J/X/vDCdpFVicl9rDHzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968967; c=relaxed/simple;
	bh=o00Pd0Ectf2KBkY7DYHJagxK02UPa662WonqyUFuBTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A//ABWIycpmfx8oYx5AZBIQbo6XKTYrkOc2FKj6l3+2Tq93JUQwAJ7mHPOq3qXEs8HQU2p05S45zWewPiHtSIJ4Oyspzf5WN6LamAEwjlraX+cR1xYOUlliqo2wfPbJAC2Wb0J3uuKsx12P7DZPdsckC6uEJJUTmTqEQVIDW2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PfhWs7xC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EC5C433F1;
	Tue, 23 Jan 2024 00:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968967;
	bh=o00Pd0Ectf2KBkY7DYHJagxK02UPa662WonqyUFuBTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PfhWs7xCWThoMuMGjO9hUSvcho2Fqr7fvoXpn6TB9oIRCR5CC6hyZNjpCkjF9sQ3K
	 QaXmfOq/4JdyVB2EIU8YA5BXFKomXHPM496LFPOTwut+GLreTIQMuDkuguNswI4n9d
	 65si9e2C4ctjzSE0vsCjt34MdJvfuCJ5yh6vBycg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 103/194] wifi: rtlwifi: rtl8192se: using calculate_bit_shift()
Date: Mon, 22 Jan 2024 15:57:13 -0800
Message-ID: <20240122235723.659211000@linuxfoundation.org>
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

From: Su Hui <suhui@nfschina.com>

[ Upstream commit ac32b9317063b101a8ff3d3e885f76f87a280419 ]

Using calculate_bit_shift() to replace _rtl92s_phy_calculate_bit_shift().
And fix the undefined bitwise shift behavior problem.

Fixes: d15853163bea ("rtlwifi: rtl8192se: Merge phy routines")
Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20231219065739.1895666-10-suhui@nfschina.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/realtek/rtlwifi/rtl8192se/phy.c  | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
index 9696fa3a08d9..f377531bc2bd 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
@@ -14,13 +14,6 @@
 #include "hw.h"
 #include "table.h"
 
-static u32 _rtl92s_phy_calculate_bit_shift(u32 bitmask)
-{
-	u32 i = ffs(bitmask);
-
-	return i ? i - 1 : 32;
-}
-
 u32 rtl92s_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
@@ -30,7 +23,7 @@ u32 rtl92s_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 		 regaddr, bitmask);
 
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
-	bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "BBR MASK=0x%x Addr[0x%x]=0x%x\n",
@@ -52,7 +45,7 @@ void rtl92s_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask,
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
-		bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((originalvalue & (~bitmask)) | (data << bitshift));
 	}
 
@@ -160,7 +153,7 @@ u32 rtl92s_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 
 	original_value = _rtl92s_phy_rf_serial_read(hw, rfpath, regaddr);
 
-	bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -191,7 +184,7 @@ void rtl92s_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	if (bitmask != RFREG_OFFSET_MASK) {
 		original_value = _rtl92s_phy_rf_serial_read(hw, rfpath,
 							    regaddr);
-		bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((original_value & (~bitmask)) | (data << bitshift));
 	}
 
-- 
2.43.0




