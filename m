Return-Path: <stable+bounces-196898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 038C2C8512F
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 855ED4E8407
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9656430E83D;
	Tue, 25 Nov 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jj3mOwhp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C833931A81F
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075733; cv=none; b=i3nZX5s0yropgIPWa0UAooM29er2E8Wyv2vShNVaCz+0dHAokR4oT+MmWGjn9uIlbg8isK2HuWgK/byLdj37ozJaTNvQAhfI1Sg33hVUT/FrqxvW9Fu2Ut8FscubmxSNTavJTy47a63YrcSnxzKBN8/eAj8wI6YNv3bLg8H6Hg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075733; c=relaxed/simple;
	bh=TigqVkS6DQDndoYNbK0oWMBbwRulRVW/005MhYv1R2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SD2yaFCX3aafXLcOoIUXT5FXZBTz64Af1VIQ6tw4Hpmir9/Sr/6rWE9RcjodVA/uzPif7NmnXaEweOnGdRvowvBOo4Zs4KJzj45U3QH2wp3VzC5arGVK9wlcdnu3huNHNXnAO/GHuH7I8TVqqaY8MnM5FPdmwmcmIDj5DDqZ17I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jj3mOwhp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29ba9249e9dso12185135ad.3
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 05:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764075731; x=1764680531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFo2hKIzH9XpgOYPVJKvzh8kRjtMBOJ9wnX7O+zKcGI=;
        b=Jj3mOwhp2tfMnGj/UmhBwmldBszh+6+EL5UlzWg4u/nUn8gyer1SW8Qy/CIjru7fQH
         nBEYcnmMI6oDFW3p/5SGGrD6JYRIah6VIZMH7jZTt3Vz0SuqPeKQ5dI6ij6KGXpMwjr3
         rz0F6xbijSl//FA4bhN36ZOdIt5txjRhu64sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075731; x=1764680531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFo2hKIzH9XpgOYPVJKvzh8kRjtMBOJ9wnX7O+zKcGI=;
        b=DkJpTZ3vphehaZujm8/wx4oBZHR7D9GbuAdNEyqiVQ7VpPKbZ37lErtDNXuLcbp9Jw
         qhuicqUBr8gkPMt4468s9TFNj/xIOdoXE7Sk8US4qSa+8ETojnZb+7LqGY3j/r0BzJ3O
         48ihJA7h1gBP5N6QIRj/ZeZ04x2sYwEKKYGZ+eWnBoLKi8+DS3fK+XJyN4vHcZM1dBH9
         eDy/9boyVPwNohylddQ5rRuig47Rxc7HShQfgWOGT2GHcq2p2xoiN2XI8Z77aq1pOCj/
         kkrHE25J87z2yYdsdSGhvgFU3Wz6Aew+1qSzz5rnt7gUMVY2V1RTC/Glk12RQH/DFmre
         /Ctw==
X-Forwarded-Encrypted: i=1; AJvYcCW0TprSTrJyL46r5kHKXtFYvufxkh/j2yPcvfdOExofMfee+GJIYWB+cCtWx0c93MWea9BTYi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNhVBNFI3XLipLw8U7uyy+ypNdKE/ED/6YCRxBM07ThYXBLsd
	NeCUoQ3sBEXhe391mIzV/tMVeKlwDQnENlmQL2d3Fr/gSHo1L89zhkz2AUsGr8nPu63OBAnEThQ
	/6co=
X-Gm-Gg: ASbGnctkKb7bOboj057Q7cNlbSyKpENhQMRQcr/XOyMoDDZH8yZzp4a1cBUd5Xybio6
	HzQzQtvUELPPE251oWZghoJ41BK5i1RUwn4Tv5W5A22man9INkNxp1lS7MuczWn7eQ8agCuldp6
	U5LKXrVRA+BwdzYdQOi1/71hgv5lolaO3/QRUe31R4ngI3oHFutRRsoopVR7iObC9IvEkgyHDtE
	uxWbSr2INFEUoEpzbB3qDHzQQL3RrjC2I8KfyVESLJthmlegehxEEcAMQapLP0hP/LWO0Xfecc+
	iSO25WRaDZ+WgNhsDs/kojqLoh8xEKesZoTaTR4Iv2wAozRODrSLo3UMLs1lEXhnLvomRxplVzm
	0lRgFn/PzKLaMVpjgQSYPxEm5luLg5b3KEEBMekAHOB8qSoY1iUr5/5hi2FYzbX9b34lzNj3k+Z
	fP/Pd+Se8q/xXM+NuMFw//ZW99WgFgtcY0/XT4Sbr1UESjWL3SIPrLQoXAfqGE
X-Google-Smtp-Source: AGHT+IGwqMR5kk4Getlgkte+wN4QzuSS17MeqzFqzoLIewz2mtVEWujEWyleSy25sN87L732HdlPGQ==
X-Received: by 2002:a17:903:2f8d:b0:298:52a9:31d4 with SMTP id d9443c01a7336-29b6c6b87c7mr198896165ad.54.1764075730021;
        Tue, 25 Nov 2025 05:02:10 -0800 (PST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com. [209.85.210.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b29b37fsm165298895ad.79.2025.11.25.05.02.08
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 05:02:08 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so5125855b3a.1
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 05:02:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgnLFX2vAAL4TgAeDYwJ9tY8zhTNUuuzmchyO8ij0RfKNlxs3chMFLp4fFb7MdQNy3ii8EJ5w=@vger.kernel.org
X-Received: by 2002:a05:7022:69a8:b0:11b:65e:f40 with SMTP id
 a92af1059eb24-11c9d709f69mr10782115c88.5.1764075726726; Tue, 25 Nov 2025
 05:02:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com> <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
 <2be3bf24-a707-48df-b224-22b5ab290006@arm.com>
In-Reply-To: <2be3bf24-a707-48df-b224-22b5ab290006@arm.com>
From: Yu-Che Cheng <giver@chromium.org>
Date: Tue, 25 Nov 2025 21:01:30 +0800
X-Gmail-Original-Message-ID: <CAKchOA31NGBWMdeSjky7MwOjU=dYmHVLbE7uUQHUXSZOzUHUeA@mail.gmail.com>
X-Gm-Features: AWmQ_bnGYnYvwZToS4iWnE0aV11bZtTOD6v7k6eS2rurzDMYiMJOuxPFEYEZqpA
Message-ID: <CAKchOA31NGBWMdeSjky7MwOjU=dYmHVLbE7uUQHUXSZOzUHUeA@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Tue, Nov 25, 2025 at 5:45=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Sergey,
>
> On 11/21/25 03:55, Sergey Senozhatsky wrote:
> > Hi Christian,
> >
> > On (25/11/20 10:15), Christian Loehle wrote:
> >> On 11/20/25 04:45, Sergey Senozhatsky wrote:
> >>> Hi,
> >>>
> >>> We are observing a performance regression on one of our arm64 boards.
> >>> We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpu=
freq:
> >>> Rework schedutil governor performance estimation").
> >>>
> >>> UI speedometer benchmark:
> >>> w/commit:   395  +/-38
> >>> w/o commit: 439  +/-14
> >>>
> >>
> >> Hi Sergey,
> >> Would be nice to get some details. What board?
> >
> > It's an MT8196 chromebook.
> >
> >> What do the OPPs look like?
> >
> > How do I find that out?
> >
> >> Does this system use uclamp during the benchmark? How?
> >
> > How do I find that out?
> >
> >> Given how large the stddev given by speedometer (version 3?) itself is=
, can we get the
> >> stats of a few runs?
> >
> > v2.1
> >
> > w/o patch     w/ patch
> > 440 +/-30     406 +/-11
> > 440 +/-14     413 +/-16
> > 444 +/-12     403 +/-14
> > 442 +/-12     412 +/-15
> >
> >> Maybe traces of cpu_frequency for both w/ and w/o?
> >
> > trace-cmd record -e power:cpu_frequency attached.
> >
> > "base" is with ada8d7fa0ad4
> > "revert" is ada8d7fa0ad4 reverted.
>
>
> I did some analysis based on your trace files.
> I have been playing some time ago with speedometer performance
> issues so that's why I'm curious about your report here.
>
> I've filtered your trace purely based on cpu7 (the single biggest cpu).
> Then I have cut the data from the 'warm-up' phase in both traces, to
> have similar start point (I think).
>
> It looks like the 2 traces can show similar 'pattern' of that benchmark
> which is good for analysis. If you align the timestamp:
> 176.051s and 972.465s then both plots (frequency changes in time) look
> similar.
>
> There are some differences, though:
> 1. there are more deeps in the freq in time, so more often you would
>     pay extra penalty for the ramp-up again
> 2. some of the ramp-up phases are a bit longer ~100ms instead of ~80ms
>     going from 2GHz to 3.6GHz

Agree. From the visualized frequency changes in the Perfetto traces,
it's more obvious that the ramp-up from 2GHz to 3.6GHz becomes much
slower and a bit unstable in v6.6.99, and it's also easier to go down
to a low frequency after a short idle.

> 3.
>
>
> There are idle phases missing in the trace, so we have to be careful
> when e.g. comparing avg frequency, because that might not be the real
> indication of the delivered computation and not indicate the gap in the
> score.
>
> Here are the stats:
> 1. revert:
> frequency
> count  1.318000e+03
> mean   2.932240e+06
> std    5.434045e+05
> min    2.000000e+06
> 50%    3.000000e+06
> 85%    3.600000e+06
> 90%    3.626000e+06
> 95%    3.626000e+06
> 99%    3.626000e+06
> max    3.626000e+06
>
> 2. base:
>            frequency
> count  1.551000e+03
> mean   2.809391e+06
> std    5.369750e+05
> min    2.000000e+06
> 50%    2.800000e+06
> 85%    3.500000e+06
> 90%    3.600000e+06
> 95%    3.626000e+06
> 99%    3.626000e+06
> max    3.626000e+06
>
>
> A better indication in this case would be comparison of the frequency
> residency in time, especially for the max freq:
> 1. revert: 11.92s
> 2. base: 9.11s
>
> So there is 2.8s longer residency for that fmax (while we even have
> longer period for finishing that Speedometer 2 test on 'base').
>
> Here is some detail about that run*:
> +---------------+---------------------+---------------+----------------+
> | Trace         | Total Trace         | Time at Max   | % of Total     |
> |               | Duration (s)        | Freq (s)      | Time           |
> +---------------+---------------------+---------------+----------------+
> | Base Trace    | 24.72               | 9.11          | 36.9%          |
> | Revert Trace  | 22.88               | 11.92         | 52.1%          |
> +---------------+---------------------+---------------+----------------+
>
> *We don't know the idle periods which might happen for those frequencies
>
>
> I wonder if you had a fix patch for the util_est in your kernel...
> That fix has been recently backported to 6.6 stable [1].
>
> You might want to try that patch as well, w/ or w/o this revert.
> IMHO it might be worth to have it on top. It might help
> the main Chrome task ('CrRendererMain') to stay longer on the biggest
> cpu, since the util_est would be higher. You can read the discussion
> that I had back then with PeterZ and VincentG [2].

No, the util_est fix isn't in our kernel yet.
It looks like after cherry-picking the fix, without the revert, the
Speedometer 2.0 score becomes even slightly higher than that on
v6.6.88 (450 ~ 460 vs 435 ~ 440).
On the other hand, with both the fix and the revert, the Speedometer
score becomes about 475 ~ 480, which is almost the same as using the
performance governor (i.e. pinning at the maximum frequency).
It looks like more tasks that originally run on the little cores are
migrated to the middle and big cores more often, which also makes CPU7
more likely to stay at a higher frequency during some short idle in
the main thread.

Also attach the Perfetto trace for both of them:

fix without revert:
https://ui.perfetto.dev/#!/?s=3Dff4d10bd58982555eada61648786adf6f7187ac3
fix with revert:
https://ui.perfetto.dev/#!/?s=3D05da3cedfb3851ad694f523ef59d3cd1092d74ae

>
> Regards,
> Lukasz
>
> [1]
> https://lore.kernel.org/stable/20251121130232.828187990@linuxfoundation.o=
rg/
> [2]
> https://lore.kernel.org/lkml/20230912142821.GA22166@noisy.programming.kic=
ks-ass.net/

Best regards,
Yu-Che

