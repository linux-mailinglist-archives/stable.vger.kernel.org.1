Return-Path: <stable+bounces-222568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD6WCGpnpWmx+wUAu9opvQ
	(envelope-from <stable+bounces-222568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:33:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE41D6925
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C45543078386
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9B639B964;
	Mon,  2 Mar 2026 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhQ1pykq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E439E6DE;
	Mon,  2 Mar 2026 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446992; cv=none; b=dLnPcmAO340Bor38iWNFiX0i5dYVGgwp7pbSgZcvQ6VseFo510+zcfao1GmsLQnCTqGIitBpUOLdiGxn8ows1PWZ4IAmBtqp0mQc4NXqpcPlOr8mxD8dcr0R8hlaISxwWXrhUIASRDXCWgrfnmllhKtH4TPd7/fV/F2rApptOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446992; c=relaxed/simple;
	bh=/aWIE3Dcr5+hz6NBbdVqa0s6QTppmTzDdwS8/g6QuzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xj/xWgsCZttXIraHc7xiXg01qwIvXbaLHVYHxq2NJrzTAGyNLnXdqefJSzNufvu6e/I5tmJ7udExCf5jSqXG0eTFq5wajGkVPW9YAxUla8BSvNmJ/5qGGHBzIIc/S/7f94AkObgVfpoeyLOMwCAUFteneQ+Oc/jnHJGVJRQ4Fc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhQ1pykq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772446990; x=1803982990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/aWIE3Dcr5+hz6NBbdVqa0s6QTppmTzDdwS8/g6QuzU=;
  b=KhQ1pykqcqVeBi6VrrdmbzlMrDX+5uot39guXRmq3OtSul1nRYa157vc
   T1l+NL/U4xhN0JYXGxcW+hNJvOKw1qLz1MGhZ/zC7AJ2FVNahPXN2Pmt4
   wypdJUqtnATbRny2JUenUnu49YPD++/RzJF93e5d+iHV4NInvD/NZSs/S
   VuGBgxCCkzRpeoIT9NbC390k/n/GhAyoh1FRBSElmE/bRiQwj/3EZVx5Y
   Kgw5JQ6HWmwaa2gcReiE7Cpa3fYKTMJglkza+uPPzzmZPvQ/5GdNqCSoo
   V2xhUP606JKwHf/ATE5DJMXXtVlGrBzW+RGYycg/URd4HBz6hPqoac17w
   g==;
X-CSE-ConnectionGUID: r7nnCqyeQ66VRk5se1gMng==
X-CSE-MsgGUID: psTc1ovYQnCvzvbNmNBXTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="84543804"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="84543804"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 02:23:10 -0800
X-CSE-ConnectionGUID: pulhv3D9ScaLQvQnmkoQRw==
X-CSE-MsgGUID: f9uENCwuRryufeeNOPHCZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="222583104"
Received: from khuang2-desk.gar.corp.intel.com ([10.124.220.2])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 02:23:06 -0800
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
Subject: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache flush for kexec
Date: Mon,  2 Mar 2026 23:22:26 +1300
Message-ID: <20260302102226.7459-2-kai.huang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302102226.7459-1-kai.huang@intel.com>
References: <20260302102226.7459-1-kai.huang@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-222568-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 71DE41D6925
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
this_cpu_{read|write}() to __this_cpu_{read|write}() which provide the more
proper check (when CONFIG_DEBUG_PREEMPT is true), which checks all
conditions that the context cannot be moved to another CPU to run in the
middle.

Fixes: 61221d07e815 ("KVM/TDX: Explicitly do WBINVD when no more TDX SEAMCALLs")
Cc: stable@vger.kernel.org
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
---

v1 -> v2:
  - Improve changelog as discussed in v1.
  - Also mention this can also be triggered in "error path" in changelog.

Hi Rick,

Are you OK with sending this patch out to public, or do you have more
comments?

-- below is for public --

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

base-commit: 7dff99b354601dd01829e1511711846e04340a69
-- 
2.53.0


