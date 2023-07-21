Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A8E75CE1B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjGUQSP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjGUQRj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:17:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57A5420C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689956194; x=1721492194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hZuqDw8u5XUELkTIg6kS0e/Vt2YOXLPzzyCYT2IeBxY=;
  b=ErbAJvj4JelwtIZAZkpTPENlxob8OnmiYgFK5atYeNcN54E9DTF8OybJ
   0ZG/4TIwfAltLoDo65wFu7i4PRQs8QCqdJo1uok/aznA4zVdt8A8NxgGQ
   L0omnXCwVzy1qcw73Od8YNWKhZCw/cNh+/sjLt7TQ/4Xh0vBCeuRtKjDE
   Kw5Z8osB3L6C3Lyr67Jy32GYvnpdSmSwM4s8MzoiaYH+u9+vP5BF3kjzy
   8YowukHPMCjf37djxvdb+7/RC+Qf1gAFi3mradtWWkidRltUuxvQXbVsP
   1etcUFBCsrRLpCzEVPF14uwlWlV4n7mslJyoUo9a6IIJZNgE/qGy+rFx8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="433292028"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="433292028"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="675095430"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="675095430"
Received: from hbockhor-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.54.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:15:55 -0700
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-evel <dri-devel@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v8 5/9] drm/i915/gt: Enable the CCS_FLUSH bit in the pipe control
Date:   Fri, 21 Jul 2023 18:15:10 +0200
Message-Id: <20230721161514.818895-6-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721161514.818895-1-andi.shyti@linux.intel.com>
References: <20230721161514.818895-1-andi.shyti@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Enable the CCS_FLUSH bit 13 in the control pipe for render and
compute engines in platforms starting from Meteor Lake (BSPEC
43904 and 47112).

Fixes: 972282c4cf24 ("drm/i915/gen12: Add aux table invalidate for all engines")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c     | 7 +++++++
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 5d2175e918dd2..139a7e69f5c4d 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -230,6 +230,13 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 
 		bit_group_0 |= PIPE_CONTROL0_HDC_PIPELINE_FLUSH;
 
+		/*
+		 * When required, in MTL and beyond platforms we
+		 * need to set the CCS_FLUSH bit in the pipe control
+		 */
+		if (GRAPHICS_VER_FULL(rq->i915) >= IP_VER(12, 70))
+			bit_group_0 |= PIPE_CONTROL_CCS_FLUSH;
+
 		bit_group_1 |= PIPE_CONTROL_TILE_CACHE_FLUSH;
 		bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
 		bit_group_1 |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
diff --git a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
index 5d143e2a8db03..5df7cce23197c 100644
--- a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
+++ b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
@@ -299,6 +299,7 @@
 #define   PIPE_CONTROL_QW_WRITE				(1<<14)
 #define   PIPE_CONTROL_POST_SYNC_OP_MASK                (3<<14)
 #define   PIPE_CONTROL_DEPTH_STALL			(1<<13)
+#define   PIPE_CONTROL_CCS_FLUSH			(1<<13) /* MTL+ */
 #define   PIPE_CONTROL_WRITE_FLUSH			(1<<12)
 #define   PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH	(1<<12) /* gen6+ */
 #define   PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE	(1<<11) /* MBZ on ILK */
-- 
2.40.1

