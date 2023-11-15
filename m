Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8B7ECBFF
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjKOT0S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjKOT0E (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5182ED7A
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B2DC433C8;
        Wed, 15 Nov 2023 19:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076359;
        bh=BKRDddobva2IywubQIZ58zMG5BliFBhg5krg+y8XcQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvKLxDVEZLrN0KiyqUWfe/vZ4ZwkOP9KR8JQQ2M/plVmn6e21/ZbjjLIXWdCY7hUV
         K0it7pKgXObg8TP+riaDzLxpt7WSFiexp0O4xATDQatrirWy3ZlzJcgOdHvmcNNs9O
         kDh7ZFmxQnSIbn6jxEjyyN+5MvrZDOFwHKtYcqZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 241/550] drm/mediatek: Fix iommu fault by swapping FBs after updating plane state
Date:   Wed, 15 Nov 2023 14:13:45 -0500
Message-ID: <20231115191617.423099353@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason-JH.Lin <jason-jh.lin@mediatek.com>

[ Upstream commit 3ec71e05ae6e7f46512e568ed81c92be589003dd ]

According to the comment in drm_atomic_helper_async_commit(),
we should make sure FBs have been swapped, so that cleanups in the
new_state performs a cleanup in the old FB.

So we should move swapping FBs after calling mtk_plane_update_new_state(),
to avoid using the old FB which could be freed.

Fixes: 1a64a7aff8da ("drm/mediatek: Fix cursor plane no update")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20230809125722.24112-2-jason-jh.lin@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index 308fe7e8106d1..a46f23cde29a0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -231,9 +231,9 @@ static void mtk_plane_atomic_async_update(struct drm_plane *plane,
 	plane->state->src_y = new_state->src_y;
 	plane->state->src_h = new_state->src_h;
 	plane->state->src_w = new_state->src_w;
-	swap(plane->state->fb, new_state->fb);
 
 	mtk_plane_update_new_state(new_state, new_plane_state);
+	swap(plane->state->fb, new_state->fb);
 	wmb(); /* Make sure the above parameters are set before update */
 	new_plane_state->pending.async_dirty = true;
 	mtk_drm_crtc_async_update(new_state->crtc, plane, state);
-- 
2.42.0



