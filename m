Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC925775D50
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjHILgF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjHILgE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317BD1FD2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:36:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B193763515
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB11FC433C8;
        Wed,  9 Aug 2023 11:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580963;
        bh=7iVtdQOXVNuAZZ8zJA6u6WZZEjRDGGgfPcy9t4San+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OlM79G2AWfaEaeMxuignBh5scHGrGpCW2qdhk2XfVSk3L3SabYBUEy9uZ+RbyEVLc
         BQeLApZxnrIl3HKPUNJioOk0V2wahSnNc/0JyUb5bRxHGRNcaWjrssRMNErcSGyxlK
         L5oGHIefDePiCkeS2Um71P/ttd6a7WmtIxJN+LZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Huang Rui <ray.huang@amd.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 017/201] drm/ttm: add ttm_bo_pin()/ttm_bo_unpin() v2
Date:   Wed,  9 Aug 2023 12:40:19 +0200
Message-ID: <20230809103644.406751041@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit deb0814b43f370a448a498409d949e38c9d8f02e ]

As an alternative to the placement flag add a
pin count to the ttm buffer object.

v2: add dma_resv_assert_help() calls

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Link: https://patchwork.freedesktop.org/patch/391596/?series=81973&rev=1
Stable-dep-of: a2848d08742c ("drm/ttm: never consider pinned BOs for eviction&swap")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c      |  9 ++++++---
 drivers/gpu/drm/ttm/ttm_bo_util.c |  2 +-
 include/drm/ttm/ttm_bo_api.h      | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index f673292eec9db..9a05caec3c996 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -115,7 +115,7 @@ static void ttm_bo_add_mem_to_lru(struct ttm_buffer_object *bo,
 	struct ttm_bo_device *bdev = bo->bdev;
 	struct ttm_resource_manager *man;
 
-	if (!list_empty(&bo->lru))
+	if (!list_empty(&bo->lru) || bo->pin_count)
 		return;
 
 	if (mem->placement & TTM_PL_FLAG_NO_EVICT)
@@ -165,7 +165,8 @@ void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo,
 	ttm_bo_del_from_lru(bo);
 	ttm_bo_add_mem_to_lru(bo, &bo->mem);
 
-	if (bulk && !(bo->mem.placement & TTM_PL_FLAG_NO_EVICT)) {
+	if (bulk && !(bo->mem.placement & TTM_PL_FLAG_NO_EVICT) &&
+	    !bo->pin_count) {
 		switch (bo->mem.mem_type) {
 		case TTM_PL_TT:
 			ttm_bo_bulk_move_set_pos(&bulk->tt[bo->priority], bo);
@@ -544,8 +545,9 @@ static void ttm_bo_release(struct kref *kref)
 		 * shrinkers, now that they are queued for
 		 * destruction.
 		 */
-		if (bo->mem.placement & TTM_PL_FLAG_NO_EVICT) {
+		if (bo->mem.placement & TTM_PL_FLAG_NO_EVICT || bo->pin_count) {
 			bo->mem.placement &= ~TTM_PL_FLAG_NO_EVICT;
+			bo->pin_count = 0;
 			ttm_bo_del_from_lru(bo);
 			ttm_bo_add_mem_to_lru(bo, &bo->mem);
 		}
@@ -1174,6 +1176,7 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 	bo->moving = NULL;
 	bo->mem.placement = TTM_PL_FLAG_CACHED;
 	bo->acc_size = acc_size;
+	bo->pin_count = 0;
 	bo->sg = sg;
 	if (resv) {
 		bo->base.resv = resv;
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index fb2a25f8408fc..1968df9743fcb 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -352,7 +352,6 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 		return -ENOMEM;
 
 	fbo->base = *bo;
-	fbo->base.mem.placement |= TTM_PL_FLAG_NO_EVICT;
 
 	ttm_bo_get(bo);
 	fbo->bo = bo;
@@ -372,6 +371,7 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
 	kref_init(&fbo->base.kref);
 	fbo->base.destroy = &ttm_transfered_destroy;
 	fbo->base.acc_size = 0;
+	fbo->base.pin_count = 1;
 	if (bo->type != ttm_bo_type_sg)
 		fbo->base.base.resv = &fbo->base.base._resv;
 
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 0f7cd21d6d748..33aca60870e26 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -157,6 +157,7 @@ struct ttm_buffer_object {
 
 	struct dma_fence *moving;
 	unsigned priority;
+	unsigned pin_count;
 
 	/**
 	 * Special members that are protected by the reserve lock
@@ -606,6 +607,31 @@ static inline bool ttm_bo_uses_embedded_gem_object(struct ttm_buffer_object *bo)
 	return bo->base.dev != NULL;
 }
 
+/**
+ * ttm_bo_pin - Pin the buffer object.
+ * @bo: The buffer object to pin
+ *
+ * Make sure the buffer is not evicted any more during memory pressure.
+ */
+static inline void ttm_bo_pin(struct ttm_buffer_object *bo)
+{
+	dma_resv_assert_held(bo->base.resv);
+	++bo->pin_count;
+}
+
+/**
+ * ttm_bo_unpin - Unpin the buffer object.
+ * @bo: The buffer object to unpin
+ *
+ * Allows the buffer object to be evicted again during memory pressure.
+ */
+static inline void ttm_bo_unpin(struct ttm_buffer_object *bo)
+{
+	dma_resv_assert_held(bo->base.resv);
+	WARN_ON_ONCE(!bo->pin_count);
+	--bo->pin_count;
+}
+
 int ttm_mem_evict_first(struct ttm_bo_device *bdev,
 			struct ttm_resource_manager *man,
 			const struct ttm_place *place,
-- 
2.39.2



