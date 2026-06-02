Return-Path: <stable+bounces-259918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uBCGHj9cH2pAlAAAu9opvQ
	(envelope-from <stable+bounces-259918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 00:42:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3E3632833
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 00:42:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=sTPVwVRE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259918-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259918-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E811E3048920
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 22:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E803C73DD;
	Tue,  2 Jun 2026 22:36:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B62A3ADBAF
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 22:36:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439814; cv=none; b=M9G7qIzzA4pEYwJ3m54i1yMtY+fAv4GzLjYDuwnX9yMJdGfanLaZ3VEdI/HrpUqfD/vSObuTbhYFZGM5OI5xghDT6iu/WDjTaZ5yRLJAIBvinJO2/NFgniI58diFz8O8MSW/yo+QN0wvJyclv8T+9sboPodeeymRtrn1wnAbWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439814; c=relaxed/simple;
	bh=nLmgK2QUTw1cM7CspAyD0+EJIbz7/EpovpRhFQ4nPyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uar8u8LkpOVvQ3qLFJ5xzHynSR1rhloNJoH/+lVKlPX7RPGmFjl5/oD01WQt0KkjgHQSWbjjxbrNEMoDq1lmIu1PKk4DjgHLWqM5Iy3IB+NO/IiV8KCYdUvHiguoWGi9eEQHp6mGsYwWGBQXLYbVOmJM1AHkKTVWkxyQbTZABrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sTPVwVRE; arc=none smtp.client-ip=91.218.175.185
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780439809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YU3VGYDHMSuXOk2TlF1/XLiQKn7O+Ll77KLtsMACVqw=;
	b=sTPVwVRERoNEMtd4MBnKVafqVhpUTs8gV9/gqRM5ohPJ/FIyyFE5GYSGX/KRLRdW3b2lmM
	9cPxHthtwG58xNu1E+sTSkJ3db3Qw2qvZ+C4DjePNsJ99tmYajze3IFMoJo6v7H0xsT3se
	3k/HD1lbSAoevqEJRoLu99K/zbyN2Ac=
From: Atish Patra <atish.patra@linux.dev>
Date: Tue, 02 Jun 2026 15:36:32 -0700
Subject: [PATCH v3 1/4] KVM: SEV: Do not allow intra-host
 migration/mirroring of SNP VMs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-sev_snp_fixes-v3-1-24bfd3ae047c@meta.com>
References: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
In-Reply-To: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
To: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Peter Gonda <pgonda@google.com>, Brijesh Singh <brijesh.singh@amd.com>, 
 Youngjae Lee <youngjaelee@meta.com>, Ashish Kalra <ashish.kalra@amd.com>, 
 Michael Roth <michael.roth@amd.com>, John Allen <john.allen@amd.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: clm@meta.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-crypto@vger.kernel.org, stable@vger.kernel.org, 
 Atish Patra <atishp@meta.com>, Sashiko <sashiko-bot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:pbonzini@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:thomas.lendacky@amd.com,m:pgonda@google.com,m:brijesh.singh@amd.com,m:youngjaelee@meta.com,m:ashish.kalra@amd.com,m:michael.roth@amd.com,m:john.allen@amd.com,m:herbert@gondor.apana.org.au,m:clm@meta.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,m:atishp@meta.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[atish.patra@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-259918-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atish.patra@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,linux.dev:from_mime,linux.dev:dkim,meta.com:mid,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB3E3632833

From: Atish Patra <atishp@meta.com>

The intra-host migration/mirroring feature is not fully implemented for
SEV-SNP VMs. The proper migration requires additional SNP-specific
state such as guest_req_mutex, guest_req_buf, and guest_resp_buf to be
transferred or initialized on the destination.

The SNP VM mirroring requires vmsa features to be copied as well otherwise
ASID would be bound to SNP range while VM is detected as a SEV VM.

Reject SNP source VMs in migration/mirroring until proper SNP state
transfer is implemented.

Fixes: 1dfe571c12cf ("KVM: SEV: Add initial SEV-SNP support")

Reported-by: Chris Mason <clm@meta.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Atish Patra <atishp@meta.com>
---
 arch/x86/kvm/svm/sev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c2126b3c3072..a34326a77290 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2141,8 +2141,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (ret)
 		return ret;
 
+	/* Do not allow SNP VM migration until additional state transfer is implemented  */
 	if (kvm->arch.vm_type != source_kvm->arch.vm_type ||
-	    sev_guest(kvm) || !sev_guest(source_kvm)) {
+	    sev_guest(kvm) || !sev_guest(source_kvm) ||
+	    sev_snp_guest(source_kvm)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -2863,8 +2865,10 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	 * disallow out-of-band SEV/SEV-ES init if the target is already an
 	 * SEV guest, or if vCPUs have been created.  KVM relies on vCPUs being
 	 * created after SEV/SEV-ES initialization, e.g. to init intercepts.
+	 * Also do not allow SNP VM mirroring until additional state transfer is implemented.
 	 */
 	if (sev_guest(kvm) || !sev_guest(source_kvm) ||
+	    sev_snp_guest(source_kvm) ||
 	    is_mirroring_enc_context(source_kvm) || kvm->created_vcpus) {
 		ret = -EINVAL;
 		goto e_unlock;

-- 
2.53.0-Meta


