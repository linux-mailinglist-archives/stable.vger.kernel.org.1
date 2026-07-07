Return-Path: <stable+bounces-272419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TxiYJuj+TGrQtAEAu9opvQ
	(envelope-from <stable+bounces-272419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 15:28:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62D71BE53
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 15:28:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=T7mYdosi;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272419-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272419-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 556DE3108326
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87D8416122;
	Tue,  7 Jul 2026 13:21:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16173416132;
	Tue,  7 Jul 2026 13:21:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430489; cv=none; b=q6FMXHPbJHFE6Cp4ixfwhAUbMm5/rJVaDX1Js3Ke4ElrMd9HiVg2bUZHpqQd8sFGbyYNoeiNnVK4KCT9C7YKwKfCpt5pHk8EXSav9tHiLI+ZzD/w0VmRVpbqZHYyLB3LmvVu0BK9r3cY8p18w3a3mu0nPr7QTViUlMU55Hk/rdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430489; c=relaxed/simple;
	bh=aTI150TJIrCiFSkMzkGJnHBZn+tFIQP7mzFfIPu4Tkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0VPr0kMl/M9b40n/bcnRIkr0tJpAzTrXy9PrrameTgYJ3q4zwLWxCW27dBha0qGUoDV7VX5XYYmk+Jh+qrDDYI9SNASXgaDSc0PWBX1MMOgPsABTIk7DgAKlOJ9YNM+aTvQcT/IzJHMIMap4OBwLVmjrUs4FVt9tpEx3+l/5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=T7mYdosi; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=My+KPg/qXh2P4MUPP32y367LOETlt/nlmXRd1cw9Rcs=; 
	b=T7mYdosiQhUuJZLvgw/3p2c6ZEQ0BrELzjDCGitCFs2FUo7cchdr1PaaCFpe4EFhB6sOUvKz8qd
	eF45+AkKPwhP2lyiBWAtNbS9fNoMEACEk4tVP2SYkc1vsm941UvKFFx61rqkI1q/4a7i8DGesBmA2
	EDyQnysDCIfKNg+Doj/yp9sI1gcKg+2jjxOcKM2joDTndMEOvrrx5dFlCjMROMRfasFHtelZGkJ7F
	Pm5/0cSLY8SfbhPOsOhfa5EIcl3BdL8K2dHXlT1Z9y7mqkaOQLqt+Zp8o4s85bqwjBs//Rc9gwgfJ
	0ht27yljz4+pkR4bkAL4pfYSZjHBcKwT3zkA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wh5jH-0000000BPKS-1vDg;
	Tue, 07 Jul 2026 21:20:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 07 Jul 2026 21:20:51 +0800
Date: Tue, 7 Jul 2026 21:20:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sean Christopherson <seanjc@google.com>
Cc: Atish Patra <atish.patra@linux.dev>,
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
	stable@vger.kernel.org, Atish Patra <atishp@meta.com>
Subject: Re: [PATCH v3 3/4] crypto: ccp: Fix possible deadlock in SEV init
 failure path
Message-ID: <akz9M0mBGwHW08aZ@gondor.apana.org.au>
References: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
 <20260602-sev_snp_fixes-v3-3-24bfd3ae047c@meta.com>
 <akdUUggmSSS1a0IW@gondor.apana.org.au>
 <akvvTFUAI9tjOXRh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akvvTFUAI9tjOXRh@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272419-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:atish.patra@linux.dev,m:pbonzini@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:thomas.lendacky@amd.com,m:pgonda@google.com,m:brijesh.singh@amd.com,m:youngjaelee@meta.com,m:ashish.kalra@amd.com,m:michael.roth@amd.com,m:john.allen@amd.com,m:clm@meta.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,m:atishp@meta.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD62D71BE53

On Mon, Jul 06, 2026 at 11:09:16AM -0700, Sean Christopherson wrote:
>
> Want to take patches 3 and 4 through your tree?  I'll grab 1 and 2; there's no
> dependency between the KVM changes and the crypto changes.

Alright, I'll add them to my tree.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

