Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBABB77588C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjHIKxr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjHIKxe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9943C16
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:51:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1762F63130
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2881FC433C7;
        Wed,  9 Aug 2023 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578279;
        bh=OL6ODWb1lVgr9XUOo8zv/7g9MB93FpiJUlNyL41Y//0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOqSRTD8KEXs63W+EpMXIH0Qv3RoFTlVlHxclZDKeFI4I9yz9NFJZacXC9SH84BYh
         5EPBGDHKz/1eIk+5nDgzpCzfybRR23bapUnuudrwwFNWMHE4M5c1DuILcBBnbNImNd
         zzfRFqNBjJg+OtR9w/Ahv05h1JdF08FB0AwDL4rE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 161/165] drm/i915/gt: Add workaround 14016712196
Date:   Wed,  9 Aug 2023 12:41:32 +0200
Message-ID: <20230809103648.049848823@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Tejas Upadhyay <tejas.upadhyay@intel.com>

[ Upstream commit d922b80b1010cd6164fa7d3c197b4fbf94b47beb ]

For mtl, workaround suggests that, SW insert a
dummy PIPE_CONTROL prior to PIPE_CONTROL which
contains a post sync: Timestamp or Write Immediate.

Bspec: 72197

V5:
  - Remove ret variable - Andi
V4:
  - Update commit message, avoid returing cs - Andi/Matt
V3:
  - Wrap dummy pipe control stuff in API - Andi
V2:
  - Fix  kernel test robot warnings

Closes: https://lore.kernel.org/oe-kbuild-all/202305121525.3EWdGoBY-lkp@intel.com/
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230601110959.1715927-1-tejas.upadhyay@intel.com
Stable-dep-of: 592b228f12e1 ("drm/i915/gt: Rename flags with bit_group_X according to the datasheet")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 6e914c3f5019a..6210b38a2d382 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -189,6 +189,27 @@ u32 *gen12_emit_aux_table_inv(struct intel_gt *gt, u32 *cs, const i915_reg_t inv
 	return cs;
 }
 
+static int mtl_dummy_pipe_control(struct i915_request *rq)
+{
+	/* Wa_14016712196 */
+	if (IS_MTL_GRAPHICS_STEP(rq->engine->i915, M, STEP_A0, STEP_B0) ||
+	    IS_MTL_GRAPHICS_STEP(rq->engine->i915, P, STEP_A0, STEP_B0)) {
+		u32 *cs;
+
+		/* dummy PIPE_CONTROL + depth flush */
+		cs = intel_ring_begin(rq, 6);
+		if (IS_ERR(cs))
+			return PTR_ERR(cs);
+		cs = gen12_emit_pipe_control(cs,
+					     0,
+					     PIPE_CONTROL_DEPTH_CACHE_FLUSH,
+					     LRC_PPHWSP_SCRATCH_ADDR);
+		intel_ring_advance(rq, cs);
+	}
+
+	return 0;
+}
+
 int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 {
 	struct intel_engine_cs *engine = rq->engine;
@@ -199,8 +220,13 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 	 */
 	if (mode & EMIT_FLUSH || gen12_needs_ccs_aux_inv(engine)) {
 		u32 flags = 0;
+		int err;
 		u32 *cs;
 
+		err = mtl_dummy_pipe_control(rq);
+		if (err)
+			return err;
+
 		flags |= PIPE_CONTROL_TILE_CACHE_FLUSH;
 		flags |= PIPE_CONTROL_FLUSH_L3;
 		flags |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
@@ -233,6 +259,11 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 	if (mode & EMIT_INVALIDATE) {
 		u32 flags = 0;
 		u32 *cs, count;
+		int err;
+
+		err = mtl_dummy_pipe_control(rq);
+		if (err)
+			return err;
 
 		flags |= PIPE_CONTROL_COMMAND_CACHE_INVALIDATE;
 		flags |= PIPE_CONTROL_TLB_INVALIDATE;
@@ -749,6 +780,13 @@ u32 *gen12_emit_fini_breadcrumb_rcs(struct i915_request *rq, u32 *cs)
 		     PIPE_CONTROL_DC_FLUSH_ENABLE |
 		     PIPE_CONTROL_FLUSH_ENABLE);
 
+	/* Wa_14016712196 */
+	if (IS_MTL_GRAPHICS_STEP(i915, M, STEP_A0, STEP_B0) ||
+	    IS_MTL_GRAPHICS_STEP(i915, P, STEP_A0, STEP_B0))
+		/* dummy PIPE_CONTROL + depth flush */
+		cs = gen12_emit_pipe_control(cs, 0,
+					     PIPE_CONTROL_DEPTH_CACHE_FLUSH, 0);
+
 	if (GRAPHICS_VER(i915) == 12 && GRAPHICS_VER_FULL(i915) < IP_VER(12, 50))
 		/* Wa_1409600907 */
 		flags |= PIPE_CONTROL_DEPTH_STALL;
-- 
2.40.1



