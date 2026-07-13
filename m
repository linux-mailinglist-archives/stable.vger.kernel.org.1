Return-Path: <stable+bounces-273547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qzubJhxdVGqLlAMAu9opvQ
	(envelope-from <stable+bounces-273547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 05:35:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 378B2746F3F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 05:35:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b="f8Nb/KWG";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273547-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273547-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80C47300F97D
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 03:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A422BEC55;
	Mon, 13 Jul 2026 03:35:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2DDF59;
	Mon, 13 Jul 2026 03:35:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913748; cv=none; b=qKBD2660yiiSR5C869Dvk09qiUcGvJ6zBymUjfFYT7/waALeZzWpbOupq77waQVk3h1dQc1l/XSi4NevbF1R5wpMjtnw9oNP50Pusdmg0rIs2a0vY2UDc3Kk0ZFoEIFfCKsSF7g+64XesSQtlMXB1ymmf0Qaty/+k1hTyv9Cv9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913748; c=relaxed/simple;
	bh=49dJJ0Sp0/vn4DmKvNUpSlyKySCDpPlXsdYOeRJpe58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5iHBPHnbaBlqTHLduh9FcsQY8UO2A3tYxWhJhufrEoaTUV4o+j6LZo4eAfpOXRBaFlvvdoeEk7vroFyGbRYsUCGDBrduXGxFO4ik772UvuB6q6LzeDSuBg/Y7MUTDUUqMMW9G46vDsrV1SM5NjuNfGpRhSBcH7FwWfCbkzjHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=f8Nb/KWG; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=IJLs1QJf2eols2ajMEIJIevnH0XW0XzUVPHUmDnAlwc=; 
	b=f8Nb/KWG1PDLnMBNVfqwzNcphoYwOETjw10pBXJnzZOPjl4EE/ZRRxVU21fVhj6Qkmz0XurYmJS
	YwYAh2IIAmUZI8Zb53ngipfncxOdSt3D3L1DAoG6F67YLcJWIot4OihsUQo15O9tC5NRZfWRNQvW6
	m9bS0i1JXZmd3paJ+xkB+rLK77a57J/WuqcYROeLKPU9YT3fru9bXMseF3Cpm/A+fecDOsENdTS9m
	Gfngm10iDSZ1Wyv4nlNLtssLBJyUWtbAQSioUcNlMMTaIwfsImrwYOZV5ISUTdQs3gzUqNZunCunc
	tlmR2QyEJ80FpV7/EUwkGI9pMrrx7Lzd6now==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wj7S0-0000000CyCJ-3h8m;
	Mon, 13 Jul 2026 11:35:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 13 Jul 2026 13:35:24 +1000
Date: Mon, 13 Jul 2026 13:35:24 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Atish Patra <atish.patra@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Peter Gonda <pgonda@google.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Youngjae Lee <youngjaelee@meta.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	John Allen <john.allen@amd.com>, clm@meta.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	stable@vger.kernel.org, Atish Patra <atishp@meta.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 0/4] KVM: Miscellaneous SEV/SNP related fixes
Message-ID: <alRc_IA1NJxvVAzR@gondor.apana.org.au>
References: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273547-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:atish.patra@linux.dev,m:seanjc@google.com,m:pbonzini@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:thomas.lendacky@amd.com,m:pgonda@google.com,m:brijesh.singh@amd.com,m:youngjaelee@meta.com,m:ashish.kalra@amd.com,m:michael.roth@amd.com,m:john.allen@amd.com,m:clm@meta.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,m:atishp@meta.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 378B2746F3F

On Tue, Jun 02, 2026 at 03:36:31PM -0700, Atish Patra wrote:
> This series addresses a few issues found during code audit of the
> KVM SEV/SNP and CCP driver code. The fixes include a incorrect lock state
> and incomplete state handling during intra-host migration for SNP VMs.
> 
> To: Sean Christopherson <seanjc@google.com>
> To: Paolo Bonzini <pbonzini@redhat.com>
> To: Borislav Petkov <bp@alien8.de>
> To: Dave Hansen <dave.hansen@linux.intel.com>
> To: x86@kernel.org
> To: H. Peter Anvin <hpa@zytor.com>
> To: Tom Lendacky <thomas.lendacky@amd.com>
> To: Peter Gonda <pgonda@google.com>
> To: Brijesh Singh <brijesh.singh@amd.com>
> To: Youngjae Lee <youngjaelee@meta.com>
> To: Ashish Kalra <ashish.kalra@amd.com>
> To: Michael Roth <michael.roth@amd.com>
> To: John Allen <john.allen@amd.com>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: clm@meta.com
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Atish Patra <atishp@meta.com>
> ---
> Changes in v3:
> - Added comments, fixed commit messages and fixes tag as per discussions on v2. 
> - sev_init_ex_buffer initialized with zero at allocation to prevent any kernel
>   data leak in case of init_ex_file is not present. Reported by Sashiko
> - Link to v2: https://lore.kernel.org/r/20260601-sev_snp_fixes-v2-0-611891b28a86@meta.com
> 
> Changes in v2:
> - Added fixes based on the reports by Sashiko. 
> - Added a kselftest for validating SNP VM mirroring/migration rejection. 
> - Link to v1: https://lore.kernel.org/r/20260528-sev_snp_fixes-v1-0-d67a08151779@meta.com
> 
> ---
> Atish Patra (4):
>       KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs
>       KVM: selftests: Verify SNP VMs are rejected from migration and mirroring
>       crypto: ccp: Fix possible deadlock in SEV init failure path
>       crypto: ccp: Fix memory leak in SEV INIT_EX path
> 
>  arch/x86/kvm/svm/sev.c                             |  6 ++-
>  drivers/crypto/ccp/sev-dev.c                       | 19 +++++++--
>  .../testing/selftests/kvm/x86/sev_migrate_tests.c  | 47 ++++++++++++++++++++++
>  3 files changed, 67 insertions(+), 5 deletions(-)
> ---
> base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> change-id: 20260525-sev_snp_fixes-0b73789c1a91

Patches 3-4 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

