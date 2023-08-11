Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174047785FF
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 05:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHKD32 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 23:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHKD31 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 23:29:27 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1BA2709
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 20:29:26 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so23790161fa.1
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 20:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691724563; x=1692329363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWhIqS9dUpfKrjrBJQYOrda9jzEuICCRO0pL3DDcTKo=;
        b=C8KPV7IwpIMphwNzL30sVdMbi6MCPXp9/6Gs9b+seqy1LcJKGkmy+5VstAw8uD82RV
         SXRBv1bLfW0RgVflJnmYUXptEfZZRFd5PgT2AAtHjaONDkPlHm9jo0IhbyRR8yVEkOGB
         B/Q91KjL1C+6B8lkX5hLSjK/5gsDKxfX/g80A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691724563; x=1692329363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWhIqS9dUpfKrjrBJQYOrda9jzEuICCRO0pL3DDcTKo=;
        b=IUWUuxrP0FWg3ku67oqnVzERenjGSAZODSzUcbBFFmxqdg1huUfu8/YLU7fSdMBDkh
         hPCwSc0aCsdRzmipncGq7HpjGWQvSwHipP9B9CgC1hcRJQwa8j00X3/HFDhsnsKm1eNp
         bCET5teQytRG/gJLc6yq8FYM/K0F1eUTh5HcEsGF6Y2jg4sE0CXiGXaZ8xzrUQhCqYfM
         LMwcwYjO1fmrbRpwuh21CsaPf/TIpHvUxT09pH0zTNAp7J9IAL9NmOTtuegY9VkItJpa
         NdZMY0KCXRgDKVqeXYPLmt3aoOS6NPUbW9w1G3lEI/kBqei7PuYFR/bb0mXjPasI7ftU
         SjzA==
X-Gm-Message-State: AOJu0YzJjYO0NwIs6AFhxoQAbz5FeWQ0aMOXMvvqRzfbslibTN4ak1HZ
        q8zlR80k+poinUXoF+kPwMsfq5yi9vS5qaLxaxHiROxIF61DpXhFvRc=
X-Google-Smtp-Source: AGHT+IFki7Bypleq8wd7lWM/nSePOLnx2JZjQp+NjPtzyOlpWDrlx19s+5gMnr/FtUo8VQuoQODBUlBs10NSnucjz2M=
X-Received: by 2002:a2e:910c:0:b0:2b9:e9c8:cb1 with SMTP id
 m12-20020a2e910c000000b002b9e9c80cb1mr609541ljg.48.1691724563379; Thu, 10 Aug
 2023 20:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230810223137.596671-1-joel@joelfernandes.org> <CAEXW_YRL9FgepcG_=-F3HdS-h-Y9rRerM9nfxRsECfg2p9GJFQ@mail.gmail.com>
In-Reply-To: <CAEXW_YRL9FgepcG_=-F3HdS-h-Y9rRerM9nfxRsECfg2p9GJFQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 10 Aug 2023 23:29:12 -0400
Message-ID: <CAEXW_YTiYxcaPgHu5bsO1Be=CT0N0HLHvJVfEhDkX2hJ5CegeA@mail.gmail.com>
Subject: Re: [PATCH 5.15 1/3] tick: Detect and fix jiffies update stall
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 10, 2023 at 11:14=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> Hi,
> Unfortunately, One of my tests showed the following after 10 minutes
> of running the TREE01 scenario (even though TREE04 got fixed). Let us
> hold off on these 3 patches. I need to be sure there's absolutely no
> new issue introduced. So more work to do.
>
> Thank you!

And heh, this could well be one of my "debug patches" in stop machine
code that is misbehaving. In any case, I'll do more long running tests
with the fixes before posting them again.

Thank you all,

 - Joel



>
> [  667.823113] CPU: 2 PID: 27 Comm: migration/2 Not tainted 5.15.126-rc1+=
 #26
> [  667.904999] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  668.063061] Stopper: multi_cpu_stop+0x0/0x170 <-
> stop_machine_from_inactive_cpu+0x118/0x170
> [  668.179708] RIP: 0010:multi_cpu_stop+0x150/0x170
> [  668.231838] Code: 35 49 dd a1 01 48 c7 c7 60 51 95 bc 49 c7 c6 60
> 51 95 bc e8 62 c0 31 00 39 44 24 04 41 0f 94 c7 e9 ed fe ff ff e8 10
> 82 fc ff <48> 8b 0d 89 69 0e 45 8b 74 24 04 48 c7 c7 6d c4 35 bc 48 29
> c8 48
> [  668.563146] RSP: 0000:ffffb28f0023be68 EFLAGS: 00010216
> [  668.646854] RAX: 0000009b1b04be30 RBX: 0000000000000001 RCX: 000000000=
0000017
> [  668.733241] RDX: 00000ef798000000 RSI: 00000000000e4546 RDI: 0001d5f26=
8800000
> [  668.851846] RBP: ffffb28f000c7e90 R08: 0000009c17aaf41a R09: 7ffffffff=
fffffff
> [  668.966445] R10: 0000009aa37f6a00 R11: 00000000012679f7 R12: 000000000=
001e7c0
> [  669.056865] R13: 0000000000000002 R14: ffff8ec49ffb4f00 R15: ffffb28f0=
00c7e01
> [  669.172537] FS:  0000000000000000(0000) GS:ffff8ec49ea80000(0000)
> knlGS:0000000000000000
> [  669.318440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  669.395012] CR2: 000000000001e7c0 CR3: 0000000019e0c000 CR4: 000000000=
00006e0
> [  669.505733] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  669.588303] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  669.702863] Call Trace:
> [  669.742668]  <TASK>
> [  669.789840]  ? __die_body.cold+0x1a/0x1f
> [  669.836098]  ? page_fault_oops+0xcd/0x210
> [  669.922700]  ? exc_page_fault+0x60/0x140
> [  669.968411]  ? asm_exc_page_fault+0x22/0x30
> [  670.012394]  ? multi_cpu_stop+0x150/0x170
> [  670.115211]  ? multi_cpu_stop+0x150/0x170
> [  670.153099]  ? stop_machine_yield+0x10/0x10
> [  670.236328]  cpu_stopper_thread+0x85/0x130
> [  670.288173]  smpboot_thread_fn+0x183/0x220
> [  670.398452]  ? smpboot_register_percpu_thread+0xd0/0xd0
> [  670.482244]  kthread+0x12d/0x160
> [  670.527783]  ? set_kthread_struct+0x40/0x40
> [  670.606296]  ret_from_fork+0x22/0x30
> [  670.651658]  </TASK>
> [  670.695138] Modules linked in:
> [  670.740198] CR2: 000000000001e7c0
>
> On Thu, Aug 10, 2023 at 6:31=E2=80=AFPM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > From: Frederic Weisbecker <frederic@kernel.org>
> >
> > [ Upstream commit a1ff03cd6fb9c501fff63a4a2bface9adcfa81cd ]
> >
> > tick: Detect and fix jiffies update stall
> >
> > On some rare cases, the timekeeper CPU may be delaying its jiffies
> > update duty for a while. Known causes include:
> >
> > * The timekeeper is waiting on stop_machine in a MULTI_STOP_DISABLE_IRQ
> >   or MULTI_STOP_RUN state. Disabled interrupts prevent from timekeeping
> >   updates while waiting for the target CPU to complete its
> >   stop_machine() callback.
> >
> > * The timekeeper vcpu has VMEXIT'ed for a long while due to some overlo=
ad
> >   on the host.
> >
> > Detect and fix these situations with emergency timekeeping catchups.
> >
> > Original-patch-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/time/tick-sched.c | 17 +++++++++++++++++
> >  kernel/time/tick-sched.h |  4 ++++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index f42d0776bc84..7701c720dc1f 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -180,6 +180,8 @@ static ktime_t tick_init_jiffy_update(void)
> >         return period;
> >  }
> >
> > +#define MAX_STALLED_JIFFIES 5
> > +
> >  static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
> >  {
> >         int cpu =3D smp_processor_id();
> > @@ -207,6 +209,21 @@ static void tick_sched_do_timer(struct tick_sched =
*ts, ktime_t now)
> >         if (tick_do_timer_cpu =3D=3D cpu)
> >                 tick_do_update_jiffies64(now);
> >
> > +       /*
> > +        * If jiffies update stalled for too long (timekeeper in stop_m=
achine()
> > +        * or VMEXIT'ed for several msecs), force an update.
> > +        */
> > +       if (ts->last_tick_jiffies !=3D jiffies) {
> > +               ts->stalled_jiffies =3D 0;
> > +               ts->last_tick_jiffies =3D READ_ONCE(jiffies);
> > +       } else {
> > +               if (++ts->stalled_jiffies =3D=3D MAX_STALLED_JIFFIES) {
> > +                       tick_do_update_jiffies64(now);
> > +                       ts->stalled_jiffies =3D 0;
> > +                       ts->last_tick_jiffies =3D READ_ONCE(jiffies);
> > +               }
> > +       }
> > +
> >         if (ts->inidle)
> >                 ts->got_idle_tick =3D 1;
> >  }
> > diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
> > index d952ae393423..504649513399 100644
> > --- a/kernel/time/tick-sched.h
> > +++ b/kernel/time/tick-sched.h
> > @@ -49,6 +49,8 @@ enum tick_nohz_mode {
> >   * @timer_expires_base:        Base time clock monotonic for @timer_ex=
pires
> >   * @next_timer:                Expiry time of next expiring timer for =
debugging purpose only
> >   * @tick_dep_mask:     Tick dependency mask - is set, if someone needs=
 the tick
> > + * @last_tick_jiffies: Value of jiffies seen on last tick
> > + * @stalled_jiffies:   Number of stalled jiffies detected across ticks
> >   */
> >  struct tick_sched {
> >         struct hrtimer                  sched_timer;
> > @@ -77,6 +79,8 @@ struct tick_sched {
> >         u64                             next_timer;
> >         ktime_t                         idle_expires;
> >         atomic_t                        tick_dep_mask;
> > +       unsigned long                   last_tick_jiffies;
> > +       unsigned int                    stalled_jiffies;
> >  };
> >
> >  extern struct tick_sched *tick_get_tick_sched(int cpu);
> > --
> > 2.41.0.640.ga95def55d0-goog
> >
