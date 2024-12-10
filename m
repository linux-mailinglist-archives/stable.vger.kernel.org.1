Return-Path: <stable+bounces-100282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9E09EA448
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 02:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE672841F6
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 01:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395AA70816;
	Tue, 10 Dec 2024 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JxsS4ehI"
X-Original-To: stable@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9E382;
	Tue, 10 Dec 2024 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794098; cv=none; b=qpAM4Y5SWRZnfUEDuthwQamczP0V5KPQkVT4al1qBHkx1a/N5FOuo6oxJx1wL6uO3DDQ+tZ1e2P23TZAXsT4HQU1lngmoJ4kgMt0tNitV6QIAMrIYUPpjyaV7gSjU1dCWAGQN8Qh+00um66xueQKuLKy/ANBBipapI7dyTGWvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794098; c=relaxed/simple;
	bh=0WGDEIBUdYzdvcU7vz5nQuOkZ6/HgJBnZUPutGdPLls=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=YhUv+jIsmD07OsJ6GGRUfXl5TVHck4E3XjYLkZ2zh1mouNaiixW3IbxHW+IPKnrzO+qvBAOh/vukXzimSv0ssp1vKlrEtAifrkUcdlc0a9gBh57VZCOaaBGfYS6hhz1LmU1NON71zIkW19GjpeVcS+c+rwFoPps2817AtaO/SOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JxsS4ehI; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733794087; h=Message-ID:Subject:Date:From:To;
	bh=yBYoMTDeCXIFbr2CWMfboyCFY2eYGLTga/HAl0c5j54=;
	b=JxsS4ehIVreAytoj6UDvYRG1tuqp07ZAhjwZTVOTxmYmYRMBp35hDLQWshH1TEaOPpwglv3ioHzVEs+XoREt12/edL0MuOcI+9mKl/hcr46QS5CBTJViie+U4TN+ahBe9Rc77W4H9AQJbCy8I6iIMaTEKkDc0XeAqctCk/yjdCA=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WLCv2v2_1733794085 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 09:28:06 +0800
Message-ID: <1733794074.144948-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v4 0/6] virtio_net: correct netdev_tx_reset_queue() invocation points
Date: Tue, 10 Dec 2024 09:27:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 jiri@resnulli.us,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20241206011047.923923-1-koichiro.den@canonical.com>
In-Reply-To: <20241206011047.923923-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


For the series,

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks


On Fri,  6 Dec 2024 10:10:41 +0900, Koichiro Den <koichiro.den@canonical.com> wrote:
> When virtnet_close is followed by virtnet_open, some TX completions can
> possibly remain unconsumed, until they are finally processed during the
> first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
> [1]. Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() call
> before RX napi enable") was not sufficient to eliminate all BQL crash
> scenarios for virtio-net.
>
> This issue can be reproduced with the latest net-next master by running:
> `while :; do ip l set DEV down; ip l set DEV up; done` under heavy network
> TX load from inside the machine.
>
> This patch series resolves the issue and also addresses similar existing
> problems:
>
> (a). Drop netdev_tx_reset_queue() from open/close path. This eliminates the
>      BQL crashes due to the problematic open/close path.
>
> (b). As a result of (a), netdev_tx_reset_queue() is now explicitly required
>      in freeze/restore path. Add netdev_tx_reset_queue() immediately after
>      free_unused_bufs() invocation.
>
> (c). Fix missing resetting in virtnet_tx_resize().
>      virtnet_tx_resize() has lacked proper resetting since commit
>      c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits").
>
> (d). Fix missing resetting in the XDP_SETUP_XSK_POOL path.
>      Similar to (c), this path lacked proper resetting. Call
>      netdev_tx_reset_queue() when virtqueue_reset() has actually recycled
>      unused buffers.
>
> This patch series consists of six commits:
>   [1/6]: Resolves (a) and (b).                      # also -stable 6.11.y
>   [2/6]: Minor fix to make [4/6] streamlined.
>   [3/6]: Prerequisite for (c).                      # also -stable 6.11.y
>   [4/6]: Resolves (c) (incl. Prerequisite for (d))  # also -stable 6.11.y
>   [5/6]: Preresuisite for (d).
>   [6/6]: Resolves (d).
>
> Changes for v4:
>   - move netdev_tx_reset_queue() out of free_unused_bufs()
>   - submit to net, not net-next
> Changes for v3:
>   - replace 'flushed' argument with 'recycle_done'
> Changes for v2:
>   - add tx queue resetting for (b) to (d) above
>
> v3: https://lore.kernel.org/all/20241204050724.307544-1-koichiro.den@canonical.com/
> v2: https://lore.kernel.org/all/20241203073025.67065-1-koichiro.den@canonical.com/
> v1: https://lore.kernel.org/all/20241130181744.3772632-1-koichiro.den@canonical.com/
>
> [1]:
> ------------[ cut here ]------------
> kernel BUG at lib/dynamic_queue_limits.c:99!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0net-next_main+ #2
> Tainted: [N]=TEST
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), \
> BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> RIP: 0010:dql_completed+0x26b/0x290
> Code: b7 c2 49 89 e9 44 89 da 89 c6 4c 89 d7 e8 ed 17 47 00 58 65 ff 0d
> 4d 27 90 7e 0f 85 fd fe ff ff e8 ea 53 8d ff e9 f3 fe ff ff <0f> 0b 01
> d2 44 89 d1 29 d1 ba 00 00 00 00 0f 48 ca e9 28 ff ff ff
> RSP: 0018:ffffc900002b0d08 EFLAGS: 00010297
> RAX: 0000000000000000 RBX: ffff888102398c80 RCX: 0000000080190009
> RDX: 0000000000000000 RSI: 000000000000006a RDI: 0000000000000000
> RBP: ffff888102398c00 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000000000ca R11: 0000000000015681 R12: 0000000000000001
> R13: ffffc900002b0d68 R14: ffff88811115e000 R15: ffff8881107aca40
> FS:  00007f41ded69500(0000) GS:ffff888667dc0000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000556ccc2dc1a0 CR3: 0000000104fd8003 CR4: 0000000000772ef0
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  ? die+0x32/0x80
>  ? do_trap+0xd9/0x100
>  ? dql_completed+0x26b/0x290
>  ? dql_completed+0x26b/0x290
>  ? do_error_trap+0x6d/0xb0
>  ? dql_completed+0x26b/0x290
>  ? exc_invalid_op+0x4c/0x60
>  ? dql_completed+0x26b/0x290
>  ? asm_exc_invalid_op+0x16/0x20
>  ? dql_completed+0x26b/0x290
>  __free_old_xmit+0xff/0x170 [virtio_net]
>  free_old_xmit+0x54/0xc0 [virtio_net]
>  virtnet_poll+0xf4/0xe30 [virtio_net]
>  ? __update_load_avg_cfs_rq+0x264/0x2d0
>  ? update_curr+0x35/0x260
>  ? reweight_entity+0x1be/0x260
>  __napi_poll.constprop.0+0x28/0x1c0
>  net_rx_action+0x329/0x420
>  ? enqueue_hrtimer+0x35/0x90
>  ? trace_hardirqs_on+0x1d/0x80
>  ? kvm_sched_clock_read+0xd/0x20
>  ? sched_clock+0xc/0x30
>  ? kvm_sched_clock_read+0xd/0x20
>  ? sched_clock+0xc/0x30
>  ? sched_clock_cpu+0xd/0x1a0
>  handle_softirqs+0x138/0x3e0
>  do_softirq.part.0+0x89/0xc0
>  </IRQ>
>  <TASK>
>  __local_bh_enable_ip+0xa7/0xb0
>  virtnet_open+0xc8/0x310 [virtio_net]
>  __dev_open+0xfa/0x1b0
>  __dev_change_flags+0x1de/0x250
>  dev_change_flags+0x22/0x60
>  do_setlink.isra.0+0x2df/0x10b0
>  ? rtnetlink_rcv_msg+0x34f/0x3f0
>  ? netlink_rcv_skb+0x54/0x100
>  ? netlink_unicast+0x23e/0x390
>  ? netlink_sendmsg+0x21e/0x490
>  ? ____sys_sendmsg+0x31b/0x350
>  ? avc_has_perm_noaudit+0x67/0xf0
>  ? cred_has_capability.isra.0+0x75/0x110
>  ? __nla_validate_parse+0x5f/0xee0
>  ? __pfx___probestub_irq_enable+0x3/0x10
>  ? __create_object+0x5e/0x90
>  ? security_capable+0x3b/0x7[I0
>  rtnl_newlink+0x784/0xaf0
>  ? avc_has_perm_noaudit+0x67/0xf0
>  ? cred_has_capability.isra.0+0x75/0x110
>  ? stack_depot_save_flags+0x24/0x6d0
>  ? __pfx_rtnl_newlink+0x10/0x10
>  rtnetlink_rcv_msg+0x34f/0x3f0
>  ? do_syscall_64+0x6c/0x180
>  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>  netlink_rcv_skb+0x54/0x100
>  netlink_unicast+0x23e/0x390
>  netlink_sendmsg+0x21e/0x490
>  ____sys_sendmsg+0x31b/0x350
>  ? copy_msghdr_from_user+0x6d/0xa0
>  ___sys_sendmsg+0x86/0xd0
>  ? __pte_offset_map+0x17/0x160
>  ? preempt_count_add+0x69/0xa0
>  ? __call_rcu_common.constprop.0+0x147/0x610
>  ? preempt_count_add+0x69/0xa0
>  ? preempt_count_add+0x69/0xa0
>  ? _raw_spin_trylock+0x13/0x60
>  ? trace_hardirqs_on+0x1d/0x80
>  __sys_sendmsg+0x66/0xc0
>  do_syscall_64+0x6c/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f41defe5b34
> Code: 15 e1 12 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00
> f3 0f 1e fa 80 3d 35 95 0f 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00
> f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> RSP: 002b:00007ffe5336ecc8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f41defe5b34
> RDX: 0000000000000000 RSI: 00007ffe5336ed30 RDI: 0000000000000003
> RBP: 00007ffe5336eda0 R08: 0000000000000010 R09: 0000000000000001
> R10: 00007ffe5336f6f9 R11: 0000000000000202 R12: 0000000000000003
> R13: 0000000067452259 R14: 0000556ccc28b040 R15: 0000000000000000
>  </TASK>
> [...]
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>
> Koichiro Den (6):
>   virtio_net: correct netdev_tx_reset_queue() invocation point
>   virtio_net: replace vq2rxq with vq2txq where appropriate
>   virtio_ring: add a func argument 'recycle_done' to virtqueue_resize()
>   virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
>   virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
>   virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx
>
>  drivers/net/virtio_net.c     | 31 +++++++++++++++++++++++++------
>  drivers/virtio/virtio_ring.c | 12 ++++++++++--
>  include/linux/virtio.h       |  6 ++++--
>  3 files changed, 39 insertions(+), 10 deletions(-)
>
> --
> 2.43.0
>

