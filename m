Return-Path: <stable+bounces-222567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JnwCRBnpWmx+wUAu9opvQ
	(envelope-from <stable+bounces-222567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:31:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F6A1D68D1
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48FB6303B5C4
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6837D399006;
	Mon,  2 Mar 2026 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQDDO2EJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7E30BF70;
	Mon,  2 Mar 2026 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446988; cv=none; b=qiryrmJo8gla4VCEhTNUKW7xRolBDHUkRFT1NEde54PAD8H027Gc2DB1SymhHqDBNW+eshTNgoOx1YLb++KGwIfHVqTDFs3/BBPa4M58CwJyqwtK88PxrH1mWQbl969C6q+bYt0rQY4zxoiRXhb9SGyyM8fD5Qu9OpUMLDyP4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446988; c=relaxed/simple;
	bh=r82dLarvdLQcWAa3IW05WQHz6P7pO9UdOp6ift+s6YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gPIYgxfPZBmmeVf1XvpXPChpZ8tLJ2omjwgUl8cRw+wbfSiIRU/pRY/QvODbvXYEQCWnSs+tn2mSNzNd/J65kBq1D1L+dgS+YMN0E92vyERBE2B+dYI4vIRPC7JqCewT/8F4QaoMeT+6g8WzSDAtWMe34XiT25RX69nhnA4+YmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQDDO2EJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772446987; x=1803982987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r82dLarvdLQcWAa3IW05WQHz6P7pO9UdOp6ift+s6YM=;
  b=jQDDO2EJPfJrjrroCmnzIifTPtE5qpP7ZdCTy7/cpOvPQBGT8sTeQaKN
   XVZb94Z3HDA2s48RlVmy1YBD2lge1ICX+d0PykgRYXG+rb+mzv53/EHK7
   +ZIdYfWJdQQ/WT86tFKiHdySVHouz43DSvCTkPvlzPD4cn8sTlkApNu8Y
   1HU/9dVKCQfQ8yQ4kz3q2lTzxUAMg9nxcKkSLn1PWqtrpH4miHPD8oNL7
   VKEC3pgZHXlJSQ966EGns1jvxI94+quFFGUutFQwB2ndPDAkbJ54P1NKV
   oYPbnl9tdnkUhCDplTTnaafbkpGu2ii494l4m7x/Xif+vBIwB4BguWocx
   A==;
X-CSE-ConnectionGUID: siTq2YrlSXS8Htd4BfIItw==
X-CSE-MsgGUID: Ev/EXUiZTyeoNvy/1oIvzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="84543798"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="84543798"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 02:23:06 -0800
X-CSE-ConnectionGUID: we/oFInrR1qnzox1OWPylA==
X-CSE-MsgGUID: NJaf2L9uRw2UQ7krpbFQfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="222583092"
Received: from khuang2-desk.gar.corp.intel.com ([10.124.220.2])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 02:23:03 -0800
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@linux.intel.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	kas@kernel.org
Cc: rick.p.edgecombe@intel.com,
	tglx@kernel.org,
	bp@alien8.de,
	mingo@redhat.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>,
	stable@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] x86/virt/tdx: Fix lockdep assertion failure in cache flush for kexec
Date: Mon,  2 Mar 2026 23:22:25 +1300
Message-ID: <20260302102226.7459-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-222567-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: D6F6A1D68D1
X-Rspamd-Action: no action

TDX can leave the cache in an incoherent state for the memory it uses.
During kexec the kernel does a WBINVD for each CPU before memory gets
reused in the second kernel.

There were two considerations for where this WBINVD should happen.  In
order to handle cases where the cache might get into an incoherent state
while the kexec is in the initial stages, it is needed to do this later
in the kexec path, when the kexecing CPU stops all remote CPUs.  However,
the later kexec process is sensitive to existing races.  So to avoid
perturbing that operation, it is better to do it earlier.

The existing solution is to track the need for the kexec time WBINVD
generically (i.e., not just for TDX) in a per-cpu var.  The late
invocation only happens if the earlier TDX specific logic in
tdx_cpu_flush_cache_for_kexec() didn’t take care of the work.  This
earlier WBINVD logic was built into KVM’s existing syscore ops shutdown()
handler, which is called earlier in the kexec path.

However, this accidentally added it to KVM’s unload path as well (also
the "error path" when bringing up TDX during KVM module load), which
uses the same internal functions.  This makes some sense too, though,
because if KVM is getting unloaded, TDX cache affecting operations will
likely cease.  So it is a good point to do the work before KVM is
unloaded and won't have a chance to handle the shutdown operation in the
future.

Unfortunately this KVM unload invocation triggers a lockdep warning in
tdx_cpu_flush_cache_for_kexec().  Since tdx_cpu_flush_cache_for_kexec()
is doing WBINVD on a specific CPU, it has an assert for preemption being
disabled.  This works fine for the kexec time invocation, but the KVM
unload path calls this as part of a CPUHP callback for which, despite
always executing on the target CPU, preemption is not disabled.

It might be better to add the earlier invocation logic to a dedicated
arch/x86 TDX syscore shutdown() handler, but to make the fix more
backport friendly just adjust the lockdep assert in the
tdx_cpu_flush_cache_for_kexec().

The real requirement is tdx_cpu_flush_cache_for_kexec() must be done on
the same CPU.  It's OK that it can be preempted in the middle as long as
it won't be rescheduled to another CPU.

Remove the too strong lockdep_assert_preemption_disabled(), and change
this_cpu_{read|write}() to __this_cpu_{read|write}() which provide the
more proper check (when CONFIG_DEBUG_PREEMPT is true), which checks all
conditions that the context cannot be moved to another CPU to run in the
middle.

Fixes: 61221d07e815 ("KVM/TDX: Explicitly do WBINVD when no more TDX SEAMCALLs")
Cc: stable@vger.kernel.org
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
---

Hi Dave, Paolo, Sean,

/facepalm.

This was recently reported by Vishal.  Sorry that I forgot to test the
module unloading (but too focused on kexecing path, which doesn't have
this issue).  This wasn't caught by our CI because there's no such test
case in CI.  Right now we are adding this to the CI so it will be covered
in the future.

---
 arch/x86/virt/vmx/tdx/tdx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 8b8e165a2001..6f6be1df4b78 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1872,9 +1872,7 @@ EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
 #ifdef CONFIG_KEXEC_CORE
 void tdx_cpu_flush_cache_for_kexec(void)
 {
-	lockdep_assert_preemption_disabled();
-
-	if (!this_cpu_read(cache_state_incoherent))
+	if (!__this_cpu_read(cache_state_incoherent))
 		return;
 
 	/*
@@ -1883,7 +1881,7 @@ void tdx_cpu_flush_cache_for_kexec(void)
 	 * there should be no more SEAMCALLs on this CPU.
 	 */
 	wbinvd();
-	this_cpu_write(cache_state_incoherent, false);
+	__this_cpu_write(cache_state_incoherent, false);
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_cpu_flush_cache_for_kexec);
 #endif

base-commit: b5425f5406ee1b4bd84720f68020ef18ce380bab
-- 
2.53.0


