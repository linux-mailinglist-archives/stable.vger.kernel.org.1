Return-Path: <stable+bounces-187904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEB8BEE7FA
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 17:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 239B5349E98
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 15:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6001E1E12;
	Sun, 19 Oct 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DTC+qFup"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88222EB5BA;
	Sun, 19 Oct 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760886063; cv=none; b=jnLfzbZQHTxnALynaiG1sJsIf6mVN397VDRTLsFETTNL2DBoDflO3f7ry5bcYBBCIWGf8JWqNg3RFU1ELpXARSN5jpSH1Md+403rAGJvVe6MZBTPfG/F8XNgYNcvGmYf1xp//Hwg3LXdAS1FQZ2mVjUUsTquDsuhD2sIQ/oMEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760886063; c=relaxed/simple;
	bh=ERpdBZXbOKHRORKHDoHzqpE80WYPkhj8DksuV/L9QtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToSrlaN/c/KRtnjJfFbmdzTbLVcwe8z//ycexZ7LYNs8Iq+k/M8Sw2Gwv0ViOY0iyOcdP2LwaJ48EYYXO8xT5sR36eqjaGq5TBEwXZlJmpAYizTUyRlOCrZlNYYKsSvuLfLLEqbcJY8qhp3gZuHLazktXqOkvVox14rnXONWA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DTC+qFup; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 36CCF40E01C9;
	Sun, 19 Oct 2025 15:00:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8p0j1AeYx9Y6; Sun, 19 Oct 2025 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760886052; bh=niiA8qTdHn4Ejho1StSCe2+DNkLDCk5uog83mTPodsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTC+qFupq2mMy15nDgXoPEurcG4fU6UnfeUnoJg/QUvnTkgJcD0kG3u/8yny5Dj+c
	 1MZUA86THCHZ0R1hYxlRLsBgZ2u119PlRDBWlAG9y+Ni+6PKrJ/+aKsfghP0gQjTYL
	 SF8A96qBkAUJ1L91QFVYzVz1VHPCCfCks5lbMpM/zEdKx6NWIRWVBM8ujkzy0cjYdU
	 VnJmUgTVhOHkHdN7to1f2PhffQy7SmTs6O/mXGIDDoqxC2fZpkD4RchMa91DkStpHF
	 PAkG0MNvpNKOzl2R+kznxkPorISeCnAPSmo8Z9XjMYtGLW6jPWJ5NliaPlB3+B+OaD
	 w3ZFosJCvkD41P/M0IUex0aB1kGn2ar8gklfqDNc5nNpyvGrOnAyIfUNG3Fk5DYix3
	 My0Y8mqkABs1yO6CSzaK6bawYLIG9SokCVU6AkJR+5HV7BLs17RzgWGsUQqm6L4uPE
	 x6eh+p+CkWd8H2kOfc3qS+yG4R5VS75zTFHsrsQFmREj4RB1u2k3Wf1+2ANHWdgGib
	 iZmF8GgYe2kCrjsMtUnqVVZOaEtaUTjM05j/7SlXEr0141YdbIZAUi5Uf3JOJcT+/j
	 JzdXZDj+KHwE6G9gO8gX0UELmpkhPgd6u9VyCPnWhoMIc2uqxn48f9r5nFepzg1sCS
	 umCQazXcJMkifPsOEbxpcU/o=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8896440E01F9;
	Sun, 19 Oct 2025 15:00:35 +0000 (UTC)
Date: Sun, 19 Oct 2025 17:00:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Gregory Price <gourry@gourry.net>, x86@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
	mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com,
	me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com,
	darwi@linutronix.de, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an
 error.
Message-ID: <20251019150027.GAaPT9Cz6NjB9S2d2a@fat_crate.local>
References: <20251018024010.4112396-1-gourry@gourry.net>
 <20251018100314.GAaPNl4ngomUnreTbZ@fat_crate.local>
 <aPT5rnbfP5efmo4I@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPT5rnbfP5efmo4I@zx2c4.com>

On Sun, Oct 19, 2025 at 04:46:06PM +0200, Jason A. Donenfeld wrote:
> While your team is checking into this, I'd be most interested to know
> one way or the other whether this affects RDRAND too.

No it doesn't, AFAIK. The only one affected is the 32-bit or 16-bit dest
operand version of RDSEED. Again, AFAIK.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

