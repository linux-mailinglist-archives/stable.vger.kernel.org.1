Return-Path: <stable+bounces-263124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HesRFXV4L2qqBAUAu9opvQ
	(envelope-from <stable+bounces-263124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 05:58:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE936832E8
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 05:58:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=jxxX2lqf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263124-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263124-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7757330010E8
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 03:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1402DC344;
	Mon, 15 Jun 2026 03:58:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECBA2DC798
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 03:58:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495923; cv=none; b=j//r43p5wpfFzkGiQW9WnwIoDUHCByLaGqUJ9Ze3pppUCL5KH/qMZxMBhhqMF5Ub9K7JRsxxC8zL3efszeDB2igB38KGcKeUFqmfHYyKX+UtqivgAAZF/hBMlAqdrmCVMhNoJkH58RzkaZ+csnQaN2uivMd9cdaxyfRnLQ63cs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495923; c=relaxed/simple;
	bh=9UnWuxlDIt02FlobJ9F61P36RcHWQbIkVMjHmYcTfMo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kv+aSQBpBoyGygn643IFfyCozsYidCT1RjdGmGw6NDonyYBO1VT/IoydEuUYvQwBtWA5U+n3nbQJ88mXjP+pTY9sOgg683rx9Yc8v3Er8MEj65U2OiItNbiCtxJXYYdWVJQg+ygtPer3CU3STSlZW+Suc95CuirZLi48OO7eej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jxxX2lqf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BB81F00A3A;
	Mon, 15 Jun 2026 03:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781495922;
	bh=gESUqLSVQKN5g0bF4Na7us7aAn0QI3O1pnzun44EMqQ=;
	h=Subject:To:Cc:From:Date;
	b=jxxX2lqfVtaYGomAsgNdFRMsfjgWph5hHVn8YvDEyHjeraf0+JiTGKaroOcSSMlZC
	 9Ortzll2pQ06Gph4x45LR5duOhtrCHkyw2pSMjJnmrfolnUDgJFRX3fVmk4eZaC8cT
	 ifkZV2a8Dc34qhIQTa1FSTSMIP0PeiU8l4PDQcJg=
Subject: FAILED: patch "[PATCH] KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free" failed to apply to 6.1-stable tree
To: seanjc@google.com,michael.roth@amd.com,pbonzini@redhat.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 05:57:21 +0200
Message-ID: <2026061520-nutrient-overripe-e496@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263124-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:michael.roth@amd.com,m:pbonzini@redhat.com,m:thomas.lendacky@amd.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,gregkh:mid,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CE936832E8


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x db38bcb3311053954f62b865cd2d86e164b04351
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061520-nutrient-overripe-e496@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db38bcb3311053954f62b865cd2d86e164b04351 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 20:35:42 +0200
Subject: [PATCH] KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free

Unmap and unpin the GHCB as needed when freeing a vCPU.  If the VM is
destroyed after mapping+pinning the GHCB on #VMGEXIT, without re-running
the vCPU, KVM will effectively leak the GHCB and any mappings created for
the GHCB.

Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Cc: stable@vger.kernel.org
Tested-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-18-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260529183549.1104619-18-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 11d46600cbdc..6c6a6d663e29 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3552,6 +3552,20 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	return 1;
 }
 
+static void __sev_es_unmap_ghcb(struct vcpu_svm *svm)
+{
+	if (svm->sev_es.ghcb_sa_free) {
+		kvfree(svm->sev_es.ghcb_sa);
+		svm->sev_es.ghcb_sa = NULL;
+		svm->sev_es.ghcb_sa_free = false;
+	}
+
+	if (svm->sev_es.ghcb) {
+		kvm_vcpu_unmap(&svm->vcpu, &svm->sev_es.ghcb_map);
+		svm->sev_es.ghcb = NULL;
+	}
+}
+
 void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 {
 	/* Clear any indication that the vCPU is in a type of AP Reset Hold */
@@ -3570,18 +3584,11 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 		svm->sev_es.ghcb_sa_sync = false;
 	}
 
-	if (svm->sev_es.ghcb_sa_free) {
-		kvfree(svm->sev_es.ghcb_sa);
-		svm->sev_es.ghcb_sa = NULL;
-		svm->sev_es.ghcb_sa_free = false;
-	}
-
 	trace_kvm_vmgexit_exit(svm->vcpu.vcpu_id, svm->sev_es.ghcb);
 
 	sev_es_sync_to_ghcb(svm);
 
-	kvm_vcpu_unmap(&svm->vcpu, &svm->sev_es.ghcb_map);
-	svm->sev_es.ghcb = NULL;
+	__sev_es_unmap_ghcb(svm);
 }
 
 void sev_free_vcpu(struct kvm_vcpu *vcpu)
@@ -3611,8 +3618,7 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 	__free_page(virt_to_page(svm->sev_es.vmsa));
 
 skip_vmsa_free:
-	if (svm->sev_es.ghcb_sa_free)
-		kvfree(svm->sev_es.ghcb_sa);
+	__sev_es_unmap_ghcb(svm);
 }
 
 int pre_sev_run(struct vcpu_svm *svm, int cpu)


