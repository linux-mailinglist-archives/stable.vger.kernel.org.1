Return-Path: <stable+bounces-172067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD66B2F9F2
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2A87AB0D9
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9013E3375C0;
	Thu, 21 Aug 2025 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q3wRyhNi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE513277BD
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782217; cv=none; b=YFZX+ok9+z/QlBlAC1NsFUlL51x13JBRDDMc4+fE9yyLjZEgpylOuJWzUrVkK2j47n6C1W2wpxVQ6IScmb8SrfJA6gCktotK9ekvKti73eusai881bQTmekj2WlD3jkAkyMmxL7eu0nC1CukSf7z9b0hccFXrI1/MTbuKLYl4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782217; c=relaxed/simple;
	bh=cbuBnulLGf0sZvXF/P55PQQ8g91fg70w4YTy6IVvOyo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MHad3sb+2QgJ7yRpxSV5yfAkzJeVzZFXEwZukf+RXDatmsPOdXz0BBKJPVdmtkVH/G3+nYzWy0fMscli8z2+wzG4EIZjLke1oxseV6KqOjADAebuUzEoUdG3pAV5jYm+YLD4mrByWu1sVd0vkVgbnkBt4LG8fmjzrgbchBSeNUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q3wRyhNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0D2C16AAE;
	Thu, 21 Aug 2025 13:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782216;
	bh=cbuBnulLGf0sZvXF/P55PQQ8g91fg70w4YTy6IVvOyo=;
	h=Subject:To:Cc:From:Date:From;
	b=Q3wRyhNi4yOpbZ6p1G2YGiWZgZKCWqGQJdRmy/4FrF9rLoJlRc4pEgIk3V3b/xijc
	 IAfyjhozhVmiVVgxkqYdELHwSJDytIqMZcUWQADW7BnHmn7ipo9UiRdXggbr1mdedS
	 7ehJMu8b0JPksXb4NKr7ODbPV9ItKBLUJ9/ZHNsE=
Subject: FAILED: patch "[PATCH] wifi: ath11k: fix dest ring-buffer corruption" failed to apply to 5.10-stable tree
To: johan+linaro@kernel.org,jeff.johnson@oss.qualcomm.com,quic_bqiang@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:15:41 +0200
Message-ID: <2025082141-perfectly-basil-f53e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8c1ba5091fa9a2d1478da63173b16a701bdf86bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082141-perfectly-basil-f53e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


