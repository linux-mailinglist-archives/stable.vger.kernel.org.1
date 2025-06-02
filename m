Return-Path: <stable+bounces-149968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 471B6ACB56E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CEE4C18FE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88922F177;
	Mon,  2 Jun 2025 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PJhlEsv6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6942248A4;
	Mon,  2 Jun 2025 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875616; cv=none; b=T28fEKLj2Ghm3pCBZcSG6rGcw+DNtPerLI3CYqYRrvbdNAHY4ON30HX2ljgdVNwN3bRXyMUfIbBu9izuVNEJLufpkZYPY80JQFPZ+KbqkkbbRJUlP6RvW9cLvMM/+IGxyrVayoPGmTWX3CuXO8ZSHRVVbTub4OqTG2PIoLowGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875616; c=relaxed/simple;
	bh=IWMzXgeGjy6tpcpipW4xjnO8qo8jpkBq5JK0Rf34C8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA3lvt19Wrd7soqTs6DkVgwZwpu8zQKQl8eFvBhY77zZ4nn0HzB4mTTGnJpamIGFRS8Y2GhjNWgLwPYRVYEWoGj39cP23XOvTAVDRrKdqBAH0dnxr1oflpESnT4NOpoB75y3QfhAGIVBiTEYH3rXpDWyyqg2bu8aseH4dNfTuRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PJhlEsv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A3CC4CEF0;
	Mon,  2 Jun 2025 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875614;
	bh=IWMzXgeGjy6tpcpipW4xjnO8qo8jpkBq5JK0Rf34C8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJhlEsv6uwLs5un9xgmOUG0rgIoJqlSePi6zZiqZxmkMfIVFd35DEM0NqCgMtYC7f
	 lEcj2hKY6bxD7cZYdmBh6ck3W1WZ0W14cK3JglUlFQzAB9DYwbZBeh5tWUeQSJhSqK
	 9YxCfNGZ0CYUWxNGgjS+WNVA7byRBFMgLmpX+EhQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 188/270] wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
Date: Mon,  2 Jun 2025 15:47:53 +0200
Message-ID: <20250602134314.893705901@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 6be7544d19fcfcb729495e793bc6181f85bb8949 ]

Set the MCS maps and the highest rates according to the number of
spatial streams the chip has. For RTL8814AU that is 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/e86aa009-b5bf-4b3a-8112-ea5e3cd49465@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/main.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 91eea38f62cd3..ea70b55150388 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1175,8 +1175,9 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 			     struct ieee80211_sta_vht_cap *vht_cap)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	u16 mcs_map;
+	u16 mcs_map = 0;
 	__le16 highest;
+	int i;
 
 	if (efuse->hw_cap.ptcl != EFUSE_HW_CAP_IGNORE &&
 	    efuse->hw_cap.ptcl != EFUSE_HW_CAP_PTCL_VHT)
@@ -1199,21 +1200,15 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 	if (rtw_chip_has_rx_ldpc(rtwdev))
 		vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC;
 
-	mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9 << 0 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 4 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 6 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 8 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 14;
-	if (efuse->hw_cap.nss > 1) {
-		highest = cpu_to_le16(780);
-		mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << 2;
-	} else {
-		highest = cpu_to_le16(390);
-		mcs_map |= IEEE80211_VHT_MCS_NOT_SUPPORTED << 2;
+	for (i = 0; i < 8; i++) {
+		if (i < efuse->hw_cap.nss)
+			mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << (i * 2);
+		else
+			mcs_map |= IEEE80211_VHT_MCS_NOT_SUPPORTED << (i * 2);
 	}
 
+	highest = cpu_to_le16(390 * efuse->hw_cap.nss);
+
 	vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(mcs_map);
 	vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(mcs_map);
 	vht_cap->vht_mcs.rx_highest = highest;
-- 
2.39.5




