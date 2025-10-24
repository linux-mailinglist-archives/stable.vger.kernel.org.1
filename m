Return-Path: <stable+bounces-189198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9E4C04A17
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 09:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E21E3BBACE
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 07:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9102BE64D;
	Fri, 24 Oct 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TgyihKLN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710452BE034
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289723; cv=none; b=p8D3nyKyeYvLD1wh5dqg5YyylQeepfJ/o4hmVpQKrUYPg/EHiKlPHvBrBrmEzRXhFTSaXftvbE07r4bbONi++YDwaKL7C+2+WUzhPqnwBNZmb4xeOnofGguqeTwkfn9RyZNOAFVjkJ+IQNRmxQZEjU7Yv80fiDrVUosGMmG3WS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289723; c=relaxed/simple;
	bh=DMYZNMyiP51qhvR163WPghAWwrfu3AH48qP2CF7lSBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0N+4jZXdzsL186G4j54oT8zGsr9jYDAn+MccUhL+MATV6C0+6K8nby0BZLpsVL3HTZ816NHLyx4K3CFrgmdIPsFxg4+79lwNq2v4FP3/DIY9Hmn1fPLJmyiGFPj4dCpVFyI4mEV3n1UtoG8Y3rZ7+RBvhRVMHFEA3ZEKr1uNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TgyihKLN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63e11cfb4a9so2994846a12.2
        for <stable@vger.kernel.org>; Fri, 24 Oct 2025 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761289719; x=1761894519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3j0863NMsH2TxDcTuhZnVL4n97Hbnm5ACId2JottOg=;
        b=TgyihKLNBy1y2Vpec/dfONbA9mJKq6bScZJuOKnKyl4kizbp2qPWxBOheSHr1M/fhm
         Lyjq46AHEcbh5xqbuPYXj258FLCZ1g3hU5xOUJhbYtV8JyGMntMEOQT4gIOhFbhL4Jzw
         BbgTuI1n6cteh2ByrWMqbY5oqcnfshxtYX8oi2b5zjYeLokLlavalWji1iDx0wOYMKxZ
         kTFUQ596WA8SLqb6r8iTcVA2MugXAn1SQpDCMv0/JPfN9aGG0aOB72gQSP/ivAHCj8Mv
         +gfNNvj7TNRZ9szYX1m1a45c9Pg6PmK5lxmvO+WGhVk9+4Jv9y3iehzZogg40xHEV+oA
         5YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761289719; x=1761894519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3j0863NMsH2TxDcTuhZnVL4n97Hbnm5ACId2JottOg=;
        b=uC/UP/WqeNufaiYC5iMhrL2mS1PSl5Gz8iGRljQPGZPSKteuVYoY6d76hQ0y+7G2Or
         fJKE24H9Lw3O55CEids09gnZs3YJvLe0MIsPtccQa0SbeTpElxjFD9yueCnTeFUIsAhA
         wRiHA6pV0iy8N0nwggBbUcabxz40nuqasMhaw8UPsJotERGW6lklFLzVZdetCad9Urzr
         aBspFqVjf5Jf+alDu/Qv2uxeuUQleFQmtpNL2qGoLKVNweVJyedlUGZ8pUmtmxjqIv//
         ojWfDHHjnXJwrD+4/RoMLusQzH+LFM5DoEwSO9KPn4pvBhuTJZu3jJzKpsPfHhS4hJZ1
         LChw==
X-Forwarded-Encrypted: i=1; AJvYcCUmxZKS3YXfnhlQekUVLqJ2x2OU7tk4X2Cp4s0p9P5RG8sDioqQuE+WosmGe7TRB9TVPrnHyfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+EXJSiI4isOKEgNb8+IMfe5RwjKHavj9hWKLrK8Li/b2P5Ug
	q+sUfYNIAevzXWM9wJd7mOdAemKDUx3t67tLf8xbsw8E/1F5SPqEIpr7GjNdrrmpS8isinpubU/
	J6u0m51OCX4dluLQ5rfbcAeoE+R27R4uwf5T+G1Py2A==
X-Gm-Gg: ASbGncv1MsFYWvJO0cg+fbg6YXyQcpd2ugph5Do45CIhgeSVSNmxdtmwN82bBfIG74r
	Xla7F2giT4QVoNNg7QR9iVEeObR9CJ8d5g+jLWV1eCeGpq8ApZfJFMNQD2yCaUkRdLh1wvvK6Os
	133LXJq98P2NTad+v9RK2TLuOFAKeF0yMc73z3joo/lmSlcQMRpSwT2jdxuuJens+JY33WyFi9q
	f64PAleDY92PofKzr2bmcc5ghFMsaL23fFE4VCsiQscN/0hf+xx7q7fnp8GcYMOb5U700afLDCU
	nOlRn68dV+BJpQ==
X-Google-Smtp-Source: AGHT+IFLe3+jRoOLX67oMONNU8hUa4/ecYf2eWSv9JTCusb49DNV8U7PDzZtofnfsGkk5jm/DBvVd/x5ZvDf51+Y6dY=
X-Received: by 2002:a05:6402:26cd:b0:63b:f1aa:11d1 with SMTP id
 4fb4d7f45d1cf-63e60086099mr1273048a12.1.1761289718654; Fri, 24 Oct 2025
 00:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKfTPtDJW4yU2=_4stdS1bggHwAA8K2On_ruV63=_H9=YEgdkw@mail.gmail.com>
 <f3d77b74d72da0c627ff4b4fe9d430969da6b900.1761200831.git.peng_wang@linux.alibaba.com>
In-Reply-To: <f3d77b74d72da0c627ff4b4fe9d430969da6b900.1761200831.git.peng_wang@linux.alibaba.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 24 Oct 2025 09:08:26 +0200
X-Gm-Features: AWmQ_bnoLl6ZwZowLqq0oAjbairDlXIzhwAx0wIrKHjZTCUL6ePTWqrJ0tk9n6U
Message-ID: <CAKfTPtC-L3R6iYA=boxQGKVafC_UhBihYq6n6qTJ6hk4Q76OZg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Clear ->h_load_next when unregistering cgroup
To: Peng Wang <peng_wang@linux.alibaba.com>
Cc: bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, vdavydov.dev@gmail.com, 
	vschneid@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Oct 2025 at 08:29, Peng Wang <peng_wang@linux.alibaba.com> wrote=
:
>
> An invalid pointer dereference bug was reported on arm64 cpu, and has
> not yet been seen on x86. A partial oops looks like:
>
>  Call trace:
>   update_cfs_rq_h_load+0x80/0xb0
>   wake_affine+0x158/0x168
>   select_task_rq_fair+0x364/0x3a8
>   try_to_wake_up+0x154/0x648
>   wake_up_q+0x68/0xd0
>   futex_wake_op+0x280/0x4c8
>   do_futex+0x198/0x1c0
>   __arm64_sys_futex+0x11c/0x198
>
> Link: https://lore.kernel.org/all/20251013071820.1531295-1-CruzZhao@linux=
.alibaba.com/
>
> We found that the task_group corresponding to the problematic se
> is not in the parent task_group=E2=80=99s children list, indicating that
> h_load_next points to an invalid address. Consider the following
> cgroup and task hierarchy:
>
>          A
>         / \
>        /   \
>       B     E
>      / \    |
>     /   \   t2
>    C     D
>    |     |
>    t0    t1
>
> Here follows a timing sequence that may be responsible for triggering
> the problem:
>
> CPU X                   CPU Y                   CPU Z
> wakeup t0
> set list A->B->C
> traverse A->B->C
> t0 exits
> destroy C
>                         wakeup t2
>                         set list A->E           wakeup t1
>                                                 set list A->B->D
>                         traverse A->B->C
>                         panic
>
> CPU Z sets ->h_load_next list to A->B->D, but due to arm64 weaker memory
> ordering, Y may observe A->B before it sees B->D, then in this time windo=
w,
> it can traverse A->B->C and reach an invalid se.
>
> We can avoid stale pointer accesses by clearing ->h_load_next when
> unregistering cgroup.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Fixes: 685207963be9 ("sched: Move h_load calculation to task_h_load()")
> Cc: <stable@vger.kernel.org>
> Co-developed-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> Signed-off-by: Peng Wang <peng_wang@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cee1793e8277..a5fce15093d3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13427,6 +13427,14 @@ void unregister_fair_sched_group(struct task_gro=
up *tg)
>                                 list_del_leaf_cfs_rq(cfs_rq);
>                         }
>                         remove_entity_load_avg(se);
> +                       /*
> +                        * Clear parent's h_load_next if it points to the
> +                        * sched_entity being freed to avoid stale pointe=
r.
> +                        */
> +                       struct cfs_rq *parent_cfs_rq =3D cfs_rq_of(se);

Move the declaration at the beg of the if (se) {

> +
> +                       if (READ_ONCE(parent_cfs_rq->h_load_next) =3D=3D =
se)
> +                               WRITE_ONCE(parent_cfs_rq->h_load_next, NU=
LL);
>                 }
>
>                 /*
> --
> 2.27.0
>

