Return-Path: <stable+bounces-91038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE99BEC27
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F15C1F24D6D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650A01F12F9;
	Wed,  6 Nov 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/EC5nbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AE21E0DFD;
	Wed,  6 Nov 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897557; cv=none; b=Z5nibDu4NIS5FM/rTGVPFHDyHpAwDbYvDRdOJMH72/dcTA8K5KnjjVFZzKlpoAd0o4Al6f7kx7BC8JdAN9oSXKFyTwZo+xa+K5Yi49o0WcnlPWZOmgCBNi0dSupQVNL5KW4RftPyMG0mNs7DPqGjUoETLacWCNt2iCKFBPwUX9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897557; c=relaxed/simple;
	bh=1XkR7rM/dq2+Me7Iv49kkaeVJshR5qaTmhF8ylJmFnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T63bT0RFSDLQSWCFqUTz2VmvOcjcquWpp3iSTON6GX2lmb/1i145gTr16JGqr8SAggLAl3ShLJW9cC94u51TcxAAd0D36/Z9m+36elBR4R4qPUIfwmYsHcpMGPZ+efYLpoAIh1RTWBEDNT6dI2NbqiBMHEsy5eMH1vvpWbYJeik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e/EC5nbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC83C4CECD;
	Wed,  6 Nov 2024 12:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897557;
	bh=1XkR7rM/dq2+Me7Iv49kkaeVJshR5qaTmhF8ylJmFnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/EC5nbNDrZY1LDx8DDZOu6xX3SxXdmvm5YDUXSCBNfsIWhJLXuDr1DOrujokvk+S
	 ummBuTOK1ghZFw+k21tUHypQgdA/IhDTTD1h5zKF0GWROPUNoNNqflP2xFi+aGtQh1
	 yRREBc9mHb/zgxiaZd7xm7qBVeQ4deKqWtvGfKAI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 6.6 093/151] wifi: ath10k: Fix memory leak in management tx
Date: Wed,  6 Nov 2024 13:04:41 +0100
Message-ID: <20241106120311.432640659@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
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
@@ -3042,9 +3042,14 @@ ath10k_wmi_tlv_op_cleanup_mgmt_tx_send(s
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
@@ -2440,6 +2440,7 @@ wmi_process_mgmt_tx_comp(struct ath10k *
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	info = IEEE80211_SKB_CB(msdu);
+	kfree(pkt_addr);
 
 	if (param->status) {
 		info->flags &= ~IEEE80211_TX_STAT_ACK;
@@ -9559,6 +9560,7 @@ static int ath10k_wmi_mgmt_tx_clean_up_p
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	ieee80211_free_txskb(ar->hw, msdu);
+	kfree(pkt_addr);
 
 	return 0;
 }



