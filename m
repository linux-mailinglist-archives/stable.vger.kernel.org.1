Return-Path: <stable+bounces-12899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC8837906
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB38D2849B9
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9986145B09;
	Tue, 23 Jan 2024 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iQczpM9a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5DE56B;
	Tue, 23 Jan 2024 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968338; cv=none; b=mW+sf0kjZJrpfsYC2jsAC/G5Y+hCDEunnJVXmniv2d/YdSbXyXA9dg4G+XLmFyYUUQb3RJhyfDWmlEQt+0F9cvRBYEpKX14ZMdvYa0zkzMv5nZA7+LdzNZrt0OU87L6nz5j3k5oDer1oP9S4znwgATkWSZmdu2IjXzvY620ES5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968338; c=relaxed/simple;
	bh=rJDMQgUJCrPNYuYEgXB+i8Kb3m0sKbjQ40ha6Ygr/i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mABwffjEnh/GNNwU+/dEQzy9s4hvpOfX5GA2Zmte0Z9zLiL/4p1sTYucMh4veXb2fOnuic+kNfsNX1/PA7lQ2hSe5tePScDxYaBOaEs8Z3q/CIAoXz4DZTSZXwG1gTh4TQnpT2RDgJpTbD4+MRtd/6SkQkL/MtnyZCC4+cpfSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iQczpM9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA20C433F1;
	Tue, 23 Jan 2024 00:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968338;
	bh=rJDMQgUJCrPNYuYEgXB+i8Kb3m0sKbjQ40ha6Ygr/i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQczpM9aS0tEFtq71ORKfNRkoHzSWgY8UqsCwFuGeOoORb/qQSLhDx71HjeNKKWi/
	 H4O/Bp7mcmM3NfgeRP1HZJkrSruddbY3IAm6K5Q76AHJXOBFr0M1OXBFYVPGJddUOv
	 B3yuIUv/6VLdgFm6iOoLwqmwcgKI35zJ1qx8iDds=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 082/148] wifi: rtlwifi: rtl8192se: using calculate_bit_shift()
Date: Mon, 22 Jan 2024 15:57:18 -0800
Message-ID: <20240122235715.722048344@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235712.442097787@linuxfoundation.org>
References: <20240122235712.442097787@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index dfc96126a356..0430a3b823d6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
@@ -36,13 +36,6 @@
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
@@ -52,7 +45,7 @@ u32 rtl92s_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 		 regaddr, bitmask);
 
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
-	bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
 	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "BBR MASK=0x%x Addr[0x%x]=0x%x\n",
@@ -74,7 +67,7 @@ void rtl92s_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask,
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
-		bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((originalvalue & (~bitmask)) | (data << bitshift));
 	}
 
@@ -182,7 +175,7 @@ u32 rtl92s_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 
 	original_value = _rtl92s_phy_rf_serial_read(hw, rfpath, regaddr);
 
-	bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -213,7 +206,7 @@ void rtl92s_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	if (bitmask != RFREG_OFFSET_MASK) {
 		original_value = _rtl92s_phy_rf_serial_read(hw, rfpath,
 							    regaddr);
-		bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
+		bitshift = calculate_bit_shift(bitmask);
 		data = ((original_value & (~bitmask)) | (data << bitshift));
 	}
 
-- 
2.43.0




