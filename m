Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828227E669C
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 10:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjKIJXh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 04:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjKIJXf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 04:23:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A687D26B1
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 01:23:31 -0800 (PST)
X-UUID: a20d5a787ee111ee8051498923ad61e6-20231109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LwLaIgMGWJSJFkr+2QiUxV9wT496qyWwMkmiQeFkrzA=;
        b=rERHYmIozZ1rCB1noFAxfJ4LODHp35Rs2ZPtpRppIvWD7+uxVxQHPj1zJw205RVk8RvCv79W7BiKr2g0vMPSGlqfDGMa6Zlp96JJxh4OiFLnSK5xFjC7sIR5wPUfUgpnZIlzna1HczODK0LnrnsOWsknBwM3MtlpQ1lLmN99xSk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:9bd332f3-fe0f-4f40-8c70-8c5d431f7243,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:366256fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a20d5a787ee111ee8051498923ad61e6-20231109
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <stuart.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 61062969; Thu, 09 Nov 2023 17:23:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 9 Nov 2023 17:23:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 9 Nov 2023 17:23:23 +0800
From:   Stuart Lee <stuart.lee@mediatek.com>
To:     Stuart Lee <stuart.lee@mediatek.com>
CC:     <stable@vger.kernel.org>
Subject: [PATCH 1/1] drm/mediatek: Fix access violation in mtk_drm_crtc_dma_dev_get
Date:   Thu, 9 Nov 2023 17:23:17 +0800
Message-ID: <20231109092317.9046-2-stuart.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231109092317.9046-1-stuart.lee@mediatek.com>
References: <20231109092317.9046-1-stuart.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Add error handling to check NULL input in
mtk_drm_crtc_dma_dev_get function.

While display path is not configured correctly, none of crtc is
established. So the caller of mtk_drm_crtc_dma_dev_get may pass
input parameter *crtc as NULL, Which may cause coredump when
we try to get the container of NULL pointer.

Fixes: cb1d6bcca542 ("drm/mediatek: Add dma dev get function")
Signed-off-by: Stuart Lee <stuart.lee@mediatek.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index c277b9fae950..047c9a31d306 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -921,7 +921,14 @@ static int mtk_drm_crtc_init_comp_planes(struct drm_device *drm_dev,
 
 struct device *mtk_drm_crtc_dma_dev_get(struct drm_crtc *crtc)
 {
-	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	struct mtk_drm_crtc *mtk_crtc = NULL;
+
+	if (!crtc)
+		return NULL;
+
+	mtk_crtc = to_mtk_crtc(crtc);
+	if (!mtk_crtc)
+		return NULL;
 
 	return mtk_crtc->dma_dev;
 }
-- 
2.18.0

