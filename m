Return-Path: <stable+bounces-196816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3BFC82A3C
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 23:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B59F3ACB8E
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59733223DD6;
	Mon, 24 Nov 2025 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+0tGCZf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1669B38D
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764022777; cv=none; b=rU7VqqZX3P5vY07vqIyH4900mLuV/Ky35aNpg84+E/zKvaEe3qoG/Ka0FGnzTkHVKFpcjkJ/hCrZD35kkOu7NmvSWVgKRw2oq9toTI3i66EpeACExrok8zcMvQ9uLP1Eihv7Da8BlEWB/GXLLf1dwkliRp/G0yT89LU1xkdcBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764022777; c=relaxed/simple;
	bh=5zYJHzFik6VSQCrkdgFjc2BQvwUnAFqiKN/X/f47S7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/bMe4I8amPT+aW7tLYpGx4I46hxHhZiwV0dzM5i2UJIgx9OiKh4wW3R0hisaDbT58b2sN6KwfK4G47qRgd+I3NQeaavhDamr1pRC7U2sSK4SXO0Ptsq0MV8lEY7bFugmF02n6NNVgjbokXAJB98SRoFS/2J+rUy+aLGz+nJVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+0tGCZf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764022775; x=1795558775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5zYJHzFik6VSQCrkdgFjc2BQvwUnAFqiKN/X/f47S7w=;
  b=D+0tGCZff4HustbLw877BgmuUB2FTpN+W2X+ajcoMZAPxhJjtzcPiP4f
   52dlo+Mi93jR8EOxfKMEv8jRw1Z13HXBR3AHQ8hLC5L4KisAarBzsvj8c
   RkXXn/6Xgi59mzRrORwp92qrAWqWa3h6d6XPVMHHtPhX0NA3Pe8Sx8gRd
   kgoMVogomGYmXPxD358FDeNe9RKgB/bq+I3fkGVpH5K+pkQ9ZwkhZMl5G
   j8qyOodgxqbbI3zcUIRshSWJABhJ9pHg0GbTUtiu7Whh+GiSIjdbzV28Y
   vMJV+pG/U3uYVPoyRvg7FoaXKQ2a0/6ghc0RhqjGeZEGtWx5srdcWji3g
   Q==;
X-CSE-ConnectionGUID: 2o3AZilvTGy3Eus/eTBZHw==
X-CSE-MsgGUID: ck2Sf8qQQ4emtxrsm+5vrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="88685803"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="88685803"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 14:19:35 -0800
X-CSE-ConnectionGUID: FBaJSr4URD2dTFEN5DpcZw==
X-CSE-MsgGUID: SkbWf+WxRSGgOdvc2congw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="192460228"
Received: from osgc-linux-buildserver.sh.intel.com ([10.112.232.103])
  by orviesa007.jf.intel.com with ESMTP; 24 Nov 2025 14:19:33 -0800
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: stable@vger.kernel.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Koen Koning <koen.koning@intel.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.17.y] drm/xe: Prevent BIT() overflow when handling invalid prefetch region
Date: Mon, 24 Nov 2025 22:16:10 +0000
Message-ID: <20251124221609.718106-2-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025112407-envious-erupt-fc37@gregkh>
References: <2025112407-envious-erupt-fc37@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If user provides a large value (such as 0x80) for parameter
prefetch_mem_region_instance in vm_bind ioctl, it will cause
BIT(prefetch_region) overflow as below:
"
 ------------[ cut here ]------------
 UBSAN: shift-out-of-bounds in drivers/gpu/drm/xe/xe_vm.c:3414:7
 shift exponent 128 is too large for 64-bit type 'long unsigned int'
 CPU: 8 UID: 0 PID: 53120 Comm: xe_exec_system_ Tainted: G        W           6.18.0-rc1-lgci-xe-kernel+ #200 PREEMPT(voluntary)
 Tainted: [W]=WARN
 Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 0812 02/24/2023
 Call Trace:
  <TASK>
  dump_stack_lvl+0xa0/0xc0
  dump_stack+0x10/0x20
  ubsan_epilogue+0x9/0x40
  __ubsan_handle_shift_out_of_bounds+0x10e/0x170
  ? mutex_unlock+0x12/0x20
  xe_vm_bind_ioctl.cold+0x20/0x3c [xe]
 ...
"
Fix it by validating prefetch_region before the BIT() usage.

v2: Add Closes and Cc stable kernels. (Matt)

Reported-by: Koen Koning <koen.koning@intel.com>
Reported-by: Peter Senna Tschudin <peter.senna@linux.intel.com>
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6478
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20251112181005.2120521-2-shuicheng.lin@intel.com
(cherry picked from commit 8f565bdd14eec5611cc041dba4650e42ccdf71d9)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit d52dea485cd3c98cfeeb474cf66cf95df2ab142f)
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 30c32717a980..ed457243e907 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3475,8 +3475,8 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 				 op == DRM_XE_VM_BIND_OP_PREFETCH) ||
 		    XE_IOCTL_DBG(xe, prefetch_region &&
 				 op != DRM_XE_VM_BIND_OP_PREFETCH) ||
-		    XE_IOCTL_DBG(xe, !(BIT(prefetch_region) &
-				       xe->info.mem_region_mask)) ||
+		    XE_IOCTL_DBG(xe, prefetch_region >= (sizeof(xe->info.mem_region_mask) * 8) ||
+				 !(BIT(prefetch_region) & xe->info.mem_region_mask)) ||
 		    XE_IOCTL_DBG(xe, obj &&
 				 op == DRM_XE_VM_BIND_OP_UNMAP)) {
 			err = -EINVAL;
-- 
2.49.0


