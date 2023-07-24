Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9D75F7AB
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 15:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGXNBG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 09:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjGXNAn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 09:00:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815E446AB
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 05:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690203498; x=1721739498;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cKQb0hHyw62+3w8EDhb99A3vugN+bsNLMvCSG6tr08s=;
  b=UGgCu5fnnIGQOi8aAetmLu6refWSe/abj1ZGGrU4T76j95oyWGWDXUyb
   2xWQfKwIOAJql7XEkDISrGWRux+CswAls5Hsx2qo8yeHO85YLStT+7z61
   jhwk3X6kpLfI0yzNB1UwsYITdnzqMSwGDAUCAQWz/bIJRQ4pT8+vSoA53
   9eS0gh5LYgBd7GMunY8dtRxkpV2LskmYfhYRR6sEhsnjT9xbnN4Rdfuaa
   lzzaUSN2BIEPTrZn4+B4/QNeXf8J0fgWHSZ2khH3H6A/h4LQHACViKkhJ
   H1cmNka1tiiRE821qnKRtmZ4BRIsoqqJr+5jQKhtU0I95bLAt6vhzX0pf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="370099780"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="370099780"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 05:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="849625005"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="849625005"
Received: from srichara-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.209.170.186])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 05:56:42 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] drm/i915: Avoid GGTT flushing on non-GGTT paths of i915_vma_pin_iomap
Date:   Mon, 24 Jul 2023 13:56:33 +0100
Message-Id: <20230724125633.1490543-1-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Fixes: 4bc91dbde0da ("drm/i915/lmem: Bypass aperture when lmem is available")
References: d976521a995a ("drm/i915: extend i915_vma_pin_iomap()")
Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Cc: <stable@vger.kernel.org> # v5.14+
---
 drivers/gpu/drm/i915/i915_vma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index ffb425ba591c..f2b626cd2755 100644
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
@@ -617,6 +619,8 @@ void i915_vma_flush_writes(struct i915_vma *vma)
 {
 	if (i915_vma_unset_ggtt_write(vma))
 		intel_gt_flush_ggtt_writes(vma->vm->gt);
+	else
+		wmb(); /* Just flush the write-combine buffer. */
 }
 
 void i915_vma_unpin_iomap(struct i915_vma *vma)
-- 
2.39.2

