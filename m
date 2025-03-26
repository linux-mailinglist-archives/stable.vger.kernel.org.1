Return-Path: <stable+bounces-126761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE4A71C14
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D37162BDA
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6931F426F;
	Wed, 26 Mar 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dum3kG8j"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE0F1F4629
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007407; cv=none; b=DLRjuDwxBEiOhE7jZMus+mZocBe+D2Y7cZJc3UBN56HFLU7qn6wR+T308TIJp7FzH3e6uyVS5x3syi+BQgUBeOzflRJZhdRbNQ/YwC17BAcsG+4++GkPTThrCg0RvP6Ifzmw11s40eI+fKdj+/AOPNA/JP7gTQEJ5R7epgKL/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007407; c=relaxed/simple;
	bh=N7yedQXHCWJJSpkeX4sf2KRcR+qb7GITXxEytvJOQBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJRWiW/9QfUEBmRAW8r2pNyw1BNslHkYDMKvIDv3BazThzVXiTdDE4ERaIMYnMnqNjavQsFeNBk12V0kSH+DhIiqBrnehYZ93wJ+Ty+2on3BX6s7u4tjHsBQNvaO412dlA++utJYnQjYUxb3L5X7UnUVBkykN0I4fG3y/Cs3epM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dum3kG8j; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so12759185a12.2
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743007404; x=1743612204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r3mHtuFS2L+ZA8HTWSpIHVhFAJlupWD9X5kq+E3WTzE=;
        b=Dum3kG8jhtxcr9TUNpztETbhvthz2oMR3+H11IotVlcmCondR9XHQ9QF0Bw50nyOA9
         UuAJwLIwC2orM8Htx3ea5+Xvphfycgok9ZsSQhABwpeEgmaps2H0IdM7pKFUya7Vq/ha
         NvZbfNGBF+g5fM2obUUwlctB6CRXszr3hIEnkSF4/i7OSsFhXr2kTq86l+LYEKF1x/1h
         9+g02MiU4WOL4WyfOg5zajS/mqYkyKoxbq8W9CzVz3YhvVC6APyzxJVq8WwaoqkABvz2
         OUJ9QyRvVt7qFm60f88vzfJkP6YPB/cMSwArWpdudJMbw60VbASQkd3URI35Gj8w6yjl
         zrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007404; x=1743612204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3mHtuFS2L+ZA8HTWSpIHVhFAJlupWD9X5kq+E3WTzE=;
        b=wNM84DKy0na9NOSUMg34O90S17+l6J1W2ucp6m0Jpd3Bf5K+Ywos86Lzz0j7DnAP6u
         kC6fjkqswU10XKLtw1SxdfdnDh3Vjg9F8S2cjR0XLkalzqE2iTIoGMc+H3KTTqKQRPh4
         UmbhYgDistqGznuPIaHb1s9pp9LHET2Fkn4fzVV7cWLUEbO23LwK1KeT+K9NVNgOl5ug
         3+/J9+xx0VMYog+ePvSG5lOMpPJ2vEpNNLae6fzuuSDhgLGW7IQCjXzkHxQDyrhE5gDl
         sGJFJkFAJAgExby2SSo6uBpwcXgU1tSHXbvr7DeWNaNvE3xyYbnJYn1hqImofFPabA5R
         pfSw==
X-Forwarded-Encrypted: i=1; AJvYcCXs31E4KQLgqeQwNIdN+iNA9Gh1cfqfqiOIwJLm0G0SLcqPwLXXrBobT7Z+aPRTgnDR8LpSM54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfOHt2FlioaL6xuj7iW6PS8JpjWKXfxG6YCXXXYSUximX2pzU
	65oVyIWDcZi67xB29Af0O3gGbZnwe0WJAAw+gbciT4VHs511T4945wO6dgwFi9o1XB7ERCO+ugc
	WD6544FTfId1CLOVvGfk9OJ15qbNBkEyPxxMJAu0BTlf1p2j4
X-Gm-Gg: ASbGncsVcHnRRZmmmpkNiL+Elqi24vpfNc2kO5qUTu15aw7cmmjRjYvf9JVQ2H/5S7C
	U/wbKL+N7MR15pnUKYl5iiyYoNxTzHJ5I+ZtO1miMAv1swGHL/1bBsq4EWfps7nwCqdahSV66Vc
	JOJ+W5tObOLcc4Lq1R0yr9FJ6sZSVUOzX9M5Oi9I08fyiEz2d6K3+y3eGR+UR3X5JQ3A==
X-Google-Smtp-Source: AGHT+IGR8/THrp/6t8yZR3dpczgrHk4+FJ3mEQbOGCvq3ovK+tbifhcOivKucw9gQAaF0D/SVCyg7EWsKFkz6ZdP8+k=
X-Received: by 2002:a17:906:f59d:b0:ac3:2d47:f6af with SMTP id
 a640c23a62f3a-ac6faeb1b91mr9064666b.20.1743007403647; Wed, 26 Mar 2025
 09:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001134603.2758480-1-pierre.gondois@arm.com> <d629b646-d04b-4a26-86a2-34300dcd3e9f@arm.com>
In-Reply-To: <d629b646-d04b-4a26-86a2-34300dcd3e9f@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 26 Mar 2025 17:43:11 +0100
X-Gm-Features: AQ5f1Jrc3oRl6pP2bBCnGcuEEoHOIPC0KovEMFTFxqJ90QBF2lmmLhrOsrN00Rk
Message-ID: <CAKfTPtAPEma3DnKLY80zF2tSFxyT1MPPF+6w5vRkEVX4r5k0xA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix integer underflow
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Pierre,

On Tue, 25 Mar 2025 at 16:10, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Vincent,
>
> This patch should still be relevant, would it be possible to pick it ?
> Or maybe something is missing ?

Nothing is missing, the patch just got lost somewhere.

Ingo, Peter,
Could we take it once rc1 is published ?

Regards,
Vincent

>
> Regards,
> Pierre
>
> On 10/1/24 15:46, Pierre Gondois wrote:
> > (struct sg_lb_stats).idle_cpus is of type 'unsigned int'.
> > (local->idle_cpus - busiest->idle_cpus) can underflow to UINT_MAX
> > for instance, and max_t(long, 0, UINT_MAX) will output UINT_MAX.
> >
> > Use lsub_positive() instead of max_t().
> >
> > Fixes: 16b0a7a1a0af ("sched/fair: Ensure tasks spreading in LLC during LB")
> > cc: stable@vger.kernel.org
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/fair.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9057584ec06d..6d9124499f52 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10775,8 +10775,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >                        * idle CPUs.
> >                        */
> >                       env->migration_type = migrate_task;
> > -                     env->imbalance = max_t(long, 0,
> > -                                            (local->idle_cpus - busiest->idle_cpus));
> > +                     env->imbalance = local->idle_cpus;
> > +                     lsub_positive(&env->imbalance, busiest->idle_cpus);
> >               }
> >
> >   #ifdef CONFIG_NUMA

