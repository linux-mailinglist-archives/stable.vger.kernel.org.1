Return-Path: <stable+bounces-196739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7F7C80DD4
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70F234E2830
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8930BB87;
	Mon, 24 Nov 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vvh9ZEm9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635F303C93
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992519; cv=none; b=QjfSAxTqZgs89RgKKlP40GH/FVtOLyo40qbrQ1fLOqssIK+XrW2M3jW7bbOrBH1sHwvbiqegvUO2klS5wPmCey3CahzcFBzYAIbsctl73a6tUO9d2YNRlj+kQjA4g7jd3R690HAHzcRk7cBgR2RlnzUPM/hopGzG8rO4euzWac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992519; c=relaxed/simple;
	bh=lvsegie2dk69RFC42eCyJZL2K6Z+bea9B/JSklfNv4Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QPh0zPnqvDxRaQIKOnP+6OJ6CrJ4JbWjDZzs882s3Y4m+Uq61oXlce3JTuzOPIrpmHH9AS6/dsbZUrm0NQZ6OeJ6tTxhNj2Et9ccignnQJOmujEionNJWrZR6gUiV4FZI1PzCvqOxNCY3SvmE+PCru6GLUTvm1XF2qSsFPV9Q3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vvh9ZEm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFE2C4CEF1;
	Mon, 24 Nov 2025 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763992519;
	bh=lvsegie2dk69RFC42eCyJZL2K6Z+bea9B/JSklfNv4Y=;
	h=Subject:To:Cc:From:Date:From;
	b=vvh9ZEm9gyA7U1T5BOkeeFoGtdtiqtZ6fnHlMaery+zudMMt2Moj9utUZzJKqNTxb
	 m+yrSDc1+oYhgDslesKVvbGvIto4Cjtxd5MrbyGYLVuW/RKmlg+YLA43Ht54KjeOYH
	 33VMMGMupjtunWp3qhHbKaSA6Y8Qhg1GHIJsQULQ=
Subject: FAILED: patch "[PATCH] drm/xe: Prevent BIT() overflow when handling invalid prefetch" failed to apply to 6.12-stable tree
To: shuicheng.lin@intel.com,koen.koning@intel.com,lucas.demarchi@intel.com,matthew.auld@intel.com,peter.senna@linux.intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:55:08 +0100
Message-ID: <2025112408-crunching-july-9814@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d52dea485cd3c98cfeeb474cf66cf95df2ab142f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112408-crunching-july-9814@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d52dea485cd3c98cfeeb474cf66cf95df2ab142f Mon Sep 17 00:00:00 2001
From: Shuicheng Lin <shuicheng.lin@intel.com>
Date: Wed, 12 Nov 2025 18:10:06 +0000
Subject: [PATCH] drm/xe: Prevent BIT() overflow when handling invalid prefetch
 region

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

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index ccb09ef4ec9e..cdd1dc540a59 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3369,8 +3369,10 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
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


