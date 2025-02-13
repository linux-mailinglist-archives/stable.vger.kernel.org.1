Return-Path: <stable+bounces-115148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E816A34134
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D521600BE
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703982222C8;
	Thu, 13 Feb 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b66ZRD10"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5862222B5
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455109; cv=none; b=B36dJH6HGLvj+5z8xUv4UBmKxEMMF+Mxm8N9Z+cduEvN/AKkLuzKMmLJnbjQsIYUGvnlBl4jPmhhBRgclaT1dHIw5iHtyE2+Xo+f03qBndHd4hJQthkCzvwP0yGZkdOJhXKD0iSGKSTdqYxCOead22a2dqMKumPVn6sTH+q+los=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455109; c=relaxed/simple;
	bh=bHZeZfKNTDogIf6Y2kInrbME7S2+Xgh/ojub8j6miqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QYzzTwg5VzJC3j0KBip0tG6h0kT+I98TQrIJSniWQElCMU9Cq8DoSt/mHSpnbe91jfd8jl3ceklxy0dWm2yKwV5+eueRuiZQ4zzyrfArCNKQf129BmQT2AxRcqysR1KcZYTy8nVQf5yiWdBOhnZ7bIEdXn1wlkgzXTA8FzhxzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b66ZRD10; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739455108; x=1770991108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bHZeZfKNTDogIf6Y2kInrbME7S2+Xgh/ojub8j6miqU=;
  b=b66ZRD10sEWUzUUJIc04hDsOFMqQTM9wjdcpgJOvTlXu0tFEqh6DBXHR
   7TM2d2dwPj72+4f3lSBtyvzkxZSNG2SupUxh9qozgtivV7mXyuB6wSTrk
   zKmsNzjq+CjloQdOAfTTN04acXF/QOFzatlwqIcf7+31rN7yWHvOI+hce
   dfF89Gn75lofiDh6XHjPKnGtWbMQJtvORummRg4L6L8EkktEahwPkgOYn
   UY0VJS9CDBREbuumvJC7VW4kryutDhQBNrbptCGVrjl5jkplc8EInYRwR
   t6klsbYJcMBitsit2HNCG7X0iCucX/XVE4IHzEnmYcjpzf7fHeS4VLS6t
   Q==;
X-CSE-ConnectionGUID: rpiyYuIBQdGQwhNOY6d6SA==
X-CSE-MsgGUID: vngqxW1yQ/GVCZ6lxd/3bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40020309"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40020309"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:58:27 -0800
X-CSE-ConnectionGUID: pIb+x+DWRsaD5bHpJKZ8cg==
X-CSE-MsgGUID: l2gAYjgQSwOJnNjr+/4Zgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118081434"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO mwauld-desk.intel.com) ([10.245.245.31])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:58:26 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe/userptr: fix EFAULT handling
Date: Thu, 13 Feb 2025 13:58:09 +0000
Message-ID: <20250213135808.189144-3-matthew.auld@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently we treat EFAULT from hmm_range_fault() as a non-fatal error
when called from xe_vm_userptr_pin() with the idea that we want to avoid
killing the entire vm and chucking an error, under the assumption that
the user just did an unmap or something, and has no intention of
actually touching that memory from the GPU.  At this point we have
already zapped the PTEs so any access should generate a page fault, and
if the pin fails there also it will then become fatal.

However it looks like it's possible for the userptr vma to still be on
the rebind list in preempt_rebind_work_func(), if we had to retry the
pin again due to something happening in the caller before we did the
rebind step, but in the meantime needing to re-validate the userptr and
this time hitting the EFAULT.

This might explain an internal user report of hitting:

[  191.738349] WARNING: CPU: 1 PID: 157 at drivers/gpu/drm/xe/xe_res_cursor.h:158 xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
[  191.738551] Workqueue: xe-ordered-wq preempt_rebind_work_func [xe]
[  191.738616] RIP: 0010:xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
[  191.738690] Call Trace:
[  191.738692]  <TASK>
[  191.738694]  ? show_regs+0x69/0x80
[  191.738698]  ? __warn+0x93/0x1a0
[  191.738703]  ? xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
[  191.738759]  ? report_bug+0x18f/0x1a0
[  191.738764]  ? handle_bug+0x63/0xa0
[  191.738767]  ? exc_invalid_op+0x19/0x70
[  191.738770]  ? asm_exc_invalid_op+0x1b/0x20
[  191.738777]  ? xe_pt_stage_bind.constprop.0+0x60a/0x6b0 [xe]
[  191.738834]  ? ret_from_fork_asm+0x1a/0x30
[  191.738849]  bind_op_prepare+0x105/0x7b0 [xe]
[  191.738906]  ? dma_resv_reserve_fences+0x301/0x380
[  191.738912]  xe_pt_update_ops_prepare+0x28c/0x4b0 [xe]
[  191.738966]  ? kmemleak_alloc+0x4b/0x80
[  191.738973]  ops_execute+0x188/0x9d0 [xe]
[  191.739036]  xe_vm_rebind+0x4ce/0x5a0 [xe]
[  191.739098]  ? trace_hardirqs_on+0x4d/0x60
[  191.739112]  preempt_rebind_work_func+0x76f/0xd00 [xe]

Followed by NPD, when running some workload, since the sg was never
actually populated but the vma is still marked for rebind when it should
be skipped for this special EFAULT case. And from the logs it does seem
like we hit this special EFAULT case before the explosions.

Fixes: 521db22a1d70 ("drm/xe: Invalidate userptr VMA on page pin fault")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
---
 drivers/gpu/drm/xe/xe_vm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index d664f2e418b2..1caee9cbeafb 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -692,6 +692,17 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
 			xe_vm_unlock(vm);
 			if (err)
 				return err;
+
+			/*
+			 * We might have already done the pin once already, but then had to retry
+			 * before the re-bind happended, due some other condition in the caller, but
+			 * in the meantime the userptr got dinged by the notifier such that we need
+			 * to revalidate here, but this time we hit the EFAULT. In such a case
+			 * make sure we remove ourselves from the rebind list to avoid going down in
+			 * flames.
+			 */
+			if (!list_empty(&uvma->vma.combined_links.rebind))
+				list_del_init(&uvma->vma.combined_links.rebind);
 		} else {
 			if (err < 0)
 				return err;
-- 
2.48.1


