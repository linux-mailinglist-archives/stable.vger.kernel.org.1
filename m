Return-Path: <stable+bounces-94665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C989D6533
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32615B23578
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D511DFE04;
	Fri, 22 Nov 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqJEAt8Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399C71DFDAE
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309675; cv=none; b=S6LbKwZV1BFbwgV2/nkvgwHZKkxWb2fXgoNum5nZX5UqVv704pTK0k2UhQm9x8DHwR7vinhXf3hsSvJEbPTHfh6ZjM1JQIwPHdfPgJs1BYkceZz1xElYMUhSzOuwdipsvM9XJDCrgcvdYeDqthxeqIELz6MM4jSkKF0iUPsAQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309675; c=relaxed/simple;
	bh=O9rr1xJx2ciHZNvmYLuHqE0cBg+3pvVvM9CBqBCOs3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNGQz3ruDcEt0ajIZhiXmZ2c8x+Qhs25tx2sMkINn+BJ7pVh5ngRpGWsMdgVybtzETQWAAF3Yibz5FfYB4VjoZSfoY8j9/uJFDRU9aM8/Bqm4HWnSfJrVGtxJfpsah9FqKaxnxVO0jK82hwaWkFPr50n0Krz3HA0cw/noQF3Dnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqJEAt8Q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309674; x=1763845674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O9rr1xJx2ciHZNvmYLuHqE0cBg+3pvVvM9CBqBCOs3c=;
  b=EqJEAt8QDaOL+jdmxRGtKRk/GJOnOvPTPjksdnOmSRd+k0gPvf0W1F0Z
   MSAwvkSszlfiCUneRsNYjR/NUQKHqH5dOa2wQq6c0hzhjGDgEs2b3Dl23
   PUC3zyEkF4Nc7xp8u3RI41mRZl5+96GEmBZcLo6lUxBEyVgfHodOnDZth
   /TcCFxBdgAwkkAFk1e9BBchj2byAp2aBPjrgsvKXHjidUa3JNim+a2z67
   05k8Luz+aB6QmniLAZItcDn/EzIP79eNbH1tE/1rJI/3eiHd44UbuKga/
   E44Aus0yfXz9goz7lZ4YUjkzrHx8FJsC2r7QDKa/05djZwo1uOaZmOGoS
   w==;
X-CSE-ConnectionGUID: bpsBg9+zQweatAqMLiQ9Xw==
X-CSE-MsgGUID: iyqOXn9WRkO/tYDHJgbKuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878285"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878285"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:44 -0800
X-CSE-ConnectionGUID: AfG0zn0oSX+ZAY2A5uX73Q==
X-CSE-MsgGUID: W6HMDA1VRyeRajkWvLI5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457294"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:44 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 28/31] drm/xe/display: Do not do intel_fbdev_set_suspend during runtime
Date: Fri, 22 Nov 2024 13:07:16 -0800
Message-ID: <20241122210719.213373-29-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suraj Kandpal <suraj.kandpal@intel.com>

commit 5422d30957570b0f0283f8ad4d0dd45637c11db7 upstream.

Do not do intel_fbdev_set_suspend during runtime_suspend/resume
functions. This cause a big circular lock_dep splat.

kworker/0:4/198 is trying to acquire lock:
<4> [77.185594] ffffffff83398500 (console_lock){+.+.}-{0:0}, at:
intel_fbdev_set_suspend+0x169/0x1f0 [xe]
<4> [77.185947]
but task is already holding lock:
<4> [77.185949] ffffffffa09e9460
(xe_pm_runtime_lockdep_map){+.+.}-{0:0}, at:
xe_pm_runtime_suspend+0x51/0x3f0 [xe]
<4> [77.186262]
which lock already depends on the new lock.
<4> [77.186264]
the existing dependency chain (in reverse order) is:
<4> [77.186266]
-> #2 (xe_pm_runtime_lockdep_map){+.+.}-{0:0}:
<4> [77.186276]        pm_runtime_lockdep_prime+0x2f/0x50 [xe]
<4> [77.186572]        xe_pm_runtime_resume_and_get+0x29/0x90 [xe]
<4> [77.186867]        intelfb_create+0x150/0x390 [xe]
<4> [77.187197]
__drm_fb_helper_initial_config_and_unlock+0x31c/0x5e0 [drm_kms_helper]
<4> [77.187243]        drm_fb_helper_initial_config+0x3d/0x50
[drm_kms_helper]
<4> [77.187274]        intel_fbdev_client_hotplug+0xb1/0x140 [xe]
<4> [77.187603]        drm_client_register+0x87/0xd0 [drm]
<4> [77.187704]        intel_fbdev_setup+0x51c/0x640 [xe]
<4> [77.188033]        intel_display_driver_register+0xb7/0xf0 [xe]
<4> [77.188438]        xe_display_register+0x21/0x40 [xe]
<4> [77.188809]        xe_device_probe+0xa8d/0xbf0 [xe]
<4> [77.189035]        xe_pci_probe+0x333/0x5b0 [xe]
<4> [77.189330]        local_pci_probe+0x48/0xb0
<4> [77.189341]        pci_device_probe+0xc8/0x280
<4> [77.189351]        really_probe+0xf8/0x390
<4> [77.189362]        __driver_probe_device+0x8a/0x170
<4> [77.189373]        driver_probe_device+0x23/0xb0

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240912012545.702032-3-suraj.kandpal@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 5aeb672f329de..b778b9748aceb 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -316,7 +316,9 @@ static void __xe_display_pm_suspend(struct xe_device *xe, bool runtime)
 	 * properly.
 	 */
 	intel_power_domains_disable(xe);
-	intel_fbdev_set_suspend(&xe->drm, FBINFO_STATE_SUSPENDED, true);
+	if (!runtime)
+		intel_fbdev_set_suspend(&xe->drm, FBINFO_STATE_SUSPENDED, true);
+
 	if (!runtime && has_display(xe)) {
 		drm_kms_helper_poll_disable(&xe->drm);
 		intel_display_driver_disable_user_access(xe);
@@ -413,7 +415,8 @@ static void __xe_display_pm_resume(struct xe_device *xe, bool runtime)
 
 	intel_opregion_resume(xe);
 
-	intel_fbdev_set_suspend(&xe->drm, FBINFO_STATE_RUNNING, false);
+	if (!runtime)
+		intel_fbdev_set_suspend(&xe->drm, FBINFO_STATE_RUNNING, false);
 
 	intel_power_domains_enable(xe);
 }
-- 
2.47.0


