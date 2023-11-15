Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58607ED643
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjKOVwp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344426AbjKOUz7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:55:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C68199
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:55:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78375C4E77A;
        Wed, 15 Nov 2023 20:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081752;
        bh=mZM0VtMtVRl6zSItFeUwlqmORu8G/qcb0ClwBlbbYJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pr7x2h+nHp9ewaNQaWabxbDI2ElcntJ9TOIClY8KUczoexnB6QLe6m3QypC0Qi2W3
         q+3NkaQ3lyca722Jk2F5jAajNbNyzH39W0mERU6CZwrrq4HbMOzaJ9Y6CyG558BdB2
         9TiJ+Q5poBoMcCT9zgX4k47YPl+DfkeYEmwzolpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 078/191] drm/rockchip: Fix type promotion bug in rockchip_gem_iommu_map()
Date:   Wed, 15 Nov 2023 15:45:53 -0500
Message-ID: <20231115204649.278031047@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 6471da5ee311d53ef46eebcb7725bc94266cc0cf ]

The "ret" variable is declared as ssize_t and it can hold negative error
codes but the "rk_obj->base.size" variable is type size_t.  This means
that when we compare them, they are both type promoted to size_t and the
negative error code becomes a high unsigned value and is treated as
success.  Add a cast to fix this.

Fixes: 38f993b7c59e ("drm/rockchip: Do not use DMA mapping API if attached to IOMMU domain")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/2bfa28b5-145d-4b9e-a18a-98819dd686ce@moroto.mountain
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 22ff4a5929768..6038aafa29c68 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -38,7 +38,7 @@ static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
 
 	ret = iommu_map_sgtable(private->domain, rk_obj->dma_addr, rk_obj->sgt,
 				prot);
-	if (ret < rk_obj->base.size) {
+	if (ret < (ssize_t)rk_obj->base.size) {
 		DRM_ERROR("failed to map buffer: size=%zd request_size=%zd\n",
 			  ret, rk_obj->base.size);
 		ret = -ENOMEM;
-- 
2.42.0



