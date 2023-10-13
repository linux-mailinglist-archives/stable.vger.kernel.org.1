Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82597C8318
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjJMKcD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 06:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjJMKcA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 06:32:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE4C9
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 03:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697193119; x=1728729119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X++2G+YUqWczaUzQS65eL9UdoWL/0d4/ZPEZXAE4zGc=;
  b=i+atOeMSP/J7MSyI0ypN6BPPJRX0K49tJQyMWfypVHjV6iAzbysNP+zy
   uorL+ktz4m/6oYlTvcWro76IUX/YwaURrpzcN80SPkHnZ8eHjbX/BdqWg
   9yNE+j4N6FSEybIYP9B615nR3qXDTaYy74KTz1H4UPz1V5rPfNlkQwpI6
   JWlUFsoyw8A6/lGSjxgOI2dGLwRlLLb9NRgreeYydS95ELCYvxtvDJHMf
   Hsu6MfMLBBJMn8qvxbw5P83am6Z5X/KKTfr2M5+SkLvaV3/O5szdfxGgf
   o0s92arzCu8hanW7XPf4NQX1rTLN/y9k0Hx62h6ZbxBDxv6OasLEsZ/pe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3749858"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="3749858"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:31:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="825014124"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="825014124"
Received: from nirmoyda-desk.igk.intel.com ([10.102.138.190])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:31:49 -0700
From:   Nirmoy Das <nirmoy.das@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, Nirmoy Das <nirmoy.das@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        John Harrison <john.c.harrison@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        stable@vger.kernel.org, Matt Roper <matthew.d.roper@intel.com>
Subject: [PATCH] drm/i915: Flush WC GGTT only on required platforms
Date:   Fri, 13 Oct 2023 12:31:40 +0200
Message-ID: <20231013103140.12192-1-nirmoy.das@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Organization: Intel Deutschland GmbH, Registered Address: Am Campeon 10, 85579 Neubiberg, Germany, Commercial Register: Amtsgericht Muenchen HRB 186928 
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

gen8_ggtt_invalidate() is only needed for limitted set of platforms
where GGTT is mapped as WC otherwise this can cause unwanted
side-effects on XE_HP platforms where GFX_FLSH_CNTL_GEN6 is not
valid.

Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: John Harrison <john.c.harrison@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.2+
Suggested-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_ggtt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index 4d7d88b92632..c2858d434bce 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -197,13 +197,17 @@ void gen6_ggtt_invalidate(struct i915_ggtt *ggtt)
 
 static void gen8_ggtt_invalidate(struct i915_ggtt *ggtt)
 {
+	struct drm_i915_private *i915 = ggtt->vm.i915;
 	struct intel_uncore *uncore = ggtt->vm.gt->uncore;
 
 	/*
 	 * Note that as an uncached mmio write, this will flush the
 	 * WCB of the writes into the GGTT before it triggers the invalidate.
+	 *
+	 * Only perform this when GGTT is mapped as WC, see ggtt_probe_common().
 	 */
-	intel_uncore_write_fw(uncore, GFX_FLSH_CNTL_GEN6, GFX_FLSH_CNTL_EN);
+	if (!IS_GEN9_LP(i915) && GRAPHICS_VER(i915) < 11)
+		intel_uncore_write_fw(uncore, GFX_FLSH_CNTL_GEN6, GFX_FLSH_CNTL_EN);
 }
 
 static void guc_ggtt_invalidate(struct i915_ggtt *ggtt)
-- 
2.41.0

