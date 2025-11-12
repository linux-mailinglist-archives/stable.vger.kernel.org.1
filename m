Return-Path: <stable+bounces-194632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92509C53E39
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 19:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03EDB4E1DD5
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7347734575A;
	Wed, 12 Nov 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aEfziyyl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79616340D9A
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971159; cv=none; b=rpFvpjgDS3HQihOqzPaPzXzQg1BBlNHuQZT1/IJ6mS6HpGgvxsWCpbcY1nkNFukP2gWPeTGuDNeoGsKiB1JvnvWyUJUVKcphHcKYHZ7+M5ZGez4R3knk8mP0YRm1dBMoNp0g7W9TefaaHA4pQe0RXhJXUyC9nBIpE2gEDfFrhlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971159; c=relaxed/simple;
	bh=pXBpMbO7JwnkmEOYiY2bivPb05DBSARSwoGTpZiRGyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cKNkYJ5MPvVz6SxOassZ/DOaYqav6cAtaIVD13G5GEBsmORXiQkc4GiiKds78RlXD/bFVAkYy6H7uHzupF5vl6p2bUEuVGFBMPl0GXETA2ZY6//HK/lRczIz36aiXR+I21ajCjMuXcz8d1hiWyLcN1W5eIHnr4q3KUPoY9rupPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aEfziyyl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762971158; x=1794507158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pXBpMbO7JwnkmEOYiY2bivPb05DBSARSwoGTpZiRGyU=;
  b=aEfziyylsGM4tC9skhWKm6pQcpug9mkn3AxIEeIybnKbOkpbK5YuOdJV
   l2mDPPn2ni8DXgI/G/7zJG0Mw3aZCGfQmV9ok2HrAWY7o+vGWH0mxLPTL
   MrVos3mu8n4YHXewDSraiLBTUYRBSG3bRrFcysLSzqbI1H2GjEkc09NSN
   kyCXsp0G7VQhDf3SVFNtoJ/0vhNRX77sxG4wole93fEDwwdWp6YsNe086
   irME+OZOL64GBzn2vB2m9aHSyRBpzly/F9G5y8GxQA4SWpyHq40zI7d7B
   zeFywAj0DhRMpWNbnAM27s6x0g/AYXx3VrUIqf31r3qyaCgHQ9Y9ky8rG
   w==;
X-CSE-ConnectionGUID: 8SBY6PkCRCS+hntphhGSmQ==
X-CSE-MsgGUID: AMSroLwZRS+dLLMq1QIAdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64967136"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64967136"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 10:12:37 -0800
X-CSE-ConnectionGUID: c36GhNUJShWzqo0BEaTqdg==
X-CSE-MsgGUID: yaxx+PhBQhqhlwusnkxorw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189061491"
Received: from osgc-linux-buildserver.sh.intel.com ([10.112.232.103])
  by orviesa009.jf.intel.com with ESMTP; 12 Nov 2025 10:12:36 -0800
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v2] drm/xe: Prevent BIT() overflow when handling invalid prefetch region
Date: Wed, 12 Nov 2025 18:10:06 +0000
Message-ID: <20251112181005.2120521-2-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.49.0
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

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6478
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 8fb5cc6a69ec..7cac646bdf1c 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3411,8 +3411,10 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 				 op == DRM_XE_VM_BIND_OP_PREFETCH) ||
 		    XE_IOCTL_DBG(xe, prefetch_region &&
 				 op != DRM_XE_VM_BIND_OP_PREFETCH) ||
-		    XE_IOCTL_DBG(xe,  (prefetch_region != DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC &&
-				       !(BIT(prefetch_region) & xe->info.mem_region_mask))) ||
+		    XE_IOCTL_DBG(xe, (prefetch_region != DRM_XE_CONSULT_MEM_ADVISE_PREF_LOC &&
+				      /* Guard against undefined shift in BIT(prefetch_region) */
+				      (prefetch_region >= (sizeof(xe->info.mem_region_mask) * 8) ||
+				      !(BIT(prefetch_region) & xe->info.mem_region_mask)))) ||
 		    XE_IOCTL_DBG(xe, obj &&
 				 op == DRM_XE_VM_BIND_OP_UNMAP) ||
 		    XE_IOCTL_DBG(xe, (flags & DRM_XE_VM_BIND_FLAG_MADVISE_AUTORESET) &&
-- 
2.49.0


