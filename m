Return-Path: <stable+bounces-28501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB0C881741
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 19:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE7B281315
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 18:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C06B6BFD0;
	Wed, 20 Mar 2024 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKi7zrYA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982416BB21
	for <stable@vger.kernel.org>; Wed, 20 Mar 2024 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710958658; cv=none; b=Tqv5bdHGpak5bZ1QUHeALkgXN8bNok66fTDkbHlPCi5mS8NBhbNdoAs4maPhgN9Xob1sYXlCZvi43ccyjCNLiM/ORl4S4uS40xrycC659H2S7SB/iIzhWB9MVNSFTHoT5uxrCZgqCAUSZ4SKkuWfO95lv240yiRsV/dykYsx1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710958658; c=relaxed/simple;
	bh=ZPoP4hySoIxWXgNQhEPezrar4BwnkEipVrTCaEqf7P0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ue7LYpfup9SZV070MI72/ul0RSK8Ox/Q8aRX8i9yYRdP8l3kyySBhXBRqPHFqljnEDMveJqNGmD6r7BKv00ZkC+bfstVqmIb5Z0jK1T6chm04ju4es3/eq+8hvq/MimO65HxAgi3YAo6RieoztXfsLCvXDhY964eDMzaPtUgCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKi7zrYA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710958655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ObIcN+ypkSzv3+S4gyvYKPSuyVaufeeCnRP/hMzldZI=;
	b=EKi7zrYAAToA1EY/yInceGJ1rv0nDrIvRVum2RaH1KD4g1u+LQkC1Qx2d2ZO/JWMJ9t6pt
	G4tgO508uZLngnNabOuFePD1roc24LGB6gQjMFL53cRN3N3pwtLp5zNnbMV3t2v0OlxPsy
	gsVqox3C/9Yn/oEs953POvqHRiBZP0w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-WUCVuD9TO4mIWROB77zXvw-1; Wed, 20 Mar 2024 14:17:31 -0400
X-MC-Unique: WUCVuD9TO4mIWROB77zXvw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4140a47f514so604795e9.0
        for <stable@vger.kernel.org>; Wed, 20 Mar 2024 11:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710958650; x=1711563450;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObIcN+ypkSzv3+S4gyvYKPSuyVaufeeCnRP/hMzldZI=;
        b=Bl2D5+J0iR/qaqD+VKEVuaDo3cxGOyZJTYHRkatw1MsqaOm8B8z2KWi2PKuqU8Um5Y
         sadLtv1rPn0GizhyNrGAPwLxU6DJStNvL0mSmut91y7duRvArpH1K6QXcr8WWvjDJ1tD
         6X7lPArg0EdK21XyPhM2vmhnB2tK6N3YPGqBSCoBP7Vo416++doZdQvribCY39ZuSwkz
         YElhAGGoVto1pAUH4dp3dSfwlQO6DRVhPy7192vzIjHmCpi2cmPyJkCNyUWaYd3GUL8L
         4Tkd3p2RRNDPskeuF1m7lez1UC4FNvC/6No83xfpsvEQx5oqFqkzMLKQIezrJKl60zbp
         q88w==
X-Forwarded-Encrypted: i=1; AJvYcCXW22oTTbXbuCE1hfUEcpTf3W4aJmc54x5nT51Zg0CEnfxH8P7fBjjnQKKig2BifnDW0PsNES33YI+gAH+s03GIKLEo18oX
X-Gm-Message-State: AOJu0YzinLJp93fDXCilR1svIUOScFCa+li3hb/mdL55tJIpeVEvH6/F
	X+Gl/3oehD+qk150uNqPRJ9094ppPlI5Y5Gvu3h1jVdM+sIPucHXOzL3hPHzNLGnPl3GXGjc2oz
	Xt1D3l9PkEDxG5+bBG9dB8fo282Y1djnp+JrFpfjpOfm2pBt/sYFYUw==
X-Received: by 2002:a05:600c:4b18:b0:414:685d:b4b0 with SMTP id i24-20020a05600c4b1800b00414685db4b0mr3883193wmp.7.1710958650064;
        Wed, 20 Mar 2024 11:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv6s3dMR21W/s0U7Wln4tUrRXxFtt0uwpQfrObw1hhf6ySqvrR4bcaIWHkD/jnHo4424QiBA==
X-Received: by 2002:a05:600c:4b18:b0:414:685d:b4b0 with SMTP id i24-20020a05600c4b1800b00414685db4b0mr3883172wmp.7.1710958649695;
        Wed, 20 Mar 2024 11:17:29 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id b2-20020a05600c4e0200b0041312c4865asm3033963wmq.2.2024.03.20.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:17:29 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Daniel Vacek <neelx@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>
Cc: Daniel Vacek <neelx@redhat.com>, stable@vger.kernel.org, Bill Peters
 <wpeters@atpco.net>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: fix affine_move_task failure case
In-Reply-To: <20240320140344.3178785-1-neelx@redhat.com>
References: <xhsmhfrwncuky.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240320140344.3178785-1-neelx@redhat.com>
Date: Wed, 20 Mar 2024 19:17:28 +0100
Message-ID: <xhsmha5msdayv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/03/24 15:03, Daniel Vacek wrote:
> Hi Valentin,
>
> On Mon, Mar 18, 2024 at 6:34=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
>> On 18/03/24 12:17, Daniel Vacek wrote:
>> > Bill Peters reported CPU hangs while offlining/onlining CPUs on s390.
>> >
>> > Analyzing the vmcore data shows `stop_one_cpu_nowait()` in `affine_mov=
e_task()`
>> > can fail when racing with off-/on-lining resulting in a deadlock waiti=
ng for
>> > the pending migration stop work completion which is never done.
>> >
>> > Fix this by correctly handling such a condition.
>> >
>>
>> IIUC the problem is that the dest_cpu and its stopper thread can be taken
>> down by take_cpu_down(), and affine_move_task() currently isn't aware of
>> that. I thought we had tested this vs hotplug, but oh well...
>
> I'm sorry, I should have provided more context in the first place. The ma=
chine
> is an LPAR with 2 CPUs and CPU 0 was onlining (hotplugging?) CPU 1. The t=
races
> show this scenario:
>
>             CPU 0                       |           CPU 1
>                                         |
>         cpuplugd task 1429              |
>  holds the `cpu_hotplug_lock`           |
>     for writing in _cpu_up+0x16a        |
> blocked on `cpuhp_state:1.done_up`      |
>      completion in __cpuhp_kick_ap+0x76 |
>                                         |
>                                         |       cpuhp/1 task 17
>                                         |supposed to complete bringup of =
the CPU
>                                         |     (`cpuhp_state:1.done_up`) i=
n cpuhp_thread_fun+0x108
>                                         |blocked on `wq_pool_attach_mutex`
>                                         |    in workqueue_online_cpu+0x9e
>                                         |
>         xfs-conv/dm-0 task 745          |
>  holds the `wq_pool_attach_mutex`       |
>     in worker_attach_to_pool+0x66        \
> blocked on `task->migration_pending->done`|
>      completion in affine_move_task+0x10a/
>
> ~~~
> crash> b 1429
> PID: 1429     TASK: 99398000          CPU: 0    COMMAND: "cpuplugd"
>  #0 [997df970] __schedule+0x34c at 3089c424
>  #1 [997df9e0] schedule+0x7e at 3089cafe
>  #2 [997dfa20] schedule_timeout+0x26e at 308a1d8e
>      [inlined] do_wait_for_common
>      [inlined] __wait_for_common
>  #3 [997dfad8] wait_for_common+0x14a at 3089d902
>     [ret call] wait_for_completion+0x1a at 3089d96a
>
>      [inlined] wait_for_ap_thread                      <<< blocked on `cp=
uhp_state:1.done_up` completion
>     [ret call] __cpuhp_kick_ap+0x76 at 300c610e
>  #4 [997dfb58] cpuhp_kick_ap+0xc4 at 300c61dc
>      [inlined] bringup_wait_for_ap
>     [ret call] bringup_cpu+0xea at 300c6402
>  #5 [997dfba8] cpuhp_invoke_callback+0xcc at 300c4f14
>  #6 [997dfc40] _cpu_up+0x16a at 300c798a               <<< holds the `cpu=
_hotplug_lock` for writing
>  #7 [997dfc98] do_cpu_up+0xc6 at 300c7b66
>  #8 [997dfcd8] cpu_subsys_online+0x58 at 305a0a00
>  #9 [997dfd28] device_online+0x9e at 30598e7e
> #10 [997dfd68] online_store+0x88 at 30598f28
> #11 [997dfda8] kernfs_fop_write+0xdc at 3040276c
> #12 [997dfdf8] vfs_write+0xa8 at 30354760
> #13 [997dfe58] ksys_write+0x62 at 30354a32
>
> crash> cpuhp_cpu_state.state cpuhp_state:a | paste - -
> [0]: 1aef424e0      state =3D CPUHP_ONLINE,               # (195)
> [1]: 1aef654e0      state =3D CPUHP_AP_WORKQUEUE_ONLINE,  # (159)
>
> crash> cpuhp_cpu_state.bringup,thread,done_up.done cpuhp_state:1 -d | pas=
te - - - -
> [1]: 1aef654e0      bringup =3D true,      thread =3D 0x81134400,      do=
ne_up.done =3D 0,  <<<
>
> crash> b 17
> PID: 17       TASK: 81134400          CPU: 1    COMMAND: "cpuhp/1"
>  #0 [81143b68] __schedule+0x34c at 3089c424
>  #1 [81143bd8] schedule+0x7e at 3089cafe
>  #2 [81143c18] schedule_preempt_disabled+0x2a at 3089cfba
>  #3 [81143c30] __mutex_lock+0x320 at 3089df60
>
>  #4 [81143cb0] workqueue_online_cpu+0x9e at 300e847e   <<< blocked on `wq=
_pool_attach_mutex`
>  #5 [81143d20] cpuhp_invoke_callback+0xcc at 300c4f14
>  #6 [81143db8] cpuhp_thread_fun+0x108 at 300c6848      <<< supposed to co=
mplete the bring-up of the CPU (`cpuhp_state:1.done_up`)
>
> crash> b 745
> PID: 745      TASK: 82359100          CPU: 0    COMMAND: "xfs-conv/dm-0"
>  #0 [8b4bfa20] __schedule+0x34c at 3089c424
>  #1 [8b4bfa90] schedule+0x7e at 3089cafe
>  #2 [8b4bfad0] schedule_timeout+0x26e at 308a1d8e
>      [inlined] do_wait_for_common
>      [inlined] __wait_for_common
>  #3 [8b4bfb88] wait_for_common+0x14a at 3089d902
>     [ret call] wait_for_completion+0x1a at 3089d96a
>
>  #4 [8b4bfc08] affine_move_task+0x10a at 300fb51a        <<< blocked on `=
task->migration_pending->done` completion
>  #5 [8b4bfd08] __set_cpus_allowed_ptr+0x12e at 300fb926
>     [ret call] set_cpus_allowed_ptr+0xa at 300fba32
>  #6 [8b4bfd78] worker_attach_to_pool+0x66 at 300e1dae    <<< holds the `w=
q_pool_attach_mutex`
>  #7 [8b4bfdc8] rescuer_thread+0x12c at 300e5bac
>
> crash> rx 8b4bfea0
>         8b4bfea0:  [863373c0:kmalloc-192]=20
>
> crash> worker.task,rescue_wq 863373c0
>   task =3D 0x82359100,
>   rescue_wq =3D 0x8aa44400,
>
> crash> list -s pool_workqueue.pool pool_workqueue.mayday_node -hO workque=
ue_struct.maydays 0x8aa44400 | paste - -
> 1fffff7f751900    pool =3D 0x1aef56a00,
>
> crash> worker_pool.attrs 0x1aef56a00
>   attrs =3D 0x80088180,
>
> crash> workqueue_attrs.cpumask[0].bits 0x80088180
>   cpumask[0].bits =3D {0x1, 0x0, ...
>
> crash> cpumask.bits __cpu_active_mask
>   bits =3D {0x1, 0x0, ...
>
> crash> cpumask.bits __cpu_online_mask
>   bits =3D {0x3, 0x0, ...
>
> crash> task_struct.migration_pending,flags 0x82359100
>     migration_pending =3D 0x8b4bfce8,
>   flags =3D 0x4208060,
>              ^ PF_KTHREAD
>
> crash> pd distribute_cpu_mask_prev:0
> per_cpu(distribute_cpu_mask_prev, 0) =3D 0
>
> crash> set_affinity_pending.refs.refs.counter,arg,stop_pending,done.done =
0x8b4bfce8 -d
>   refs.refs.counter =3D 1
>   arg =3D {
>     task =3D 0x82359100,
>     dest_cpu =3D 0,
>     pending =3D 0x8b4bfce8
>   }
>   stop_pending =3D 1,
>   done.done =3D 0,
> ~~~
>
> In other words the `set_cpus_allowed_ptr()` is called from a worker threa=
d which
> tries to migrate. The worker pool is only allowed on CPU 0 and that was s=
upposed
> to be the destination as per the stack structure. In this case I thought =
it's OK
> to leave the task on the old CPU

AFAICT if a call to set_cpus_allowed_ptr() ends up in affine_move_task()
and down to the stopper call, that means the task isn't allowed on its
current CPU and needs to be moved.

> and the Bill's testing scenario was successful
> with the proposed patch. IIUC, it's exercising the hotplug due to load-ba=
lancing.
>
> This was on RHEL 8.8.z kernel. I see upstream changed a bit so I'm not su=
re it's
> still reproducible. Also, I'm not sure why this only happens on s390 and =
not on
> x86. I imagine the CPU hotplug slightly differs? Anyways this seems to be=
 timing
> sensitive and the timing will differ greatly for sure.
>

Thanks for the extra context!

Double checking what I wrote before, I forgot RCU considers preempt-off
sections as read-side critical sections. __set_cpus_allowed_ptr() already
has preemption disabled all the way from reading the cpu_active_mask to the
stop_one_cpu_nowait() call via task_rq_lock() + preempt_disable().

IOW we have:

__set_cpus_allowed_ptr()
  task_rq_lock() <-- PREEMPT OFF
  __set_cpus_allowed_ptr_locked()
    cpu_valid_mask =3D cpu_active_mask;
    dest_cpu =3D cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask);
    affine_move_task()
      preempt_disable();
      task_rq_unlock();
      stop_one_cpu_nowait(); <-- preemption still OFF

And, considering:

sched_cpu_deactivate()
  set_cpu_active(cpu, false);
  synchronize_rcu();

Then, if __set_cpus_allowed_ptr() observes a CPU as being in the
cpu_active_mask and uses that one as a destination CPU, said CPU cannot
reach CPUHP_TEARDOWN_CPU:take_cpu_down() and park the stopper thread
because its hotplug machinery will wait on the synchronize_rcu() in
CPUHP_AP_ACTIVE:sched_cpu_deactivate().

So "in theory", this shouldn't happen upstream.


