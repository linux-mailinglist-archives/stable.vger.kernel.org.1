Return-Path: <stable+bounces-154601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2E4ADE026
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F03189AC41
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D20E7080D;
	Wed, 18 Jun 2025 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e65XhD6M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85E2F5301
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207448; cv=none; b=rFW3OHwtSw4rGdOG23SpCSZDfHEaTkk3KkVwxe1tKUYQe2dA41LVEo7WsHbXd/VOXMQvF+MJPLlDUkF0YWKucENETT8lgwVIpNbbReZ9K6NfjeJyPjVS1Z+A6vuZXoE7kA0X654mkYGwp/nmvXhJM3DqG9vr/gmy+2frbsAWG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207448; c=relaxed/simple;
	bh=/jtRmlcukY4RTwRJ2WWvwSSeYJJaosyXw5wV4iXDH2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uGi7nxOEEuBsAdJTRPhHRKKBF6OAioxeYRajtj35rfceVug1TB/+FFVTAhnrd25KKMVnEhrtBky/PZQgIF5W8fE5JzTwxoXj2ImFhBasShKkHL6KTVTO5VM1AmmttyzZ7/sfqSi+jh+NlckhHk057+VvqFmk6738Wc9uy5OIui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e65XhD6M; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207447; x=1781743447;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/jtRmlcukY4RTwRJ2WWvwSSeYJJaosyXw5wV4iXDH2E=;
  b=e65XhD6MuI7X6/BAYe3hpY5rG8Aaso5EEKP9rajaIu5fv8vddZH3uN5G
   IaOC192G1e0+b5RRCK8Yh/V8X3iphxsJvGND3SJ2taZZqdkbbggsOA1/h
   hHqLlUn8t58feJSRjvzA1J+JY3gf92ar6oGwev/glcffDDMCBdxADbZu2
   jwWOsuH7yLackoM4O4qMARTLJ5XYH/+YlqrftQOYH/Pojs1+WQweXfakj
   UOLndTdCDMCN8JG9hYdAS1EWSQZILr9QBdaA61hsqizss93/LF2v5EcB7
   hUnWKVrt4CQkYOky0N4HeEsfas7+2LE4aReLaQ6xxYwhRBwu3IqvCaU5I
   A==;
X-CSE-ConnectionGUID: TE9pmOsnT2KBdHyQyra4sA==
X-CSE-MsgGUID: 0h7d/9PaQvCoUlA6r+MC+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52323612"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52323612"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:44:06 -0700
X-CSE-ConnectionGUID: 3V9lD9bbR9aSRkjoKM+1vQ==
X-CSE-MsgGUID: 2CO/zttwSYqv+kpt8k9fvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="149409300"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:44:05 -0700
Date: Tue, 17 Jun 2025 17:44:05 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Guenter Roeck <linux@roeck-us.net>, Eric Biggers <ebiggers@google.com>, 
	Dave Hansen <dave.hansen@intel.com>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	holger@applied-asynchrony.com
Subject: [PATCH 5.10 v2 00/16] ITS mitigation for 5.10
Message-ID: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAIEHUmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDM0Nz3cySYl1TXUMDXRPjFMNUQ0vTJGMTUyWg8oKi1LTMCrBR0UoBjiH
 OHiBRUz1DA6XY2loAmkyKKGkAAAA=
X-Change-ID: 20250617-its-5-10-43d1e195b345
X-Mailer: b4 0.15-dev-c81fc
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v2:
- Fixed the sign-offs.

v1: https://lore.kernel.org/stable/20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com/

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
change-id: 20250617-its-5-10-43d1e195b345


