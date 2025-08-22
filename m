Return-Path: <stable+bounces-172512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B86F5B3233B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 21:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD5B5839F8
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA7A2D640F;
	Fri, 22 Aug 2025 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SelyD4dN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D5A2D63FC
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892419; cv=none; b=IN3a5i+PJZu/FfHxaHp/9WOxBdjsYLQ4Z+ZL8EAYWheUf6O9aFkSM6p73sOyT51siLDZBlChs6BcVCwdnytXLH3q7OcvM5lRK7UAWrWgJHwwrFuAJCUM9hYonJ0fwK2K5KqOyCV6GvFHNLV1wP47gNB8dSAi8cbvDcfkuvW7K0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892419; c=relaxed/simple;
	bh=atKBMzE8cd4gyCf5pEK1my9B4isSUdIG6r1poCCUxh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEmhMg7jECt0aFnej+2+tTTg7zVje2kdEPg+BiWZgW2oQSZcXwsHgsjv5RnJvpRAgoeZ8WyPq3xd021U0V776/L/sTPmnla40kfaYqW7zruhi9jduMgqPl0wZ1gXeVb1D07dUxidfIZwYNE7YObp9sDb8EBtySoao+VHEETCfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SelyD4dN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65D8C116D0;
	Fri, 22 Aug 2025 19:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755892415;
	bh=atKBMzE8cd4gyCf5pEK1my9B4isSUdIG6r1poCCUxh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SelyD4dNPafj1piR6ET6QLO9aqpVP6BDFX5htQqJJQsE6vCfVxrl/ERUkNVDQFSb9
	 C0qb12B5r0hc5LFlWLmfrA7PzxuSYmQG7KoMfcEspFoiJIZPj19UOY7u6TiPhtBsWW
	 OQ3oyPkDp2q6jP+6f4tap8BB9xIoiwnJzfWDTuicm2DhoYsd++pJ0xXOkg4VheW3cF
	 NnxtuxMK1YppAoxyF8W986MSgTtFEYFhSPq6THtymnb8TtVhH+Z3ZW15wW2b7ZszJA
	 bMxUF1ahPuyArJ1hAnSrHRdPfjgOlVe1lyo3R/oPq9PnVKOrKmgSII5dvhH7Xd80nu
	 hESbMBg8tG3ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] wifi: ath11k: fix dest ring-buffer corruption when ring is full
Date: Fri, 22 Aug 2025 15:53:30 -0400
Message-ID: <20250822195330.1458412-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822195330.1458412-1-sashal@kernel.org>
References: <2025082153-saline-camcorder-75cb@gregkh>
 <20250822195330.1458412-1-sashal@kernel.org>
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
index f3b9108ab6bd..d2303b2d52ae 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -833,7 +833,6 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 {
 	lockdep_assert_held(&srng->lock);
 
-	/* TODO: See if we need a write memory barrier here */
 	if (srng->flags & HAL_SRNG_FLAGS_LMAC_RING) {
 		/* For LMAC rings, ring pointer updates are done through FW and
 		 * hence written to a shared memory location that is read by FW
@@ -844,7 +843,11 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
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
@@ -856,6 +859,10 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
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


