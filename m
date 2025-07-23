Return-Path: <stable+bounces-164441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB653B0F455
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B391A1C81B31
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E14423BD1F;
	Wed, 23 Jul 2025 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NxYqOsIE"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C062E8E03;
	Wed, 23 Jul 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278317; cv=none; b=U2v+50cSPE9KGijncE1+TfS9R60rn9V0hgABuZ0HcEoiYASPfxL3ff6IX+lLxNIq2OEEHH3uiO/aCVmcwjOPtB/y9yiJZbbIrbLiClOIbo4R+nP6ngJtIMxBlI1q321cvhKEnsJVdGBWfdSTM4PrgS3cRctx4pae9HW2vS/YrtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278317; c=relaxed/simple;
	bh=oJylinypehdQyPsCdIVijc/yaybEaj5ZKeTk/myeuaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moNMBSDD9N+qUbnEeydO6sJtfYQ9qwwA/otXmnjkWT72uPUKpX2Q/mmv9S57iVtW02deBhBjNz4RRJiokObYUUPKk7QxNKdihI9vORii6QIDVWcG2Vtl8+NO84v2P9/Jwnzv7VtZgTlqFOPHQkG0q8T/3yxhyhzQPiTpdAl74+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NxYqOsIE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DE87140E00DE;
	Wed, 23 Jul 2025 13:45:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SSKvEkHiXWsa; Wed, 23 Jul 2025 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753278307; bh=TppZ4uWlJeuf3aNZh3evgHc5hZXZVNbYYHFgBWK08W0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxYqOsIED0u4CFNDn+pF2v37MzS0n+D8UXe6UOZNc5PFQY1e3mZntcaihbVQpJPfU
	 3MsE72GS4s7Yq+vX/LkBkAa13Mx7YG6K/IlR9hpPVvoCOLWGj/r0B6+lbasUKd5M/4
	 wnrUZ6k5CzI8pLWVm4MCjOx4AcrsfzsNFxI3hbE2tQ1Y08lMQZA77eVpeyU9vW0/Ip
	 hsoBAFWiDF8tUJ9Mm1y3Wf1TieVUOWVTQOULgVrLQVfS58Kl77qtO43C4CUOF47lIK
	 UVstRJ+kgytVacRuqja2yHDYQtNmg6nemhqmSIKAIyTr7b5BjFkEAuo+zHTBu42PqL
	 P8cghIxxwnZzA7oykbd6q5weJ9yRZ7OZbG62w5tCYBZ33YgZkr+rncZf63RuLeXyh+
	 8KjHCs7PDjUFQFNMf0PMYCAqVpSjD7ZVz8NpLDKJtEKD6GfNyEyyzdUNgjMNRM3TTn
	 i1FXMs4l+kInendeX/Sa9j0M3tQPgxyYtDGbTtJ6pqkNCi12LIjHfIFsR32YGm/khK
	 /hdYDcmTN72VE0YYtOeQOOcycKC+ERhyXRdF0mS8hOFD+7VbuOsvukaKO82Z3ZaCqH
	 bOi39KG4zjHL+Dz5oYX4OXzqUSM6BN2QLuuR4Ifr6NkBvl8SQnWv9o1Q1kagbSMU++
	 zC02VtMak+E7pDH6V5tpnzDQ=
Received: from rn.tnic (unknown [IPv6:2a02:3037:203:1a6e:b9af:7c3a:f890:4610])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id DE2EC40E0163;
	Wed, 23 Jul 2025 13:44:43 +0000 (UTC)
Date: Wed, 23 Jul 2025 15:46:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Xin Li <xin3.li@intel.com>,
	Sai Praneeth <sai.praneeth.prakhya@intel.com>,
	Jethro Beekman <jethro@fortanix.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Clear feature bits disabled at compile-time
Message-ID: <20250723134640.GAaIDnwGx6cAF9FFGz@renoirsky.local>
References: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723092250.3411923-1-maciej.wieczor-retman@intel.com>

On Wed, Jul 23, 2025 at 11:22:49AM +0200, Maciej Wieczor-Retman wrote:
> +static __init void init_cpu_cap(struct cpuinfo_x86 *c)
> +{
> +	int i;
> +
> +	for (i = 0; i < NCAPINTS; i++) {
> +		cpu_caps_set[i] = REQUIRED_MASK(i);
> +		cpu_caps_cleared[i] = DISABLED_MASK(i);
> +	}
> +}

There's already apply_forced_caps(). Not another cap massaging function
please. Add that stuff there.

As to what the Fixes: tag should be - it should not have any Fixes: tag
because AFAICT, this has always been this way. So this fix should be
backported everywhere.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

