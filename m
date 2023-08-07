Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423D77728AC
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 17:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjHGPIf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 11:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjHGPIe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 11:08:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17565170A;
        Mon,  7 Aug 2023 08:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C554361DDA;
        Mon,  7 Aug 2023 15:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3749FC433C7;
        Mon,  7 Aug 2023 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691420867;
        bh=EgTyXvWLOsNUpOMCI4UmxlS3ibq/vp17qgyx1BWLaZg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lxRagVEIjcnaJkJ0MZkPhUYi02BFmKEpWN6kNS0nr+20X2H1cCGFWIQ9K5JhMFXc2
         WnsR+I97XTM2esVSqi/SNELb7a2s8wBI/4lCBOZdl0a1CrmB0arfSFrDVm2tVJUAab
         M2zWngetAAvJUa7jgCAg+rahdGF8R5iGclpr6oSHJ0Ft1ltMKI2KslHiAnrBxtFCSl
         KZm4wYAottpWb92V5Qs+68RDJE0NRBpcmRiOfSAlnJeFpW31oADuKJ/sorSqlZqKT+
         mdwb/k1IcuDXq2jvbhNMmLA6SdLcE7iSxkqa9JS4PF/mumKvtZ9rak3IZgMbH2N8BB
         eCJpaM5XwwpXA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5230df1ce4fso6212297a12.1;
        Mon, 07 Aug 2023 08:07:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YwhChmlqt+pQNrSFED3MvZMNPZTMRBgIrBUMfVVlwOb4OBLyuWP
        oQWvjJQuv9NtK/xV7fK7lsK2iH3NakFufkkWAWE=
X-Google-Smtp-Source: AGHT+IG3uXPPuHfXbxr0Lm/Qv4Q3JdIk6Y2z3UUA93JuF0CmUTDz46KO24MTVF9g3cPM1ou8/M5XPNPWNvhzrrCt2Tk=
X-Received: by 2002:aa7:d358:0:b0:51d:f5bd:5a88 with SMTP id
 m24-20020aa7d358000000b0051df5bd5a88mr8120698edr.38.1691420865350; Mon, 07
 Aug 2023 08:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230807121045.2574938-1-chenhuacai@loongson.cn> <CAEXW_YQA96pDxvnqEQHA2QqiyApRSsN=5WKZ0c1ggwNKb473PA@mail.gmail.com>
In-Reply-To: <CAEXW_YQA96pDxvnqEQHA2QqiyApRSsN=5WKZ0c1ggwNKb473PA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 7 Aug 2023 23:07:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H55OpBzHDHv01zCgN85S=Lhi9WgqCpD_hhxZPbO3DWrzw@mail.gmail.com>
Message-ID: <CAAhV-H55OpBzHDHv01zCgN85S=Lhi9WgqCpD_hhxZPbO3DWrzw@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi, Joel,

On Mon, Aug 7, 2023 at 10:40=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Mon, Aug 7, 2023 at 8:11=E2=80=AFAM Huacai Chen <chenhuacai@loongson.c=
n> wrote:
> >
> > The KGDB initial breakpoint gets an rcu stall warning after commit
> > a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection in
> > rcu_cpu_stall_reset()").
> >
> > [   53.452051] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [   53.487950] rcu:     3-...0: (1 ticks this GP) idle=3D0e2c/1/0x40000=
00000000000 softirq=3D375/375 fqs=3D8
> > [   53.528243] rcu:     (t=3D12297 jiffies g=3D-995 q=3D1 ncpus=3D4)
> > [   53.564840] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc2+ #48=
48
> > [   53.603005] Hardware name: Loongson Loongson-3A5000-HV-7A2000-1w-V0.=
1-CRB/Loongson-LS3A5000-7A2000-1w-CRB-V1.21, BIOS Loongson-UDK2018-V2.0.050=
99-beta8 08
> > [   53.682062] pc 9000000000332100 ra 90000000003320f4 tp 90000001000a0=
000 sp 90000001000a3710
> > [   53.724934] a0 9000000001d4b488 a1 0000000000000000 a2 0000000000000=
001 a3 0000000000000000
> > [   53.768179] a4 9000000001d526c8 a5 90000001000a38f0 a6 0000000000000=
02c a7 0000000000000000
> > [   53.810751] t0 00000000000002b0 t1 0000000000000004 t2 900000000131c=
9c0 t3 fffffffffffffffa
> > [   53.853249] t4 0000000000000080 t5 90000001002ac190 t6 0000000000000=
004 t7 9000000001912d58
> > [   53.895684] t8 0000000000000000 u0 90000000013141a0 s9 0000000000000=
028 s0 9000000001d512f0
> > [   53.937633] s1 9000000001d51278 s2 90000001000a3798 s3 90000000019fc=
410 s4 9000000001d4b488
> > [   53.979486] s5 9000000001d512f0 s6 90000000013141a0 s7 0000000000000=
078 s8 9000000001d4b450
> > [   54.021175]    ra: 90000000003320f4 kgdb_cpu_enter+0x534/0x640
> > [   54.060150]   ERA: 9000000000332100 kgdb_cpu_enter+0x540/0x640
> > [   54.098347]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=3DCC DACM=3DCC -W=
E)
> > [   54.136621]  PRMD: 0000000c (PPLV0 +PIE +PWE)
> > [   54.172192]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
> > [   54.207838]  ECFG: 00071c1c (LIE=3D2-4,10-12 VS=3D7)
> > [   54.242503] ESTAT: 00000800 [INT] (IS=3D11 ECode=3D0 EsubCode=3D0)
> > [   54.277996]  PRID: 0014c011 (Loongson-64bit, Loongson-3A5000-HV)
> > [   54.313544] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc2+ #48=
48
> > [   54.430170] Stack : 0072617764726148 0000000000000000 90000000002235=
04 90000001000a0000
> > [   54.472308]         9000000100073a90 9000000100073a98 00000000000000=
00 9000000100073bd8
> > [   54.514413]         9000000100073bd0 9000000100073bd0 9000000100073a=
00 0000000000000001
> > [   54.556018]         0000000000000001 9000000100073a98 99828271f24e96=
1a 90000001002810c0
> > [   54.596924]         0000000000000001 0000000000010003 00000000000000=
00 0000000000000001
> > [   54.637115]         ffff8000337cdb80 0000000000000001 00000000063600=
00 900000000131c9c0
> > [   54.677049]         0000000000000000 0000000000000000 90000000017b4c=
98 9000000001912000
> > [   54.716394]         9000000001912f68 9000000001913000 9000000001912f=
70 00000000000002b0
> > [   54.754880]         90000000014a8840 0000000000000000 90000000002235=
1c 0000000000000000
> > [   54.792372]         00000000000002b0 000000000000000c 00000000000000=
00 0000000000071c1c
> > [   54.829302]         ...
> > [   54.859163] Call Trace:
> > [   54.859165] [<900000000022351c>] show_stack+0x5c/0x180
> > [   54.918298] [<90000000012f6100>] dump_stack_lvl+0x60/0x88
> > [   54.949251] [<90000000012dd5d8>] rcu_dump_cpu_stacks+0xf0/0x148
> > [   54.981116] [<90000000002d2fb8>] rcu_sched_clock_irq+0xb78/0xe60
> > [   55.012744] [<90000000002e47cc>] update_process_times+0x6c/0xc0
> > [   55.044169] [<90000000002f65d4>] tick_sched_timer+0x54/0x100
> > [   55.075488] [<90000000002e5174>] __hrtimer_run_queues+0x154/0x240
> > [   55.107347] [<90000000002e6288>] hrtimer_interrupt+0x108/0x2a0
> > [   55.139112] [<9000000000226418>] constant_timer_interrupt+0x38/0x60
> > [   55.170749] [<90000000002b3010>] __handle_irq_event_percpu+0x50/0x16=
0
> > [   55.203141] [<90000000002b3138>] handle_irq_event_percpu+0x18/0x80
> > [   55.235064] [<90000000002b9d54>] handle_percpu_irq+0x54/0xa0
> > [   55.266241] [<90000000002b2168>] generic_handle_domain_irq+0x28/0x40
> > [   55.298466] [<9000000000aba95c>] handle_cpu_irq+0x5c/0xa0
> > [   55.329749] [<90000000012f7270>] handle_loongarch_irq+0x30/0x60
> > [   55.361476] [<90000000012f733c>] do_vint+0x9c/0x100
> > [   55.391737] [<9000000000332100>] kgdb_cpu_enter+0x540/0x640
> > [   55.422440] [<9000000000332b64>] kgdb_handle_exception+0x104/0x180
> > [   55.452911] [<9000000000232478>] kgdb_loongarch_notify+0x38/0xa0
> > [   55.481964] [<900000000026b4d4>] notify_die+0x94/0x100
> > [   55.509184] [<90000000012f685c>] do_bp+0x21c/0x340
> > [   55.562475] [<90000000003315b8>] kgdb_compiled_break+0x0/0x28
> > [   55.590319] [<9000000000332e80>] kgdb_register_io_module+0x160/0x1c0
> > [   55.618901] [<9000000000c0f514>] configure_kgdboc+0x154/0x1c0
> > [   55.647034] [<9000000000c0f5e0>] kgdboc_probe+0x60/0x80
> > [   55.674647] [<9000000000c96da8>] platform_probe+0x68/0x100
> > [   55.702613] [<9000000000c938e0>] really_probe+0xc0/0x340
> > [   55.730528] [<9000000000c93be4>] __driver_probe_device+0x84/0x140
> > [   55.759615] [<9000000000c93cdc>] driver_probe_device+0x3c/0x120
> > [   55.787990] [<9000000000c93e8c>] __device_attach_driver+0xcc/0x160
> > [   55.817145] [<9000000000c91290>] bus_for_each_drv+0x90/0x100
> > [   55.845654] [<9000000000c94328>] __device_attach+0xa8/0x1a0
> > [   55.874145] [<9000000000c925f0>] bus_probe_device+0xb0/0xe0
> > [   55.902572] [<9000000000c8ec7c>] device_add+0x65c/0x860
> > [   55.930635] [<9000000000c96704>] platform_device_add+0x124/0x2c0
> > [   55.959669] [<9000000001452b38>] init_kgdboc+0x58/0xa0
> > [   55.987677] [<900000000022015c>] do_one_initcall+0x7c/0x1e0
> > [   56.016134] [<9000000001420f1c>] kernel_init_freeable+0x22c/0x2a0
> > [   56.045128] [<90000000012f923c>] kernel_init+0x20/0x124
> >
> > Currently rcu_cpu_stall_reset() set rcu_state.jiffies_stall to one chec=
k
> > period later, i.e. jiffies + rcu_jiffies_till_stall_check(). But jiffie=
s
> > is only updated in the timer interrupt, so when kgdb_cpu_enter() begins
> > to run there may already be nearly one rcu check period after jiffies.
> > Since all interrupts are disabled during kgdb_cpu_enter(), jiffies will
> > not be updated. When kgdb_cpu_enter() returns, rcu_state.jiffies_stall
> > maybe already gets timeout.
> >
> > We can set rcu_state.jiffies_stall to two rcu check periods later, i.e.
> > jiffies + (rcu_jiffies_till_stall_check() * 2) in rcu_cpu_stall_reset()
> > to avoid this problem.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detectio=
n in rcu_cpu_stall_reset()")
> > Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  kernel/rcu/tree_stall.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index b10b8349bb2a..a35afd19e2bf 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -154,7 +154,7 @@ static void panic_on_rcu_stall(void)
> >  void rcu_cpu_stall_reset(void)
> >  {
> >         WRITE_ONCE(rcu_state.jiffies_stall,
> > -                  jiffies + rcu_jiffies_till_stall_check());
> > +                  jiffies + (rcu_jiffies_till_stall_check() * 2));
>
> I feel this is just pushing the problem. Example if somebody
> configures a smaller stall timeout, then again it is a problem.
>
> Instead, wouldn't it be better to figure out how to update jiffies in thi=
s path?
>
> Would any of the tick_*_update_jiffies() functions help?
Thank you for your advice, I have considered
tick_do_update_jiffies64(), but it is a static function and it is
conditionally defined. So it is difficult to use.

On the other hand, the method in this patch can solve most of problems:
1, There is a lower limit of "stall timeout", 3 seconds;
2, If there is a timeout before kgdb_cpu_enter() begins, then it is
another problem which has nothing to do with rcu_cpu_stall_reset();
3, Then we can avoid rcu stall warning if the execution time of
kgdb_cpu_enter() is not greater than the "stall timeout".

Huacai

>
> thanks,
>
> - Joel
>
>
> >  }
> >
> >  //////////////////////////////////////////////////////////////////////=
////////
> > --
> > 2.39.3
> >
