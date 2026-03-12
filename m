Return-Path: <stable+bounces-224833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNI4L8OOsmlINgAAu9opvQ
	(envelope-from <stable+bounces-224833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 11:00:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CD226FF2A
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 11:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72D0030048C3
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F49B3BD63B;
	Thu, 12 Mar 2026 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0FeMx+4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C03B2FE8;
	Thu, 12 Mar 2026 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309631; cv=none; b=sGq2bRDSQTrWnN8JJxy7Og9Dh8XSxGh5LvV2PIZI+fzTqCYRtI+PH5s/zzUAuMyGfolx548vk2hPbuk0XUN0ZNB53XhzBo4HS3AVutZNuY6WDpp52zN2VJ3Mb3DgkQoDfGHE4yVzvDNnzidgCqahNZyBe93AA1J2S7lZepZi1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309631; c=relaxed/simple;
	bh=c5a9ZD92LOVUYLj0ycsN0wfbUiCK9f+lUGBp7OMHHlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BB1jcjkbLBjdN2Uf9/qXxFTIgWg+LbOfwE4p4rWuFaCQSEsJfsvljjjpihEvxvYnp20vYzDaHA+XV/CaVV8s0FxhazaD86kOtV+ezZZ2zfvhJCS7N3mK3ZQAx58UiBAGgnDkjB92TBL5R2nZyyF2MBloh+sVFRWthu0nMZkDd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0FeMx+4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773309630; x=1804845630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c5a9ZD92LOVUYLj0ycsN0wfbUiCK9f+lUGBp7OMHHlM=;
  b=Z0FeMx+4OBcE3By56ayYbMbzZyOTWMIie93MREfDS0xn6GyO1PLoaumn
   Cafn5uoA8GmfAkW6SOk2QizwV7TylVd7QZrfGrUsxzYygxnHdh6fzshFC
   veN8+3vWjjC9qv5s67yVooL5tBeYc/JD5ZQ69jFDiXKLxPdfM1ppzn7SF
   or6vIrRyAAjNcJC9B9moTU8Aj1nk7sHuGuHzDlR6IujVMbI/sB6u9USlI
   hA6wznZ4WrxPhxbVkSNMl173TH1n6DCeRtvhCuCU3bWTTdYbM7yZzUHxX
   9Hr+CzHAOXg++O0mHD7xGAn/x6rWf+jFoafWf8GaoUkj37XfS3oeOPmGF
   Q==;
X-CSE-ConnectionGUID: aqH1JkR+RdOhTm1cvxOdIA==
X-CSE-MsgGUID: u1QWBY6JRbyON0XJ5GeeCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="77006538"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="77006538"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 03:00:29 -0700
X-CSE-ConnectionGUID: LNRKgkUJTpOfTviq15UrPQ==
X-CSE-MsgGUID: e0VoEWI1SRy85I+WO+E3Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="258676692"
Received: from khuang2-desk.gar.corp.intel.com ([10.124.222.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 03:00:24 -0700
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
	Vishal Verma <vishal.l.verma@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache flush for kexec
Date: Thu, 12 Mar 2026 23:00:09 +1300
Message-ID: <20260312100009.924136-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-224833-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8CD226FF2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
tdx_cpu_flush_cache_for_kexec():

  IS_ENABLED(CONFIG_PREEMPT_COUNT) && __lockdep_enabled && (preempt_count() == 0 && this_cpu_read(hardirqs_enabled))
  WARNING: arch/x86/virt/vmx/tdx/tdx.c:1875 at tdx_cpu_flush_cache_for_kexec+0x36/0x60, CPU#0: cpuhp/0/22
  ...
  Call Trace:
   <TASK>
   vt_disable_virtualization_cpu+0x1c/0x30 [kvm_intel]
   kvm_arch_disable_virtualization_cpu+0x12/0x80 [kvm]
   kvm_offline_cpu+0x24/0x40 [kvm]
   cpuhp_invoke_callback+0x1b0/0x740
   ...

Since tdx_cpu_flush_cache_for_kexec() is doing WBINVD on a specific CPU,
it has an assert for preemption being disabled.  This works fine for the
kexec time invocation, but the KVM unload path calls this as part of a
CPUHP callback for which, despite always executing on the target CPU,
preemption is not disabled.

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
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
---

v1 -> v2:
 - Collect tags - Thanks Nikolay, Rick and Sean!.
 - Add the actual lockdep warn splat - Rick, Sean

v1: https://lore.kernel.org/lkml/20260302102226.7459-1-kai.huang@intel.com/

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

base-commit: 0f409eaea53e49932cf92a761de66345c9a4b4be
-- 
2.53.0


