Return-Path: <stable+bounces-136087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3E8A991D8
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96D51BA524E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BA328EA4A;
	Wed, 23 Apr 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fHVpRXSH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B46283CAC;
	Wed, 23 Apr 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421621; cv=none; b=qopTtnDlnKqLJ/KGBBzpSKwdN0xeuEDYzDqbnndk180xdapnjtHBgUov4gZGuH+gyf8Zh9DaR3Q0bruEndY9W77S0dp7KCv/9GoEtQwybmB6WrLe4A2azc4EfU+9O/YLypDp4LnvWTMT+kHnIrhum8Vb+Bkq+R2dyzLlJ4btyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421621; c=relaxed/simple;
	bh=L1hf1qgdFy7Pqd1+hUG3YMVguCG1q/5v1j0NpIeS6SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKl3JOo3tfUpKa8buW3IgPRbzydWCpxWcvkIOelKWF0ZhroH3NDEKlf5BWlDjoQmLDvK9yW+yLskhI3DXtKxV6J9jzFiPQbPuvoxjxQHgQ3Iqn1YN+jkhC6Q3rGH1NAe+oyw+ajtl7LFwVCnG7036ARhWw0agBquY35RSrVJTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fHVpRXSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D682C4CEE2;
	Wed, 23 Apr 2025 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421620;
	bh=L1hf1qgdFy7Pqd1+hUG3YMVguCG1q/5v1j0NpIeS6SM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHVpRXSHgCGVtn3TF18upgZg9SXUMUBVC7uHXBWoxBoRYNCkH0vKFnHFXbMUl1wTr
	 ijWvK8CzclyiJBNh7QVrGjzImLRy8xTVq12OpfsvIikOlR6FC67qdYQeAWxQ3TcwcT
	 StbLHuugg5tauWOSKAnq5gP2kJfDke9IvizNqvlU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.14 203/241] drm/xe: Fix an out-of-bounds shift when invalidating TLB
Date: Wed, 23 Apr 2025 16:44:27 +0200
Message-ID: <20250423142628.830729242@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit 7bcfeddb36b77f9fe3b010bb0b282b7618420bba upstream.

When the size of the range invalidated is larger than
rounddown_pow_of_two(ULONG_MAX),
The function macro roundup_pow_of_two(length) will hit an out-of-bounds
shift [1].

Use a full TLB invalidation for such cases.
v2:
- Use a define for the range size limit over which we use a full
  TLB invalidation. (Lucas)
- Use a better calculation of the limit.

[1]:
[   39.202421] ------------[ cut here ]------------
[   39.202657] UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
[   39.202673] shift exponent 64 is too large for 64-bit type 'long unsigned int'
[   39.202688] CPU: 8 UID: 0 PID: 3129 Comm: xe_exec_system_ Tainted: G     U             6.14.0+ #10
[   39.202690] Tainted: [U]=USER
[   39.202690] Hardware name: ASUS System Product Name/PRIME B560M-A AC, BIOS 2001 02/01/2023
[   39.202691] Call Trace:
[   39.202692]  <TASK>
[   39.202695]  dump_stack_lvl+0x6e/0xa0
[   39.202699]  ubsan_epilogue+0x5/0x30
[   39.202701]  __ubsan_handle_shift_out_of_bounds.cold+0x61/0xe6
[   39.202705]  xe_gt_tlb_invalidation_range.cold+0x1d/0x3a [xe]
[   39.202800]  ? find_held_lock+0x2b/0x80
[   39.202803]  ? mark_held_locks+0x40/0x70
[   39.202806]  xe_svm_invalidate+0x459/0x700 [xe]
[   39.202897]  drm_gpusvm_notifier_invalidate+0x4d/0x70 [drm_gpusvm]
[   39.202900]  __mmu_notifier_release+0x1f5/0x270
[   39.202905]  exit_mmap+0x40e/0x450
[   39.202912]  __mmput+0x45/0x110
[   39.202914]  exit_mm+0xc5/0x130
[   39.202916]  do_exit+0x21c/0x500
[   39.202918]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[   39.202920]  do_group_exit+0x36/0xa0
[   39.202922]  get_signal+0x8f8/0x900
[   39.202926]  arch_do_signal_or_restart+0x35/0x100
[   39.202930]  syscall_exit_to_user_mode+0x1fc/0x290
[   39.202932]  do_syscall_64+0xa1/0x180
[   39.202934]  ? do_user_addr_fault+0x59f/0x8a0
[   39.202937]  ? lock_release+0xd2/0x2a0
[   39.202939]  ? do_user_addr_fault+0x5a9/0x8a0
[   39.202942]  ? trace_hardirqs_off+0x4b/0xc0
[   39.202944]  ? clear_bhb_loop+0x25/0x80
[   39.202946]  ? clear_bhb_loop+0x25/0x80
[   39.202947]  ? clear_bhb_loop+0x25/0x80
[   39.202950]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   39.202952] RIP: 0033:0x7fa945e543e1
[   39.202961] Code: Unable to access opcode bytes at 0x7fa945e543b7.
[   39.202962] RSP: 002b:00007ffca8fb4170 EFLAGS: 00000293
[   39.202963] RAX: 000000000000003d RBX: 0000000000000000 RCX: 00007fa945e543e3
[   39.202964] RDX: 0000000000000000 RSI: 00007ffca8fb41ac RDI: 00000000ffffffff
[   39.202964] RBP: 00007ffca8fb4190 R08: 0000000000000000 R09: 00007fa945f600a0
[   39.202965] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[   39.202966] R13: 00007fa9460dd310 R14: 00007ffca8fb41ac R15: 0000000000000000
[   39.202970]  </TASK>
[   39.202970] ---[ end trace ]---

Fixes: 332dd0116c82 ("drm/xe: Add range based TLB invalidations")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com> #v1
Link: https://lore.kernel.org/r/20250326151634.36916-1-thomas.hellstrom@linux.intel.com
(cherry picked from commit b88f48f86500bc0b44b4f73ac66d500a40d320ad)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -322,6 +322,13 @@ int xe_gt_tlb_invalidation_ggtt(struct x
 	return 0;
 }
 
+/*
+ * Ensure that roundup_pow_of_two(length) doesn't overflow.
+ * Note that roundup_pow_of_two() operates on unsigned long,
+ * not on u64.
+ */
+#define MAX_RANGE_TLB_INVALIDATION_LENGTH (rounddown_pow_of_two(ULONG_MAX))
+
 /**
  * xe_gt_tlb_invalidation_range - Issue a TLB invalidation on this GT for an
  * address range
@@ -346,6 +353,7 @@ int xe_gt_tlb_invalidation_range(struct
 	struct xe_device *xe = gt_to_xe(gt);
 #define MAX_TLB_INVALIDATION_LEN	7
 	u32 action[MAX_TLB_INVALIDATION_LEN];
+	u64 length = end - start;
 	int len = 0;
 
 	xe_gt_assert(gt, fence);
@@ -358,11 +366,11 @@ int xe_gt_tlb_invalidation_range(struct
 
 	action[len++] = XE_GUC_ACTION_TLB_INVALIDATION;
 	action[len++] = 0; /* seqno, replaced in send_tlb_invalidation */
-	if (!xe->info.has_range_tlb_invalidation) {
+	if (!xe->info.has_range_tlb_invalidation ||
+	    length > MAX_RANGE_TLB_INVALIDATION_LENGTH) {
 		action[len++] = MAKE_INVAL_OP(XE_GUC_TLB_INVAL_FULL);
 	} else {
 		u64 orig_start = start;
-		u64 length = end - start;
 		u64 align;
 
 		if (length < SZ_4K)



