Return-Path: <stable+bounces-264904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8DOlHVCAMWoUlAUAu9opvQ
	(envelope-from <stable+bounces-264904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:56:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3369299D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:56:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=JljdT0j8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264904-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264904-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B64D230172D7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A1645348A;
	Tue, 16 Jun 2026 16:48:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AB83C09F3;
	Tue, 16 Jun 2026 16:48:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628502; cv=none; b=owes+Dv3Nkm396hEk6dJxSHkRVHz02a9AjxPEAe+B6H3PSKzp7otia8zKC/Lt6jk4+6U4y1kjdb8ln4CAx0xi9Qoo7QZwAHaWt6KmthzCWwMsFk6NcpzcNQsZFB4mxqAe4/ZX7RCPCrHUr4TDcNAyT19ZTfBh+BabX5uV2V8M+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628502; c=relaxed/simple;
	bh=oQEFOwgNzrQvkoAh2Vjs67xrusdDeaTEXsa8WQWP8UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NV00eEx71uIKCCYXOVAARw7Mh9nB692jnpNE02PhE6WherLoAaShP0q9S8qvHjnMN2BM4REdzQRnkhWQHnl0ajgj77k7MXfOIkSpZ2459cXj7Mls0Ga4YMWn+A8UT8GKLw7wL2d+8i963sosg5jp5TBlHkA6XaAdxAbEDFir91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JljdT0j8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7671F000E9;
	Tue, 16 Jun 2026 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628501;
	bh=soB1W5/qydvuk9qbgdTAXviZnMN52IUs72FjLsNrjoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JljdT0j8ezmZvJLnO7Xq9wLG0Qf9mj+5/sq7xGJww+Z0MYp/EPkkBlCM7f/V9kM/F
	 +Jzhrgdg8bIGGkJVlzkOVTd1AsRW8Z+MARYQjNSz/MSxC7LNdkrTypONpI3iZaVyEQ
	 LQhGRPHLTnFziQJwUGYBFLP45bugvwmMy4UL8bsg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Naveen N Rao (AMD)" <naveen@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.6 106/452] KVM: SVM: Flush the current TLB when transitioning from xAVIC => x2AVIC
Date: Tue, 16 Jun 2026 20:25:33 +0530
Message-ID: <20260616145123.343980225@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264904-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:naveen@kernel.org,m:seanjc@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DC3369299D

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit a9e18aa3263f356edae305e29830e5fe63d8597a upstream.

Flush the current TLB when xAVIC *or* x2AVIC is activated, as KVM is
(apparently) responsible for purging TLB entries when transitioning from
xAVIC to x2AVIC.  The APM says a whole lot of nothing about TLB flushing
with respect to (x2)AVIC, but empirical data strongly suggests hardware
also does a whole lot of nothing.

Failure to flush the TLB when enabling x2AVIC can lead to guest accesses
to the APIC base address getting incorrectly redirected to the virtual
APIC page.  The flaw most visibly manifests as failures in KVM-Unit-Test's
verify_disabled_apic_mmio() testcase when x2APIC is enabled (though for
reasons unknown, the test only reliably fails with EFI builds).

Fixes: 0ccf3e7cb95a ("KVM: SVM: Flush the "current" TLB when activating AVIC")
Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://patch.msgid.link/20260515171536.1841645-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/avic.c |   35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -111,6 +111,35 @@ static void avic_activate_vmcb(struct vc
 	svm_clr_intercept(svm, INTERCEPT_CR8_WRITE);
 
 	/*
+	 * Flush the TLB when enabling (x2)AVIC and when transitioning between
+	 * xAVIC and x2AVIC, as the CPU may have inserted a TLB entry for the
+	 * "wrong" mapping.
+	 *
+	 * KVM uses a per-VM "scratch" page to back the APIC memslot, because
+	 * KVM also uses per-VM page tables *and* maintains the page table (NPT
+	 * or shadow page) mappings for said memslot even if one or more vCPUs
+	 * have their local APIC hardware-disabled or are in x2APIC mode, i.e.
+	 * even if one or more vCPUs' APIC MMIO BAR is effectively disabled.
+	 *
+	 * If xAVIC is fully enabled, hardware ignores the physical address in
+	 * KVM's page tables, i.e. in the leaf SPTE for the APIC memslot, and
+	 * instead redirects the access to the AVIC backing page, i.e. to the
+	 * vCPU's virtual APIC page.  If xAVIC is not enabled (APIC is either
+	 * hardware-disabled or in x2APIC mode), then guest accesses will use
+	 * the page table mapping verbatim, i.e. will access the per-VM scratch
+	 * page, as normal memory.
+	 *
+	 * In both cases, the CPU is allowed to cache TLB entries for the APIC
+	 * base GPA.  So, KVM needs to flush the TLB when enabling xAVIC, as
+	 * accesses need to be redirected to the virtual APIC page, but the TLB
+	 * may contain entries pointing at the scratch page.  KVM also needs to
+	 * flush the TLB when enabling x2AVIC, as accesses need to go to the
+	 * scratch page, but the TLB may contain entries tagged as xAVIC, i.e.
+	 * entries pointing to the vCPU's virtual APIC page.
+	 */
+	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
+
+	/*
 	 * Note: KVM supports hybrid-AVIC mode, where KVM emulates x2APIC MSR
 	 * accesses, while interrupt injection to a running vCPU can be
 	 * achieved using AVIC doorbell.  KVM disables the APIC access page
@@ -123,12 +152,6 @@ static void avic_activate_vmcb(struct vc
 		/* Disabling MSR intercept for x2APIC registers */
 		svm_set_x2apic_msr_interception(svm, false);
 	} else {
-		/*
-		 * Flush the TLB, the guest may have inserted a non-APIC
-		 * mapping into the TLB while AVIC was disabled.
-		 */
-		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
-
 		/* Enabling MSR intercept for x2APIC registers */
 		svm_set_x2apic_msr_interception(svm, true);
 	}



