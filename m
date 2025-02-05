Return-Path: <stable+bounces-112786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC120A28E67
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9123A252F
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE9F1547E9;
	Wed,  5 Feb 2025 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ns89Dd3H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEFF14A088;
	Wed,  5 Feb 2025 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764749; cv=none; b=r8CCyv3M8oWuQ1k1r4VJtGRQAG6VB5ySJow58djwxsdqZRiIMdmXTRTuw2WCLhcwNYYmKa1ydZQeLu1y+llX2vqSwGDf/t+HAY5ckY31ddDOWWXzBR5Sc7mFMcx+NR9iNvLyhMVufDE/v35/h2gl5qYUfQTGGyLI4I+fdsj4cDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764749; c=relaxed/simple;
	bh=c8zwyVes9rkRIsoguMk/JD598gizJNzyUfaCfsqEhng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlKzIrO14sSQ4c3FvKUyTEZ2Ok8Ht8fGRHAQJwUwPOAigZ43CGzKI1CBH4egCwAdegpQWiYwq+tUajKItnNuUZkBMe2PUMdI0MQzyJ/m9cG2DFbJtnbJJrZTPgqOBfcotpOs0sbvzKsZizEehe43wUDwK1Kedj+XdG+0MG3ZHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ns89Dd3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0C6C4CED1;
	Wed,  5 Feb 2025 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764748;
	bh=c8zwyVes9rkRIsoguMk/JD598gizJNzyUfaCfsqEhng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ns89Dd3Hy5U2N6tV3q9w4b0FDKaj2DGnQIUIlv4k3NOWwy0XEKzgFcMz15oGEts20
	 gWYtN1t4CnMkxUcmFNWecyvBqr1HzhGrLWwoZlJ/B8wwJyvBwqygDwVOuFwMCBwyhJ
	 Kf3WmqjGuvbQd3gxFnyWq44rzxnMQo5mGj3dsTL4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 110/623] wifi: ath12k: fix read pointer after free in ath12k_mac_assign_vif_to_vdev()
Date: Wed,  5 Feb 2025 14:37:32 +0100
Message-ID: <20250205134500.423396951@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

[ Upstream commit 5a10971c7645a95f5d5dc23c26fbac4bf61801d0 ]

In ath12k_mac_assign_vif_to_vdev(), if arvif is created on a different
radio, it gets deleted from that radio through a call to
ath12k_mac_unassign_link_vif(). This action frees the arvif pointer.
Subsequently, there is a check involving arvif, which will result in a
read-after-free scenario.

Fix this by moving this check after arvif is again assigned via call to
ath12k_mac_assign_link_vif().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Closes: https://scan5.scan.coverity.com/#/project-view/63541/10063?selectedIssue=1636423
Fixes: b5068bc9180d ("wifi: ath12k: Cache vdev configs before vdev create")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20241210-read_after_free-v1-1-969f69c7d66c@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d493ec812055f..cf4f4245f6068 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7173,9 +7173,6 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 
 	ab = ar->ab;
 
-	if (arvif->is_created)
-		goto flush;
-
 	/* Assign arvif again here since previous radio switch block
 	 * would've unassigned and cleared it.
 	 */
@@ -7186,6 +7183,9 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 		goto unlock;
 	}
 
+	if (arvif->is_created)
+		goto flush;
+
 	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
 		ath12k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
 			    TARGET_NUM_VDEVS);
-- 
2.39.5




