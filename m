Return-Path: <stable+bounces-127822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B5A7AC21
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0507917D1F6
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AE52698A0;
	Thu,  3 Apr 2025 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZwEADBH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8488D269899;
	Thu,  3 Apr 2025 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707166; cv=none; b=Qe4T55h2f4oWdP+k9hL1NwBKu7zJxXOfueEi1SwCfZTgaN8Ozw3fJ4Cv8NwMI8Os0DUAtV692HFqgVSdurat7X6pxCBuKGGtdk85q+snYWqjUCykqMPmGCXr2AwTMNAPMaD5pW1eaqrpUoasDRb/qdqCXPbm8CuKJvzXZvwVRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707166; c=relaxed/simple;
	bh=gHL983/4Paj9RUeaojNW1KJ40fSB9x+SqPIDpBipqS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VuiCgbSkjJDLF9dwDyDx7D51qaLEFEcT4KUvBo7t544jJhSgqCeQvKoSF4ZtiPrEsiaDa9fta4ioPYickAnwqRQ8DFjImeF39BbcarkxEkZeD9I1ZVnL1iyswvwbDC6cXHE/sNRBAjNMDb6EA/bbrLmSLRJJpoolvj+KxQm5VuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZwEADBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2855DC4CEE8;
	Thu,  3 Apr 2025 19:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707166;
	bh=gHL983/4Paj9RUeaojNW1KJ40fSB9x+SqPIDpBipqS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZwEADBHdWwVHJmhDx9A6TTCCSRAdopqk8EtLs07q14YiECGwqBiAXVhXd30MEOEP
	 sFHPranqZ9EfbP/fGLcKrB1CvVHvhUgJd5yQ6QLKPhB0mQ2NKfVYl3UYisY4Pg2G4b
	 bkXczulmnAgXDHy6uxZLyDQ/heukxHQU998iIpssB8vPtC9+1DrnEe6g3762wL5a8e
	 yWGnrjFezicq3sNgvsDSWVSkrw53lJS0Dlb9CvIcWc1xKURahhrr9Nb57cX1Ke/hu5
	 VaMSjQr/cHFKngweOPY6QB5ZOQLP6jzZV2IkF8mX/nGrP3557dB2ZIVEF/HLCdCGjH
	 g4LyHXTvmRbFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: P Praneesh <quic_ppranees@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 04/47] wifi: ath12k: Fix invalid entry fetch in ath12k_dp_mon_srng_process
Date: Thu,  3 Apr 2025 15:05:12 -0400
Message-Id: <20250403190555.2677001-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: P Praneesh <quic_ppranees@quicinc.com>

[ Upstream commit 63fdc4509bcf483e79548de6bc08bf3c8e504bb3 ]

Currently, ath12k_dp_mon_srng_process uses ath12k_hal_srng_src_get_next_entry
to fetch the next entry from the destination ring. This is incorrect because
ath12k_hal_srng_src_get_next_entry is intended for source rings, not destination
rings. This leads to invalid entry fetches, causing potential data corruption or
crashes due to accessing incorrect memory locations. This happens because the
source ring and destination ring have different handling mechanisms and using
the wrong function results in incorrect pointer arithmetic and ring management.

To fix this issue, replace the call to ath12k_hal_srng_src_get_next_entry with
ath12k_hal_srng_dst_get_next_entry in ath12k_dp_mon_srng_process. This ensures
that the correct function is used for fetching entries from the destination
ring, preventing invalid memory accesses.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Link: https://patch.msgid.link/20241223060132.3506372-7-quic_ppranees@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 5c6749bc4039d..1706ec27eb9c0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2533,7 +2533,7 @@ int ath12k_dp_mon_rx_process_stats(struct ath12k *ar, int mac_id,
 		dest_idx = 0;
 move_next:
 		ath12k_dp_mon_buf_replenish(ab, buf_ring, 1);
-		ath12k_hal_srng_src_get_next_entry(ab, srng);
+		ath12k_hal_srng_dst_get_next_entry(ab, srng);
 		num_buffs_reaped++;
 	}
 
-- 
2.39.5


