Return-Path: <stable+bounces-170824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8E0B2A653
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A320E1BA01F6
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5430132253F;
	Mon, 18 Aug 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MhvxX4Hz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12453322539;
	Mon, 18 Aug 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523915; cv=none; b=uxbN6NO9wGosYMSLlE2/eeShMV+B8vwdHj8CeFVMLGdOgK8ub6kHTG+PV+k/nqs9IJTSiRWdhshvcrU/u5dyeSAbQVawLeLyndY+PF+tKS9rRpVdrhi6N359EDEtMiwcOot0nwDcEDTNYYmGK8U5Q8ZwPoBq4wmzn4l01V1hEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523915; c=relaxed/simple;
	bh=MQiCrSS7kUx/shURTcefWsvaG4bksayGJxw1dtUWr8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbWanaPUBTVvPhKDmkZwIOsPahzOae3sqrvhIxqTjKW1K2O/MNZ1Vh0s4wUmYZul5rMuI07weupMCCkVyXcB7rvmZzDehyz5fpuLY2QmFVVxl2CFJ6wQzLf9aDFwqWN2UCuzZ8/UnOBY1GdU0V0qB0RUk2/E4v3ERaXG+oL0G7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MhvxX4Hz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEFBC116D0;
	Mon, 18 Aug 2025 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755523914;
	bh=MQiCrSS7kUx/shURTcefWsvaG4bksayGJxw1dtUWr8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhvxX4HzZhBPleLvpu9Wz4yGe1re8It0nlbywkBHcyRyibTeHDJSU1scijjEgX1ob
	 PMzAEd/YofcaA1X0rGUdo7bcJj39XA8Y/zrTkGMBiJ4adaIOtoiRge3hVZkoglAom6
	 F6W1hzEEe7zYMbib6NfdS7805v3Q3rmD4BppHAeM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 311/515] wifi: rtlwifi: fix possible skb memory leak in _rtl_pci_init_one_rxdesc()
Date: Mon, 18 Aug 2025 14:44:57 +0200
Message-ID: <20250818124510.407453131@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit 76b3e5078d76f0eeadb7aacf9845399f8473da0d ]

When `dma_mapping_error()` is true, if a new `skb` has been allocated,
then it must be de-allocated.

Compile tested only

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250613074014.69856-2-fourier.thomas@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 2741c3beac4c..d080469264cf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -572,8 +572,11 @@ static int _rtl_pci_init_one_rxdesc(struct ieee80211_hw *hw,
 		dma_map_single(&rtlpci->pdev->dev, skb_tail_pointer(skb),
 			       rtlpci->rxbuffersize, DMA_FROM_DEVICE);
 	bufferaddress = *((dma_addr_t *)skb->cb);
-	if (dma_mapping_error(&rtlpci->pdev->dev, bufferaddress))
+	if (dma_mapping_error(&rtlpci->pdev->dev, bufferaddress)) {
+		if (!new_skb)
+			kfree_skb(skb);
 		return 0;
+	}
 	rtlpci->rx_ring[rxring_idx].rx_buf[desc_idx] = skb;
 	if (rtlpriv->use_new_trx_flow) {
 		/* skb->cb may be 64 bit address */
-- 
2.39.5




