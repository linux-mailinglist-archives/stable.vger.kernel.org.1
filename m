Return-Path: <stable+bounces-13062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2B7837A5D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EED01C23598
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B2112BF3F;
	Tue, 23 Jan 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nn4ZIa4E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79AD12BF35;
	Tue, 23 Jan 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968915; cv=none; b=R2w6gp5SNSbXyqFdfcTXJ53Yp40k1c1NGQVYpc/CKlyL8neMnIIo0/wMlAZrziNxit/LQ18RDP385ftHZz1buNuxna6rLwMnfTDtzDXSkU5elV6bzPrPHN4bPir4tOrR4w46guv0VpLd5tGmxS38nDDhzyz2BelYVp5pqKK/cQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968915; c=relaxed/simple;
	bh=Nnflbc4xwkYnKuizPwP+F+NeN05TlGGDy5N1NbdeD9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2wPwgG3jcFVgYUU2J+Ci5QtX4D+HRd+bYPIOOM711n0ElBTx41u+ObCirxTnJI9cMOJ64QA97xJLuCJPutocSj4N3mSAyR0l5lo09aPC2NmjIOqUZ/IM77LYKE+11JjY5NUuP75d6qyW+/IhSKu6HdfWP8INi1a33V7MBFOvCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nn4ZIa4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57976C433B1;
	Tue, 23 Jan 2024 00:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968915;
	bh=Nnflbc4xwkYnKuizPwP+F+NeN05TlGGDy5N1NbdeD9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nn4ZIa4Eb1NNMlGoHlTlMhHnCJU2zqKJDGCEN9DV9tc/na9APblVBn2cKBl4AxI70
	 3bvjtcX1wMenVOHr6gRSjSk5VAdm3eN6GJVJ9DaEYM2/P4Zrrw1ThjPN2xP8NLiZ5W
	 ApHrafuJ1JSpMFPnu6QFLvHwCgHNGSTLrYCEMj+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 096/194] wifi: rtlwifi: rtl8188ee: phy: using calculate_bit_shift()
Date: Mon, 22 Jan 2024 15:57:06 -0800
Message-ID: <20240122235723.348546950@linuxfoundation.org>
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

[ Upstream commit 969bc926f04b438676768aeffffffb050e480b62 ]

Using calculate_bit_shift() to replace _rtl88e_phy_calculate_bit_shift().
And fix the undefined bitwise shift behavior problem.

Fixes: f0eb856e0b6c ("rtlwifi: rtl8188ee: Add new driver")
Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20231219065739.1895666-4-suhui@nfschina.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/realtek/rtlwifi/rtl8188ee/phy.c   | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
index 52b0fccc31f8..4b8bdf3885db 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
@@ -16,12 +16,6 @@ static u32 _rtl88e_phy_rf_serial_read(struct ieee80211_hw *hw,
 static void _rtl88e_phy_rf_serial_write(struct ieee80211_hw *hw,
 					enum radio_path rfpath, u32 offset,
 					u32 data);
-static u32 _rtl88e_phy_calculate_bit_shift(u32 bitmask)
-{
-	u32 i = ffs(bitmask);
-
-	return i ? i - 1 : 32;
-}
 static bool _rtl88e_phy_bb8188e_config_parafile(struct ieee80211_hw *hw);
 static bool _rtl88e_phy_config_mac_with_headerfile(struct ieee80211_hw *hw);
 static bool phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
@@ -51,7 +45,7 @@ u32 rtl88e_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x)\n", regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
-	bitshift = _rtl88e_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
@@ -74,7 +68,7 @@ void rtl88e_phy_set_bb_reg(struct ieee80211_hw *hw,
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
-		bitshift = _rtl88e_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((originalvalue & (~bitmask)) | (data << bitshift));
 	}
 
@@ -100,7 +94,7 @@ u32 rtl88e_phy_query_rf_reg(struct ieee80211_hw *hw,
 
 
 	original_value = _rtl88e_phy_rf_serial_read(hw, rfpath, regaddr);
-	bitshift = _rtl88e_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock_irqrestore(&rtlpriv->locks.rf_lock, flags);
@@ -129,7 +123,7 @@ void rtl88e_phy_set_rf_reg(struct ieee80211_hw *hw,
 			original_value = _rtl88e_phy_rf_serial_read(hw,
 								    rfpath,
 								    regaddr);
-			bitshift = _rtl88e_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
-- 
2.43.0




