Return-Path: <stable+bounces-171377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A74BB2A9BA
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3955D196751F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4039133A01C;
	Mon, 18 Aug 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pVfPEheu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08F34AB12;
	Mon, 18 Aug 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525716; cv=none; b=eevVmUMV+ywByct8W6Z7iFORC5K5x+xbsVeqKygYwc9JphW6mEZPnjC94WNvL19e26cfBvSglhoY25VuV44n+uUQnVoY4TvR6rtfjx9PT8h+CCEOUm78JwFuC2GC5xxFIylnzdrfyNNI4XXDeATgJwKp/DJ0DR3JRPvq1rqS2js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525716; c=relaxed/simple;
	bh=6L9driD62lbPkzRMEdL9JePXW8mkElxCl3vk/PooXfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TifINYU4TF26ud7Tvg+qdSYlXOOn+LPpaJXThiYcLxQYIPlsSrM8mHVAhNdu1MA8eNGmJForTOvonpZokpFCok9BQTEfPspMueUtAxm8khc8iA0xNuo0aZW/tW0HpWyf0E2MlnDuPz85bMH/AmrUEEqKkeuSKwS78C9WTeyrwpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pVfPEheu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E11EC4CEEB;
	Mon, 18 Aug 2025 14:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525715;
	bh=6L9driD62lbPkzRMEdL9JePXW8mkElxCl3vk/PooXfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVfPEheuo/ACSW4XSn2i3r7zNkbi1xTNJ0njUNEl/jXx2vHx8xyNbTaMnLl+JEKLI
	 9DVmH9Knx+aa0AxtGiLwYn0ZTrdw1MNlIxlcvx3iA6Q+Mmsnz9IBhacSQuX8UFB8sU
	 jVSeVgkGsWXkIFOquxBBTzEUdUYuCUx3rheqwmD0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 313/570] wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.
Date: Mon, 18 Aug 2025 14:45:00 +0200
Message-ID: <20250818124517.922421289@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit 44c0e191004f0e3aa1bdee3be248be14dbe5b020 ]

The function `_rtl_pci_init_one_rxdesc()` can fail even when the new
`skb` is passed because of a DMA mapping error.  If it fails, the `skb`
is not saved in the rx ringbuffer and thus lost.

Compile tested only

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250616105631.444309-4-fourier.thomas@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 898f597f70a9..2741c3beac4c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -802,13 +802,19 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw *hw)
 		skb = new_skb;
 no_new:
 		if (rtlpriv->use_new_trx_flow) {
-			_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)buffer_desc,
-						 rxring_idx,
-						 rtlpci->rx_ring[rxring_idx].idx);
+			if (!_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)buffer_desc,
+						      rxring_idx,
+						      rtlpci->rx_ring[rxring_idx].idx)) {
+				if (new_skb)
+					dev_kfree_skb_any(skb);
+			}
 		} else {
-			_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)pdesc,
-						 rxring_idx,
-						 rtlpci->rx_ring[rxring_idx].idx);
+			if (!_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)pdesc,
+						      rxring_idx,
+						      rtlpci->rx_ring[rxring_idx].idx)) {
+				if (new_skb)
+					dev_kfree_skb_any(skb);
+			}
 			if (rtlpci->rx_ring[rxring_idx].idx ==
 			    rtlpci->rxringcount - 1)
 				rtlpriv->cfg->ops->set_desc(hw, (u8 *)pdesc,
-- 
2.39.5




