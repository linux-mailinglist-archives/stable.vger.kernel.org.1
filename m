Return-Path: <stable+bounces-152324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFEBAD427E
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3363A5608
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F29825F996;
	Tue, 10 Jun 2025 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVfR1XQX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675ED25CC5E
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582391; cv=none; b=aNlJM4bVz+eSB8/QSRj1MMG/3WhJLcORmcCZvnqsbXvmHi9MS9eLiF91D3P6wz4RNCglmPIHiOjQ+QB1GlYqYIC1YHrrSSxT25M+Ui1mcN8+auJcYHoohtikfPTwXPWl8xKYxjtP+ncInW4JJgAS+2VE9m9XhUiR+hukzngrrY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582391; c=relaxed/simple;
	bh=X6KkB0mlMv4ipGJmrMH+j0EUfqmeqLj7v+d4OPoPLg4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qLRlsIBgYTmyw0s6selE5dxm8fa+0XrTPrR8DJSaMgr3aDyKfvoi1+8dgK37N/tQolaKkdJvgdo4G8nWI3GoPzkDQt54HFEukTwmDbn2IrTu2QZowyuxfwzDI7+HuBdlI+0/qohLpDx1yUanjPbYL7qGp4jPEhLPXZZ++c9lGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVfR1XQX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749582389; x=1781118389;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X6KkB0mlMv4ipGJmrMH+j0EUfqmeqLj7v+d4OPoPLg4=;
  b=GVfR1XQXhmM+3WubtgFkAnM9AxfVkuCMYOKG9vZ+zUGV7RR4Z+l2kTJD
   //rj9hN7C5qVkbLzm/3fSjD9E2uELUOmL5RF/+mBCPJiTRDwRFnlMxPyy
   MQ3VEYP6ULC0HS31XiyV9/OyRywhZpQSVnrTZ5MBPPiRAoukmDlSEfz1g
   /vEotr9Gn0BzW0DZ3o/fQiLFIYX6lFEDqwH+AJvKTtPGUvcFooaPQCZfs
   nhvh5ZXGx6x0F7tIT68AhG9mpEd+/Nm7PAdleUu18jeaBDqpTVVjds6CI
   vyiEUMs0sk+cifWouN5dyL2B97MHZ39s5S3i0MwR5SYy4WmU9m8agekBw
   A==;
X-CSE-ConnectionGUID: Gk8TQOD7T72Cwe9+VDBDVA==
X-CSE-MsgGUID: a1vOakYbTF+JNUEVlCbhvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51418037"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51418037"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:06:29 -0700
X-CSE-ConnectionGUID: cQcr3g6nQ8qrP4H8IEOCQg==
X-CSE-MsgGUID: WleVdjVcRPm5FuOZNEFfyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147869442"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:06:28 -0700
Date: Tue, 10 Jun 2025 12:06:27 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Eric Biggers <ebiggers@google.com>,
	Dave Hansen <dave.hansen@intel.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Holger =?utf-8?Q?Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Subject: [RFC PATCH 5.10 00/16] ITS mitigation for 5.10
Message-ID: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIABmBSGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwNL3cySYl1TXUMD3UQzU7PkVKNUA4vkVCWg8oKi1LTMCrBR0UpBbs4
 gsQDHEGcPEMNUz9BAKba2FgDX6E65cAAAAA==
X-Change-ID: 20250609-its-5-10-a656ce2e08ce
X-Mailer: b4 0.14.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the backport for Indirect Target Selection(ITS) mitigation for
5.10. This is only boot tested, so sending it as an RFC for now. I hope
some bot picks this up for some at-scale testing. Meanwhile I am doing
basic tests around ITS mitigation.

In addition to commits in 5.15 ITS backport, below commits are required
to make the ITS mitigation work on 5.10. These are the prime target of
scrutiny:

x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
x86/alternatives: Introduce int3_emulate_jcc()
x86/bhi: Define SPEC_CTRL_BHI_DIS_S

---
Borislav Petkov (AMD) (1):
      x86/alternative: Optimize returns patching

Daniel Sneddon (1):
      x86/bhi: Define SPEC_CTRL_BHI_DIS_S

Eric Biggers (1):
      x86/its: Fix build errors when CONFIG_MODULES=n

Josh Poimboeuf (1):
      x86/alternatives: Remove faulty optimization

Pawan Gupta (7):
      Documentation: x86/bugs/its: Add ITS documentation
      x86/its: Enumerate Indirect Target Selection (ITS) bug
      x86/its: Add support for ITS-safe indirect thunk
      x86/its: Add support for ITS-safe return thunk
      x86/its: Fix undefined reference to cpu_wants_rethunk_at()
      x86/its: Enable Indirect Target Selection mitigation
      x86/its: Add "vmexit" option to skip mitigation on some CPUs

Peter Zijlstra (4):
      x86/alternatives: Introduce int3_emulate_jcc()
      x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
      x86/its: Use dynamic thunks for indirect branches
      x86/its: FineIBT-paranoid vs ITS

Thomas Gleixner (1):
      x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()

 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/admin-guide/hw-vuln/index.rst        |   1 +
 .../hw-vuln/indirect-target-selection.rst          | 156 +++++++++++
 Documentation/admin-guide/kernel-parameters.txt    |  15 +
 arch/x86/Kconfig                                   |  11 +
 arch/x86/include/asm/alternative.h                 |  26 ++
 arch/x86/include/asm/cpufeatures.h                 |   6 +-
 arch/x86/include/asm/msr-index.h                   |  13 +-
 arch/x86/include/asm/nospec-branch.h               |  11 +
 arch/x86/include/asm/text-patching.h               |  31 +++
 arch/x86/kernel/alternative.c                      | 308 ++++++++++++++++++++-
 arch/x86/kernel/cpu/bugs.c                         | 139 +++++++++-
 arch/x86/kernel/cpu/common.c                       |  63 ++++-
 arch/x86/kernel/cpu/scattered.c                    |   1 +
 arch/x86/kernel/ftrace.c                           |   4 +-
 arch/x86/kernel/kprobes/core.c                     |  39 +--
 arch/x86/kernel/module.c                           |  14 +-
 arch/x86/kernel/static_call.c                      |   2 +-
 arch/x86/kernel/vmlinux.lds.S                      |   8 +
 arch/x86/kvm/x86.c                                 |   4 +-
 arch/x86/lib/retpoline.S                           |  39 +++
 arch/x86/net/bpf_jit_comp.c                        |   8 +-
 drivers/base/cpu.c                                 |   8 +
 include/linux/cpu.h                                |   2 +
 include/linux/module.h                             |   5 +
 25 files changed, 842 insertions(+), 73 deletions(-)
---
base-commit: 01e7e36b8606e5d4fddf795938010f7bfa3aa277
change-id: 20250609-its-5-10-a656ce2e08ce

Best regards,
-- 
Pawan



