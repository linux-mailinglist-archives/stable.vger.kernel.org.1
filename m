Return-Path: <stable+bounces-196821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 186CFC82B9E
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 23:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C7654EA64F
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3266233A018;
	Mon, 24 Nov 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tuhpqw+r"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13955339B52
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023468; cv=none; b=oXg65Xc6cc+iFK9npFdaFsbCKEuSIZGJK2gZdIHDlddf0PlcguI72jeJM+ck9/Mxsh94Y9NpfR/+/L9cgR/etzIVKjMhoB9d07KxCveIf26oSgnKkltwEWyt1rt/ka1EK2tpZbF4x5/4U/aoV9Ve3XmkUEsES7lFK9cWbQZQ/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023468; c=relaxed/simple;
	bh=IuR6ngsJ34tq7+cbBSzAiZ3Tns5PdX4qxd/iDTRdLH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cf2EKp49wOpTQ+gHSyZ0/wspjEYgrPq2VAeAGRrRoMmFwnXJCNgjSHp7nALRDfVIkjRxc8dlhIqkHGKpfBnbvrpzOLUlDnYHXdLEa7E93ki24ppRjaIDmK1Tbgi8F2oWL+L09IppGtXAIFCfpMF3m0pf3uDV3iQm1+Bvqh0162E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tuhpqw+r; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764023463; x=1795559463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IuR6ngsJ34tq7+cbBSzAiZ3Tns5PdX4qxd/iDTRdLH0=;
  b=Tuhpqw+rY8yv7LuFnO1/in6zgGC1/Ijq32rms7jRVDCHO5ZSPqYqVS8v
   mfJz/+E7XCTj0rKp9+KbtdCW0xQJktXkpVGHNNlUbIDItxBUOTlWfyDAL
   8cvZTl3TyNDVz4Frk9WEG/u0RFxrNadWCchCKN/d5mf9TTeUwHBv44tAC
   znEXAi2YRHXazj9OtfTJmX4yxdcCcenp+Tm4SiQRYyr9yOr8AJQkCZCU2
   vEj5AsDbYUdrEgUyk4qS0Oebff2CRJKb9IXVGeH1/+DO3WT5cQh5EFvjq
   Otz/TEAumrTwBRBSGmtO3XfU4V1oSKALlPvggCrTjvFMV4lgEbGVVkHXN
   g==;
X-CSE-ConnectionGUID: aHgzjLFcRLeglBvN8XpTsw==
X-CSE-MsgGUID: OloyvCGhSeStNNyDjjraSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="69890177"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="69890177"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 14:31:02 -0800
X-CSE-ConnectionGUID: tBIqG2h8TG2CrSz0dW2xyg==
X-CSE-MsgGUID: 5FZfFwonSmGDoMwe7nHNaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="215804590"
Received: from osgc-linux-buildserver.sh.intel.com ([10.112.232.103])
  by fmviesa002.fm.intel.com with ESMTP; 24 Nov 2025 14:31:01 -0800
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: stable@vger.kernel.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Koen Koning <koen.koning@intel.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.12.y] drm/xe: Prevent BIT() overflow when handling invalid prefetch region
Date: Mon, 24 Nov 2025 22:28:28 +0000
Message-ID: <20251124222827.901507-2-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025112408-crunching-july-9814@gregkh>
References: <2025112408-crunching-july-9814@gregkh>
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
index fc5f0e135193..30625ce691fa 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2903,8 +2903,8 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe,
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


