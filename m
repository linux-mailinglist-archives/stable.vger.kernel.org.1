Return-Path: <stable+bounces-154933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD184AE1500
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB073B6208
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EE6227EBF;
	Fri, 20 Jun 2025 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rvc75tgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AAF30E85C
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404648; cv=none; b=nGUz6Uvdpzerzg+N+jBpD7QLxq/0gtoVVNU7Jxu9EyGNyirRssHa9K8CdKp+jksfnqi7chMI4+vFhTlf1tNYQfVwDkUJULc1h1wZizh2OWl+d1U5l3ZXfxn+Eyt5UfNGHOgX53cexn32KFyZLDXs6zqhpi+OE9XRiGTbw53rSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404648; c=relaxed/simple;
	bh=3Fp/3B+PcUMWGoyr3eC58E05vRUNtPdh6OYJ+FFdadQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PwrSDcFBpqaxj2RlfzSIePcg6FivBrlBpPiGS6PhonduJAyBaO68LYF1iIPip9ulkP2fdqsv7Kzr1JsRk2J/+ETIUPreMHcDIZK3Byp6hj8LUaIZk5IhGWj7jKZlh1lLRTBGa4F8xIDshBjz9z3gsYweZCh5RVdu3MuPup/xsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rvc75tgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD87C4CEED;
	Fri, 20 Jun 2025 07:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750404648;
	bh=3Fp/3B+PcUMWGoyr3eC58E05vRUNtPdh6OYJ+FFdadQ=;
	h=Subject:To:Cc:From:Date:From;
	b=rvc75tggj2dL8fS1OCGav3LdcEM8HZQ30ojTVqQ+9+XZnK36U20HoqW46Yiwb30uu
	 +qr01kLo9zEbWWcaoop8PPPas+Kk3nC9SpDA1VhdhssKvjf5p673K7n35nRlIrbt0h
	 aA5Xf9jD5QuQdKdt1sWuf2KASc9pd/vC+JrMppx0=
Subject: FAILED: patch "[PATCH] wifi: ath11k: fix rx completion meta data corruption" failed to apply to 5.15-stable tree
To: johan+linaro@kernel.org,clayton@craftyguy.net,jeff.johnson@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:30:44 +0200
Message-ID: <2025062044-setback-catchable-ac30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ab52e3e44fe9b666281752e2481d11e25b0e3fdd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062044-setback-catchable-ac30@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab52e3e44fe9b666281752e2481d11e25b0e3fdd Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Fri, 21 Mar 2025 15:53:02 +0100
Subject: [PATCH] wifi: ath11k: fix rx completion meta data corruption

Add the missing memory barrier to make sure that the REO dest ring
descriptor is read after the head pointer to avoid using stale data on
weakly ordered architectures like aarch64.

This may fix the ring-buffer corruption worked around by commit
f9fff67d2d7c ("wifi: ath11k: Fix SKB corruption in REO destination
ring") by silently discarding data, and may possibly also address user
reported errors like:

	ath11k_pci 0006:01:00.0: msdu_done bit in attention is not set

Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org	# 5.6
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218005
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Clayton Craft <clayton@craftyguy.net>
Link: https://patch.msgid.link/20250321145302.4775-1-johan+linaro@kernel.org
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 218ab41c0f3c..ea2959305dec 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2637,7 +2637,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 	struct ath11k *ar;
 	struct hal_reo_dest_ring *desc;
 	enum hal_reo_dest_ring_push_reason push_reason;
-	u32 cookie;
+	u32 cookie, info0, rx_msdu_info0, rx_mpdu_info0;
 	int i;
 
 	for (i = 0; i < MAX_RADIOS; i++)
@@ -2650,11 +2650,14 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 try_again:
 	ath11k_hal_srng_access_begin(ab, srng);
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	while (likely(desc =
 	      (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_entry(ab,
 									     srng))) {
 		cookie = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
-				   desc->buf_addr_info.info1);
+				   READ_ONCE(desc->buf_addr_info.info1));
 		buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID,
 				   cookie);
 		mac_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_PDEV_ID, cookie);
@@ -2683,8 +2686,9 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 
 		num_buffs_reaped[mac_id]++;
 
+		info0 = READ_ONCE(desc->info0);
 		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
-					desc->info0);
+					info0);
 		if (unlikely(push_reason !=
 			     HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION)) {
 			dev_kfree_skb_any(msdu);
@@ -2692,18 +2696,21 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 			continue;
 		}
 
-		rxcb->is_first_msdu = !!(desc->rx_msdu_info.info0 &
+		rx_msdu_info0 = READ_ONCE(desc->rx_msdu_info.info0);
+		rx_mpdu_info0 = READ_ONCE(desc->rx_mpdu_info.info0);
+
+		rxcb->is_first_msdu = !!(rx_msdu_info0 &
 					 RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU);
-		rxcb->is_last_msdu = !!(desc->rx_msdu_info.info0 &
+		rxcb->is_last_msdu = !!(rx_msdu_info0 &
 					RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU);
-		rxcb->is_continuation = !!(desc->rx_msdu_info.info0 &
+		rxcb->is_continuation = !!(rx_msdu_info0 &
 					   RX_MSDU_DESC_INFO0_MSDU_CONTINUATION);
 		rxcb->peer_id = FIELD_GET(RX_MPDU_DESC_META_DATA_PEER_ID,
-					  desc->rx_mpdu_info.meta_data);
+					  READ_ONCE(desc->rx_mpdu_info.meta_data));
 		rxcb->seq_no = FIELD_GET(RX_MPDU_DESC_INFO0_SEQ_NUM,
-					 desc->rx_mpdu_info.info0);
+					 rx_mpdu_info0);
 		rxcb->tid = FIELD_GET(HAL_REO_DEST_RING_INFO0_RX_QUEUE_NUM,
-				      desc->info0);
+				      info0);
 
 		rxcb->mac_id = mac_id;
 		__skb_queue_tail(&msdu_list[mac_id], msdu);


