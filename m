Return-Path: <stable+bounces-13290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C06837B46
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B19C1F282CD
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5720F14C587;
	Tue, 23 Jan 2024 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HX6inG6Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1744114C580;
	Tue, 23 Jan 2024 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969268; cv=none; b=af95OYCZjBRGwObZ9IZ+3mrXyuiK/oSU6MlA6gRfMWsAgzRdNAgS/18aVMgILfrVr4FMLWi0CMwfsoZLlwB6fFHxcVNv4CqPHvPiVrq3jmxeVBEXL3pFa2AvdjnzStvr0WNPGaQU8wRl5nJRHj/cnUvpaxCVL2lR394tRPS6nlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969268; c=relaxed/simple;
	bh=R6WlfNRryRYWampqypQCCNn2WOUIhfifJX3F8tDQxdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+Yf8BXDqcq4zn/xhR/B6fYp5bnJO/qCOsNrMVWdmdHDw0e6g+xOd87/vUxgagC0ncoTGCk+MIknQHAiuCrDzcYVDIGvThLwjpUvs5UAIq9Zk9VPltdxX33Wh0y05HDmWifomtRijtAMmm3vDyRMvbTkO1pZ7Enk+8mjwyDk82M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HX6inG6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2E4C433C7;
	Tue, 23 Jan 2024 00:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969267;
	bh=R6WlfNRryRYWampqypQCCNn2WOUIhfifJX3F8tDQxdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HX6inG6ZoaOmYhvAGGuL406vvzHndAmJGR9CxsaV1dfu8tbv1BS5Q5O9C9Pz1wq9a
	 AC3pBz8HqMMeyVlTeSDP5BMS8SABTOrQDcpSTzU+c5hjCvEGU0BNz06tlMdX4ck859
	 MYC8+4/syn0puS0aNWNMbYAwGMo8lyBQsRHIoGM8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 109/641] wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
Date: Mon, 22 Jan 2024 15:50:13 -0800
Message-ID: <20240122235821.451650586@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

[ Upstream commit bc8263083af60e7e57c6120edbc1f75d6c909a35 ]

Clang static checker warns:

drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c:184:49:
	The result of the left shift is undefined due to shifting by '32',
	which is greater or equal to the width of type 'u32'.
	[core.UndefinedBinaryOperatorResult]

If the value of the right operand is negative or is greater than or
equal to the width of the promoted left operand, the behavior is
undefined.[1][2]

For example, when using different gcc's compilation optimization options
(-O0 or -O2), the result of '(u32)data << 32' is different. One is 0, the
other is old value of data. Let _rtl8821ae_phy_calculate_bit_shift()'s
return value less than 32 to fix this problem. Warn if bitmask is zero.

[1] https://stackoverflow.com/questions/11270492/what-does-the-c-standard-say-about-bitshifting-more-bits-than-the-width-of-type
[2] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf

Fixes: 21e4b0726dc6 ("rtlwifi: rtl8821ae: Move driver from staging to regular tree")
Signed-off-by: Su Hui <suhui@nfschina.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20231127013511.26694-2-suhui@nfschina.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index 5323ead30db0..fa1839d8ee55 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -29,9 +29,10 @@ static void _rtl8821ae_phy_rf_serial_write(struct ieee80211_hw *hw,
 					   u32 data);
 static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
 {
-	u32 i = ffs(bitmask);
+	if (WARN_ON_ONCE(!bitmask))
+		return 0;
 
-	return i ? i - 1 : 32;
+	return __ffs(bitmask);
 }
 static bool _rtl8821ae_phy_bb8821a_config_parafile(struct ieee80211_hw *hw);
 /*static bool _rtl8812ae_phy_config_mac_with_headerfile(struct ieee80211_hw *hw);*/
-- 
2.43.0




