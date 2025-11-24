Return-Path: <stable+bounces-196765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D2DC81949
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 17:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B81D64E6809
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80CE299AB1;
	Mon, 24 Nov 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTIbIqRX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEE275111
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001858; cv=none; b=s6vr27mSHwtQ2cE7cq/ZqFumDZbfV8VmmFJDUaBnOAceCyCFGuvGSzh1TBh6ktBjzYtgWj9xrgk9cVv+BpZpQdHFM9oo78UbJEU1f2haGmHJvpDS0ZiNZDvitJHmA7Z/4gKnylRowWbNGNumFBmVAOJJd5A/ygnZUUWcDGJRCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001858; c=relaxed/simple;
	bh=/yg/3vFSu+t3Vszk9ER8F44Jhc1fq0F3jCN+kTU6NRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruUlypHD3nllyonTDhsP8JewUNWpOjgWUmc7jkWzPIs0XloupIRtADYjAHPTkIuIiNUmw9qV4n0uP856SHf/NkciiJDmyb8elgxioMn1U4y8hzKNGAia4+S6D15IyFisuK9/MWlvdm3xtAjHC3BtpJJCLcuQTsuhFz+eT4hCISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HTIbIqRX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso3504341b3a.1
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 08:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764001856; x=1764606656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt8dbF380bHvpju0TtrK3vC4wEeL415QsL7Oy2Q+loI=;
        b=HTIbIqRXZBjgC6tU0mJfLB1qA0F0pUNgUS2W1o0ud+mGzhHcpvVGJwDyZdbGqJJSvp
         HhV1wzeXhvlwUAiwfNfNOiHsO93s24nJpgpfPdWM6RKAwS4RN1dGmZ+iFJRFm+VTNxVR
         Tu2IkFFzV/52DQiNQhP6CuLo9PNXi56pQPJtE63uxx/4zecT37F568jVkNaOeid2i9el
         KmrxsKmPMIORONvFDw1P8r+RIGP6EBnhoufSOSdCIVdhmlIMX74GNhSxJoob/15RdfSB
         vDFWW0zvE9KX6cgj1E7hTNKE+k8/MsvRLERT0YKJdRReo2z153uzigno05PwQ+nN50EG
         5REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001856; x=1764606656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gt8dbF380bHvpju0TtrK3vC4wEeL415QsL7Oy2Q+loI=;
        b=WRDM6Kur1/lgDGp1ajeJHGiRICIKDf+lfP6rjf7wXzR5CYxombumbp/LfZKVkIHPKW
         JpAgIACxRJ1FwUGGKRi/kSEBSsaOPfaBS7/J995flWIKbTDcgWYr4fQOgPYw9a1+JH93
         NbDAyLGQTjUyNXVLuMmlbXtEOlfy0R+xU3DCij2SYZiTjWNsH6KSXzVD31/eDsH6wamD
         KlVlRr1EUNAm6La/qz2TFA7qamgbVEhTEk1jMurXDDSGvp8zeriYYsJJw4Hn9I4lfd0l
         RyMhH3AB5reke6zNaKMelPOndEdR4HZ9yVznk+L03REW4tfWEweg3ZhPbMTBe1ub5GEw
         Q7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvhY/CiSurmeOOvDoH8VGGfkGTxcjA8CLkm1kEnGNN5y3MoiZwJi2ovDp2pDwQMhTjVeoMN6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLJNbKCaSdd3d7RlqYnikU+eMoi3U4uHr6tBcBGSH5shWTwHjr
	KRXO8SqsgcD3wvkyrMbAg+ppM0Y7Q8ww3xEOsnRCMPwaDnwSpPzQh7wpB0M9DjdSvQ70gcQVWcb
	lR9tH8odIzJUDo052RwGiJnPVWD5H9poOrTXn4DvC/A==
X-Gm-Gg: ASbGnct+YlKS3ka5ddCVxzTrXlblxtO5mAbbDS+YviZoW9/ESbTPGeAGMdY5X2hDTp2
	w4TLj7i+2noD93mUVBrcpRY125qs0DixsYEKLgdsGYiksP0IeAcJg/wF/o1WVVRmY2HGs6N4zvo
	moSqNBCX5W2+TJqLj06Q0durCaYcetOroJ2MOhZekon7PbsSfWjP02e8bneooweNIu/8CSGNq99
	49DEs4wWa5itemr8qvfIp6U8GNYjck5ROFjstSvIP+iJgPP2GcHHpLYIa9gIoXwnj0AAczvgkVS
	d2ogavIsMoghfF0bxWJvp6JI
X-Google-Smtp-Source: AGHT+IGR5VI8o6yYk658ulbQ5bEgxqAw6UmHI9yJ75e7PHbfw3kfAS7Rm2DYxkaYHO8RPX9oaU8+doKKmiKxAR2qv0I=
X-Received: by 2002:a05:7022:4298:b0:119:e55a:9bf5 with SMTP id
 a92af1059eb24-11c9d716488mr7716513c88.17.1764001855869; Mon, 24 Nov 2025
 08:30:55 -0800 (PST)
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
In-Reply-To: <4345086e-d68b-47eb-adfa-939a7c6514ba@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 24 Nov 2025 17:30:39 +0100
X-Gm-Features: AWmQ_bnO-60uT4B0uBi4JCgHf8PtpGcrBwj4JKN0Aj6tHAHML4TPIg0thKqlqr8
Message-ID: <CAKfTPtAxu5yac6teiFcPkrR-6Ui=J1Q1q7+-PQ6iNjEZP_yuyg@mail.gmail.com>
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

On Fri, 21 Nov 2025 at 17:43, Christian Loehle <christian.loehle@arm.com> w=
rote:
>
> On 11/21/25 16:35, Christian Loehle wrote:
> > On 11/21/25 15:37, Yu-Che Cheng wrote:
> >> Hi Vincent,
> >>
> >> On Fri, Nov 21, 2025 at 10:00=E2=80=AFPM Vincent Guittot <vincent.guit=
tot@linaro.org>
> >> wrote:
> >>>
> >>> On Fri, 21 Nov 2025 at 04:55, Sergey Senozhatsky
> >>> <senozhatsky@chromium.org> wrote:
> >>>>
> >>>> Hi Christian,
> >>>>
> >>>> On (25/11/20 10:15), Christian Loehle wrote:
> >>>>> On 11/20/25 04:45, Sergey Senozhatsky wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> We are observing a performance regression on one of our arm64
> >> boards.
> >>>>>> We tracked it down to the linux-6.6.y commit ada8d7fa0ad4
> >> ("sched/cpufreq:
> >>>
> >>> You mentioned that you tracked down to linux-6.6.y but which kernel
> >>> are you using ?
> >>>
> >>
> >> We're using ChromeOS 6.6 kernel, which is currently on top of linux-v6=
.6.99.
> >> But we've tested that the performance regression still happens on exac=
tly
> >> the same scheduler codes (`kernel/sched`) as upstream v6.6.99, compare=
d to
> >> those on v6.6.88.
> >>
> >>>>>> Rework schedutil governor performance estimation").
> >>>>>>
> >>>>>> UI speedometer benchmark:
> >>>>>> w/commit:   395  +/-38
> >>>>>> w/o commit: 439  +/-14
> >>>>>>
> >>>>>
> >>>>> Hi Sergey,
> >>>>> Would be nice to get some details. What board?
> >>>>
> >>>> It's an MT8196 chromebook.
> >>>>
> >>>>> What do the OPPs look like?
> >>>>
> >>>> How do I find that out?
> >>>
> >>> In /sys/kernel/debug/opp/cpu*/
> >>> or
> >>> /sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequencies
> >>> with related_cpus
> >>>
> >>
> >> The energy model on the device is:
> >>
> >> CPU0-3:
> >> +------------+------------+
> >> | freq (khz) | power (uw) |
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> >> |     339000 |      34362 |
> >> |     400000 |      42099 |
> >> |     500000 |      52907 |
> >> |     600000 |      63795 |
> >> |     700000 |      74747 |
> >> |     800000 |      88445 |
> >> |     900000 |     101444 |
> >> |    1000000 |     120377 |
> >> |    1100000 |     136859 |
> >> |    1200000 |     154162 |
> >> |    1300000 |     174843 |
> >> |    1400000 |     196833 |
> >> |    1500000 |     217052 |
> >> |    1600000 |     247844 |
> >> |    1700000 |     281464 |
> >> |    1800000 |     321764 |
> >> |    1900000 |     352114 |
> >> |    2000000 |     383791 |
> >> |    2100000 |     421809 |
> >> |    2200000 |     461767 |
> >> |    2300000 |     503648 |
> >> |    2400000 |     540731 |
> >> +------------+------------+
> >>
> >> CPU4-6:
> >> +------------+------------+
> >> | freq (khz) | power (uw) |
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> >> |     622000 |     131738 |
> >> |     700000 |     147102 |
> >> |     800000 |     172219 |
> >> |     900000 |     205455 |
> >> |    1000000 |     233632 |
> >> |    1100000 |     254313 |
> >> |    1200000 |     288843 |
> >> |    1300000 |     330863 |
> >> |    1400000 |     358947 |
> >> |    1500000 |     400589 |
> >> |    1600000 |     444247 |
> >> |    1700000 |     497941 |
> >> |    1800000 |     539959 |
> >> |    1900000 |     584011 |
> >> |    2000000 |     657172 |
> >> |    2100000 |     746489 |
> >> |    2200000 |     822854 |
> >> |    2300000 |     904913 |
> >> |    2400000 |    1006581 |
> >> |    2500000 |    1115458 |
> >> |    2600000 |    1205167 |
> >> |    2700000 |    1330751 |
> >> |    2800000 |    1450661 |
> >> |    2900000 |    1596740 |
> >> |    3000000 |    1736568 |
> >> |    3100000 |    1887001 |
> >> |    3200000 |    2048877 |
> >> |    3300000 |    2201141 |
> >> +------------+------------+
> >>
> >> CPU7:
> >>
> >> +------------+------------+
> >> | freq (khz) | power (uw) |
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> >> |     798000 |     320028 |
> >> |     900000 |     330714 |
> >> |    1000000 |     358108 |
> >> |    1100000 |     384730 |
> >> |    1200000 |     410669 |
> >> |    1300000 |     438355 |
> >> |    1400000 |     469865 |
> >> |    1500000 |     502740 |
> >> |    1600000 |     531645 |
> >> |    1700000 |     560380 |
> >> |    1800000 |     588902 |
> >> |    1900000 |     617278 |
> >> |    2000000 |     645584 |
> >> |    2100000 |     698653 |
> >> |    2200000 |     744179 |
> >> |    2300000 |     810471 |
> >> |    2400000 |     895816 |
> >> |    2500000 |     985234 |
> >> |    2600000 |    1097802 |
> >> |    2700000 |    1201162 |
> >> |    2800000 |    1332076 |
> >> |    2900000 |    1439847 |
> >> |    3000000 |    1575917 |
> >> |    3100000 |    1741987 |
> >> |    3200000 |    1877346 |
> >> |    3300000 |    2161512 |
> >> |    3400000 |    2437879 |
> >> |    3500000 |    2933742 |
> >> |    3600000 |    3322959 |
> >> |    3626000 |    3486345 |
> >> +------------+------------+
> >>
> >>>>
> >>>>> Does this system use uclamp during the benchmark? How?
> >>>>
> >>>> How do I find that out?
> >>>
> >>> it can be set per cgroup
> >>> /sys/fs/cgroup/system.slice/<name>/cpu.uclam.min|max
> >>> or per task with sched_setattr()
> >>>
> >>> You most probably use it because it's the main reason for ada8d7fa0ad=
4
> >>> to remove wrong overestimate of OPP
> >>>
> >>
> >> For the speedometer case, yes, we set the uclamp.min to 20 for the who=
le
> >> browser and UI (chrome).
> >> There's no system-wide uclamp settings though.
> >
> > (From Sergey's traces)
> > Per-cluster time=E2=80=91weighted average frequency base =3D> revert:
> > little (cpu0=E2=80=933, max 2.4=E2=80=AFGHz): 0.746=E2=80=AFGHz =3D> 1.=
132=E2=80=AFGHz (+51.6%)
> > mid (cpu4=E2=80=936, max 3.3=E2=80=AFGHz): 1.043=E2=80=AFGHz =3D> 1.303=
=E2=80=AFGHz (+24.9%)
> > big (cpu7, max 3.626=E2=80=AFGHz): 2.563=E2=80=AFGHz =3D> 3.116=E2=80=
=AFGHz (+21.6%)
> >
> > And in particular time spent at OPPs (base =3D> revert):
> > Big core at upper 10%: 29.6% =3D> 61.5%
> > little cluster at 339=E2=80=AFMHz: 50.1% =3D> 1.0%
>
> Sorry, should be 1.0% =3D> 50.1%

Having in mind that we have uclamp min at 20% ~204, this means that
the tasks are not put in little cluster after the revert so the little
goes back to low freq but 204 is less than half of little capacity


>
> >
> > Interesting that a uclamp.min of 20 (which shouldn't really have
> > much affect on big CPU at all, with or without headroom AFAICS?)
> > makes such a big difference here?
>
> Can we get a sched_switch / sched_migrate / sched_wakeup trace for this?
> Perfetto would also do if that is better for you.
>
> >
> >>
> >> But we also found other performance regressions in an Android guest VM=
,
> >> where there's no uclamp for the VM and vCPU processes from the host si=
de.
> >> Particularly, the RAR extraction throughput reduces about 20% in the R=
AR
> >> app (from RARLAB).
> >> Although it's hard to tell if this is some sort of a side-effect of th=
e UI
> >> regression as the UI is also running at the same time.
> >>
> > I'd be inclined to say that is because of the vastly different DVFS fro=
m the
> > UI workload, yes.
> >
>

