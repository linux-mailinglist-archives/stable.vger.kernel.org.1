Return-Path: <stable+bounces-127866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F68A7ACB1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFAA179FAF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AAC27CCE8;
	Thu,  3 Apr 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbIZI58R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5B2586D9;
	Thu,  3 Apr 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707270; cv=none; b=sY0N7BpEnlPFW9irT5m3tNiMrlDzmSjuwVeF96cS7z9IEfh/g87P0lFgu7gj1krEv+rnIqXcNtzSC7UVWUY54tYdSyy2V39badvOBH1I54bqncXGikOCSHTecce76me1WFyoRLClJuoxuHvTFCOfPNKxWARon3hZ01+LMy5XcSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707270; c=relaxed/simple;
	bh=DmUNrENmIO/tvvF53YKKC/KhVFbiso1i3NPfSHucRLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HKLEnTMTfRYxvdilbx1UBZM1gVomibd5GHKsc+L2RtKt0KcMQPwlHxbF5i8XqyhzaD0TVJcjfTBOjVMeqUv5/c6t/hDHu0yFs4MFU2X9nBnWGj2AkQDRLJLUraU+NDjkcLjJlJadDEiD5Rspu8xTtS+PLIBBceXJ7/nwBRRNTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbIZI58R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFB4C4CEE3;
	Thu,  3 Apr 2025 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707270;
	bh=DmUNrENmIO/tvvF53YKKC/KhVFbiso1i3NPfSHucRLE=;
	h=From:To:Cc:Subject:Date:From;
	b=nbIZI58Rsv4ZbeCYvfZR2G0dvN/Jg0DdGUimPaFQ5y52GuujEe/z2YoEPIXeIBmCx
	 ZGQky9b2FTUPnqadR1399/5I1WxoHT8MOtkOkrBQrC6/4MfkfCxL99NlWv5YYtBtfG
	 4nL3bXdi9J+T9UQO0K8vwdjJGJ3TwYkq2ZF+ZBMk4Ca4fwxJsw37MdCpkQ8t8Qxcmg
	 j3XU08eEvTU+mz5Xt/VQIn7uM0KJqC3uybKhnDQQO09xJAMLTXx51Px/yEUGwyHOxB
	 5XteVPoobJFYLnm2cYwrGioLjUu2ZA9VptZH/3biAB9+0wXrirosi2vsKhgYCItS2i
	 IMZdaa6l6pw5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: P Praneesh <quic_ppranees@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 01/26] wifi: ath12k: Fix invalid entry fetch in ath12k_dp_mon_srng_process
Date: Thu,  3 Apr 2025 15:07:20 -0400
Message-Id: <20250403190745.2677620-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index f1e57e98bdc60..35f22a4a16cf2 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2571,7 +2571,7 @@ int ath12k_dp_mon_rx_process_stats(struct ath12k *ar, int mac_id,
 		dest_idx = 0;
 move_next:
 		ath12k_dp_mon_buf_replenish(ab, buf_ring, 1);
-		ath12k_hal_srng_src_get_next_entry(ab, srng);
+		ath12k_hal_srng_dst_get_next_entry(ab, srng);
 		num_buffs_reaped++;
 	}
 
-- 
2.39.5


