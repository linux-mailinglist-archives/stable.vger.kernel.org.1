Return-Path: <stable+bounces-231263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG0JIQ3DymmL/wUAu9opvQ
	(envelope-from <stable+bounces-231263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 20:38:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E770935FCD4
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 20:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6888A30292E4
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35D237E2FE;
	Mon, 30 Mar 2026 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7ZIJxAd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D202FD7D3
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895880; cv=none; b=NsswbcdUBDLTNJlEbFEERw9YOyz5L6YsGQOSURYgdnnv0W6qD5KbgofWakzr1sbB2XPVRPrr/IUJt9iwKiDtf6U8dmWB5iubEevpJ4WX+hWX1KHfhywc3KGJL1xzZHpCVtI5ciuZNpaFkw/yteXD6ggG2j0QdcsMzXiZJOnOJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895880; c=relaxed/simple;
	bh=xoY5ekMSApKsdq+L3fojgVwyVzkYVjIVoc6wPSwHOcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zz2HULWqf/iIf0aFz1Bpf7Mb2hOSnZH28dfY5AXtQdL37K4mCt2FZ8nBcllbClg008G2v7a3tC7+UCcYkSuYTtcj/6OwZyZ3/5m6x/PraP2aBEG72Jv4VynlwGynCqvP5ZCxd0c2Po9fmmEgNmcLd5imdU4uVOQ/7YHu1ybVRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7ZIJxAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC58C4CEF7;
	Mon, 30 Mar 2026 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774895880;
	bh=xoY5ekMSApKsdq+L3fojgVwyVzkYVjIVoc6wPSwHOcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W7ZIJxAdGS/X6cu4TKbnYNvIEG6pjXoT+og6f1Nrtlq4wjeB1f5ywUHZhIszc1dmc
	 UPTB0Se8oEfZVNK5B0q7R4w6crxlTM1hepTAlElM1iV8AK62lQHJS4xNPzvY02dpcp
	 UtCLWZbhn6zS+wc7EOl/B5kxk0lCXomWsz/39Aug7B08nz4wknGXQxKHPvhO0Qe24m
	 zXeaxZ+TC28r7agQEqigujPV3afITyBsB/LXTG7z6YFzVSj3ufpr9DwTq/VusHNHmd
	 uNuzpcEg6l3Yc9hxTenemA/oyuxN2+Bb++2/2S6yDBRinbrp1qw8UUxKo7AZKqBlBH
	 kdtXCWTXFE6aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/xe: always keep track of remap prev/next
Date: Mon, 30 Mar 2026 14:37:58 -0400
Message-ID: <20260330183758.941967-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026032929-running-boots-dc07@gregkh>
References: <2026032929-running-boots-dc07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231263-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.freedesktop.org:url,intel.com:email]
X-Rspamd-Queue-Id: E770935FCD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Matthew Auld <matthew.auld@intel.com>

[ Upstream commit bfe9e314d7574d1c5c851972e7aee342733819d2 ]

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
[ adapted function signatures ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pt.c       | 12 ++++++------
 drivers/gpu/drm/xe/xe_vm.c       | 22 ++++++++++++++++++----
 drivers/gpu/drm/xe/xe_vm_types.h |  4 ++++
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index fb94ff55c7361..9b8903ad6f043 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1281,9 +1281,9 @@ static int op_check_userptr(struct xe_vm *vm, struct xe_vma_op *op,
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
@@ -1784,12 +1784,12 @@ static int op_prepare(struct xe_vm *vm,
 		err = unbind_op_prepare(tile, pt_update_ops,
 					gpuva_to_vma(op->base.remap.unmap->va));
 
-		if (!err && op->remap.prev) {
+		if (!err && op->remap.prev && !op->remap.skip_prev) {
 			err = bind_op_prepare(vm, tile, pt_update_ops,
 					      op->remap.prev);
 			pt_update_ops->wait_vm_bookkeep = true;
 		}
-		if (!err && op->remap.next) {
+		if (!err && op->remap.next && !op->remap.skip_next) {
 			err = bind_op_prepare(vm, tile, pt_update_ops,
 					      op->remap.next);
 			pt_update_ops->wait_vm_bookkeep = true;
@@ -1950,10 +1950,10 @@ static void op_commit(struct xe_vm *vm,
 				 gpuva_to_vma(op->base.remap.unmap->va), fence,
 				 fence2);
 
-		if (op->remap.prev)
+		if (op->remap.prev && !op->remap.skip_prev)
 			bind_op_commit(vm, tile, pt_update_ops, op->remap.prev,
 				       fence, fence2);
-		if (op->remap.next)
+		if (op->remap.next && !op->remap.skip_next)
 			bind_op_commit(vm, tile, pt_update_ops, op->remap.next,
 				       fence, fence2);
 		break;
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 02f2b7ad8a85f..7ce6a9d4e5c10 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2187,7 +2187,6 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
 			if (!err && op->remap.skip_prev) {
 				op->remap.prev->tile_present =
 					tile_present;
-				op->remap.prev = NULL;
 			}
 		}
 		if (op->remap.next) {
@@ -2197,11 +2196,13 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
 			if (!err && op->remap.skip_next) {
 				op->remap.next->tile_present =
 					tile_present;
-				op->remap.next = NULL;
 			}
 		}
 
-		/* Adjust for partial unbind after removin VMA from VM */
+		/*
+		 * Adjust for partial unbind after removing VMA from VM. In case
+		 * of unwind we might need to undo this later.
+		 */
 		if (!err) {
 			op->base.remap.unmap->va->va.addr = op->remap.start;
 			op->base.remap.unmap->va->va.range = op->remap.range;
@@ -2273,6 +2274,8 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
 
 			op->remap.start = xe_vma_start(old);
 			op->remap.range = xe_vma_size(old);
+			op->remap.old_start = op->remap.start;
+			op->remap.old_range = op->remap.range;
 
 			if (op->base.remap.prev) {
 				flags |= op->base.remap.unmap->va->flags &
@@ -2421,8 +2424,19 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
 			down_read(&vm->userptr.notifier_lock);
 			vma->gpuva.flags &= ~XE_VMA_DESTROYED;
 			up_read(&vm->userptr.notifier_lock);
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
index 4f95308a61b8d..b280e335c5bb4 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -314,6 +314,10 @@ struct xe_vma_op_remap {
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


