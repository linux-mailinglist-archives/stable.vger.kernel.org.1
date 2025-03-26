Return-Path: <stable+bounces-126700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7EFA71610
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 12:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A24F1720CC
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 11:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835A91DC997;
	Wed, 26 Mar 2025 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bD6S/cUb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3E15199A
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989896; cv=none; b=aWha+GGe1gjTEZhPtvYcXo3E+HiwM/MwdqOmHPAfgdFEcE5Tjz5Otgwp/DAY514ap8AkK2R6K6P0GK3RNRN9l6yD3wwesSwoGJe3Xm/NBaaRc3/l+WJn513QGWJxFCXsB0NYFiMpp8cDwDGSh8g8yZbNAH4tXw2mMfHpW4WVrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989896; c=relaxed/simple;
	bh=DHeB8p4YVbj/MKcoieMbqKJPCEP9BbXIdyH3ILhkoaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BOGS9scfSlWh4SXLfO0Pmc+BQ2nGFOHIU3wDwG8K0LR/oLWhhYmao0KHPaKR+DAkQXx+HDDy0a4k2Gx3iSkkOixTRoPPHwRHvLj8ndH8McxUQgWQINIDRZQwUizm2Dh8Hkv3BzsqkBHOHZzev1ztP7F5GkWZnP59LQFb8OaWOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bD6S/cUb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742989895; x=1774525895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DHeB8p4YVbj/MKcoieMbqKJPCEP9BbXIdyH3ILhkoaY=;
  b=bD6S/cUbXu3gRx3fEZ95OJgZUqzENx3WddwdCQlfIJNuCrf5tSYJM0h7
   czNDGlCnB1LFVu+gKFvUFahrFN6r7cxzyrP6GU8e1asmJS5PUhimAexmG
   dZezntF62UOvhIq/Ns4Tega/I7MXduxXPtrQy15UZ8PJZlVOVcJen9wVw
   HqPmllkS7y1/Kfv7rdn693RtH6jc+gm2GJ3I+tAD8EQq1olcIj6ZMCnLz
   iwb/2K7UeHayw7KdMQyvV3L/pXszFr6o89fPJa7RcC1BlG5SGDedMoxoS
   1DFBeXtY8BB7KTNdG++sH2KXE++Z6E3PDv9T/26ZFpjphCQYISGh/XjWu
   A==;
X-CSE-ConnectionGUID: umO3SiYTRN+SR+QZ9actjg==
X-CSE-MsgGUID: +T/4gAqnRW6S7bcw+iJ66g==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55273999"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="55273999"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 04:51:34 -0700
X-CSE-ConnectionGUID: 2Xl+C3GeRz+tg13W0J50+w==
X-CSE-MsgGUID: 9IVKGvErTW2urpC631uWjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="129585514"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.202])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 04:51:32 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Fix an out-of-bounds shift when invalidating TLB
Date: Wed, 26 Mar 2025 12:51:17 +0100
Message-ID: <20250326115117.14673-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the size of the range invalidated is larger than
U64_MAX / 2 + 1, The function roundup_pow_of_two(length) will
hit an out-of-bounds shift.

Use a full TLB invalidation for such cases.

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
---
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
index 03072e094991..79f8fe127867 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -346,6 +346,7 @@ int xe_gt_tlb_invalidation_range(struct xe_gt *gt,
 	struct xe_device *xe = gt_to_xe(gt);
 #define MAX_TLB_INVALIDATION_LEN	7
 	u32 action[MAX_TLB_INVALIDATION_LEN];
+	u64 length = end - start;
 	int len = 0;
 
 	xe_gt_assert(gt, fence);
@@ -358,11 +359,10 @@ int xe_gt_tlb_invalidation_range(struct xe_gt *gt,
 
 	action[len++] = XE_GUC_ACTION_TLB_INVALIDATION;
 	action[len++] = 0; /* seqno, replaced in send_tlb_invalidation */
-	if (!xe->info.has_range_tlb_invalidation) {
+	if (!xe->info.has_range_tlb_invalidation || length > (U64_MAX >> 1) + 1) {
 		action[len++] = MAKE_INVAL_OP(XE_GUC_TLB_INVAL_FULL);
 	} else {
 		u64 orig_start = start;
-		u64 length = end - start;
 		u64 align;
 
 		if (length < SZ_4K)
-- 
2.48.1


