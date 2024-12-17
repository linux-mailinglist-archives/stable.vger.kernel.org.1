Return-Path: <stable+bounces-105025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A013A9F552D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F86164E95
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A181FCFD4;
	Tue, 17 Dec 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i1UODlnJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF71F8ACA
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457475; cv=none; b=Kf/HcyEhNgdX6cLqCs4YugTWoL1UtrWxG3syH5ou2B/GmVDIgzfMY4r7PznuYmJKpjtqebXjZHhR2EV1QrVsCAdYkS2NFMyD6cE0smLHvWlHDJADEkuWEdUMB7Vtj9t+9PpdzLYtkQrnBcIwOKoL67Prx7UqSikOKZ0mBrC4rPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457475; c=relaxed/simple;
	bh=JLQtj3Z+YBvoe66gPP5jwG3nfGAR0rbHbfqZsmiV4Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNBvkyKPlOiIowki/F9lnyhiD2AHGDvNKYmuWV0xWpKNjT7oo6H5q0r/ZR9cnCawiC2sHr954RtHmcXhB7oHjezlidOFiEeHfEvTRn8SgHDkY7VnFg2imITtpFYYlM99ZEKpdHWMueA7zOhMghgqaKUyzytjtkK9U+QithOobWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i1UODlnJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso67424831fa.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 09:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734457469; x=1735062269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLQtj3Z+YBvoe66gPP5jwG3nfGAR0rbHbfqZsmiV4Zk=;
        b=i1UODlnJ0KIsogvPyL4C1wg95eOJ2EanpTavhmVjTQBTUQUwTa2xeTt487NUhnmJd1
         NGXDYO7Nw1UAkkQo9kwFzw9OUtXS1k6AGBjDUBqhc4oAKk6eM8O/nZ6YJr4rUOqChabu
         BAlQ8jvN4Ir1FufryAd2iYBZNm6bAdCQEpr+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734457469; x=1735062269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLQtj3Z+YBvoe66gPP5jwG3nfGAR0rbHbfqZsmiV4Zk=;
        b=YCP9Tu6hDgqEd/U1X9IiHqSdjVNJu1r4RPEt/20l7/9gWSPJNTN0z/6mZBmzj3Ey0S
         bcRZ/84kOvhIdKifEc1pJefR06/KXaQJVnAwTvbmq/UNZEZx5EAWiUpbGDMplA3L+onM
         dkcRbqJeouKk+e596sxyQqSBA0iPnV+fSX5Iv4lmCOsyxyiNSadZIH21waGacOA7em9F
         cceM2gGNsqc2cM/4GWP6fWUyyRDuigsoairz2WCUFZMMXpxy3QXXowEDwTYCnhA4tIqc
         aG/t9XMvo7/agTzAd7l5k1brADAGZh5QMw5Pq9aN9V5ISaD9lR5f/s0WY1wq05OJU0eu
         dF1g==
X-Forwarded-Encrypted: i=1; AJvYcCWQM2oqxsMM1SXReGeVUPcyIFfoj3KXr692YmQOcG815bviKb5SnFokX97bOlA1ix9Lbn0csAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGhc72JUegHUgk+eg0kIUK5fRWSP/WuNWXmODgBZvyC08SIB+T
	61Q8wJMVEYhSi2maWDzUTBID5uJ4ZOxfbysvmG83HC7k2cymywGPv38fikl66NgsKDBYfy3X2Jj
	tPQ==
X-Gm-Gg: ASbGncsbJWYskcn8gckbeIBgXn2xRZ78MstaI0LvQOc9ZuN+5TB81LDl2Zg4SMgV25D
	ukrLsBjk1c8eAaIyelO2Iy+bF+Z73Cb06eZAlMZXeJm0A7oYhjZbqUMr4OLZZbtK2ygaFfjC+hn
	kN7vyHEWyDAuMRnF//w8nAbmAKp68Bz1B1xaiEknDS5FagZSrzsm8g4U9mMvbd/kljGfOcyC/jD
	dHIvRJ2QJkdPOTnDBrPAEN5sVNSFKyOa/o3sOkf1C6y3pf83HVWwZmkfhP981Dh5ORIFOfoxW2e
	amPsTFLQ4Xgp/IGLYfgJ3p5J
X-Google-Smtp-Source: AGHT+IFd2AZ8/CB3szYaeJbTmdzqogY5VHG6bB3c9vvIfBproDN0yZdlBtqvFrkA4Ibp+p9DMN002Q==
X-Received: by 2002:a05:651c:210d:b0:2fb:4b0d:9092 with SMTP id 38308e7fff4ca-302545669ddmr66794131fa.1.1734457468977;
        Tue, 17 Dec 2024 09:44:28 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3034401d546sm13151091fa.11.2024.12.17.09.44.25
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:44:26 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso67423731fa.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 09:44:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUU5B8D+P6AQXHu3hybc/h0yft9Tj7eF9Kfu/uUypzjURJ7rsPIMflLLwUdXK15kXzKshTb76c=@vger.kernel.org
X-Received: by 2002:a05:651c:2108:b0:302:3de5:b039 with SMTP id
 38308e7fff4ca-30254566a55mr66069711fa.8.1734457465327; Tue, 17 Dec 2024
 09:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214005248.198803-1-dianders@chromium.org>
 <20241213165201.v2.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid>
 <CAODwPW_c+Ycu_zhiDOKN-fH2FEWf2pxr+FcugpqEjLX-nVjQrg@mail.gmail.com>
 <CAD=FV=UHBA7zXZEw3K6TRpZEN-ApOkmymhRCOkz7h+yrAkR_Dw@mail.gmail.com> <CAODwPW8s4GhWGuZMUbWVNLYw_EVJe=EeMDacy1hxDLmnthwoFg@mail.gmail.com>
In-Reply-To: <CAODwPW8s4GhWGuZMUbWVNLYw_EVJe=EeMDacy1hxDLmnthwoFg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 17 Dec 2024 09:44:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X61y+RmbWCiZut_HHVS4jPdv_ZB8F+_Hs0R-1aKHdK4w@mail.gmail.com>
X-Gm-Features: AbW1kvbAgvCz7vA_yFdhIVykkakAa4L6Lz2IE9DR-f5ZjOd70MgEn8kxRtbYbd0
Message-ID: <CAD=FV=X61y+RmbWCiZut_HHVS4jPdv_ZB8F+_Hs0R-1aKHdK4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm64: errata: Assume that unknown CPUs _are_
 vulnerable to Spectre BHB
To: Julius Werner <jwerner@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-kernel@lists.infradead.org, 
	Roxana Bradescu <roxabee@google.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	bjorn.andersson@oss.qualcomm.com, stable@vger.kernel.org, 
	James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 17, 2024 at 5:25=E2=80=AFAM Julius Werner <jwerner@chromium.org=
> wrote:
>
> > > - Refactor max_bhb_k in spectre_bhb_loop_affected() to be a global
> > > instead, which starts out as zero, is updated by
> > > spectre_bhb_loop_affected(), and is directly read by
> > > spectre_bhb_patch_loop_iter() (could probably remove the `scope`
> > > argument from spectre_bhb_loop_affected() then).
> >
> > Refactoring "max_bhb_k" would be a general cleanup and not related to
> > anything else here, right?
> >
> > ...but the function is_spectre_bhb_affected() is called from
> > "cpu_errata.c" and has a scope. Can we guarantee that it's always
> > "SCOPE_LOCAL_CPU"? I tried reading through the code and it's
> > _probably_ SCOPE_LOCAL_CPU most of the time, but it doesn't seem worth
> > it to add an assumption here for a small cleanup.
> >
> > I'm not going to do this, though I will move "max_bhb_k" to be a
> > global for the suggestion below.
>
> If you make max_bhb_k a global, then whether you change all
> `spectre_bhb_loop_affected(SCOPE_SYSTEM)` calls to read the global
> directly or whether you keep it such that
> `spectre_bhb_loop_affected()` simply returns that global for
> SCOPE_SYSTEM makes no difference. I just think reading the global
> directly would look a bit cleaner. Calling a function that's called
> "...affected()" when you're really just trying to find out the K-value
> feels a bit odd.
>
> For is_spectre_bhb_affected(), I was assuming the change below where
> you combine all the `return true` paths, so the scope question
> wouldn't matter there.

Ah, right. OK.


> > > - Change the `return false` into `return true` at the end of
> > > is_spectre_bhb_affected (in fact, you can probably take out some of
> > > the other calls that result in returning true as well then)
> >
> > I'm not sure you can take out the other calls. Specifically, both
> > spectre_bhb_loop_affected() and is_spectre_bhb_fw_affected() _need_ to
> > be called for each CPU so that they update static globals, right?
> > Maybe we could get rid of the call to supports_clearbhb(), but that
> > _would_ change things in ways that are not obvious. Specifically I
> > could believe that someone could have backported "clear BHB" to their
> > core but their core is otherwise listed as "loop affected". That would
> > affect "max_bhb_k". Maybe (?) it doesn't matter in this case, but I'd
> > rather not mess with it unless someone really wants me to and is sure
> > it's safe.
>
> Yes, but spectre_bhb_enable_mitigation() already calls all those
> functions on its own again anyway, so I'm pretty sure the "must be
> called once for each CPU" part of spectre_bhb_loop_affected() is
> covered by that. (Besides, it would be really awful if they had made a
> function whose name starts with is_... have critical side-effects that
> break things when it doesn't get called.)

The existing predicates already do change globals before my patch and
changing that is outside of the scope of what I'm willing to entertain
with my patchset

Given that I'm not going to change the way the existing predicates
work, if I move the "fallback" setting `max_bhb_k` to 32 to
spectre_bhb_enable_mitigation() then when we set `max_bhb_k` becomes
inconsistent between recognized and unrecognized CPUs. One gets set in
the predicate and one doesn't. Even if it works, this inconsistency
feels like bad design to me. Also, setting `max_bhb_k` to the max at
the end of is_spectre_bhb_affected() would perhaps _help_ someone
realize that the predicate has side effects because they'd see it in
the function itself and not have to dig down.

I would also say that having `max_bhb_k` get set in an inconsistent
place opens us up for bugs in the future. Even if it works today, I
imagine someone could change things in the future such that
spectre_bhb_enable_mitigation() reads `max_bhb_k` and essentially
caches it (maybe it constructs an instruction based on it). If that
happened things could be subtly broken for the "unrecognized CPU" case
because the first CPU would "cache" the value without it having been
called on all CPUs.

In case you can't tell, I'm still not convinced and will plan to keep
setting `max_bhb_k =3D 32` in is_spectre_bhb_affected().


> > > - In spectre_bhb_enable_mitigations(), at the end of the long if-else
> > > chain, put a last else block that prints your WARN_ONCE(), sets the
> > > max_bhb_k global to 32, and then does the same stuff that the `if
> > > (spectre_bhb_loop_affected())` block would have installed (maybe
> > > factoring that out into a helper function called from both cases).
> >
> > ...or just reorder it so that the spectre_bhb_loop_affected() code is
> > last and it can be the "else". Then I can WARN_ONCE() if
> > spectre_bhb_loop_affected(). ...or I could just do the WARN_ONCE()
> > when I get to the end of is_spectre_bhb_affected() and set "max_bhb_k"
> > to 32 there. I'd actually rather do that so that "max_bhb_k" is
> > consistently set after is_spectre_bhb_affected() is called on all
> > cores regardless of whether or not some cores are unknown.
>
> Yeah, you can reorder the loops too. I don't feel like moving this
> into is_spectre_bhb_affected() would be a good idea. Functions with a
> predicate name like that really shouldn't have such side effects.
> Besides, I think is_spectre_bhb_affected() is probably called more
> often per CPU, both once from spectre_bhb_enable_mitigation() and by
> whatever calls the `matches` pointer in the cpu_errata struct.
> spectre_bhb_enable_mitigation() seems to be the function that's called
> once for each CPU on boot to install the correct mitigation, so that
> feels like the best spot to put the fallback logic to me.

As per above, while I agree that having predicate functions w/ side
effects is not ideal, that predates my patch series and I'd rather
things work consistently.

-Doug

