Return-Path: <stable+bounces-145840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5910EABF6BB
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDB54A779E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F48C1607A4;
	Wed, 21 May 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="W15AYtGr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2D15381A
	for <stable@vger.kernel.org>; Wed, 21 May 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835774; cv=none; b=GKDxp1FwFtSagVg9Z2/VqZjbDWScqhN3POp+bnNxwYhLOwDX2egqe25BxtWgvGEwiopYyy7xPsNaBlVAYCtt6t7vjTSVKVd5afndb//2dVwzB05WxW+ZHpEIqxoe35z4MgpG3VbE9RXIOLSoTeiyL7PomhA5pCeQ7lzLpYDhX98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835774; c=relaxed/simple;
	bh=/S1MxmT9sT0m7/j11IqjHXioF1uvB9kbHUQngA0fYtA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=U9d/RhpDY+OivT2Ne1wgBkpQsgBpiUAUh6UDkOja1DzMCXtGR0HhKhUFkSsm0TiGbhvgZQODv+TfRUEtx46WtGzVNQVUEG76xFyMXyLSSoaG1G6tw2rNcqhBb3teYp+hORlZnwxizYLO0HKpCcwfjRO4vbDCEarYpaejzPsX14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=W15AYtGr; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5fb55d8671dso1372903a12.3
        for <stable@vger.kernel.org>; Wed, 21 May 2025 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1747835769; x=1748440569; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nKSoyAUKgqat/8XR3iGVkGia9liEQ9m+SYFRFLGwgb8=;
        b=W15AYtGrCs4E9GtL87FcyMvvwUa7XsrNd72O1hzD09l5yjUhgzRFd8GCHxvIuTtHKw
         O6CNFqAUo6qvuAP2Vys8c+ZOI1FZ/WaIJpjoIRHUN8p8DyT7/SMbqz1z37c7HueCkRyq
         bzwr5AYbct7NrrLEoHFcmPMQeHNyF/5bOtbMRLWf19kE7v3vzs0paJGYrS1Ne2SlBLOr
         Hu7dbbFbWPsb5VZPD4s3tLLwYYSZOL60jBLT5lAr40az6VUjBtk9JcKhSFU9bGz2B8Q3
         HUqEfAwfiUsMQJc1w9fGVfIB0D6gLVisGxul9KXc9+pHkcgfht/BqQrM18XEqfvftDjo
         W//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747835769; x=1748440569;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKSoyAUKgqat/8XR3iGVkGia9liEQ9m+SYFRFLGwgb8=;
        b=u2SGOSehjimjlQ8T53u6QZSWrnGBLh0OzILUdo43bM4YYzukhNz1daVrk5zhkE2mni
         tQ/GPGEDchsByVQ4eLcwqzolX90xW2SDbmFt3W5MVU92b90qXHcy34VKcDPTYhvQ36a0
         MUqZQFZSU39exGPWySTsXJVfl2+rYK7QEE4qGaDnj6wF41ZRDYql7G5947DaaAzcsJT3
         oRZuZhIbHlm8Z4FoZBR0g/mEE/MCW5uzVCADdcp3PlFJUETzuFsUbKCUOc2WmGK7Z929
         gvC2fY9cBzUd8TDNtzQAUiiNtX7za0ksB6rkA+YrRSnwSG3uE7C79X1vDOzT0yZcrpqi
         GeEA==
X-Gm-Message-State: AOJu0YyZdpxIIBIUkq91gkwir/N8eE6j/GyBsi8O+XjMuXtrRVvCf1Vj
	uUnft6LQ3wKsx37gw+cG7gWSsx0CxiFZvRza3ROd/0/P1zAa2HzjFKG8eJwX7gAxahYc75fWePK
	xZ8i3Tsunh8qeIt5uJZ6U3cnMbLur96XSRBu45SbwRX30buVzfLXZE6EkmmYf
X-Gm-Gg: ASbGnctUAol4RDtgKFG5gnvQxMxgFVX81brAw6cxjqqXNZrSrPooe9VhlSmrZ/G6LGl
	nMQ9vjMEvOOyb+sN2IUhapE1MAli87N0N0Qzo0VSwcfKlrxQaelAxzecLKg8yVi2JSBjuxd93yZ
	xHa7Wa5hz6t6uCghl2hJSG7oDlzxX5TosF2WRGGvW+BB+gZnCCr6Gh1Pu6D71yGNiftA==
X-Google-Smtp-Source: AGHT+IFAcO8LLoLNWAaokiS71wc4zumkJhkfQuBwxXuWwS05EJIGBmvmfcaEVmVz84kCIO+zduZzMlX9hcUXzKDBQPg=
X-Received: by 2002:a05:6402:1ec4:b0:5fd:1a46:a7d7 with SMTP id
 4fb4d7f45d1cf-6008a7aa0damr7716949a12.3.1747835769085; Wed, 21 May 2025
 06:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 21 May 2025 15:55:57 +0200
X-Gm-Features: AX0GCFstSPGX8tuocdIrdLJAlJh7vEpUB_8JqQO95CJkePzTArGecBnPCz3-yDc
Message-ID: <CAMGffEkv3+MkNT5a9Pp7-v+RX4j+nci5HA7dQsEsm3Ae4iAjgQ@mail.gmail.com>
Subject: Random Crashes in Linux Kernel 6.1.139 on Intel Cascadelake/Icelake
 Due to ITS Mitigation
To: stable <stable@vger.kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Folks,

Bug Description:

When running Linux kernel version 6.1.139 on Intel Cascadelake/Icelake
processors, systems experience random crashes related to mitigation.
These crashes do not occur when booted with
indirect_target_selection=off or when using kernel version 6.12.29.
The crashes manifest as page faults leading to a kernel panic.

System Details:

Kernel Version: 6.1.139 or 6.1.118 with the ITS migration patches from 6.1.139
Hardware: Intel Cascadelake/Icelake

Steps to Reproduce:

Boot a system with Intel Cascadelake/Icelake processors using Linux
kernel 6.1.139.
Allow the system to run standard operations; crashes appear randomly.
Notice that crashes do not occur when booted with
indirect_target_selection=off. also works fine on Intel servers with
Broadwell or Skylake CPU

linux kernel 6.1.139 crash due to its mitigation on Intel
Cascadelake/Icelake, the crash seems random, eg I've seen crashing
like below:
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.207823] BUG:
unable to handle page fault for address: ff1ac0d89d45f8c0
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.212762] #PF:
supervisor write access in kernel mode
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.217741] #PF:
error_code(0x0003) - permissions violation
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.222708] PGD
5341c01067 P4D 5341c02067 PUD 211835063 PMD 21d44f063 PTE
800000021d45f161
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.227831]
Oops: 0003 [#1] PREEMPT SMP
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.233002] CPU:
12 PID: 0 Comm: swapper/12 Kdump: loaded Tainted: G           O
6.1.139-pserver
#6.1.139-1+feature+linux+6.1.y+20250521.1015+45a526cf~deb12
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.244731]
Hardware name: Dell Inc. PowerEdge R650/0PYXKY, BIOS 1.9.2 11/17/2022
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.250583] RIP:
0010:__build_skb_around+0x79/0xc0
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.256492]
Code: 00 00 00 00 89 85 bc 00 00 00 66 89 95 b6 00 00 00 66 89 8d b2
00 00 00 65 8b 15 c2 5b 90 48 48 8d 34 03 66 89 95 a0 00 00 00 <48> c7
06 00 00 00 00 48 c7 46 08 00 00 00 00 48 c7 46 10 00 00 00
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.269200] RSP:
0018:ff409de44cdf4d28 EFLAGS: 00010206
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.275492] RAX:
00000000000006c0 RBX: ff1ac0d89d45f200 RCX: 00000000ffffffff
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.281987] RDX:
000000000000000c RSI: ff1ac0d89d45f8c0 RDI: ff1ac0d7886a8000
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.288943] RBP:
ff1ac0d7886a8000 R08: 0000000000000006 R09: ff1ac11708ffc0b8
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.295838] R10:
ffffffffb86060c0 R11: ff1ac0d8c02d7000 R12: ff1ac0d89d45f200
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.302796] R13:
ff1ac0d839a20000 R14: ff1ac0d89d1241d0 R15: 0000000000000000
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.309496] FS:
0000000000000000(0000) GS:ff1ac116fef80000(0000)
knlGS:0000000000000000
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.315978] CS:
0010 DS: 0000 ES: 0000 CR0: 0000000080050033
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.322411] CR2:
ff1ac0d89d45f8c0 CR3: 000000534060a005 CR4: 0000000000771ee0
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.329030] DR0:
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.336289] DR3:
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.343624] PKRU: 55555554
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.350175] Call Trace:
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.356777]  <IRQ>
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.363585]
build_skb+0x41/0xe0
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.370198]
mlx5e_skb_from_cqe_nonlinear+0x20a/0x3b0 [mlx5_core]
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.377107]
mlx5i_handle_rx_cqe+0x311/0x450 [mlx5_core]
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.384273]
mlx5e_poll_rx_cq+0x437/0x450 [mlx5_core]
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.392409]
mlx5e_napi_poll+0xe4/0x710 [mlx5_core]
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.399293]
__napi_poll+0x28/0x160
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.406107]
net_rx_action+0x29c/0x2f0
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.412790]
handle_softirqs+0xcf/0x270
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.419895]
irq_exit_rcu+0x85/0xb0
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.427245]
common_interrupt+0x82/0xa0
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.434181]  </IRQ>
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.442032]  <TASK>
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.448577]
asm_common_interrupt+0x22/0x40
May 21 13:03:00 ps404a-62.stg.profitbricks.net >>> [  241.455431] RIP:
0010:cpuidle_enter_state+0xd8/0x420
and below:
kern.alert: May 21 05:59:31 ps404a-1 kernel: [   35.775609] #PF:
error_code(0x0003) - permissions violation
kern.info: May 21 05:59:31 ps404a-1 kernel: [   35.775740] PGD
251ac01067 P4D 251ac01067 PUD 1b17dd063 PMD 6098b1f063 PTE
8000000153faf161
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.775910] Oops:
0003 [#1] PREEMPT SMP
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.776036] CPU: 54
PID: 3109 Comm: (spawn) Tainted: G           O       6.1.118-pserver
#6.1.118-9+develop+20250520.1233+48c89f78~deb
12
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.776218] Hardware
name: RAUSCH CoreVPS-Gen2-STG/X11DDW-NT, BIOS 3.3 02/21/2020
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.776382] RIP:
0010:__tlb_remove_page_size+0x64/0x90
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.776515] Code: c3
cc cc cc cc 83 7f 1c 13 74 39 31 f6 bf 00 28 00 00 e8 3f 27 01 00 48
85 c0 74 28 48 b9 00 00 00 00 fe 01 00 00 83 43 1c 01 <48> c7 00 00 00
00 00 48 89 48 08 48 8b 53 20 48 89 02 48 89 43 20
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.776746] RSP:
0018:ffffb15a5d563a70 EFLAGS: 00010202
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.776876] RAX:
ffff8ad4d3faf000 RBX: ffffb15a5d563c88 RCX: 000001fe00000000
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.777013] RDX:
0000000000000000 RSI: 0000000000000000 RDI: ffff8b3240b317c0
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.777149] RBP:
000055a0e8f5f000 R08: 0000000000000100 R09: 000055a0e9011fff
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.777285] R10:
ffffb15a5d563a08 R11: 0000000000000025 R12: ffffeff344443300
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.777421] R13:
ffffb15a5d563b90 R14: ffff8ad50c2faaf8 R15: 00000001110cc025
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.777557] FS:
0000000000000000(0000) GS:ffff8b3240b00000(0000)
knlGS:0000000000000000
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.777724] CS:
0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.777855] CR2:
ffff8ad4d3faf000 CR3: 000000018c2f8002 CR4: 00000000007706e0
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.777991] DR0:
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.778126] DR3:
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.778262] PKRU: 55555554
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.778382] Call Trace:
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.778502]  <TASK>
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.778621]  ?
__die_body.cold+0x1a/0x1f
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.778749]  ?
page_fault_oops+0x15a/0x2b0
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.778875]  ?
search_module_extables+0x15/0x60
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.779004]  ?
search_bpf_extables+0x5b/0x80
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.779150]  ?
exc_page_fault+0x8d/0x120
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.779277]  ?
asm_exc_page_fault+0x22/0x30
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.779536]
unmap_page_range+0x8f0/0x1370
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.779667]
unmap_vmas+0xea/0x180
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.779794]
exit_mmap+0xcb/0x2e0
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.779919]
__mmput+0x3d/0x110
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.780045]
begin_new_exec+0x46f/0xaf0
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.780173]  ?
load_elf_phdrs+0x6c/0xc0
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.780312]
load_elf_binary+0x2c2/0x1750
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.780438]  ?
__kernel_read+0x195/0x290
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.780564]
bprm_execve+0x27f/0x650
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.780689]
do_execveat_common.isra.0+0x1ad/0x220
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.780818]
__x64_sys_execve+0x32/0x40
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.780944]
do_syscall_64+0x34/0x80
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.781070]
entry_SYSCALL_64_after_hwframe+0x6e/0xd8
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.781200] RIP:
0033:0x7f1d66e70ad7
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.781325] Code:
Unable to access opcode bytes at 0x7f1d66e70aad.
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.789385] RSP:
002b:00007ffceeb31338 EFLAGS: 00000206 ORIG_RAX: 000000000000003b
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.789552] RAX:
ffffffffffffffda RBX: 000055a11a55e4b0 RCX: 00007f1d66e70ad7
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.789688] RDX:
000055a11a50f200 RSI: 000055a11a6c2d60 RDI: 000055a11a5748c0
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.789825] RBP:
00007ffceeb31570 R08: 0000000000000007 R09: 000055a11a6b1fa0
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.789962] R10:
0000000000000000 R11: 0000000000000206 R12: 00007ffceeb35570
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.790098] R13:
000000000aba9500 R14: 00007ffceeb313b0 R15: 000055a11a6c2d60
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.790237]  </TASK>
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.790367] Modules
linked in: mei watchdog led_class pcc_cpufreq(-) dca acpi_pad button
andbd_shared(O+) 8021q garp stp mrp llc dm_mod dax fuse ip_tables
x_tables autofs4 loop raid10 raid456 async_raid6_recov async_memcpy
async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 linear
md_mod mlx5_core i2c_i801 crc32c_intel xhci_pci mlxfw i2c_smbus i40e
lpc_ich i2c_core mfd_core xhci_hcd
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.790742] CR2:
ffff8ad4d3faf000
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   35.790864] ---[ end
trace 0000000000000000 ]---
kern.warning: May 21 05:59:31 ps404a-1 kernel: [   36.457953] RIP:
0010:__tlb_remove_page_size+0x64/0x90

Any idea what went wrong and how to fix it?

Thanks!
Jinpu Wang

