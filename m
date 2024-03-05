Return-Path: <stable+bounces-26704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E987150B
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 06:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3831C21201
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 05:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3564543ACF;
	Tue,  5 Mar 2024 05:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oot8xJGf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF51803A
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 05:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614916; cv=none; b=oOAJMX0Izmp7eLRzFWKUCYHIyuIZFDsuWwDvfa20L2VFCyj9SjStjPpdkHUq4AmPLWd7OHUxsgCk13Ft1dgswdb3PS4VVDFnUIEnh2G2lvv4XOUrU7gHV6RjPHqCYrqLh2oJzrbPYWETeLmGb4HH38nt/4NfskoZZEfzVbcZxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614916; c=relaxed/simple;
	bh=MfemCsauOwHKFucBFjK9demOrw/nyrNxaW7rP3tV72s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pXubMOp6FB7F42f/gyC1Os83vP3QjtAMuS/45fhwOZVIIW+0ypkGHgTg/lWV3V9EYavypXCQ0vHDmCfgUqlPlJLRcyTWNRy6c4ArSh2HhNzDZT0qA6Mkkaq++1fsJ3ZupNlS/3DhMEFDLPwofmorLZoTeetGpL746lcG6PcCkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oot8xJGf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709614915; x=1741150915;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MfemCsauOwHKFucBFjK9demOrw/nyrNxaW7rP3tV72s=;
  b=Oot8xJGf9eUzO7SkWYxDYPGphrw5i1zZ4BPxGLofL53wKh7qoeLw/ImT
   0AClcgczsVEL6ZPzdqzSzjELimgBEDbWVP+o7G1V1wEtlJTQEjuAT82s5
   i4+OQBorSfwQuIr0DLBevbELsPIYIs2PFpLUA2ey9e3khZl+lxZWLncvG
   8ypMlXutcsoO1n5IWAxU7CmWerzRwOOn7OoN4a3hjQuAZsFC7uM7Afxdy
   tgWPUXmgBJeTdlV1vC08yhgIuk3U/GYDUarTeWyxgo4TU0Oq35tD601My
   qAbVIY3w8wgwbJ2PvH5hj34IvEOkMW/pLunVAdvYC3Ec+fdvoTQk2iSQ6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="15285210"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="15285210"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:01:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9822560"
Received: from egolubev-mobl.amr.corp.intel.com (HELO desk) ([10.212.137.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:01:54 -0800
Date: Mon, 4 Mar 2024 21:01:52 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 5.15.y 0/7] Delay VERW 5.15.y backport
Message-ID: <20240304-delay-verw-backport-5-15-y-v1-0-fd02afc00fec@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIADem5mUC/x3MwQqDMAwA0F+RnI00zk7wV2SHVtMtTFRScSviv
 1s8vss7ILIKR+iKA5R3ibLMGVQWMHzc/GaUMRtqUzfmYRoceXIJd9Yfejd810U3tEgWEzI9g2m
 D9y0x5GBVDvK/8x5sRbZK8DrPC5OHeHl0AAAA
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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
H. Peter Anvin (Intel) (1):
      x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix

Pawan Gupta (5):
      x86/bugs: Add asm helpers for executing VERW
      x86/entry_64: Add VERW just before userspace transition
      x86/entry_32: Add VERW just before userspace transition
      x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
      KVM/VMX: Move VERW closer to VMentry for MDS mitigation

Sean Christopherson (1):
      KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH

 Documentation/x86/mds.rst            | 38 +++++++++++++++++++++++++-----------
 arch/x86/entry/entry.S               | 23 ++++++++++++++++++++++
 arch/x86/entry/entry_32.S            |  3 +++
 arch/x86/entry/entry_64.S            | 11 +++++++++++
 arch/x86/entry/entry_64_compat.S     |  1 +
 arch/x86/include/asm/asm.h           |  5 +++++
 arch/x86/include/asm/cpufeatures.h   |  2 +-
 arch/x86/include/asm/entry-common.h  |  1 -
 arch/x86/include/asm/nospec-branch.h | 27 +++++++++++++------------
 arch/x86/kernel/cpu/bugs.c           | 15 ++++++--------
 arch/x86/kernel/nmi.c                |  3 ---
 arch/x86/kvm/vmx/run_flags.h         |  7 +++++--
 arch/x86/kvm/vmx/vmenter.S           |  9 ++++++---
 arch/x86/kvm/vmx/vmx.c               | 12 ++++++++----
 14 files changed, 111 insertions(+), 46 deletions(-)
---
base-commit: 80efc6265290d34b75921bf7294e0d9c5a8749dc
change-id: 20240304-delay-verw-backport-5-15-y-e16f07fbb71e

Best regards,
-- 
Thanks,
Pawan



