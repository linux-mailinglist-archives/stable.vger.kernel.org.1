Return-Path: <stable+bounces-104401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 399F19F3CCD
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 22:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CA21884D58
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 21:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D371D5165;
	Mon, 16 Dec 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="isnOhTst"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759131D434F
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384572; cv=none; b=qQDtNcRIKRaPkIhe1pU3CkfqRV+c3Yllb2ZDQ0MuN4dF3wSog0CJ6xEfi4WHXGQGxcj4WQDu1X3Tipy/LO6x3OofkY5HuavyB5XPnoOSN+r5dx5Vi5JEBi2jvuWUuV6OPoO+oA6D0fgjIxYn1BzPZOzDOQTNGP1dMa9ccLj5xrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384572; c=relaxed/simple;
	bh=G/NWvy/T67wNQqnhJzeR7JlZsIpKitZV5e9Xln/qnac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/dzjKins3MU8BgW3+KL2md/1WB7wSwZhK4EXk+b8iXhb211sPKeyHMiuojYpt4s9Vy7uKC5BFGEkYj8XIZu8jpwlhq8M3ZB6SkqbXtP2C3Pr3udsFTz39vAbWxz0KWvnZWxAAY1EasXEZxUNgHHRCj0oqNsf7kqgAjg/ZSdmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=isnOhTst; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3011c7b39c7so50571381fa.1
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 13:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734384565; x=1734989365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/NWvy/T67wNQqnhJzeR7JlZsIpKitZV5e9Xln/qnac=;
        b=isnOhTstgGhcEf+8Ubq7BLyCbO+PZIK1YL9Pn9c7aARaYTZ+MD4J8uDgT60xa2EYL3
         NTG6Tutm+UeaPlYOO+w6o9HUEDHk0UvKuv4uMAW+6EbfyBRP7v/q0b5YuQVTC8+TGAb+
         bjrcLZtfZUtI+UuKCsvtfcaEaaNC75xLdUQsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734384565; x=1734989365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/NWvy/T67wNQqnhJzeR7JlZsIpKitZV5e9Xln/qnac=;
        b=qwlZU8eTcVoWyb747CKaw+FVuv+64Pc+0GfiBP9cd/bCyHKGyLOc4BHHi4xuYaoSLU
         e+F98ANNWzsEBNKTn+pu8dHUq6A+idLYztR+7hnllFjLCuS5eqRmiecb8ZbI4MTumC3o
         HNTv80nh75Cm2oAnrTJvjX81QN2ad/2ci5+IDA7uQBs+AEI+bY6gKyRZjf3EZSzgAV2d
         +sra8QcP3tMiscwp+5Rk0ZQjYd4kBBRldC5f7qbrdYWr+ikscLofaG01ckXu2suaMWv9
         4VnHUCq7Ozl2B7U473/jErVZCDvhfkC+NwaZsUb2eXjUy1Fgjyic0evJLz8Gjm10fFLd
         wi/w==
X-Forwarded-Encrypted: i=1; AJvYcCUdCev25kk6cUumoJ3shUQb2i8YaUQBSCS5ypsQXhBtZPZB+TtBEREiv/uu1t6uKWFRt9tGRuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHFgYeBCByN0WvsfHOvpROaQ4hCsAyLazJzIjBGXnHyQWXAGAO
	UTIwXH0y/BEa38UfU18NHdkP2nzJ0MmID4NUJn4FUNVLWBjt4yXmHPLbL6iLNQju4RItXszJ0tq
	35w==
X-Gm-Gg: ASbGncvc9wp5nTdRC0dtXHaUVwfEFICWmv5is1Ba8wHi59Yuo1pO1rmMI2VAXsdLCWS
	/jZCHjwZgqelQGL5XfbBa2/Z931A1ISaxAi3tjJsl5LWzQUV7G+/iMGsA1TPNtM5t+wRdRfMxcS
	jp4VamFBR04KBZ7AAYyDe04MVHDbZ3snmFI+MHYlbC1HcoZwu42/5uBNmeOc1cGgnh7tYLrHvzi
	VULIyckQutJWzCx1H5lQ0/YlTREeKNz/f79GnDCYbOHnIDjs9Z/6/Y1ZdCOl1Ouu1VU24b5neCz
	iWbAKoSYyuNKd3o0Ja8b
X-Google-Smtp-Source: AGHT+IEMHkJzvpXWvsF/evuJDZyu1j8XS/qRwqKSYvLvfpEa3C7BY/zoyZzol3SnCBUxBQCC2bde5w==
X-Received: by 2002:a2e:be8e:0:b0:302:3b3f:fdab with SMTP id 38308e7fff4ca-3025459d115mr59962401fa.28.1734384565375;
        Mon, 16 Dec 2024 13:29:25 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344175b76sm10352321fa.90.2024.12.16.13.29.23
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 13:29:24 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so4935132e87.0
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 13:29:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXknuuRfpEqAvltfV0/C1GBV6C6UQQkMk5tIepTyRhKAKyya0hM5Ma8tjaWwODKOyxqhPJ66XA=@vger.kernel.org
X-Received: by 2002:a05:6512:b94:b0:540:353a:df8e with SMTP id
 2adb3069b0e04-540905ab051mr4197028e87.39.1734384562829; Mon, 16 Dec 2024
 13:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214005248.198803-1-dianders@chromium.org>
 <20241213165201.v2.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid> <CAODwPW_c+Ycu_zhiDOKN-fH2FEWf2pxr+FcugpqEjLX-nVjQrg@mail.gmail.com>
In-Reply-To: <CAODwPW_c+Ycu_zhiDOKN-fH2FEWf2pxr+FcugpqEjLX-nVjQrg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 16 Dec 2024 13:29:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UHBA7zXZEw3K6TRpZEN-ApOkmymhRCOkz7h+yrAkR_Dw@mail.gmail.com>
X-Gm-Features: AbW1kvbmXu3MO-VJHQBuZxXwEAVNjn8ERCKhnS19UuE5S2BYm8ga04moQxlHz9o
Message-ID: <CAD=FV=UHBA7zXZEw3K6TRpZEN-ApOkmymhRCOkz7h+yrAkR_Dw@mail.gmail.com>
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

On Fri, Dec 13, 2024 at 6:25=E2=80=AFPM Julius Werner <jwerner@chromium.org=
> wrote:
>
> I feel like this patch is maybe taking a bit of a wrong angle at
> achieving what you're trying to do. The code seems to be structured in
> a way that it has separate functions to test for each of the possible
> mitigation options one at a time, and pushing the default case into
> spectre_bhb_loop_affected() feels like a bit of a layering violation.
> I think it would work the way you wrote it, but it depends heavily on
> the order functions are called in is_spectre_bhb_affected(), which
> seems counter-intuitive with the way the functions seem to be designed
> as independent checks.
>
> What do you think about an approach like this instead:
>
> - Refactor max_bhb_k in spectre_bhb_loop_affected() to be a global
> instead, which starts out as zero, is updated by
> spectre_bhb_loop_affected(), and is directly read by
> spectre_bhb_patch_loop_iter() (could probably remove the `scope`
> argument from spectre_bhb_loop_affected() then).

Refactoring "max_bhb_k" would be a general cleanup and not related to
anything else here, right?

...but the function is_spectre_bhb_affected() is called from
"cpu_errata.c" and has a scope. Can we guarantee that it's always
"SCOPE_LOCAL_CPU"? I tried reading through the code and it's
_probably_ SCOPE_LOCAL_CPU most of the time, but it doesn't seem worth
it to add an assumption here for a small cleanup.

I'm not going to do this, though I will move "max_bhb_k" to be a
global for the suggestion below.


> - Add a function is_spectre_bhb_safe() that just checks if the MIDR is
> in the new list you're adding
>
> - Add an `if (is_spectre_bhb_safe()) return false;` to the top of
> is_spectre_bhb_affected

That seems reasonable to do and lets me get rid of the "safe" checks
from is_spectre_bhb_fw_affected() and spectre_bhb_loop_affected(), so
it sounds good.


> - Change the `return false` into `return true` at the end of
> is_spectre_bhb_affected (in fact, you can probably take out some of
> the other calls that result in returning true as well then)

I'm not sure you can take out the other calls. Specifically, both
spectre_bhb_loop_affected() and is_spectre_bhb_fw_affected() _need_ to
be called for each CPU so that they update static globals, right?
Maybe we could get rid of the call to supports_clearbhb(), but that
_would_ change things in ways that are not obvious. Specifically I
could believe that someone could have backported "clear BHB" to their
core but their core is otherwise listed as "loop affected". That would
affect "max_bhb_k". Maybe (?) it doesn't matter in this case, but I'd
rather not mess with it unless someone really wants me to and is sure
it's safe.


> - In spectre_bhb_enable_mitigations(), at the end of the long if-else
> chain, put a last else block that prints your WARN_ONCE(), sets the
> max_bhb_k global to 32, and then does the same stuff that the `if
> (spectre_bhb_loop_affected())` block would have installed (maybe
> factoring that out into a helper function called from both cases).

...or just reorder it so that the spectre_bhb_loop_affected() code is
last and it can be the "else". Then I can WARN_ONCE() if
spectre_bhb_loop_affected(). ...or I could just do the WARN_ONCE()
when I get to the end of is_spectre_bhb_affected() and set "max_bhb_k"
to 32 there. I'd actually rather do that so that "max_bhb_k" is
consistently set after is_spectre_bhb_affected() is called on all
cores regardless of whether or not some cores are unknown.

