Return-Path: <stable+bounces-91553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072569BEE80
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393B81C209D7
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE8F1DFD9D;
	Wed,  6 Nov 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SrlsGXcK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24C1DE3B9;
	Wed,  6 Nov 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899070; cv=none; b=Eo8FhAMbaOrxey79gYDCFnNC4QcK5FJFeQ1U9zTK5KpEvrkfrBQYfgLeeY1Hwnd6XuXTlBtT5Fd+7OYwBN55zQOob5E0hRzDBVv5nlM3AiAzkwlmrodhBDQ3wsRukg2+D2JckDtMiHrf6cUtnQ3oRwuPTPP1Z0K93IeeNrrkZjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899070; c=relaxed/simple;
	bh=c5Jc2pFOEyA6tp6kjuCxG8TtCKUc1XwGTb0krpUK6rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkK3N6BNIcgfq/JklLKjcdqMCZafxPF773nRIIi8gnoYU+3ivmb9d3hM4SO0N71BbtMGdKANJ+4OeJjAAv7cjBbBtRGiWvzOfxAuS+z0khXUlvEo17oEUvXfHO35/wgu1EOcIULtbNr11dC/5xZng1AlkNU7LyBFi11R80HlBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SrlsGXcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F35C4CECD;
	Wed,  6 Nov 2024 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730899070;
	bh=c5Jc2pFOEyA6tp6kjuCxG8TtCKUc1XwGTb0krpUK6rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SrlsGXcKMT/o7D6AxWqekOrjtwqYu07cyfTiDhHEC1gNpOZAj+FszJIHgZTQm9ODs
	 mQmdazruzRW3mLrDAncC+V0OM9T/2pq1J5U0n/0KMs9R5xyTP9Qgwl0DRkj/h3ZRRH
	 0qChBLCBHkcAFH0XepwMvgLCViqqqgVvpSIp9Xi4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 5.4 451/462] wifi: ath10k: Fix memory leak in management tx
Date: Wed,  6 Nov 2024 13:05:44 +0100
Message-ID: <20241106120342.646591569@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

From: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

commit e15d84b3bba187aa372dff7c58ce1fd5cb48a076 upstream.

In the current logic, memory is allocated for storing the MSDU context
during management packet TX but this memory is not being freed during
management TX completion. Similar leaks are seen in the management TX
cleanup logic.

Kmemleak reports this problem as below,

unreferenced object 0xffffff80b64ed250 (size 16):
  comm "kworker/u16:7", pid 148, jiffies 4294687130 (age 714.199s)
  hex dump (first 16 bytes):
    00 2b d8 d8 80 ff ff ff c4 74 e9 fd 07 00 00 00  .+.......t......
  backtrace:
    [<ffffffe6e7b245dc>] __kmem_cache_alloc_node+0x1e4/0x2d8
    [<ffffffe6e7adde88>] kmalloc_trace+0x48/0x110
    [<ffffffe6bbd765fc>] ath10k_wmi_tlv_op_gen_mgmt_tx_send+0xd4/0x1d8 [ath10k_core]
    [<ffffffe6bbd3eed4>] ath10k_mgmt_over_wmi_tx_work+0x134/0x298 [ath10k_core]
    [<ffffffe6e78d5974>] process_scheduled_works+0x1ac/0x400
    [<ffffffe6e78d60b8>] worker_thread+0x208/0x328
    [<ffffffe6e78dc890>] kthread+0x100/0x1c0
    [<ffffffe6e78166c0>] ret_from_fork+0x10/0x20

Free the memory during completion and cleanup to fix the leak.

Protect the mgmt_pending_tx idr_remove() operation in
ath10k_wmi_tlv_op_cleanup_mgmt_tx_send() using ar->data_lock similar to
other instances.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1

Fixes: dc405152bb64 ("ath10k: handle mgmt tx completion event")
Fixes: c730c477176a ("ath10k: Remove msdu from idr when management pkt send fails")
Cc: stable@vger.kernel.org
Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Link: https://patch.msgid.link/20241015064103.6060-1-quic_mpubbise@quicinc.com
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |    7 ++++++-
 drivers/net/wireless/ath/ath10k/wmi.c     |    2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -2854,9 +2854,14 @@ ath10k_wmi_tlv_op_cleanup_mgmt_tx_send(s
 				       struct sk_buff *msdu)
 {
 	struct ath10k_skb_cb *cb = ATH10K_SKB_CB(msdu);
+	struct ath10k_mgmt_tx_pkt_addr *pkt_addr;
 	struct ath10k_wmi *wmi = &ar->wmi;
 
-	idr_remove(&wmi->mgmt_pending_tx, cb->msdu_id);
+	spin_lock_bh(&ar->data_lock);
+	pkt_addr = idr_remove(&wmi->mgmt_pending_tx, cb->msdu_id);
+	spin_unlock_bh(&ar->data_lock);
+
+	kfree(pkt_addr);
 
 	return 0;
 }
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2385,6 +2385,7 @@ wmi_process_mgmt_tx_comp(struct ath10k *
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	info = IEEE80211_SKB_CB(msdu);
+	kfree(pkt_addr);
 
 	if (param->status) {
 		info->flags &= ~IEEE80211_TX_STAT_ACK;
@@ -9466,6 +9467,7 @@ static int ath10k_wmi_mgmt_tx_clean_up_p
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	ieee80211_free_txskb(ar->hw, msdu);
+	kfree(pkt_addr);
 
 	return 0;
 }



