Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA62F7A3993
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjIQTv2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbjIQTu5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:50:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995519F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:50:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D5CC433C8;
        Sun, 17 Sep 2023 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980252;
        bh=+zxxHBPprBkPfKpGfZT04Fuk/UBfcBKT1KbWid0TP1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ci5B9QwLF5Xossc/fBBMHhBnzaWszes/pxSLgEcyNGn6HQfW4No7uZO+SKEpKQiUS
         A1+JR+iR9R/Yvaz7eJ6I2PMHVA3vI5SEDP7qEtZrO0HbFzPx2s8CiE3jsOBP9i1HVv
         Nkw8OJwQtA2+g1VZyA3n6UboG0mw24vkFyNKRCGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 101/285] drm/i915: mark requests for GuC virtual engines to avoid use-after-free
Date:   Sun, 17 Sep 2023 21:11:41 +0200
Message-ID: <20230917191055.172929036@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <andrzej.hajda@intel.com>

[ Upstream commit 5eefc5307c983b59344a4cb89009819f580c84fa ]

References to i915_requests may be trapped by userspace inside a
sync_file or dmabuf (dma-resv) and held indefinitely across different
proceses. To counter-act the memory leaks, we try to not to keep
references from the request past their completion.
On the other side on fence release we need to know if rq->engine
is valid and points to hw engine (true for non-virtual requests).
To make it possible extra bit has been added to rq->execution_mask,
for marking virtual engines.

Fixes: bcb9aa45d5a0 ("Revert "drm/i915: Hold reference to intel_context over life of i915_request"")
Signed-off-by: Chris Wilson <chris.p.wilson@linux.intel.com>
Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230821153035.3903006-1-andrzej.hajda@intel.com
(cherry picked from commit 280410677af763f3871b93e794a199cfcf6fb580)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_engine_types.h      | 1 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c | 3 +++
 drivers/gpu/drm/i915/i915_request.c               | 7 ++-----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_types.h b/drivers/gpu/drm/i915/gt/intel_engine_types.h
index e99a6fa03d453..a7e6775980043 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_engine_types.h
@@ -58,6 +58,7 @@ struct i915_perf_group;
 
 typedef u32 intel_engine_mask_t;
 #define ALL_ENGINES ((intel_engine_mask_t)~0ul)
+#define VIRTUAL_ENGINES BIT(BITS_PER_TYPE(intel_engine_mask_t) - 1)
 
 struct intel_hw_status_page {
 	struct list_head timelines;
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index a0e3ef1c65d24..b5b7f2fe8c78e 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -5470,6 +5470,9 @@ guc_create_virtual(struct intel_engine_cs **siblings, unsigned int count,
 
 	ve->base.flags = I915_ENGINE_IS_VIRTUAL;
 
+	BUILD_BUG_ON(ilog2(VIRTUAL_ENGINES) < I915_NUM_ENGINES);
+	ve->base.mask = VIRTUAL_ENGINES;
+
 	intel_context_init(&ve->context, &ve->base);
 
 	for (n = 0; n < count; n++) {
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 833b73edefdbb..eb2a3000ad66b 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -134,9 +134,7 @@ static void i915_fence_release(struct dma_fence *fence)
 	i915_sw_fence_fini(&rq->semaphore);
 
 	/*
-	 * Keep one request on each engine for reserved use under mempressure
-	 * do not use with virtual engines as this really is only needed for
-	 * kernel contexts.
+	 * Keep one request on each engine for reserved use under mempressure.
 	 *
 	 * We do not hold a reference to the engine here and so have to be
 	 * very careful in what rq->engine we poke. The virtual engine is
@@ -166,8 +164,7 @@ static void i915_fence_release(struct dma_fence *fence)
 	 * know that if the rq->execution_mask is a single bit, rq->engine
 	 * can be a physical engine with the exact corresponding mask.
 	 */
-	if (!intel_engine_is_virtual(rq->engine) &&
-	    is_power_of_2(rq->execution_mask) &&
+	if (is_power_of_2(rq->execution_mask) &&
 	    !cmpxchg(&rq->engine->request_pool, NULL, rq))
 		return;
 
-- 
2.40.1



