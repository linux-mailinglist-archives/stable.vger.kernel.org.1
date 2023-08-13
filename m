Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1DA77AB2C
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 22:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjHMUYk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 16:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHMUYk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 16:24:40 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF62910FB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 13:24:41 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-790a8c74383so174259439f.3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691958281; x=1692563081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sc2h2+fDGzvUiqncUIs0a5l/TY1gRvKRdoPkDeQW88c=;
        b=aihRdEd9ZD+OCq2SEGIYrDIaVHCR5mSY6o/ELOyHwqokOigZszTVXj7Ne8Abb5eero
         KnHCkmSxsEbU+UHstcXgnDKQiTJ3xzvZmG4tFo5rii3w6cxcXnBKOkhZMAfj/b+5UIJm
         eupudujOZbqXQdvg/FOBJDnlezLSgLBQOqcQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691958281; x=1692563081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sc2h2+fDGzvUiqncUIs0a5l/TY1gRvKRdoPkDeQW88c=;
        b=DsvFC4Ph5D+XjzLk4cVwmrPHJ/Obm73REPx2sBtSREW2EV0NTDbiQ/TZG6VRuPB83C
         Zu8RJ3DYh1ZQng2K+7RNRSNrUo6IJGtzDhL5yhmaZMEk0fSs87pioHwkL797VNdFgsuI
         bgkPoqPy6Ov/S1qy7hvEC1ld6d2NFiiTc2WnEjW+Nr0XJZ04gQWH0u3nb/sHA7oRE+S0
         ceRfqmQ3PIultC9qyMYEJhfnFBeaN3Mss736AWRnDuIVCzZu7lnyKTh72S4GG8onJQR5
         MgBm9RZjzd0Du+wTNfHlAD7ZhZHMQjKITGNNynvxOTM1LOkk5qQzZxgZ1CfV/d4dhMWA
         a6PQ==
X-Gm-Message-State: AOJu0Yx0MoIZNtONWdXIkgvsULUBgR6XM1dtP9RAmNOLvUb2nvNCRrjs
        w7/383VsCgo0esn9K20AhGaQw8m2b2z49AY26/k=
X-Google-Smtp-Source: AGHT+IEjZ7J0B1IKroti/YGKwmMrPMIr9TGEDNTvHfdyctCQK5RDE3hpBzHesJDjckzocp3G+IWeDQ==
X-Received: by 2002:a6b:dc19:0:b0:785:5917:a35f with SMTP id s25-20020a6bdc19000000b007855917a35fmr11003842ioc.8.1691958281109;
        Sun, 13 Aug 2023 13:24:41 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id d24-20020a056602229800b0077a1d1029fcsm2792419iod.28.2023.08.13.13.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 13:24:40 -0700 (PDT)
Date:   Sun, 13 Aug 2023 20:24:39 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 5.10 1/3] torture: Fix hang during kthread shutdown phase
Message-ID: <20230813202439.GA675119@google.com>
References: <20230813031536.2166337-1-joel@joelfernandes.org>
 <2023081349-widely-trousers-4ef1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081349-widely-trousers-4ef1@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 13, 2023 at 06:34:27PM +0200, Greg KH wrote:
> On Sun, Aug 13, 2023 at 03:15:34AM +0000, Joel Fernandes (Google) wrote:
> > From: Joel Fernandes <joel@joelfernandes.org>
> > 
> > During shutdown of rcutorture, the shutdown thread in
> > rcu_torture_cleanup() calls torture_cleanup_begin() which sets fullstop
> > to FULLSTOP_RMMOD. This is enough to cause the rcutorture threads for
> > readers and fakewriters to breakout of their main while loop and start
> > shutting down.
> > 
> > Once out of their main loop, they then call torture_kthread_stopping()
> > which in turn waits for kthread_stop() to be called, however
> > rcu_torture_cleanup() has not even called kthread_stop() on those
> > threads yet, it does that a bit later.  However, before it gets a chance
> > to do so, torture_kthread_stopping() calls
> > schedule_timeout_interruptible(1) in a tight loop. Tracing confirmed
> > this makes the timer softirq constantly execute timer callbacks, while
> > never returning back to the softirq exit path and is essentially "locked
> > up" because of that. If the softirq preempts the shutdown thread,
> > kthread_stop() may never be called.
> > 
> > This commit improves the situation dramatically, by increasing timeout
> > passed to schedule_timeout_interruptible() 1/20th of a second. This
> > causes the timer softirq to not lock up a CPU and everything works fine.
> > Testing has shown 100 runs of TREE07 passing reliably, which was not the
> > case before because of RCU stalls.
> > 
> > Cc: Paul McKenney <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > Cc: <stable@vger.kernel.org> # 6.0.x
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> > Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> >  kernel/torture.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Any hint as to what the git commit id in Linus's tree for this, and the
> other patches you just sent, are?  I kind of need that to keep track of
> things...

Apologies, I added the SHA to the 5.15 ones but not 5.10. Here they are for 5.10:

1/3
d52d3a2bf408ff86f3a79560b5cce80efb340239
("torture: Fix hang during kthread shutdown phase")

2/3
a1ff03cd6fb9c501fff63a4a2bface9adcfa81cd
("tick: Detect and fix jiffies update stall")

3/3
62c1256d544747b38e77ca9b5bfe3a26f9592576
("timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped")

In case you wish to pull them in via git, I have uploaded them to:
Git: https://github.com/joelagnel/linux-kernel.git
Branch: rcu/linux-5.10.y.aug13.greg


thanks,

 - Joel

