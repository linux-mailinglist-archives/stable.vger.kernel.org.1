Return-Path: <stable+bounces-105347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E869F835A
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 19:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB2E167AD8
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11491A0BDB;
	Thu, 19 Dec 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZecH/Dqi"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26971A00D1
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633395; cv=none; b=ZYcO0BoXy/51O/VinYB/rosxO6BYLMbhe9nDbA/LLAOFnCFyd0nWC6oUQdHw69mMPcJnIKMOzn7po3FzdMCc2Cqh3k8JZPI2m10a/CRuVbW8xvhRW6eqimvMs1bE1NMwVkqjFRNiZVE8+c1ypIRT+6RPwGzPhbAOKGzvtL3aUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633395; c=relaxed/simple;
	bh=rGd7ObbG8am+yMUo8jY97Hpu/e58CJlvRLs1UHv0j9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLLmQ5OmWS13Ldf60pI5cpaXNu0Tg5RHK4u6o0IvIuJS0ivpyj8K+e8eI9WtlpN61uvKt6nRcGfRZNZ5X1BaCdoXMN6yQtljpw7rQjxz5m9pmaJAa+U+ryr5g2DScWpWILkP3zi7LWxkW3MKiF9hxkbT0mOuLtV/o37CnANJmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZecH/Dqi; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30229d5b21cso12018701fa.1
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 10:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734633390; x=1735238190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGd7ObbG8am+yMUo8jY97Hpu/e58CJlvRLs1UHv0j9A=;
        b=ZecH/Dqix56cbVkOQLg7JRGzEYxo3FnlKEv/y3iT/WCevgm7eZ8Q2kmLzs8rK+i3jX
         ecT4RfjuIALqWv2zJ7bMklYjj/vHiaVrFGh6mUiPFndua8sCX/fZvDeqdqxO90SToBpG
         sZvXhwqdz0kMfRBrOq2E+9R9Fy9UKf9kp6v80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734633390; x=1735238190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGd7ObbG8am+yMUo8jY97Hpu/e58CJlvRLs1UHv0j9A=;
        b=C8/gYKDMakSwNB8JRHlXXJlg7Ak4FNmNWXy2ZjLSdqVeu1TtXj/SjS3psTwq51bc+l
         pWM+ficP/tgSUVm5r5hvQlcF/Z98EmtwBdPI7tJoqR1kfuETBDbq5hEQ7f1MPqjyAybE
         paoG0hjYRk2FDOccnyYUlU9qw6JkV3Q/omVqCToEVZj17aA7uTMrvLs+9F1ck4zBQy6e
         wz6iw045xBnGZ858w9c2RRha48Ld2LadigrfoJXiyqA8eyvQwzE82dFanhT0/rv3GuX6
         IxLKZDgG0ove6TW6kc66/EaMSWqR9lZZjs5wxoJyUkkf9otI467ZpfBJhB2EOZiU+Kjj
         TzbA==
X-Forwarded-Encrypted: i=1; AJvYcCWWZgoSWajF4uB+JJGYmCrDZXwYXmh7+FWAnYFVoGWsEIVKiIUzpZT8/JOFzftqDH8gvgODgro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPjBnIcwmgRbZ2VwtBauESW/OWWncRNHSV/MUma8amvtu0UVS
	JPFzda26hENFBiTW07a0xwP8NI/DM/bI+yirUKpO8O0BUyqTLzlgY1ciVwERVG/l9rnTtcIqmaC
	4ZQ==
X-Gm-Gg: ASbGncslyTMrZQrt2c5SdOJInp8Ch4gVs8PGhGTeX63ovVPWSXqOD5anHW8Bz4XlEWW
	QaFOfU17Z/gXXvPr/7tN9EijaSLKtGBlQxxpmPtKX5KgEdwtU1Xpmx+gjfu+PzEqa+8KLl+BWRR
	UeD1aBciayzYsRImopseSojP4Nt+AxwO4HvW4bBpwHl6oZjz9HgFm5riuK7I8AIciNQ5Nux1YZG
	gKncsZ/7EkOvBHPgrZee8U+WsimeMbrhDV4bSD6cE+TvWSV+bYSAURPlYBWAO5hN1zckoyeUhIF
	ZD37NEZqZU9Jhy9bee7s
X-Google-Smtp-Source: AGHT+IEc41Ntv0Clax92oJS+UpguaLvUBIJwFAMMdDRzDNEDaVHg8EL2NSM9Nrg1ytzpe9z9nPS8Ug==
X-Received: by 2002:a2e:b8d5:0:b0:300:2464:c0c2 with SMTP id 38308e7fff4ca-3046850a101mr502621fa.8.1734633390206;
        Thu, 19 Dec 2024 10:36:30 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045b069ef9sm2916141fa.91.2024.12.19.10.36.28
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 10:36:28 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso1077133e87.0
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 10:36:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTPqKZOU9z1eyqUXsgRtUsw4u7gluoEJOcoMJ3ADW4FJ90PF6IUbYpuPw/cPOiJPU+u7YKYdM=@vger.kernel.org
X-Received: by 2002:a05:6512:1320:b0:540:1fcd:1d9a with SMTP id
 2adb3069b0e04-5422102f5cbmr1448494e87.48.1734633388364; Thu, 19 Dec 2024
 10:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214005248.198803-1-dianders@chromium.org>
 <20241213165201.v2.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid> <20241219175128.GA25477@willie-the-truck>
In-Reply-To: <20241219175128.GA25477@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 19 Dec 2024 10:36:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WnbMegiKDuV1HeWrGyQx42+bPZjwKQ09Q++b-fFBm7gg@mail.gmail.com>
X-Gm-Features: AbW1kvYHski0KpEwR6JI2rs7ZczsyhWkjzlkYCDe4FZwiR8jg7mutRjD544Tlw8
Message-ID: <CAD=FV=WnbMegiKDuV1HeWrGyQx42+bPZjwKQ09Q++b-fFBm7gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm64: errata: Assume that unknown CPUs _are_
 vulnerable to Spectre BHB
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-msm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Julius Werner <jwerner@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	Roxana Bradescu <roxabee@google.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	bjorn.andersson@oss.qualcomm.com, stable@vger.kernel.org, 
	James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 19, 2024 at 9:51=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Fri, Dec 13, 2024 at 04:52:02PM -0800, Douglas Anderson wrote:
> > The code for detecting CPUs that are vulnerable to Spectre BHB was
> > based on a hardcoded list of CPU IDs that were known to be affected.
> > Unfortunately, the list mostly only contained the IDs of standard ARM
> > cores. The IDs for many cores that are minor variants of the standard
> > ARM cores (like many Qualcomm Kyro CPUs) weren't listed. This led the
> > code to assume that those variants were not affected.
> >
> > Flip the code on its head and instead list CPU IDs for cores that are
> > known to be _not_ affected. Now CPUs will be assumed vulnerable until
> > added to the list saying that they're safe.
> >
> > As of right now, the only CPU IDs added to the "unaffected" list are
> > ARM Cortex A35, A53, and A55. This list was created by looking at
> > older cores listed in cputype.h that weren't listed in the "affected"
> > list previously.
>
> There's a list of affected CPUs from Arm here:
>
> https://developer.arm.com/Arm%20Security%20Center/Spectre-BHB
>
> (obviously only covers their own designs).
>
> So it looks like A510 and A520 should be unaffected too, although I
> didn't check exhaustively. It also looks like A715 is affected but the
> whitepaper doesn't tell you what version of 'k' to use...
>
> > Unfortunately, while this solution is better than what we had before,
> > it's still an imperfect solution. Specifically there are two ways to
> > mitigate Spectre BHB and one of those ways is parameterized with a "k"
> > value indicating how many loops are needed to mitigate. If we have an
> > unknown CPU ID then we've got to guess about how to mitigate it. Since
> > more cores seem to be mitigated by looping (and because it's unlikely
> > that the needed FW code will be in place for FW mitigation for unknown
> > cores), we'll choose looping for unknown CPUs and choose the highest
> > "k" value of 32.
>
> I don't think we should guess. Just say vulnerable.

Ah, I see. So the series won't actually _fix_ anyone, it will just
properly report that we're vulnerable. I guess that works.


> > The downside of our guessing is that some CPUs may now report as
> > "mitigated" when in reality they should need a firmware mitigation.
> > We'll choose to put a WARN_ON splat in the logs in this case any time
> > we had to make a guess since guessing the right mitigation is pretty
> > awful. Hopefully this will encourage CPU vendors to add their CPU IDs
> > to the list.
>
> Hmm. We shouldn't have to guess here as the firmware mitigation is
> discoverable. So if it's unavailable and we're running an a CPU which
> needs it, then we're vulnerable.

Sure.

-Doug

