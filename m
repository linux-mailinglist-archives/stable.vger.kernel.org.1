Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F340E7588C0
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 00:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjGRWx1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 18:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjGRWx0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 18:53:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E948B1988
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 15:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689720782; x=1721256782;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5P7XMGZuIUy64clFPdCVpDqC90apgKwgNWXho8jASWY=;
  b=LtWc/3OXqOnQ5EGDAr98XeRu+A+/jP4jSUTZLY+PlrpMKPz4NnjP/7hY
   jbvTB4HfmUEbhZehMEn/0pNPgZxCAFRAaE7JwjrUH30k2RYxlivs+p1wu
   Tmorw4ebhdTAlO9R2Ma9eGbBr1Rb5SV7f4i6oH6ypv0aTy0JW2SZuaNib
   CXJ7aZIQOzPguFkA6xGtHa3nnPkd5trM5dHiNsgKrRrbZC9ipWIMBVKlL
   Pz36PKvpSMZvdsU1TWoRBW6nyoJVaMlFkOys8D4wIcwQhT4R2C2NBDJm6
   00teNuqz2a6PfgFJEozWo1WwarlJhh3iXMIQSNfHSEUHGpCJ0vrttOYBB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="452705853"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="452705853"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 15:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847852003"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="847852003"
Received: from invictus.jf.intel.com ([10.165.21.201])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 15:52:50 -0700
From:   Radhakrishna Sripada <radhakrishna.sripada@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Fei Yang <fei.yang@intel.com>
Subject: [PATCH v2] drm/i915/dpt: Use shmem for dpt objects
Date:   Tue, 18 Jul 2023 15:51:18 -0700
Message-Id: <20230718225118.2562132-1-radhakrishna.sripada@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dpt objects that are created from internal get evicted when there is
memory pressure and do not get restored when pinned during scanout. The
pinned page table entries look corrupted and programming the display
engine with the incorrect pte's result in DE throwing pipe faults.

Create DPT objects from shmem and mark the object as dirty when pinning so
that the object is restored when shrinker evicts an unpinned buffer object.

v2: Unconditionally mark the dpt objects dirty during pinning(Chris).

Fixes: 0dc987b699ce ("drm/i915/display: Add smem fallback allocation for dpt")
Cc: <stable@vger.kernel.org> # v6.0+
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Suggested-by: Chris Wilson <chris.p.wilson@intel.com>
Signed-off-by: Fei Yang <fei.yang@intel.com>
Signed-off-by: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dpt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpt.c b/drivers/gpu/drm/i915/display/intel_dpt.c
index 7c5fddb203ba..fbfd8f959f17 100644
--- a/drivers/gpu/drm/i915/display/intel_dpt.c
+++ b/drivers/gpu/drm/i915/display/intel_dpt.c
@@ -166,6 +166,8 @@ struct i915_vma *intel_dpt_pin(struct i915_address_space *vm)
 		i915_vma_get(vma);
 	}
 
+	dpt->obj->mm.dirty = true;
+
 	atomic_dec(&i915->gpu_error.pending_fb_pin);
 	intel_runtime_pm_put(&i915->runtime_pm, wakeref);
 
@@ -261,7 +263,7 @@ intel_dpt_create(struct intel_framebuffer *fb)
 		dpt_obj = i915_gem_object_create_stolen(i915, size);
 	if (IS_ERR(dpt_obj) && !HAS_LMEM(i915)) {
 		drm_dbg_kms(&i915->drm, "Allocating dpt from smem\n");
-		dpt_obj = i915_gem_object_create_internal(i915, size);
+		dpt_obj = i915_gem_object_create_shmem(i915, size);
 	}
 	if (IS_ERR(dpt_obj))
 		return ERR_CAST(dpt_obj);
-- 
2.34.1

