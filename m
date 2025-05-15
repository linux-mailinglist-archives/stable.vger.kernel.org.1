Return-Path: <stable+bounces-144502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E78AB830C
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 11:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277EF9E101F
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39EB29827B;
	Thu, 15 May 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bfv+bjMQ"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDEE297A7D;
	Thu, 15 May 2025 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301841; cv=none; b=O40Aw63CVv8YWdq2ylR/fJ4j3xc5VT/q0Rnx5jLcYml6AcjSkxcNf0dCPfXrMqTsFN+BFI2z72DhlPD1UEuOGYl49JmIM8wrx7urHAD+cGudemc501P9PyB/P2N0aRoeyweR5jijq0JeQlb954ZyOv230UR/taMHSMGnesaxqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301841; c=relaxed/simple;
	bh=emi+aNYU4mWKlAhtTRSNDNOWFzQ2hO5aFxBe1DQ/olM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt4fuMHPMXVTU8KxO9JZgBn+p+S6uG6jz8LZa5AAnoFMLx40TaCjciTBwqxgcuggsgcLcNYbLwm8Y72XM0k3vqzo6RBD+NDQgYkFmQ5WlpQ1ss1OYdbyXtRwm2dnBQ5D409nv4SaghAaIL1orvo5XTdSUabp7sVwq2BrpQafn28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bfv+bjMQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A3E1B40E01ED;
	Thu, 15 May 2025 09:37:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FmpDjZ3TgoGK; Thu, 15 May 2025 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747301830; bh=5IpVI1yeltgyxQx2/jTirdFyelhmgHjmGnukJe749fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bfv+bjMQ/MbrUS7mXLtAa2m5h+dzd408M0x08KgRppZaGiemrey/08ggnAl74tpmj
	 UANJEkxluqyV3/pHRDSCctwdw7vqxnEwk0h3r5Pad3wVqht2iausL0fCLO05XqpI11
	 ESkpHrHfOg8Vq5QgYPJsY/PDi576nyyQ67xedVxAaRMY77OxOjjWHZB7PjL49k4GSt
	 0cZUV8AeXHbAm2lvgxUVcwHWw6TEMYwrnuPpwKVXX5V1iAqYZyvfRinIlS+zRn318r
	 YjGaoHHK1jzE9Y7s6CSkjctvjYA6xbJ+OM3okeVmD0UppgDGcZLrX71eiywW+1nuF4
	 pxBZOARHJ2yAf09JjdM6EByTeostF59OyC43RbW6xAe68yWaHNRCzZ11gFN+8wVpkv
	 hmQWbLzoy9KsQIQ9ijwJB5fhh6jSCdmOFolFmcCh3HRuw1gmZ6LiN6/9YNNfm3HtxE
	 q4zM8Qwf34JW+DgEAjq4/bTEDLkMc2YKV3kUh6miFY3qsLhaUjMcB+w1yLUPTkYcIJ
	 KXCyl6bNjWRiAdVC0uTX8/dZ7lLvi1xmw6pDsqqzaTXGX+6sd9+Ky2O/yt0QD5gLfD
	 u/qa7wrPMF8+c9nR2u6IwLrw821f0WZf+zRMkRq7IhtdrI0H+2P7Q4nvVU5jEnoDN0
	 hRPJnZ2HKW1+RcVTYPMuW1A8=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 75A2B40E0196;
	Thu, 15 May 2025 09:37:00 +0000 (UTC)
Date: Thu, 15 May 2025 11:36:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Suraj Jitindar Singh <surajjs@amazon.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Don't warn when overwriting
 retbleed_return_thunk with srso_return_thunk
Message-ID: <20250515093652.GBaCW1tARiE2jkVs_d@fat_crate.local>
References: <20250514220835.370700-1-surajjs@amazon.com>
 <20250514222507.GKaCUYQ9TVadHl7zMv@fat_crate.local>
 <20250514233022.t72lijzi4ipgmmpj@desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250514233022.t72lijzi4ipgmmpj@desk>

On Wed, May 14, 2025 at 04:30:22PM -0700, Pawan Gupta wrote:
> This was discussed during the mitigation, and pr_warn() was chosen because
> it was not obvious that srso mitigation also mitigates retbleed. (On a
> retrospect, there should have been a comment about it).

Why is that important?

We have multiple cases where a mitigation strategy addresses multiple attacks.

> The conclusion was to make the srso and retbleed relationship clear and
> then take care of the pr_warn().

So let's ask ourselves: who is really going to see what single-line warning?

What are we *actually* trying to prevent here?

How about a big fat splat at least if we're really trying to prevent something
nasty which causes a panic on warn...?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

