Return-Path: <stable+bounces-146327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A3BAC3AF0
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 09:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066033A4002
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BEB1E1DEC;
	Mon, 26 May 2025 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gpFXMSgJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BFD1E1A20
	for <stable@vger.kernel.org>; Mon, 26 May 2025 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748246000; cv=none; b=hxkBk6Z1Wi9EAmXW7Cs7hpn48v0pVJ74qWvow9zH2lyfnv+k1FD8hXVDaYIi2CSxe0iajX0pjsf0/o/VAD+mtgxjev8Vo2xheWnnyQMa823hsupoDeJDjZ8es72gKRUxQQ6WvGZxfiGhOtFz7mJg55X7App5TP0P4a4koz/9JrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748246000; c=relaxed/simple;
	bh=8zGG98q9qUYZNS1ImPKzK++WJb03mJOL5AJYgz2KFCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JetWg5VAndjZY53iFtB9cpykTqBMp9GC5E//8ODk21x2ykWJjkOIk62QMQAJtluYHSJjw/0MWnNhV0BTsQLGavjxkY++lStAOlfq6JWSuyaE7du0baD3d9t14Q2QIutKLTXy4dl6l6EyBeVUQSE9tmaNfTgy7tZMmmk19GotSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gpFXMSgJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad883afdf0cso5311166b.0
        for <stable@vger.kernel.org>; Mon, 26 May 2025 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748245997; x=1748850797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AXjdGFDhJ6dNVjl5AY3P4sCfMdaDyI2qz17SglDOYM0=;
        b=gpFXMSgJQhPdX5UeopVBNb7w6/CoU2PjayQ9+ojv1LsNI75uhEq8NuuzNEO2XwTDCE
         lQjANMZ5MNcNonkrh2vkXKM1VeCb3Jr+d7HaUVX5fZ14Lg7BQ9OmJ9brhQZQXDmhS/hN
         Sdstz4qPi/7XVm/Burk2ajpErLeh3WRXEM5cmrvZhZbzYLbKhBlO8QmDtN0CPz4/XimA
         s1h4+AyMFw3LatLb2W8bPiT/vjcirip0TIt2YI+NASJ5Cwgwx4BsKoLsGF5d0tyrO+cF
         cpoFoKYGl+WXzyF2abSt6xkuQKB1WwiG7csu9PgbopUrvrRXUUOiAvY7R8eZZU7e/E5b
         N8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748245997; x=1748850797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXjdGFDhJ6dNVjl5AY3P4sCfMdaDyI2qz17SglDOYM0=;
        b=uUZZJMbb4gRkkCdUJdpQK6VI9R/jQhF7spHFchvGlJkVMHV7wNIe8YO6AEpuupLihi
         sZu9bUzCexzLeC6VNmHVd+KycaBciXcl+ZbDGloi3r5BTxLRqqdhUo0HPQHXNSuB7p4f
         JMabODoW/agyyL0m1XE6BRG15bK74aaDgwG+iUddJu4otKuU4shEJhJqWnQgXWIRnpPQ
         OHd2ZoDk88N3mol4GPQA8pEIFeUDG48P5dhxu6ARxBoAw5OCypCgzCp6VmX+dcOt1tHU
         nslHZae/KgUWvDM51jnZ3b8QKFqEIDZm9ggB+6fRFzdC1PN8BMndpRQOtTnXxTivS5d+
         JFlA==
X-Forwarded-Encrypted: i=1; AJvYcCUIZrmpaOuhNomvHLNc19P+8mTEu/G6M2Flbju/cCxOnMy2oedhK9GcVHdHoIHge8ukLjYP7tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIl9WUEQ0KGUN/sVA1J/Bo/Gr/C3aKVrmgrDlbJAWU9htdCZ0q
	zRfk8TKKIcYAj2RJwyApKCbX8SZluR0QrZBEUO6bLRE4VJMPuR3+eQeBDB5Piur6xwiTA2vh6xD
	Tqrw/U8dWvGzTtLloGwCY6ea+/XfZOsOF8TNhASpLKQ==
X-Gm-Gg: ASbGncusVfxxJIfKf0AJj7okDgXWpAZ0DBz2wnOZ1nMX6AjmYziE/6haBPAKLSlCjaO
	nT/GdCXqgKKQweyUWVuLOJlMImyq/XBPM8yvXo8eZ0Uwx0ULk6AMCUN2R5aekEPh+LK/R5Ym9q0
	Y9b0AimLbGSPbG+nPbBv6o0AuKXujf3CuRqXIwl66FlXBNpIMtdMDwwlwOkY3SNvFrt0BWZAHi
X-Google-Smtp-Source: AGHT+IEHR623wBlrfv2bAwYHebBHB/uVZnyri8NclAhYoOaAPShxgc2ECJIYwH4Jo6EBzAfQkeCfgUHu9q3L/BOSO8s=
X-Received: by 2002:a17:907:9803:b0:ad4:8ec1:8fc9 with SMTP id
 a640c23a62f3a-ad85b20aca2mr724880666b.42.1748245996928; Mon, 26 May 2025
 00:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
 <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com> <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
 <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com> <CAKfTPtBovA700=_0BajnzkdDP6MkdgLU=E3M0GTq4zoLW=RGhA@mail.gmail.com>
 <de22462b-cda6-400f-b28c-4d1b9b244eec@amd.com> <CAKfTPtC6siPqX=vBweKz+dt2zoGiSQEGo32yh+MGhxNLSSW1_w@mail.gmail.com>
 <c0e87c08-f863-47f3-8016-c44e3dce2811@amd.com> <db7b5ad7-3dad-4e7c-a323-d0128ae818eb@ateme.com>
 <CAKfTPtDkmsFD=1uG+dGOrYfdaap4SWupc8kVV8LanwaXSbxruA@mail.gmail.com> <fea6da1d-85d6-459d-9ac3-661d5909420b@ateme.com>
In-Reply-To: <fea6da1d-85d6-459d-9ac3-661d5909420b@ateme.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 26 May 2025 09:53:05 +0200
X-Gm-Features: AX0GCFuROGCSyLoX-AVhsYdFkI6e9UYLuZkd2WamYF2gufcPj-7lR5ZaPUa4N-s
Message-ID: <CAKfTPtAPPG2Xa1P9r+NQZv_VkYRic+e-qxG1ODJodPUqdry7BQ@mail.gmail.com>
Subject: Re: IPC drop down on AMD epyc 7702P
To: Jean-Baptiste Roquefere <jb.roquefere@ateme.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	"mingo@kernel.org" <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Valentin Schneider <vschneid@redhat.com>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 May 2025 at 14:24, Jean-Baptiste Roquefere
<jb.roquefere@ateme.com> wrote:
>
> Hello Vincent,
>
> > As said previously, I don't see an obvious connection between commit
> > 16b0a7a1a0af  ("sched/fair: Ensure tasks spreading in LLC during LB")
> > which mainly ensures a better usage of CPUs inside a LLC. Do you have
> > cpufreq and freq scaling enabled ? The only link that I could think
> > of, is that the spread of task inside a llc favors inter LLC newly
> > idle load balance
> # lsmod | grep cpufreq
> cpufreq_userspace      16384  0
> cpufreq_conservative    16384  0
> cpufreq_powersave      16384  0
>
>
> but I'm not sure cpufreq is well loaded :
>
> # cpupower frequency-info
> analyzing CPU 0:
>    no or unknown cpufreq driver is active on this CPU
>    CPUs which run at the same hardware frequency: Not Available
>    CPUs which need to have their frequency coordinated by software: Not
> Available
>    maximum transition latency:  Cannot determine or is not supported.
> Not Available
>    available cpufreq governors: Not Available
>    Unable to determine current policy
>    current CPU frequency: Unable to call hardware
>    current CPU frequency:  Unable to call to kernel
>    boost state support:
>      Supported: yes
>      Active: yes
>      Boost States: 0
>      Total States: 3
>      Pstate-P0:  2000MHz
>      Pstate-P1:  1800MHz
>      Pstate-P2:  1500MHz
>
> And I cant find cpufreq/ under /sys/devices/system/cpu/cpu*/

Looks like you don't have cpufreq driver so we can forget a perf drop
because of a lower avg freq
Thanks

>
>
> Thanks for your help,
>
> jb
>

