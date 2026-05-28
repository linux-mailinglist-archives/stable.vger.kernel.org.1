Return-Path: <stable+bounces-256442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLyiICjNGGpjnggAu9opvQ
	(envelope-from <stable+bounces-256442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:18:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A85FB520
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F4AF319F626
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243D836D9F6;
	Thu, 28 May 2026 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I6nQSKE/"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084B368962
	for <stable@vger.kernel.org>; Thu, 28 May 2026 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009924; cv=none; b=JF7x8zsWLjsaCo+Y/Gefkw5ayIuu/TaxF1MM92MEcwaFdss2iwl8LDxBfLqnXlV6GWp0BhsZUEbATf3sSsHub3gzmKOxM4Nx9dn1APMMkO9S2QtJB9Np0laGFtfIIHuUjxy4g8ClPozM+50dr2dtehqlYV1oXpTiUybjmYfCH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009924; c=relaxed/simple;
	bh=0SRtLywbtSurzeqEFPiQwtA3Ef8TPShnXFjpjQsg7GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ImHWET3XdYW3rIImbzod2H+7iVhi4AtXv5U8qx91wI8lqYRf+7hCjZ8/lmycWCIu2xa10WD+rMBCt2unaAVtJBwMMK3fGxRyI8owBOSKG+8okOLqmR5m/1jqIlFPTzIYn7x5zuGDuE/BElw1k/fihQ1JqN8hPPR1WL8Md32DzBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I6nQSKE/; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780009921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1750RrUr2OSKFkOGW1fGK+AkRlnCbVk2rTP6i3DUa0=;
	b=I6nQSKE/nhSSsap75tS7Ny4/d1LzbZQE4GXX3Tbdjctlphwrq0/BUk2ZiKi58y/+HUghgN
	vxjfKN/0W7noMmIUF8sSMDDU3BgcYnP4JWzYViZvUPb18AFI+z9qK+PqKqBjkttMgXFKml
	BsoQwhYHUvVF3m95+3/NAhECNOE7MsI=
From: Atish Patra <atish.patra@linux.dev>
Date: Thu, 28 May 2026 16:11:38 -0700
Subject: [PATCH 1/2] KVM: SEV: Do not allow SEV-SNP VMs from intra-host
 migration
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-sev_snp_fixes-v1-1-d67a08151779@meta.com>
References: <20260528-sev_snp_fixes-v1-0-d67a08151779@meta.com>
In-Reply-To: <20260528-sev_snp_fixes-v1-0-d67a08151779@meta.com>
To: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Marc Orr <marcorr@google.com>, Peter Gonda <pgonda@google.com>, 
 Brijesh Singh <brijesh.singh@amd.com>, Youngjae Lee <youngjaelee@meta.com>, 
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
 John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: clm@meta.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-crypto@vger.kernel.org, stable@vger.kernel.org, 
 Atish Patra <atishp@meta.com>
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
	TAGGED_FROM(0.00)[bounces-256442-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: DE1A85FB520
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Atish Patra <atishp@meta.com>

The intra-host migration feature is not fully implemented for SEV-SNP
VMs which require additional SNP-specific state such as guest_req_mutex,
guest_req_buf, and guest_resp_buf to be transferred or initialized on
the destination.

Reject SNP source VMs in sev_vm_move_enc_context_from() until proper
SNP state transfer is implemented.

Fixes: 0b020f5af092 ("KVM: SEV: Add support for SEV-ES intra host migration")

Reported-by: Chris Mason <clm@meta.com>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Atish Patra <atishp@meta.com>
---
 arch/x86/kvm/svm/sev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c2126b3c3072..aff6a0cf5bfe 100644
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

-- 
2.53.0-Meta


