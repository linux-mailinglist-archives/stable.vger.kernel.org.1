Return-Path: <stable+bounces-95583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58C29DA158
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 05:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662E4284184
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 04:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13B13AD2F;
	Wed, 27 Nov 2024 04:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="l2QNjnDb"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5D282FE
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680474; cv=none; b=bThI+4nr5yqtVtKtMmOHLrZe9QhvDbUVNPy9R74Gx+xFTynEdORMoACq/YhHGdVeJbUTNpE01lVwhwUXYZKe5yADoymBEnYp6sZe8BadcATCsoL4qSQYDKW592WzBLMgGPDaeGLFw3gJOEwamHp71gKzTD3+iFaQ461fUt1BeZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680474; c=relaxed/simple;
	bh=DmST9PFbRHUXgYspuc7kOe6H5jWOwaIoW/9b3Sm7K7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjBcdD3ouozU63hGS4ZXWdGJSbRNGTiUgrMaebnvi62VNxtctDzOlThDQcSltVjrMdQsw4IpMj7j5TpiblglsqUvzO11ZsMb/VuZlofGArFG7kDaXIVWJ7LZe+CCVZTwytKqMGjqBY5wr4ztS5/GH8PNwNVLF3JhItzwDFTodmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=l2QNjnDb; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7F0C23F84E
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 04:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732680469;
	bh=tcxowMTCDYap5jhfDWtWfSNdZtAgdsKkRr6s9f0a344=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=l2QNjnDbJGJ1okwZI1MJkYybp2XkR+Zua59GAIXouS7FOrx41SdlCcam3pbKc4VVm
	 sxysodaEVekJewuGAQPJQ0tnhmF1InFnpCKGpelMlqfXdtN+cDN8wLj0/mhYu2BkPn
	 d3Yj8Qf2CQBpCRAt3c/aSVgiATdUeE0/kClJyqw10Chf56EEJZnAOmwWe5DW96yKZy
	 6Ql1mnarTwVA+ogHy/wNyGxNl3v9vBalQ+NUtKZzBtFNw1NtqQzVGpBJogJYcD+5ph
	 1kKbuFN07fRzKWajamiTVK1ME5KGXn5RuXlvPtxG/ukayH7DYiXUm0EgO3R76l/5+3
	 PE6T+OzFZON2g==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ea42039766so6122074a91.3
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 20:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732680468; x=1733285268;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcxowMTCDYap5jhfDWtWfSNdZtAgdsKkRr6s9f0a344=;
        b=JQEFv6UxF5t7ihenIMgZxane1ZPA3urQoTHHGWidRztrKyNXLevPnsI+z+FAjNFkSZ
         1PFlJh5OCz4nBr4KTl5fp5wXFvGgs644KeXiU3c2g9hlZhuxLDW/gZV0by5fkrN78Yep
         0CSGIJHrTJEY6hLEXGlcqHzA55hqEUOVbTpbbLvlDyxX5MxLj5yZ8NSPwswpKiGw4Q8O
         YLH5Rz9ZY9hbdZM/5LqzjA5Jdppdw0BqBlzlltMzb59Trz9UzhVVvJTvWul0Zk6CFXiP
         yClCcgJmd/e98gzq8kq/+rCagSeriE/OXNmoq20ZGK6QYca0bjCNr1ZLlXPMXqBPlCM3
         UHnw==
X-Forwarded-Encrypted: i=1; AJvYcCWlKj04LuR2qMOBvzjegP1wcGrC/usTHU13brK5nAJdiXM1XwdGo61gjimwEUXLBeBEFHE+Kzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNj9kBJ6mAhYp58TJzIvYFjDlJUROceFEWZPXbdjZWtKavjoGz
	r8aK42mmryiza2x1mgzXE4/xwIXjOxXmJiZM0JU2TAekR+YgD6UTaqQH17wLIrL3Kmr3/3j8ejt
	Uu1m2SiK019CeeXI3/+HmOF586koC8fwWNjnqQ2QUaYoWEOiDJdNFfKaF7Sh777VEJweQ9A==
X-Gm-Gg: ASbGncvGKeZo2HOW53Vhv3jtAdLvvL96EMxUYirbcaOV9p2gYuT400suGjeOuCJfWRt
	mpuN6zXN0DUPwwT+WHJ0yoR9UNXli2/v9F74GV/aJHsb8RBD2K41YhRKQd+DZhjIQpWbTxtp5pK
	wg0/4CcMPiC4ifDSJEFsQYWXEzh5W9H9ja+ejUkuGFlQtrlyGT+brnD/EIjG82OLWq5GCH2bgH5
	VuoSbAd/W1eRJvc3a9/yBCJdwLB2R6dhZ2VF8kz2MTctHEhAts=
X-Received: by 2002:a17:90b:3e86:b0:2ea:9ce1:d143 with SMTP id 98e67ed59e1d1-2ee08eb0640mr2361215a91.11.1732680467933;
        Tue, 26 Nov 2024 20:07:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqSQL6zAE0wvtElDjVcQcWzTfHG5uchaXuqkueuJqrfp6dYOb2r9JNbhtirZgWctUwcdmB4Q==
X-Received: by 2002:a17:90b:3e86:b0:2ea:9ce1:d143 with SMTP id 98e67ed59e1d1-2ee08eb0640mr2361187a91.11.1732680467505;
        Tue, 26 Nov 2024 20:07:47 -0800 (PST)
Received: from localhost ([240f:74:7be:1:e412:c4ef:3b3:8931])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fb10032sm455714a91.45.2024.11.26.20.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:07:47 -0800 (PST)
Date: Wed, 27 Nov 2024 13:07:45 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] virtio_net: drain unconsumed tx completions if any
 before dql_reset
Message-ID: <uwpyhnvavs6gnagujf2etse3q4c7vgjtej5bi34546isuefmgk@ebkfjs3wagsp>
References: <20241126024200.2371546-1-koichiro.den@canonical.com>
 <CACGkMEsJ1X-u=djO2=kJzZdpZH5SX560V9osdpDuySXtfBMpuw@mail.gmail.com>
 <6lkdqvbnlntx3cno5qi7c4nks2ub3bkaycsuq7p433c4vemcmf@fwnhqbo5ehaw>
 <CACGkMEvR4+_iRAFACkXLgX-hGwjfOgd3emiyquzxUHL9wC-b=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvR4+_iRAFACkXLgX-hGwjfOgd3emiyquzxUHL9wC-b=g@mail.gmail.com>

On Wed, Nov 27, 2024 at 11:24:15AM +0800, Jason Wang wrote:
> On Tue, Nov 26, 2024 at 12:44 PM Koichiro Den
> <koichiro.den@canonical.com> wrote:
> >
> > On Tue, Nov 26, 2024 at 11:50:17AM +0800, Jason Wang wrote:
> > > On Tue, Nov 26, 2024 at 10:42 AM Koichiro Den
> > > <koichiro.den@canonical.com> wrote:
> > > >
> > > > When virtnet_close is followed by virtnet_open, there is a slight chance
> > > > that some TX completions remain unconsumed. Those are handled during the
> > > > first NAPI poll, but since dql_reset occurs just beforehand, it can lead
> > > > to a crash [1].
> > > >
> > > > This issue can be reproduced by running: `while :; do ip l set DEV down;
> > > > ip l set DEV up; done` under heavy network TX load from inside of the
> > > > machine.
> > > >
> > > > To fix this, drain unconsumed TX completions if any before dql_reset,
> > > > allowing BQL to start cleanly.
> > > >
> > > > ------------[ cut here ]------------
> > > > kernel BUG at lib/dynamic_queue_limits.c:99!
> > > > Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > > > CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0net-next_main+ #2
> > > > Tainted: [N]=TEST
> > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), \
> > > > BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > > > RIP: 0010:dql_completed+0x26b/0x290
> > > > Code: b7 c2 49 89 e9 44 89 da 89 c6 4c 89 d7 e8 ed 17 47 00 58 65 ff 0d
> > > > 4d 27 90 7e 0f 85 fd fe ff ff e8 ea 53 8d ff e9 f3 fe ff ff <0f> 0b 01
> > > > d2 44 89 d1 29 d1 ba 00 00 00 00 0f 48 ca e9 28 ff ff ff
> > > > RSP: 0018:ffffc900002b0d08 EFLAGS: 00010297
> > > > RAX: 0000000000000000 RBX: ffff888102398c80 RCX: 0000000080190009
> > > > RDX: 0000000000000000 RSI: 000000000000006a RDI: 0000000000000000
> > > > RBP: ffff888102398c00 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 00000000000000ca R11: 0000000000015681 R12: 0000000000000001
> > > > R13: ffffc900002b0d68 R14: ffff88811115e000 R15: ffff8881107aca40
> > > > FS:  00007f41ded69500(0000) GS:ffff888667dc0000(0000)
> > > > knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000556ccc2dc1a0 CR3: 0000000104fd8003 CR4: 0000000000772ef0
> > > > PKRU: 55555554
> > > > Call Trace:
> > > >  <IRQ>
> > > >  ? die+0x32/0x80
> > > >  ? do_trap+0xd9/0x100
> > > >  ? dql_completed+0x26b/0x290
> > > >  ? dql_completed+0x26b/0x290
> > > >  ? do_error_trap+0x6d/0xb0
> > > >  ? dql_completed+0x26b/0x290
> > > >  ? exc_invalid_op+0x4c/0x60
> > > >  ? dql_completed+0x26b/0x290
> > > >  ? asm_exc_invalid_op+0x16/0x20
> > > >  ? dql_completed+0x26b/0x290
> > > >  __free_old_xmit+0xff/0x170 [virtio_net]
> > > >  free_old_xmit+0x54/0xc0 [virtio_net]
> > > >  virtnet_poll+0xf4/0xe30 [virtio_net]
> > > >  ? __update_load_avg_cfs_rq+0x264/0x2d0
> > > >  ? update_curr+0x35/0x260
> > > >  ? reweight_entity+0x1be/0x260
> > > >  __napi_poll.constprop.0+0x28/0x1c0
> > > >  net_rx_action+0x329/0x420
> > > >  ? enqueue_hrtimer+0x35/0x90
> > > >  ? trace_hardirqs_on+0x1d/0x80
> > > >  ? kvm_sched_clock_read+0xd/0x20
> > > >  ? sched_clock+0xc/0x30
> > > >  ? kvm_sched_clock_read+0xd/0x20
> > > >  ? sched_clock+0xc/0x30
> > > >  ? sched_clock_cpu+0xd/0x1a0
> > > >  handle_softirqs+0x138/0x3e0
> > > >  do_softirq.part.0+0x89/0xc0
> > > >  </IRQ>
> > > >  <TASK>
> > > >  __local_bh_enable_ip+0xa7/0xb0
> > > >  virtnet_open+0xc8/0x310 [virtio_net]
> > > >  __dev_open+0xfa/0x1b0
> > > >  __dev_change_flags+0x1de/0x250
> > > >  dev_change_flags+0x22/0x60
> > > >  do_setlink.isra.0+0x2df/0x10b0
> > > >  ? rtnetlink_rcv_msg+0x34f/0x3f0
> > > >  ? netlink_rcv_skb+0x54/0x100
> > > >  ? netlink_unicast+0x23e/0x390
> > > >  ? netlink_sendmsg+0x21e/0x490
> > > >  ? ____sys_sendmsg+0x31b/0x350
> > > >  ? avc_has_perm_noaudit+0x67/0xf0
> > > >  ? cred_has_capability.isra.0+0x75/0x110
> > > >  ? __nla_validate_parse+0x5f/0xee0
> > > >  ? __pfx___probestub_irq_enable+0x3/0x10
> > > >  ? __create_object+0x5e/0x90
> > > >  ? security_capable+0x3b/0x70
> > > >  rtnl_newlink+0x784/0xaf0
> > > >  ? avc_has_perm_noaudit+0x67/0xf0
> > > >  ? cred_has_capability.isra.0+0x75/0x110
> > > >  ? stack_depot_save_flags+0x24/0x6d0
> > > >  ? __pfx_rtnl_newlink+0x10/0x10
> > > >  rtnetlink_rcv_msg+0x34f/0x3f0
> > > >  ? do_syscall_64+0x6c/0x180
> > > >  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > >  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> > > >  netlink_rcv_skb+0x54/0x100
> > > >  netlink_unicast+0x23e/0x390
> > > >  netlink_sendmsg+0x21e/0x490
> > > >  ____sys_sendmsg+0x31b/0x350
> > > >  ? copy_msghdr_from_user+0x6d/0xa0
> > > >  ___sys_sendmsg+0x86/0xd0
> > > >  ? __pte_offset_map+0x17/0x160
> > > >  ? preempt_count_add+0x69/0xa0
> > > >  ? __call_rcu_common.constprop.0+0x147/0x610
> > > >  ? preempt_count_add+0x69/0xa0
> > > >  ? preempt_count_add+0x69/0xa0
> > > >  ? _raw_spin_trylock+0x13/0x60
> > > >  ? trace_hardirqs_on+0x1d/0x80
> > > >  __sys_sendmsg+0x66/0xc0
> > > >  do_syscall_64+0x6c/0x180
> > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > RIP: 0033:0x7f41defe5b34
> > > > Code: 15 e1 12 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00
> > > > f3 0f 1e fa 80 3d 35 95 0f 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00
> > > > f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> > > > RSP: 002b:00007ffe5336ecc8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> > > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f41defe5b34
> > > > RDX: 0000000000000000 RSI: 00007ffe5336ed30 RDI: 0000000000000003
> > > > RBP: 00007ffe5336eda0 R08: 0000000000000010 R09: 0000000000000001
> > > > R10: 00007ffe5336f6f9 R11: 0000000000000202 R12: 0000000000000003
> > > > R13: 0000000067452259 R14: 0000556ccc28b040 R15: 0000000000000000
> > > >  </TASK>
> > > > [...]
> > > > ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> > > >
> > > > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > > > Cc: <stable@vger.kernel.org> # v6.11+
> > > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 37 +++++++++++++++++++++++++++++--------
> > > >  1 file changed, 29 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 64c87bb48a41..3e36c0470600 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -513,7 +513,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> > > >                                                struct sk_buff *curr_skb,
> > > >                                                struct page *page, void *buf,
> > > >                                                int len, int truesize);
> > > > -static void virtnet_xsk_completed(struct send_queue *sq, int num);
> > > > +static void virtnet_xsk_completed(struct send_queue *sq, int num, bool drain);
> > > >
> > > >  enum virtnet_xmit_type {
> > > >         VIRTNET_XMIT_TYPE_SKB,
> > > > @@ -580,7 +580,8 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
> > > >  }
> > > >
> > > >  static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
> > > > -                           bool in_napi, struct virtnet_sq_free_stats *stats)
> > > > +                           bool in_napi, struct virtnet_sq_free_stats *stats,
> > > > +                           bool drain)
> > > >  {
> > > >         struct xdp_frame *frame;
> > > >         struct sk_buff *skb;
> > > > @@ -620,7 +621,8 @@ static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
> > > >                         break;
> > > >                 }
> > > >         }
> > > > -       netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
> > > > +       if (!drain)
> > > > +               netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
> > > >  }
> > > >
> > > >  static void virtnet_free_old_xmit(struct send_queue *sq,
> > > > @@ -628,10 +630,21 @@ static void virtnet_free_old_xmit(struct send_queue *sq,
> > > >                                   bool in_napi,
> > > >                                   struct virtnet_sq_free_stats *stats)
> > > >  {
> > > > -       __free_old_xmit(sq, txq, in_napi, stats);
> > > > +       __free_old_xmit(sq, txq, in_napi, stats, false);
> > > >
> > > >         if (stats->xsk)
> > > > -               virtnet_xsk_completed(sq, stats->xsk);
> > > > +               virtnet_xsk_completed(sq, stats->xsk, false);
> > > > +}
> > > > +
> > > > +static void virtnet_drain_old_xmit(struct send_queue *sq,
> > > > +                                  struct netdev_queue *txq)
> > > > +{
> > > > +       struct virtnet_sq_free_stats stats = {0};
> > > > +
> > > > +       __free_old_xmit(sq, txq, false, &stats, true);
> > > > +
> > > > +       if (stats.xsk)
> > > > +               virtnet_xsk_completed(sq, stats.xsk, true);
> > > >  }
> > >
> > > Are we sure this can drain the queue? Note that the device is not stopped.
> >
> > Thanks for reviewing. netif_tx_wake_queue can be invoked before the "drain"
> > point I added e.g. via virtnet_config_changed_work, so it seems that I need
> > to ensure it's stopped (DRV_XOFF) before the "drain" and wake it afterwards.
> > Please let me know if I’m mistaken.
> 
> Not sure I get you, but I meant we don't reset the device so it can

I was wondering whether there would be a scenario where the tx queue is
woken up and some new packets from the upper layer reach dql_queued()
before the drain point, which also could cause the crash.

> keep raising tx interrupts:
> 
> virtnet_drain_old_xmit()
> netdev_tx_reset_queue()
> skb_xmit_done()
> napi_enable()
> netdev_tx_completed_queue() // here we might still surprise the bql?

Indeed, virtqueue_disable_cb() is needed before the drain point.

Thanks

> 
> Thanks
> 
> >
> > >
> > > >
> > > >  /* Converting between virtqueue no. and kernel tx/rx queue no.
> > > > @@ -1499,7 +1512,8 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
> > > >         /* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
> > > >          * free_old_xmit().
> > > >          */
> > > > -       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), true, &stats);
> > > > +       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), true,
> > > > +                       &stats, false);
> > > >
> > > >         if (stats.xsk)
> > > >                 xsk_tx_completed(sq->xsk_pool, stats.xsk);
> > > > @@ -1556,10 +1570,13 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
> > > >         return 0;
> > > >  }
> > > >
> > > > -static void virtnet_xsk_completed(struct send_queue *sq, int num)
> > > > +static void virtnet_xsk_completed(struct send_queue *sq, int num, bool drain)
> > > >  {
> > > >         xsk_tx_completed(sq->xsk_pool, num);
> > > >
> > > > +       if (drain)
> > > > +               return;
> > > > +
> > > >         /* If this is called by rx poll, start_xmit and xdp xmit we should
> > > >          * wakeup the tx napi to consume the xsk tx queue, because the tx
> > > >          * interrupt may not be triggered.
> > > > @@ -3041,6 +3058,7 @@ static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> > > >
> > > >  static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > > >  {
> > > > +       struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, qp_index);
> > > >         struct net_device *dev = vi->dev;
> > > >         int err;
> > > >
> > > > @@ -3054,7 +3072,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > > >         if (err < 0)
> > > >                 goto err_xdp_reg_mem_model;
> > > >
> > > > -       netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
> > > > +       /* Drain any unconsumed TX skbs transmitted before the last virtnet_close */
> > > > +       virtnet_drain_old_xmit(&vi->sq[qp_index], txq);
> > > > +
> > > > +       netdev_tx_reset_queue(txq);
> > > >         virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> > > >         virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > > >
> > >
> > > Thanks
> > >
> >
> 

