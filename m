Return-Path: <stable+bounces-227014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eClELt15ummTWwIAu9opvQ
	(envelope-from <stable+bounces-227014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:09:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA592B9A4F
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B332C30086A2
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938B83AEF49;
	Wed, 18 Mar 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqDad8o0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753473A6EE5
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828156; cv=none; b=sPR3F1Lmpi1P0ELHe8Ko67NYSNYWwkKSMee+uqJ7opyUmQqDT8a23N4tK8VqvwQPegFLo4WCms8PVNJwD1FbNa6phCzhRX11+PwchRIvhrbJneTXGaf/as6HOgkIlNG56fVhT20nunBZvoUbOuW0VIGpBk4ONmN/X25dZh23WrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828156; c=relaxed/simple;
	bh=P3QBGQ26ck72X4lcL/ofRghVPQ8V/D7QsLsqG0tz7VY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thJEGYd094cRxa05f8tuljrMWK5+I7935T2jdtPKd4jxovkGWSJPv1hS46hmONrgIzwAc2TavyBEb0vl2NLkhkISV+UCctCyydsWx/gDQ1f9KJbSs6V01u4SNoR/7ueKJsba3T0MTQL3dClWJVjkXaS5ietkm+boQXBHa8zrWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqDad8o0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773828151; x=1805364151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P3QBGQ26ck72X4lcL/ofRghVPQ8V/D7QsLsqG0tz7VY=;
  b=CqDad8o0tHPqeUKoxvk+JGg9e0PIO9/h8xVsCtLlYf6dxBAr/gVyFGBs
   SJZpiATmv31nRmI8Ei35mrTMDfKpsyUv789LVmFgu0zF+WlsWzUjuG0ss
   X4tnb5eQLChhsj0OWkw/4dMMf7D53+PY0t06iz/9Ydn/Eb9NeTKeBQT12
   gZi/2UhnjpcrKWNfwpoqHaVGW6v9eqTtRwYmZ+nuNNY/gYr33jvpvrb1M
   Qbhddoo9eYQUvvOAG/P5dcdq2favHc2B2j2+GVBCIpz4nuUmgv0Jf8mQx
   XLZeWR24YzyJYuv+f4eh7Xll/8DV4z7VFupTiS4TdK6639dFdaeirj6er
   w==;
X-CSE-ConnectionGUID: FpelROJqSNK7L0ZbB/GF6Q==
X-CSE-MsgGUID: ffwpyV+EQVOvXj1VG377Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78777167"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="78777167"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 03:02:30 -0700
X-CSE-ConnectionGUID: efOHI/yUS7eCtEkBGIsvuQ==
X-CSE-MsgGUID: gCRN05P3R6aWsPXnkRfLjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="226713963"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.34])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 03:02:29 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/xe: always keep track of remap prev/next
Date: Wed, 18 Mar 2026 10:02:09 +0000
Message-ID: <20260318100208.78097-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227014-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: BEA592B9A4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During 3D workload, user is reporting hitting:

[  413.361679] WARNING: drivers/gpu/drm/xe/xe_vm.c:1217 at vm_bind_ioctl_ops_unwind+0x1e2/0x2e0 [xe], CPU#7: vkd3d_queue/9925
[  413.361944] CPU: 7 UID: 1000 PID: 9925 Comm: vkd3d_queue Kdump: loaded Not tainted 7.0.0-070000rc3-generic #202603090038 PREEMPT(lazy)
[  413.361949] RIP: 0010:vm_bind_ioctl_ops_unwind+0x1e2/0x2e0 [xe]
[  413.362074] RSP: 0018:ffffd4c25c3df930 EFLAGS: 00010282
[  413.362077] RAX: 0000000000000000 RBX: ffff8f3ee817ed10 RCX: 0000000000000000
[  413.362078] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  413.362079] RBP: ffffd4c25c3df980 R08: 0000000000000000 R09: 0000000000000000
[  413.362081] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8f41fbf99380
[  413.362082] R13: ffff8f3ee817e968 R14: 00000000ffffffef R15: ffff8f43d00bd380
[  413.362083] FS:  00000001040ff6c0(0000) GS:ffff8f4696d89000(0000) knlGS:00000000330b0000
[  413.362085] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  413.362086] CR2: 00007ddfc4747000 CR3: 00000002e6262005 CR4: 0000000000f72ef0
[  413.362088] PKRU: 55555554
[  413.362089] Call Trace:
[  413.362092]  <TASK>
[  413.362096]  xe_vm_bind_ioctl+0xa9a/0xc60 [xe]

Which seems to hint that the vma we are re-inserting for the ops unwind
is either invalid or overlapping with something already inserted in the
vm. It shouldn't be invalid since this is a re-insertion, so must have
worked before. Leaving the likely culprit as something already placed
where we want to insert the vma.

Following from that, for the case where we do something like a rebind in
the middle of a vma, and one or both mapped ends are already compatible,
we skip doing the rebind of those vma and set next/prev to NULL. As well
as then adjust the original unmap va range, to avoid unmapping the ends.
However, if we trigger the unwind path, we end up with three va, with
the two ends never being removed and the original va range in the middle
still being the shrunken size.

If this occurs, one failure mode is when another unwind op needs to
interact with that range, which can happen with a vector of binds. For
example, if we need to re-insert something in place of the original va.
In this case the va is still the shrunken version, so when removing it
and then doing a re-insert it can overlap with the ends, which were
never removed, triggering a warning like above, plus leaving the vm in a
bad state.

With that, we need two things here:

 1) Stop nuking the prev/next tracking for the skip cases. Instead
    relying on checking for skip prev/next, where needed. That way on the
    unwind path, we now correctly remove both ends.

 2) Undo the unmap va shrinkage, on the unwind path. With the two ends
    now removed the unmap va should expand back to the original size again,
    before re-insertion.

v2:
  - Update the explanation in the commit message, based on an actual IGT of
    triggering this issue, rather than conjecture.
  - Also undo the unmap shrinkage, for the skip case. With the two ends
    now removed, the original unmap va range should expand back to the
    original range.
v3:
  - Track the old start/range separately. vma_size/start() uses the va
    info directly.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7602
Fixes: 8f33b4f054fc ("drm/xe: Avoid doing rebinds")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/xe_pt.c       | 12 ++++++------
 drivers/gpu/drm/xe/xe_vm.c       | 22 ++++++++++++++++++----
 drivers/gpu/drm/xe/xe_vm_types.h |  4 ++++
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 2d9ce2c4cb4f..713a303c9053 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1442,9 +1442,9 @@ static int op_check_svm_userptr(struct xe_vm *vm, struct xe_vma_op *op,
 		err = vma_check_userptr(vm, op->map.vma, pt_update);
 		break;
 	case DRM_GPUVA_OP_REMAP:
-		if (op->remap.prev)
+		if (op->remap.prev && !op->remap.skip_prev)
 			err = vma_check_userptr(vm, op->remap.prev, pt_update);
-		if (!err && op->remap.next)
+		if (!err && op->remap.next && !op->remap.skip_next)
 			err = vma_check_userptr(vm, op->remap.next, pt_update);
 		break;
 	case DRM_GPUVA_OP_UNMAP:
@@ -2198,12 +2198,12 @@ static int op_prepare(struct xe_vm *vm,
 
 		err = unbind_op_prepare(tile, pt_update_ops, old);
 
-		if (!err && op->remap.prev) {
+		if (!err && op->remap.prev && !op->remap.skip_prev) {
 			err = bind_op_prepare(vm, tile, pt_update_ops,
 					      op->remap.prev, false);
 			pt_update_ops->wait_vm_bookkeep = true;
 		}
-		if (!err && op->remap.next) {
+		if (!err && op->remap.next && !op->remap.skip_next) {
 			err = bind_op_prepare(vm, tile, pt_update_ops,
 					      op->remap.next, false);
 			pt_update_ops->wait_vm_bookkeep = true;
@@ -2428,10 +2428,10 @@ static void op_commit(struct xe_vm *vm,
 
 		unbind_op_commit(vm, tile, pt_update_ops, old, fence, fence2);
 
-		if (op->remap.prev)
+		if (op->remap.prev && !op->remap.skip_prev)
 			bind_op_commit(vm, tile, pt_update_ops, op->remap.prev,
 				       fence, fence2, false);
-		if (op->remap.next)
+		if (op->remap.next && !op->remap.skip_next)
 			bind_op_commit(vm, tile, pt_update_ops, op->remap.next,
 				       fence, fence2, false);
 		break;
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 5572e12c2a7e..2773f1ee90d4 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2584,7 +2584,6 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
 			if (!err && op->remap.skip_prev) {
 				op->remap.prev->tile_present =
 					tile_present;
-				op->remap.prev = NULL;
 			}
 		}
 		if (op->remap.next) {
@@ -2594,11 +2593,13 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
 			if (!err && op->remap.skip_next) {
 				op->remap.next->tile_present =
 					tile_present;
-				op->remap.next = NULL;
 			}
 		}
 
-		/* Adjust for partial unbind after removing VMA from VM */
+		/*
+		 * Adjust for partial unbind after removing VMA from VM. In case
+		 * of unwind we might need to undo this later.
+		 */
 		if (!err) {
 			op->base.remap.unmap->va->va.addr = op->remap.start;
 			op->base.remap.unmap->va->va.range = op->remap.range;
@@ -2717,6 +2718,8 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
 
 			op->remap.start = xe_vma_start(old);
 			op->remap.range = xe_vma_size(old);
+			op->remap.old_start = op->remap.start;
+			op->remap.old_range = op->remap.range;
 
 			flags |= op->base.remap.unmap->va->flags & XE_VMA_CREATE_MASK;
 			if (op->base.remap.prev) {
@@ -2865,8 +2868,19 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
 			xe_svm_notifier_lock(vm);
 			vma->gpuva.flags &= ~XE_VMA_DESTROYED;
 			xe_svm_notifier_unlock(vm);
-			if (post_commit)
+			if (post_commit) {
+				/*
+				 * Restore the old va range, in case of the
+				 * prev/next skip optimisation. Otherwise what
+				 * we re-insert here could be smaller than the
+				 * original range.
+				 */
+				op->base.remap.unmap->va->va.addr =
+					op->remap.old_start;
+				op->base.remap.unmap->va->va.range =
+					op->remap.old_range;
 				xe_vm_insert_vma(vm, vma);
+			}
 		}
 		break;
 	}
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 69e80c94138a..fc811b5e308c 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -393,6 +393,10 @@ struct xe_vma_op_remap {
 	u64 start;
 	/** @range: range of the VMA unmap */
 	u64 range;
+	/** @old_start: Original start of the VMA we unmap */
+	u64 old_start;
+	/** @old_range: Original range of the VMA we unmap */
+	u64 old_range;
 	/** @skip_prev: skip prev rebind */
 	bool skip_prev;
 	/** @skip_next: skip next rebind */
-- 
2.53.0


