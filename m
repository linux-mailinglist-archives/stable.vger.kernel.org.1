Return-Path: <stable+bounces-174613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF3B3634B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E6B7A621A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E833A010;
	Tue, 26 Aug 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R8Z7TS12"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27E1DE4CD;
	Tue, 26 Aug 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214858; cv=none; b=YV2QhRk+DmRhzAA6IwQzAmgkEwb3EvAw5zGvzyd6Zde0yLIpAJyd2PnBAEdxV5OmXwDedmuCa9w5tZLcJNTO4FawLhzwYQQM6TGIGF1mCbnOOO3qJjp1zMMmTAVUCKchidAcBfVJRRpmCxz4GJ+G5voJxhkYzBw4UGQiHr8sNck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214858; c=relaxed/simple;
	bh=p2X4cz5LoKc0B3izdho7Ha2feprDpnZqll76EKgo2nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhJIMoq944K72G9zT9I1zl9g9NwkcFdijrXr8+fTXMH7ZYrO+ZeCjuOena2G4wEXvHtyyIb3JULLK8nehXl19KlR5fnsJSBhuJ0wmsCEHr+m3r0s7BMK1KedEkIHa8g8ohLr2MClAhE9qAPKl6jpt3lVvWCjSTrrfEFp1v0JAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R8Z7TS12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7F2C113CF;
	Tue, 26 Aug 2025 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214856;
	bh=p2X4cz5LoKc0B3izdho7Ha2feprDpnZqll76EKgo2nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R8Z7TS12WqUyGUgWEtXVkPMtmpmUyQoFYYLpMToPD7qCj1u1Zp6mjp40uXhkI8Ijz
	 OhWrj6t3WnDVmxxJbzcErfLoyU+cizGs6CNgu0OG74mU40BiufXJvdygaNF/U3qmyC
	 I8zbXli8hvXjaqv0wrlUZ3Sb1Jb2owitsiLYGS0U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH 6.1 296/482] wifi: ath11k: fix dest ring-buffer corruption
Date: Tue, 26 Aug 2025 13:09:09 +0200
Message-ID: <20250826110938.106464138@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

commit 8c1ba5091fa9a2d1478da63173b16a701bdf86bb upstream.

Add the missing memory barrier to make sure that destination ring
descriptors are read after the head pointers to avoid using stale data
on weakly ordered architectures like aarch64.

The barrier is added to the ath11k_hal_srng_access_begin() helper for
symmetry with follow-on fixes for source ring buffer corruption which
will add barriers to ath11k_hal_srng_access_end().

Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org	# 5.6
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>
Link: https://patch.msgid.link/20250604143457.26032-2-johan+linaro@kernel.org
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath11k/ce.c    |    3 ---
 drivers/net/wireless/ath/ath11k/dp_rx.c |    3 ---
 drivers/net/wireless/ath/ath11k/hal.c   |   12 +++++++++++-
 3 files changed, 11 insertions(+), 7 deletions(-)

--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -393,9 +393,6 @@ static int ath11k_ce_completed_recv_next
 		goto err;
 	}
 
-	/* Make sure descriptor is read after the head pointer. */
-	dma_rmb();
-
 	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
 
 	*skb = pipe->dest_ring->skb[sw_index];
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2661,9 +2661,6 @@ int ath11k_dp_process_rx(struct ath11k_b
 try_again:
 	ath11k_hal_srng_access_begin(ab, srng);
 
-	/* Make sure descriptor is read after the head pointer. */
-	dma_rmb();
-
 	while (likely(desc =
 	      (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_entry(ab,
 									     srng))) {
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -796,13 +796,23 @@ u32 *ath11k_hal_srng_src_peek(struct ath
 
 void ath11k_hal_srng_access_begin(struct ath11k_base *ab, struct hal_srng *srng)
 {
+	u32 hp;
+
 	lockdep_assert_held(&srng->lock);
 
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		srng->u.src_ring.cached_tp =
 			*(volatile u32 *)srng->u.src_ring.tp_addr;
 	} else {
-		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+
+		if (hp != srng->u.dst_ring.cached_hp) {
+			srng->u.dst_ring.cached_hp = hp;
+			/* Make sure descriptor is read after the head
+			 * pointer.
+			 */
+			dma_rmb();
+		}
 
 		/* Try to prefetch the next descriptor in the ring */
 		if (srng->flags & HAL_SRNG_FLAGS_CACHED)



