Return-Path: <stable+bounces-27522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759ED879D43
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17041F22C25
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF25142916;
	Tue, 12 Mar 2024 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZ6c5v+m"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03214290A
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277837; cv=none; b=HycXq8WmJSsu8Oeu7gjVrYz5KoQVXH9tDhdlbc+xeyRUTd7Smc62ZoyjW7us2eoOg3Q6LgqmjoOsR75lxAjutzpoLnfbv8QeDafLheAYEuukJHevGbAcFght7Q7TueZyo5KC0tCK4YHfhUt1OE+C3rfOz9FCqeh1JG0HCk2i2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277837; c=relaxed/simple;
	bh=xBIKA3ePQBgw3K8JbQtqqWPl43/wdfy9XCEYM9B9MOY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uELe/yzfUa5tbqmI+OWDIlO47SBazoB+59YJTTjiSDMzYpUj7aXEWLIbnJyxeSba4PAhZz7AUw02FU3M9H6Rp+06T4cPrQWpgrgu/LzqCJvOqxGfcGZH+UKxSC7t/Mu5F0SY4hFgsyTlXbxgUReFVU0caC+/EnhjaUr4awQVnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZ6c5v+m; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710277836; x=1741813836;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xBIKA3ePQBgw3K8JbQtqqWPl43/wdfy9XCEYM9B9MOY=;
  b=kZ6c5v+mLHN5kebS6f6AUHJOfsG8BBiCW1reTMYPKUZgQ5vlgfGuAymA
   hPRW5ptBVORX8ftZlAcO4JBoK9E0AC/kd4aWiEgTibC83DyC4IS1SuzZp
   wRmhMLcTYfdVcVnnk6nSc/XAzClGt+yRDzzxhe5XqyDvQj6wJLPQYoSPv
   asT+UVXXaWaresc5Mle7pMOILItUaGgufD1+URzwgdptt/2L/EXSuN9Z7
   0adqB/DeIAxNNQGngAkwcKPIl/YcHblsSkuQFBsULYC41416pPl8FbunC
   bo+fWK4Ql9SX2SU3IGwfZROJjfRJq9g+5z/PChFPk3pNTCCoeRpxdd9Yx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5138791"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5138791"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16322649"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:10:35 -0700
Date: Tue, 12 Mar 2024 14:10:34 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 5.15.y v2 00/11] Delay VERW + RFDS 5.15.y backport
Message-ID: <20240312-delay-verw-backport-5-15-y-v2-0-e0f71d17ed1b@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIACfE8GUC/42NQQ7CIBBFr2Jm7RDAYhNX3sN0QelgiRUaqFjS9
 O6SnsDlez95f4NE0VGC22mDSNklF3wFeT6BGbV/ErqhMkguG37hDQ406YKZ4hd7bV5ziAsqFAo
 Lkrha3tq+bwVBDcyRrFuP+AMUE4oV6KofXVpCLMdnFsf6Tz4L5GgHLrU1nFsy98n5z8qcX2hiJ
 ryh2/f9Bz2jaOrSAAAA
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v2:
- This includes the backport of recently upstreamed mitigation of a CPU
  vulnerability Register File Data Sampling (RFDS) (CVE-2023-28746).
  This is because RFDS has a dependency on "Delay VERW" series, and it
  is convenient to merge them together.
- rebased to v5.15.151

v1: https://lore.kernel.org/r/20240304-delay-verw-backport-5-15-y-v1-0-fd02afc00fec@linux.intel.com

This is the backport of recently upstreamed series that moves VERW
execution to a later point in exit-to-user path. This is needed because
in some cases it may be possible for data accessed after VERW executions
may end into MDS affected CPU buffers. Moving VERW closer to ring
transition reduces the attack surface.

- The series includes a dependency commit f87bc8dc7a7c ("x86/asm: Add
  _ASM_RIP() macro for x86-64 (%rip) suffix").

- Patch 2 includes a change that adds runtime patching for jmp (instead
  of verw in original series) due to lack of rip-relative relocation
  support in kernels <v6.5.

- Fixed warning:
  arch/x86/entry/entry.o: warning: objtool: mds_verw_sel+0x0: unreachable instruction.

- Resolved merge conflicts in:
	swapgs_restore_regs_and_return_to_usermode in entry_64.S.
	__vmx_vcpu_run in vmenter.S.
	vmx_update_fb_clear_dis in vmx.c.

- Boot tested with KASLR and KPTI enabled.

- Verified VERW being executed with mitigation ON, and not being
  executed with mitigation turned OFF.

To: stable@vger.kernel.org

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---

---
H. Peter Anvin (Intel) (1):
      x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix

Pawan Gupta (9):
      x86/bugs: Add asm helpers for executing VERW
      x86/entry_64: Add VERW just before userspace transition
      x86/entry_32: Add VERW just before userspace transition
      x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
      KVM/VMX: Move VERW closer to VMentry for MDS mitigation
      x86/mmio: Disable KVM mitigation when X86_FEATURE_CLEAR_CPU_BUF is set
      Documentation/hw-vuln: Add documentation for RFDS
      x86/rfds: Mitigate Register File Data Sampling (RFDS)
      KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests

Sean Christopherson (1):
      KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH

 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/admin-guide/hw-vuln/index.rst        |   1 +
 .../admin-guide/hw-vuln/reg-file-data-sampling.rst | 104 ++++++++++++++++++++
 Documentation/admin-guide/kernel-parameters.txt    |  21 ++++
 Documentation/x86/mds.rst                          |  38 +++++---
 arch/x86/Kconfig                                   |  11 +++
 arch/x86/entry/entry.S                             |  23 +++++
 arch/x86/entry/entry_32.S                          |   3 +
 arch/x86/entry/entry_64.S                          |  11 +++
 arch/x86/entry/entry_64_compat.S                   |   1 +
 arch/x86/include/asm/asm.h                         |   5 +
 arch/x86/include/asm/cpufeatures.h                 |   3 +-
 arch/x86/include/asm/entry-common.h                |   1 -
 arch/x86/include/asm/msr-index.h                   |   8 ++
 arch/x86/include/asm/nospec-branch.h               |  27 +++---
 arch/x86/kernel/cpu/bugs.c                         | 107 ++++++++++++++++++---
 arch/x86/kernel/cpu/common.c                       |  38 +++++++-
 arch/x86/kernel/nmi.c                              |   3 -
 arch/x86/kvm/vmx/run_flags.h                       |   7 +-
 arch/x86/kvm/vmx/vmenter.S                         |   9 +-
 arch/x86/kvm/vmx/vmx.c                             |  12 ++-
 arch/x86/kvm/x86.c                                 |   5 +-
 drivers/base/cpu.c                                 |   8 ++
 include/linux/cpu.h                                |   2 +
 24 files changed, 394 insertions(+), 55 deletions(-)
---
base-commit: 57436264850706f50887bbb2148ee2cc797c9485
change-id: 20240304-delay-verw-backport-5-15-y-e16f07fbb71e

Best regards,
-- 
Thanks,
Pawan



