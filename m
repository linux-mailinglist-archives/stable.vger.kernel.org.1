Return-Path: <stable+bounces-116433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E496A363E0
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09187A1F61
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C35E267AE5;
	Fri, 14 Feb 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmseMhjX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558E267700
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552754; cv=none; b=OMUilJP0CnJPVXv764/qMJk4R2wY1Yvp4SRwoZb7cClcn4/qkS543lSxRbj+a2AKkxy/0xfaRQ5OATirakMSgh5yda+jLA9QQrx5K2F3WOTrJ8QvBk5xKpdv20JRajDoV4MmScP12RRZ/hjQLLqJaOhZAqyY0YR0kvbyo35g+/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552754; c=relaxed/simple;
	bh=76mtQ+EvUdEkdDJrFmFI5GF3XGE1PxfDlpCxnfmkp10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYuFbsiireBNKGAfbNMnUmE0JtCs9oVlT57vOKJo0gMAAaXRzjBsPHq4yYUWJPC4njji7O1Q/LS0xRDVQ3x01UY8bXnIb0FEKHZXaJloUeOdGSQhkegB5eO3/nKl4xGCFm23Lsb0SnRh92PKDjQEZQqp+3VLYaGqKQMAngdQTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmseMhjX; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739552753; x=1771088753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=76mtQ+EvUdEkdDJrFmFI5GF3XGE1PxfDlpCxnfmkp10=;
  b=JmseMhjX3JjLPAlx2SpNQTwujKxWBCxwT3dV9Scf4jo0OIPEzXlmFoLY
   pH4k+izMpwF1pM0v38cW92qaubwNlxr2Bx1g54Bj4h29go4aFRbOr4NxI
   NcA+lqJYh0exUW5ddeT47ji88L8PdYLY1LpFJipl7X6xRyH6b1Us1JIZA
   QnUcM9osE3EIpLUXbIj+JpC9YROaquDg9oa7NvDp97duMe3fgDjWcr2po
   kWvW0D8KqZ1HlR8AXwvfb8PIIQJ0cQaFDU92LndjTBzXA3xtCOJOJys9v
   cclbfz1pidiwoSy6YoYtKallg58awjeZ6PHt+IxQcObiaXNSUs0iajMeS
   A==;
X-CSE-ConnectionGUID: /hm4h9xFSQmhyl3HwukTsg==
X-CSE-MsgGUID: r3BCa5m7Qai8m0OllpTg7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40575944"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40575944"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:05:41 -0800
X-CSE-ConnectionGUID: 7XEX515uTFCSio09gOpGLw==
X-CSE-MsgGUID: v9/GYdUuTPq3g0vwxpjexQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113235221"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.190])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:05:39 -0800
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] drm/xe/userptr: fix EFAULT handling
Date: Fri, 14 Feb 2025 17:05:29 +0000
Message-ID: <20250214170527.272182-5-matthew.auld@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214170527.272182-4-matthew.auld@intel.com>
References: <20250214170527.272182-4-matthew.auld@intel.com>
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

v2 (MattB):
 - Move earlier

Fixes: 521db22a1d70 ("drm/xe: Invalidate userptr VMA on page pin fault")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
---
 drivers/gpu/drm/xe/xe_vm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 668b0bde7822..f36e2cc1d155 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -681,6 +681,18 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
 		err = xe_vma_userptr_pin_pages(uvma);
 		if (err == -EFAULT) {
 			list_del_init(&uvma->userptr.repin_link);
+			/*
+			 * We might have already done the pin once already, but
+			 * then had to retry before the re-bind happened, due
+			 * some other condition in the caller, but in the
+			 * meantime the userptr got dinged by the notifier such
+			 * that we need to revalidate here, but this time we hit
+			 * the EFAULT. In such a case make sure we remove
+			 * ourselves from the rebind list to avoid going down in
+			 * flames.
+			 */
+			if (!list_empty(&uvma->vma.combined_links.rebind))
+				list_del_init(&uvma->vma.combined_links.rebind);
 
 			/* Wait for pending binds */
 			xe_vm_lock(vm, false);
-- 
2.48.1


