Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B92F78A285
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 00:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjH0WMB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 18:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjH0WL4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 18:11:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01C4127
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 15:11:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bd0a5a5abbso9440261fa.0
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693174312; x=1693779112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d6xSF+2pEGkhL7JF/wHkItwmOxk3wpHtrYQMpWiRw4=;
        b=unsfsMwHDjZcgxt9qP6DgIpwUDH62wIV4mLw6HAS1vYEt45nxq8joJMosCpd2M+qhs
         /5f9iUmJ0PQh0U9iLiokhRQEJyegWuDSxOWfuUIBzJAyG/gbTyoEyR8/rSzRayujfogh
         ib8cU8MWa7101kMl7SZ/id5eiY377YqtuMD8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693174312; x=1693779112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9d6xSF+2pEGkhL7JF/wHkItwmOxk3wpHtrYQMpWiRw4=;
        b=GU0AFesUVxrx+wC5aFAsRuip2mfZ3+A7A2jF2S6zkAu4ZDF8GwEqLG7/Iv/BEO5/xE
         AH8cwZxEJ3grXf3L6axPONdrSYkY1QHl3WKYQnnd6sGFAanQ92vPxQ8m1PAchn5TsokJ
         x+BMoaOKPalUIVYzxiNPqYWlV7H30p0Mg0lXICMYVd4qM8Sp75mZquUdRNSw1BpINfBP
         Z0oxR0iz2PUV7Tq6P/Og49ZifXGVbprNpwZTGlaTxtuw5lQQzurmxvkJ1p+bdtoEi3Co
         kcknDcNhvNMmxn500MetIUeEkOTIkV9Gd18yxXETm+pjZbDvh/mBs7o98rTI3v05PkuS
         vFmA==
X-Gm-Message-State: AOJu0YzaECjDHrpna6qMURwD+g/Hk21jKrhuhzyaXVs785PwrsaoUT7m
        UlGJTfELqulWatWu2nV353UrmCNXSeviz1RoxNiyXg==
X-Google-Smtp-Source: AGHT+IEwShjYrT8PqPKg1WSz4PsF42AvQFKdj2JbXv18RW7BNfI5UO6wl23SEut50k5JlqHoiut37/kRlH5S1cZq46U=
X-Received: by 2002:a2e:2e0e:0:b0:2b7:2066:10e1 with SMTP id
 u14-20020a2e2e0e000000b002b7206610e1mr18068437lju.0.1693174312006; Sun, 27
 Aug 2023 15:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx> <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
 <CAAhV-H5Z3s=2_OyA_AJ1-NqXBtNrcs-EmsqYcrjc+qXmJ=SitQ@mail.gmail.com>
 <16827b4e-9823-456d-a6be-157fbfae64c3@paulmck-laptop> <CAAhV-H7uXA=r-w1nN7sBpRTba3LjjZs+wasJfGo7VZ6D9eMBAw@mail.gmail.com>
 <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop> <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
 <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop> <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
 <20230825232807.GA97898@google.com> <CAEXW_YSock304V471X_A7WrxCWtHJGx3APmSy0k7Lc0o69D9Hg@mail.gmail.com>
 <CAAhV-H6PM_KZj4_h-SdJAaseMDK2nMqqJWL8fWHhL4vUA50bQg@mail.gmail.com>
In-Reply-To: <CAAhV-H6PM_KZj4_h-SdJAaseMDK2nMqqJWL8fWHhL4vUA50bQg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 27 Aug 2023 18:11:40 -0400
Message-ID: <CAEXW_YS5dVVOQvO6tWwF7mrgtHiYgVKP_TAipzBNiaFqWDzdeQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     paulmck@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 27, 2023 at 1:51=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
[..]
> > > > > The only way I know of to avoid these sorts of false positives is=
 for
> > > > > the user to manually suppress all timeouts (perhaps using a kerne=
l-boot
> > > > > parameter for your early-boot case), do the gdb work, and then un=
suppress
> > > > > all stalls.  Even that won't work for networking, because the oth=
er
> > > > > system's clock will be running throughout.
> > > > >
> > > > > In other words, from what I know now, there is no perfect solutio=
n.
> > > > > Therefore, there are sharp limits to the complexity of any soluti=
on that
> > > > > I will be willing to accept.
> > > > I think the simplest solution is (I hope Joel will not angry):
> > >
> > > Not angry at all, just want to help. ;-). The problem is the 300*HZ s=
olution
> > > will also effect the VM workloads which also do a similar reset.  All=
ow me few
> > > days to see if I can take a shot at fixing it slightly differently. I=
 am
> > > trying Paul's idea of setting jiffies at a later time. I think it is =
doable.
> > > I think the advantage of doing this is it will make stall detection m=
ore
> > > robust in this face of these gaps in jiffie update. And that solution=
 does
> > > not even need us to rely on ktime (and all the issues that come with =
that).
> > >
> >
> > I wrote a patch similar to Paul's idea and sent it out for review, the
> > advantage being it purely is based on jiffies. Could you try it out
> > and let me know?
> If you can cc my gmail <chenhuacai@gmail.com>, that could be better.

Sure, will do.

>
> I have read your patch, maybe the counter (nr_fqs_jiffies_stall)
> should be atomic_t and we should use atomic operation to decrement its
> value. Because rcu_gp_fqs() can be run concurrently, and we may miss
> the (nr_fqs =3D=3D 1) condition.

I don't think so. There is only 1 place where RMW operation happens
and rcu_gp_fqs() is called only from the GP kthread. So a concurrent
RMW (and hence a lost update) is not possible.

Could you test the patch for the issue you are seeing and provide your
Tested-by tag? Thanks,

 - Joel
