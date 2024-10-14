Return-Path: <stable+bounces-84685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE1D99D182
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28E5283A29
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28456481B3;
	Mon, 14 Oct 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iyk56Ywy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC9A1AAE1D;
	Mon, 14 Oct 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918856; cv=none; b=KuHZb2WOMpCLlYLniEtp9vta/KmZgxVBZTEG2/qF9QbcCKEHQn5/uvFhAXla5EBobioSlxiBnMO13EDrln698DkFRBAUEv9vTQ0rgB2QRmL/W8rVAxpzE7tW9FlZ6SFChtFrCZbV7sKL5pphyRcaOp8nDIGuFIgxIl1MP0ugycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918856; c=relaxed/simple;
	bh=bmYY/HOKBUM7+9HH3wswCtBXfHkxUS6BWNEdL5zgiqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ1gJzuxr38qx026RJ1UC3ABt37RKSVy5QuDY5HG2xTJkCB/DLMUt1zIYF9irtjliW9ONDERuhlQrJUGmWSPBbRHnAwEHaxS2NhLFPJ5uiXFAdlaHhIgoSOLkYUYu9xiHBLn5YMMSI+X5b/HLdQv7u77p4hyl1AwJnPDA2OO9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iyk56Ywy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE683C4CEC3;
	Mon, 14 Oct 2024 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918856;
	bh=bmYY/HOKBUM7+9HH3wswCtBXfHkxUS6BWNEdL5zgiqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iyk56YwyEcUm2si9Rfwnojdr2WacezRDqNr6GhmEmNYQh7L8oqKVsB1jsxZTOcS5Y
	 uAQSkzld6f8YUYBnMssB1Y1v9C8s/zdXZjIdqo9BFdU8Gj9d4kYYzo+AE9RzNvEdaP
	 wIGP9/8NreewKRQRSH+Du5JN2PSc+6NkXylsWYbc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 443/798] wifi: rtw89: correct base HT rate mask for firmware
Date: Mon, 14 Oct 2024 16:16:37 +0200
Message-ID: <20241014141235.375602860@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 45742881f9eee2a4daeb6008e648a460dd3742cd ]

Coverity reported that u8 rx_mask << 24 will become signed 32 bits, which
casting to unsigned 64 bits will do sign extension. For example,
putting 0x80000000 (signed 32 bits) to a u64 variable will become
0xFFFFFFFF_80000000.

The real case we meet is:
  rx_mask[0...3] = ff ff 00 00
  ra_mask = 0xffffffff_ff0ff000

After this fix:
  rx_mask[0...3] = ff ff 00 00
  ra_mask = 0x00000000_ff0ff000

Fortunately driver does bitwise-AND with incorrect ra_mask and supported
rates (1ss and 2ss rate only) afterward, so the final rate mask of
original code is still correct.

Addresses-Coverity-ID: 1504762 ("Unintended sign extension")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240809072012.84152-5-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c894a2b614eb1..f6647f9d23939 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -281,8 +281,8 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		csi_mode = RTW89_RA_RPT_MODE_HT;
 		ra_mask |= ((u64)sta->deflink.ht_cap.mcs.rx_mask[3] << 48) |
 			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[2] << 36) |
-			   (sta->deflink.ht_cap.mcs.rx_mask[1] << 24) |
-			   (sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
+			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[1] << 24) |
+			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
 		high_rate_masks = rtw89_ra_mask_ht_rates;
 		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			stbc_en = 1;
-- 
2.43.0




