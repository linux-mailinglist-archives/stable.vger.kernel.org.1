Return-Path: <stable+bounces-172066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCF6B2FA38
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA6517A47C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB553314A2;
	Thu, 21 Aug 2025 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dLT57+A9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A032A3CD
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782213; cv=none; b=El8Tliq+c4KUk7IP1qtlN8uf9YK4kq6virY5xj+M6TeWiiQm2nP5gEjfxlTUlTjpdRtYFasAFDWIor1OEVApXHpZC9a8tfkaWamJOMvTBxeR25YheOfrAgT8oyTyPuyItIqmapfeL5bmxCK4VGcW3GY5TJNU6uI9oBlOxBCumuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782213; c=relaxed/simple;
	bh=ovzyZEVCAHuxCgPnapTqu65h4qt4kwxG12eRKkOFaeI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uGosJVUk1a40DHsPJqy4CyWyk8rEh+PqcRorKIK+tMsXaaF2jnohkPU0LxRFLzxmSXikLMh+6csQescDqxheJWYI7JvR28pb/SaT0EI5LcTl0mKJz2ZR6wPL8Mun9W8goC7ut0IFcObx6t8qZPbz1tF0HIvTe2hO1+y0auU8FJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dLT57+A9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9BFC4CEEB;
	Thu, 21 Aug 2025 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782213;
	bh=ovzyZEVCAHuxCgPnapTqu65h4qt4kwxG12eRKkOFaeI=;
	h=Subject:To:Cc:From:Date:From;
	b=dLT57+A9AY7LusM2CpEmFBoomARdFHLG5udi/MY6b0qwiBzUPzOrpy+BBsNL4s+94
	 6F1D98daU5iX06LC482R6ndW3mKS1zsxe5+euUZm44tkdH+lrBEKk5UhSTVbhVjiJE
	 EngkChQivKyvxklT0fQSS3GUkoTHkVqsEZyXZZU0=
Subject: FAILED: patch "[PATCH] wifi: ath11k: fix dest ring-buffer corruption" failed to apply to 5.15-stable tree
To: johan+linaro@kernel.org,jeff.johnson@oss.qualcomm.com,quic_bqiang@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:15:40 +0200
Message-ID: <2025082140-deuce-radiator-ccc5@gregkh>
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
git cherry-pick -x 8c1ba5091fa9a2d1478da63173b16a701bdf86bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082140-deuce-radiator-ccc5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c1ba5091fa9a2d1478da63173b16a701bdf86bb Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 4 Jun 2025 16:34:53 +0200
Subject: [PATCH] wifi: ath11k: fix dest ring-buffer corruption

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

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index be9395f2ed8b..878ce30b307c 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -395,9 +395,6 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
 		goto err;
 	}
 
-	/* Make sure descriptor is read after the head pointer. */
-	dma_rmb();
-
 	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
 
 	*skb = pipe->dest_ring->skb[sw_index];
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 9230a965f6f0..065fc40e2541 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2650,9 +2650,6 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 try_again:
 	ath11k_hal_srng_access_begin(ab, srng);
 
-	/* Make sure descriptor is read after the head pointer. */
-	dma_rmb();
-
 	while (likely(desc =
 	      (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_entry(ab,
 									     srng))) {
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index a6513aa6fbfa..0aa73774150c 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -825,13 +825,23 @@ u32 *ath11k_hal_srng_src_peek(struct ath11k_base *ab, struct hal_srng *srng)
 
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


