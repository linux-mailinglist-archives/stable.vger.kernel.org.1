Return-Path: <stable+bounces-164528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F4EB0FE5D
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 03:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73843546D16
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 01:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A636190664;
	Thu, 24 Jul 2025 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+lhX8gx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323D156C79;
	Thu, 24 Jul 2025 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753320960; cv=none; b=K0jaY4W7X20DuYfG+cEVeUWiCqCFqTx7ql15iZh322l5QKBZzCVumJEqXJ/DIwBedMPZUH0ozNryQNBU5MqpZtD44COJi4XITP973DDlOuMz9BlRE1T1y2OK3G6H2HZgbVGq7zDIOi6KknythoePlMce9IRf1tNz/BUcwhndEAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753320960; c=relaxed/simple;
	bh=z+nGo5hRjMtOQRT8LU6RDRf9rSnaquYa5CSInK+fhRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7S4bd2NvG6JKP/hXJ1v59vUAbKIHG4aszfoqcabnoT8jWZMH5BOAewQLxVIYNZUNtUf6eVEuAIntecNrOuFpF/dYSGTN5WNw+LRi7B2bNqJFnxZgjhSrwHlDTwxp2H6kYTLrjQGwkPWhMwjJCU2U4LSZtUIQbQRXVFu0/9p6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+lhX8gx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753320958; x=1784856958;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z+nGo5hRjMtOQRT8LU6RDRf9rSnaquYa5CSInK+fhRQ=;
  b=m+lhX8gxhANW3qRN9pnM2NlH1+O0IU4CCb1bnx6BPUVOXXjDjhZf5lJE
   vDmxyK86Y18WrPP1Nk/fCi2J38OFeViAyCU0UvcqZKts9r1xIWhL9VMjA
   lfYmRNpzK3UHbflm6uZBWSUt0RA7xcfZZ+oLDKR0U04VEi9/A7BzeGOxK
   ll/CjKkmZbv45C8LsSSa7jJOfXD5oJhE03MwUkS2/98CPGDIflODeWVKw
   hdGGn51+5dhlj00fHLST6ovo3MNMuDLwjXM6sJn59OW3WiI6M52Fd3YTZ
   RjPN4hclBOaCHnTBQQW681XPvdNncfuxRj2fg7w3z6z9DPV4VpSPw5ry8
   g==;
X-CSE-ConnectionGUID: UBeWL2l+TOmx61SvSRCNUg==
X-CSE-MsgGUID: XwYM6vurThOHb2HU5fyTsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59434473"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="59434473"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 18:35:56 -0700
X-CSE-ConnectionGUID: CQZG2qV0QDCh6EJGpQ4Yeg==
X-CSE-MsgGUID: nWXTyqtaThS4KRFZx5MWPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="164010225"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jul 2025 18:35:56 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vignesh Balasubramanian <vigbalas@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Eric Biggers <ebiggers@google.com>,
	Kees Cook <kees@kernel.org>,
	Chao Gao <chao.gao@intel.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] x86/fpu: Fix NULL dereference in avx512_status()
Date: Wed, 23 Jul 2025 18:34:21 -0700
Message-ID: <20250724013422.307954-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fushuai Wang <wangfushuai@baidu.com>

Problem
-------
With CONFIG_X86_DEBUG_FPU enabled, reading /proc/[kthread]/arch_status
causes a kernel NULL pointer dereference.

Kernel threads aren't expected to access the FPU state directly. Kernel
usage of FPU registers is contained within kernel_fpu_begin()/_end()
sections.

However, to report AVX-512 usage, the avx512_timestamp variable within
struct fpu needs to be accessed, which triggers a warning in
x86_task_fpu().

For Kthreads:
  proc_pid_arch_status()
    avx512_status()
      x86_task_fpu() => Warning and returns NULL
      x86_task_fpu()->avx512_timestamp => NULL dereference

The warning is a false alarm in this case, since the access isn't
intended for modifying the FPU state. All kernel threads (except the
init_task) have a "struct fpu" with an accessible avx512_timestamp
variable. The init_task (PID 0) never follows this path since it is not
exposed in /proc.

Solution
--------
One option is to get rid of the warning in x86_task_fpu() for kernel
threads. However, that warning was recently added and might be useful to
catch any potential misuse of the FPU state in kernel threads.

Another option is to avoid the access altogether. The kernel does not
track AVX-512 usage for kernel threads.
save_fpregs_to_fpstate()->update_avx_timestamp() is never invoked for
kernel threads, so avx512_timestamp is always guaranteed to be 0.

Also, the legacy behavior of reporting "AVX512_elapsed_ms: -1", which
signifies "no AVX-512 usage", is misleading. The kernel usage just isn't
tracked.

Update the ABI for kernel threads and do not report AVX-512 usage for
them. Not having a value in the file avoids the NULL dereference as well
as the misleading report.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Fixes: 22aafe3bcb67 ("x86/fpu: Remove init_task FPU state dependencies, add debugging warning for PF_KTHREAD tasks")
Cc: stable@vger.kernel.org
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Co-developed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v3:
 - Do not report anything for kernel threads. (DaveH)
 - Make the commit message more precise.

v2: https://lore.kernel.org/lkml/20250721215302.3562784-1-sohil.mehta@intel.com/
 - Avoid making the fix dependent on CONFIG_X86_DEBUG_FPU.
 - Include PF_USER_WORKER in the kernel thread check.
 - Update commit message for clarity.
---
 arch/x86/kernel/fpu/xstate.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9aa9ac8399ae..b90b2eec8fb8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1855,19 +1855,20 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 /*
  * Report the amount of time elapsed in millisecond since last AVX512
- * use in the task.
+ * use in the task. Report -1 if no AVX-512 usage.
  */
 static void avx512_status(struct seq_file *m, struct task_struct *task)
 {
-	unsigned long timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
-	long delta;
+	unsigned long timestamp;
+	long delta = -1;
 
-	if (!timestamp) {
-		/*
-		 * Report -1 if no AVX512 usage
-		 */
-		delta = -1;
-	} else {
+	/* AVX-512 usage is not tracked for kernel threads. */
+	if (task->flags & (PF_KTHREAD | PF_USER_WORKER))
+		return;
+
+	timestamp = READ_ONCE(x86_task_fpu(task)->avx512_timestamp);
+
+	if (timestamp) {
 		delta = (long)(jiffies - timestamp);
 		/*
 		 * Cap to LONG_MAX if time difference > LONG_MAX
-- 
2.43.0


