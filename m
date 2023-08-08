Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C4D773F0E
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 18:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjHHQm3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 12:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjHHQlg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 12:41:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB43E3DE0D
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 08:54:59 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe3b86cec1so9039984e87.2
        for <stable@vger.kernel.org>; Tue, 08 Aug 2023 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691510084; x=1692114884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJiI83OpdQpykxcKfreAi9GUl0qWK41Y3bMmIPO65BE=;
        b=Aq+LNFnaGiBPCRNA2irCu789OAEknPdmrzibIlgVfSA9VuiB8Nd48fJLKfNWN8dWHJ
         WKE9c61XJkK15WQfoC2EaIggTqhkPfI+QCeDni/UWmo/oCcrJm/k5nd7mhXP/j1fYP5e
         wiYMFtQ2L/GqFuM6xvpTM3FFFg5e23+XEdtAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510084; x=1692114884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJiI83OpdQpykxcKfreAi9GUl0qWK41Y3bMmIPO65BE=;
        b=Vr6QE6TndY+XUS6W3PH5nIECPMgmljmv8zDvwJNab1bikiDOeZ1orUA2nKzdT0kR1k
         txGtqZ5XLKxrStTPKhDMNSGWZhEeGuV92F1hW0lbI6rL/PR/kF7d/NpzG49K7E7Bdxm1
         qL2mRHyNZuMqRvliR5rKZWaxfShyrtfg0a/QQ3IH7tSlKhpJSAndsyF0ycpEKgJ8BBmb
         LTqkgh8MI5lqq3+eYyfJoYzVuyOOr+yJSS8ekm4YljGfMjiEajsXavB2TWVbD870sxkA
         VjHCpQ465SF/UUhCzppyVenURdXzCucgH8Sj/8GwhVuSzMmi+abZtGeuKkHcFbcgIDxS
         R6Qg==
X-Gm-Message-State: AOJu0YxCcog+KMip+ANmBN4oOKs9z/CbENn9MS0PpJRcGBKnDy505mm9
        2zy6f6k0TJmiF9hAkWpVe2QQVJDvjGJ+h248+oObK0guwMQCHhe85yg=
X-Google-Smtp-Source: AGHT+IE6ulLNyySmWfmheRasURqe+tCEKDCXDmx2CBwGFTdc7xWgrBWY8SEb7DFElr9sQycIwl1xDdEHhUxCXUoKNnY=
X-Received: by 2002:a2e:a16e:0:b0:2b6:9f5d:e758 with SMTP id
 u14-20020a2ea16e000000b002b69f5de758mr9468393ljl.9.1691506531645; Tue, 08 Aug
 2023 07:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230807121045.2574938-1-chenhuacai@loongson.cn>
 <CAEXW_YQA96pDxvnqEQHA2QqiyApRSsN=5WKZ0c1ggwNKb473PA@mail.gmail.com> <CAAhV-H55OpBzHDHv01zCgN85S=Lhi9WgqCpD_hhxZPbO3DWrzw@mail.gmail.com>
In-Reply-To: <CAAhV-H55OpBzHDHv01zCgN85S=Lhi9WgqCpD_hhxZPbO3DWrzw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 8 Aug 2023 10:55:20 -0400
Message-ID: <CAEXW_YQUd0MVmBq4eDCTWnTsT=Y3ASzTwo-M_zsVSvx0s36dKQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: Set jiffies_stall to two periods later in rcu_cpu_stall_reset()
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, stable@vger.kernel.org,
        Binbin Zhou <zhoubinbin@loongson.cn>
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

On Mon, Aug 7, 2023 at 11:07=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Joel,
>
> On Mon, Aug 7, 2023 at 10:40=E2=80=AFPM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> > On Mon, Aug 7, 2023 at 8:11=E2=80=AFAM Huacai Chen <chenhuacai@loongson=
.cn> wrote:
> > >
> > > The KGDB initial breakpoint gets an rcu stall warning after commit
> > > a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection in
> > > rcu_cpu_stall_reset()").
> > >
> > > [   53.452051] rcu: INFO: rcu_preempt self-detected stall on CPU
> > > [   53.487950] rcu:     3-...0: (1 ticks this GP) idle=3D0e2c/1/0x400=
0000000000000 softirq=3D375/375 fqs=3D8
> > > [   53.528243] rcu:     (t=3D12297 jiffies g=3D-995 q=3D1 ncpus=3D4)
> > > [   53.564840] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc2+ #=
4848
> > > [   53.603005] Hardware name: Loongson Loongson-3A5000-HV-7A2000-1w-V=
0.1-CRB/Loongson-LS3A5000-7A2000-1w-CRB-V1.21, BIOS Loongson-UDK2018-V2.0.0=
5099-beta8 08
> > > [   53.682062] pc 9000000000332100 ra 90000000003320f4 tp 90000001000=
a0000 sp 90000001000a3710
> > > [   53.724934] a0 9000000001d4b488 a1 0000000000000000 a2 00000000000=
00001 a3 0000000000000000
> > > [   53.768179] a4 9000000001d526c8 a5 90000001000a38f0 a6 00000000000=
0002c a7 0000000000000000
> > > [   53.810751] t0 00000000000002b0 t1 0000000000000004 t2 90000000013=
1c9c0 t3 fffffffffffffffa
> > > [   53.853249] t4 0000000000000080 t5 90000001002ac190 t6 00000000000=
00004 t7 9000000001912d58
> > > [   53.895684] t8 0000000000000000 u0 90000000013141a0 s9 00000000000=
00028 s0 9000000001d512f0
> > > [   53.937633] s1 9000000001d51278 s2 90000001000a3798 s3 90000000019=
fc410 s4 9000000001d4b488
> > > [   53.979486] s5 9000000001d512f0 s6 90000000013141a0 s7 00000000000=
00078 s8 9000000001d4b450
> > > [   54.021175]    ra: 90000000003320f4 kgdb_cpu_enter+0x534/0x640
> > > [   54.060150]   ERA: 9000000000332100 kgdb_cpu_enter+0x540/0x640
> > > [   54.098347]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC =
-WE)
> > > [   54.136621]  PRMD: 0000000c (PPLV0 +PIE +PWE)
> > > [   54.172192]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> > > [   54.207838]  ECFG: 00071c1c (LIE=3D2-4,10-12 VS=3D7)
> > > [   54.242503] ESTAT: 00000800 [INT] (IS=3D11 ECode=3D0 EsubCode=3D0)
> > > [   54.277996]  PRID: 0014c011 (Loongson-64bit, Loongson-3A5000-HV)
> > > [   54.313544] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc2+ #=
4848
> > > [   54.430170] Stack : 0072617764726148 0000000000000000 900000000022=
3504 90000001000a0000
> > > [   54.472308]         9000000100073a90 9000000100073a98 000000000000=
0000 9000000100073bd8
> > > [   54.514413]         9000000100073bd0 9000000100073bd0 900000010007=
3a00 0000000000000001
> > > [   54.556018]         0000000000000001 9000000100073a98 99828271f24e=
961a 90000001002810c0
> > > [   54.596924]         0000000000000001 0000000000010003 000000000000=
0000 0000000000000001
> > > [   54.637115]         ffff8000337cdb80 0000000000000001 000000000636=
0000 900000000131c9c0
> > > [   54.677049]         0000000000000000 0000000000000000 90000000017b=
4c98 9000000001912000
> > > [   54.716394]         9000000001912f68 9000000001913000 900000000191=
2f70 00000000000002b0
> > > [   54.754880]         90000000014a8840 0000000000000000 900000000022=
351c 0000000000000000
> > > [   54.792372]         00000000000002b0 000000000000000c 000000000000=
0000 0000000000071c1c
> > > [   54.829302]         ...
> > > [   54.859163] Call Trace:
> > > [   54.859165] [<900000000022351c>] show_stack+0x5c/0x180
> > > [   54.918298] [<90000000012f6100>] dump_stack_lvl+0x60/0x88
> > > [   54.949251] [<90000000012dd5d8>] rcu_dump_cpu_stacks+0xf0/0x148
> > > [   54.981116] [<90000000002d2fb8>] rcu_sched_clock_irq+0xb78/0xe60
> > > [   55.012744] [<90000000002e47cc>] update_process_times+0x6c/0xc0
> > > [   55.044169] [<90000000002f65d4>] tick_sched_timer+0x54/0x100
> > > [   55.075488] [<90000000002e5174>] __hrtimer_run_queues+0x154/0x240
> > > [   55.107347] [<90000000002e6288>] hrtimer_interrupt+0x108/0x2a0
> > > [   55.139112] [<9000000000226418>] constant_timer_interrupt+0x38/0x6=
0
> > > [   55.170749] [<90000000002b3010>] __handle_irq_event_percpu+0x50/0x=
160
> > > [   55.203141] [<90000000002b3138>] handle_irq_event_percpu+0x18/0x80
> > > [   55.235064] [<90000000002b9d54>] handle_percpu_irq+0x54/0xa0
> > > [   55.266241] [<90000000002b2168>] generic_handle_domain_irq+0x28/0x=
40
> > > [   55.298466] [<9000000000aba95c>] handle_cpu_irq+0x5c/0xa0
> > > [   55.329749] [<90000000012f7270>] handle_loongarch_irq+0x30/0x60
> > > [   55.361476] [<90000000012f733c>] do_vint+0x9c/0x100
> > > [   55.391737] [<9000000000332100>] kgdb_cpu_enter+0x540/0x640
> > > [   55.422440] [<9000000000332b64>] kgdb_handle_exception+0x104/0x180
> > > [   55.452911] [<9000000000232478>] kgdb_loongarch_notify+0x38/0xa0
> > > [   55.481964] [<900000000026b4d4>] notify_die+0x94/0x100
> > > [   55.509184] [<90000000012f685c>] do_bp+0x21c/0x340
> > > [   55.562475] [<90000000003315b8>] kgdb_compiled_break+0x0/0x28
> > > [   55.590319] [<9000000000332e80>] kgdb_register_io_module+0x160/0x1=
c0
> > > [   55.618901] [<9000000000c0f514>] configure_kgdboc+0x154/0x1c0
> > > [   55.647034] [<9000000000c0f5e0>] kgdboc_probe+0x60/0x80
> > > [   55.674647] [<9000000000c96da8>] platform_probe+0x68/0x100
> > > [   55.702613] [<9000000000c938e0>] really_probe+0xc0/0x340
> > > [   55.730528] [<9000000000c93be4>] __driver_probe_device+0x84/0x140
> > > [   55.759615] [<9000000000c93cdc>] driver_probe_device+0x3c/0x120
> > > [   55.787990] [<9000000000c93e8c>] __device_attach_driver+0xcc/0x160
> > > [   55.817145] [<9000000000c91290>] bus_for_each_drv+0x90/0x100
> > > [   55.845654] [<9000000000c94328>] __device_attach+0xa8/0x1a0
> > > [   55.874145] [<9000000000c925f0>] bus_probe_device+0xb0/0xe0
> > > [   55.902572] [<9000000000c8ec7c>] device_add+0x65c/0x860
> > > [   55.930635] [<9000000000c96704>] platform_device_add+0x124/0x2c0
> > > [   55.959669] [<9000000001452b38>] init_kgdboc+0x58/0xa0
> > > [   55.987677] [<900000000022015c>] do_one_initcall+0x7c/0x1e0
> > > [   56.016134] [<9000000001420f1c>] kernel_init_freeable+0x22c/0x2a0
> > > [   56.045128] [<90000000012f923c>] kernel_init+0x20/0x124
> > >
> > > Currently rcu_cpu_stall_reset() set rcu_state.jiffies_stall to one ch=
eck
> > > period later, i.e. jiffies + rcu_jiffies_till_stall_check(). But jiff=
ies
> > > is only updated in the timer interrupt, so when kgdb_cpu_enter() begi=
ns
> > > to run there may already be nearly one rcu check period after jiffies=
.
> > > Since all interrupts are disabled during kgdb_cpu_enter(), jiffies wi=
ll
> > > not be updated. When kgdb_cpu_enter() returns, rcu_state.jiffies_stal=
l
> > > maybe already gets timeout.
> > >
> > > We can set rcu_state.jiffies_stall to two rcu check periods later, i.=
e.
> > > jiffies + (rcu_jiffies_till_stall_check() * 2) in rcu_cpu_stall_reset=
()
> > > to avoid this problem.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detect=
ion in rcu_cpu_stall_reset()")
> > > Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  kernel/rcu/tree_stall.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > index b10b8349bb2a..a35afd19e2bf 100644
> > > --- a/kernel/rcu/tree_stall.h
> > > +++ b/kernel/rcu/tree_stall.h
> > > @@ -154,7 +154,7 @@ static void panic_on_rcu_stall(void)
> > >  void rcu_cpu_stall_reset(void)
> > >  {
> > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > -                  jiffies + rcu_jiffies_till_stall_check());
> > > +                  jiffies + (rcu_jiffies_till_stall_check() * 2));
> >
> > I feel this is just pushing the problem. Example if somebody
> > configures a smaller stall timeout, then again it is a problem.
> >
> > Instead, wouldn't it be better to figure out how to update jiffies in t=
his path?
> >
> > Would any of the tick_*_update_jiffies() functions help?
> Thank you for your advice, I have considered
> tick_do_update_jiffies64(), but it is a static function and it is
> conditionally defined. So it is difficult to use.
>
> On the other hand, the method in this patch can solve most of problems:
> 1, There is a lower limit of "stall timeout", 3 seconds;
> 2, If there is a timeout before kgdb_cpu_enter() begins, then it is
> another problem which has nothing to do with rcu_cpu_stall_reset();
> 3, Then we can avoid rcu stall warning if the execution time of
> kgdb_cpu_enter() is not greater than the "stall timeout".

Forgive me if this is a silly question, if "stall timeout" is 3
seconds; then if kgdb_cpu_enter() takes 2.9 seconds (or 5.9 seconds
when you double the stall timeout), are you saying that's Ok and
should not be reported?

That still sounds like not the right fix. Let me know what I am missing, th=
anks!

What I was getting at was, if it is an issue then let us just report
it until it is fixed the right way IMHO rather than papering over it.

 - Joel


>
> Huacai
>
> >
> > thanks,
> >
> > - Joel
> >
> >
> > >  }
> > >
> > >  ////////////////////////////////////////////////////////////////////=
//////////
> > > --
> > > 2.39.3
> > >
