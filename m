Return-Path: <stable+bounces-192449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E4EC331E7
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 22:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20DB434BD0E
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 21:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92BD346E48;
	Tue,  4 Nov 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JF/4gPOe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862F2D0617
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293392; cv=none; b=tMOYrFzz7FGFPAX8rOZbpWRFccweQ0CNdbY6xBlWVMFtRkEc3pl07ZDMird5bdr2oIu5B7g1FOLD0vyzDmBbPVvYl7WCToPrju2eGJJPA0UfhGj5/ZD9k+bJQrG2TWTYHMJXoypLBYOjMpeE1N+yqIKfL1jkqp/typsH6358ptk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293392; c=relaxed/simple;
	bh=H+lxm8q7CJzI62Ckpit0fJo8mBoz1rPHi57QHMAz6uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHT9hknd7nEaXnib1VvZ3ihrWB12YOqDx5TT5CmEyJ/AI3mZw35tylzcm+8CAeDDyHEX3VvSK835pErW+gmHMe5YfhbiKDfa1n6/j13nCvV2SxOJPf5LC5o4OHY8993dp8e7S5nj5mYPrTs2gyBgtm8UEPw2XzhZ+qa6IBsVpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=JF/4gPOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53CDC16AAE
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 21:56:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JF/4gPOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762293385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pcv6dVf9X8hHjejIcS+yVF56DO9bVj1SCEz5ECjpupQ=;
	b=JF/4gPOeT2l/eP5IU3ZTP8jWsP/t+UVEG/Nsk/xnNBgC1xqWuYQULgmnGAcpfmgKkIvBo6
	4aPyXo16pAlvZJFibuY+dWZLKbQHzShOBd3VGWntAkA9wnJ62fmrXaJAXd8DTrArQt07qE
	fG69cCFAD4XJS7Hz58V3esnwV9NceLI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 216baab7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Tue, 4 Nov 2025 21:56:25 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-65366485678so3018494eaf.2
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 13:56:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhUseUF7cbuROFGZdj0J22ti6WrFU48CQ52B+ly9DHlTnYTz9HgFVFWyqaxHsMZcU/dkCcK+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YylsC5mM/79wgUws6O2NT1hGsSyPI18BEpIhmGcCpD4xewagbDP
	6+OOY4HX8w/dlbyAN7uJVLszFVgVdb0Rq43Fo6i7+usSlAD/lfK2mWkoRGdto5jT69YBOlA73YK
	zApgxfcnnwHFDt7Uu6hUrksv0PEo/MfA=
X-Google-Smtp-Source: AGHT+IHfWhQqcUpCmCD72JNFRCOsgkAlcqY686emJubXCrgQGNGJXbmamwyCywTIDSR5FZJcFmhYkF6poQH34nG9Cw0=
X-Received: by 2002:a05:6870:a194:b0:30b:e02b:c7f5 with SMTP id
 586e51a60fabf-3e19c15aa06mr410066fac.40.1762293383341; Tue, 04 Nov 2025
 13:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPT9vUT7Hcrkh6_l@zx2c4.com> <20251104132118.GCaQn9zoT_sqwHeX-4@fat_crate.local>
 <CAHmME9o+cVsBzkVN9Gnhos+4hH7Y7N6Sfq9C5G=bkkz=jzRUUA@mail.gmail.com> <1964951.LkxdtWsSYb@tjmaciei-mobl5>
In-Reply-To: <1964951.LkxdtWsSYb@tjmaciei-mobl5>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 4 Nov 2025 22:56:11 +0100
X-Gmail-Original-Message-ID: <CAHmME9o+Sc7kh8NAxQ6Kr49-58hNXbvSkw_7JTLhObOLgEavBA@mail.gmail.com>
X-Gm-Features: AWmQ_bl8_t64-tGodaQtE8hr3Lgsntgw6g2W3cOx8ILzRWPoNijbVj5rysLJ7B8
Message-ID: <CAHmME9o+Sc7kh8NAxQ6Kr49-58hNXbvSkw_7JTLhObOLgEavBA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an error.
To: Thiago Macieira <thiago.macieira@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Christopher Snowhill <chris@kode54.net>, Gregory Price <gourry@gourry.net>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org, 
	mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com, 
	me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com, 
	darwi@linutronix.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thiago,

On Tue, Nov 4, 2025 at 7:08=E2=80=AFPM Thiago Macieira
<thiago.macieira@intel.com> wrote:
> > Another strange thing, though, is the way this is actually used. As
> > far as I can tell from reading this messy source,
> > QRandomGenerator::SystemGenerator::generate() tries in order:
> >
> > 1. rdseed
> > 2. rdrand
> > 3. getentropy (getrandom)
> > 4. /dev/urandom
> > 5. /dev/random
> > 6. Something ridiculous using mt19937
>
> #1 and #2 are a runtime decision. If they fail due to lack of entropy or =
are
> unavailable, we will use getentropy().

I didn't see that SkipHWRNG thing being set anywhere. That looked like
it was internal/testing only. So #1 and #2 will always be tried first.
At least I think so, but it's a bit hard to follow.

I think ranking rdrand & rdseed as 1 and 2 above the rest is a
senseless decision. I'll elaborate below.

> #3 is mutually exclusive with #4 and #5. We enable getentropy() if your g=
libc
> has it at compile time, or we use /dev/urandom if it doesn't. There's a m=
arker
> in the ELF header then indicating we can't run in a kernel without
> getrandom().

That's good. You can always call getrandom via the syscall if libc
doesn't have it, but probably that doesn't matter for you, and what
you're doing is sufficient.

> #6 will never be used on Linux. That monstrosity is actually compiled out=
 of
> existence on Linux, BSDs, and Windows (in spite of mentioning Linux in th=
e
> source). It's only there as a final fallback for systems I don't really c=
are
> about and can't test anyway.

That's good. Though I see this code in the fallback:

    // works on Linux -- all modern libc have getauxval
    #  ifdef AT_RANDOM

Which makes me think it is happening for Linux in some cases? I don't
know; this is hard to follow; you know best.

It'd probably be a good idea to just remove this code entirely and
abort. If there's no cryptographic source of random numbers, and the
user requests it, you can't just return garbage... Or if you're going
to rely on AT_RANDOM, look at the (also awful fallback) code I wrote
for systemd. But I dunno, just get rid of it...

> What do you mean about RDSEED? Should it not be used? Note that
> QRandomGenerator is often used to seed a PRNG, so it seemed correct to me=
 to
> use it.
>
> When this was originally written, getrandom() wasn't generally available =
and
> the glibc wrapper even less so, meaning the code path usually went throug=
h the
> read() syscall. Using RDRAND seemed like a good idea to avoid the transit=
ion
> into kernel mode.
>
> I still think so, even with getrandom(). Though, with the new vDSO suppor=
t for
> userspace generation, that bears reevaluation.

RDRAND and RDSEED are slow! Benchmark filling a buffer or whatever,
and you'll find that even with the syscall, getrandom() and
/dev/urandom are still faster than RDRAND and RDSEED.

Here are timings on my tiger lake laptop to fill a gigabyte:

getrandom vdso: 1.520942015 seconds
getrandom syscall: 2.323843614 seconds
/dev/urandom: 2.629186218 seconds
rdrand: 79.510470674 seconds
rdseed: 242.396616879 seconds

And here are timings to make 25000000 calls for 4 bytes each -- in
case you don't believe me about syscall transitions:

getrandom vdso 0.371687883 seconds
getrandom syscall: 5.334084969 seconds
/dev/urandom: 5.820504847 seconds
rdrand: 15.399338418 seconds
rdseed: 45.145797233 seconds

Play around yourself. But what's certain is that getrandom() will
always be *at least as secure* as rdrand/rdseed, by virtue of
combining those with multiple other sources, and you won't find
yourself in trouble viz buggy CPUs or whatever. And it's faster too.
There's just no reason to use RDRAND/RDSEED in user code like this,
especially not in a library like Qt.

> There's also the issue of being cross-platform. Because my primary system=
 is
> Linux, I prefer to have as little differentiation from it as I can get aw=
ay
> with, so I can test what other users may see. However, I will not hesitat=
e to
> write code that is fast only on Linux and let other OSes deal with their =
own
> shortcomings (q.v. qstorageinfo_linux.cpp, qnetworkinterface_linux.cpp,
> support for glibc-hwcaps). In this case, I'm not convinced there's benefi=
t for
> Linux by bypassing the RDRND check and going straight to getentropy()/
> getrandom().

The right thing to do is to call each OS's native RNG functions. On
Linux, that's getrandom(), which you can access via getentropy(). On
the BSDs that's getentropy(). On Windows, there's a variety of ways
in, but I assume Qt with all its compatibility concerns is best off
using RtlGenRandom. Don't try to be too clever and use CPU features;
the kernel already takes care of abstracting that for you via its RNG.
And especially don't be too clever by trying to roll your own RNG or
importing some mt19937 madness.

> The separation is because I was convinced, at the time of developing the =
code,
> that advocating that people use a system-wide resource like the RDRND or
> getrandom() entropy for everything was bad advice. So, instead, we create=
 our
> own per-process PRNG, securely seed it from that shared resource, and the=
n let
> people use it for their own weird needs. Like creating random strings.
>
> And it's also expected that if you know you need something more than base=
line,
> you'll be well-versed in the lingo to understand the difference between
> global() and system().

I'd recommend that you fix the documentation, and change the function
names for Qt7. You have a cryptographic RNG and a deterministic RNG.
These both have different legitimate use cases, and should be
separated cleanly as such.

For now, you can explain the global() one as giving insecure
deterministic random numbers, but is always seeded properly in a way
that will always be unique per process. And system() as giving
cryptographically secure random numbers. Don't try to call anything
involving std::mersenne_twister_engine "secure"; instead say,
"uniquely seeded" or something like that, and mention explicitly that
it's insecure and deterministic.

Jason

