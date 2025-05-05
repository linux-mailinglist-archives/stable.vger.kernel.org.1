Return-Path: <stable+bounces-139708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ED7AA9706
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF45170637
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80C725DB13;
	Mon,  5 May 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rkURpThN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F61525A2D2
	for <stable@vger.kernel.org>; Mon,  5 May 2025 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457867; cv=none; b=dJfyl/lfk46qaJRNQF748tPKibvcuCuqtWKf+zS+Wb2lbmgykP1q8TOUvrLhLff2u/JNxuFOh2v5NtanSVJpiFW4d3Ddyj7J8yq3QBdQVTCysfNKIvErI7Y/IrZzSnD2PwXujwt5IeIIHnWF39uXwqdapMCAvdxWfidJSbgmles=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457867; c=relaxed/simple;
	bh=pBSU+i+mpQmbCxqb+l45MEZnOucbUsIa1Ybw9DczQzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U03ePCGXxIGdnXYB9PCeTzpdBQvIjhfP/tIYG9a3tXDTF1uLcyZNd970Dp02z52Cm+Ywp3Vi9dPfVkJJF+bd8ztcoyiwj8M2sHmrMC5+TuSUww3ibln1zo8JCCtNMf9Rn4QqkpbpI5+/y6xtRHyn8ht6ZAaNv7nBHLLD/F0Xv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rkURpThN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so745665866b.1
        for <stable@vger.kernel.org>; Mon, 05 May 2025 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746457861; x=1747062661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i9wML/xLpYYqfIBMOeUqyFoxTmu2U5NAGM6uMVztntg=;
        b=rkURpThNpAi4WSDRQddqMynNCv+c+fKrbxM7V/Aox3Vb9crSvyHfAwy771NqVeRvM7
         J8mW520kEpqucijeVk2r5aZpBoFBIrHfRPTMEzrDPOGhLGoV62VyhDa6Z9jS751qxW7q
         QbLYspK2WLCcHfelHmknwoc0O+dqH4dds0fxjWL64rY4qsifkyyBA5fJ/todYO93mdVP
         DpHHSV4nL/V5fRaiX3k2mz9xk9r+a9GjmauoLHQgWbMgddOFvAMdz1KBn85CNbywgxdw
         AwxckzaYkzJLj9aT3sTV+M6Z9cqo3aTJJuFZ4BtbWrUW/dK2wL0NtOMYJyEHaTXfMhqy
         QO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746457861; x=1747062661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9wML/xLpYYqfIBMOeUqyFoxTmu2U5NAGM6uMVztntg=;
        b=GcB7vNXbnR7aQizBvm5AysSRnN7pW2ToUf7LlW/C0yv76T26gFNwQ8F7VikKMXGKlT
         Y/r7K9nE7NDkk1EA4RjDycCoXIuM5CUOpRG8yV7pouK9QNZV0IuV+LQ2THEl8EHryHGd
         w5Lz95cI6Dmw4debnuIX5M89PmB3lSy68nSzsc9NSLnSyo/OCqexPIWre1FMUcuTAQhm
         Dy6SidT7PdtznwffSM1Ra7pfsi6GWBnhNvSsDF68S2fWDFM/NIqDsCSrZtBSRgqMeayU
         XFbyRJgEqddndftfXN00P6pYQVkd5p49GAvgp79G9r3ofyoWfhUTLXELf6tOPQIoN+gF
         1q3A==
X-Forwarded-Encrypted: i=1; AJvYcCUVBBUGqjnxfLqXKtXfqxTxrJnvaAz3ul8h0pJVIXv7kzAasYhP/Ux5md4saOZIaChdTu+NGIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+KspGX2Vv2pPpiA0qfqGBZ0u3TfrrFSL+NhpZzEs1OvHSgC9x
	wn3XaFCYSoBQokOw3NMQw20SMth/SqDBjjGii4Z8Nia4lfvWdAA21I+edXTkkbAe1TlC4uLDe4e
	4se0kB60jt4eCyExDnUK5GCK17QlBeWPnYGHJVQ==
X-Gm-Gg: ASbGncuZWAhQJ4ckyf0lcAd+ywhOirC7RBtE/oHRUlFckQSBKvghRBZFcG35Uk6Xjx4
	LSDoVovJhmrLWaQPiN5mbm9ycJMlS12FGy0edEy2uOwKzOSFln9khCU/jSBDPkIKsSNb8NGaTAs
	6vCZZbTVCVtqnIvxP0gkBX1ZlbdARf1DwdzdgSL0VWiqClm70Q7LY=
X-Google-Smtp-Source: AGHT+IFWkNtGAga6J16A8HKiYJ4SY2/o0Msa04cQUJk7YPbvTNuKFTsMbSZxQChXOVr5+3LUR9RdojulzJSqTTqNRDc=
X-Received: by 2002:a17:907:1c1d:b0:aca:d83b:611b with SMTP id
 a640c23a62f3a-ad1a4a8d3d5mr716977766b.43.1746457860528; Mon, 05 May 2025
 08:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
 <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com> <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
 <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com> <CAKfTPtBovA700=_0BajnzkdDP6MkdgLU=E3M0GTq4zoLW=RGhA@mail.gmail.com>
 <de22462b-cda6-400f-b28c-4d1b9b244eec@amd.com>
In-Reply-To: <de22462b-cda6-400f-b28c-4d1b9b244eec@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 5 May 2025 17:10:47 +0200
X-Gm-Features: ATxdqUEpRr0s0YMR4bSumWKWv0-Woy7WG2WhTlTCQARD72sKZ0DENvnoHm-LHds
Message-ID: <CAKfTPtC6siPqX=vBweKz+dt2zoGiSQEGo32yh+MGhxNLSSW1_w@mail.gmail.com>
Subject: Re: IPC drop down on AMD epyc 7702P
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Jean-Baptiste Roquefere <jb.roquefere@ateme.com>, Peter Zijlstra <peterz@infradead.org>, 
	"mingo@kernel.org" <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Valentin Schneider <vschneid@redhat.com>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 14:29, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> On 5/5/2025 3:58 PM, Vincent Guittot wrote:
> > On Wed, 30 Apr 2025 at 11:13, K Prateek Nayak<kprateek.nayak@amd.com> wrote:
> >> (+ more scheduler folks)
> >>
> >> tl;dr
> >>
> >> JB has a workload that hates aggressive migration on the 2nd Generation
> >> EPYC platform that has a small LLC domain (4C/8T) and very noticeable
> >> C2C latency.
> >>
> >> Based on JB's observation so far, reverting commit 16b0a7a1a0af
> >> ("sched/fair: Ensure tasks spreading in LLC during LB") and commit
> >> c5b0a7eefc70 ("sched/fair: Remove sysctl_sched_migration_cost
> >> condition") helps the workload. Both those commits allow aggressive
> >> migrations for work conservation except it also increased cache
> >> misses which slows the workload quite a bit.
> > commit 16b0a7a1a0af  ("sched/fair: Ensure tasks spreading in LLC
> > during LB") eases the spread of task inside a LLC so It's not obvious
> > for me how it would increase "a lot of CPU migrations go out of CCX,
> > then L3 miss,". On the other hand, it will spread task in SMT and in
> > LLC which can prevent running at highest freq on some system but I
> > don't know if it's relevant for this SoC.
>
> I misspoke there. JB's workload seems to be sensitive even to core to
> core migrations - "relax_domain_level=2" actually disabled newidle
> balance above CLUSTER level which is a subset of MC on x86 and gets

Did he try with relax_domain_level=3, i.e. prevent newilde idle
balance between LLC ? I don't see results showing that it's not enough
to prevent newly idle migration between LLC

> degenerated into the SMT domain.
>
> >
> > commit c5b0a7eefc70 ("sched/fair: Remove sysctl_sched_migration_cost
> > condition") makes newly idle migration happen more often which can
> > then do migrate tasks across LLC. But then It's more about why
> > enabling newly idle load balance out of LLC if it is so costly.
>
> It seems to be very workload + possibly platform specific
> characteristic where re-priming the cache is actually very costly.
> I'm not sure if there are any other uarch factors at play here that
> require repriming (branch prediction, prefetcher, etc.) after a task
> migration to reach same IPC.
>
> Essentially "relax_domain_level" gets the desired characteristic
> where only the periodic balance will balance long-term imbalance
> but as Libo mentioned the short term imbalances can build up
> and using "relax_domain_level" might lead to other problems.
>
> Short of pinning / more analysis of which part of migrations make
> the workload unhappy, I couldn't think of a better way to
> communicate this requirement.
>
> >
> >> "relax_domain_level" helps but cannot be set at runtime and I couldn't
> >> think of any stable / debug interfaces that JB hasn't tried out
> >> already that can help this workload.
> >>
> >> There is a patch towards the end to set "relax_domain_level" at
> >> runtime but given cpusets got away with this when transitioning to
> >> cgroup-v2, I don't know what the sentiments are around its usage.
> >> Any input / feedback is greatly appreciated.
>
> --
> Thanks and Regards,
> Prateek
>

