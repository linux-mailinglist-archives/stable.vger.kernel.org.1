Return-Path: <stable+bounces-3133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5532C7FD2D1
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 10:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49485B20E95
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 09:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A7115AE8;
	Wed, 29 Nov 2023 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWBvSiGx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC28D1707;
	Wed, 29 Nov 2023 01:33:49 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b4c2ef584so14326195e9.3;
        Wed, 29 Nov 2023 01:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701250428; x=1701855228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GfEWbAa5eVH99NqtMtI/lEIzIzx8gV15mC23gb91+Ss=;
        b=jWBvSiGxG2mOdmJxOWuE5UVz7wO5fgdJHifyBl40ZcqFdOsLayJxw1QJvFYbHcMcSR
         DXytcHxMcMt/AlQoKBFwUhUzIdEh3SKtOZMszTSWAKJxBIdf35u9QqGYzsR0rOWFA/aq
         bIp3AXEkuFtZ4VW4xRrhZUwZ+g7nFzMJZi0CmEM8Cy+T9a6nCuA40dImAawO8g2vkY7l
         NKRWWoLkqG7eNFQM+37IQhQBDkgkUFb2bBJaYctTQbm5OTtB0sUaSOmCHGpQHSSm87vr
         3WBDc2uzWxqF0ZTpEtk0Xy0YPBalWq95TypA6kgpA074s8M2CI9fzsBmSJgDhD/RSkhg
         XQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701250428; x=1701855228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfEWbAa5eVH99NqtMtI/lEIzIzx8gV15mC23gb91+Ss=;
        b=IDPWoK/t6hVwS3GPCNyzrFsEc0Dshtpx8ztM+NoxGNFCcbuwb1R8crPhatccdwmTRg
         Iczrzfu5DR26tX668+AkhCKMj/byDr9jRtNXXyKlC1562qsIu5R0woR4xRmUZ5QPLoEW
         T+ayV87qegA/XshkP//1MkQpYKvMj1hvx1u40GwfarwcquP2g24x2CCTL/V01wq56h7q
         XG55pk81cQwXdqZsXO93C2stLMSrFuKC01ewPD+69hA6sF8IVwqhJJw2CjDjYch3jz6K
         h6wvaSy3PXJFxLuwNO4MsZDq62Vl3w/FjbjlgYUEPK10pZFombfSBykS8cx8NEERoUFs
         GBSQ==
X-Gm-Message-State: AOJu0YxC99SSyv2zXSzQtTMMPZ2tV+Ym2M2fK62O/uWAYTgxbYLEneos
	AP/1h8ZKIXm3kQ+EQ2aVn/HhYgZ/UeDgDVmwgiKLRJUlsUc=
X-Google-Smtp-Source: AGHT+IG6DBV1nd5pkKa2Z7HbvzqaXy0qXVheqMRHQzkD6hE4cS72nKN61DwkGGNypsksp8lWTsA8LGzomO3xhciSIKk=
X-Received: by 2002:adf:f985:0:b0:332:c9be:d9bd with SMTP id
 f5-20020adff985000000b00332c9bed9bdmr11901691wrr.45.1701250427844; Wed, 29
 Nov 2023 01:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhengyuan Liu <liuzhengyuang521@gmail.com>
Date: Wed, 29 Nov 2023 17:33:33 +0800
Message-ID: <CAOOPZo5oFZAs3sMcEgmTEZy3ef4jg630xL3mUBx3bvV6tQcdQg@mail.gmail.com>
Subject: Question about perf sibling_list race problem
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-perf-users@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?6IOh5rW3?= <huhai@kylinos.cn>, =?UTF-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>, 
	huangjinhui@kylinos.cn, Zhengyuan Liu <liuzhengyuan@kylinos.cn>, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, all

We are encountering a perf related soft lockup as shown below:

[25023823.265138] watchdog: BUG: soft lockup - CPU#29 stuck for 45s!
[YD:3284696]
[25023823.275772]  net_failover virtio_scsi failover
[25023823.276750] CPU: 29 PID: 3284696 Comm: YD Kdump: loaded Not
tainted 4.19.90-23.18.v2101.ky10.aarch64 #1
[25023823.278257] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06=
/2015
[25023823.279475] pstate: 80400005 (Nzcv daif +PAN -UAO)
[25023823.280516] pc : perf_iterate_sb+0x1b8/0x1f0
[25023823.281530] lr : perf_iterate_sb+0x18c/0x1f0
[25023823.282529] sp : ffff801f282efbf0
[25023823.283446] x29: ffff801f282efbf0 x28: ffff801f207a8b80
[25023823.284551] x27: 0000000000000000 x26: ffff801f99b355e8
[25023823.285674] x25: 0000000000000000 x24: ffff8019e2fbd800
[25023823.286770] x23: ffff0000093f0018 x22: ffff801f282efc40
[25023823.287864] x21: ffff000008255f60 x20: ffff801ffdf58e80
[25023823.288964] x19: ffff8019f1c27800 x18: 0000000000000000
[25023823.290060] x17: 0000000000000000 x16: 0000000000000000
[25023823.291164] x15: 0400000000000000 x14: 0000000000000000
[25023823.292266] x13: ffff000008c6e340 x12: 0000000000000002
[25023823.293381] x11: ffff000008c6e318 x10: 00000019e5feff20
[25023823.294486] x9 : ffff8019fb49c000 x8 : 0058e6fd335b260e
[25023823.295597] x7 : 0000000100321ed8 x6 : ffff00003d083780
[25023823.296715] x5 : 00ffffffffffffff x4 : 0000801ff4ae0000
[25023823.297860] x3 : ffff801ffdf64cc0 x2 : ffff000009858758
[25023823.298977] x1 : 0000000000000000 x0 : ffff8019e2fbd800
[25023823.300090] Call trace:
[25023823.300962]  perf_iterate_sb+0x1b8/0x1f0
[25023823.301961]  perf_event_task+0x78/0x80
[25023823.302946]  perf_event_exit_task+0xa4/0xb0
[25023823.303978]  do_exit+0x38c/0x5d0
[25023823.304932]  do_group_exit+0x3c/0xd8
[25023823.305904]  get_signal+0x12c/0x740
[25023823.306859]  do_signal+0x158/0x260
[25023823.307795]  do_notify_resume+0xd8/0x358
[25023823.308781]  work_pending+0x8/0x10

We got a vmcore by enable panic_on_soft_lockup, from the vmcore we
found the perf_event accessed through
perf_iterate_sb -> perf_iterate_sb_cpu -> event_filter_match ->
pmu_filter_match -> for_each_sibling_event
had been removed:

#define for_each_sibling_event(sibling, event)                  \
        if ((event)->group_leader =3D=3D (event))                   \
                list_for_each_entry((sibling), &(event)->sibling_list,
sibling_list)

#define list_for_each_entry(pos, head, member)                          \
    for (pos =3D __container_of((head)->next, pos, member);               \
         &pos->member !=3D (head);                                        \
         pos =3D __container_of(pos->member.next, pos, member))

crash> struct perf_event ffff8019e2fbd800
struct perf_event {
  event_entry =3D {
    next =3D 0xffff8019f1c27800,
    prev =3D 0xdead000000000200
  },
  ...
  state =3D PERF_EVENT_STATE_DEAD,
  ...
}

By the way, we also found another process which is deleting sibling_list:

crash> bt 3284533
PID: 3284533  TASK: ffff801f901ae880  CPU: 16  COMMAND: "YD"
 #0 [ffff801f8cd977f0] __switch_to at ffff000008088ba4
 #1 [ffff801f8cd97810] __schedule at ffff000008bf10c4
 #2 [ffff801f8cd97890] schedule at ffff000008bf17b0
 #3 [ffff801f8cd978a0] schedule_timeout at ffff000008bf5b10
 #4 [ffff801f8cd97960] wait_for_common at ffff000008bf2530
 #5 [ffff801f8cd979f0] wait_for_completion at ffff000008bf2644
 #6 [ffff801f8cd97a10] __wait_rcu_gp at ffff000008171c00
 #7 [ffff801f8cd97a80] synchronize_sched at ffff000008179da8
 #8 [ffff801f8cd97ad0] perf_trace_event_unreg at ffff000008216d50
 #9 [ffff801f8cd97b00] perf_trace_destroy at ffff000008217148
#10 [ffff801f8cd97b20] tp_perf_event_destroy at ffff000008256ae0
#11 [ffff801f8cd97b30] _free_event at ffff00000825f21c
#12 [ffff801f8cd97b70] put_event at ffff00000825faf0
#13 [ffff801f8cd97b80] perf_event_release_kernel at ffff00000825fcb8
#14 [ffff801f8cd97be0] perf_release at ffff00000825fdbc
#15 [ffff801f8cd97bf0] __fput at ffff00000832f0b8
#16 [ffff801f8cd97c30] ____fput at ffff00000832f28c
#17 [ffff801f8cd97c50] task_work_run at ffff00000810f8c8
#18 [ffff801f8cd97c90] do_exit at ffff0000080ef458
#19 [ffff801f8cd97cf0] do_group_exit at ffff0000080ef738
#20 [ffff801f8cd97d20] get_signal at ffff0000080fdde0
#21 [ffff801f8cd97d90] do_signal at ffff00000808e488
#22 [ffff801f8cd97e80] do_notify_resume at ffff00000808e7f4
#23 [ffff801f8cd97ff0] work_pending at ffff000008083f60


So it's reasonable to suspect that perf_iterate_sb is traversing
sibling_list while another
process is deleting it which eventually caused for_each_sibling_event
to endless loop and thus soft lockup.

The race scenario thus could be this:

CPU 29:                                   CPU 16:
                                          perf_event_release_kernel
                                      --> mutex_lock(&ctx->mutex)
                                         --> perf_remove_from_context
                                           --> perf_group_detach(event);
for_each_sibling_event()                              -->
list_del_init(&event->sibling_list)

As commit f3c0eba287049=EF=BC=88=E2=80=9Cperf: Add a few assertions=E2=80=
=9D=EF=BC=89said:
=E2=80=9CNotable for_each_sibling_event() relies on exclusion from
modification. This would normally be holding either ctx->lock or
ctx->mutex, however due to how things are constructed disabling IRQs
is a valid and sufficient substitute for ctx->lock.=E2=80=9D, we think it's
necessary to hold ctx ->mutex, but currently LTS such as 4.19,5.4,5.10,
and 6.1 all does not do so:

perf_event_task
--> perf_iterate_sb
   --> perf_iterate_sb_cpu
      --> event_filter_match
          --> pmu_filter_match
             --> for_each_sibling_event

commit bd27568117664=EF=BC=88=E2=80=9Cperf: Rewrite core context handling=
=E2=80=9D=EF=BC=89had removed
the pmu_filter_match operation, so it may be a temporary workaround
for this issue.

But it's necessary to confirm if there is a race problem between
sibling_list, and if it is, how
to fix currently LTS branches.

Thanks in advance.

