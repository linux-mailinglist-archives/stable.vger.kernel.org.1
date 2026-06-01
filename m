Return-Path: <stable+bounces-259671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJwuMDUQHmrugwkAu9opvQ
	(envelope-from <stable+bounces-259671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 01:05:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A226262F9
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 01:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 855F230226BE
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 23:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE22D35E1CE;
	Mon,  1 Jun 2026 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xpLKQ578"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E3352035
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780355094; cv=none; b=u3L5mFeRnYvWHeA8l4rhtjFae/61s/jPyadxlg+QEDu7nqsfcAxtsmb0SK3I7GtaNicwsEfFgfjSONVc4px9KPQ22WLgrZzpMI/g3gbthY1bmtNSAXH44gcXe0P/3mT0HrLzAgrq0ZPVJ0r1/D2ZsRcmdlR4YCPs1LuoQJZMrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780355094; c=relaxed/simple;
	bh=Uzh9aoY+3BR7q/Cka+rhzBuUGwNlpyblwx+0tJWMaGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qnYihMbUwVbfJfR1ScCal/utnZ/PKDjhonh+jjZUAK2GCc1AW/hdbAB9JKvsyA0tZfqBO2qHEeIgj2R+tx4kYOrrJdP6qHXpe7xeR4J6UlB7eUNwYCviMUbQgNGl7MGaHIIBdGZI0fgER4x6pNPUMX1DfFiqR27yFi7SL/zCSjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xpLKQ578; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780355091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Bvf4Jr5d3UMYOq7tmej32Y+RUqc/jpd+AKbJsTaXNA=;
	b=xpLKQ578EbaZaVFXeAjzTTqxwYu+dyhFf8q9GaNW7MKWVZ3oLc15Z34gorh1Ed/TFAQSDr
	p7AFal87GfHKFUcmt/aWldBWzS2De9yvdmiGFO4PGSvKUnLa+46i2Cmt9ijwFKF7V2kG7L
	mLDqujed1hTxvjhql3+sWx/QVsWD9lE=
From: Atish Patra <atish.patra@linux.dev>
Date: Mon, 01 Jun 2026 16:04:35 -0700
Subject: [PATCH v2 1/4] KVM: SEV: Do not allow intra-host
 migration/mirroring of SNP VMs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sev_snp_fixes-v2-1-611891b28a86@meta.com>
References: <20260601-sev_snp_fixes-v2-0-611891b28a86@meta.com>
In-Reply-To: <20260601-sev_snp_fixes-v2-0-611891b28a86@meta.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259671-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atish.patra@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 62A226262F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Atish Patra <atishp@meta.com>

The intra-host migration/mirroring feature is not fully implemented for
SEV-SNP VMs. The proper migration requires additional SNP-specific
state such as guest_req_mutex, guest_req_buf, and guest_resp_buf to be
transferred or initialized on the destination.

The SNP VM mirroring requires vmsa features to be copied as well otherwise
ASID would be bound to SNP range while VM is detected as a SEV VM.

Reject SNP source VMs in migration/mirroring until proper SNP state
transfer is implemented.

Fixes: 0b020f5af092 ("KVM: SEV: Add support for SEV-ES intra host migration")

Reported-by: Chris Mason <clm@meta.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Atish Patra <atishp@meta.com>
---
 arch/x86/kvm/svm/sev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c2126b3c3072..e6ad6af128c9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2142,7 +2142,8 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 		return ret;
 
 	if (kvm->arch.vm_type != source_kvm->arch.vm_type ||
-	    sev_guest(kvm) || !sev_guest(source_kvm)) {
+	    sev_guest(kvm) || !sev_guest(source_kvm) ||
+	    sev_snp_guest(source_kvm)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -2865,6 +2866,7 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	 * created after SEV/SEV-ES initialization, e.g. to init intercepts.
 	 */
 	if (sev_guest(kvm) || !sev_guest(source_kvm) ||
+	    sev_snp_guest(source_kvm) ||
 	    is_mirroring_enc_context(source_kvm) || kvm->created_vcpus) {
 		ret = -EINVAL;
 		goto e_unlock;

-- 
2.53.0-Meta


