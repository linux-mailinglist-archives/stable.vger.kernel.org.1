Return-Path: <stable+bounces-3383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C127FF559
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F87B2817C2
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06DD54FA8;
	Thu, 30 Nov 2023 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wy4iIgb/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA28524C2;
	Thu, 30 Nov 2023 16:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E543C433C7;
	Thu, 30 Nov 2023 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361692;
	bh=g0OdPbiujeXRvEvPpK+lU/3VySkgDeR8copQBOFSrx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wy4iIgb/rjmJlKk71xm0dLfkAc4ipK/X6bAIgKSWkHkEO87fVbDjsUfF49m0ATxYD
	 E9Ijrf+cayIiWBxhRbZPNyV9cpPeUig1oaypSxYslUIKHBvFOjEqs4kyvL2Q+TSL5F
	 ERgUP1ZJSKPU9/TuWY2jIqCD+fOFf0L/5O5NicVg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 10/82] drm/i915: do not clean GT table on error path
Date: Thu, 30 Nov 2023 16:21:41 +0000
Message-ID: <20231130162136.290856282@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
References: <20231130162135.977485944@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <andrzej.hajda@intel.com>

[ Upstream commit 0561794b6b642b84b879bf97061c4b4fa692839e ]

The only task of intel_gt_release_all is to zero gt table. Calling
it on error path prevents intel_gt_driver_late_release_all (called from
i915_driver_late_release) to cleanup GTs, causing leakage.
After i915_driver_late_release GT array is not used anymore so
it does not need cleaning at all.

Sample leak report:

BUG i915_request (...): Objects remaining in i915_request on __kmem_cache_shutdown()
...
Object 0xffff888113420040 @offset=64
Allocated in __i915_request_create+0x75/0x610 [i915] age=18339 cpu=1 pid=1454
 kmem_cache_alloc+0x25b/0x270
 __i915_request_create+0x75/0x610 [i915]
 i915_request_create+0x109/0x290 [i915]
 __engines_record_defaults+0xca/0x440 [i915]
 intel_gt_init+0x275/0x430 [i915]
 i915_gem_init+0x135/0x2c0 [i915]
 i915_driver_probe+0x8d1/0xdc0 [i915]

v2: removed whole intel_gt_release_all

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8489
Fixes: bec68cc9ea42 ("drm/i915: Prepare for multiple GTs")
Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231115-dont_clean_gt_on_error_path-v2-1-54250125470a@intel.com
(cherry picked from commit e899505533852bf1da133f2f4c9a9655ff77f7e5)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/intel_gt.c | 11 -----------
 drivers/gpu/drm/i915/i915_driver.c |  4 +---
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
index d12ec092e62df..91a005c46b107 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -903,8 +903,6 @@ int intel_gt_probe_all(struct drm_i915_private *i915)
 
 err:
 	i915_probe_error(i915, "Failed to initialize %s! (%d)\n", gtdef->name, ret);
-	intel_gt_release_all(i915);
-
 	return ret;
 }
 
@@ -923,15 +921,6 @@ int intel_gt_tiles_init(struct drm_i915_private *i915)
 	return 0;
 }
 
-void intel_gt_release_all(struct drm_i915_private *i915)
-{
-	struct intel_gt *gt;
-	unsigned int id;
-
-	for_each_gt(gt, i915, id)
-		i915->gt[id] = NULL;
-}
-
 void intel_gt_info_print(const struct intel_gt_info *info,
 			 struct drm_printer *p)
 {
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 75a93951fe429..be0ebed2a360f 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -901,7 +901,7 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	ret = i915_driver_mmio_probe(i915);
 	if (ret < 0)
-		goto out_tiles_cleanup;
+		goto out_runtime_pm_put;
 
 	ret = i915_driver_hw_probe(i915);
 	if (ret < 0)
@@ -959,8 +959,6 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	i915_ggtt_driver_late_release(i915);
 out_cleanup_mmio:
 	i915_driver_mmio_release(i915);
-out_tiles_cleanup:
-	intel_gt_release_all(i915);
 out_runtime_pm_put:
 	enable_rpm_wakeref_asserts(&i915->runtime_pm);
 	i915_driver_late_release(i915);
-- 
2.42.0




