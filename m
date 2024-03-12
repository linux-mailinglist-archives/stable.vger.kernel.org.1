Return-Path: <stable+bounces-27541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998BE879EF8
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 23:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF13EB21EA9
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57D914293;
	Tue, 12 Mar 2024 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnmzIyws"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713541740
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283225; cv=none; b=Uc0VKAh2lOLtky85WaIyCJ541FILW3MRbvXx5EEaLzUVWuPgaZ9ypJZV1h/B5uFU3ZGOKI5Jid/S4A6lUilj7K+QyNTGLf/ItwPh4z5dhLuZsBNN/62pt+ucqgt2IpSHA4zTb9prP+xvGShIUUBXQUvwtcOceFqvEOdQbbxPMTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283225; c=relaxed/simple;
	bh=3f3nXXhzc4vFZZb7ejI9cUV6A/VdCzD/nL3BfKIlEA0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lUNx886uupeh6lBtGR8AGw/8jSxE4x7DavfLcE56wPGapmSiI1ba9iagEXcATzdPUzhheNUIVk5l99gSUcpLIIQEu9LvxMos7apgbtNBnIyFcnv4htf1DnoCRdXFOd0SX82ZIT5LdG70oSNJLOITqC2UqQuyFmILyIH9nL7Nw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnmzIyws; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710283224; x=1741819224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3f3nXXhzc4vFZZb7ejI9cUV6A/VdCzD/nL3BfKIlEA0=;
  b=KnmzIywsbxbxEdBOdZcNloAu3u8vKYN7XGSD434k63BWztQfcimUUTTt
   IYxs4YtwGyyexVSX8JbJgXmLRV8QqAMoq0lSeCaTPCS1CLhEKFgepH4r7
   86J+WCqkExZd4T90wpJ0PFC9ABPTfjk90v39DhlK6LAX/y2u48Xjcqunf
   F/Wdp40FZnXgB4IgBvMKBrea+gDwSKuVhS6q+WfBTllcQ3vaR/u8gbUa5
   h1xwHSlAhz8gxlfBx474w3ndGe82qQfk7KdWFJCAokxDLXcC4VsfhtyAl
   07Nj+g3xW0IW+RAI/4sZdSOJfRPtJQ4/UGsBJXyq/NowU8RlyYrah+2Jz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22475815"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22475815"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12115969"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:40:23 -0700
Date: Tue, 12 Mar 2024 15:40:21 -0700
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
Subject: [PATCH 5.10.y v2 00/11] Delay VERW + RFDS 5.10.y backport
Message-ID: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAE3Z8GUC/33NwQqDMBAE0F+RPXfDGhPBnvofxUPUtYZalcSmB
 vHfG6TnHmcG3uzg2Vn2cM12cByst/OUgrxk0A5mejDaLmWQJBUVpLDj0UQM7D7YmPa5zG5FjTl
 hRCJjurJShewVJGBx3NvtxO+gRU4iQp36wfp1dvH8DPm5/nj9jw85EmpqeqUlV2VjbqOd3puw0
 8qjaOcX1MdxfAG71+pW0gAAAA==
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
- rebased to v5.10.212

v1: https://lore.kernel.org/r/20240305-delay-verw-backport-5-10-y-v1-0-50bf452e96ba@linux.intel.com

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
	syscall_return_via_sysret in entry_64.S
	swapgs_restore_regs_and_return_to_usermode in entry_64.S.
	__vmx_vcpu_run in vmenter.S.
	vmx_update_fb_clear_dis in vmx.c.

- Boot tested with KASLR and KPTI enabled.

- Verified VERW being executed with mitigation ON.

To: stable@vger.kernel.org

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
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
 arch/x86/entry/entry_64.S                          |  10 ++
 arch/x86/entry/entry_64_compat.S                   |   1 +
 arch/x86/include/asm/asm.h                         |   5 +
 arch/x86/include/asm/cpufeatures.h                 |   2 +
 arch/x86/include/asm/entry-common.h                |   1 -
 arch/x86/include/asm/irqflags.h                    |   1 +
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
 25 files changed, 394 insertions(+), 54 deletions(-)
---
base-commit: 7cfcd0ed929b28ff6942c2bee15816d08d6f7266
change-id: 20240304-delay-verw-backport-5-10-y-00aad69432f4

Best regards,
-- 
Thanks,
Pawan



