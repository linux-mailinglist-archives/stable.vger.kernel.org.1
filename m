Return-Path: <stable+bounces-115144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F80A340E0
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30506188BD30
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7138389;
	Thu, 13 Feb 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gtrg/AQV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6C221575
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454892; cv=none; b=fr1zNQlskNllqngdwYdWR63+mpaXgzJTPc+VV7T3k2yjaeW5Fq3OusTcUBWTR0fVGa4TDo0DoHPx7oF7U2Q5Yla4xn9VgydkAeRDhLWPSkb+Amvc4CUWey2X1bnUGd2VDejJE381TVphPIr0MY0fXjYHOCCUsTn94ck2s5feYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454892; c=relaxed/simple;
	bh=bHZeZfKNTDogIf6Y2kInrbME7S2+Xgh/ojub8j6miqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=choAArY3Pt75ZtGwG5MU/TWbh+bPUEWFIoDqFVxosONz+ZzcOGDKWv68xN49+8wai2mpHjXZtUTIZVo3R1eam98GG0BYNgLozh3Ir9JBFC7n6MYANTmN7i8EAmhCRCM4syRIRAGmQvQjhb8fU1WH3HlCPI0UVEQfqLj8vyFKMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gtrg/AQV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739454890; x=1770990890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bHZeZfKNTDogIf6Y2kInrbME7S2+Xgh/ojub8j6miqU=;
  b=Gtrg/AQV0/FwTL1uImnIxjICT9hWm/icDMuJFGNzxxza8KbALk8Scbfr
   k4E1nefhxTujNmngRSJ90sTcAq3xWwGTuFFqJnHgdhU0mwF9Gw876Itec
   lJwKUV5JGEzoU0clxdxmxtW1pSri1t+NM9htIRW+Eb83/mWhmg4wPbMfw
   YhZVkmCoknC37BemIWCw3TnCZdGq8NMk2Xiht8rNUKukH6M5/tb3M/7du
   xt8aQjkemJw8cUET6v8MYNpPjuyiw/NydY8j204qG/GYZUyZrki0jSeJz
   VLAdQHhWbdbGb2YWmLvb02BXOoBgMdKTz24g3KmFSGTqOez6RHMCeiwb5
   Q==;
X-CSE-ConnectionGUID: R/Kx5l3wR5C/Elq61NOgLQ==
X-CSE-MsgGUID: zrbo3z2zT7GbdZh7OZlnjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="51554198"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="51554198"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:54:50 -0800
X-CSE-ConnectionGUID: YZ+rNqu2T3OcocVS5wpSaQ==
X-CSE-MsgGUID: UWP57olhRjaEQ9XGGQFx2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113020051"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO mwauld-desk.intel.com) ([10.245.245.31])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:54:48 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/userptr: fix EFAULT handling
Date: Thu, 13 Feb 2025 13:54:35 +0000
Message-ID: <20250213135434.186967-2-matthew.auld@intel.com>
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


