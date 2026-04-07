Return-Path: <stable+bounces-233728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id f4mjBGOU1WkK7wcAu9opvQ
	(envelope-from <stable+bounces-233728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 01:33:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EECE3B578A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 01:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F0E13012E45
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 23:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC760265606;
	Tue,  7 Apr 2026 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0fK4cQ0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4659883F;
	Tue,  7 Apr 2026 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775604831; cv=none; b=AqRKU8mqlRmuu540TehRPT53yuoPM6q9qdGcXggrbzQewbTvyznobaEcrHOz1QSmAJgFyk9DWR5uMODxpVP5TQ8qC49oN5fVzRk/X4GkMkP7kIzrui8LayE9zIPKQ0FRzXqwdryBvibzcVDQJhYSb2JEUInTemGc35zTQRnCe4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775604831; c=relaxed/simple;
	bh=uylsPdjPBMrkzCUjh9aG+tnh0sNL48eF1cCzfl5ptOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzGugVHPRO/uRWZ4+sLuAHw9dQOFRF5ObHCNYwzv74ohbhVLgK06m3U96Mc7pdwo+PtReBHT8cmXhBwUaZKUbZmplDDcPNMcmaKSic67vzfGKVpJE5BHsUkESP+iQfQW/YFOgFxe5gPAsgftABmuznsRAyCCS8JE+NifkP8Jdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0fK4cQ0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775604829; x=1807140829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uylsPdjPBMrkzCUjh9aG+tnh0sNL48eF1cCzfl5ptOg=;
  b=U0fK4cQ0LOtf7any1rapOIh0yQWjwk7G0aFbSo8kbDp5GY/z2V44eIKS
   wpoNGOoNXd19ac6DOhKVnwVryFu7uG6z0WUgvTDgVzEn+SXmXSY522jc9
   5AHRnHkn7Soomqj1ZAPp9cS0LJn9pkfxU8aPNyNM50Ikabhe2Gj7xlpSj
   egD0geX5oduvWxUf9gI10uaqMndzMtfVPg9O3ZX/qUxn3CSVYXPKBahw8
   PEenHwzpg8pqEwy+ve5yw6v8L+Gyqql94qxxznsPj77cnKUSrK2BggJRW
   H/4y+aZnCvbYXwH67M65h1f7KI4NIF4fHLzIu7YENJhQZnmC++eNMdQPb
   g==;
X-CSE-ConnectionGUID: ygWQ4sxiQCq/uNaQRyrl/g==
X-CSE-MsgGUID: zAR8yMcJTI2PmAXHv/ZZvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76299776"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="76299776"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 16:33:48 -0700
X-CSE-ConnectionGUID: 0a4SPlq0RwaVZTiGkKtteg==
X-CSE-MsgGUID: Qv0BvMaVRnyuCziNDzsyrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="228246249"
Received: from khuang2-desk.gar.corp.intel.com ([10.124.220.192])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 16:33:44 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@linux.intel.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com
Cc: tglx@kernel.org,
	bp@alien8.de,
	mingo@redhat.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>,
	stable@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v3] x86/virt/tdx: Fix lockdep assertion failure in cache flush for kexec
Date: Wed,  8 Apr 2026 11:33:33 +1200
Message-ID: <20260407233333.1608820-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233728-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EECE3B578A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TDX can leave the cache in an incoherent state for the memory it uses.
During kexec, the kernel does a WBINVD for all CPUs which may have
incoherent cache before memory gets reused in the second kernel.

The kernel tracks the need for the kexec-time WBINVD generically (i.e.,
not just for TDX) in a per-cpu boolean.  The TDX core also provides a
function tdx_cpu_flush_cache_for_kexec() to do the WBINVD at an earlier
time to save the kexec-time WBINVD.  This function manipulates the
per-cpu boolean, and it has a lockdep_assert_preemption_disabled() to
check that the context cannot be preempted.

This function is called from both KVM's syscore ops shutdown() handler
(which is called at an early stage in the kexec path) and the module
unload path.  The lockdep assert passes in the kexec path since the
shutdown() handler calls that function in IRQ context.  However, the
module unload path invokes it via the CPUHP callback which runs that
function in a per-cpu thread with preemption enabled.  This triggers the
lockdep warning when unloading the KVM module:

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

The lockdep warning is actually a false positive, though, because the
CPUHP callback guarantees that the function runs on the same CPU even
when preemption is enabled.  In other words, the lockdep assert of
preemption being disabled is overkill.

Remove the overkill lockdep_assert_preemption_disabled(), and change
this_cpu_{read|write}() to __this_cpu_{read|write}() which provides a
more proper preemption check (when CONFIG_DEBUG_PREEMPT is true), which
checks all conditions that the context cannot be moved to another CPU to
run in the middle.

Fixes: 61221d07e815 ("KVM/TDX: Explicitly do WBINVD when no more TDX SEAMCALLs")
Cc: stable@vger.kernel.org
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
---

v2 -> v3:

- Add Kirill's tag (Thanks!)
- Address Dave's comments (provided in internal chat) about the changelog
being not concise enough to get the main points:

  The code manipulates a per-cpu variable
  There is a preempt disable check for #1
  The preempt check passes in the kexec path, but WARN()s in the "KVM unload"
  The KVM unload path is actually OK so #3 is a false positive

v2: https://lore.kernel.org/lkml/20260312100009.924136-1-kai.huang@intel.com/


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

base-commit: 87d034b5b9f36c66bf02af587fb6935af88ffbf1
-- 
2.53.0


