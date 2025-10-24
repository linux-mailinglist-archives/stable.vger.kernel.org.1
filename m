Return-Path: <stable+bounces-189204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7ECC04DC0
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 09:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF07E4EB7B1
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 07:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB32EFDB2;
	Fri, 24 Oct 2025 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrjiRzsf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA752ECD34
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292395; cv=none; b=A0oCyaz7APe9epTWge3g/a19mDC4SF20W8w9wxVF1mwYMn90TebBEEiaIvVmv/4JhkDYcm6Vkaw+4+Gg0AiIYvqlumbeHLrw4FR7DWAwhmQRtpxEQKGxbGxKveoBAohh7BOezeMO90IwMyODSyJ9jxoRjXKwp5+eAC2gR6oguYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292395; c=relaxed/simple;
	bh=P7zF7cjvJ1Q3rOhajH7/UXplbDPBM4d595YyLLBuR30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRy/K20EVut+dnm2k5TIqLCsR6IEfORwF3Cpi3SwElnAVz6S1k5F8TGI4F35cBOBhpwLRCIYuVULYy5YZfONdY/0NGupHr9Y2QxdR1bhn5p8fY5hVsTs3D1Q7PyuZcIvtNAHeT1u+pFr3ulOKWEnSEzYGU662d7d/5Jz124q2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FrjiRzsf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b6d5e04e0d3so227055666b.2
        for <stable@vger.kernel.org>; Fri, 24 Oct 2025 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761292390; x=1761897190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKllA+8hadRygowXgxLBBClv4XZmSGXBHfWBIhPUwx0=;
        b=FrjiRzsfG59/W0mANB3GU+xjEZbX8vjpWV4Tlih/iCLpMnP/bvdW2TAjE+5cy+5ZjH
         0ykwtVQPP/RcMSGLyUsdXuE1zYSBJAmXDkApWeKHWD8SEhn0MMcnoJz2kvuC5SUak+td
         2cmGL10tz93WeUPorV8IUuFxw4QMhcWCV7uGrJVp8LEXIwEnI/4agsmfCQt0RqPlOsfx
         uP5qq6qL144wrQ9CLTlF0OmRvg6obj6bNDbT7C+Pkysu/n/u9nuURrBENHkUrjJWXD3U
         DQDZNVhtFRGsJ9rfiz4w04XrISECxiKVk6KdDf77vBGoTGtvpiPGLufGumPnlGaxeAHN
         piBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292390; x=1761897190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKllA+8hadRygowXgxLBBClv4XZmSGXBHfWBIhPUwx0=;
        b=QaFLmX0zcdRvJTP+2dduZnLHHnqz6s3Iq+zJ2RC/fw+rSSiQuSMuyJyqjOLVCD14Dg
         D2ao7BFhj6V0ge2XsHfVX5VCVg6IT7Ljca6V1JcKykBJVKi2DY1MSNxKQcQcikg+Cn7c
         CFkvk9wsiEfJpbPtNiNgyByizcSitVLcTH+nd9Bdxx2S0wWvY6mytg6KYGCmd7ysU6dF
         HxvmqjhcqLOpX272yQaH35xe26L2nXTh2R6O4uUZ5iEDR40mRdMdcYmyg247TVEfTMal
         jLkujZO8fA6cDYbt50pALba0Yo5eIokH3aAsiHfThtHORnrm+lpl/Mxw4DN6T2u3jhZA
         k9iA==
X-Forwarded-Encrypted: i=1; AJvYcCWOjp4qz1VxziMBAqBsotX0NtFzUIHb9/3tzP+t+rQc6JBj7n6YRbfZXzPhQf+TaHEqSS2FWtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIAtGCl9SsT49uZpa5lerMtGqu/F3+A90EFp/jRfBKoaRxsVg
	uAreYL+8fcv6PDsVTYj7uAmw+hlyYEJZX3F75Afv92YlF0mRgJEaX8hVXnW4YpmEe5HNlnT0Hsd
	k98axwpy3dS8VtXIq5zW0F90Vv/Jwy6yGKuJwlfbMsQ==
X-Gm-Gg: ASbGnctw1FlOZQiq8K3dC3NG9RajbKonOHLpD6+C1IP7six6MosLh1yVHJoRoVZt+VN
	H1JMsgzZOPTvTW2n50t1l2WQbPb12liBfvKCJ6O0yg7mZLqRagPVYPOCBetFLkWnajF2bzM7fkO
	CpXN+mmtON5bhmG+OSvRsA2jpfwEGoa6XsqN3W7Uqn9TDzNBawb08uZXslNXjPm1g3PEVmL65iE
	01qM4KVkLKYgfxEdaIX1RSALP/Rm0qm/GHxIPfTePzkjdMxJLXx2cw6MOb/VGjDatQhatg3Rdbs
	k6XEXJnLyv91kA==
X-Google-Smtp-Source: AGHT+IGuxqs5bOlII/faQL2M35FIEaaiNCoqe3+W5kb3jw9QMfIKjRTVG9bozgDzcWilzmdpzrfzjwWjHTkTVLgtzvU=
X-Received: by 2002:a17:906:c116:b0:b1d:285c:e0ef with SMTP id
 a640c23a62f3a-b6471f3c342mr3326362566b.26.1761292390445; Fri, 24 Oct 2025
 00:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKfTPtC-L3R6iYA=boxQGKVafC_UhBihYq6n6qTJ6hk4Q76OZg@mail.gmail.com>
 <bf93d41ff9f2da19ef2c1cfb505362e0b48c39de.1761290330.git.peng_wang@linux.alibaba.com>
In-Reply-To: <bf93d41ff9f2da19ef2c1cfb505362e0b48c39de.1761290330.git.peng_wang@linux.alibaba.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 24 Oct 2025 09:52:59 +0200
X-Gm-Features: AWmQ_bnQgxXt5ibBEVX_WfS9VKxw9bwe-kZEoxyzLDtbPvVx8LfO7x9y7EODhJw
Message-ID: <CAKfTPtBMVkCVCSMN2ztpA=kje-BoNFt=bK44_zdkMeAPfNMdqA@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: Clear ->h_load_next when unregistering cgroup
To: Peng Wang <peng_wang@linux.alibaba.com>
Cc: bsegall@google.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, stable@vger.kernel.org, 
	vdavydov.dev@gmail.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Oct 2025 at 09:24, Peng Wang <peng_wang@linux.alibaba.com> wrote=
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

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cee1793e8277..32b466605925 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13418,6 +13418,8 @@ void unregister_fair_sched_group(struct task_grou=
p *tg)
>                 struct rq *rq =3D cpu_rq(cpu);
>
>                 if (se) {
> +                       struct cfs_rq *parent_cfs_rq =3D cfs_rq_of(se);
> +
>                         if (se->sched_delayed) {
>                                 guard(rq_lock_irqsave)(rq);
>                                 if (se->sched_delayed) {
> @@ -13427,6 +13429,13 @@ void unregister_fair_sched_group(struct task_gro=
up *tg)
>                                 list_del_leaf_cfs_rq(cfs_rq);
>                         }
>                         remove_entity_load_avg(se);
> +
> +                       /*
> +                        * Clear parent's h_load_next if it points to the
> +                        * sched_entity being freed to avoid stale pointe=
r.
> +                        */
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

