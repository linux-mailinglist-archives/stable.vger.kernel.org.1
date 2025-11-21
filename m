Return-Path: <stable+bounces-196473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FE2C7A107
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 654C74F0AB6
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33AD31A553;
	Fri, 21 Nov 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncI78LyG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB20034C826
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733613; cv=none; b=XrTfBxxemGNFCPw/bjJLaIN71eTHEMOjCJYWEWMwJh/U15BLe7Dt0JGEys5AGcokf3+E5DwKXILELSuJbEO82GhmEtA5M5fdL5+LwPuY1VJBuquY6LpkgAiWI+yU5pu8R+O0v8usobiMLuVK9X2c1Soz4AbEq6tzdbBc2Sj9HHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733613; c=relaxed/simple;
	bh=vU4pYHitsr0hiKsk/HUXzExLHhMPcEsJvVyAtRbwpjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6cJhDH1ihO1f0u7pkEP8U5KhMnxass41/wNImWUrjawQqd4aq3M43gB19YWk43x08CUfPfKKCt38JrwitZMeE5kFf1LDkJlmfh6BfGURg5lTs4wzW1dMAOpXrUIEu57+BeB0QuwHl5qR6ArLb7gL6WaSnZgpWQM3PUMnTOdSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ncI78LyG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b72cbc24637so358743066b.0
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 06:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763733610; x=1764338410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJL0FJVgKrnVFnqIMVj+hUZotuSnFwRiu+YmMsHAZn0=;
        b=ncI78LyGUPkXjIcDqOGuax6gRooZSEpqQd5UvkFYXhLn9ofour1wfe7DrYxMwKfEOv
         oRj3AG+7qbzs51/YO2UROD5fE+DUCM9obH7awX1ytWswQFJSmw7QRWHp2v2UVuKA1Dnb
         5/59YS0VeI5+pUuxKdo8whhGxoLUZLW8a9XdOIjbBlBecHPi3EyOCFH6mJ32MvUZRdb6
         nAs8TgiuurvfB6pSGB0UTxDRtDB1ljNIJdyml6UT6KiPIobNpB9okVzlKP+tvjpLJeZB
         d4NZh3yr++3mcA9b6qhSFZTgo/hO2ktpdjmyr9xQSfrH8dBen2T4Ff3wfd90MnVtV/bY
         +KWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763733610; x=1764338410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJL0FJVgKrnVFnqIMVj+hUZotuSnFwRiu+YmMsHAZn0=;
        b=djAqAT4UpC23dYfhIgzg74mkk4VCQ9QbIHwnJoYho58n1bB5/Xr3OyvqbubZcWdnIJ
         HFaPrnIYzbXUmwNJTBIOmWHvoMlCFO1jnmxidS01CxuNAu24bU+hwpcHcw2n3erybtuQ
         Eg/Yw+ELDxodwFN2qR5260H30MRd+dAENp8gGFgiWaGA5zmLDTfI+vZEQfyo6nyczbhe
         zChdeCHWnl3/QLdm+xEMq5ONPyD4XgWrZwA5/XV7fyVgqngGEB3sBkTAYlVR+Ykr6J4V
         XK0cmg1Wj90Shx3tu/Rx9PJyb9TOM/W5/eWM2vm0C2ywCO8j9vgYd4Azm5JqEqdpx+IJ
         Kwng==
X-Forwarded-Encrypted: i=1; AJvYcCXkv+MZnCvHzztHbgf4JgQ+exnhiauBlCb1rH6kDiw0rf1oAgeNU5BiOSysOkwKahgjK/zKpqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/2JuFSEnv71hMTCprlx5DTnOhjnIbmbCO/qGA4OFGkmZPOtg
	6v3ah9KAo42csG+9BajzoPc/XGtwwqwo6RiNTuMagndpJI5VQI3+nH6BglV+iK0KZTXzWqaWkCO
	hSSPGWxvdlbNNdA/t7T75RK/xF2KtzmsRKVpBwAwQXg==
X-Gm-Gg: ASbGncsmSLT/nhiyYE3hecI/g+36ANscSfMAmQD9Erwm9nFSg2ZWvl3Lx3HS2HcFCA6
	0igHrSa0fijd+j8d6W94+ZgotFPuMIgtYIR5V8nyPgLg3HqbVMS4yvIfYceiWY2Mseixr/FyExt
	VzYSLWRd1GkPGl5J8V3TLVKKmROuwlt0Qg74w1/Bq1buA20lidenj8MWCbDWGUZA6xJHk+daQSw
	zRCM49F69uZ2DsMgvVWjxuaZgbniQ3f/1Ec8MEhM4JEcho7EPd6uHEfGce29urhsuOCf/n59nqP
	ru8V+mlPQjhNJcrnwXWD2M5d
X-Google-Smtp-Source: AGHT+IFAnmvurUyPCUUptc+x0iNJfNhwaQBmwEu4uxZnrH0TRieIGTMUyHGeXO2SOgALfueMMABITJEJzG57A7u8Ohg=
X-Received: by 2002:a17:907:d05:b0:b73:6b24:14b5 with SMTP id
 a640c23a62f3a-b7671a47bafmr272081766b.31.1763733610141; Fri, 21 Nov 2025
 06:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com> <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
In-Reply-To: <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 21 Nov 2025 14:59:58 +0100
X-Gm-Features: AWmQ_bmM4o5Z3q1ve2PQdTw2QsE7ykHgVxbu8IqvT3a4hy7EoAQ4fqrzOXFlGbg
Message-ID: <CAKfTPtBBtMysuYgBYZR2EH=WPR7X5F_RRzGmf94UhyDiGmmqCg@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yu-Che Cheng <giver@google.com>, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 04:55, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hi Christian,
>
> On (25/11/20 10:15), Christian Loehle wrote:
> > On 11/20/25 04:45, Sergey Senozhatsky wrote:
> > > Hi,
> > >
> > > We are observing a performance regression on one of our arm64 boards.
> > > We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:

You mentioned that you tracked down to linux-6.6.y but which kernel
are you using ?

> > > Rework schedutil governor performance estimation").
> > >
> > > UI speedometer benchmark:
> > > w/commit:   395  +/-38
> > > w/o commit: 439  +/-14
> > >
> >
> > Hi Sergey,
> > Would be nice to get some details. What board?
>
> It's an MT8196 chromebook.
>
> > What do the OPPs look like?
>
> How do I find that out?

In /sys/kernel/debug/opp/cpu*/
or
/sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequencies
with related_cpus

>
> > Does this system use uclamp during the benchmark? How?
>
> How do I find that out?

it can be set per cgroup
/sys/fs/cgroup/system.slice/<name>/cpu.uclam.min|max
or per task with sched_setattr()

You most probably use it because it's the main reason for ada8d7fa0ad4
to remove wrong overestimate of OPP

>
> > Given how large the stddev given by speedometer (version 3?) itself is, can we get the
> > stats of a few runs?
>
> v2.1
>
> w/o patch     w/ patch
> 440 +/-30     406 +/-11
> 440 +/-14     413 +/-16
> 444 +/-12     403 +/-14
> 442 +/-12     412 +/-15
>
> > Maybe traces of cpu_frequency for both w/ and w/o?
>
> trace-cmd record -e power:cpu_frequency attached.
>
> "base" is with ada8d7fa0ad4
> "revert" is ada8d7fa0ad4 reverted.

