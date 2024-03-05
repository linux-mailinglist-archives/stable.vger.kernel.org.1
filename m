Return-Path: <stable+bounces-26863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309BA8729C3
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 22:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB8CB20EB3
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 21:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74A812BEA3;
	Tue,  5 Mar 2024 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaDJluQg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0AE5A796
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675688; cv=none; b=TWrHxB0mZ+Melqh+zJ+hPMVAKdRrhjrlECzzpHvG7qXR+Td/6uztaAUbxq7rpqETKLxe4l7hgUTxNUEEpVlh/dmCadc8RI8XDt+xG41iH1qZf663aZIA2Qx+DJhUwt8u1btMV2Tm77J2vrvyLQKGMzpQxYxdw+G6a/I3ID/J9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675688; c=relaxed/simple;
	bh=AOS6B5MMXOiz/ObftSsk1JSF/bYunndrc9aVLTcrWUI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fx6p0jeLe8PBXr/eqzkoxLO/w/i6u3vaW8Tn5yXZBPxlPxVNt2fOMmoc62Nn9/KnZ4kSeQypzPD9RSm0W60JPdS5h5lm1e2zFvKGbF5t4zpppFtUPaPzar78nMvM/Fw2WTWg4DIFPC7pNdRGgMsQm7RFFiDyeB9i+Q/tcueonmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaDJluQg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709675687; x=1741211687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AOS6B5MMXOiz/ObftSsk1JSF/bYunndrc9aVLTcrWUI=;
  b=SaDJluQgWwsKdl0blaGaGZT5zlSjiUi1I0ROG/KRzoVaMPYXQeTwagH9
   mv2pJuHA9coLU63LzgTVaXqy1o8yt0Y+8us3cwc8poxwOGTXYFMgHZHhi
   E6O8y4gLdSt0LjXaVCdJWF4RX0RKoMaHJOs34tpR23QuGq76pGvRbRKMY
   4UeSg9+iLK3oEFAWlBesDBvDZUp9il8iB+2KSbUz1sYrPx3ZVOiwhHQDc
   mMC6u0Sbm+xY9Utc1rMbS8zC3OqiRxwfSK8mMhnHcjSYOulRZ+z3b5xiV
   UBnvsAamy2KQyEQ3lV62A95iWXHEy2evLQTy9zeiw6D1fiU785d6aHzD5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15662561"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="15662561"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:54:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9413533"
Received: from pbemalkh-mobl.amr.corp.intel.com (HELO desk) ([10.209.20.113])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:54:44 -0800
Date: Tue, 5 Mar 2024 13:54:43 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 5.10.y 0/7] Delay VERW 5.10.y backport
Message-ID: <20240305-delay-verw-backport-5-10-y-v1-0-50bf452e96ba@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIANuT52UC/x3MwQqDMAwA0F+RnBdJaxW2Xxk7ZDZq2FBJh1sR/
 33F47u8HZKYSoJbtYPJpkmXucBdKugnnkdBjcXgyQdqKGCUN2fcxL745P61LvbBFh1hRiLm2F1
 D44cAJVhNBv2d+R3a2lGd4XEcf80ut7h0AAAA
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
 arch/x86/entry/entry_64.S            | 10 ++++++++++
 arch/x86/entry/entry_64_compat.S     |  1 +
 arch/x86/include/asm/asm.h           |  5 +++++
 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/entry-common.h  |  1 -
 arch/x86/include/asm/irqflags.h      |  1 +
 arch/x86/include/asm/nospec-branch.h | 27 +++++++++++++------------
 arch/x86/kernel/cpu/bugs.c           | 15 ++++++--------
 arch/x86/kernel/nmi.c                |  3 ---
 arch/x86/kvm/vmx/run_flags.h         |  7 +++++--
 arch/x86/kvm/vmx/vmenter.S           |  9 ++++++---
 arch/x86/kvm/vmx/vmx.c               | 12 ++++++++----
 15 files changed, 111 insertions(+), 45 deletions(-)
---
base-commit: 9985c44f239fa0db0f3b4a1aee80794f113c135c
change-id: 20240304-delay-verw-backport-5-10-y-00aad69432f4

Best regards,
-- 
Thanks,
Pawan



