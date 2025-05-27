Return-Path: <stable+bounces-146967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908B5AC5569
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 098207A66BD
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B73274FF4;
	Tue, 27 May 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lrvu1Mwk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500EC86347;
	Tue, 27 May 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365864; cv=none; b=Q0VSucLXUsop8tqTLlLJWqT07SohNMtkJ9fPvHsU+rLVuSFEmnJK/y1BXry2N4eMasToLqSGgn6dZuS9M0t4ko3zK8O4MU9S9YMn7gTDDjanhsxuxM2It/9EyXV+QQvaVfkYCJRbBkE8A+iRHyJIoySbhRrWHITmrGwekOovBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365864; c=relaxed/simple;
	bh=/ebF3QhLWSES5HCBK/dc18arMIxSbiVpCNJOspbcjEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lo92Alot/k0pPXv4jbz5dNm1fBAPO9DtifQxd6Ln/9Sku2JzyKxEv6W2IwDUX8IihtBXC08CKzXUh8u/CaF8PonSDKw2fcW+kXyzLMvYxsX8XmfG+B4EaSz38k+eah3k/g4OTesT4Sg5gQ7FBKxd70NDTFtHCAldkehkMNc8pC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lrvu1Mwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7CDC4CEE9;
	Tue, 27 May 2025 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365864;
	bh=/ebF3QhLWSES5HCBK/dc18arMIxSbiVpCNJOspbcjEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lrvu1MwkvqFQFyXECYTPnI+67UIIeO5gXtu+TurP16MkDWwjH4PSjpNUlSJ1MBv1v
	 ZwpwB1i0tPkUycLsHep7FyebO8HLp4JMbr9g3l9B0g7NVXtjuxWMjRUGvivyDGEX7h
	 YgVE8m7WUyab335XCs+HefSO5ulpqsmVOfnQP3EI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Soeren Moch <smoch@web.de>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 482/626] wifi: rtl8xxxu: retry firmware download on error
Date: Tue, 27 May 2025 18:26:15 +0200
Message-ID: <20250527162504.572099372@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Soeren Moch <smoch@web.de>

[ Upstream commit 3d3e28feca7ac8c6cf2a390dbbe1f97e3feb7f36 ]

Occasionally there is an EPROTO error during firmware download.
This error is converted to EAGAIN in the download function.
But nobody tries again and so device probe fails.

Implement download retry to fix this.

This error was observed (and fix tested) on a tbs2910 board [1]
with an embedded RTL8188EU (0bda:8179) device behind a USB hub.

[1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts

Signed-off-by: Soeren Moch <smoch@web.de>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250127194828.599379-1-smoch@web.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 4ce0c05c51291..569856ca677f6 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -860,9 +860,10 @@ rtl8xxxu_writeN(struct rtl8xxxu_priv *priv, u16 addr, u8 *buf, u16 len)
 	return len;
 
 write_error:
-	dev_info(&udev->dev,
-		 "%s: Failed to write block at addr: %04x size: %04x\n",
-		 __func__, addr, blocksize);
+	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_REG_WRITE)
+		dev_info(&udev->dev,
+			 "%s: Failed to write block at addr: %04x size: %04x\n",
+			 __func__, addr, blocksize);
 	return -EAGAIN;
 }
 
@@ -4064,8 +4065,14 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	 */
 	rtl8xxxu_write16(priv, REG_TRXFF_BNDY + 2, fops->trxff_boundary);
 
-	ret = rtl8xxxu_download_firmware(priv);
-	dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
+	for (int retry = 5; retry >= 0 ; retry--) {
+		ret = rtl8xxxu_download_firmware(priv);
+		dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
+		if (ret != -EAGAIN)
+			break;
+		if (retry)
+			dev_dbg(dev, "%s: retry firmware download\n", __func__);
+	}
 	if (ret)
 		goto exit;
 	ret = rtl8xxxu_start_firmware(priv);
-- 
2.39.5




