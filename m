Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60907A7FBF
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjITMaO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbjITMaD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:30:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC82183
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:29:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD88C433C7;
        Wed, 20 Sep 2023 12:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212997;
        bh=W6in0XI+5vF9msbKg6jM5qufyql9DCkRU09nw/+xggM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p7z+yCljCcxulYj1usikxzLK9F3Q25YqNVpOXzhaPI+qV161RV9/S/uf3RKJHC6Bj
         WNnnGSjjgw3U9FPI21cvalBZDeArtuUNjeDNuZ2LSXkod3OmDn2Ol0oUFVTflCbbPV
         0sHrSEJwydny5SnELwIONEz5QdukJ/zCsvF6Rcng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        CK Hu <ck.hu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 122/367] drm/mediatek: Fix potential memory leak if vmap() fail
Date:   Wed, 20 Sep 2023 13:28:19 +0200
Message-ID: <20230920112901.811304840@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sui Jingfeng <suijingfeng@loongson.cn>

[ Upstream commit 379091e0f6d179d1a084c65de90fa44583b14a70 ]

Also return -ENOMEM if such a failure happens, the implement should take
responsibility for the error handling.

Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap function")
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20230706134000.130098-1-suijingfeng@loongson.cn/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 2fa432287d690..e51394982efb6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -267,7 +267,11 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 	}
 	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
 			       pgprot_writecombine(PAGE_KERNEL));
-
+	if (!mtk_gem->kvaddr) {
+		kfree(sgt);
+		kfree(mtk_gem->pages);
+		return -ENOMEM;
+	}
 out:
 	kfree(sgt);
 
-- 
2.40.1



