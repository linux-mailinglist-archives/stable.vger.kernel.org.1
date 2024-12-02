Return-Path: <stable+bounces-95918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396759DF9D3
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 05:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9143EB2128E
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 04:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C06215B554;
	Mon,  2 Dec 2024 04:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLoIBPtY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D1B10F1
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113368; cv=none; b=CEDMbfXzEVtlgQ9yLKGT9QyPv+9ecmPndoV5ELF+e/DdYt40iF62sbA49YCz7xNAabq1Ukxh1LvFh6dyWw2kW+TX6ZdNcZHT1VzUkQ8x8G6yIxJytLBDFa7DH5/Mmi89udYRODRJIb6lZ38VYVxxzx317lAgFddzgVEwMrGPGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113368; c=relaxed/simple;
	bh=i3O7VDACVaXHg4T5WRtBIqMDe+a610xmPQw4lsczTB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xz9IUJ8Kgy8CDOWG9ioPAN6Wp+nmzyNnV26NRfyr+ap+7KXLuW53XV3Ef7ijj85QxEplnL+J6uT//jSvzPqfukRTeZEBGpeS82ppnkhX1K0Jstf8gJxSAW75XqV7bx7BwrnDa4ZJMPAEXhrzC0O63XfZ2sFkOftXmdTgne4NwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLoIBPtY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733113364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ETcSP7IuJTrSogKMHvc5oS8wyNLakVgfPInivyX7J0=;
	b=dLoIBPtYS6BROvjDI+FL737DmiYEZsrbv6HD04IpHWB9AAnXhlLeol2hiInJ93AtN+M9XU
	nBspt/jst8PQKK6D8YC3vhWKFoxji1+1tADtTwkx8eCq7gHjar2BX+UT4/614BMlMv+kOk
	TrzsFiAJqXOeV6S7avdnPnBAdOKl+gg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-MfRq9KvkOvW3RLBaeCcUXg-1; Sun, 01 Dec 2024 23:22:43 -0500
X-MC-Unique: MfRq9KvkOvW3RLBaeCcUXg-1
X-Mimecast-MFC-AGG-ID: MfRq9KvkOvW3RLBaeCcUXg
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee6b027a90so3088038a91.1
        for <stable@vger.kernel.org>; Sun, 01 Dec 2024 20:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113362; x=1733718162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ETcSP7IuJTrSogKMHvc5oS8wyNLakVgfPInivyX7J0=;
        b=PjKcSDTt7H6xNcWfU+aKsZIm0ZuWjRPxW8FBuNJMeo2lQ8TkIGcjGLPHHRyQqkHV0X
         SdrPI/nS1WqlejzZoKg9WHkJ5Ai0ggu4im68pCn1msV8ue8UsymHvBYP8bMu4eXOGN1E
         8lRuKtRjaaIyziHWt+CM1KaBES+3j3dvp/pEqHL76giZ7XYiFApEYOGlhTUGxg36PSyA
         fgXoTnimxTGwIzC651r5OxrlKwmQ3k+JvdAzj8KowKhrj6AjxDjqQSm4A5e3VwhMjhnj
         oQr5hCi9au/D2Pzy3E/q1zToiLVcihZfv2wiJtvM9wQ6Eu/cPJOjscgv9i5ISn1gbPdy
         DoCg==
X-Forwarded-Encrypted: i=1; AJvYcCXA00RjqWnUnLHDhmgtIMEbkuYWJabArCbtope4tc2Z8o/2Xvkx/w1VXKP6vt+jeMVUAHMJBsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qPSbq/fhSWJOtoIdU8VoOXFjqiZs9Llk2JSlERDAsi17wcFb
	L5QUMDAgOhFz71zRdge8wWUMq52io66E1Qshc4necoz0LGU5fyV79z6gA3z1SL5UyIg/v+f9NSy
	mdqF3qS76nyDQGMM6sHDbpQlhcGPVz53ztjRibDQW2zMYai0M3y2/hf4SpbmwK20hcv6kExCb5J
	S+nuGJ+W9XIzZrB1kmrhRHzQXMNtGa
X-Gm-Gg: ASbGnctHH2JqTOx+4Js+nItH5U5h/lA9vmVyI4AiCG/Gf9UHFBoMEsh5OLK+UriNzVX
	guOfXNHlJLEGco1KcdKWQr971daVltVcy
X-Received: by 2002:a17:90a:fc4b:b0:2ee:b0b0:8e02 with SMTP id 98e67ed59e1d1-2eeb0b0909fmr5526380a91.28.1733113362113;
        Sun, 01 Dec 2024 20:22:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3owW+SOw/6TSQRf+iiTMlMr7if3X8wBPRcjaRd+9e4CwQrjnBXXPJqj8Cy2o5TKnl3hlsLKX/fG7qarE02EA=
X-Received: by 2002:a17:90a:fc4b:b0:2ee:b0b0:8e02 with SMTP id
 98e67ed59e1d1-2eeb0b0909fmr5526355a91.28.1733113361524; Sun, 01 Dec 2024
 20:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126024200.2371546-1-koichiro.den@canonical.com>
 <CACGkMEsJ1X-u=djO2=kJzZdpZH5SX560V9osdpDuySXtfBMpuw@mail.gmail.com>
 <6lkdqvbnlntx3cno5qi7c4nks2ub3bkaycsuq7p433c4vemcmf@fwnhqbo5ehaw>
 <CACGkMEvR4+_iRAFACkXLgX-hGwjfOgd3emiyquzxUHL9wC-b=g@mail.gmail.com>
 <uwpyhnvavs6gnagujf2etse3q4c7vgjtej5bi34546isuefmgk@ebkfjs3wagsp>
 <CACGkMEvmBEfMwko-wJJ_78w+1QhN=r1zJ4wbaCJ1L9TU1Uo1pQ@mail.gmail.com>
 <judg4yj4adez5y3tm6lojouf6uh7ge3nice2npzzvwklpluj6t@oicfewgnwbll>
 <CACGkMEu_9aeb5xzKd7r+OFfud=kWOZYREa-8GcDzzppceKszjw@mail.gmail.com> <mva2p3l75byaqsmn2b55w7ougwg52mk67k7gzhhjngytuago3s@ndov2hbr57ns>
In-Reply-To: <mva2p3l75byaqsmn2b55w7ougwg52mk67k7gzhhjngytuago3s@ndov2hbr57ns>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 2 Dec 2024 12:22:30 +0800
Message-ID: <CACGkMEuCO0xBB9cDxp=fpZTMjCLcCdzQP+5_LysuDbWV4Ru1Lw@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: drain unconsumed tx completions if any before dql_reset
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 11:18=E2=80=AFPM Koichiro Den
<koichiro.den@canonical.com> wrote:
>
> On Fri, Nov 29, 2024 at 10:18:04AM +0800, Jason Wang wrote:
> > On Thu, Nov 28, 2024 at 12:25=E2=80=AFPM Koichiro Den
> > <koichiro.den@canonical.com> wrote:
> > >
> > > On Thu, Nov 28, 2024 at 10:57:01AM +0800, Jason Wang wrote:
> > > > On Wed, Nov 27, 2024 at 12:08=E2=80=AFPM Koichiro Den
> > > > <koichiro.den@canonical.com> wrote:
> > > > >
> > > > > On Wed, Nov 27, 2024 at 11:24:15AM +0800, Jason Wang wrote:
> > > > > > On Tue, Nov 26, 2024 at 12:44=E2=80=AFPM Koichiro Den
> > > > > > <koichiro.den@canonical.com> wrote:
> > > > > > >
> > > > > > > On Tue, Nov 26, 2024 at 11:50:17AM +0800, Jason Wang wrote:
> > > > > > > > On Tue, Nov 26, 2024 at 10:42=E2=80=AFAM Koichiro Den
> > > > > > > > <koichiro.den@canonical.com> wrote:
> > > > > > > > >
> > > > > > > > > When virtnet_close is followed by virtnet_open, there is =
a slight chance
> > > > > > > > > that some TX completions remain unconsumed. Those are han=
dled during the
> > > > > > > > > first NAPI poll, but since dql_reset occurs just beforeha=
nd, it can lead
> > > > > > > > > to a crash [1].
> > > > > > > > >
> > > > > > > > > This issue can be reproduced by running: `while :; do ip =
l set DEV down;
> > > > > > > > > ip l set DEV up; done` under heavy network TX load from i=
nside of the
> > > > > > > > > machine.
> > > > > > > > >
> > > > > > > > > To fix this, drain unconsumed TX completions if any befor=
e dql_reset,
> > > > > > > > > allowing BQL to start cleanly.
> > > > > > > > >
> > > > > > > > > ------------[ cut here ]------------
> > > > > > > > > kernel BUG at lib/dynamic_queue_limits.c:99!
> > > > > > > > > Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > > > > > > > > CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0ne=
t-next_main+ #2
> > > > > > > > > Tainted: [N]=3DTEST
> > > > > > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), \
> > > > > > > > > BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2=
014
> > > > > > > > > RIP: 0010:dql_completed+0x26b/0x290
> > > > > > > > > Code: b7 c2 49 89 e9 44 89 da 89 c6 4c 89 d7 e8 ed 17 47 =
00 58 65 ff 0d
> > > > > > > > > 4d 27 90 7e 0f 85 fd fe ff ff e8 ea 53 8d ff e9 f3 fe ff =
ff <0f> 0b 01
> > > > > > > > > d2 44 89 d1 29 d1 ba 00 00 00 00 0f 48 ca e9 28 ff ff ff
> > > > > > > > > RSP: 0018:ffffc900002b0d08 EFLAGS: 00010297
> > > > > > > > > RAX: 0000000000000000 RBX: ffff888102398c80 RCX: 00000000=
80190009
> > > > > > > > > RDX: 0000000000000000 RSI: 000000000000006a RDI: 00000000=
00000000
> > > > > > > > > RBP: ffff888102398c00 R08: 0000000000000000 R09: 00000000=
00000000
> > > > > > > > > R10: 00000000000000ca R11: 0000000000015681 R12: 00000000=
00000001
> > > > > > > > > R13: ffffc900002b0d68 R14: ffff88811115e000 R15: ffff8881=
107aca40
> > > > > > > > > FS:  00007f41ded69500(0000) GS:ffff888667dc0000(0000)
> > > > > > > > > knlGS:0000000000000000
> > > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > > CR2: 0000556ccc2dc1a0 CR3: 0000000104fd8003 CR4: 00000000=
00772ef0
> > > > > > > > > PKRU: 55555554
> > > > > > > > > Call Trace:
> > > > > > > > >  <IRQ>
> > > > > > > > >  ? die+0x32/0x80
> > > > > > > > >  ? do_trap+0xd9/0x100
> > > > > > > > >  ? dql_completed+0x26b/0x290
> > > > > > > > >  ? dql_completed+0x26b/0x290
> > > > > > > > >  ? do_error_trap+0x6d/0xb0
> > > > > > > > >  ? dql_completed+0x26b/0x290
> > > > > > > > >  ? exc_invalid_op+0x4c/0x60
> > > > > > > > >  ? dql_completed+0x26b/0x290
> > > > > > > > >  ? asm_exc_invalid_op+0x16/0x20
> > > > > > > > >  ? dql_completed+0x26b/0x290
> > > > > > > > >  __free_old_xmit+0xff/0x170 [virtio_net]
> > > > > > > > >  free_old_xmit+0x54/0xc0 [virtio_net]
> > > > > > > > >  virtnet_poll+0xf4/0xe30 [virtio_net]
> > > > > > > > >  ? __update_load_avg_cfs_rq+0x264/0x2d0
> > > > > > > > >  ? update_curr+0x35/0x260
> > > > > > > > >  ? reweight_entity+0x1be/0x260
> > > > > > > > >  __napi_poll.constprop.0+0x28/0x1c0
> > > > > > > > >  net_rx_action+0x329/0x420
> > > > > > > > >  ? enqueue_hrtimer+0x35/0x90
> > > > > > > > >  ? trace_hardirqs_on+0x1d/0x80
> > > > > > > > >  ? kvm_sched_clock_read+0xd/0x20
> > > > > > > > >  ? sched_clock+0xc/0x30
> > > > > > > > >  ? kvm_sched_clock_read+0xd/0x20
> > > > > > > > >  ? sched_clock+0xc/0x30
> > > > > > > > >  ? sched_clock_cpu+0xd/0x1a0
> > > > > > > > >  handle_softirqs+0x138/0x3e0
> > > > > > > > >  do_softirq.part.0+0x89/0xc0
> > > > > > > > >  </IRQ>
> > > > > > > > >  <TASK>
> > > > > > > > >  __local_bh_enable_ip+0xa7/0xb0
> > > > > > > > >  virtnet_open+0xc8/0x310 [virtio_net]
> > > > > > > > >  __dev_open+0xfa/0x1b0
> > > > > > > > >  __dev_change_flags+0x1de/0x250
> > > > > > > > >  dev_change_flags+0x22/0x60
> > > > > > > > >  do_setlink.isra.0+0x2df/0x10b0
> > > > > > > > >  ? rtnetlink_rcv_msg+0x34f/0x3f0
> > > > > > > > >  ? netlink_rcv_skb+0x54/0x100
> > > > > > > > >  ? netlink_unicast+0x23e/0x390
> > > > > > > > >  ? netlink_sendmsg+0x21e/0x490
> > > > > > > > >  ? ____sys_sendmsg+0x31b/0x350
> > > > > > > > >  ? avc_has_perm_noaudit+0x67/0xf0
> > > > > > > > >  ? cred_has_capability.isra.0+0x75/0x110
> > > > > > > > >  ? __nla_validate_parse+0x5f/0xee0
> > > > > > > > >  ? __pfx___probestub_irq_enable+0x3/0x10
> > > > > > > > >  ? __create_object+0x5e/0x90
> > > > > > > > >  ? security_capable+0x3b/0x70
> > > > > > > > >  rtnl_newlink+0x784/0xaf0
> > > > > > > > >  ? avc_has_perm_noaudit+0x67/0xf0
> > > > > > > > >  ? cred_has_capability.isra.0+0x75/0x110
> > > > > > > > >  ? stack_depot_save_flags+0x24/0x6d0
> > > > > > > > >  ? __pfx_rtnl_newlink+0x10/0x10
> > > > > > > > >  rtnetlink_rcv_msg+0x34f/0x3f0
> > > > > > > > >  ? do_syscall_64+0x6c/0x180
> > > > > > > > >  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > > > >  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> > > > > > > > >  netlink_rcv_skb+0x54/0x100
> > > > > > > > >  netlink_unicast+0x23e/0x390
> > > > > > > > >  netlink_sendmsg+0x21e/0x490
> > > > > > > > >  ____sys_sendmsg+0x31b/0x350
> > > > > > > > >  ? copy_msghdr_from_user+0x6d/0xa0
> > > > > > > > >  ___sys_sendmsg+0x86/0xd0
> > > > > > > > >  ? __pte_offset_map+0x17/0x160
> > > > > > > > >  ? preempt_count_add+0x69/0xa0
> > > > > > > > >  ? __call_rcu_common.constprop.0+0x147/0x610
> > > > > > > > >  ? preempt_count_add+0x69/0xa0
> > > > > > > > >  ? preempt_count_add+0x69/0xa0
> > > > > > > > >  ? _raw_spin_trylock+0x13/0x60
> > > > > > > > >  ? trace_hardirqs_on+0x1d/0x80
> > > > > > > > >  __sys_sendmsg+0x66/0xc0
> > > > > > > > >  do_syscall_64+0x6c/0x180
> > > > > > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > > > > RIP: 0033:0x7f41defe5b34
> > > > > > > > > Code: 15 e1 12 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf =
0f 1f 44 00 00
> > > > > > > > > f3 0f 1e fa 80 3d 35 95 0f 00 00 74 13 b8 2e 00 00 00 0f =
05 <48> 3d 00
> > > > > > > > > f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> > > > > > > > > RSP: 002b:00007ffe5336ecc8 EFLAGS: 00000202 ORIG_RAX: 000=
000000000002e
> > > > > > > > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f41=
defe5b34
> > > > > > > > > RDX: 0000000000000000 RSI: 00007ffe5336ed30 RDI: 00000000=
00000003
> > > > > > > > > RBP: 00007ffe5336eda0 R08: 0000000000000010 R09: 00000000=
00000001
> > > > > > > > > R10: 00007ffe5336f6f9 R11: 0000000000000202 R12: 00000000=
00000003
> > > > > > > > > R13: 0000000067452259 R14: 0000556ccc28b040 R15: 00000000=
00000000
> > > > > > > > >  </TASK>
> > > > > > > > > [...]
> > > > > > > > > ---[ end Kernel panic - not syncing: Fatal exception in i=
nterrupt ]---
> > > > > > > > >
> > > > > > > > > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Qu=
eue Limits")
> > > > > > > > > Cc: <stable@vger.kernel.org> # v6.11+
> > > > > > > > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/net/virtio_net.c | 37 ++++++++++++++++++++++++++=
+++--------
> > > > > > > > >  1 file changed, 29 insertions(+), 8 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virti=
o_net.c
> > > > > > > > > index 64c87bb48a41..3e36c0470600 100644
> > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > @@ -513,7 +513,7 @@ static struct sk_buff *virtnet_skb_ap=
pend_frag(struct sk_buff *head_skb,
> > > > > > > > >                                                struct sk_=
buff *curr_skb,
> > > > > > > > >                                                struct pag=
e *page, void *buf,
> > > > > > > > >                                                int len, i=
nt truesize);
> > > > > > > > > -static void virtnet_xsk_completed(struct send_queue *sq,=
 int num);
> > > > > > > > > +static void virtnet_xsk_completed(struct send_queue *sq,=
 int num, bool drain);
> > > > > > > > >
> > > > > > > > >  enum virtnet_xmit_type {
> > > > > > > > >         VIRTNET_XMIT_TYPE_SKB,
> > > > > > > > > @@ -580,7 +580,8 @@ static void sg_fill_dma(struct scatte=
rlist *sg, dma_addr_t addr, u32 len)
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  static void __free_old_xmit(struct send_queue *sq, struc=
t netdev_queue *txq,
> > > > > > > > > -                           bool in_napi, struct virtnet_=
sq_free_stats *stats)
> > > > > > > > > +                           bool in_napi, struct virtnet_=
sq_free_stats *stats,
> > > > > > > > > +                           bool drain)
> > > > > > > > >  {
> > > > > > > > >         struct xdp_frame *frame;
> > > > > > > > >         struct sk_buff *skb;
> > > > > > > > > @@ -620,7 +621,8 @@ static void __free_old_xmit(struct se=
nd_queue *sq, struct netdev_queue *txq,
> > > > > > > > >                         break;
> > > > > > > > >                 }
> > > > > > > > >         }
> > > > > > > > > -       netdev_tx_completed_queue(txq, stats->napi_packet=
s, stats->napi_bytes);
> > > > > > > > > +       if (!drain)
> > > > > > > > > +               netdev_tx_completed_queue(txq, stats->nap=
i_packets, stats->napi_bytes);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  static void virtnet_free_old_xmit(struct send_queue *sq,
> > > > > > > > > @@ -628,10 +630,21 @@ static void virtnet_free_old_xmit(s=
truct send_queue *sq,
> > > > > > > > >                                   bool in_napi,
> > > > > > > > >                                   struct virtnet_sq_free_=
stats *stats)
> > > > > > > > >  {
> > > > > > > > > -       __free_old_xmit(sq, txq, in_napi, stats);
> > > > > > > > > +       __free_old_xmit(sq, txq, in_napi, stats, false);
> > > > > > > > >
> > > > > > > > >         if (stats->xsk)
> > > > > > > > > -               virtnet_xsk_completed(sq, stats->xsk);
> > > > > > > > > +               virtnet_xsk_completed(sq, stats->xsk, fal=
se);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static void virtnet_drain_old_xmit(struct send_queue *sq=
,
> > > > > > > > > +                                  struct netdev_queue *t=
xq)
> > > > > > > > > +{
> > > > > > > > > +       struct virtnet_sq_free_stats stats =3D {0};
> > > > > > > > > +
> > > > > > > > > +       __free_old_xmit(sq, txq, false, &stats, true);
> > > > > > > > > +
> > > > > > > > > +       if (stats.xsk)
> > > > > > > > > +               virtnet_xsk_completed(sq, stats.xsk, true=
);
> > > > > > > > >  }
> > > > > > > >
> > > > > > > > Are we sure this can drain the queue? Note that the device =
is not stopped.
> > > > > > >
> > > > > > > Thanks for reviewing. netif_tx_wake_queue can be invoked befo=
re the "drain"
> > > > > > > point I added e.g. via virtnet_config_changed_work, so it see=
ms that I need
> > > > > > > to ensure it's stopped (DRV_XOFF) before the "drain" and wake=
 it afterwards.
> > > > > > > Please let me know if I=E2=80=99m mistaken.
> > > > > >
> > > > > > Not sure I get you, but I meant we don't reset the device so it=
 can
> > > > >
> > > > > I was wondering whether there would be a scenario where the tx qu=
eue is
> > > > > woken up and some new packets from the upper layer reach dql_queu=
ed()
> > > > > before the drain point, which also could cause the crash.
> > > >
> > > > Ok.
> > > >
> > > > >
> > > > > > keep raising tx interrupts:
> > > > > >
> > > > > > virtnet_drain_old_xmit()
> > > > > > netdev_tx_reset_queue()
> > > > > > skb_xmit_done()
> > > > > > napi_enable()
> > > > > > netdev_tx_completed_queue() // here we might still surprise the=
 bql?
> > > > >
> > > > > Indeed, virtqueue_disable_cb() is needed before the drain point.
> > > >
> > > > Two problems:
> > > >
> > > > 1) device/virtqueue is not reset, it can still process the packets
> > > > after virtnet_drain_old_xmit()
> > > > 2) virtqueue_disable_cb() just does its best effort, it can't
> > > > guarantee no interrupt after that.
> > > >
> > > > To drain TX, the only reliable seems to be:
> > > >
> > > > 1) reset a virtqueue (or a device)
> > > > 2) drain by using free_old_xmit()
> > > > 3) netif_reset_tx_queue() // btw this seems to be better done in cl=
ose not open
> > >
> > > Thank you for the clarification.
> > > As for 1), I may be missing something but what if VIRTIO_F_RING_RESET=
 is
> > > not supported. A device reset in this context feels a bit excessive t=
o me
> > > (just my two cents though) if in virtnet_open, so as you said, it see=
ms
> > > better done in close in that regard as well.
> >
> > Probably, most NIC has a way to stop its TX which is missed in
> > virtio-net. So we don't have more choices other than device reset when
> > there's no virtqueue reset.
> >
> > Or we can limit the BQL to virtqueue reset, AF_XDP used to suffer from
> > the exact issue when there's no virtqueue reset. That's why virtqueue
> > reset is invented and AF_XDP is limited to virtqueue reset.
>
> Thank you for the response.
>
> Hmm, if we do a device reset, to me it seems better to (re-)initialize th=
e
> device in a sane way (i.e. ACKNOWLEDGE->DRIVER->...->DRIVER_OK) here as
> well, to avoid potentially surprising the hyperviour side, IIUC. That wou=
ld
> essentially make it nearly equivalent to the current freeze/restore
> handling. However, performing such a reset in open or close path would
> likely require a fundamental restructuring/redefinition of the open/close
> semantics for virtio-net, right? Otherwise I guess it would be a dirty ha=
ck
> solely for this BQL issue. Limitting the BQL to virtqueue reset sounds
> nicer, but I'm now inclined to your suggestion to simply drop
> netdev_tx_reset_queue(), as mentioned in my response below.

Right.

>
> >
> > >
> > > >
> > > > Or I wonder if this can be easily fixed by just removing
> > > > netdev_tx_reset_queue()?
> > >
> > > Perhaps introducing a variant of dql_reset() that clears all stall hi=
story
> > > would suffice? To avoid excessively long stall_max to be possibly rec=
orded.
> >
> > Not sure, it looks like the problem still, bql might still be
> > surprised when it might get completed tx packets when it think it
> > hasn't sent any?
>
> I meant an API that would clear only stall_max, without requiring users t=
o
> do so in such cases. That said, I just noticed that commit message of
> 6025b9135f7a ("net: dqs: add NIC stall detector based on BQL") mentions
> that "this mechanism does not ignore stalls caused by Tx being disabled, =
or
> loss of link", primarily for simplicity's sake. Given this, simply droppi=
ng
> netdev_tx_reset_queue() seems like a streamlined approach. I'll resend a
> patch that does so. If I'm missing something or mistaken, please let me
> know.

I think we can go this way. So I will ACK that patch.

Thanks

>
> Thanks
>
> >
> > Thanks
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > >  /* Converting between virtqueue no. and kernel tx/rx que=
ue no.
> > > > > > > > > @@ -1499,7 +1512,8 @@ static bool virtnet_xsk_xmit(struct=
 send_queue *sq, struct xsk_buff_pool *pool,
> > > > > > > > >         /* Avoid to wakeup napi meanless, so call __free_=
old_xmit instead of
> > > > > > > > >          * free_old_xmit().
> > > > > > > > >          */
> > > > > > > > > -       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq -=
 vi->sq), true, &stats);
> > > > > > > > > +       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq -=
 vi->sq), true,
> > > > > > > > > +                       &stats, false);
> > > > > > > > >
> > > > > > > > >         if (stats.xsk)
> > > > > > > > >                 xsk_tx_completed(sq->xsk_pool, stats.xsk)=
;
> > > > > > > > > @@ -1556,10 +1570,13 @@ static int virtnet_xsk_wakeup(str=
uct net_device *dev, u32 qid, u32 flag)
> > > > > > > > >         return 0;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > -static void virtnet_xsk_completed(struct send_queue *sq,=
 int num)
> > > > > > > > > +static void virtnet_xsk_completed(struct send_queue *sq,=
 int num, bool drain)
> > > > > > > > >  {
> > > > > > > > >         xsk_tx_completed(sq->xsk_pool, num);
> > > > > > > > >
> > > > > > > > > +       if (drain)
> > > > > > > > > +               return;
> > > > > > > > > +
> > > > > > > > >         /* If this is called by rx poll, start_xmit and x=
dp xmit we should
> > > > > > > > >          * wakeup the tx napi to consume the xsk tx queue=
, because the tx
> > > > > > > > >          * interrupt may not be triggered.
> > > > > > > > > @@ -3041,6 +3058,7 @@ static void virtnet_disable_queue_p=
air(struct virtnet_info *vi, int qp_index)
> > > > > > > > >
> > > > > > > > >  static int virtnet_enable_queue_pair(struct virtnet_info=
 *vi, int qp_index)
> > > > > > > > >  {
> > > > > > > > > +       struct netdev_queue *txq =3D netdev_get_tx_queue(=
vi->dev, qp_index);
> > > > > > > > >         struct net_device *dev =3D vi->dev;
> > > > > > > > >         int err;
> > > > > > > > >
> > > > > > > > > @@ -3054,7 +3072,10 @@ static int virtnet_enable_queue_pa=
ir(struct virtnet_info *vi, int qp_index)
> > > > > > > > >         if (err < 0)
> > > > > > > > >                 goto err_xdp_reg_mem_model;
> > > > > > > > >
> > > > > > > > > -       netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev=
, qp_index));
> > > > > > > > > +       /* Drain any unconsumed TX skbs transmitted befor=
e the last virtnet_close */
> > > > > > > > > +       virtnet_drain_old_xmit(&vi->sq[qp_index], txq);
> > > > > > > > > +
> > > > > > > > > +       netdev_tx_reset_queue(txq);
> > > > > > > > >         virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[=
qp_index].napi);
> > > > > > > > >         virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &=
vi->sq[qp_index].napi);
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.43.0
> > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


