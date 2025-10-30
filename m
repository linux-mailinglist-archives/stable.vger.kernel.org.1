Return-Path: <stable+bounces-191752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D44BC211CE
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 17:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B513D4268D3
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C930365D26;
	Thu, 30 Oct 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b="hKmsH0vO"
X-Original-To: stable@vger.kernel.org
Received: from mail.waldn.net (mail.waldn.net [216.66.77.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28783655E1
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.66.77.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840659; cv=none; b=TG/qhzT/qLLK+FGFzFAbwm9rZRlERXj0W+2wdTMo/HEnWMt3I90KgQlNmQhexIPFcjp1VKzFz4xDUq8cenyywi8NoqiIid58vP586O1oNzCcGlyEDECTqy6Hc9/HXnNkrWg7ZjarYS7nYOuN5RWrC2l3XmCtyDt8eLZWKgVckSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840659; c=relaxed/simple;
	bh=cvjMijDE44etsrDLfppH4gUBdDmDPW03PCR/Li8RmvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4ruCHMNrbyqhi/t9kq8HS+i8P9jxTHT3twjbhrDPftIMO5cErVe2dP+kEPbybOx+auZMbjf08V5m03ZlPsjQE6YO+Ij8lj2JrNMt4psFks/TUUzXDO70FKFfJGMgvSifNZ1kG/+2CdBa87bEQJlr5b1GEhyoimprQosCXsrRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net; spf=pass smtp.mailfrom=waldn.net; dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b=hKmsH0vO; arc=none smtp.client-ip=216.66.77.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldn.net
From: Amelia Crate <acrate@waldn.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waldn.net; s=mail;
	t=1761840656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCTQk1dO+iiwFTJirHH1yjKNrmtfrmYHBzl62XmQrOo=;
	b=hKmsH0vOkWTL9dOwvI++VtiAWPh615r5jOogVECz2sVDYBbySTM37iweCfBDJfeKyLXjnU
	/0nUjRrWY6qT8Y39uaHV9bjAa2ei/Pgk+EBtEmBfaSXA9TNOooTsNiqjruwF2lHRzfc43z
	LmC1u1fI4D/BHBDE92rGNEywmNf/eqU=
To: gregkh@linuxfoundation.org
Cc: dimitri.ledkov@surgut.co.uk,
	stable@vger.kernel.org,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Amelia Crate <acrate@waldn.net>
Subject: [PATCH v2 3/4] wifi: ath12k: fix read pointer after free in ath12k_mac_assign_vif_to_vdev()
Date: Thu, 30 Oct 2025 11:08:33 -0500
Message-ID: <20251030160942.19490-4-acrate@waldn.net>
In-Reply-To: <20251030160942.19490-1-acrate@waldn.net>
References: <2025103043-refinish-preformed-280e@gregkh>
 <20251030160942.19490-1-acrate@waldn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Amelia Crate <acrate@waldn.net>
---
 drivers/net/wireless/ath/ath12k/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4b3fbec397ac..c15eecf2a188 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6733,15 +6733,15 @@ static struct ath12k *ath12k_mac_assign_vif_to_vdev(struct ieee80211_hw *hw,
 
 	mutex_lock(&ar->conf_mutex);
 
-	if (arvif->is_created)
-		goto flush;
-
 	if (vif->type == NL80211_IFTYPE_AP &&
 	    ar->num_peers > (ar->max_num_peers - 1)) {
 		ath12k_warn(ab, "failed to create vdev due to insufficient peer entry resource in firmware\n");
 		goto unlock;
 	}
 
+	if (arvif->is_created)
+		goto flush;
+
 	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
 		ath12k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
 			    TARGET_NUM_VDEVS);
-- 
2.50.1


