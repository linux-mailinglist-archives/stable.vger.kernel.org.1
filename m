Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A86D76D4E8
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 19:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjHBRPh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 13:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjHBRPe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 13:15:34 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A92D72
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 10:15:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe463420fbso86369e87.3
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690996511; x=1691601311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=us0CaLITIVnj4VszPxxEKlt0TWFj+St3gLNGsd+vgGs=;
        b=bvgYFIw4iR13VgxlLvGnO+zVTwCTy3GenoEMwwcYXvMaobQSOp1VPwYAn+0BTIYJ3y
         eMt4cvhYxI5Em1VuBtphyB+z1Icj0at166qPurcdrCV7NlYr+6c4wM5wSHqFneLFHpB2
         EjpQYA32A8TIMBpSsFTQbPTsNRQK5DrSb1o88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690996511; x=1691601311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=us0CaLITIVnj4VszPxxEKlt0TWFj+St3gLNGsd+vgGs=;
        b=PuVlJm53F+F8EnsgbnAqsf4Wcs1HOpb4zjupB8eO2eLLMwCQRxFlox8OD7SSk7TgLH
         53fq7PiGnWS3WILVRjq9gBDIRExxGL7uVIeFcy5Cq+JmToimcYfc7OrIHE3dcYAbJhrW
         x+JaoHFMGqKymRYet5fiNLVnmGieSqqlZvIgoxf3DhkwxR5mWsOAYHcCxqibeqaS2LU2
         Y9CqWsJQlmWUsEg0E0FaIORrkSzwwJquDPn5WXByyBZJ2+1/ffPDmu7jbga6Puj+hFCk
         wyMrgfKLuC5U5Zu1Ja0HP8as6wmucsuFV9LFSOO80SuuwUD5L2gul43xxjQzY+4PghOd
         0mxA==
X-Gm-Message-State: ABy/qLZ88snK79Kc4Hr7mkQO3zz0FULS4AkK8pa0B9ybeHj0AsYsUAft
        WvSxEUSe9Eq5Lpc/J1+fLFps+V7DAaA+w+c4PDeFaprh
X-Google-Smtp-Source: APBJJlEV6Q6XlOOUwuUMZLpB957RT5+1giaOpHhck2jkOmJpf7u+KwzfW7aNtmvXPAvseQ3qTez98g==
X-Received: by 2002:ac2:5332:0:b0:4fb:c885:425 with SMTP id f18-20020ac25332000000b004fbc8850425mr4900237lfh.9.1690996511241;
        Wed, 02 Aug 2023 10:15:11 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512020c00b004fb745fd21esm3035178lfo.122.2023.08.02.10.15.10
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 10:15:10 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe0c566788so121794e87.0
        for <stable@vger.kernel.org>; Wed, 02 Aug 2023 10:15:10 -0700 (PDT)
X-Received: by 2002:a19:6d17:0:b0:4fb:89e2:fc27 with SMTP id
 i23-20020a196d17000000b004fb89e2fc27mr4136280lfc.54.1690996508881; Wed, 02
 Aug 2023 10:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net>
 <20230731141934.GK29590@hirez.programming.kicks-ass.net> <20230731143954.GB37820@hirez.programming.kicks-ass.net>
 <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net> <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de> <20230731161452.GA40850@hirez.programming.kicks-ass.net>
 <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net> <20230731211517.GA51835@hirez.programming.kicks-ass.net>
 <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net> <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
In-Reply-To: <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Aug 2023 10:14:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5iESP-=gJSHe0Mfi=Xh2HdSsy+nm8NSr7DbXB9aBDGQ@mail.gmail.com>
Message-ID: <CAHk-=wj5iESP-=gJSHe0Mfi=Xh2HdSsy+nm8NSr7DbXB9aBDGQ@mail.gmail.com>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
To:     paulmck@kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Roy Hopkins <rhopkins@suse.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Two quick comments, both of them "this code is a bit odd" rather than
anything else.

On Tue, 1 Aug 2023 at 12:11, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h

Why is this file called "tasks.h"?

It's not a header file. It makes no sense. It's full of C code. It's
included in only one place. It's just _weird_.

However, more relevantly:

> +               mutex_unlock(&rtp->tasks_gp_mutex);
>                 set_tasks_gp_state(rtp, RTGS_WAIT_CBS);

Isn't the tasks_gp_mutex the thing that protects the gp state here?
Shouldn't it be after setting?

>                 rcuwait_wait_event(&rtp->cbs_wait,
>                                    (needgpcb = rcu_tasks_need_gpcb(rtp)),
>                                    TASK_IDLE);

Also, looking at rcu_tasks_need_gpcb() that is now called outside the
lock, it does something quite odd.

At the very top of the function does

        for (cpu = 0; cpu < smp_load_acquire(&rtp->percpu_dequeue_lim); cpu++) {

and 'smp_load_acquire()' is all about saying "everything *after* this
load is ordered,

But the way it is done in that loop, it is indeed done at the
beginning of the loop, but then it's done *after* the loop too, so the
last smp_load_acquire seems a bit nonsensical.

If you want to load a value and say "this value is now sensible for
everything that follows", I think you should load it *first*. No?

IOW, wouldn't the whole sequence make more sense as

        dequeue_limit = smp_load_acquire(&rtp->percpu_dequeue_lim);
        for (cpu = 0; cpu < dequeue_limit; cpu++) {

and say that everything in rcu_tasks_need_gpcb() is ordered wrt the
initial limit on entry?

I dunno. That use of "smp_load_acquire()" just seems odd. Memory
ordering is hard to understand to begin with, but then when you have
things like loops that do the same ordered load multiple times, it
goes from "hard to understand" to positively confusing.

         Linus
