Return-Path: <stable+bounces-144582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7D2AB96CF
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 09:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31171BC4633
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5420322CBD8;
	Fri, 16 May 2025 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HdTE/7lO"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66212288F9;
	Fri, 16 May 2025 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381717; cv=none; b=GB2xPeeCIPquD8axmpVSxm8GBjmZBAHYdifl0DxAjLBtQzphcykDR1eAXUvoCNGzMJoYVcjsLZXngHCxm3KRtRV52mFOMKY5wTH6enmxll4MqO7pdjo+3fRjx/5VmaDUOC+wBIg7SRCYmoEnOb449yzWWYuYtx7j7CFyzbVIQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381717; c=relaxed/simple;
	bh=NGGea+Xl9PhfLPNnOL1TZgnMozKaFETgeW8lvayNJEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1qEDu/LsaL2Yw4s66yyTd9/Q+JR27V2Hntd5+C0ADxRHp4EkT0b8YlEVBBgmZHjJR0wdVLjBvwWubIxY9eRpq6KhKp9oC5LPIeV5cklUKJuDLJ1C5GKkDkOssqQblMm+3A8KovbrsMhlP5mBRq7c8Qu4YV/aXTuwRhgX5BiJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HdTE/7lO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B5EA540E01ED;
	Fri, 16 May 2025 07:48:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id s4U2TzRhrVR5; Fri, 16 May 2025 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747381706; bh=N7Zdp89bjOj4FjeUAF9kFqVmlf6VStnPSEwpdOdDTRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdTE/7lOnT2f6hY8ww9RAXnyBcXkrxsLYTIMiemYtpol/JQr9zNik2VRthZmd/JC+
	 8fqOYkA9nHsUS8SXSrgHNbss/zDP2jyIOyT/DVqjUwKewv4DV/RJxuqOfD19XbZ+G/
	 i0MCaMZsW9SdM1tbJ4clokpf6NTbK4ko5lHhGO4zwWguMjpF0xBXDXVIuP3Wa5oYE1
	 MPD385I+O68yukhzdizfu4a+EsNWWZWyUkjjoQQ9aNW06l7rp1MHLQp3cN3xA0vw14
	 Dsml7w8Az4Xnk/gfbJzp654iBAWXdrOAUNoEAox3H5iFcKhtjC7waIlSn6K3FawkNG
	 dqcrwhcCfCquXuBzCsH3sWN1xiLBmtK3HUjpDSf642Q3yvUed5mTI+Djjn8cwguEts
	 8HnovGW0Fk7blveZN6CI5YL8e2eEgZKPfphIKSR69oTZ3K1BcpoCsf4KWC7XXD7Ukd
	 4TCqd3esqtY3YM9PbGP4tMgQswh0yFah18TQEYAilO0r/4O35wSSWtVrJ42b5hwYfK
	 7CM1YVXSQ62mP2djQl9ICzl4wfQK+e9R+YW5sU8S4EERZ1WUCPwsw1iWVM/4TWz1FC
	 N62Gf6zTrTaIjOwlvgoqP0ocynsbPOUVcJT3tGeQIAdLZWqjC3IYRBcRQI3cZ24rm1
	 ur9k4jHjrGvaz5vpHAdQSsAE=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25AC940E0239;
	Fri, 16 May 2025 07:48:15 +0000 (UTC)
Date: Fri, 16 May 2025 09:48:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Suraj Jitindar Singh <surajjs@amazon.com>,
	David Kaplan <David.Kaplan@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/bugs: Don't WARN() when overwriting
 retbleed_return_thunk with srso_return_thunk
Message-ID: <20250516074806.GAaCbttptX_H2Gn8OZ@fat_crate.local>
References: <20250515173830.uulahmrm37vyjopx@desk>
 <20250515233433.105054-1-surajjs@amazon.com>
 <20250515233433.105054-2-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250515233433.105054-2-surajjs@amazon.com>

On Thu, May 15, 2025 at 04:34:33PM -0700, Suraj Jitindar Singh wrote:
> -	WARN(x86_return_thunk != __x86_return_thunk,
> +	WARN((x86_return_thunk != __x86_return_thunk) &&
> +	     (thunk != srso_return_thunk ||
> +	      x86_return_thunk != retbleed_return_thunk),
>  	     "x86/bugs: return thunk changed from %ps to %ps\n",
>  	     x86_return_thunk, thunk);

This is still adding that nasty conditional which I'd like to avoid.

And I just had this other idea: we're switching to select/update/apply logic
with the mitigations and I'm sure we can use that new ability to select the
proper mitigation when other mitigations are influencing the decision, to
select the proper return thunk.

I'm thinking for retbleed and SRSO we could set it only once, perhaps in
srso_select_mitigation() as it runs last.

I don't want to introduce an amd_return_thunk... :-)

But David might have a better idea...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

