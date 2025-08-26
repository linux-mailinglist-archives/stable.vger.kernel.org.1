Return-Path: <stable+bounces-174484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D36AB3638C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815015E2DED
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7614342CAE;
	Tue, 26 Aug 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q+yo7Sj+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99237341AA9;
	Tue, 26 Aug 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214514; cv=none; b=WpE39GjwrSHmzjmzmELUuL3E1GmzRBaqgeiV9yaXPPL4WIvOQ2GFU+4unQJnXaKCpBTNAbo++ilfewsKxdQq2/2SLWirknGZtyPt64IxX7gZOWeVhyuSNIf+bbLM0bYz34F1UTrY3Xw0b3toQveswH0VXOJ66xfEsB62Y7h6fIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214514; c=relaxed/simple;
	bh=ZYW+NC1D9SPOTo2B/hW3/QX3mrUZeeg0XyB1ETnnMZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L00q8dWUDI/agtPL0q/hElW7+Qmv1MJh0vK40j7ettIG+8VbqONasOIX17ODcq+GlO7BYOMVfsiLUezDBS1VEFJFY5QZZkUo7N/jP8+VDOxz3tiSgxrS4SzVgsaRGLN42jSbqDRzLTGAFjUpTotuWNV/OZIgj/M5fkvZnNNagpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q+yo7Sj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8282C4CEF1;
	Tue, 26 Aug 2025 13:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214514;
	bh=ZYW+NC1D9SPOTo2B/hW3/QX3mrUZeeg0XyB1ETnnMZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+yo7Sj+hUEG3A48Ou7Z51+Hns45vir0xJq8Fk42mGxX4VWUGNXtviERQeL28KE50
	 Y27IqldYF1GcCwY5voEIXiBc/4XG6nydPf2IFNeD3v5tgg44GZ8Kuxj8JJoa43BZyp
	 lGCPcSaIoK92yqj/0cYP9OGUTPju/4TFpsDmGoL4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 149/482] wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.
Date: Tue, 26 Aug 2025 13:06:42 +0200
Message-ID: <20250826110934.500422378@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index b423caea2c58..f796b16eac53 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -803,13 +803,19 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw *hw)
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




