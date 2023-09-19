Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBBA7A61A6
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 13:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjISLrr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 07:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLrr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 07:47:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE41BA
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695124061; x=1726660061;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EZCE6lNO/5ZK4xDLwMtsiXiVPZzBD8iQ9YtFYhFBliY=;
  b=jTHwmJFbrV5ej0Qs3speg14014WGnIUoPijiymW/q1Aktgod5URokfp9
   kVgUx/DS8FlhFz/vb1iHSP8rmjc7g+J4VfgiqEBW94J3IPwq9k+msNUCY
   tXfw83FM9wI1dbMLR/jNIG1Ec14pEIHA5JjAfva5J38yeExM8TbonrwFt
   NMOGE635lsygQTch//goDONpLq/VWc3lBiT4GUHhhB90USAo5OQED3hSW
   vNl0YAs3JSV1AanSG79IXj1LG35o37Yd7wHMqvxqkElXNyuuWuskVDAlg
   dEYtXo9ueCKhAizoi68WdQIr/B6iqLWs3R1Z8k50jp+v9aD11FaMyNcVh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="410847281"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="410847281"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 04:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="861506893"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="861506893"
Received: from nirmoyda-desk.igk.intel.com ([10.102.138.190])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 04:47:38 -0700
From:   Nirmoy Das <nirmoy.das@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, Nirmoy Das <nirmoy.das@intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        stable@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
Subject: [PATCH] drm/i915: Fix aux invalidation with proper pipe_control flag
Date:   Tue, 19 Sep 2023 13:47:16 +0200
Message-ID: <20230919114716.19378-1-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928 
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The suggestion from the spec is to do l3 fabric flush not L3 flush.

Fixes: 78a6ccd65fa3 ("drm/i915/gt: Ensure memory quiesced before
invalidation")
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c     | 6 +++++-
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 0143445dba83..a4b241d502c8 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -272,7 +272,11 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 			bit_group_0 |= PIPE_CONTROL_CCS_FLUSH;
 
 		bit_group_1 |= PIPE_CONTROL_TILE_CACHE_FLUSH;
-		bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
+		if (mode & EMIT_FLUSH)
+			bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
+		else if (gen12_needs_ccs_aux_inv(engine))
+			bit_group_1 |= PIPE_CONTROL_L3_FABRIC_FLUSH;
+
 		bit_group_1 |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
 		bit_group_1 |= PIPE_CONTROL_DEPTH_CACHE_FLUSH;
 		/* Wa_1409600907:tgl,adl-p */
diff --git a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
index 2bd8d98d2110..12e8dc481c53 100644
--- a/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
+++ b/drivers/gpu/drm/i915/gt/intel_gpu_commands.h
@@ -284,6 +284,7 @@
 #define   DISPLAY_PLANE_A           (0<<20)
 #define   DISPLAY_PLANE_B           (1<<20)
 #define GFX_OP_PIPE_CONTROL(len)	((0x3<<29)|(0x3<<27)|(0x2<<24)|((len)-2))
+#define   PIPE_CONTROL_L3_FABRIC_FLUSH			(1<<30)
 #define   PIPE_CONTROL_COMMAND_CACHE_INVALIDATE		(1<<29) /* gen11+ */
 #define   PIPE_CONTROL_TILE_CACHE_FLUSH			(1<<28) /* gen11+ */
 #define   PIPE_CONTROL_FLUSH_L3				(1<<27)
-- 
2.41.0

