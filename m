Return-Path: <stable+bounces-191679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7422CC1D966
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 23:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2D2189335F
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 22:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1BC2E9EAE;
	Wed, 29 Oct 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b="iEl3lKwU"
X-Original-To: stable@vger.kernel.org
Received: from mail.waldn.net (mail.waldn.net [216.66.77.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A537A3C6
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.66.77.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776839; cv=none; b=a+b4MzXQH+ywdNOgAzJJ71/l/sqSndfqVcUhbYsNYrkvdtSSChXJrXiJyZ/14Il/TBoTUPSZ0yGj7xU+lyJlXX0mYsjhBci+DoUCeN8SFeeh6kx8yVk8KR4TX1MiDpMCRwnu3ivFIWzjHNcKEKlR9CRtRvsC9lg1xmZJSugfhHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776839; c=relaxed/simple;
	bh=pWzsGgra2cR1InXss0fOjpvM/G4pF64WrqeOAUekaIA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WXk8BU+cnBqvl2/0ZTex0OwaySu8IFMVPkllqdCwaFx3XXXqSDTkY6+A/fbi4xlH3SBshFgMgHEc5G66CbBJaMtj8JA5C4x/4ccR2HLJFKK9rvvpDH8ZnKFurGQ6nVyvHwhBT8e8xyvtveyi2uQACrOQRCf/vYpqrRzeAq9bEeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net; spf=pass smtp.mailfrom=waldn.net; dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b=iEl3lKwU; arc=none smtp.client-ip=216.66.77.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldn.net
Message-ID: <9415e0e3-77b6-4a9b-a26e-1def9e2bc5d5@waldn.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waldn.net; s=mail;
	t=1761776836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWzsGgra2cR1InXss0fOjpvM/G4pF64WrqeOAUekaIA=;
	b=iEl3lKwUCKjVjSGe/BGxbdYlWAIoZ0GJElduR+NofqusM+gxzneOqtTel7b6Jod19bQVuD
	7h3Ai1W7fTSxbkYH/TC8SU4y6pOHHKv81TPlVLlGgpuw6rJdntstr7lbudUrBonay0smQo
	pC4XkafSrZ1UfkiEvdvI2M7h1H5X3mQ=
Date: Wed, 29 Oct 2025 17:27:16 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH 3/4] wifi: ath12k: fix read pointer after free in
 ath12k_mac_assign_vif_to_vdev()
From: Amelia Crate <acrate@waldn.net>
To: stable@vger.kernel.org
Cc: dimitri.ledkov@surgut.co.uk
References: <79b19099-3791-4690-8729-de15128d79b7@waldn.net>
 <645ca90a-0f5d-44a0-985e-aa84a18c2fd1@waldn.net>
 <2fea6323-c3c9-4229-a139-39ab15e365ae@waldn.net>
Content-Language: en-US
In-Reply-To: <2fea6323-c3c9-4229-a139-39ab15e365ae@waldn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From bdf6ae776fd6536127b8765a38bfb2a96e9c7a29 Mon Sep 17 00:00:00 2001
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Tue, 10 Dec 2024 10:56:33 +0530
Subject: [PATCH 3/4] wifi: ath12k: fix read pointer after free in
 ath12k_mac_assign_vif_to_vdev()

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

-    if (arvif->is_created)
-        goto flush;
-
     if (vif->type == NL80211_IFTYPE_AP &&
         ar->num_peers > (ar->max_num_peers - 1)) {
         ath12k_warn(ab, "failed to create vdev due to insufficient peer entry resource in firmware\n");
         goto unlock;
     }

+    if (arvif->is_created)
+        goto flush;
+
     if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
         ath12k_warn(ab, "failed to create vdev, reached max vdev limit %d\n",
                 TARGET_NUM_VDEVS);
--
2.50.1

