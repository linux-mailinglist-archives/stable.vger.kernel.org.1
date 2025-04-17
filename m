Return-Path: <stable+bounces-134171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CEDA929EF
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E9D3A18AD
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D304256C60;
	Thu, 17 Apr 2025 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QNP02n5q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F39254B12;
	Thu, 17 Apr 2025 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915309; cv=none; b=JnHxSSVtEiAwsVolS5tZ6sMMaMVNveWRiDoRTBh0o6y2joqrtIEj2Jpf05Z0GJ17RUlP7WAi1FrUtZ/pZY13UUbGTBxmeZfr9xjkMx9AFxOy8HzwoQcRMBl/BkXtJ2w3/GDHKC/OQgwR+airmrByI8gZ8EO06eGH2k/eT9yPZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915309; c=relaxed/simple;
	bh=OsvkAwksqZzVKmy+tBjOHWiDw4KBtpfs3WmDliXnlVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWdSZDm1SOIGby9eHU5VSNXlrTuFfeshtWZVuDfX74oUjHVXfOgfbnPyr0R01h4J62cxrimLVty80LFOOVFMvmCh7+52kFmR6h8kYaIaQuTIADNv66H97r7JoMBIVg0XLpIBm277jMrxJpLaj/DIfzWT19LyuHl40aCvhsf6gQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QNP02n5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335DCC4CEE4;
	Thu, 17 Apr 2025 18:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915308;
	bh=OsvkAwksqZzVKmy+tBjOHWiDw4KBtpfs3WmDliXnlVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QNP02n5qsFb1gZFydrUywICGCANzZm22pBldZ5mehQMpoZMkvZsssm5slr7VTJv1C
	 UH0yvXsdn5eU13fuHOmWl68wU8CYV77vUAQPwyIlGNU5rYbUUJ8nAnKbCUoMpq9Gxo
	 EgFAGLg4x8FdAnxuSj8BdhHnBq4cojnkjgtslZN0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	P Praneesh <quic_ppranees@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 085/393] wifi: ath12k: Fix invalid entry fetch in ath12k_dp_mon_srng_process
Date: Thu, 17 Apr 2025 19:48:14 +0200
Message-ID: <20250417175111.019326590@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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




