Return-Path: <stable+bounces-192468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF1C33B83
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 02:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1315464B50
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 01:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869E5212548;
	Wed,  5 Nov 2025 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jcKP9fZD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130471E9B22;
	Wed,  5 Nov 2025 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307924; cv=none; b=hmkJe+Wa6t7VA8S2ic+eiz+BAeyNXyVarHE8umHUYjfzYY4Nl9tbTdeTMQ9EuvA4b31hsAa8GpvVU+p5wWBHDDpiXPcHDLjBOejaAUEPTGu8mEG1z7y+DYsdm+eVvMZ53gwzNOhyuiV8upgBrIHubrS3b9hF94WGHNv3yaCeRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307924; c=relaxed/simple;
	bh=VPYu2jHMeTFAL2Ca8RFhnXAPTrsOM+oGtBaDIawiTu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bc6XEJP2xJAxFZj9GbPelyBLymPzCiCUNT9l6QY3Bf1Wu59hu0SIedfsDIJGvzXWreER24Z+DgVeedJxg2g2f9Nlvgk1iNJW9sM/3V1E6+HVX9kAB+6rQtQyLHMrpMmOP7WfNMPyIASPhKrcBJdA7FkmTVbQdFMbnK/UH7VGvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=jcKP9fZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD5BC4CEF7;
	Wed,  5 Nov 2025 01:58:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jcKP9fZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762307920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E1W4BFa1Qz5mykz9ujHDqCac4DPwHMFuXNbvBRSzVbw=;
	b=jcKP9fZD876gi9ls2EDPOZcJzRzM6GdwmB1za1pToJt9TRekRhsXxzPdo8oFQCZI+wOZg5
	vmmhwgZln01JELesNDn6YQUN+H9nn+X62OsYg4Go1qfmp1wmcHqo1Btd3qUgSQ99H/VfTu
	0jd+18NmQLl5mMyOeQMYWFqFAoAJCv8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 68a20046 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Nov 2025 01:58:39 +0000 (UTC)
Date: Wed, 5 Nov 2025 02:58:36 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thiago Macieira <thiago.macieira@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Christopher Snowhill <chris@kode54.net>,
	Gregory Price <gourry@gourry.net>, x86@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
	mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com,
	me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com,
	darwi@linutronix.de, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an
 error.
Message-ID: <aQqvTGblMoKkRK1j@zx2c4.com>
References: <aPT9vUT7Hcrkh6_l@zx2c4.com>
 <1964951.LkxdtWsSYb@tjmaciei-mobl5>
 <CAHmME9o+Sc7kh8NAxQ6Kr49-58hNXbvSkw_7JTLhObOLgEavBA@mail.gmail.com>
 <4632322.0HT0TaD9VG@tjmaciei-mobl5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4632322.0HT0TaD9VG@tjmaciei-mobl5>

Hi Thiago,

On Tue, Nov 04, 2025 at 03:50:37PM -0800, Thiago Macieira wrote:
> Strictly speaking, if you don't have getentropy(), the fallback will be 
> compiled in, in case someone runs the application is a messed up environment 
> with /dev improperly populated. In practice, that never happens and 
> getentropy() appeared in glibc 2.25, which is now older than the oldest distro 
> we still support.

Great, so I suppose you can entirely remove /dev/[u]random support then.



> But I don't want to deal with bug reports for the other operating systems Qt 
> still supports (QNX, VxWorks, INTEGRITY) for which I have no SDK and for which 
> even finding man pages is difficult. I don't want to spend time on them, 
> including that of checking if they always have /dev/urandom. There are people 
> being paid to worry about those. They can deal with them.

Ahhh. It'd be nice to gate this stuff off carefully, and maybe use a
real hash function too.

> Indeed. Linux is *impressively* fast in transitioning to kernel mode and back. 
> Your numbers above are showing getrandom() taking about 214 ns, which is about 
> on par what I'd expect for a system call that does some non-trivial work. 
> Other OSes may be an order of magnitude slower, placing them on the other side 
> of RDRAND (616 ns).
> 
> Then I have to ask myself if I care. I've been before in the situation where I 
> just say, "Linux can do it (state of the art), so complain to your OS vendor 
> that yours can't". Especially as it also simplifies my codebase.

Well, if you want performance consistency, use arc4random() on the BSDs,
and you'll avoid syscalls. Same for RtlGenRandom on Windows. These will
all have similar performance as vDSO getrandom() on Linux, because they
live in userspace. Or use the getentropy() syscall on the BSDs and trust
that it's still probably faster than RDRAND, and certainly faster than
RDSEED.


> QRandomGenerator *can* be used as a deterministic generator, but that's 
> neither global() nor system(). Even though global() uses a DPRNG, it's always 
> seeded from system(), so the user can never control the initial seed and thus 
> should never rely on a particular random sequence.
> 
> The question remaining is whether we should use the system call for global() 
> or if we should retain the DPRNG. This is not about performance any more, but 
> about the system-wide impact that could happen if someone decided to fill in a 
> couple of GB of of random data. From your data, that would only take a couple 
> of seconds to achieve.

Oh yea, good question. Well, with every major OS now having a mechanism
to skip syscalls for random numbers, I guess you could indeed just alias
global() to system() and call it a day. Then users really cannot shoot
themselves in the foot. That would be simpler too. Seems like the best
option.
 
> From everything I could read at the time, the MT was cryptographically-secure 
> so long as it had been cryptographically-securely seeded in the first place. I 
> have a vague memory of reading a paper somewhere that the MT state can be 
> predicted after a few entries, but given that it has a 624*32 = 10368 bit 
> internal state I find that hard to believe.

I suppose it's linear in F2.

> >       1) New microcode
> >       
> >       2) Fix all source code to either use the 64bit variant of RDSEED
> >          or check the result for 0 and treat it like RDSEED with CF=0
> >          (fail) or make it check the CPUID bit....
> 
> Or 3) recompile the code with the runtime detection enabled.
> 
> It's a pity that Qt always uses the 64-bit variant, so it would have worked 
> just fine.

4) Fix Qt to use getrandom().

Jason

