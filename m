Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A07775879
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjHIKxH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjHIKvc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889C42706
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D2BB63126
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BA0C433C9;
        Wed,  9 Aug 2023 10:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578248;
        bh=feLQySvwu0wxk7o6rmeceHGz43t0uldhn1T2ZYJD+AU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoFJXKu59hy047IAbvXg8/nVROq2NsfPOvZShCKw21zaFWK954Jy0FqasyfDq/Poz
         tH5eU7dA1RtEd5CdfMoT4eUw22Cell5i9iG8zdm5F84Ykw8uYKRJdoAxPuPktI2QzZ
         1GysgmsECTNdLqFhKcNS18M2tyOwCrKCHRT1ifN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 6.4 130/165] drm/i915/gt: Cleanup aux invalidation registers
Date:   Wed,  9 Aug 2023 12:41:01 +0200
Message-ID: <20230809103647.072825010@linuxfoundation.org>
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

From: Andi Shyti <andi.shyti@linux.intel.com>

commit d14560ac1b595aa2e792365e91fea6aeaee66c2b upstream.

Fix the 'NV' definition postfix that is supposed to be INV.

Take the chance to also order properly the registers based on
their address and call the GEN12_GFX_CCS_AUX_INV address as
GEN12_CCS_AUX_INV like all the other similar registers.

Remove also VD1, VD3 and VE1 registers that don't exist and add
BCS0 and CCS0.

Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230725001950.1014671-2-andi.shyti@linux.intel.com
(cherry picked from commit 2f0b927d3ca3440445975ebde27f3df1c3ed6f76)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c |    8 ++++----
 drivers/gpu/drm/i915/gt/intel_gt_regs.h  |   16 ++++++++--------
 drivers/gpu/drm/i915/gt/intel_lrc.c      |    6 +++---
 3 files changed, 15 insertions(+), 15 deletions(-)

--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -256,8 +256,8 @@ int gen12_emit_flush_rcs(struct i915_req
 
 		if (!HAS_FLAT_CCS(rq->engine->i915)) {
 			/* hsdes: 1809175790 */
-			cs = gen12_emit_aux_table_inv(rq->engine->gt,
-						      cs, GEN12_GFX_CCS_AUX_NV);
+			cs = gen12_emit_aux_table_inv(rq->engine->gt, cs,
+						      GEN12_CCS_AUX_INV);
 		}
 
 		*cs++ = preparser_disable(false);
@@ -317,10 +317,10 @@ int gen12_emit_flush_xcs(struct i915_req
 	if (aux_inv) { /* hsdes: 1809175790 */
 		if (rq->engine->class == VIDEO_DECODE_CLASS)
 			cs = gen12_emit_aux_table_inv(rq->engine->gt,
-						      cs, GEN12_VD0_AUX_NV);
+						      cs, GEN12_VD0_AUX_INV);
 		else
 			cs = gen12_emit_aux_table_inv(rq->engine->gt,
-						      cs, GEN12_VE0_AUX_NV);
+						      cs, GEN12_VE0_AUX_INV);
 	}
 
 	if (mode & EMIT_INVALIDATE)
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -331,9 +331,11 @@
 #define GEN8_PRIVATE_PAT_HI			_MMIO(0x40e0 + 4)
 #define GEN10_PAT_INDEX(index)			_MMIO(0x40e0 + (index) * 4)
 #define BSD_HWS_PGA_GEN7			_MMIO(0x4180)
-#define GEN12_GFX_CCS_AUX_NV			_MMIO(0x4208)
-#define GEN12_VD0_AUX_NV			_MMIO(0x4218)
-#define GEN12_VD1_AUX_NV			_MMIO(0x4228)
+
+#define GEN12_CCS_AUX_INV			_MMIO(0x4208)
+#define GEN12_VD0_AUX_INV			_MMIO(0x4218)
+#define GEN12_VE0_AUX_INV			_MMIO(0x4238)
+#define GEN12_BCS0_AUX_INV			_MMIO(0x4248)
 
 #define GEN8_RTCR				_MMIO(0x4260)
 #define GEN8_M1TCR				_MMIO(0x4264)
@@ -341,14 +343,12 @@
 #define GEN8_BTCR				_MMIO(0x426c)
 #define GEN8_VTCR				_MMIO(0x4270)
 
-#define GEN12_VD2_AUX_NV			_MMIO(0x4298)
-#define GEN12_VD3_AUX_NV			_MMIO(0x42a8)
-#define GEN12_VE0_AUX_NV			_MMIO(0x4238)
-
 #define BLT_HWS_PGA_GEN7			_MMIO(0x4280)
 
-#define GEN12_VE1_AUX_NV			_MMIO(0x42b8)
+#define GEN12_VD2_AUX_INV			_MMIO(0x4298)
+#define GEN12_CCS0_AUX_INV			_MMIO(0x42c8)
 #define   AUX_INV				REG_BIT(0)
+
 #define VEBOX_HWS_PGA_GEN7			_MMIO(0x4380)
 
 #define GEN12_AUX_ERR_DBG			_MMIO(0x43f4)
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -1367,7 +1367,7 @@ gen12_emit_indirect_ctx_rcs(const struct
 	/* hsdes: 1809175790 */
 	if (!HAS_FLAT_CCS(ce->engine->i915))
 		cs = gen12_emit_aux_table_inv(ce->engine->gt,
-					      cs, GEN12_GFX_CCS_AUX_NV);
+					      cs, GEN12_CCS_AUX_INV);
 
 	/* Wa_16014892111 */
 	if (IS_DG2(ce->engine->i915))
@@ -1394,10 +1394,10 @@ gen12_emit_indirect_ctx_xcs(const struct
 	if (!HAS_FLAT_CCS(ce->engine->i915)) {
 		if (ce->engine->class == VIDEO_DECODE_CLASS)
 			cs = gen12_emit_aux_table_inv(ce->engine->gt,
-						      cs, GEN12_VD0_AUX_NV);
+						      cs, GEN12_VD0_AUX_INV);
 		else if (ce->engine->class == VIDEO_ENHANCEMENT_CLASS)
 			cs = gen12_emit_aux_table_inv(ce->engine->gt,
-						      cs, GEN12_VE0_AUX_NV);
+						      cs, GEN12_VE0_AUX_INV);
 	}
 
 	return cs;


