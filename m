Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5F7B8467
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 18:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjJDQBl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 12:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjJDQBi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 12:01:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0CC0
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 09:01:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E434C433C7;
        Wed,  4 Oct 2023 16:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696435294;
        bh=s8PP3vS4rQfDOamX+h4rO/bRf1YASJdH3LZ/aSm4GtM=;
        h=Subject:To:Cc:From:Date:From;
        b=Lunf6U/rMg/s1qX+cCcwAmwVFLgJl9KCT64paCYufX3ynTuqIVi6BhN6n0t8Nxh4C
         RI4vuorIXa1AmJhqf+VxtX3aFtZr/aXqZAkBe6Ft5Em23Oz/XVg87w2K9qGZmf8Puv
         0oaFn/eTcIUwjxd9VzL4Ymcs5AwS9E0XaS5Vb7dM=
Subject: FAILED: patch "[PATCH] drm/i915/gt: Fix reservation address in ggtt_reserve_guc_top" failed to apply to 5.10-stable tree
To:     devel@otheo.eu, John.C.Harrison@Intel.com,
        chris@chris-wilson.co.uk, daniele.ceraolospurio@intel.com,
        fernando.pacheco@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 18:01:27 +0200
Message-ID: <2023100427-familiar-tabasco-df57@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b7599d241778d0b10cdf7a5c755aa7db9b83250c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100427-familiar-tabasco-df57@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b7599d241778d0b10cdf7a5c755aa7db9b83250c Mon Sep 17 00:00:00 2001
From: Javier Pello <devel@otheo.eu>
Date: Sat, 2 Sep 2023 17:10:39 +0200
Subject: [PATCH] drm/i915/gt: Fix reservation address in ggtt_reserve_guc_top

There is an assertion in ggtt_reserve_guc_top that the global GTT
is of size at least GUC_GGTT_TOP, which is not the case on a 32-bit
platform; see commit 562d55d991b39ce376c492df2f7890fd6a541ffc
("drm/i915/bdw: Only use 2g GGTT for 32b platforms"). If GEM_BUG_ON
is enabled, this triggers a BUG(); if GEM_BUG_ON is disabled, the
subsequent reservation fails and the driver fails to initialise
the device:

i915 0000:00:02.0: [drm:i915_init_ggtt [i915]] Failed to reserve top of GGTT for GuC
i915 0000:00:02.0: Device initialization failed (-28)
i915 0000:00:02.0: Please file a bug on drm/i915; see https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs for details.
i915: probe of 0000:00:02.0 failed with error -28

Make the reservation at the top of the available space, whatever
that is, instead of assuming that the top will be GUC_GGTT_TOP.

Fixes: 911800765ef6 ("drm/i915/uc: Reserve upper range of GGTT")
Link: https://gitlab.freedesktop.org/drm/intel/-/issues/9080
Signed-off-by: Javier Pello <devel@otheo.eu>
Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Fernando Pacheco <fernando.pacheco@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: John Harrison <John.C.Harrison@Intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230902171039.2229126186d697dbcf62d6d8@otheo.eu
(cherry picked from commit 0f3fa942d91165c2702577e9274d2ee1c7212afc)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index dd0ed941441a..da21f2786b5d 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -511,20 +511,31 @@ void intel_ggtt_unbind_vma(struct i915_address_space *vm,
 	vm->clear_range(vm, vma_res->start, vma_res->vma_size);
 }
 
+/*
+ * Reserve the top of the GuC address space for firmware images. Addresses
+ * beyond GUC_GGTT_TOP in the GuC address space are inaccessible by GuC,
+ * which makes for a suitable range to hold GuC/HuC firmware images if the
+ * size of the GGTT is 4G. However, on a 32-bit platform the size of the GGTT
+ * is limited to 2G, which is less than GUC_GGTT_TOP, but we reserve a chunk
+ * of the same size anyway, which is far more than needed, to keep the logic
+ * in uc_fw_ggtt_offset() simple.
+ */
+#define GUC_TOP_RESERVE_SIZE (SZ_4G - GUC_GGTT_TOP)
+
 static int ggtt_reserve_guc_top(struct i915_ggtt *ggtt)
 {
-	u64 size;
+	u64 offset;
 	int ret;
 
 	if (!intel_uc_uses_guc(&ggtt->vm.gt->uc))
 		return 0;
 
-	GEM_BUG_ON(ggtt->vm.total <= GUC_GGTT_TOP);
-	size = ggtt->vm.total - GUC_GGTT_TOP;
+	GEM_BUG_ON(ggtt->vm.total <= GUC_TOP_RESERVE_SIZE);
+	offset = ggtt->vm.total - GUC_TOP_RESERVE_SIZE;
 
-	ret = i915_gem_gtt_reserve(&ggtt->vm, NULL, &ggtt->uc_fw, size,
-				   GUC_GGTT_TOP, I915_COLOR_UNEVICTABLE,
-				   PIN_NOEVICT);
+	ret = i915_gem_gtt_reserve(&ggtt->vm, NULL, &ggtt->uc_fw,
+				   GUC_TOP_RESERVE_SIZE, offset,
+				   I915_COLOR_UNEVICTABLE, PIN_NOEVICT);
 	if (ret)
 		drm_dbg(&ggtt->vm.i915->drm,
 			"Failed to reserve top of GGTT for GuC\n");

