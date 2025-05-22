Return-Path: <stable+bounces-146101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E79AC0ECC
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 16:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68FA188B160
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E0B28C870;
	Thu, 22 May 2025 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdiCYPFw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23128C877
	for <stable@vger.kernel.org>; Thu, 22 May 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925513; cv=none; b=bIvb8UxsfC2NVd7jBvbMKFVg3wDTZcLdPPkoZdR2kBPlMcudLNDbIbGnYtJ8b06BDkQM1QtoMPViawvju5cwTOeL2xyMmFew4hpynt2AZbHhouNNZmbyJTjsYAGur5g2rENpV3UNh+XXE4KrziFc0R7ygXr5CVhnh9r+8Knnscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925513; c=relaxed/simple;
	bh=NEGa2Lvo0VHyrDn2dfZSXfnMD3VzC1tI27MkvHbZIKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCVdLwBPJWrrdr+aP0cokVcLkSIWaoo+O6FM1Ds/wBphed2sxfQCUJSQhVATkVu6Elbir+5b+d5Zx9uvXaE5izAzNxJfN6B3Wym8cbLKZ8RPoug/CLEQoGVz9QjgyKitv/3eU880xRaiP1nEyatdBKxNtiTwngM9NTD5l1MxG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kdiCYPFw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad52dfe06ceso730001866b.3
        for <stable@vger.kernel.org>; Thu, 22 May 2025 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747925510; x=1748530310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=if965oZYMwcs5T6DXjAoq7MGEz2mOJ2Vn9bNEq+AKGA=;
        b=kdiCYPFwh/BzNTGN726u5e7M7b5UHKkMGeJtbVoa+X9FGbEqniIf3QM+6+Ab19QMXE
         /hCkE0bvYc58O69B04iiiQABmK2AUh3VUUfib7NdbfmTNvVDJCKgDcmJuV1/daZ5M+Mt
         X02CX71mlwD1QsnpjAtrfSug/MM7grNxd+M0Ok9aLWul/jS03u4BnTAvVL0tecKo/pHi
         C1uENx+wmrXVng+gOZm4/kby6gUzZQwWVeaGaUzibzO7BSue4MA/Qwo2HnAOlmLKELm9
         PRRJ1ISgpJ+pnuC0/DZR3+/p1HKqhjDqq1lpmavoxHBBTieDkYNa2NGKaySG0MlhiFyZ
         ggjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925510; x=1748530310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=if965oZYMwcs5T6DXjAoq7MGEz2mOJ2Vn9bNEq+AKGA=;
        b=oGnwaexCMMO5sJM5ODvPpa0VyceHH+uz9rg9VHLNa5csq55wG8Wx4v39vQDsgENkuT
         IcmIKbCV6ZAaRiAZkjeoQrFzCY2I+v/mGmPlPgB06zta5BtTwkN4BypXjCfG9VE8aQbT
         5iIJUk/W7Yo0LLNMB5yawOv0AUmyJ+ARDgtMYc2QSc84aP8N8uaqsXWHVoe5ABR5GemG
         qaVZdz7FI5hqloJmOBy6fYlaP+9LXPKvpw5NNofOWzDleNwl25pfcrWd+fKq6osVXkmD
         HOfx9LkPnugNhpE6vylBTx+d4rfqU6kZgIikn4hCr2sKe3fjEt/fykU/AQcg+dFZNg/t
         dbFw==
X-Forwarded-Encrypted: i=1; AJvYcCWiEEjZyMg16v7ftzPKGW0ogkoQligHA+Dkp/drzjy7GTjGhEF5uBVkp5H6hxA8pquwg+xvLPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM04EVIcdhVfUKTdcKVZPD1fsEopNUap4BmrK2kGtYoCvA6OI2
	V1pbtnSJ5bdPb4Lv4CLuNQWbrjedxus6soXho/2Z2XjG/Zr0yPjb7sfdAbOeUF2vnd2hvhTmN5Q
	J2UOis+u6YSFVEmwH+VjSt3HohsM012R+fDLHr3rBWA==
X-Gm-Gg: ASbGnct7YnNb31aAucxNNkEXOPvXN9Y594CGDYD5j83Va5TuIH57iYsB7d2WlIHfFDd
	94HMu2tjrE8QlK9M9Cdv+V7r3c+WKU/Y7dby+3tSCXjQ7sMTORk/QVwSLe1BbR7eF4XSP7nE+Yh
	lBmO6c6dwoKFNeGG/unNR6FRHsgotMOerzA1Tu9zv01Wj9LvD+4CMPY+4JDsc=
X-Google-Smtp-Source: AGHT+IEWWodIXY6RPzmgsLl29LtMjEztepnXSAqOidAoBrsS8Lw4awvNzuVYZIqKaYEoqKapvbrKCUHcq2jJyT9DmhA=
X-Received: by 2002:a17:906:6a14:b0:ac3:bf36:80e2 with SMTP id
 a640c23a62f3a-ad52d4c2ed3mr2316934866b.20.1747925510014; Thu, 22 May 2025
 07:51:50 -0700 (PDT)
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
In-Reply-To: <db7b5ad7-3dad-4e7c-a323-d0128ae818eb@ateme.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 22 May 2025 16:51:34 +0200
X-Gm-Features: AX0GCFvdXP-4idhTJtDESTwuQOtxpJxvvZ6RDqVKNRr-ZF6A0JkBHH_UMh9yOgw
Message-ID: <CAKfTPtDkmsFD=1uG+dGOrYfdaap4SWupc8kVV8LanwaXSbxruA@mail.gmail.com>
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

Hi Jean-Baptiste,

On Fri, 16 May 2025 at 17:05, Jean-Baptiste Roquefere
<jb.roquefere@ateme.com> wrote:
>
> Hello Prateek,
> long time no see... I've been very busy lately.
>
> Did he try with relax_domain_level=3, i.e. prevent newilde idle
>
>
> >> balance between LLC ? I don't see results showing that it's not enough
> >> to prevent newly idle migration between LLC
> >
> > I don't think he did. JB if it isn't too much trouble, could you please
> > try running with "relax_domain_level=3" in kernel cmdline and see if
> > the performance is similar to "relax_domain_level=2".
>
> I just tried relax_domain_level=3 on my payload. As you can see
> relax_domain_level=3 performances are more or less the same

As there is no difference between level2 and level3, I assume that the
problem is not linked to a core to core migration but only the
migration between LLC.

As said previously, I don't see an obvious connection between commit
16b0a7a1a0af  ("sched/fair: Ensure tasks spreading in LLC during LB")
which mainly ensures a better usage of CPUs inside a LLC. Do you have
cpufreq and freq scaling enabled ? The only link that I could think
of, is that the spread of task inside a llc favors inter LLC newly
idle load balance

>
> +--------------------+---------------------+---------------------+
> | Kernel             | 6.12.17 relax dom 2 | 6.12.17 relax dom 3 |
> +--------------------+---------------------+---------------------+
> | Utilization (%)    | 52,01               | 52,15 |
> | CPU effective freq | 1 294,12            | 1 309,85 |
> | IPC                | 1,42                | 1,40 |
> | L2 access (pti)    | 38,18               | 38,03 |
> | L2 miss   (pti)    | 7,78                | 7,90 |
> | L3 miss   (abs)    | 33 929 609 924,00   | 33 705 899 797,00 |
> | Mem (GB/s)         | 49,10               | 48,91 |
> | Context switches   | 107 896 729,00      | 106 441 463,00 |
> | CPU migrations     | 16 075 947,00       | 18 129 700,00 |
> | Real time (s)      | 193,39              | 193,41 |
> +--------------------+---------------------+---------------------+
>
> We got the point that tuning this variable is not a good solution, but
> for now it's the only one we can apply.
>
> Without this tuning our solution loses real time video processing. With
> : we keep real time on.
>
>
> Thanks for your help, I'll stay alert on this thread if someday a better
> solution can emerge.
>
>
> Regards,
>
>
> jb
>

