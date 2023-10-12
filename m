Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C2D7C6F21
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 15:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjJLN2G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjJLN2F (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 09:28:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6CB91
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697117284; x=1728653284;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KjskJTlRvAwg7tYHEzfwPBW6BTZqpZfOq3eurfH5JbM=;
  b=NqhQEJz9KLJlkEMkmQpbKRHY9A5M7oirF0EuIf+TLQeycZGoZ40qqHHq
   3tIY5E8mkGguz62SXRTnIwmOXy2w2f2rN49ju68QsJoaWGaP2wWvGB6yo
   vgeSkefw3TS4wAQVCJMorh2EnSOCVdItsgjD/hvbQ4b4JfeEjO7R/BP43
   5w9avy763wkgLKaePxVgDoh4QjzE9zi0IcrT68jsGI9WagYyhujX7CZS2
   jDi+B4UGwTYocPtxgnRsQ49jYs6VnofeVrCzyWH7jBo6WeA56/ff+Z869
   vcQ1xamAwDGBp1Ah88bfXUvaMWZmNdlsbIm5z+nzBUtnYoc4TEMSRTY6Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="365189473"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="365189473"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="1001548038"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="1001548038"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmsmga006.fm.intel.com with SMTP; 12 Oct 2023 06:28:02 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 12 Oct 2023 16:28:01 +0300
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     stable@vger.kernel.org
Subject: [PATCH] drm/i915: Retry gtt fault when out of fence register
Date:   Thu, 12 Oct 2023 16:28:01 +0300
Message-ID: <20231012132801.16292-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

If we can't find a free fence register to handle a fault in the GMADR
range just return VM_FAULT_NOPAGE without populating the PTE so that
userspace will retry the access and trigger another fault. Eventually
we should find a free fence and the fault will get properly handled.

A further improvement idea might be to reserve a fence (or one per CPU?)
for the express purpose of handling faults without having to retry. But
that would require some additional work.

Looks like this may have gotten broken originally by
commit 39965b376601 ("drm/i915: don't trash the gtt when running out of fences")
as that changed the errno to -EDEADLK which wasn't handle by the gtt
fault code either. But later in commit 2feeb52859fc ("drm/i915/gt: Fix
-EDEADLK handling regression") I changed it again to -ENOBUFS as -EDEADLK
was now getting used for the ww mutex dance. So this fix only makes
sense after that last commit.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9479
Fixes: 2feeb52859fc ("drm/i915/gt: Fix -EDEADLK handling regression")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_mman.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index aa4d842d4c5a..310654542b42 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -235,6 +235,7 @@ static vm_fault_t i915_error_to_vmf_fault(int err)
 	case 0:
 	case -EAGAIN:
 	case -ENOSPC: /* transient failure to evict? */
+	case -ENOBUFS: /* temporarily out of fences? */
 	case -ERESTARTSYS:
 	case -EINTR:
 	case -EBUSY:
-- 
2.41.0

