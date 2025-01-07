Return-Path: <stable+bounces-107922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0E7A04D89
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7024165E76
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 23:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CECC1E47DC;
	Tue,  7 Jan 2025 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2QinzP2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB113B58A;
	Tue,  7 Jan 2025 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292673; cv=none; b=n6dPgnsm9hAB7JnroEDcjpJVLxn3Lk6rM1VkTN6msQS3d5okGnPJZi7IXqFJw8GRSJqgA5onxOEKxmQiigbPSM+b1P3FWA6bWNg7yo25cBCsBDeKSMIdJfvqvJWriU42yXHLFOtPJ4Lw0n954pY+ev7FQ2Wrjs4OQSv4yr/yG+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292673; c=relaxed/simple;
	bh=YsUhYzmw80y1YSE6gNUI7jusRskc/AMDaUjoQjc+eeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9QpkVi+jV2kG0ZadwByQRnudNFNqoHZ26Z7fOmRnwuKpkdS5yrkTiWthmQyCYdbwM+Uz/VOEqtDu1VYWszGmA37gTo4XGAUcjzQJZmRfobZ/TLNEsZFzGV2aInBBp9WQrDJ+V8d/e8pRN1cXfJ4BOjFByce7GA9Cc/K1xu7jKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2QinzP2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736292670; x=1767828670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YsUhYzmw80y1YSE6gNUI7jusRskc/AMDaUjoQjc+eeE=;
  b=J2QinzP2vV3sDHSJ5kFIpCIkGNnElqz1p8EN87da81K1Y4vMwWjbPedn
   Ilp911CUbODX1zegPwDzSwxQChZuON/cp6deh5DtE6mauX3P4jJodtduy
   eBof5TtGyq7S/7/+JtjibclL4gBPSyjDFvv6cAv70z0JmwlKPgCWuwLDT
   4VMKvf/RivU/kFSK36XuXz4X5rHY1aIiWrhtyqoEHvB9oD8B4Pc8WHpxH
   O79NTIrgxOfWVXOHK0bvr6o9EL1QXrAokLduwAo7gNOvjDrU61quAvALO
   GhLgTFAo1xPHNlwCFAnYp9OiO3ei6NUeOrTweCSI5vtabJyUDg12n8ELq
   A==;
X-CSE-ConnectionGUID: KtmdkZ3iT1GC9O4T8rdUGw==
X-CSE-MsgGUID: N92GAl9iTKu92oScdnlgdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="40446785"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="40446785"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 15:31:10 -0800
X-CSE-ConnectionGUID: rHlJruxYSQeeNBK6/D9Zag==
X-CSE-MsgGUID: TizrbzUfRMK0DF7QhxLxbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106941425"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO rpedgeco-desk4..) ([10.124.221.75])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 15:31:09 -0800
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: dave.hansen@intel.com,
	bp@alien8.de
Cc: christina.schimpe@intel.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	tglx@linutronix.de,
	x86@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] x86: Check if shadow stack is active for ssp_get()
Date: Tue,  7 Jan 2025 15:30:56 -0800
Message-ID: <20250107233056.235536-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 shadow stack support has its own set of registers. Those registers
are XSAVE-managed, but they are "supervisor state components" which means
that userspace can't touch them with XSAVE/XRSTOR.  It also means that
they are not accessible from the existing ptrace ABI like the FPU register
or GPRs. Thus, there is a new ptrace get/set interface for it.

The regset code that ptrace uses provides an ->active() handler in
addition to the get/set ones. For shadow stack this ->active() handler
verifies that shadow stack is enabled via the ARCH_SHSTK_SHSTK bit in the
thread struct. The ->active() handler is checked from some callsites of
the regset get/set handlers, but not the ptrace ones. This was not
understood when shadow stack support was put in place.

As a result, both the set/get handlers can be called with
XFEATURE_CET_USER in its init state, which would cause get_xsave_addr() to
return NULL and trigger a WARN_ON(). The ssp_set() handler luckily has an
ssp_active() check to avoid surprising the kernel with shadow stack
behavior when the kernel is not read for it (ARCH_SHSTK_SHSTK==0). That
check just happened to avoid the warning.

But the ->get() side wasn't so lucky. It can be called with shadow stacks
disabled, triggering the warning in practice, as reported by Christina
Schimpe:

WARNING: CPU: 5 PID: 1773 at arch/x86/kernel/fpu/regset.c:198 ssp_get+0x89/0xa0
[...]
Call Trace:
<TASK>
? show_regs+0x6e/0x80
? ssp_get+0x89/0xa0
? __warn+0x91/0x150
? ssp_get+0x89/0xa0
? report_bug+0x19d/0x1b0
? handle_bug+0x46/0x80
? exc_invalid_op+0x1d/0x80
? asm_exc_invalid_op+0x1f/0x30
? __pfx_ssp_get+0x10/0x10
? ssp_get+0x89/0xa0
? ssp_get+0x52/0xa0
__regset_get+0xad/0xf0
copy_regset_to_user+0x52/0xc0
ptrace_regset+0x119/0x140
ptrace_request+0x13c/0x850
? wait_task_inactive+0x142/0x1d0
? do_syscall_64+0x6d/0x90
arch_ptrace+0x102/0x300
[...]

Ensure that shadow stacks are active in a thread before looking them up
in the XSAVE buffer. Since ARCH_SHSTK_SHSTK and user_ssp[SHSTK_EN] are
set at the same time, the active check ensures that there will be
something to find in the XSAVE buffer.

Fixes: 2fab02b25ae7 ("x86: Add PTRACE interface for shadow stack")
Reported-by: Christina Schimpe <christina.schimpe@intel.com>
Tested-by: Christina Schimpe <christina.schimpe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: stable@vger.kernel.org
---
v2:
 - Incorporate log feedback from Dave here:
   https://lore.kernel.org/lkml/81d3af8f-bad8-4559-8a0f-3271dd7f0abc@intel.com/

 arch/x86/kernel/fpu/regset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 6bc1eb2a21bd..887b0b8e21e3 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -190,7 +190,8 @@ int ssp_get(struct task_struct *target, const struct user_regset *regset,
 	struct fpu *fpu = &target->thread.fpu;
 	struct cet_user_state *cetregs;
 
-	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !ssp_active(target, regset))
 		return -ENODEV;
 
 	sync_fpstate(fpu);
-- 
2.47.1


