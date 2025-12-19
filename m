Return-Path: <stable+bounces-203120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEEBCD22C9
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 00:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D786302035E
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 23:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31E92E975E;
	Fri, 19 Dec 2025 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ISQ4Rm0n"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6E264FBD;
	Fri, 19 Dec 2025 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766186081; cv=none; b=Is5eeEZ74Njrqg9MjL+qHJR3BhGi4+c5QdTPRovA1EboxgRpQkRrah55BL96pnWuvKVKDZ7nY5KlqBm73Ug5sXNRMOnBpYmsBL/Pp63b4dfZogSAB5yLFM0cLWLWQcG87qyi7SPSGygaYTjY6yrbfuGbZBRJydl0QQQMCnC2JCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766186081; c=relaxed/simple;
	bh=zwvw+jsLPHD40wf6SsHgKMZzAZp9Zc6Ki2kDFCQW290=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms9E2r33vZoS1W48j4LRqAljaeF3DE4pEuffgQFaswbxc/tB6NJDh3Xuxu7RGR9r1R0fMIBk8Cb7neMdxQf8a4NhEIOlqf6qEvTVPsltA5TyRfRB8iEAZsw8A3FoTqFF/R2y8peVRyWbU2mbupHB9Ofn9XFQp2Ma7I20GOFgPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ISQ4Rm0n; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2F58340E0200;
	Fri, 19 Dec 2025 23:14:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id goW8WhbuMwbl; Fri, 19 Dec 2025 23:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1766186071; bh=CsBXwAp1FXa5OdMQOT31fIYLZoJQpogmOvYurQaWB4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISQ4Rm0nLWlpmd7UwFjS9cxyBlJ2GcZ4RhipjlygwEujhWf+76T2NC1Gkaf/8Yqor
	 L5Zq9Xe46MhNFRoSrGskKpLi7NuZIbcmJAAHTaqjTDYs+icL9H6goIGu7bWDi8ozqK
	 wc0Y082xz7nBmE1mUgWf3HX9Y8+zJzPcG0eKQPcU5rNf7jSyt7e+Yutsf/aJ+8OuAV
	 ItHH1iBcRf2S1hr/RT264ntESFk/YAnAk8H1jPR2BEEt9BAgUauwky5IMxytOM4TTo
	 1c/hjJHnuc4Jg+lKH91QhRQgxGAJMHImmJa1K9RC8H0Zacs38uZpoA131HqFYUoYOf
	 GZlxWbi/pEXMsxaq1lHV+vSMUOegus3KLGTQgIWLmi7UflNVQOeWQFJ4AAO+dKGsIU
	 XDol6jDDX41gVYLw7mFU+D11UdgvJqFJ8W6gN0GnLbksPs5TC7MV8Dd6hDmMN5z/oe
	 nLMx6ZLEuK1WItBCrS8r3dz6OzMIpF+zdb6R5Ppy12HLLOOY3nh/nI/O6Jng/Oubtv
	 rwRv654zggQhpJsKOBqmQJ4cjFyjT7Xt0+U7DLA1K5RuiQ6dsMdYDwHSwN/TV3oHWe
	 SfAEaPSoHiKsQqsTY+N/UzRXECOEGHwtaleaRuDsof+qCqBuiR7bLNOsfbufFaQYw6
	 /jyAsVouB4kcFGTo18yiNiCo=
Received: from rn.tnic (unknown [160.86.253.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3038840E016C;
	Fri, 19 Dec 2025 23:14:10 +0000 (UTC)
Date: Sat, 20 Dec 2025 00:14:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Ariadne Conill <ariadne@ariadne.space>,
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
	darwi@linutronix.de, sandipan.das@amd.com, kai.huang@intel.com,
	me@mixaill.net, yazen.ghannam@amd.com, riel@surriel.com,
	peterz@infradead.org, hpa@zytor.com, x86@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	xen-devel@lists.xenproject.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/CPU/AMD: avoid printing reset reasons on Xen domU
Message-ID: <20251027131249.GAaP9v0Rs0C2WZvbfR@renoirsky.local>
References: <20251219010131.12659-1-ariadne@ariadne.space>
 <7C6C14C2-ABF8-4A94-B110-7FFBE9D2ED79@alien8.de>
 <aUV4u0r44V5zHV5f@google.com>
 <e2632ad6-6721-4697-a923-53b5bb0c9f0f@citrix.com>
 <aUWNLUEme9FCUeAb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aUWNLUEme9FCUeAb@google.com>

On Fri, Dec 19, 2025 at 09:36:45AM -0800, Sean Christopherson wrote:
> @@ -301,6 +303,20 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
>         if (ioremap_page_range(vaddr, vaddr + size, phys_addr, prot))
>                 goto err_free_area;
>  
> +       /*
> +        * Verify the range was actually mapped when running as a Xen PV DomU
> +        * guest.  Xen PV doesn't emulate a virtual chipset/motherboard, and
> +        * disallows DomU from mapping host physical addresses that the domain
> +        * doesn't own.  Unfortunately, the PTE APIs assume success, and so
> +        * Xen's rejection of the mapping is ignored.
> +        */
> +       if (xen_pv_domain() && !xen_initial_domain()) {
> +               int level;
> +
> +               if (!lookup_address(vaddr, &level))
> +                       goto err_free_area;
> +       }

This activates my ancient allergies caused by the sprinkling "if (XEN)"
randomly across the kernel tree. If this is a PV guest there probably
should be a PV ioremap variant which hides all that gunk away...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

