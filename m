Return-Path: <stable+bounces-268315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nHxHKyPzPGp9uwgAu9opvQ
	(envelope-from <stable+bounces-268315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:21:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 123556C42AF
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:21:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=djTeP2uC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268315-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268315-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCE9F3088E15
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19C43749EC;
	Thu, 25 Jun 2026 09:17:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FAC3749F9;
	Thu, 25 Jun 2026 09:17:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379079; cv=none; b=pdSNCtRI5LrMNOhwKWkpUlvVC8TCZnVCLFEzPDl+gyi0bITSirWS/awixp5ZORj2mzozAN5jQSCp2UVqO/gY9H9OTvcs9IQOA1LkYUlKWhl9yHq9HwoF5pfbY4tltXJLtdQbEr6mgkYGqVUKOo9lJyk4iPzmU1XH9c7eLoOx9ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379079; c=relaxed/simple;
	bh=bjgGWlplv9/JktxLIMqoRkr5vATpR2RJU5bhLxl0QLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7dNHa9xGHw6lQYekEBN0qu1KCPU+0CJ+Yx78E3T7RZ4O3yPu/gZI035z0IdOfskHfTu3CBy2HFkUVxx2KKY9usjTRTveMTu2GUUDEdm2wRIUVKJe4XfHuLBokV6kVviK5RhnZBTI8uqL6Wr4AvjN6KbEAy+ltZ/gemRIlCtB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djTeP2uC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3FC1F000E9;
	Thu, 25 Jun 2026 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782379078;
	bh=hyl0r7qoXpmlOqukqnYP5mXmYI+O28BQshwsjUEjmBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=djTeP2uC+QLKcSOTUUl+65wvlAUwmoceprV7HWk97NLWgvQ2p1VWg1uKlk6krpWPy
	 AqjUZHdfD+VCjUnBc1xKMEIk2L3MkB4QOt4jLCvG9LtiM/MaLpXpOnGEsMKj5JoMTe
	 iyQjKwq2s+7LdQJi//FvkG6gQlbTxJilTTPTaBIygR80SLTwVP0ij5unej1Msjd5M8
	 d6RqUKOkPyrn/hOXG7liXQqoU0Bpt8sGA9yJ59FVxN04ilPknAmsN+/XBlIsnDMl2d
	 p8Ff2s8KGavNJH+JmPzuwXKw+60jcbd3v16+yQBlYWtKY7sd94U5USUr4ZLu06b0Xb
	 aiWVwJcLszC+Q==
Date: Thu, 25 Jun 2026 12:17:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, upstream+x86@sigma-star.at,
	peterz@infradead.org, hpa@zytor.com, x86@kernel.org,
	dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
	tglx@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/Kconfig: enable ROX also when STRICT_KERNEL_RWX is
 present
Message-ID: <ajzyPjOPw3bpXfuK@kernel.org>
References: <20260625090627.1501095-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625090627.1501095-1-richard@nod.at>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268315-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:richard@nod.at,m:linux-kernel@vger.kernel.org,m:upstream+x86@sigma-star.at,m:peterz@infradead.org,m:hpa@zytor.com,m:x86@kernel.org,m:dave.hansen@linux.intel.com,m:bp@alien8.de,m:mingo@redhat.com,m:tglx@kernel.org,m:stable@vger.kernel.org,m:upstream@sigma-star.at,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable,x86];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 123556C42AF

On Thu, Jun 25, 2026 at 11:06:27AM +0200, Richard Weinberger wrote:
> Running a kernel with CONFIG_MODULES=n causes the W+X page dectection
> to trigger:
> x86/mm: Found insecure W+X mapping at address 0xffffffffc033a000
> 
> The W+X pages come from __its_alloc() with type being EXECMEM_MODULE_TEXT.
> Without ARCH_HAS_EXECMEM_ROX pgprot is PAGE_KERNEL instead of
> PAGE_KERNEL_ROX.
> 
> Cc: stable@vger.kernel.org
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Fixes: 47410d839fcda ("x86/Kconfig: only enable ROX cache in execmem when STRICT_MODULE_RWX is set")
> Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0b5f30d769ffb..330ccbf6726ad 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -85,7 +85,7 @@ config X86
>  	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
>  	select ARCH_HAS_EARLY_DEBUG		if KGDB
>  	select ARCH_HAS_ELF_RANDOMIZE
> -	select ARCH_HAS_EXECMEM_ROX		if X86_64 && STRICT_MODULE_RWX
> +	select ARCH_HAS_EXECMEM_ROX		if X86_64 && (STRICT_MODULE_RWX || STRICT_KERNEL_RWX)
>  	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> -- 
> 2.51.0
> 

-- 
Sincerely yours,
Mike.

