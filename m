Return-Path: <stable+bounces-28504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E126B881758
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 19:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B11F285236
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FA485281;
	Wed, 20 Mar 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UI4sHZjF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72182CA6
	for <stable@vger.kernel.org>; Wed, 20 Mar 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959589; cv=none; b=sqeva2ibKfQrvvekgkI0xwyvJmQ9adw+2jmnevJneC0vK/N8o43eBSVGFfDArp2lS9EJA8NYOhh6ydRNb78of+Yu4IjIz7XWAj3/kYncnG35GVLICOazjNFn8KBNEwwX59bUxvi6TiT164fU4fboc91rV0VvqQU5DzQ0DlBpFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959589; c=relaxed/simple;
	bh=7Rz+Amqe6rCNwDS6/E1qo6ysulXjER0jvHKpk5G/3xE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n7F+luAnRRrojKQSIbyhzKuRcShLZwGJ564yMRC4+KgNT2h6IFAbumN1SWwIDHvbYO1GkdC8w2SNYUNw8D261XJLylGGWPhmR7RigRD/lZ0GeQ9RxP3yQacxHTXA3Dka8TnRtBYZwe3lyDz8aISkVq7tJ4EycYfqyjZlp0VuOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UI4sHZjF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710959587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaznzHgSKSh5WhIwu2eWg4pDU6QPJDx8JYNKENnQESQ=;
	b=UI4sHZjFwt73KT9UVhNdHJBtj94p8V9NrBuyi/8NH8F0TU4GBBB7Jp47VHwsjYVKtzGqSN
	uYYej+bLbeAK6gHDSuXdfdcDDmLRYuXoBPjTTBGSYzPTcjoicXfkQsOolJNB+1RbzFAp83
	nPK6yuk5hHjwa/KvL5FkhC38ziUU0I8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-u9dX8aS2Md-GEwiaRWfECQ-1; Wed, 20 Mar 2024 14:33:03 -0400
X-MC-Unique: u9dX8aS2Md-GEwiaRWfECQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-430b673a96eso1722061cf.2
        for <stable@vger.kernel.org>; Wed, 20 Mar 2024 11:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710959583; x=1711564383;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaznzHgSKSh5WhIwu2eWg4pDU6QPJDx8JYNKENnQESQ=;
        b=dmcg240rFUzQqEe3nyD8mUk/jwckeWYlWjRilWhsRG9CT74N9q4fksDL4KCuMaxh04
         yrgspT8nxsCWah8bjE4DkgcWTncCI0mLp7Sitw09U1pcCPo92dIejJ1TI7pLzu20krWS
         O/yHbGn4sluPMinJdq9L/gfd0k8VeYBH5gde4h7O174w66e3PzIxGzg0c1SXsyoY00yf
         02VzRiBrOv9FnhPMxWWqfdAvtipFdUOcNi84kfFlyX/YSkkS8uzepY4xMwdutr2NbHUy
         WCR3RKWsolu3HuPdtFKHT+5Qazh84yYNAT8Obj9uogzFbJR9OwLeJN7BwOVzaUaxFiDR
         //Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXSdl/7tEg2mjn61wgAgGNn5fU964BkpgAud+K5k2MovSTf0PSp8t/vPUS+N5xzacnDi4MeseqpZuMWr5Q1TDvoe6uav/hM
X-Gm-Message-State: AOJu0YxYkXY0ZFVv7BdknC/9f71YlrbGoT/85ReLWq1zx+9wGFrEFAWd
	QrzGSinjRvq1ACAvBzQ2aF4kpMmh/brUrPzse/8NwBYPLsqHUj9h6EET047BlPCQa4yH6IoPQa9
	JRP17u1PiWVbkAy9Tha3vxNN2DZkpBzSyD1jxspLf5HUe7UtlIatycg==
X-Received: by 2002:ac8:5d8c:0:b0:430:eea1:e230 with SMTP id d12-20020ac85d8c000000b00430eea1e230mr3232027qtx.67.1710959583075;
        Wed, 20 Mar 2024 11:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ06EW32KFL8AdJbOSWdjha8WKxG4mE7JIX48T5HXf/M9BKJ0nRUc2NP8q1elbXKF7qzPmNw==
X-Received: by 2002:ac8:5d8c:0:b0:430:eea1:e230 with SMTP id d12-20020ac85d8c000000b00430eea1e230mr3231995qtx.67.1710959582682;
        Wed, 20 Mar 2024 11:33:02 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id fw6-20020a05622a4a8600b0042f21b795d0sm3661749qtb.45.2024.03.20.11.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:33:02 -0700 (PDT)
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
In-Reply-To: <xhsmha5msdayv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <xhsmhfrwncuky.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240320140344.3178785-1-neelx@redhat.com>
 <xhsmha5msdayv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Wed, 20 Mar 2024 19:32:52 +0100
Message-ID: <xhsmh4jd0da97.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/03/24 19:17, Valentin Schneider wrote:
> On 20/03/24 15:03, Daniel Vacek wrote:
>> Hi Valentin,
>>
>> On Mon, Mar 18, 2024 at 6:34=E2=80=AFPM Valentin Schneider <vschneid@red=
hat.com> wrote:
>>> On 18/03/24 12:17, Daniel Vacek wrote:
>>> > Bill Peters reported CPU hangs while offlining/onlining CPUs on s390.
>>> >
>>> > Analyzing the vmcore data shows `stop_one_cpu_nowait()` in `affine_mo=
ve_task()`
>>> > can fail when racing with off-/on-lining resulting in a deadlock wait=
ing for
>>> > the pending migration stop work completion which is never done.
>>> >
>>> > Fix this by correctly handling such a condition.
>>> >
>>>
>>> IIUC the problem is that the dest_cpu and its stopper thread can be tak=
en
>>> down by take_cpu_down(), and affine_move_task() currently isn't aware of
>>> that. I thought we had tested this vs hotplug, but oh well...
>>
>> I'm sorry, I should have provided more context in the first place. The m=
achine
>> is an LPAR with 2 CPUs and CPU 0 was onlining (hotplugging?) CPU 1. The =
traces
>> show this scenario:
>>
>>             CPU 0                       |           CPU 1
>>                                         |
>>         cpuplugd task 1429              |
>>  holds the `cpu_hotplug_lock`           |
>>     for writing in _cpu_up+0x16a        |
>> blocked on `cpuhp_state:1.done_up`      |
>>      completion in __cpuhp_kick_ap+0x76 |
>>                                         |
>>                                         |       cpuhp/1 task 17
>>                                         |supposed to complete bringup of=
 the CPU
>>                                         |     (`cpuhp_state:1.done_up`) =
in cpuhp_thread_fun+0x108
>>                                         |blocked on `wq_pool_attach_mute=
x`
>>                                         |    in workqueue_online_cpu+0x9e
>>                                         |
>>         xfs-conv/dm-0 task 745          |
>>  holds the `wq_pool_attach_mutex`       |
>>     in worker_attach_to_pool+0x66        \
>> blocked on `task->migration_pending->done`|
>>      completion in affine_move_task+0x10a/
>>
>> ~~~
>> crash> b 1429
>> PID: 1429     TASK: 99398000          CPU: 0    COMMAND: "cpuplugd"
>>  #0 [997df970] __schedule+0x34c at 3089c424
>>  #1 [997df9e0] schedule+0x7e at 3089cafe
>>  #2 [997dfa20] schedule_timeout+0x26e at 308a1d8e
>>      [inlined] do_wait_for_common
>>      [inlined] __wait_for_common
>>  #3 [997dfad8] wait_for_common+0x14a at 3089d902
>>     [ret call] wait_for_completion+0x1a at 3089d96a
>>
>>      [inlined] wait_for_ap_thread                      <<< blocked on `c=
puhp_state:1.done_up` completion
>>     [ret call] __cpuhp_kick_ap+0x76 at 300c610e
>>  #4 [997dfb58] cpuhp_kick_ap+0xc4 at 300c61dc
>>      [inlined] bringup_wait_for_ap
>>     [ret call] bringup_cpu+0xea at 300c6402
>>  #5 [997dfba8] cpuhp_invoke_callback+0xcc at 300c4f14
>>  #6 [997dfc40] _cpu_up+0x16a at 300c798a               <<< holds the `cp=
u_hotplug_lock` for writing
>>  #7 [997dfc98] do_cpu_up+0xc6 at 300c7b66
>>  #8 [997dfcd8] cpu_subsys_online+0x58 at 305a0a00
>>  #9 [997dfd28] device_online+0x9e at 30598e7e
>> #10 [997dfd68] online_store+0x88 at 30598f28
>> #11 [997dfda8] kernfs_fop_write+0xdc at 3040276c
>> #12 [997dfdf8] vfs_write+0xa8 at 30354760
>> #13 [997dfe58] ksys_write+0x62 at 30354a32
>>
>> crash> cpuhp_cpu_state.state cpuhp_state:a | paste - -
>> [0]: 1aef424e0      state =3D CPUHP_ONLINE,               # (195)
>> [1]: 1aef654e0      state =3D CPUHP_AP_WORKQUEUE_ONLINE,  # (159)
>>
>> crash> cpuhp_cpu_state.bringup,thread,done_up.done cpuhp_state:1 -d | pa=
ste - - - -
>> [1]: 1aef654e0      bringup =3D true,      thread =3D 0x81134400,      d=
one_up.done =3D 0,  <<<
>>
>> crash> b 17
>> PID: 17       TASK: 81134400          CPU: 1    COMMAND: "cpuhp/1"
>>  #0 [81143b68] __schedule+0x34c at 3089c424
>>  #1 [81143bd8] schedule+0x7e at 3089cafe
>>  #2 [81143c18] schedule_preempt_disabled+0x2a at 3089cfba
>>  #3 [81143c30] __mutex_lock+0x320 at 3089df60
>>
>>  #4 [81143cb0] workqueue_online_cpu+0x9e at 300e847e   <<< blocked on `w=
q_pool_attach_mutex`
>>  #5 [81143d20] cpuhp_invoke_callback+0xcc at 300c4f14
>>  #6 [81143db8] cpuhp_thread_fun+0x108 at 300c6848      <<< supposed to c=
omplete the bring-up of the CPU (`cpuhp_state:1.done_up`)
>>
>> crash> b 745
>> PID: 745      TASK: 82359100          CPU: 0    COMMAND: "xfs-conv/dm-0"
>>  #0 [8b4bfa20] __schedule+0x34c at 3089c424
>>  #1 [8b4bfa90] schedule+0x7e at 3089cafe
>>  #2 [8b4bfad0] schedule_timeout+0x26e at 308a1d8e
>>      [inlined] do_wait_for_common
>>      [inlined] __wait_for_common
>>  #3 [8b4bfb88] wait_for_common+0x14a at 3089d902
>>     [ret call] wait_for_completion+0x1a at 3089d96a
>>
>>  #4 [8b4bfc08] affine_move_task+0x10a at 300fb51a        <<< blocked on =
`task->migration_pending->done` completion
>>  #5 [8b4bfd08] __set_cpus_allowed_ptr+0x12e at 300fb926
>>     [ret call] set_cpus_allowed_ptr+0xa at 300fba32
>>  #6 [8b4bfd78] worker_attach_to_pool+0x66 at 300e1dae    <<< holds the `=
wq_pool_attach_mutex`
>>  #7 [8b4bfdc8] rescuer_thread+0x12c at 300e5bac
>>
>> crash> rx 8b4bfea0
>>         8b4bfea0:  [863373c0:kmalloc-192]=20
>>
>> crash> worker.task,rescue_wq 863373c0
>>   task =3D 0x82359100,
>>   rescue_wq =3D 0x8aa44400,
>>
>> crash> list -s pool_workqueue.pool pool_workqueue.mayday_node -hO workqu=
eue_struct.maydays 0x8aa44400 | paste - -
>> 1fffff7f751900    pool =3D 0x1aef56a00,
>>
>> crash> worker_pool.attrs 0x1aef56a00
>>   attrs =3D 0x80088180,
>>
>> crash> workqueue_attrs.cpumask[0].bits 0x80088180
>>   cpumask[0].bits =3D {0x1, 0x0, ...
>>
>> crash> cpumask.bits __cpu_active_mask
>>   bits =3D {0x1, 0x0, ...
>>
>> crash> cpumask.bits __cpu_online_mask
>>   bits =3D {0x3, 0x0, ...
>>
>> crash> task_struct.migration_pending,flags 0x82359100
>>     migration_pending =3D 0x8b4bfce8,
>>   flags =3D 0x4208060,
>>              ^ PF_KTHREAD
>>
>> crash> pd distribute_cpu_mask_prev:0
>> per_cpu(distribute_cpu_mask_prev, 0) =3D 0
>>
>> crash> set_affinity_pending.refs.refs.counter,arg,stop_pending,done.done=
 0x8b4bfce8 -d
>>   refs.refs.counter =3D 1
>>   arg =3D {
>>     task =3D 0x82359100,
>>     dest_cpu =3D 0,
>>     pending =3D 0x8b4bfce8
>>   }
>>   stop_pending =3D 1,
>>   done.done =3D 0,
>> ~~~
>>
>> In other words the `set_cpus_allowed_ptr()` is called from a worker thre=
ad which
>> tries to migrate. The worker pool is only allowed on CPU 0 and that was =
supposed
>> to be the destination as per the stack structure. In this case I thought=
 it's OK
>> to leave the task on the old CPU
>
> AFAICT if a call to set_cpus_allowed_ptr() ends up in affine_move_task()
> and down to the stopper call, that means the task isn't allowed on its
> current CPU and needs to be moved.
>
>> and the Bill's testing scenario was successful
>> with the proposed patch. IIUC, it's exercising the hotplug due to load-b=
alancing.
>>
>> This was on RHEL 8.8.z kernel. I see upstream changed a bit so I'm not s=
ure it's
>> still reproducible. Also, I'm not sure why this only happens on s390 and=
 not on
>> x86. I imagine the CPU hotplug slightly differs? Anyways this seems to b=
e timing
>> sensitive and the timing will differ greatly for sure.
>>
>
> Thanks for the extra context!
>
> Double checking what I wrote before, I forgot RCU considers preempt-off
> sections as read-side critical sections. __set_cpus_allowed_ptr() already
> has preemption disabled all the way from reading the cpu_active_mask to t=
he
> stop_one_cpu_nowait() call via task_rq_lock() + preempt_disable().
>
> IOW we have:
>
> __set_cpus_allowed_ptr()
>   task_rq_lock() <-- PREEMPT OFF
>   __set_cpus_allowed_ptr_locked()
>     cpu_valid_mask =3D cpu_active_mask;
>     dest_cpu =3D cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask=
);
>     affine_move_task()
>       preempt_disable();
>       task_rq_unlock();
>       stop_one_cpu_nowait(); <-- preemption still OFF
>
> And, considering:
>
> sched_cpu_deactivate()
>   set_cpu_active(cpu, false);
>   synchronize_rcu();
>
> Then, if __set_cpus_allowed_ptr() observes a CPU as being in the
> cpu_active_mask and uses that one as a destination CPU, said CPU cannot
> reach CPUHP_TEARDOWN_CPU:take_cpu_down() and park the stopper thread
> because its hotplug machinery will wait on the synchronize_rcu() in
> CPUHP_AP_ACTIVE:sched_cpu_deactivate().
>
> So "in theory", this shouldn't happen upstream.

Eh nevermind, in your stacktrace the relevant task is a rescuer thread
which is a kthread, so the cpu_valid_mask in use there is
cpu_online_mask, not cpu_valid_mask... Back to reading code :-)


