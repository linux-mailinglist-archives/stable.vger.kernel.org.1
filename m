Return-Path: <stable+bounces-264677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gQy9FQV7MWq/kQUAu9opvQ
	(envelope-from <stable+bounces-264677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:34:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C22EF69236E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:34:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=F+GrBfST;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264677-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264677-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC9703076338
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CB7472764;
	Tue, 16 Jun 2026 16:27:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26843A6B61;
	Tue, 16 Jun 2026 16:27:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627233; cv=none; b=HASMjuttZ/H2ylAhzXJNxMShp4PifkCiahhfumaPkRMAUIjl4qX2zsMOn6YiCu82zzFmlLvb8o/qwf7ywTDtVwqQKGOZ5n+ubpTdOfh0rlee499dcfVr7FsVC0yIQsKel+NqUq75apankrlWh6rCyW2NFyhyp/eVOgUbC9idji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627233; c=relaxed/simple;
	bh=Mt3n6NJ3gjyIq0V9K6Dt6XDJoUPcQBSCad98CTO+zj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQWmqEykD5T+FWDoshCgICO+0MTmJz6TaEikDtpTGd+8sr9IJRNU7oCM+lnDGMBBDldVktoFynA51GCuGTXJ3HUDN9lG69Yz2W9qVOMShyx1Ft7Csxq1MnxyWKv/4VntKCC744YJQTIPI+cDmg2ZplFHa1+YogH1eIAHClQwN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F+GrBfST; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09F51F000E9;
	Tue, 16 Jun 2026 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627232;
	bh=4A+f/9zpHWoGsrKxDNKqLCRb2aZe+XGCiLSNLQuAYng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F+GrBfSTAGBins4bVtR8Cgny3hhiyoHHtHKwu1wkSyaf7gMW0BNs2dKH094OS/Nc/
	 V2n3wsa6tkqVKsZ8RpJtz1tzl3hHsAlBIv8cWyKNb/LbOIjU88DidgdtsXJTrB/mlU
	 QmqFzV9EGcCOJmEzcSzFul+/nPL9nlGxPW8n6L1Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Roth <michael.roth@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.12 133/261] KVM: Dont WARN if memory is dirtied without a vCPU when the VM is dying
Date: Tue, 16 Jun 2026 20:29:31 +0530
Message-ID: <20260616145051.250017449@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264677-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.roth@amd.com,m:seanjc@google.com,m:pbonzini@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C22EF69236E

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 8618004d3e897c0f1b71d9a9ab860461289bb89a upstream.

When marking a page dirty, complain about not having a running/loaded vCPU
if and only if the VM is still alive, i.e. its refcount is non-zero.  This
will allow fixing a memory leak for x86 SEV-ES guests without hitting what
is effectively a false positive on the WARN.

For some SEV-ES VM-Exits, KVM keeps a writable mapping of a guest page
across an exit to userspace, and typically unmaps the page on the next
KVM_RUN.  But if userspace never calls KVM_RUN after such an exit, then KVM
needs to unmap the page when the vCPU is destroyed, which in turn triggers
the WARN about not having a running vCPU.

Alternatively, SEV-ES could temporarily load the vCPU to suppress the WARN,
as is done in nested_vmx_free_vcpu() (but for completely unrelated reasons;
suppressing WARN from nested_put_vmcs12_pages() is pure happenstance).  But
loading a vCPU during destruction is gross (ideally nVMX code would be
cleaned up), risks complicating the SEV-ES code (KVM would need to ensure
the temporarily load()+put() only runs when the vCPU isn't already loaded),
and is ultimately pointless.

The motivation for the WARN is to guard against KVM dirtying guest memory
without pushing the corresponding GFN to the active vCPU's dirty ring, e.g.
to ensure userspace doesn't miss a dirty page.  But for the VM's refcount
to reach zero, there can't be _any_ userspace mappings to the dirty ring,
as mapping the dirty ring requires doing mmap() on the vCPU FD.  I.e. if
userspace had a valid mapping for the dirty ring, then the vCPU file and
thus the owning VM would still be alive.  And so since userspace can't
possibly reach the dirty ring, whether or not KVM technically "misses" a
push to the dirty ring is irrelevant.

Reported-by: Michael Roth <michael.roth@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-15-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260529183549.1104619-15-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/kvm_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3611,7 +3611,8 @@ void mark_page_dirty_in_slot(struct kvm
 	if (WARN_ON_ONCE(vcpu && vcpu->kvm != kvm))
 		return;
 
-	WARN_ON_ONCE(!vcpu && !kvm_arch_allow_write_without_running_vcpu(kvm));
+	WARN_ON_ONCE(!vcpu && refcount_read(&kvm->users_count) &&
+		     !kvm_arch_allow_write_without_running_vcpu(kvm));
 #endif
 
 	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {



