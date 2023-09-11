Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF779BD00
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350604AbjIKVjj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240460AbjIKOov (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:44:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A67D12A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:44:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2407C433C7;
        Mon, 11 Sep 2023 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443487;
        bh=sgssh4JQHgQmfjD3RWzQs1bv1Tr5pL2rZnvx9JRwif8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4/LOPzFv/Klq1Nm7LdHewB0HY4n1+Xvh1SPQO/Gye0RO7iN1wkVKWqS0rJX1kFdt
         PJMY3LYOxARoVCRTK9LNc4W9I81pRr1JVn73J2kEirXxYaeGW4sa+LwlIKnNaW5wGQ
         Jgrt6niPmKmmVW0alIDzElEZSoYrfPH56gxqySE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Nancy.Lin" <nancy.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 367/737] drm/mediatek: Fix uninitialized symbol
Date:   Mon, 11 Sep 2023 15:43:46 +0200
Message-ID: <20230911134700.794393212@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nancy.Lin <nancy.lin@mediatek.com>

[ Upstream commit 63ee9438f2aeffb2d1b2df2599c168ca08d35025 ]

Fix Smatch static checker warning
  -Fix uninitialized symbol comp_pdev in mtk_ddp_comp_init.

Fixes: 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub driver for MT8195")
Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20230803094843.4439-1-nancy.lin@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index f114da4d36a96..771f4e1733539 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -563,14 +563,15 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 	/* Not all drm components have a DTS device node, such as ovl_adaptor,
 	 * which is the drm bring up sub driver
 	 */
-	if (node) {
-		comp_pdev = of_find_device_by_node(node);
-		if (!comp_pdev) {
-			DRM_INFO("Waiting for device %s\n", node->full_name);
-			return -EPROBE_DEFER;
-		}
-		comp->dev = &comp_pdev->dev;
+	if (!node)
+		return 0;
+
+	comp_pdev = of_find_device_by_node(node);
+	if (!comp_pdev) {
+		DRM_INFO("Waiting for device %s\n", node->full_name);
+		return -EPROBE_DEFER;
 	}
+	comp->dev = &comp_pdev->dev;
 
 	if (type == MTK_DISP_AAL ||
 	    type == MTK_DISP_BLS ||
@@ -580,7 +581,6 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 	    type == MTK_DISP_MERGE ||
 	    type == MTK_DISP_OVL ||
 	    type == MTK_DISP_OVL_2L ||
-	    type == MTK_DISP_OVL_ADAPTOR ||
 	    type == MTK_DISP_PWM ||
 	    type == MTK_DISP_RDMA ||
 	    type == MTK_DPI ||
-- 
2.40.1



