Return-Path: <stable+bounces-76092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A0697858A
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 18:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F9B1C225D0
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAE36F2F6;
	Fri, 13 Sep 2024 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jc1DQIL5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A26BFA3
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244079; cv=none; b=bveTWBmgz1AUnbYxNwEO+g2+aKWVrf9PEp40LJCf00g6gOj1IPD770rUY+IMZ0qTX7BYJLtgy8lmTTcSjEqQ5aCx/By5voTMiBHwaoiSItjsKWrNxVb64KedF4DqF15DtJR8wp5a+MtQoTdCp6HbmDe2YLEq0KlfXBbXD/Ignzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244079; c=relaxed/simple;
	bh=58i9GhiFFTmfKWxU3edBq68pTLPjGtrRGCYmR0XEWYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma7v33EshW307BYWch91PsISHj9HPheoiwP/HzCFrmC+3Zjchag/KVQ7PhUMSIa5Sz9W/qhRCHmwXld/UXIRHAgIJ20TAzvLFMvmm6eZ9Nv7t+s+tIdm+h8k7X/8889mMkh6GZZ2hAgKIH+pJ5e9fD1AtlK2PIqWoCuZ3E829Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jc1DQIL5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d877e9054eso1729145a91.3
        for <stable@vger.kernel.org>; Fri, 13 Sep 2024 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726244077; x=1726848877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k3sfmhPCsJ8N0kfGHvGp1JD0fhbJFa0kOkkkY4RvNYg=;
        b=jc1DQIL5RHmoR80Tmtf5VlWXQwD+OVZ0UdgXgMnzjTv+8QdtXvNctxz+YHq3IG9E0Q
         lrQ8Jf/5Zs15KfnW1AtOLSUOnzE7+1wExYNKax1X6sQ6N8pvkImxvJqdmgn3Jihnie1Z
         XTeJjXCurSMaIiIDq1jJP+a2Y6Vqb+PyF0H4CIVQ7nSQsl6RsiExSn0oDaboHd3JegE5
         FP5Mb0ZRjiNqq5DWnTuVolLziJ1s0EneIMUE7XVyvMAJsxEI3Beqttkuetq0gBNyprQl
         DfKRKc0m1O28KQp3pHBzfQLVATtp7hzjSFkVt3Yu7OawuCGMk5u/Vu9asb7Gtwp/PbOs
         db3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726244077; x=1726848877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3sfmhPCsJ8N0kfGHvGp1JD0fhbJFa0kOkkkY4RvNYg=;
        b=UrSv9WWi5n84BdXgNWBZr2+gO38vcKugcclTgQis9I0RoeaogzNzAxH5nLAqLH36e5
         nPL3ow2HaISsQemD/WUyTEi9Z5xlwmgyCQgOYEgX9/PkLDxJLHyyAItH3A2OCC0Hlhw4
         b5sx6PYkDoqumKIUjootVQuVQAz6K8cWZP1zcZIicFSuVZgnB4RdzdxwKClwaz6qdYUK
         QuuNCbPb94TeH2PXXvYfW7x+iBtDhc1d+Jvm98Pu5qWUUCc7JlwqCU6XFv434zz5rcnK
         mwbYsWUH1JLGIRePZa3GzJolHoJkcG7tUK1XbsNWAgmASGJ1w5yTJULvDfxUfTYPtHj1
         Jukw==
X-Forwarded-Encrypted: i=1; AJvYcCUbtTgU6gArOI+vBMJeKGOUABKrGMe08/wc856DLRG2pLBpYyCATXgQc2kXrvNLeJ1rmHuRSoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+twOFF9MNwyCnO7nsj1Ovy/vFOHJm3e5gW7miQY/0ZK5fg2Bu
	X7TaCLaMI0kXLg8caPVn46iU2oVemE8jVyueU+FggTy7lLUutpvJbbIOOzu7edBiRNTxdfko6Db
	lMNxvZp1RR//BmVwtXv7xOMMvEXhja2z1a+/SiA==
X-Google-Smtp-Source: AGHT+IE1JePHlH3d/E87lzzKaJZwUvbA+kPupkgy6Tswjrp87EvmuEgorBN7aRkFJMMq4kK0pCYLnLU6PhV97Yv5DHY=
X-Received: by 2002:a17:90a:c10:b0:2d8:f7e2:eff with SMTP id
 98e67ed59e1d1-2dba006821cmr7133948a91.36.1726244077324; Fri, 13 Sep 2024
 09:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913085824.404709-1-pierre.gondois@arm.com>
In-Reply-To: <20240913085824.404709-1-pierre.gondois@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 13 Sep 2024 18:14:26 +0200
Message-ID: <CAKfTPtB2=_O=dJbTH=e_Hg80_rcSvBgwUP+ZMehfyG4sG5W6iQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix integer underflow
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Pierre

On Fri, 13 Sept 2024 at 10:58, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> (struct sg_lb_stats).idle_cpus is of type 'unsigned int'.
> (local->idle_cpus - busiest->idle_cpus) can underflow to UINT_MAX
> for instance, and max_t(long, 0, UINT_MAX) will output UINT_MAX.
>
> Use lsub_positive() instead of max_t().

Have you faced the problem or this patch is based on code review ?

we have the below in sched_balance_find_src_group() that should ensure
that we have local->idle_cpus > busiest->idle_cpus

if (busiest->group_weight > 1 &&
    local->idle_cpus <= (busiest->idle_cpus + 1)) {
    /*
    * If the busiest group is not overloaded
    * and there is no imbalance between this and busiest
    * group wrt idle CPUs, it is balanced. The imbalance
    * becomes significant if the diff is greater than 1
    * otherwise we might end up to just move the imbalance
    * on another group. Of course this applies only if
    * there is more than 1 CPU per group.
    */
    goto out_balanced;
}

>
> Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
> cc: stable@vger.kernel.org
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..6d9124499f52 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10775,8 +10775,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>                          * idle CPUs.
>                          */
>                         env->migration_type = migrate_task;
> -                       env->imbalance = max_t(long, 0,
> -                                              (local->idle_cpus - busiest->idle_cpus));
> +                       env->imbalance = local->idle_cpus;
> +                       lsub_positive(&env->imbalance, busiest->idle_cpus);
>                 }
>
>  #ifdef CONFIG_NUMA
> --
> 2.25.1
>

