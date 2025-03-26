Return-Path: <stable+bounces-126722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B735A71A21
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD70B3BEABD
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CC6154430;
	Wed, 26 Mar 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzTcc8Yv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95FC1487FE
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002223; cv=none; b=pbM9CYyBxpzBGxL+7jCpDZTK0jA4LIkrgeRrx9EdxC+DMr+xXsPavOcj/IB2SjGOCcek1sJS6TRRgDzanXfv2W+rYhq3QeikL1sC2M2QxAHQgeoBGiqtaW/wRJf8VQub2EDSN6jTb1Yji2xAq058Udi/RF7d35A55GyBYe18bhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002223; c=relaxed/simple;
	bh=nh66HMd5TpjDSo6b8rcbkaC0lMNeryog+95DmuVjJzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CAlaJ8Dhr94e1GBGAYC54el+ZxbT58wCj8LBfLc5CGSv8fMp0S1xBt4cOdZh8zgprZuxtecwa0LmZWRsNDOiWG5SBDH8gEf1dC0+0E2NJsCSHHQzHNa4Tv0hkL5OrTXtb5R4P6YSV2i/W5pB6eqcwf69g2LHxUNlOiE9K43k8x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzTcc8Yv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743002222; x=1774538222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nh66HMd5TpjDSo6b8rcbkaC0lMNeryog+95DmuVjJzk=;
  b=PzTcc8YvMeM/+NXzpfTEpq4N8/L0qTlV4h0S6n9GddKTl6wAirq7lbnX
   +utVlM9BYa6hIyaPAGsaTsjETgeK5rMI1I5RU2om4A24L7AaTYWKkbmRr
   p2ueO9GGL2gdKJoNGpolDmDlJ2pB4qfCsFriy26+yl0SZywZ55bUTvXs6
   kGJHnwkpcBmXh/3kR6IDYTLWZGiPTYKCUg7MUOUzpfQBCidNMDya5bqJB
   BTNOlMYS8XAlv4mfzWeQ1hUwQtfgsjK5I81RC2kyR2Y45tI7xgkcb/hG2
   zoG0HEfGjXq07AKv+yULDzjJN0iGH0y69YVtxbVPlfu/1igBSlR3pPwG3
   Q==;
X-CSE-ConnectionGUID: zuAfnZrTTTKPPEc8d0N6Yw==
X-CSE-MsgGUID: XdBQs1iRQzyYuWFtNxpIbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61818495"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="61818495"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:17:01 -0700
X-CSE-ConnectionGUID: DdxpsL4yR7auc3zypD0tbA==
X-CSE-MsgGUID: QnXPYXtySK2yYy1/c6edlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="147995079"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.202])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 08:16:59 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v2] drm/xe: Fix an out-of-bounds shift when invalidating TLB
Date: Wed, 26 Mar 2025 16:16:34 +0100
Message-ID: <20250326151634.36916-1-thomas.hellstrom@linux.intel.com>
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
---
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
index 03072e094991..084cbdeba8ea 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -322,6 +322,13 @@ int xe_gt_tlb_invalidation_ggtt(struct xe_gt *gt)
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
@@ -346,6 +353,7 @@ int xe_gt_tlb_invalidation_range(struct xe_gt *gt,
 	struct xe_device *xe = gt_to_xe(gt);
 #define MAX_TLB_INVALIDATION_LEN	7
 	u32 action[MAX_TLB_INVALIDATION_LEN];
+	u64 length = end - start;
 	int len = 0;
 
 	xe_gt_assert(gt, fence);
@@ -358,11 +366,11 @@ int xe_gt_tlb_invalidation_range(struct xe_gt *gt,
 
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
-- 
2.48.1


