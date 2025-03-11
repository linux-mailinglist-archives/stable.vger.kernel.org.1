Return-Path: <stable+bounces-124086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8664A5CEB2
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91B2170929
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6609B26562E;
	Tue, 11 Mar 2025 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="S70H8XeK"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0079264F9E;
	Tue, 11 Mar 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719750; cv=none; b=YOBB5yMYH5sFIbAjrh4YBUOYGSbZOWt1Cit6mY/0drUn2LhDJA3GUUmaPBztRaARr7QUNJLhYst25f0KS2WvrF7B0B1dmmB+B+rdl+j7tZeEYSPOVbwIlIDXG73jS8aj7GceBVkZnapj62LtSwSNFUIdJ+f9o2VJBtCYDOpizQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719750; c=relaxed/simple;
	bh=yx9qAAh6rkGLYDfV4Z9SwGwvndUWDSinlt15vtuJNUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0Y1mfT0Aw6yHbmqWnDZWsDpQrg60PQZ5alRzoTnaM/pKnyGAnH2kpjTBXQiKLyaYtAM68kEMW7qYBGr/sBPLPJTA5G9Wy1iugsoNbNWV4IeBG2OE9cV4WqPi7xVBtLAsBPAq9pnYJP2nQVmK3Zh3oTr5Q1b5fhbv2xRwD6lZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=S70H8XeK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A6FA340E0217;
	Tue, 11 Mar 2025 19:02:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9zYlqVEeTnKh; Tue, 11 Mar 2025 19:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741719739; bh=ALXY8Hj5H62ZWEVjwil2Bk5DXZc2e4V9kMYphIUTOiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S70H8XeKYQWT9DbSZmwXWG2LfQ4i0o0yr8+AdGZq+0NXAQKvIVePoht29UDyCIKFH
	 T/qJMJfISouNShu0pwQgshZoz8q12DH6GXiiKhA5Qqv1uf6Apl2y/yXVoJtFnGUvY2
	 HkK8Lzzj2YoKH6GkC44CPltbxjm1MZ+HRy4NnrRKytxu1I420k6h4INjo+GMYApWtL
	 E2Kt3ON1Fp2K50ZGjG00PF9U508DtaLgH9RoZyeepkOdlabkt5lT9n0a1nMhkIQumF
	 +4kWYWjSOpEhN9X+HoFq6teeHvcMPZ6R0PH/xgN9lUPB3Mf3RcQzuC6X97LdAION93
	 1mecfFHIpq0Vj/ssmzueKZHswbbQ2mHMrYWzSDduC37ZYVyjv2uw/cdGICDk1JuE8b
	 qgVPodj1/YO54Jje/1Sii7OyLkFnqhKGytXzaKUNCo2hQyqbmoXkgRr4BF/UWuzdFx
	 dix98Mw+QcvY8dZ83VQ6mJgs76BwlzY217iV///W9hVCq7dsLlpUpPvnxeY0t8IYlC
	 t7LvO5mIJ5Z9EW6WZlCbi5lRn+PHmk72nrwTN/sTANsW5NDB3y/SAxrBbr6OV+8SIc
	 L8Q9ojhvUpW8I4ajIQdTESsafALpcRUvOGGKbzI7f7DVi+sqBH6RmV8h+LApwnl2Cz
	 MahxTLdyk6n4ioVRSEQvKrxk=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8ADBD40E015D;
	Tue, 11 Mar 2025 19:02:06 +0000 (UTC)
Date: Tue, 11 Mar 2025 20:01:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/stackprotector: fix build failure with
 CONFIG_STACKPROTECTOR=n
Message-ID: <20250311190159.GIZ9CIp81bEg1Ny5gn@fat_crate.local>
References: <CAMj1kXF8PZq4660mzNYcT=QmWywB1gOOfZGzZhi1sQxQacUX=g@mail.gmail.com>
 <20250310214402.GBZ89dIo_NLF4zOSKh@fat_crate.local>
 <CAMj1kXEK0Kgx-C8sOvWJ9rkmC0ioWDEb+tpM9BTeWVwOWyGNog@mail.gmail.com>
 <20250311102326.GAZ9APHqe5aSQ1m5ND@fat_crate.local>
 <CAMj1kXHTLz4onmR5iyowptRE38RCK4jNT3BoURBkq2FoDOMTxQ@mail.gmail.com>
 <20250311112112.GEZ9AcqM2ceIQVUA0N@fat_crate.local>
 <20250311131356.GGZ9A3FNOxp32eGAgV@fat_crate.local>
 <20250311143724.GE3493@redhat.com>
 <20250311174626.GHZ9B28rDrfWKJthsN@fat_crate.local>
 <20250311181056.GF3493@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311181056.GF3493@redhat.com>

On Tue, Mar 11, 2025 at 07:10:57PM +0100, Oleg Nesterov wrote:
> See the "older binutils?" above ;)
> 
> my toolchain is quite old,
> 
> 	$ ld -v
> 	GNU ld version 2.25-17.fc23
> 
> but according to Documentation/process/changes.rst
> 
> 	binutils               2.25             ld -v
> 
> it should be still supported.

So your issue happens because of older binutils? Any other ingredient?

I'd like for the commit message to contain *exactly* what we're fixing here so
that anyone who reads this, can know whether this fix is needed on her/his
kernel or not...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

