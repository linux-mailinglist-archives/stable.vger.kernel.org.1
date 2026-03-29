Return-Path: <stable+bounces-230856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DZ8LInSyGnprAUAu9opvQ
	(envelope-from <stable+bounces-230856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:19:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3788B35106A
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 489C9301AF7A
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 07:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CCF29D281;
	Sun, 29 Mar 2026 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V9LkUy/f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98522D4DC
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768772; cv=none; b=UEjE2hyC4nMYPQ7TjJvB6wTk8h8uo+ghgz7opRYM3XwXiFpYfZGsp90uAKyxHRpzlQpDbRq0CBLs9wN9YwiTUowKBwRaq5FPGUgR9pfwBoK0fk/PzL7benq6F4tnpiX51eW26lyPKJUB8rlRc7PzluPtfuSIDrcuLcFbkTgzjT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768772; c=relaxed/simple;
	bh=8vXXYhTZzCbdfLhm7xK0lmgq+IeLdbkXET8V33aht64=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ohncNjV+PEO20VJJ2RSd310ZwqEh360GNCOM5+RF+NRv0aurFZnA66zzt4WMlffSwqFBdKxEL3aqxXMNhmLZ1z16T9sbS5LYFDCFo0Cp/bmLkr0u7bT88D97SjmhVNLa8ZbLNTmUtvMrL7XZEwndIJqtmFH9hHSFpiFkO6DCofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V9LkUy/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40ACC116C6;
	Sun, 29 Mar 2026 07:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774768772;
	bh=8vXXYhTZzCbdfLhm7xK0lmgq+IeLdbkXET8V33aht64=;
	h=Subject:To:Cc:From:Date:From;
	b=V9LkUy/fsOLPRHeh9/lXWLR0ROEiKT8Qb+LX3tOUmMdbvwOj9GJMEzywnQWvbPpw4
	 Z3CnvT9+UJSEuJ+HAj6NX3BsCJRVRGDlA4ydsWtoXhMtIbumfDXjn/tEiftV+v/6Pi
	 j8QQTcl/vO8JKS1ikg54eSIyftl9sRCThohAn4nA=
Subject: FAILED: patch "[PATCH] drm/xe: always keep track of remap prev/next" failed to apply to 6.12-stable tree
To: matthew.auld@intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 09:19:29 +0200
Message-ID: <2026032929-running-boots-dc07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230856-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 3788B35106A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bfe9e314d7574d1c5c851972e7aee342733819d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032929-running-boots-dc07@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bfe9e314d7574d1c5c851972e7aee342733819d2 Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Wed, 18 Mar 2026 10:02:09 +0000
Subject: [PATCH] drm/xe: always keep track of remap prev/next

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
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260318100208.78097-2-matthew.auld@intel.com
(cherry picked from commit aec6969f75afbf4e01fd5fb5850ed3e9c27043ac)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

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
index a82e3a4fb389..ffdbab106a58 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2554,7 +2554,6 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
 			if (!err && op->remap.skip_prev) {
 				op->remap.prev->tile_present =
 					tile_present;
-				op->remap.prev = NULL;
 			}
 		}
 		if (op->remap.next) {
@@ -2564,11 +2563,13 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
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
@@ -2687,6 +2688,8 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
 
 			op->remap.start = xe_vma_start(old);
 			op->remap.range = xe_vma_size(old);
+			op->remap.old_start = op->remap.start;
+			op->remap.old_range = op->remap.range;
 
 			flags |= op->base.remap.unmap->va->flags & XE_VMA_CREATE_MASK;
 			if (op->base.remap.prev) {
@@ -2835,8 +2838,19 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
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
index 437f64202f3b..e2946e311d7a 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -373,6 +373,10 @@ struct xe_vma_op_remap {
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


