Return-Path: <stable+bounces-172509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EDCB322E9
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 21:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F461627D2B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECF82D0C96;
	Fri, 22 Aug 2025 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYProfI0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33214A1A
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891307; cv=none; b=ubIhXyxjjriwIyPTsB9+ZgqNMQjqbjUocTKJNdeF/KUBZbGKtRUVlfTFDyU8MOwBQ8q7Zu/3MHeqCqG0J4KvxNcIoVm/ZV23z1eNkbghZommkq6hd24DiISXYj8XoCrHzk0AmSB/q1Yjp/POQf9wRvKzFZxu7BRVumseMD6VbV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891307; c=relaxed/simple;
	bh=fOF8LlPyKWtyvjLxYB5LgEa3H3bPjyThIs6sIUtmIpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fdn7+rkfA/vctEvPPYKuJMPwl5Jaqo8oBccPN5BZk5tT5MpmRiFZapQ/wzsQSnUH7jADditffbeB7xLhxgtd65Ub7hI5lF4HDYweCHsV567lngEMvg6KnpFs0hvOchEPhlSznk4uB4Mj6eJx47vZLnzen9SXDyjiqyr1N5UgGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYProfI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B97C113CF;
	Fri, 22 Aug 2025 19:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755891306;
	bh=fOF8LlPyKWtyvjLxYB5LgEa3H3bPjyThIs6sIUtmIpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYProfI0tsqmAqsRSVd6ZMiBG9jGS2Nk/7ThacyZ8jC3I2z5xpuR6IymtcmAvtTo+
	 09zfD2s1BHjrwjB15AyNNP8c7EQCux6t49qKvGNxRQdadfbAx1jSFgbVmPzi+Pdyrq
	 4rshhlOS5fR/AdqnNHWxq4rbn7KxG4NeL86/B+Rg0Ar3RnkuhZxIj026UOc3vjusfC
	 AlVGjUUF1xUc2eWlXD5I52wYIkIOx4DZg39gEoi8nN0SErCfyKaWrudIc8VwwzBmLB
	 oRHuc9R3E64/QPM6sB6VteSfU/Gq2Ml5Wx+yWnLcE6j82S9iyLPANiHwyMSdjsE0rq
	 BtoISlv+QKqmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] wifi: ath11k: fix dest ring-buffer corruption when ring is full
Date: Fri, 22 Aug 2025 15:35:02 -0400
Message-ID: <20250822193502.1445377-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822193502.1445377-1-sashal@kernel.org>
References: <2025082143-halved-suitably-b32b@gregkh>
 <20250822193502.1445377-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit aa6956150f820e6a6deba44be325ddfcb5b10f88 ]

Add the missing memory barriers to make sure that destination ring
descriptors are read before updating the tail pointer (and passing
ownership to the device) to avoid memory corruption on weakly ordered
architectures like aarch64 when the ring is full.

Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org      # 5.6
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>
Link: https://patch.msgid.link/20250604143457.26032-6-johan+linaro@kernel.org
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/hal.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 5dbf5596c9e8..b83d8e3890f9 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -789,7 +789,6 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 {
 	lockdep_assert_held(&srng->lock);
 
-	/* TODO: See if we need a write memory barrier here */
 	if (srng->flags & HAL_SRNG_FLAGS_LMAC_RING) {
 		/* For LMAC rings, ring pointer updates are done through FW and
 		 * hence written to a shared memory location that is read by FW
@@ -800,7 +799,11 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 			*srng->u.src_ring.hp_addr = srng->u.src_ring.hp;
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
-			*srng->u.dst_ring.tp_addr = srng->u.dst_ring.tp;
+			/* Make sure descriptor is read before updating the
+			 * tail pointer.
+			 */
+			dma_mb();
+			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
 		}
 	} else {
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
@@ -812,6 +815,10 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 					   srng->u.src_ring.hp);
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
+			/* Make sure descriptor is read before updating the
+			 * tail pointer.
+			 */
+			mb();
 			ath11k_hif_write32(ab,
 					   (unsigned long)srng->u.dst_ring.tp_addr -
 					   (unsigned long)ab->mem,
-- 
2.50.1


