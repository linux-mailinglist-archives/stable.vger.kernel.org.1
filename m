Return-Path: <stable+bounces-154071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A641ADD7BC
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882322C6F53
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0E32F2354;
	Tue, 17 Jun 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mx2v9M7q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA82EF2A6;
	Tue, 17 Jun 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178010; cv=none; b=bk3UsrrvOUyOKVwIYjp+3uYVTethR7nlRZgJ2SRfIn6KWgH5jeZA4FTRwMEN6SfIrHMuoA2KgBsZE8AwZq8Q7y7nAMyV0r1/M8JaWoc10ZTx2a9pgR10lJhc7RiC0LEO2nF5/6EJczuMODwTbtz7/x5nJueEMKMa37PHsVD7lRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178010; c=relaxed/simple;
	bh=7SmktlSpiYZWBRrBmuvcy7WOFovlq7a79dl3lJ4Y0s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+obiPDnBq4+9Ntm7JW27+jml7jhkEeX5qt2A/NO92AFKTvdL3Q16UXDMx7RPC24eJkJBxr8tmKIDTOBS+jjVF4jHBa2zMYJpJN0JePVSOpd4RfCy3s85XSCVmjCVYC8R+V5BARINCH8R7vQLOmrVEjCi8NGWAzuPDt3aiHydO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mx2v9M7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE777C4CEE3;
	Tue, 17 Jun 2025 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178010;
	bh=7SmktlSpiYZWBRrBmuvcy7WOFovlq7a79dl3lJ4Y0s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mx2v9M7q+QPVifnWikznL8P8M6bN5AzECg7THYHVcwNypHUaPQH91QwNmpM6qJC79
	 Av7pTZorciJ17i7Lg4Dh1JRuEfPJoFo6C9YKy0EFlPJtlTEHbkuGh/jAPLamaZ5WWG
	 dFH/GAENL9iU/DTH6oDIUVr66R3ubxjNpwDJHjVA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Kalle Valo <kvalo@kernel.org>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 431/512] wifi: ath11k: dont use static variables in ath11k_debugfs_fw_stats_process()
Date: Tue, 17 Jun 2025 17:26:37 +0200
Message-ID: <20250617152437.037036599@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 2bcf73b2612dda7432f2c2eaad6679bd291791f2 ]

Currently ath11k_debugfs_fw_stats_process() is using static variables to count
firmware stat events. Taking num_vdev as an example, if for whatever reason (
say ar->num_started_vdevs is 0 or firmware bug etc.) the following condition

	(++num_vdev) == total_vdevs_started

is not met, is_end is not set thus num_vdev won't be cleared. Next time when
firmware stats is requested again, even if everything is working fine, we will
fail due to the condition above will never be satisfied.

The same applies to num_bcn as well.

Change to use non-static counters so that we have a chance to clear them each
time firmware stats is requested. Currently only ath11k_fw_stats_request() and
ath11k_debugfs_fw_stats_request() are requesting firmware stats, so clear
counters there.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Fixes: da3a9d3c1576 ("ath11k: refactor debugfs code into debugfs.c")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250220082448.31039-3-quic_bqiang@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.h    |  2 ++
 drivers/net/wireless/ath/ath11k/debugfs.c | 16 +++++++---------
 drivers/net/wireless/ath/ath11k/mac.c     |  2 ++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index bbf2ccfee3fc0..fcdec14eb3cfa 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -599,6 +599,8 @@ struct ath11k_fw_stats {
 	struct list_head pdevs;
 	struct list_head vdevs;
 	struct list_head bcn;
+	u32 num_vdev_recvd;
+	u32 num_bcn_recvd;
 };
 
 struct ath11k_dbg_htt_stats {
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 1d03e3aab011d..27c93c0b4c223 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -98,6 +98,8 @@ static void ath11k_debugfs_fw_stats_reset(struct ath11k *ar)
 	spin_lock_bh(&ar->data_lock);
 	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
 	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
+	ar->fw_stats.num_vdev_recvd = 0;
+	ar->fw_stats.num_bcn_recvd = 0;
 	spin_unlock_bh(&ar->data_lock);
 }
 
@@ -106,7 +108,6 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_pdev *pdev;
 	bool is_end;
-	static unsigned int num_vdev, num_bcn;
 	size_t total_vdevs_started = 0;
 	int i;
 
@@ -131,15 +132,14 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 				total_vdevs_started += ar->num_started_vdevs;
 		}
 
-		is_end = ((++num_vdev) == total_vdevs_started);
+		is_end = ((++ar->fw_stats.num_vdev_recvd) == total_vdevs_started);
 
 		list_splice_tail_init(&stats->vdevs,
 				      &ar->fw_stats.vdevs);
 
-		if (is_end) {
+		if (is_end)
 			complete(&ar->fw_stats_done);
-			num_vdev = 0;
-		}
+
 		return;
 	}
 
@@ -151,15 +151,13 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 		/* Mark end until we reached the count of all started VDEVs
 		 * within the PDEV
 		 */
-		is_end = ((++num_bcn) == ar->num_started_vdevs);
+		is_end = ((++ar->fw_stats.num_bcn_recvd) == ar->num_started_vdevs);
 
 		list_splice_tail_init(&stats->bcn,
 				      &ar->fw_stats.bcn);
 
-		if (is_end) {
+		if (is_end)
 			complete(&ar->fw_stats_done);
-			num_bcn = 0;
-		}
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 78c825244613b..9159ee20a33b8 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9332,6 +9332,8 @@ static int ath11k_fw_stats_request(struct ath11k *ar,
 
 	spin_lock_bh(&ar->data_lock);
 	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
+	ar->fw_stats.num_vdev_recvd = 0;
+	ar->fw_stats.num_bcn_recvd = 0;
 	spin_unlock_bh(&ar->data_lock);
 
 	reinit_completion(&ar->fw_stats_complete);
-- 
2.39.5




