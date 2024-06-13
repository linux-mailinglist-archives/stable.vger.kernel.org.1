Return-Path: <stable+bounces-51124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B808906E70
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCBF1C2197A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1134D1474AE;
	Thu, 13 Jun 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EDCjol2V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C5F13C805;
	Thu, 13 Jun 2024 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280379; cv=none; b=mYUxSnM+SgBi4eimNwtCkwF8+DkIcL0bIkTA9atmA9vjHT7xGnOX7c6H6sRQdXWIpndUyswALNrfe838eUSLrEWhLhCXX8ArSCL6d8voyEg6bNiTZgaJjKw8O3YT2kQiyCShU3AbGPuJnhsbdZHvh3ogcmN0IkWbuyug/BeVVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280379; c=relaxed/simple;
	bh=248RzELqZSUNPHTwpZwP3dh4FiR9mXbZ4/LVc5ipddk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdbyQwfmi3SPfT4O7mL7aSgv9ja4VgVXkfIZa0Xu8aEJk2X9eXZ74zQya6y5dqNdMPhSvHCAzQAvpSagE7fxas8qJyUvkFQvTKSoKz9utaHwHfd77B36hHQd35cfQ99j1RelzNGKbqGln1A/ctxCopkvC35UGB+nL9sf1OlECzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EDCjol2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AADAC2BBFC;
	Thu, 13 Jun 2024 12:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280379;
	bh=248RzELqZSUNPHTwpZwP3dh4FiR9mXbZ4/LVc5ipddk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDCjol2V49wxqG8fJqlbLbj29+3+iwhf+bdXtAkcxAdALO3gHf8sQGZK3r9Bb/D/z
	 yD0CfsmEVjl/FEQCVvwxqWk57OzmtKqemeCAjU7SbqSuPcITRgIMXBnnlHfvmgXlXy
	 8kOz5Lbcf/L8JP5JVZx0UKNiJ67byOONfbSxzf7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 6.6 033/137] wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
Date: Thu, 13 Jun 2024 13:33:33 +0200
Message-ID: <20240613113224.575923567@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

commit 08b5d052d17a89bb8706b2888277d0b682dc1610 upstream.

Don't subtract 1 from the power index. This was added in commit
2fc0b8e5a17d ("rtl8xxxu: Add TX power base values for gen1 parts")
for unknown reasons. The vendor drivers don't do this.

Also correct the calculations of values written to
REG_OFDM0_X{C,D}_TX_IQ_IMBALANCE. According to the vendor driver,
these are used for TX power training.

With these changes rtl8xxxu sets the TX power of RTL8192CU the same
as the vendor driver.

None of this appears to have any effect on my RTL8192CU device.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://msgid.link/6ae5945b-644e-45e4-a78f-4c7d9c987910@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |   25 +++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1505,13 +1505,13 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xx
 	u8 cck[RTL8723A_MAX_RF_PATHS], ofdm[RTL8723A_MAX_RF_PATHS];
 	u8 ofdmbase[RTL8723A_MAX_RF_PATHS], mcsbase[RTL8723A_MAX_RF_PATHS];
 	u32 val32, ofdm_a, ofdm_b, mcs_a, mcs_b;
-	u8 val8;
+	u8 val8, base;
 	int group, i;
 
 	group = rtl8xxxu_gen1_channel_to_group(channel);
 
-	cck[0] = priv->cck_tx_power_index_A[group] - 1;
-	cck[1] = priv->cck_tx_power_index_B[group] - 1;
+	cck[0] = priv->cck_tx_power_index_A[group];
+	cck[1] = priv->cck_tx_power_index_B[group];
 
 	if (priv->hi_pa) {
 		if (cck[0] > 0x20)
@@ -1522,10 +1522,6 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xx
 
 	ofdm[0] = priv->ht40_1s_tx_power_index_A[group];
 	ofdm[1] = priv->ht40_1s_tx_power_index_B[group];
-	if (ofdm[0])
-		ofdm[0] -= 1;
-	if (ofdm[1])
-		ofdm[1] -= 1;
 
 	ofdmbase[0] = ofdm[0] +	priv->ofdm_tx_power_index_diff[group].a;
 	ofdmbase[1] = ofdm[1] +	priv->ofdm_tx_power_index_diff[group].b;
@@ -1614,20 +1610,19 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xx
 
 	rtl8xxxu_write32(priv, REG_TX_AGC_A_MCS15_MCS12,
 			 mcs_a + power_base->reg_0e1c);
+	val8 = u32_get_bits(mcs_a + power_base->reg_0e1c, 0xff000000);
 	for (i = 0; i < 3; i++) {
-		if (i != 2)
-			val8 = (mcsbase[0] > 8) ? (mcsbase[0] - 8) : 0;
-		else
-			val8 = (mcsbase[0] > 6) ? (mcsbase[0] - 6) : 0;
+		base = i != 2 ? 8 : 6;
+		val8 = max_t(int, val8 - base, 0);
 		rtl8xxxu_write8(priv, REG_OFDM0_XC_TX_IQ_IMBALANCE + i, val8);
 	}
+
 	rtl8xxxu_write32(priv, REG_TX_AGC_B_MCS15_MCS12,
 			 mcs_b + power_base->reg_0868);
+	val8 = u32_get_bits(mcs_b + power_base->reg_0868, 0xff000000);
 	for (i = 0; i < 3; i++) {
-		if (i != 2)
-			val8 = (mcsbase[1] > 8) ? (mcsbase[1] - 8) : 0;
-		else
-			val8 = (mcsbase[1] > 6) ? (mcsbase[1] - 6) : 0;
+		base = i != 2 ? 8 : 6;
+		val8 = max_t(int, val8 - base, 0);
 		rtl8xxxu_write8(priv, REG_OFDM0_XD_TX_IQ_IMBALANCE + i, val8);
 	}
 }



