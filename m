Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331BE7126DA
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjEZMmF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 08:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEZMmE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 08:42:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9AEBC
        for <stable@vger.kernel.org>; Fri, 26 May 2023 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685104922; x=1716640922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iHnTy+rGdynPSN2oUg3l6ddZoSKYljpn1oATVCjWczE=;
  b=GUu/KAnldw3CGBOeU8QM+GGb32TQX6suDG6zpWGcA/+vf7ex06mqoUYl
   kzfRiffWqS4Tu6AXcW2ewhF5934yZVMSSF08KZjGDPn7a/v9gZGug7nN/
   D7i/lDpNARXMebQCELTD8vhKnINIcfsZdraDzUiLmhBhUKAs7AmPR7Fwd
   DJF2BLdygHjMNulv6Z90T0tukDoPJeADhEedJORa+yuVT1HoGMD3KJ5Me
   do8RmtPk881AY12oxzER4qhA6lgPWTYoNOg4dMHgyY0KhhbXGLuO7JnA0
   ZsDhQlDMOWITti/egtvnfldvy94ELNB240tBe2yfeUKsw/ws/7T4A5Fcn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="353034626"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="353034626"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 05:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="795079654"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="795079654"
Received: from schoenfm-mobl1.ger.corp.intel.com (HELO intel.com) ([10.249.39.253])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 05:41:59 -0700
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Intel GFX <intel-gfx@lists.freedesktop.org>,
        DRI Devel <dri-devel@lists.freedesktop.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Chris Wilson <chris@chris-wilson.co.uk>, stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Use the correct error value when kernel_context() fails
Date:   Fri, 26 May 2023 14:41:38 +0200
Message-Id: <20230526124138.2006110-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.40.1
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

kernel_context() returns an error pointer. Use pointer-error
conversion functions to evaluate its return value, rather than
checking for a '0' return.

Fixes: eb5c10cbbc2f ("drm/i915: Remove I915_USER_PRIORITY_SHIFT")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Chris Wilson < chris@chris-wilson.co.uk>
Cc: <stable@vger.kernel.org> # v5.13+
---
 drivers/gpu/drm/i915/gt/selftest_execlists.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 736b89a8ecf54..4202df5b8c122 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -1530,8 +1530,8 @@ static int live_busywait_preempt(void *arg)
 	struct drm_i915_gem_object *obj;
 	struct i915_vma *vma;
 	enum intel_engine_id id;
-	int err = -ENOMEM;
 	u32 *map;
+	int err;
 
 	/*
 	 * Verify that even without HAS_LOGICAL_RING_PREEMPTION, we can
@@ -1539,13 +1539,17 @@ static int live_busywait_preempt(void *arg)
 	 */
 
 	ctx_hi = kernel_context(gt->i915, NULL);
-	if (!ctx_hi)
-		return -ENOMEM;
+	if (IS_ERR(ctx_hi))
+		return PTR_ERR(ctx_hi);
+
 	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
 
 	ctx_lo = kernel_context(gt->i915, NULL);
-	if (!ctx_lo)
+	if (IS_ERR(ctx_lo)) {
+		err = PTR_ERR(ctx_lo);
 		goto err_ctx_hi;
+	}
+
 	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
 
 	obj = i915_gem_object_create_internal(gt->i915, PAGE_SIZE);
-- 
2.40.1

