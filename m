Return-Path: <stable+bounces-263126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8QzLOXx4L2qtBAUAu9opvQ
	(envelope-from <stable+bounces-263126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 05:58:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB566832F3
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 05:58:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=d1cvdJqf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263126-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263126-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A41B30028B4
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 03:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A058C2DC76F;
	Mon, 15 Jun 2026 03:58:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638912AD2C
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 03:58:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495930; cv=none; b=FdttO8q20ObNFOLbpk7PFwwglDs2DtvfzoF6H/Tw+6o7P8vOgvjb1GT3N78XnqY++qSLnma/oqWMEeI1LAQKvhiEfG/++cEwRecWRHnJ8iHTF5VssewSkpSIu6G3CgCsep4ae7LfX+KaRaWuA5z4DGQxoznw4oMChXkttMd6mvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495930; c=relaxed/simple;
	bh=L8ETtziHZDdGAmqOVQGOpmlXp47+bMsth36kztNtCEo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=psTBKESgkqBSP9TDbemOXa6EHtdz8S146++bJ2ahKF2InoT5UfkbYyaUn6ttmSvZB6wnkP9pB1iilvDZ35zSf1jnNpmDk9VS9hRzdOLIxHz1Po7IYL7SgaLq0DFyGwf7VCXSJZ7/PQsLeU2uRHXKSvOXsou5knpsWBNq5K5BzvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d1cvdJqf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85A01F000E9;
	Mon, 15 Jun 2026 03:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781495929;
	bh=JZaAAKvRL/7bVgImB+W5f2yJLXrXWkjjjGuCbNj/rf8=;
	h=Subject:To:Cc:From:Date;
	b=d1cvdJqf+eOQxCQ3sXxAx6Nex7UZnWcpWcdA4+zU0D2oTQwPXgeJvxNamanZ7nPjl
	 EXb7xjzXYKviWPUwljZqU0spoNqq9HU6KlpWl/xLfxd1dd6byh7FLCyOnyqM7w6e38
	 RfxlI0CD4bUzzuxd8NZqlDPv30U1CYuOO+xwScrc=
Subject: FAILED: patch "[PATCH] KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()" failed to apply to 6.12-stable tree
To: seanjc@google.com,michael.roth@amd.com,pbonzini@redhat.com,thomas.lendacky@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 05:57:32 +0200
Message-ID: <2026061532-bullish-evasion-0742@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263126-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:michael.roth@amd.com,m:pbonzini@redhat.com,m:thomas.lendacky@amd.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,gregkh:mid,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DB566832F3


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 08385c5e1814edee829ffe475d559ed730354335
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061532-bullish-evasion-0742@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 08385c5e1814edee829ffe475d559ed730354335 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 20:35:40 +0200
Subject: [PATCH] KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()

Relocate sev_free_vcpu() down in sev.c so that it's definition comes after
sev_es_unmap_ghcb().  This will allow sharing unmap functionality between
the two functions without needing a forward declaration (or weird placement
of the common code).

No functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-16-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260529183549.1104619-16-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 4ebe0d449789..437282f0ea94 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3313,37 +3313,6 @@ void sev_guest_memory_reclaimed(struct kvm *kvm)
 	sev_writeback_caches(kvm);
 }
 
-void sev_free_vcpu(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm;
-
-	if (!is_sev_es_guest(vcpu))
-		return;
-
-	svm = to_svm(vcpu);
-
-	/*
-	 * If it's an SNP guest, then the VMSA was marked in the RMP table as
-	 * a guest-owned page. Transition the page to hypervisor state before
-	 * releasing it back to the system.
-	 */
-	if (is_sev_snp_guest(vcpu)) {
-		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
-
-		if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K))
-			goto skip_vmsa_free;
-	}
-
-	if (vcpu->arch.guest_state_protected)
-		sev_flush_encrypted_page(vcpu, svm->sev_es.vmsa);
-
-	__free_page(virt_to_page(svm->sev_es.vmsa));
-
-skip_vmsa_free:
-	if (svm->sev_es.ghcb_sa_free)
-		kvfree(svm->sev_es.ghcb_sa);
-}
-
 static void dump_ghcb(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -3618,6 +3587,37 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 	svm->sev_es.ghcb = NULL;
 }
 
+void sev_free_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm;
+
+	if (!is_sev_es_guest(vcpu))
+		return;
+
+	svm = to_svm(vcpu);
+
+	/*
+	 * If it's an SNP guest, then the VMSA was marked in the RMP table as
+	 * a guest-owned page. Transition the page to hypervisor state before
+	 * releasing it back to the system.
+	 */
+	if (is_sev_snp_guest(vcpu)) {
+		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
+
+		if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K))
+			goto skip_vmsa_free;
+	}
+
+	if (vcpu->arch.guest_state_protected)
+		sev_flush_encrypted_page(vcpu, svm->sev_es.vmsa);
+
+	__free_page(virt_to_page(svm->sev_es.vmsa));
+
+skip_vmsa_free:
+	if (svm->sev_es.ghcb_sa_free)
+		kvfree(svm->sev_es.ghcb_sa);
+}
+
 int pre_sev_run(struct vcpu_svm *svm, int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);


