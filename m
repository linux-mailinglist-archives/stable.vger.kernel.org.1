Return-Path: <stable+bounces-144616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A339ABA01B
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 17:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F6F17AE8C4
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E31B87EB;
	Fri, 16 May 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZW/QTdDU"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BE149C64;
	Fri, 16 May 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410058; cv=none; b=afrEQ8psd1V+RT4sDfvQjAyDW4mZXl0fA046dCoLWniA6pJMg4lRc8z9dPjDd10b9sNZQuTX9lxS/aqkfGa6QzYQwEIpvAl31Y+pcGeWiFrM2W3nksu7eQhoQqNVZ/TKXV7XkZAUjKMnc3DP44EeEy7Y2zKN2LZiF+vDjsAlU4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410058; c=relaxed/simple;
	bh=3gVahgVvh24z8R88A7UN/LS9CeC5yvoSzkDRbxORIkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPh+My2p85hIsfzQ8MToyotR8ZE9CCQBTH5ckNKvWXqmf+MBCLOUKXClRyql793qsrqIjzUNq3hgxVohS/T2C9mFfkwYfxxa2erAdUdpGQJbFE8QcWaUAA8IvCS3vb6GZ1XlSr5UwT//4ESZg1OECxmOXsMVG4w0nM6xURTrXeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZW/QTdDU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A366140E01ED;
	Fri, 16 May 2025 15:40:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0MjL6LvCWYJp; Fri, 16 May 2025 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747410050; bh=OwcTzx3fY+Hh1bkSXKFzEScUpfUJaZijnEP7fGg+4co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZW/QTdDU2S2/hl0uW6zz2aZxJJ9bSXI5wCMrQvatpHaKOLMYfK7FxpRwq+CklO2B8
	 GWM5ynznfm4e1lMRTtB0YIhLrU1Tmz37IGz9XM45tuUVhDIOgBpkxRmaLrvBdIk66R
	 hcXO9FebG5Af03zItUDezJaxlnBCF/sjiurtCOzzI2b2IHSEm+tBH5XHTXFIpeEo1C
	 2uDUuXwqOQAp0MczKd6Xw19c7UOmeUV/bVWs5q6epXJRcnYdhnN//EiIiUAoEm7t8P
	 W3zZ9pgDdha2djDAmgslhkKZmqPA2ZORNuJwzyQs1RpZi/RI/wmqSRWnhC25fdwf4S
	 tb3exQMZw1672pF1Ez1Gj1xjy8IXJL4AlSaI46iRO/wmT9Vhg97m3lnT6KnPLz75Gc
	 pOKnML3qrlVK049ZSsX5OpMTsOf2R5+NkW5J61NcKjphi5xaTK3byc+HUUiVmR2Jc9
	 R9KGmSFbhwrbpjz0eEjkrPnclngYEsPWUo/inLFIxhDrQ8W2mEsJxm4aDpCe2Tj52e
	 uqJUQjzmIvtlFPzlVV1//gLy1+b31jtjOVl8itQz3NLo36z+KMY/2kIq3KtWnVfpXs
	 qw+c1aaUOo2+Ub04PzxyJHh5B+s+3IMjpovZHngNdFie4fLu2I4zQCJ88XDAvEtcuk
	 sP9XFVpovyKn6cMKBQHr9L9s=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4BD640E0196;
	Fri, 16 May 2025 15:40:38 +0000 (UTC)
Date: Fri, 16 May 2025 17:40:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Suraj Jitindar Singh <surajjs@amazon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/bugs: Don't WARN() when overwriting
 retbleed_return_thunk with srso_return_thunk
Message-ID: <20250516154034.GEaCdccm27F_hgZ8c9@fat_crate.local>
References: <20250515173830.uulahmrm37vyjopx@desk>
 <20250515233433.105054-1-surajjs@amazon.com>
 <20250515233433.105054-2-surajjs@amazon.com>
 <20250516074806.GAaCbttptX_H2Gn8OZ@fat_crate.local>
 <LV3PR12MB926587E1175B9450C34C17829493A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB926587E1175B9450C34C17829493A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Fri, May 16, 2025 at 03:18:30PM +0000, Kaplan, David wrote:
> Hmm.  Since SRSO is kind of a superset of retbleed, it might make sense to
> create a new mitigation, RETBLEED_MITIGATION_SAFE_RET.
> 
> retbleed_update_mitigation() can change its mitigation to this if
> srso_mitigation is SAFE_RET (or SAFE_RET_UCODE_NEEDED).
> RETBLEED_MITIGATION_SAFE_RET can do nothing in retbleed_apply_mitigation()
> because it means that srso is taking care of things.  Thoughts?
> 
> This also made me realize there's another minor missing interaction here,
> which is that if spec_rstack_overflow=ibpb, then that should set
> retbleed_mitigation to IBPB as well.

Ok, this sounds like we should expedite our srso mitigation cleanup
intentions. :-)

Lemme find you on chat...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

