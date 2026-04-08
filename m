Return-Path: <stable+bounces-234454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKmyJpCg1mlDGwgAu9opvQ
	(envelope-from <stable+bounces-234454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:38:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 088DF3C120D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67CFF31895ED
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641533D75C3;
	Wed,  8 Apr 2026 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dWRSSpDN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276673B0ADA;
	Wed,  8 Apr 2026 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672902; cv=none; b=on54or6lwLKq2yINU70KbGLNNMRfBsLEAVuVu0mHGnhpKEG0R/IIv3yKKIF9hooVYoVNZlH7cLAE/2dgHXU9Kc0I55gWx2GVjp61t7LgFpSTm+OWt01JzTaLPaifDaniYBS+q1FMFQ+JOgZ0Za31TPsyrODrmntayoHhju5Unr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672902; c=relaxed/simple;
	bh=kEp2KuphSHk2RFYvTF+bhDqCMyo2m9/jKtweOBKadDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGU4e75VNAj4ACneNEstNpglUDlP6ueS5VzSZVBHdPp6w/LZHTZzaXD0FegDhLQ6/qCGCJPRIyyn3WbjGBtYImFzLLFcaCPvDCljoMQ3BSHRMP/o6MSPG6vQXbJf3uGxy5z+eW1Gb9+fIN7b3gEBjpx1q5rQjsSqERzvmF7V3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dWRSSpDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFBAC19421;
	Wed,  8 Apr 2026 18:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672901;
	bh=kEp2KuphSHk2RFYvTF+bhDqCMyo2m9/jKtweOBKadDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWRSSpDNyIlo5Bf8FuO8MVzZpP97G5zvJUDWPu5RNag6EcAWlxIMxC4Q4eVp+h0+W
	 jPyFPly73m5GVYvXslHyhJSYpJFVrtyS8dVOKDl2T8BSt1ITno0CZRXC3LwezguhTP
	 1OKi5ipzNi+loiDMu+8YoaNZedjipzXM1fuslA9c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 024/277] wifi: ath11k: Pass the correct value of each TID during a stop AMPDU session
Date: Wed,  8 Apr 2026 20:00:09 +0200
Message-ID: <20260408175934.755876937@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234454-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 088DF3C120D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>

[ Upstream commit e225b36f83d7926c1f2035923bb0359d851fdb73 ]

During ongoing traffic, a request to stop an AMPDU session
for one TID could incorrectly affect other active sessions.
This can happen because an incorrect TID reference would be
passed when updating the BA session state, causing the wrong
session to be stopped. As a result, the affected session would
be reduced to a minimal BA size, leading to a noticeable
throughput degradation.

Fix this issue by passing the correct argument from
ath11k_dp_rx_ampdu_stop() to ath11k_peer_rx_tid_reo_update()
during a stop AMPDU session. Instead of passing peer->tx_tid, which
is the base address of the array, corresponding to TID 0; pass
the value of &peer->rx_tid[params->tid], where the different TID numbers
are accounted for.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f2895 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20260319065608.2408179-1-reshma.rajkumar@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index b9e976ddcbbf6..44eea682c297b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/ieee80211.h>
@@ -1110,9 +1110,8 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_peer *peer;
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(params->sta);
+	struct dp_rx_tid *rx_tid;
 	int vdev_id = arsta->arvif->vdev_id;
-	dma_addr_t paddr;
-	bool active;
 	int ret;
 
 	spin_lock_bh(&ab->base_lock);
@@ -1124,15 +1123,14 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
 		return -ENOENT;
 	}
 
-	paddr = peer->rx_tid[params->tid].paddr;
-	active = peer->rx_tid[params->tid].active;
+	rx_tid = &peer->rx_tid[params->tid];
 
-	if (!active) {
+	if (!rx_tid->active) {
 		spin_unlock_bh(&ab->base_lock);
 		return 0;
 	}
 
-	ret = ath11k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
+	ret = ath11k_peer_rx_tid_reo_update(ar, peer, rx_tid, 1, 0, false);
 	spin_unlock_bh(&ab->base_lock);
 	if (ret) {
 		ath11k_warn(ab, "failed to update reo for rx tid %d: %d\n",
@@ -1141,7 +1139,8 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
 	}
 
 	ret = ath11k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id,
-						     params->sta->addr, paddr,
+						     params->sta->addr,
+						     rx_tid->paddr,
 						     params->tid, 1, 1);
 	if (ret)
 		ath11k_warn(ab, "failed to send wmi to delete rx tid %d\n",
-- 
2.53.0




