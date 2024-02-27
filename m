Return-Path: <stable+bounces-23830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B92868A4D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE3F2820C1
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A03A54FA6;
	Tue, 27 Feb 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSXsRQH/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357E55E57
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020805; cv=none; b=VKXYIo+nrjLXnnJ01+bmOqSMSp6hguk29jI49ulgbvtyefwiGn5TsKmwxOKqJDvHMt7oxnA39KbChxI1F164UHFEkzcob5lksvUF40N7KyPuOToDqUGn3E9fYX7moRtFEyt7gLtd3ng+ezS9R8XsxS9MrYQ/5Nakae0VUFAbUP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020805; c=relaxed/simple;
	bh=ZJPcgkGsAODEc/qyUgZ5bjDTSNB5m1McUtN55Q09+uc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bopKFPBkB1Dn36MJ0Wyt4Qi5NAtRHlun1TM8ykFmOrY4V0CaRzqGqtKCpZledzfebsFAGFy8LuD+Skhdxj3gvouTyRxMbbRHhkxQFdjEjLthpioQf044jyrjRLvA0iwkNsNvhpYT9JGEGAMnX8iwdMpOXllkWpB2T8pV+OLdAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSXsRQH/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709020803; x=1740556803;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZJPcgkGsAODEc/qyUgZ5bjDTSNB5m1McUtN55Q09+uc=;
  b=iSXsRQH/IMxPwLU113MdCVsirmP7NLzJk3tHfWq98Xrx8MLomZpr2s8c
   wBwOTfGHvdFeqKleDyaqfdw8jcT11mGhia8duaa9Bv+CCyYBLZTfewOfv
   abn1SdqMaWTe6BEM9spWm3XrlXJBOeXj1oJG3fw4QlLdsWEEU9G1zlrYn
   RhwO5hfPJqssXdiGqZTRm42yt9mjWB9/pWlgYna4AuWFP4iKD02857pA+
   EQSRw+hJFylyHS9LxyyWxoF0pPio10kHm7jRH+eUB9fRP8unFJNW0v0zl
   i4IEptjn/yZ5JFw8wVkMJQ7sGgjBJN/nJkMYvBtmvJ+I1CuTB6VSQ0phK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3509376"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3509376"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7371073"
Received: from jhaqq-mobl1.amr.corp.intel.com (HELO desk) ([10.209.17.170])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:00:01 -0800
Date: Tue, 27 Feb 2024 00:00:00 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 6.1.y 0/6] Delay VERW - 6.1.y backport
Message-ID: <20240226-delay-verw-backport-6-1-y-v1-0-b3a2c5b9b0cb@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIANWV3WUC/x3MQQqDMBBA0avIrDuShJBKr1K6iOO0HRSViahBv
 LvB5Vv8f0BiFU7wqg5QXiXJNBbYRwX0j+OPUbpicMZ541zAjoeYcWXdsI3Uz5MuGNBiRt8aYmq
 8aZ4EpZ+Vv7Lf7zeE2tYZPud5AeX9ActyAAAA
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
 arch/x86/entry/entry.S               | 22 +++++++++++++++++++++
 arch/x86/entry/entry_32.S            |  3 +++
 arch/x86/entry/entry_64.S            | 11 +++++++++++
 arch/x86/entry/entry_64_compat.S     |  1 +
 arch/x86/include/asm/cpufeatures.h   |  2 +-
 arch/x86/include/asm/entry-common.h  |  1 -
 arch/x86/include/asm/nospec-branch.h | 25 ++++++++++++------------
 arch/x86/kernel/cpu/bugs.c           | 15 ++++++--------
 arch/x86/kernel/nmi.c                |  3 ---
 arch/x86/kvm/vmx/run_flags.h         |  7 +++++--
 arch/x86/kvm/vmx/vmenter.S           |  9 ++++++---
 arch/x86/kvm/vmx/vmx.c               | 12 ++++++++----
 13 files changed, 103 insertions(+), 46 deletions(-)
---
base-commit: 81e1dc2f70014b9523dd02ca763788e4f81e5bac
change-id: 20240226-delay-verw-backport-6-1-y-4b0cec84087c


