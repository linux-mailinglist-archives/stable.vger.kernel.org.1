Return-Path: <stable+bounces-125739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2461A6B818
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 10:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FFD3BDE7F
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B65E1F1301;
	Fri, 21 Mar 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHcV8z2C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048E1F03D9;
	Fri, 21 Mar 2025 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550678; cv=none; b=AMOMx/YMcKmELCTZWezGPDQR+6DulDfD65DMKiRdCJh2l5vHMKKoTQa3jRNrUfvJdbBBtZlMaev0zLXpU+uvtofEYNrK5/I6NDAn63zsc/IzNwz3MDgTxwMbXy3H5OLARv+6qgerPTDf/VRnbZCOsTv/bOvQnT4Ltb2xgIugjsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550678; c=relaxed/simple;
	bh=7VVnqp5We7VPKAInGfw9ekTMBCZL0z2VJqoEGwTjLi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJB5PxUp+DisCSvyhg3G2iiI+eZ+OaY9/gjYwDXj+tNuK4k4GxBYbaa5/+hggRutaGEzBzgKm+QMONAk92z1zqj/bSwFmjAoAbKqpP+huqwrQHe0RnjpDv5tGA6PsNmCgQnhC47R9ksDF3ensWbEEqKJLTBs77MuSl96R0bwkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHcV8z2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBF1C4CEE3;
	Fri, 21 Mar 2025 09:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742550677;
	bh=7VVnqp5We7VPKAInGfw9ekTMBCZL0z2VJqoEGwTjLi4=;
	h=From:To:Cc:Subject:Date:From;
	b=lHcV8z2CtfTJIarA0QrL219MIoGuU+sSOalI+d+YJmpoPz+DELbdmQUV5siLF44lQ
	 C++07eAF9FLFaHnO43AwMRh4KM+vP/BLytxJWUZJekB+x0fOoTqW/l2fGuKUnhpQmL
	 X0rxP3YTo4a8ths5Ci9stdyTcBw7HhtKEGAIA0WX6j8B9sV4ePpsZnaqcuNv3AvJMA
	 2acHrQhuAr9did8o4HwDdyeJ+JjR5SKoybrFO+izvveLb1wuTmS1EGHxNAF8Ek8gk3
	 5JNySUSLARJK2EakaHjRRHvbWR7rOvgR4G7FtRYYl5v9OS5nb1JdCzuMbIG0CvpoVN
	 QEMm72u/CNQUw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tvZ26-0000000050m-3F6D;
	Fri, 21 Mar 2025 10:51:19 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Steev Klimaszewski <steev@kali.org>,
	Clayton Craft <clayton@craftyguy.net>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath11k: fix ring-buffer corruption
Date: Fri, 21 Mar 2025 10:49:16 +0100
Message-ID: <20250321094916.19098-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
breaks and the log fills up with errors like:

    ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
    ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484

which based on a quick look at the driver seemed to indicate some kind
of ring-buffer corruption.

Miaoqing Pan tracked it down to the host seeing the updated destination
ring head pointer before the updated descriptor, and the error handling
for that in turn leaves the ring buffer in an inconsistent state.

Add the missing memory barrier to make sure that the descriptor is read
after the head pointer to address the root cause of the corruption while
fixing up the error handling in case there are ever any (ordering) bugs
on the device side.

Note that the READ_ONCE() are only needed to avoid compiler mischief in
case the ring-buffer helpers are ever inlined.

Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218623
Link: https://lore.kernel.org/20250310010217.3845141-3-quic_miaoqing@quicinc.com
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: stable@vger.kernel.org	# 5.6
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath11k/ce.c  | 11 +++++------
 drivers/net/wireless/ath/ath11k/hal.c |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index e66e86bdec20..9d8efec46508 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -393,11 +393,10 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
 		goto err;
 	}
 
+	/* Make sure descriptor is read after the head pointer. */
+	dma_rmb();
+
 	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
-	if (*nbytes == 0) {
-		ret = -EIO;
-		goto err;
-	}
 
 	*skb = pipe->dest_ring->skb[sw_index];
 	pipe->dest_ring->skb[sw_index] = NULL;
@@ -430,8 +429,8 @@ static void ath11k_ce_recv_process_cb(struct ath11k_ce_pipe *pipe)
 		dma_unmap_single(ab->dev, ATH11K_SKB_RXCB(skb)->paddr,
 				 max_nbytes, DMA_FROM_DEVICE);
 
-		if (unlikely(max_nbytes < nbytes)) {
-			ath11k_warn(ab, "rxed more than expected (nbytes %d, max %d)",
+		if (unlikely(max_nbytes < nbytes || nbytes == 0)) {
+			ath11k_warn(ab, "unexpected rx length (nbytes %d, max %d)",
 				    nbytes, max_nbytes);
 			dev_kfree_skb_any(skb);
 			continue;
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 61f4b6dd5380..8cb1505a5a0c 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -599,7 +599,7 @@ u32 ath11k_hal_ce_dst_status_get_length(void *buf)
 	struct hal_ce_srng_dst_status_desc *desc = buf;
 	u32 len;
 
-	len = FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, desc->flags);
+	len = FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, READ_ONCE(desc->flags));
 	desc->flags &= ~HAL_CE_DST_STATUS_DESC_FLAGS_LEN;
 
 	return len;
@@ -829,7 +829,7 @@ void ath11k_hal_srng_access_begin(struct ath11k_base *ab, struct hal_srng *srng)
 		srng->u.src_ring.cached_tp =
 			*(volatile u32 *)srng->u.src_ring.tp_addr;
 	} else {
-		srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
+		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
 
 		/* Try to prefetch the next descriptor in the ring */
 		if (srng->flags & HAL_SRNG_FLAGS_CACHED)
-- 
2.48.1


