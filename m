Return-Path: <stable+bounces-196513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B14AC7AA95
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67D3E4E43DE
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11F73346A9;
	Fri, 21 Nov 2025 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GQEhRjmM"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724432F759
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740466; cv=none; b=O1ZSG4hIm8Z+6oGDmi5gh/tOQjL3WXSPghbw+x32kJ6ujbXeo/x+fS5cEY+KlKfzdwvuEWlIc/yx0NWWpD+rdfMyswpwVijHSkXTsN/fD6w1ZL3VgMaWXNv9mRCfzEanjvb96Y603GfztZbTRBBm7loDR/pvugcYDyZbHmauh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740466; c=relaxed/simple;
	bh=CSzS5noCEE5PWQvUphRjNHfuR40Fqs3MLNv0oZstaW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+Ejs8DCZ8Bm6X4JnWCUQ1bDW1Az1O2zxU+GpVM5zBiWHgsp7sXP653kAqEggLshyr/BAISNcPbllnLSdmptVXeV6s1nWlGs7U+3swEvruAWWB2W+tZpjVkjq6Vn86DLtyKl7h7wZJN43DTNMW6fqhBPf4jOSqAZ68FuJcFD7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GQEhRjmM; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-559934e34bcso620263e0c.1
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 07:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763740463; x=1764345263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfT2bQElUpzvxBFgvql/qjDEiLfZvX/L5WNx/vnBEGM=;
        b=GQEhRjmMnZHq3gI1r8jYwmW7gG0/cUbQUG1lX+7PX3FaH0NlRnAY0wU2cPBMbfCOfx
         vrGJ/chkRfu2LEfSRutMeO5te5aj0/0rXSlqPRMbS15rj/OYWzot+9ml/5/87jiKOfqy
         ICQqDYPTOOT8DqjjtF2MtQ0DnYCFf/ksk1K0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763740463; x=1764345263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfT2bQElUpzvxBFgvql/qjDEiLfZvX/L5WNx/vnBEGM=;
        b=sLiMDjdn4W+kCun2Zzq7qhxJ2GbqFe6sgS9JYK8nup1HozH3ybea79pq+GZqjt0fUw
         J7a90Lv4EEAYTYa9prRwwMjoNAhugx1COuECHYvRdwaxNx/qsy0il4eNva6EaACUxeX/
         3RxvsI33kWknMa9LHrClGyM+lEbd7rPRl3AiObllTV7OTlyyz40eclaLTVXTW9r2rmLa
         lTSqqFJR5WVrSG7YYMo+02eVjXG+WQd+MPMEW4/O9c7NdwGTI71WzQid3tOr8z+ITNOh
         7yjWPlowDy2HnR45bLKkvSp9C8Z6FB7bw9oTyNckWjZ2I8cOy7B+qTClDGo83Oqn3w0i
         jLqg==
X-Forwarded-Encrypted: i=1; AJvYcCUQbUjhq3KRQjjoykMP3lxZeapmQOgO/JbF1qyQzlgk9QIC1MZND2zws0kh5ltLwgxVu2+58Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuSzKMQZtbtCueUKAha+oyw/x6Wx5Kgb4DVEFrfhqpqGMhPcIn
	OUnDM2Jxb9QQ5WTigQzS81rp0qdEU/ALxhvw8jXFYQ9KsiAvhOrDXUoC22YJn6IYA1136FAoE0i
	YYZvnWw==
X-Gm-Gg: ASbGnctYIaHDvSgq63Xut30E4PlJyj2TKIP0ntj1N4M9W2V9HvwxMzgAdg2+FiGYK3A
	S+SRaG2VBb52P2ML9Q2EnA1SFwkJSYuKB280qaLii/q5HNhW7AWxJp6fRQbfVKCmqD0uZg9Zj/n
	ULmRuJIBFacpVc0T1eNRFgvvx2hAglXuzWUmMKZCYiLlLhNiSWtlpY6myWFTbMY7sYdE9TYUxUp
	1z2m9+n2Sx5s0OVkJHtrEZ/xe1jUz+zbd4PIKoPYSa99+fe9nnX8IgnP6W7Wjb07BmKv/xJH+gf
	KcwY9v5gCsHrHDwqvoKkapTq24048IMdyNNwjrb+xuQ/YZcA/Y9MYYCie8q73IHodXYeltnleK6
	KGsY6fdl/tjl4tU6vZ6RAgjbO8zhtTRzyLOSZIskKJW9YKe4sLWaXezDeYkANQ3aWazGqWmpbac
	IbMBc55EiUyVL+XM/oAxyeupwDtbHbinzJlrlx6cnJZrJNpImtQ0C2Wy8u
X-Google-Smtp-Source: AGHT+IFmwNdRxWMy5vGm0Jj0wEdpeUgr35L5gQKI5U8w7BYvZsNssc86XBMBObby917PvgXFE/JIRQ==
X-Received: by 2002:a05:6122:8c20:b0:55b:aab:95e8 with SMTP id 71dfb90a1353d-55b8d6f83d7mr807600e0c.9.1763740463445;
        Fri, 21 Nov 2025 07:54:23 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f657f41sm2491417e0c.9.2025.11.21.07.54.21
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 07:54:21 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9352cbe2e14so615232241.3
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 07:54:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWref2PGX1DeFHt6a/JYItMKF3b7yqgeKyAWkaSPqpJhF/SG+kT8XCHX6cz5X75LvjjDkyIXNY=@vger.kernel.org
X-Received: by 2002:a05:6102:5109:b0:5de:6dc:2296 with SMTP id
 ada2fe7eead31-5e1de2cfa42mr812358137.31.1763740460694; Fri, 21 Nov 2025
 07:54:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com> <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
 <CAKfTPtBBtMysuYgBYZR2EH=WPR7X5F_RRzGmf94UhyDiGmmqCg@mail.gmail.com>
In-Reply-To: <CAKfTPtBBtMysuYgBYZR2EH=WPR7X5F_RRzGmf94UhyDiGmmqCg@mail.gmail.com>
From: Yu-Che Cheng <giver@chromium.org>
Date: Fri, 21 Nov 2025 23:53:43 +0800
X-Gmail-Original-Message-ID: <CAKchOA3Kxc6M+nih7sEinOZnMX3qO60hF+jWHCfW5PZh10F-hA@mail.gmail.com>
X-Gm-Features: AWmQ_bmTRD3G8jYZB_E6oSM7wsgR8D-CwYDwL9AzeqFT7s6u44NVAeuBQjm6m6c
Message-ID: <CAKchOA3Kxc6M+nih7sEinOZnMX3qO60hF+jWHCfW5PZh10F-hA@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry that I accidentally sent in non-plain-text mode... Resend the
email to the mailing list again.

Hi Vincent,

On Fri, Nov 21, 2025 at 10:00=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 21 Nov 2025 at 04:55, Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > Hi Christian,
> >
> > On (25/11/20 10:15), Christian Loehle wrote:
> > > On 11/20/25 04:45, Sergey Senozhatsky wrote:
> > > > Hi,
> > > >
> > > > We are observing a performance regression on one of our arm64 board=
s.
> > > > We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/c=
pufreq:
>
> You mentioned that you tracked down to linux-6.6.y but which kernel
> are you using ?
>

We're using ChromeOS 6.6 kernel, which is currently on top of linux-v6.6.99=
.
But we've tested that the performance regression also happens on
exactly the same scheduler codes (`kernel/sched`) as upstream v6.6.99,
compared to those on v6.6.88.

> > > > Rework schedutil governor performance estimation").
> > > >
> > > > UI speedometer benchmark:
> > > > w/commit:   395  +/-38
> > > > w/o commit: 439  +/-14
> > > >
> > >
> > > Hi Sergey,
> > > Would be nice to get some details. What board?
> >
> > It's an MT8196 chromebook.
> >
> > > What do the OPPs look like?
> >
> > How do I find that out?
>
> In /sys/kernel/debug/opp/cpu*/
> or
> /sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequencies
> with related_cpus
>

The energy model on the device is:

CPU0-3:
+------------+------------+
| freq (khz) | power (uw) |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
|     339000 |      34362 |
|     400000 |      42099 |
|     500000 |      52907 |
|     600000 |      63795 |
|     700000 |      74747 |
|     800000 |      88445 |
|     900000 |     101444 |
|    1000000 |     120377 |
|    1100000 |     136859 |
|    1200000 |     154162 |
|    1300000 |     174843 |
|    1400000 |     196833 |
|    1500000 |     217052 |
|    1600000 |     247844 |
|    1700000 |     281464 |
|    1800000 |     321764 |
|    1900000 |     352114 |
|    2000000 |     383791 |
|    2100000 |     421809 |
|    2200000 |     461767 |
|    2300000 |     503648 |
|    2400000 |     540731 |
+------------+------------+

CPU4-6:
+------------+------------+
| freq (khz) | power (uw) |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
|     622000 |     131738 |
|     700000 |     147102 |
|     800000 |     172219 |
|     900000 |     205455 |
|    1000000 |     233632 |
|    1100000 |     254313 |
|    1200000 |     288843 |
|    1300000 |     330863 |
|    1400000 |     358947 |
|    1500000 |     400589 |
|    1600000 |     444247 |
|    1700000 |     497941 |
|    1800000 |     539959 |
|    1900000 |     584011 |
|    2000000 |     657172 |
|    2100000 |     746489 |
|    2200000 |     822854 |
|    2300000 |     904913 |
|    2400000 |    1006581 |
|    2500000 |    1115458 |
|    2600000 |    1205167 |
|    2700000 |    1330751 |
|    2800000 |    1450661 |
|    2900000 |    1596740 |
|    3000000 |    1736568 |
|    3100000 |    1887001 |
|    3200000 |    2048877 |
|    3300000 |    2201141 |
+------------+------------+

CPU7:

+------------+------------+
| freq (khz) | power (uw) |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
|     798000 |     320028 |
|     900000 |     330714 |
|    1000000 |     358108 |
|    1100000 |     384730 |
|    1200000 |     410669 |
|    1300000 |     438355 |
|    1400000 |     469865 |
|    1500000 |     502740 |
|    1600000 |     531645 |
|    1700000 |     560380 |
|    1800000 |     588902 |
|    1900000 |     617278 |
|    2000000 |     645584 |
|    2100000 |     698653 |
|    2200000 |     744179 |
|    2300000 |     810471 |
|    2400000 |     895816 |
|    2500000 |     985234 |
|    2600000 |    1097802 |
|    2700000 |    1201162 |
|    2800000 |    1332076 |
|    2900000 |    1439847 |
|    3000000 |    1575917 |
|    3100000 |    1741987 |
|    3200000 |    1877346 |
|    3300000 |    2161512 |
|    3400000 |    2437879 |
|    3500000 |    2933742 |
|    3600000 |    3322959 |
|    3626000 |    3486345 |
+------------+------------+

> >
> > > Does this system use uclamp during the benchmark? How?
> >
> > How do I find that out?
>
> it can be set per cgroup
> /sys/fs/cgroup/system.slice/<name>/cpu.uclam.min|max
> or per task with sched_setattr()
>
> You most probably use it because it's the main reason for ada8d7fa0ad4
> to remove wrong overestimate of OPP
>

For the speedometer case, yes, we set the uclamp.min to 20 for the
whole browser and UI (chrome).
There's no system-wide uclamp settings though.

But we also found other performance regressions in an Android guest
VM, where there's no uclamp for the VM and vCPU processes from the
host side.
Particularly, the RAR extraction throughput reduces about 20% in the
RAR app (from RARLAB).
Although it's hard to tell if this is some sort of a side-effect of
the UI regression as the UI is also running at the same time.

> >
> > > Given how large the stddev given by speedometer (version 3?) itself i=
s, can we get the
> > > stats of a few runs?

By the way, it's speedometer version 2.0 (or 2.1).

> >
> > v2.1
> >
> > w/o patch     w/ patch
> > 440 +/-30     406 +/-11
> > 440 +/-14     413 +/-16
> > 444 +/-12     403 +/-14
> > 442 +/-12     412 +/-15
> >
> > > Maybe traces of cpu_frequency for both w/ and w/o?
> >
> > trace-cmd record -e power:cpu_frequency attached.
> >
> > "base" is with ada8d7fa0ad4
> > "revert" is ada8d7fa0ad4 reverted.

