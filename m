Return-Path: <stable+bounces-196766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD57C819FF
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 17:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CC0D346C5E
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9064313E0D;
	Mon, 24 Nov 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SO7R3bzy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC02BD5A1
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002464; cv=none; b=TAKASZmX5mv9ng7j+35Rv1z3JaNtu+5BrJP363ZAgj6tzkJ/2WjtSTDjklEIh9wL9OvvsZL2bqKNObVjL7V4reYS5d+S+KwPxpfyQZvx8wjyALKrSHqYhdIM9oe3T1LSm7pSL2VxDRMvl/zhxwy5M0ltdBTxKnZTMdzJOzh7r3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002464; c=relaxed/simple;
	bh=+s01IMGOq7fWaiX32857RFS00H0HRMLrnjTEDXiCuRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUN0ZRVXfLvcWkadtFzBubRRyZn3J2sIJIkNS2hN3ILkEptgBvW/SMxmq7TNTXEfWvr2oiJkKNIfod29XEfdEdfaR8q/dJ69j8OSdpWWbBrU9jPqHn3LokFOIEoWDIsL3mncp46wQ5EGspOUFGxRqqBzmJroh6ed9N8+taDm32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SO7R3bzy; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso499953a12.1
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764002461; x=1764607261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6HgUl5QsQnFckEI6mEv2Hd7RQpyPMXr+UUWpwJga+o=;
        b=SO7R3bzyL+eR8weKkXWjRKFzsiZ6fUP2n/W42UdPEqFagQhHP5Mw4kmi6bfekKV/F9
         J1yg/EP1dS55wmeleYTMKKeTRu6NzrNLOmw8j9oUpvR9A9Y7OHSQf8ES9d0oBmfZMZjy
         /5lBZxwYRDIdm9BW1pIenlTTrEQXjA1U8X1oA12km5R2USLW+lCQX6thTTdXYyHk8FbW
         y1exMXFZWXRel25nps2daFXmiYV01J9e+bB3B9Pu8BlI756xLOjGrA+V+mdvdStZ/sn/
         NBm99BJ9vR26mxqWdbI3AgwEiP3yMa3nwIQwF7P6CM8glyzApS7o3BtfaO9kHFUirpWr
         3/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764002461; x=1764607261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V6HgUl5QsQnFckEI6mEv2Hd7RQpyPMXr+UUWpwJga+o=;
        b=SJ1BxoPsHAeZzJjUS8/Vw4PgnEBUr5HqOwxL/by+EbanMeyjyEJGD0MHzg+N6PrWQk
         HK74KwbQ4e0LGPcGRGnIN1Vqddi3rPBh8hazwY1NUPZx8te7ygxrG6wkz42dbUK8/Fq7
         o8HQH4axV3EwNQivWNcyBQFjY+qwJaICXfg3iQIMjYEpssTzzjXJx6K3jEfxosBLwRrB
         IRjn9Lr4JQB+JMKDKSwnZn4KbRqVJjJiZ19t+Nyb0ChmRplXLsCcQt5k78Ix/Cf1S3Ru
         ZdHiwb5HRU1A0y0QNHPlaxioPtsYGxros1fb+aSK8w/plXvFhtF6++6tzMa3vvp8YpMx
         Ew1w==
X-Forwarded-Encrypted: i=1; AJvYcCUz9zwPe/h+6/TW3LLLC10z/C7bBYMEw4xn96Jnnp5/KmRu0NSY5NcaLOYUZuYwm6CvOulcQpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0FYsuqCc+62/J9XF1FM4F8cN1JT/xNqjS7ey4ptfHG2ly3KTW
	fRo4JEMFEjCTNIe6GMdlFQ/V08f95ds9lRg0t4FhyUpICYPHxWRvbsDcRA8ODjrig3kahFu7GXC
	7Kx192PJBn6X+iTRg4rNqotac4tx2tzXoDNT8+lw+4Q==
X-Gm-Gg: ASbGncuj+8j5n3V28W1jIhY/szbfZv6onip9mtxZzTrwDzQfEIUE8D5BT9TX20UUW1D
	EhsR1oNtHpiWwAJBuZaE3WGdM0VjAOyUYJOFuZLzCxY11aRSzwH0ijYwg+dg9zrcVulXb/Y9a8X
	qq2uT3RVQuDCEGzxZwbgua7Dd0mm9Y7+RjVoFCfl2xigIHnjNF+igaB1pXkBp1E92LhB4yaeTny
	tkCH5g7E8vhd0SvyRzB+QW/nhSGevIypIGeJr2F/ppX9iAGD6WinjUUPhJ0+5E1GU3L9opO0bbT
	cWPFg4OtmyO2+XoKSqPdFuDqfowRq9QR3LU=
X-Google-Smtp-Source: AGHT+IG++DSD0lIYFNQWemmFMsXda/eHOl1HHgkOF0KAP38QgeZAO7Xz7LPRHAHpvFdXMVxX44MWRPi4jWsYXecqkm0=
X-Received: by 2002:a05:6402:350b:b0:63b:ee76:3f63 with SMTP id
 4fb4d7f45d1cf-6455508801fmr12501053a12.7.1764002460734; Mon, 24 Nov 2025
 08:41:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com> <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
 <CAKfTPtBBtMysuYgBYZR2EH=WPR7X5F_RRzGmf94UhyDiGmmqCg@mail.gmail.com>
 <CAKchOA03GKXMUbfVvEXtyp3=-t0mWOzQVHNkB6F9QsMfTzCofA@mail.gmail.com>
 <6e50830f-a1b8-452a-86a7-1621cd3968ce@arm.com> <4345086e-d68b-47eb-adfa-939a7c6514ba@arm.com>
 <CAKfTPtAxu5yac6teiFcPkrR-6Ui=J1Q1q7+-PQ6iNjEZP_yuyg@mail.gmail.com>
In-Reply-To: <CAKfTPtAxu5yac6teiFcPkrR-6Ui=J1Q1q7+-PQ6iNjEZP_yuyg@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 24 Nov 2025 17:40:49 +0100
X-Gm-Features: AWmQ_bnyyz0dq-R1DfdxUATnp77naaqS9RgALhsGnBzFdUooYNuIAFZLU-BRPIE
Message-ID: <CAKfTPtCafw+VzSbfGtC+hxjxy=ioN9CmbsJMiRum777ds6GhSw@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Christian Loehle <christian.loehle@arm.com>
Cc: Yu-Che Cheng <giver@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Nov 2025 at 17:30, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 21 Nov 2025 at 17:43, Christian Loehle <christian.loehle@arm.com>=
 wrote:
> >
> > On 11/21/25 16:35, Christian Loehle wrote:
> > > On 11/21/25 15:37, Yu-Che Cheng wrote:
> > >> Hi Vincent,
> > >>
> > >> On Fri, Nov 21, 2025 at 10:00=E2=80=AFPM Vincent Guittot <vincent.gu=
ittot@linaro.org>
> > >> wrote:
> > >>>
> > >>> On Fri, 21 Nov 2025 at 04:55, Sergey Senozhatsky
> > >>> <senozhatsky@chromium.org> wrote:
> > >>>>
> > >>>> Hi Christian,
> > >>>>
> > >>>> On (25/11/20 10:15), Christian Loehle wrote:
> > >>>>> On 11/20/25 04:45, Sergey Senozhatsky wrote:
> > >>>>>> Hi,
> > >>>>>>
> > >>>>>> We are observing a performance regression on one of our arm64
> > >> boards.
> > >>>>>> We tracked it down to the linux-6.6.y commit ada8d7fa0ad4
> > >> ("sched/cpufreq:
> > >>>
> > >>> You mentioned that you tracked down to linux-6.6.y but which kernel
> > >>> are you using ?
> > >>>
> > >>
> > >> We're using ChromeOS 6.6 kernel, which is currently on top of linux-=
v6.6.99.
> > >> But we've tested that the performance regression still happens on ex=
actly
> > >> the same scheduler codes (`kernel/sched`) as upstream v6.6.99, compa=
red to
> > >> those on v6.6.88.
> > >>
> > >>>>>> Rework schedutil governor performance estimation").
> > >>>>>>
> > >>>>>> UI speedometer benchmark:
> > >>>>>> w/commit:   395  +/-38
> > >>>>>> w/o commit: 439  +/-14
> > >>>>>>
> > >>>>>
> > >>>>> Hi Sergey,
> > >>>>> Would be nice to get some details. What board?
> > >>>>
> > >>>> It's an MT8196 chromebook.
> > >>>>
> > >>>>> What do the OPPs look like?
> > >>>>
> > >>>> How do I find that out?
> > >>>
> > >>> In /sys/kernel/debug/opp/cpu*/
> > >>> or
> > >>> /sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequenci=
es
> > >>> with related_cpus
> > >>>
> > >>
> > >> The energy model on the device is:
> > >>
> > >> CPU0-3:
> > >> +------------+------------+
> > >> | freq (khz) | power (uw) |
> > >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> > >> |     339000 |      34362 |
> > >> |     400000 |      42099 |
> > >> |     500000 |      52907 |
> > >> |     600000 |      63795 |
> > >> |     700000 |      74747 |
> > >> |     800000 |      88445 |
> > >> |     900000 |     101444 |
> > >> |    1000000 |     120377 |
> > >> |    1100000 |     136859 |
> > >> |    1200000 |     154162 |
> > >> |    1300000 |     174843 |
> > >> |    1400000 |     196833 |
> > >> |    1500000 |     217052 |
> > >> |    1600000 |     247844 |
> > >> |    1700000 |     281464 |
> > >> |    1800000 |     321764 |
> > >> |    1900000 |     352114 |
> > >> |    2000000 |     383791 |
> > >> |    2100000 |     421809 |
> > >> |    2200000 |     461767 |
> > >> |    2300000 |     503648 |
> > >> |    2400000 |     540731 |
> > >> +------------+------------+
> > >>
> > >> CPU4-6:
> > >> +------------+------------+
> > >> | freq (khz) | power (uw) |
> > >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> > >> |     622000 |     131738 |
> > >> |     700000 |     147102 |
> > >> |     800000 |     172219 |
> > >> |     900000 |     205455 |
> > >> |    1000000 |     233632 |
> > >> |    1100000 |     254313 |
> > >> |    1200000 |     288843 |
> > >> |    1300000 |     330863 |
> > >> |    1400000 |     358947 |
> > >> |    1500000 |     400589 |
> > >> |    1600000 |     444247 |
> > >> |    1700000 |     497941 |
> > >> |    1800000 |     539959 |
> > >> |    1900000 |     584011 |
> > >> |    2000000 |     657172 |
> > >> |    2100000 |     746489 |
> > >> |    2200000 |     822854 |
> > >> |    2300000 |     904913 |
> > >> |    2400000 |    1006581 |
> > >> |    2500000 |    1115458 |
> > >> |    2600000 |    1205167 |
> > >> |    2700000 |    1330751 |
> > >> |    2800000 |    1450661 |
> > >> |    2900000 |    1596740 |
> > >> |    3000000 |    1736568 |
> > >> |    3100000 |    1887001 |
> > >> |    3200000 |    2048877 |
> > >> |    3300000 |    2201141 |
> > >> +------------+------------+
> > >>
> > >> CPU7:
> > >>
> > >> +------------+------------+
> > >> | freq (khz) | power (uw) |
> > >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> > >> |     798000 |     320028 |
> > >> |     900000 |     330714 |
> > >> |    1000000 |     358108 |
> > >> |    1100000 |     384730 |
> > >> |    1200000 |     410669 |
> > >> |    1300000 |     438355 |
> > >> |    1400000 |     469865 |
> > >> |    1500000 |     502740 |
> > >> |    1600000 |     531645 |
> > >> |    1700000 |     560380 |
> > >> |    1800000 |     588902 |
> > >> |    1900000 |     617278 |
> > >> |    2000000 |     645584 |
> > >> |    2100000 |     698653 |
> > >> |    2200000 |     744179 |
> > >> |    2300000 |     810471 |
> > >> |    2400000 |     895816 |
> > >> |    2500000 |     985234 |
> > >> |    2600000 |    1097802 |
> > >> |    2700000 |    1201162 |
> > >> |    2800000 |    1332076 |
> > >> |    2900000 |    1439847 |
> > >> |    3000000 |    1575917 |
> > >> |    3100000 |    1741987 |
> > >> |    3200000 |    1877346 |
> > >> |    3300000 |    2161512 |
> > >> |    3400000 |    2437879 |
> > >> |    3500000 |    2933742 |
> > >> |    3600000 |    3322959 |
> > >> |    3626000 |    3486345 |
> > >> +------------+------------+
> > >>
> > >>>>
> > >>>>> Does this system use uclamp during the benchmark? How?
> > >>>>
> > >>>> How do I find that out?
> > >>>
> > >>> it can be set per cgroup
> > >>> /sys/fs/cgroup/system.slice/<name>/cpu.uclam.min|max
> > >>> or per task with sched_setattr()
> > >>>
> > >>> You most probably use it because it's the main reason for ada8d7fa0=
ad4
> > >>> to remove wrong overestimate of OPP
> > >>>
> > >>
> > >> For the speedometer case, yes, we set the uclamp.min to 20 for the w=
hole
> > >> browser and UI (chrome).
> > >> There's no system-wide uclamp settings though.
> > >
> > > (From Sergey's traces)
> > > Per-cluster time=E2=80=91weighted average frequency base =3D> revert:
> > > little (cpu0=E2=80=933, max 2.4=E2=80=AFGHz): 0.746=E2=80=AFGHz =3D> =
1.132=E2=80=AFGHz (+51.6%)
> > > mid (cpu4=E2=80=936, max 3.3=E2=80=AFGHz): 1.043=E2=80=AFGHz =3D> 1.3=
03=E2=80=AFGHz (+24.9%)
> > > big (cpu7, max 3.626=E2=80=AFGHz): 2.563=E2=80=AFGHz =3D> 3.116=E2=80=
=AFGHz (+21.6%)
> > >
> > > And in particular time spent at OPPs (base =3D> revert):
> > > Big core at upper 10%: 29.6% =3D> 61.5%
> > > little cluster at 339=E2=80=AFMHz: 50.1% =3D> 1.0%
> >
> > Sorry, should be 1.0% =3D> 50.1%
>
> Having in mind that we have uclamp min at 20% ~204, this means that
> the tasks are not put in little cluster after the revert so the little
> goes back to low freq but 204 is less than half of little capacity

As Christian said, it would be good to have a trace with scheduler
events. Having task and cpu util would be interesting too: perfetto
should record all that for you

>
>
> >
> > >
> > > Interesting that a uclamp.min of 20 (which shouldn't really have
> > > much affect on big CPU at all, with or without headroom AFAICS?)
> > > makes such a big difference here?
> >
> > Can we get a sched_switch / sched_migrate / sched_wakeup trace for this=
?
> > Perfetto would also do if that is better for you.
> >
> > >
> > >>
> > >> But we also found other performance regressions in an Android guest =
VM,
> > >> where there's no uclamp for the VM and vCPU processes from the host =
side.
> > >> Particularly, the RAR extraction throughput reduces about 20% in the=
 RAR
> > >> app (from RARLAB).
> > >> Although it's hard to tell if this is some sort of a side-effect of =
the UI
> > >> regression as the UI is also running at the same time.
> > >>
> > > I'd be inclined to say that is because of the vastly different DVFS f=
rom the
> > > UI workload, yes.
> > >
> >

