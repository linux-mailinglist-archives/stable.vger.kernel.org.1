Return-Path: <stable+bounces-268317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pgncAkX0PGrIuwgAu9opvQ
	(envelope-from <stable+bounces-268317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:26:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA096C4345
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:26:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=mNOJjoZ0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268317-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268317-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A99143037462
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF1B374E63;
	Thu, 25 Jun 2026 09:20:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE2378D68;
	Thu, 25 Jun 2026 09:20:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379207; cv=none; b=suCEH76DKCk/MZwLNU6XnIUe3EDP5q9KAgPFFyukcZjAPgln8SP9MzWyz9Oon6OpSLt+xPvnruVy0tm4oC137qC/Fs2FH/qe67nTuy/BHA1N84tsTzM4ucflAiQmc0ftcg/Y6p5L3DLAFgQ4Pa0ucxGvnF21bV1Qt3/B/jjrR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379207; c=relaxed/simple;
	bh=MSB2XXR/SSW9QxAU11ULZxlLxN/DXLmkLJdSXPivLHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7H5pqLTtYAIOlS0kfqs4fGF6FZf9eCVJxUaH+qE/c+gJKmEklyyjVKBjX7UsBaFhwEyGsl9lq2F3mtlox5dT8FJFIX4zmphD71L5LawI7bcQ84ethIfBsB5lN98jN7NI8girvO0qC2qS7VOZ1aHSKA82s/4aOTgR66vTVkXSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mNOJjoZ0; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zxvnE2eOaMrVjIQxaZIC3414HqYps7eOQS5RgfX/BRM=; b=mNOJjoZ0v4y0+Q4g3GECEqILfp
	nVxOU0QuZxhTB940waQc/HJHRjNyp07pP5Yoc4xYPbJYVpLIl4WljMCMzKqTmJNDZKfSmFbf7So/Q
	IQsvWA7SiKq4ZpG/8rn6i/MUXjPvJVrZ8om723mU6YSvrSYjZo7RrUl5AJdUpb4Bj0mAIc0+v/vuT
	19p+X3YJ3JwQx3p/MO2qKdyMrciQGa3H4EgvwMqthKG9w3e5g0HEhoIkbd3t/Fy4CaF21BlPNRrfh
	pRJ7JEgVLdgKP7Pa3ohh3euphcz/MQ4PwP/Wp6tnXFNC1Mk1BgREUHVqBLVGLDUJ9gMMgJusepoA/
	emFB+A9w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcgFZ-00000009dOX-0Yw2;
	Thu, 25 Jun 2026 09:19:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1A9A0300B5F; Thu, 25 Jun 2026 11:19:57 +0200 (CEST)
Date: Thu, 25 Jun 2026 11:19:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, upstream+x86@sigma-star.at,
	rppt@kernel.org, hpa@zytor.com, x86@kernel.org,
	dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
	tglx@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/Kconfig: enable ROX also when STRICT_KERNEL_RWX is
 present
Message-ID: <20260625091957.GC1181229@noisy.programming.kicks-ass.net>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268317-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:richard@nod.at,m:linux-kernel@vger.kernel.org,m:upstream+x86@sigma-star.at,m:rppt@kernel.org,m:hpa@zytor.com,m:x86@kernel.org,m:dave.hansen@linux.intel.com,m:bp@alien8.de,m:mingo@redhat.com,m:tglx@kernel.org,m:stable@vger.kernel.org,m:upstream@sigma-star.at,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,x86];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nod.at:email,infradead.org:dkim,infradead.org:email,infradead.org:from_mime,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BA096C4345

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

I wonder, is STRICT_KERNEL_RWX=y, MODULE=y, STRICT_MODULE_RWX=n at all
possible? ;-) That seems an eminently insane combo.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

