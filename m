Return-Path: <stable+bounces-241835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEK6AVuz8WmwjgEAu9opvQ
	(envelope-from <stable+bounces-241835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:29:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDB749077C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E0EF3014FD5
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F153A5E69;
	Wed, 29 Apr 2026 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dS1BH+oy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2FE3A544A;
	Wed, 29 Apr 2026 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447748; cv=none; b=jYjS73RQDbxY1kYZTIZYkVOs91VB7tDKzHgNNMkY2hSZ25IaVzt5WepbNPyJCw7KxT9XJlYRDNRv8TOOavE667ipFA1g/hnYfoRK7cSJuXOiGAraFYYI7vPtuMjpabqdwqpiJGrMQMrDFdrtt5t8zV2V2BTDi7zooZC+o+81eo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447748; c=relaxed/simple;
	bh=ZQOkCYnVZVIH8EPI+hVf+trWhsoG6Ezt8CwwxR3iaFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKYyvuBrK2611aFac9OliDmNrSgV7ciJbHmpEI1+Lp4QcMgzPRk7ZQ6QrnkSiyAtLn5rxsFaEocEuwALLtNRORmx0FlqxWox38aMkOuO/s2lzjskwHb9Rt6KpHYzBP7bXAYfwxLlhyOMndH60W2+1zC+vcjgkPASZbxVeIslID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dS1BH+oy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777447747; x=1808983747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZQOkCYnVZVIH8EPI+hVf+trWhsoG6Ezt8CwwxR3iaFc=;
  b=dS1BH+oyNU7JxF0rLYnzXZB42C3nE9N9mpUk2wIY97EgpRHfihcS3ZgV
   Ble6foL92JI6UTSxyPgQwj1u89K/JwWrcNhvXFjqMDESovLsAl4YfQ8ye
   cDyKMS8bmSIIF4dJ469x/k9uACwI48DyBCDdtSrSGH3aglX3lvkCttahV
   sZr+3mxlCws7DOQHpxtbrc4/sau9+NjVs0Q265U6B4CZKKEOcllAdClXm
   rjjJRFrVRlw5dEfYJxV696cwohAw1BiersMyp0JZuhchJ1KRU7LWndg7B
   yySG/GzT33qwh4x6m5M+8pqpizWPxwFcP9uNnnRatWmYqNHN0R40miAbx
   w==;
X-CSE-ConnectionGUID: 1+7SY+m4Q5GkdY7FWHh50Q==
X-CSE-MsgGUID: dEOHlRmnSPC+jMYpqO/UPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78385801"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78385801"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:29:07 -0700
X-CSE-ConnectionGUID: +1M7tQq+Q2egq0jq81cD9g==
X-CSE-MsgGUID: hse7KraFR/eiex16L4hUgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="272324268"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:29:05 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: kvm@vger.kernel.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Gao Chao <chao.gao@intel.com>,
	stable@vger.kernel.org,
	Farrah Chen <farrah.chen@intel.com>
Subject: [PATCH v2 1/2] KVM: x86: Always report highest IRR from __kvm_apic_update_irr()
Date: Wed, 29 Apr 2026 15:28:07 +0800
Message-ID: <20260429072851.3004430-2-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260429072851.3004430-1-chenyi.qiang@intel.com>
References: <20260429072851.3004430-1-chenyi.qiang@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CDDB749077C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241835-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenyi.qiang@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Compute *max_irr from the existing IRR in __kvm_apic_update_irr() even
when pi_harvest_pir() returns false (PIR is empty), instead of leaving
*max_irr uninitialized at -1.

In a nested VM stress test, the following WARNING fires in
vmx_check_nested_events() when kvm_cpu_has_interrupt() reports a pending
interrupt but the subsequent kvm_apic_has_interrupt() (which invokes
vmx_sync_pir_to_irr() again) returns -1:

  WARNING: CPU: 99 PID: 57767 at arch/x86/kvm/vmx/nested.c:4449 vmx_check_nested_events+0x6bf/0x6e0 [kvm_intel]
  Call Trace:
   kvm_check_and_inject_events
   vcpu_enter_guest.constprop.0
   vcpu_run
   kvm_arch_vcpu_ioctl_run
   kvm_vcpu_ioctl
   __x64_sys_ioctl
   do_syscall_64
   entry_SYSCALL_64_after_hwframe

The root cause is a race between vmx_sync_pir_to_irr() on the target vCPU
and __vmx_deliver_posted_interrupt() on a sender vCPU.  The sender
performs two individually-atomic operations that are not a single
transaction:

  1. pi_test_and_set_pir(vector)  -- sets the PIR bit
  2. pi_test_and_set_on()         -- sets PID.ON

The following interleaving triggers the bug:

  Sender vCPU (IPI):              Target vCPU (1st sync_pir_to_irr):
  B1: set PIR[vector]
                                  A1: pi_clear_on()
                                  A2: pi_harvest_pir() -> sees B1 bit
                                  A3: xchg() -> consumes bit, PIR=0
                                      (1st sync returns correct max_irr)
  B2: set PID.ON = 1

                                  Target vCPU (2nd sync_pir_to_irr):
                                  C1: pi_test_on() -> TRUE (from B2)
                                  C2: pi_clear_on() -> ON=0
                                  C3: pi_harvest_pir() -> PIR empty
                                  C4: *max_irr = -1, early return
                                      IRR NOT SCANNED

The interrupt is not lost (it resides in the IRR from the first sync and
is recovered on the next vcpu_enter_guest() iteration), but the incorrect
max_irr causes a spurious WARNING and a wasted L2 VM-Enter/VM-Exit cycle.

Fix this by scanning the IRR via apic_find_highest_vector() in
__kvm_apic_update_irr() when PIR is empty, so that *max_irr always
reflects the true highest pending interrupt regardless of PIR state.

Fixes: b41f8638b9d3 ("KVM: VMX: Isolate pure loads from atomic XCHG when processing PIR")
Cc: stable@vger.kernel.org
Reported-by: Farrah Chen <farrah.chen@intel.com>
Assisted-by: GitHub Copilot:Claude Opus 4.6
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 arch/x86/kvm/lapic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9381c58d4c85..e9f1e5451160 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -669,12 +669,14 @@ bool __kvm_apic_update_irr(unsigned long *pir, void *regs, int *max_irr)
 	u32 irr_val, prev_irr_val;
 	int max_updated_irr;
 
+	if (!pi_harvest_pir(pir, pir_vals)) {
+		*max_irr = apic_find_highest_vector(regs + APIC_IRR);
+		return false;
+	}
+
 	max_updated_irr = -1;
 	*max_irr = -1;
 
-	if (!pi_harvest_pir(pir, pir_vals))
-		return false;
-
 	for (i = vec = 0; i <= 7; i++, vec += 32) {
 		u32 *p_irr = (u32 *)(regs + APIC_IRR + i * 0x10);
 
-- 
2.43.5


