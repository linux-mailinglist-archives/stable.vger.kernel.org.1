Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EB87619F7
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 15:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGYN37 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 09:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjGYN36 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 09:29:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5F8E6D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 06:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690291797; x=1721827797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7PaAeH1auRhSSbzeWKOgTSpHq7Ypc+OO1v7czgix8lU=;
  b=MAct05XbW+o6xP5GhoHEL0w9DqkMo/GABVlPyVfm+gpgPyhUaUYzUyp3
   bC+lDk5exVO5C6CQn3rNVzx4gOEcQJH/cPsUSLV+5l12V7KyS/LcY8e3G
   ewNpZ+J82a1LviS3KHvw1owPuET883aaWYUFqpAt6S6UIW+Xuehniditm
   z+y/ODZzt+HJb57UT0Ir+w1h7mEKtjHipYtPD/R8PxjcSaJQVNz0lYHYb
   Jkeyc9WhcDn+Bs2rKgtBEq+RkbxFv+D/rELSh835hreXypu0xvOfDB3ql
   X1s5YRFXa/ul2GgIwPLtwWH8s+bq1gqWeoE0zEFYV0OdJmkEB3tECh8rq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="454101877"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="454101877"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 06:29:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="761216135"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761216135"
Received: from grdarcy-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.228.4])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 06:29:55 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        stable@vger.kernel.org, Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v2] drm/i915: Avoid GGTT flushing on non-GGTT paths of i915_vma_pin_iomap
Date:   Tue, 25 Jul 2023 14:29:46 +0100
Message-Id: <20230725132946.1539075-1-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724125633.1490543-1-tvrtko.ursulin@linux.intel.com>
References: <20230724125633.1490543-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Commit 4bc91dbde0da ("drm/i915/lmem: Bypass aperture when lmem is available")
added a code path which does not map via GGTT, but was still setting the
ggtt write bit, and so triggering the GGTT flushing.

Fix it by not setting that bit unless the GGTT mapping path was used, and
replace the flush with wmb() in i915_vma_flush_writes().

This also works for the i915_gem_object_pin_map path added in
d976521a995a ("drm/i915: extend i915_vma_pin_iomap()").

It is hard to say if the fix has any observable effect, given that the
write-combine buffer gets flushed from intel_gt_flush_ggtt_writes too, but
apart from code clarity, skipping the needless GGTT flushing could be
beneficial on platforms with non-coherent GGTT. (See the code flow in
intel_gt_flush_ggtt_writes().)

v2:
 * Improve comment in i915_vma_flush_writes(). (Andi)

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Fixes: 4bc91dbde0da ("drm/i915/lmem: Bypass aperture when lmem is available")
References: d976521a995a ("drm/i915: extend i915_vma_pin_iomap()")
Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Cc: <stable@vger.kernel.org> # v5.14+
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_vma.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index ffb425ba591c..7788b03b86d6 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -602,7 +602,9 @@ void __iomem *i915_vma_pin_iomap(struct i915_vma *vma)
 	if (err)
 		goto err_unpin;
 
-	i915_vma_set_ggtt_write(vma);
+	if (!i915_gem_object_is_lmem(vma->obj) &&
+	    i915_vma_is_map_and_fenceable(vma))
+		i915_vma_set_ggtt_write(vma);
 
 	/* NB Access through the GTT requires the device to be awake. */
 	return page_mask_bits(ptr);
@@ -615,8 +617,19 @@ void __iomem *i915_vma_pin_iomap(struct i915_vma *vma)
 
 void i915_vma_flush_writes(struct i915_vma *vma)
 {
+	/*
+	 * i915_vma_iomap() could have mapped the underlying memory in one
+	 * of the three ways, depending on which we have to choose the most
+	 * appropriate flushing mechanism.
+	 *
+	 * If the mapping method was via the aperture the appropriate flag will
+	 * be set via i915_vma_set_ggtt_write(), and if not then we know it is
+	 * enough to simply flush the CPU side write-combine buffer.
+	 */
 	if (i915_vma_unset_ggtt_write(vma))
 		intel_gt_flush_ggtt_writes(vma->vm->gt);
+	else
+		wmb();
 }
 
 void i915_vma_unpin_iomap(struct i915_vma *vma)
-- 
2.39.2

