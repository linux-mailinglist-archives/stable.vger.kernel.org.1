Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F31E773FE8
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 18:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjHHQzd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 12:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjHHQyz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 12:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B36718102;
        Tue,  8 Aug 2023 08:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6EB362607;
        Tue,  8 Aug 2023 15:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4EBC433CB;
        Tue,  8 Aug 2023 15:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691510345;
        bh=KRWTRWJWWW+2bvOgYQuA1QPh03KSQbjmX5/AOkW0Zeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ovWXzVhQgLHQgzZm8rePnQLU+lXgMnG5A1KBmARmIXWTg3aDvZSkoOmmap+SrVZLM
         uJhkxAjcINqRHM4UOUSzxkZ8neBYXywtcikiD5m3UcgILCuM1Ne5MRbHWtTjTXdYzr
         /UDtRRJFhZBU4baDOMXu2YTiHJnJwvc8yS5R/uGzdalZcDGdhjpzAvxDqVU/h11Ddj
         mgJZRUywXTLurRaWBHuYHlpVjN6HjsQTw5Pw2/fAH9HNUUMIwx9K84Ig6lseHOVqYh
         V7iOciOPkbK+eeK/7NZF/bepihsnYU2mLN2qpAuZhVjfnoea6KJqnuRaBZ5qm1zYm6
         ZFBu0FMzQq27w==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so14412123a12.1;
        Tue, 08 Aug 2023 08:59:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YyuaSOukJzqBKyLLQvUcSDU+dz9izWXSMoG4oTd2RABkkvlWyQb
        d9KkLNdfyW/CYzMQGI98MEolsnZ1hQDXo7U0mQ0=
X-Google-Smtp-Source: AGHT+IFrizHUILbCDb63eBFvA9oibInfHXOh6CnF1wasWKBzCfpEJcgtnwNOpmtmDAUkvcrX/VaFHe4KXrkKdtafGNk=
X-Received: by 2002:a05:6402:5192:b0:51e:4218:b91b with SMTP id
 q18-20020a056402519200b0051e4218b91bmr11711728edd.1.1691510343501; Tue, 08
 Aug 2023 08:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230807121045.2574938-1-chenhuacai@loongson.cn>
 <CAEXW_YQA96pDxvnqEQHA2QqiyApRSsN=5WKZ0c1ggwNKb473PA@mail.gmail.com>
 <CAAhV-H55OpBzHDHv01zCgN85S=Lhi9WgqCpD_hhxZPbO3DWrzw@mail.gmail.com> <CAEXW_YQUd0MVmBq4eDCTWnTsT=Y3ASzTwo-M_zsVSvx0s36dKQ@mail.gmail.com>
In-Reply-To: <CAEXW_YQUd0MVmBq4eDCTWnTsT=Y3ASzTwo-M_zsVSvx0s36dKQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 8 Aug 2023 23:58:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7j9Y=VvRLm8thLw-EX1PGqBA9YfT4G1AN7ucYS=iP+DQ@mail.gmail.com>
Message-ID: <CAAhV-H7j9Y=VvRLm8thLw-EX1PGqBA9YfT4G1AN7ucYS=iP+DQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: Set jiffies_stall to two periods later in rcu_cpu_stall_reset()
To:     Joel Fernandes <joel@joelfernandes.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi, Joel,

On Tue, Aug 8, 2023 at 10:55=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Mon, Aug 7, 2023 at 11:07=E2=80=AFAM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Joel,
> >
> > On Mon, Aug 7, 2023 at 10:40=E2=80=AFPM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > >
> > > On Mon, Aug 7, 2023 at 8:11=E2=80=AFAM Huacai Chen <chenhuacai@loongs=
on.cn> wrote:
> > > >
> > > > The KGDB initial breakpoint gets an rcu stall warning after commit
> > > > a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection i=
n
> > > > rcu_cpu_stall_reset()").
> > > >
> > > > [   53.452051] rcu: INFO: rcu_preempt self-detected stall on CPU
> > > > [   53.487950] rcu:     3-...0: (1 ticks this GP) idle=3D0e2c/1/0x4=
000000000000000 softirq=3D375/375 fqs=3D8
> > > > [   53.528243] rcu:     (t=3D12297 jiffies g=3D-995 q=3D1 ncpus=3D4=
)
> > > > [   53.564840] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc2+=
 #4848
> > > > [   53.603005] Hardware name: Loongson Loongson-3A5000-HV-7A2000-1w=
-V0.1-CRB/Loongson-LS3A5000-7A2000-1w-CRB-V1.21, BIOS Loongson-UDK2018-V2.0=
.05099-beta8 08
> > > > [   53.682062] pc 9000000000332100 ra 90000000003320f4 tp 900000010=
00a0000 sp 90000001000a3710
> > > > [   53.724934] a0 9000000001d4b488 a1 0000000000000000 a2 000000000=
0000001 a3 0000000000000000
> > > > [   53.768179] a4 9000000001d526c8 a5 90000001000a38f0 a6 000000000=
000002c a7 0000000000000000
> > > > [   53.810751] t0 00000000000002b0 t1 0000000000000004 t2 900000000=
131c9c0 t3 fffffffffffffffa
> > > > [   53.853249] t4 0000000000000080 t5 90000001002ac190 t6 000000000=
0000004 t7 9000000001912d58
> > > > [   53.895684] t8 0000000000000000 u0 90000000013141a0 s9 000000000=
0000028 s0 9000000001d512f0
> > > > [   53.937633] s1 9000000001d51278 s2 90000001000a3798 s3 900000000=
19fc410 s4 9000000001d4b488
> > > > [   53.979486] s5 9000000001d512f0 s6 90000000013141a0 s7 000000000=
0000078 s8 9000000001d4b450
> > > > [   54.021175]    ra: 90000000003320f4 kgdb_cpu_enter+0x534/0x640
> > > > [   54.060150]   ERA: 9000000000332100 kgdb_cpu_enter+0x540/0x640
> > > > [   54.098347]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DC=
C -WE)
> > > > [   54.136621]  PRMD: 0000000c (PPLV0 +PIE +PWE)
> > > > [   54.172192]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> > > > [   54.207838]  ECFG: 00071c1c (LIE=3D2-4,10-12 VS=3D7)
> > > > [   54.242503] ESTAT: 00000800 [INT] (IS=3D11 ECode=3D0 EsubCode=3D=
0)
> > > > [   54.277996]  PRID: 0014c011 (Loongson-64bit, Loongson-3A5000-HV)
> > > > [   54.313544] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc2+=
 #4848
> > > > [   54.430170] Stack : 0072617764726148 0000000000000000 9000000000=
223504 90000001000a0000
> > > > [   54.472308]         9000000100073a90 9000000100073a98 0000000000=
000000 9000000100073bd8
> > > > [   54.514413]         9000000100073bd0 9000000100073bd0 9000000100=
073a00 0000000000000001
> > > > [   54.556018]         0000000000000001 9000000100073a98 99828271f2=
4e961a 90000001002810c0
> > > > [   54.596924]         0000000000000001 0000000000010003 0000000000=
000000 0000000000000001
> > > > [   54.637115]         ffff8000337cdb80 0000000000000001 0000000006=
360000 900000000131c9c0
> > > > [   54.677049]         0000000000000000 0000000000000000 9000000001=
7b4c98 9000000001912000
> > > > [   54.716394]         9000000001912f68 9000000001913000 9000000001=
912f70 00000000000002b0
> > > > [   54.754880]         90000000014a8840 0000000000000000 9000000000=
22351c 0000000000000000
> > > > [   54.792372]         00000000000002b0 000000000000000c 0000000000=
000000 0000000000071c1c
> > > > [   54.829302]         ...
> > > > [   54.859163] Call Trace:
> > > > [   54.859165] [<900000000022351c>] show_stack+0x5c/0x180
> > > > [   54.918298] [<90000000012f6100>] dump_stack_lvl+0x60/0x88
> > > > [   54.949251] [<90000000012dd5d8>] rcu_dump_cpu_stacks+0xf0/0x148
> > > > [   54.981116] [<90000000002d2fb8>] rcu_sched_clock_irq+0xb78/0xe60
> > > > [   55.012744] [<90000000002e47cc>] update_process_times+0x6c/0xc0
> > > > [   55.044169] [<90000000002f65d4>] tick_sched_timer+0x54/0x100
> > > > [   55.075488] [<90000000002e5174>] __hrtimer_run_queues+0x154/0x24=
0
> > > > [   55.107347] [<90000000002e6288>] hrtimer_interrupt+0x108/0x2a0
> > > > [   55.139112] [<9000000000226418>] constant_timer_interrupt+0x38/0=
x60
> > > > [   55.170749] [<90000000002b3010>] __handle_irq_event_percpu+0x50/=
0x160
> > > > [   55.203141] [<90000000002b3138>] handle_irq_event_percpu+0x18/0x=
80
> > > > [   55.235064] [<90000000002b9d54>] handle_percpu_irq+0x54/0xa0
> > > > [   55.266241] [<90000000002b2168>] generic_handle_domain_irq+0x28/=
0x40
> > > > [   55.298466] [<9000000000aba95c>] handle_cpu_irq+0x5c/0xa0
> > > > [   55.329749] [<90000000012f7270>] handle_loongarch_irq+0x30/0x60
> > > > [   55.361476] [<90000000012f733c>] do_vint+0x9c/0x100
> > > > [   55.391737] [<9000000000332100>] kgdb_cpu_enter+0x540/0x640
> > > > [   55.422440] [<9000000000332b64>] kgdb_handle_exception+0x104/0x1=
80
> > > > [   55.452911] [<9000000000232478>] kgdb_loongarch_notify+0x38/0xa0
> > > > [   55.481964] [<900000000026b4d4>] notify_die+0x94/0x100
> > > > [   55.509184] [<90000000012f685c>] do_bp+0x21c/0x340
> > > > [   55.562475] [<90000000003315b8>] kgdb_compiled_break+0x0/0x28
> > > > [   55.590319] [<9000000000332e80>] kgdb_register_io_module+0x160/0=
x1c0
> > > > [   55.618901] [<9000000000c0f514>] configure_kgdboc+0x154/0x1c0
> > > > [   55.647034] [<9000000000c0f5e0>] kgdboc_probe+0x60/0x80
> > > > [   55.674647] [<9000000000c96da8>] platform_probe+0x68/0x100
> > > > [   55.702613] [<9000000000c938e0>] really_probe+0xc0/0x340
> > > > [   55.730528] [<9000000000c93be4>] __driver_probe_device+0x84/0x14=
0
> > > > [   55.759615] [<9000000000c93cdc>] driver_probe_device+0x3c/0x120
> > > > [   55.787990] [<9000000000c93e8c>] __device_attach_driver+0xcc/0x1=
60
> > > > [   55.817145] [<9000000000c91290>] bus_for_each_drv+0x90/0x100
> > > > [   55.845654] [<9000000000c94328>] __device_attach+0xa8/0x1a0
> > > > [   55.874145] [<9000000000c925f0>] bus_probe_device+0xb0/0xe0
> > > > [   55.902572] [<9000000000c8ec7c>] device_add+0x65c/0x860
> > > > [   55.930635] [<9000000000c96704>] platform_device_add+0x124/0x2c0
> > > > [   55.959669] [<9000000001452b38>] init_kgdboc+0x58/0xa0
> > > > [   55.987677] [<900000000022015c>] do_one_initcall+0x7c/0x1e0
> > > > [   56.016134] [<9000000001420f1c>] kernel_init_freeable+0x22c/0x2a=
0
> > > > [   56.045128] [<90000000012f923c>] kernel_init+0x20/0x124
> > > >
> > > > Currently rcu_cpu_stall_reset() set rcu_state.jiffies_stall to one =
check
> > > > period later, i.e. jiffies + rcu_jiffies_till_stall_check(). But ji=
ffies
> > > > is only updated in the timer interrupt, so when kgdb_cpu_enter() be=
gins
> > > > to run there may already be nearly one rcu check period after jiffi=
es.
> > > > Since all interrupts are disabled during kgdb_cpu_enter(), jiffies =
will
> > > > not be updated. When kgdb_cpu_enter() returns, rcu_state.jiffies_st=
all
> > > > maybe already gets timeout.
> > > >
> > > > We can set rcu_state.jiffies_stall to two rcu check periods later, =
i.e.
> > > > jiffies + (rcu_jiffies_till_stall_check() * 2) in rcu_cpu_stall_res=
et()
> > > > to avoid this problem.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall dete=
ction in rcu_cpu_stall_reset()")
> > > > Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  kernel/rcu/tree_stall.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > > index b10b8349bb2a..a35afd19e2bf 100644
> > > > --- a/kernel/rcu/tree_stall.h
> > > > +++ b/kernel/rcu/tree_stall.h
> > > > @@ -154,7 +154,7 @@ static void panic_on_rcu_stall(void)
> > > >  void rcu_cpu_stall_reset(void)
> > > >  {
> > > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > > -                  jiffies + rcu_jiffies_till_stall_check());
> > > > +                  jiffies + (rcu_jiffies_till_stall_check() * 2));
> > >
> > > I feel this is just pushing the problem. Example if somebody
> > > configures a smaller stall timeout, then again it is a problem.
> > >
> > > Instead, wouldn't it be better to figure out how to update jiffies in=
 this path?
> > >
> > > Would any of the tick_*_update_jiffies() functions help?
> > Thank you for your advice, I have considered
> > tick_do_update_jiffies64(), but it is a static function and it is
> > conditionally defined. So it is difficult to use.
> >
> > On the other hand, the method in this patch can solve most of problems:
> > 1, There is a lower limit of "stall timeout", 3 seconds;
> > 2, If there is a timeout before kgdb_cpu_enter() begins, then it is
> > another problem which has nothing to do with rcu_cpu_stall_reset();
> > 3, Then we can avoid rcu stall warning if the execution time of
> > kgdb_cpu_enter() is not greater than the "stall timeout".
>
> Forgive me if this is a silly question, if "stall timeout" is 3
> seconds; then if kgdb_cpu_enter() takes 2.9 seconds (or 5.9 seconds
> when you double the stall timeout), are you saying that's Ok and
> should not be reported?
Yes, this is indeed a problem, and updating jiffies at the beginning
of rcu_cpu_stall_reset() seems the best solution (but not easy).

However, in normal cases kgdb_cpu_enter() will not take as long as 2.9
seconds (of course we can produce such a case).

This patch is just an "easy but not best" solution. :)

Huacai

>
> That still sounds like not the right fix. Let me know what I am missing, =
thanks!
>
> What I was getting at was, if it is an issue then let us just report
> it until it is fixed the right way IMHO rather than papering over it.
>
>  - Joel
>
>
> >
> > Huacai
> >
> > >
> > > thanks,
> > >
> > > - Joel
> > >
> > >
> > > >  }
> > > >
> > > >  //////////////////////////////////////////////////////////////////=
////////////
> > > > --
> > > > 2.39.3
> > > >
