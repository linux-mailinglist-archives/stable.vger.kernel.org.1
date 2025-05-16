Return-Path: <stable+bounces-144642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4AEABA6D0
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 01:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9423BA0854A
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 23:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC37C280A3B;
	Fri, 16 May 2025 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeywrLHf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C123644F
	for <stable@vger.kernel.org>; Fri, 16 May 2025 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747439971; cv=none; b=EcfwmeLQ/Xfa4Kt7clglqAQRTAjBnzzyApds685M/il6F4s9mIMTKCvL6zUfYpxZlRG/wGT2Hh/bkIqPuehoc0bebzKio7Yhp8H6WkiYYzkJFR0aeibxsFmZHGq07v3U4uDLeUva5zhOvQshOJHWmsJieTwkzflivLiNgTtS9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747439971; c=relaxed/simple;
	bh=V0SdWBjt68recXf5BE4ADGpqPGKwpf0Yd1U7BRHi41o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J/njl298FY0RFUhpDAGdTO1Z1cduYBQXram72QMCBo5/xHSpazow00t7tEH1kvsQXXcYptsr/+iOSFNRWCGGNZGmuGijT4vc5FtSx9riv1uWacw8fIufoyEqgcn8r8Mz1JaPRyb6EQFoMKv2/DffpGRg/Ftk/GVq4TLp+Ptl8/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeywrLHf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747439970; x=1778975970;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V0SdWBjt68recXf5BE4ADGpqPGKwpf0Yd1U7BRHi41o=;
  b=GeywrLHfGZS/lnOx/7c+V7IrSHdakuuPY/uTOYOG3ZILfpfiQ0bqBTgV
   yFMQxkYTm9ofJtbpiqTs3LG9AiDuKRKAC8VzYXMHScam6pYn5DAQOUcmS
   Z7516dmbLNOaGSxT2gxfI+/cmxVPkPWUFKw1qAGBALpYCxqVN5vvoWK/q
   IHPhYl5RUPX3KNRKpyW468HN72Dx2xpzbCtkpXv9ykdgssudYn+ff6dHN
   N5E4m8rJrmENRf2IrXo01q7UvB8ZZ3f9qLxfxm/6ds+Sa9FUGK8qWb+M0
   qBzuWxBx6E2fogmksUyyiufd7o0/HSWBBUDLCWD7K1PQvTwPOohmbfKHX
   A==;
X-CSE-ConnectionGUID: hVcgWze6SL2x0oQgcKj6sg==
X-CSE-MsgGUID: bNecPIRsTNq6O/lxeEmgXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="66975575"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="66975575"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 16:59:29 -0700
X-CSE-ConnectionGUID: Q4K7lRKLTu6iEXpk/zcKLg==
X-CSE-MsgGUID: sXwe1WItSrOdPm4LCuuAnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="139358981"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 16:59:29 -0700
Date: Fri, 16 May 2025 16:59:28 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15 v3 00/16] ITS mitigation
Message-ID: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAKbOJ2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0Mj3cySYl1TXUNTXYNUA2MLUyMjw1RjIyWg8oKi1LTMCrBR0UoBjiH
 OHiBRUz1DU6XY2loA7MwAkmkAAAA=
X-Change-ID: 20250512-its-5-15-0e0385221e32
X-Mailer: b4 0.14.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v3:
- Added patches:
  x86/its: Fix build errors when CONFIG_MODULES=n
  x86/its: FineIBT-paranoid vs ITS

v2:
- Added missing patch to 6.1 backport.

This is a backport of mitigation for Indirect Target Selection (ITS).

ITS is a bug in some Intel CPUs that affects indirect branches including
RETs in the first half of a cacheline. Mitigation is to relocate the
affected branches to an ITS-safe thunk.

Below additional upstream commits are required to cover some of the special
cases like indirects in asm and returns in static calls:

cfceff8526a4 ("x86/speculation: Simplify and make CALL_NOSPEC consistent")
052040e34c08 ("x86/speculation: Add a conditional CS prefix to CALL_NOSPEC")
c8c81458863a ("x86/speculation: Remove the extra #ifdef around CALL_NOSPEC")
d2408e043e72 ("x86/alternative: Optimize returns patching")
4ba89dd6ddec ("x86/alternatives: Remove faulty optimization")

[1] https://github.com/torvalds/linux/commit/6f5bf947bab06f37ff931c359fd5770c4d9cbf87

---
Borislav Petkov (AMD) (1):
      x86/alternative: Optimize returns patching

Eric Biggers (1):
      x86/its: Fix build errors when CONFIG_MODULES=n

Josh Poimboeuf (1):
      x86/alternatives: Remove faulty optimization

Pawan Gupta (10):
      x86/speculation: Simplify and make CALL_NOSPEC consistent
      x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
      x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
      Documentation: x86/bugs/its: Add ITS documentation
      x86/its: Enumerate Indirect Target Selection (ITS) bug
      x86/its: Add support for ITS-safe indirect thunk
      x86/its: Add support for ITS-safe return thunk
      x86/its: Enable Indirect Target Selection mitigation
      x86/its: Add "vmexit" option to skip mitigation on some CPUs
      x86/its: Align RETs in BHB clear sequence to avoid thunking

Peter Zijlstra (3):
      x86,nospec: Simplify {JMP,CALL}_NOSPEC
      x86/its: Use dynamic thunks for indirect branches
      x86/its: FineIBT-paranoid vs ITS

 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/admin-guide/hw-vuln/index.rst        |   1 +
 .../hw-vuln/indirect-target-selection.rst          | 156 +++++++++++++
 Documentation/admin-guide/kernel-parameters.txt    |  15 ++
 arch/x86/Kconfig                                   |  11 +
 arch/x86/entry/entry_64.S                          |  20 +-
 arch/x86/include/asm/alternative.h                 |  32 +++
 arch/x86/include/asm/cpufeatures.h                 |   3 +
 arch/x86/include/asm/msr-index.h                   |   8 +
 arch/x86/include/asm/nospec-branch.h               |  57 +++--
 arch/x86/kernel/alternative.c                      | 243 ++++++++++++++++++++-
 arch/x86/kernel/cpu/bugs.c                         | 139 +++++++++++-
 arch/x86/kernel/cpu/common.c                       |  63 +++++-
 arch/x86/kernel/ftrace.c                           |   2 +-
 arch/x86/kernel/module.c                           |   7 +
 arch/x86/kernel/static_call.c                      |   2 +-
 arch/x86/kernel/vmlinux.lds.S                      |  10 +
 arch/x86/kvm/x86.c                                 |   4 +-
 arch/x86/lib/retpoline.S                           |  39 ++++
 arch/x86/net/bpf_jit_comp.c                        |   8 +-
 drivers/base/cpu.c                                 |   8 +
 include/linux/cpu.h                                |   2 +
 include/linux/module.h                             |   5 +
 23 files changed, 793 insertions(+), 43 deletions(-)
---
change-id: 20250512-its-5-15-0e0385221e32


