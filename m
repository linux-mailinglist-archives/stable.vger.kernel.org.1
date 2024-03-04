Return-Path: <stable+bounces-25863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF52A86FD5C
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3DB2825C5
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A443613B;
	Mon,  4 Mar 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXdEtJUE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF01B802
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544231; cv=none; b=U5SkdFaIeGeIxAZvZ1TDntyWAYD1EmtQA1w7WUt3p214V+KGQr/ppshsXkHWbPDRjVt/YCGFmuRfRCvcy+tv2JkEUbbaCaP14To8/I2LHq46/0t/ZMToXcCNO0qVfP5P4HN8aTdC1JvQNrPUy+jxmJ4FjAwcGybhCZ+ac+3SMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544231; c=relaxed/simple;
	bh=QYMvGHvTnLhl7nIH+7UQuf979pLxyoumUvbQkWbH+/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AUv/g2Bn0LfjwFWOv80jX3xBwiRL/7q+GHRbh3zGi6VhW3mO1sNpTvVA7WB6Jrz2jOcsE4tXWf3oFrJ9yo8oF3vNCsj8AKlSPiWevzdvvFEgGvaz9gl3zQD29etx9Jxd619SyXa8Tlznq7havN9VPQrEgE5Vhn/nPxO2+BM2aJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXdEtJUE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709544230; x=1741080230;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QYMvGHvTnLhl7nIH+7UQuf979pLxyoumUvbQkWbH+/o=;
  b=FXdEtJUEL75AWtcVf+ho/bpXQ3pTGWbDler8eBj2veH3tGZi7RxmAJrc
   F3kOuSEoTEeA1jl1cf8jZt8Xsz/Sko2kuMFjVzkrHL+8Lwi0SFd2S8LfJ
   NGlySR0hrWkxWz18BeVJrt6dI2Lv8t074C5wUG1pqASUhnYG/5i3Lgoiu
   aUY2/YUsBicWfiFMC3HuZCfrWmiHWvBS4StXyHu+Vivk9z6cm7cnzmHza
   cz/A/eKd9aaZK83N3SnwiEucGk/QFMANjTr21O6L9SaEH4buoH3/6u574
   CcyKijJEzor2Cv8uX7lQv9ysy3Fbb7/81Nh442WyHMHQxwg5aAPT0HGWW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4151027"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4151027"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8885411"
Received: from smullaly-mobl1.amr.corp.intel.com (HELO desk) ([10.209.64.100])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:23:47 -0800
Date: Mon, 4 Mar 2024 01:23:46 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 6.1.y v2 0/6] Delay VERW - 6.1.y backport
Message-ID: <20240304-delay-verw-backport-6-1-y-v2-0-bf4bce517d60@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAH2S5WUC/42NQQ7CIBREr9L8tZ8A1lpdeQ/TBdCvJVZooGJJ0
 7tLegKXM5N5b4VIwVKEa7VCoGSj9a4EeajADMo9CW1fMkguay5lgz2NKmOi8EWtzGvyYcYGBWa
 sNTdk2pq3ZwPlPwV62GVn36FhgmXoSj3YOPuQd2MS+/gHPAnkqI9KmpO+FJG+jdZ9FmbdTCMz/
 g3dtm0/PMkWH88AAAA=
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
- Runtime patch jmp instead of verw in macro CLEAR_CPU_BUFFERS due to
  lack of relative addressing support in relocations in kernels <v6.5.
- Rebased to v6.1.80
- Boot tested with KASLR and KPTI enabled.
- Fixed warning:
  arch/x86/entry/entry.o: warning: objtool: mds_verw_sel+0x0: unreachable instruction
- Verified VERW being executed with mitigation ON, and not being
  executed with mitigation turned OFF.
- Rebased to v6.1.80.

v1: https://lore.kernel.org/r/20240226-delay-verw-backport-6-1-y-v1-0-b3a2c5b9b0cb@linux.intel.com

This is the backport of recently upstreamed series that moves VERW
execution to a later point in exit-to-user path. This is needed because
in some cases it may be possible for data accessed after VERW executions
may end into MDS affected CPU buffers. Moving VERW closer to ring
transition reduces the attack surface.

Patch 1/6 includes a minor fix that is queued for upstream:
https://lore.kernel.org/lkml/170899674562.398.6398007479766564897.tip-bot2@tip-bot2/

Patch 1,2,5 and 6 needed conflict resolution.

I saw a few new warnings:

  arch/x86/entry/entry.o: warning: objtool: mds_verw_sel+0x0: unreachable instruction

I tried using REACHABLE, but that did not fix the warning.

For the below warning:

  vmlinux.o: warning: objtool: .altinstr_replacement+0x17: unsupported relocation in alternatives section

not sure if this is related to this series or a pre-existing warning, I
will check later without this series.

I am not too concerned because the alternative did substitute verw
correctly:

entry_SYSCALL_64:
...
   0xffffffff8200013d <+253>:   swapgs
   0xffffffff82000140 <+256>:   verw   0xffffffff82000000
   0xffffffff82000148 <+264>:   sysretq
   0xffffffff8200014b <+267>:   int3

Cc: Dave Hansen <dave.hansen@linux.intel.com>
To: stable@vger.kernel.org

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
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
 arch/x86/include/asm/cpufeatures.h   |  2 +-
 arch/x86/include/asm/entry-common.h  |  1 -
 arch/x86/include/asm/nospec-branch.h | 27 +++++++++++++------------
 arch/x86/kernel/cpu/bugs.c           | 15 ++++++--------
 arch/x86/kernel/nmi.c                |  3 ---
 arch/x86/kvm/vmx/run_flags.h         |  7 +++++--
 arch/x86/kvm/vmx/vmenter.S           |  9 ++++++---
 arch/x86/kvm/vmx/vmx.c               | 12 ++++++++----
 13 files changed, 106 insertions(+), 46 deletions(-)
---
base-commit: a3eb3a74aa8c94e6c8130b55f3b031f29162868c
change-id: 20240226-delay-verw-backport-6-1-y-4b0cec84087c

Best regards,
-- 
Thanks,
Pawan



