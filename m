Return-Path: <stable+bounces-98844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342C49E5992
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 16:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9331882B52
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE6521C17A;
	Thu,  5 Dec 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmN9FxfQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879AA1D278A
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411889; cv=none; b=K4vNLqsdNFO0PnOYJDOLXp7uqS6UWo+3IPbeucFAIuGAzOLmCEXTzXMKS26CcaxeDWQKx7I/kIsnEuASVcG9k21h73s7Eh1/poX5HeuKeXWrc5Mz6hAPRNB1IoFOobEoOzncALhJY43SPpvhZUKcdVpihGITC7196Kpyrunn/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411889; c=relaxed/simple;
	bh=ubhbPtzBn8syqYBtLvmidYf4WZHhwRkbUJb61pjNjr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9vZeAcgov95Jcf5h+mgX1x43elixljY4llZNqv19vsawuG/7S2ecs8p9xa/ONpnAmh/jaPc1tdDEgbBVJlZExUREdy9RW19ATrMIcKUt1vGfgxrXW06KmURnqBc6sk8RbNYEFZQRgl2pypDRdjignV1fTGaBTZ9OpBw5zutLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmN9FxfQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733411886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JdSji3NGlMnQ1jXsJVZOGl9L1qIEshri+ASXsE86GnI=;
	b=GmN9FxfQm1JfosRvoSDYZcB9VG1jayfOd1ZhqgCPiHpsentq1NtgK6u0e7ha3rkkbheUwF
	82/wBOoV9R/uhK1gXELoJskaYJwaR/QuKPMUrgA79kUz2ZD4MzN2qh2rpLAZpXqqcFLc2x
	HGWvHdr6I1dhDPJlA86e9hkleX9zSEQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-8RsLcmhHMLWEhNFKRBYPVw-1; Thu, 05 Dec 2024 10:18:05 -0500
X-MC-Unique: 8RsLcmhHMLWEhNFKRBYPVw-1
X-Mimecast-MFC-AGG-ID: 8RsLcmhHMLWEhNFKRBYPVw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d80576abso813029f8f.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 07:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411884; x=1734016684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdSji3NGlMnQ1jXsJVZOGl9L1qIEshri+ASXsE86GnI=;
        b=YUkghu5m4WihDpEGAxc9K8rd+m6jmlKr+8J/A2+QwZEHrup1GnCEoyyWBwcYpkntT3
         6+oji8SYUpzP87kfQ0gZphjndM6inkN3r8Of4h3LdoA+Ak070JluJS1SYyttKARAXZcg
         ogeeXNZ2p9DwDYA5jSJD/eWgxHVGK2JfMvnQewR4OYGKIf4U6ww1LfgLzu2LPbRe/Ef1
         wDNZipyZUlwx3PkfPZ79NFxhBe0s/C8DGtmcJdQhaP/mEPuK2npJYI7Z+bS4jkz98nQf
         c2w6ia4EnBTpSpCPQoqx8dsIqZBCEg8xZPFve9baIAkBvwBBxOoTlqyMtVk84ruyLbmu
         08hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUphaP7BSnSU0LJaVtRiu9JcbUPoKA76lvSLPV+ltAWU7JM5ewuHK4u8OmApNNillvq0ZAKhbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUj7wjwc0tIdeCC06NCT/A0cCpYftJXCIaUUHN/+JKT9y8tDiF
	5/YfsyQDpUOp31d1oDq6zA1WIjZ2EbX3lgFlUBUAJ91Xlp/E6TTGLftxDFZV9IY2BLuNjL1+bbP
	SV+jO9TFVCyi7RAA9jsBeWzstKMeOC2UVHBiER1V1HXcE3rSxf4KkEw==
X-Gm-Gg: ASbGncuqv3GooaNmMvdtIsy7tkJMbB/io7cMNRtqpi0MoCQCIm9hMDgvTIokNImBY1Z
	2Uyy2rjT9AVJ0ExWKxkD98gUsWaP9G8Ge4pnoWQo6HdBrp+1WqUl6F9dmS2KdaLMCcRlPJLlVod
	mPeKnqq9p2Om+2tGuNs1Yfm6Gsdv8oysONuFIR3xLj9/RwRyrYrdH61B5VwIl+P73jB51oHK/nh
	NxMJyLmgkOBhlBPoRgIqclmrCeTzksXOYbhLrk=
X-Received: by 2002:a5d:6d03:0:b0:37d:4833:38f5 with SMTP id ffacd0b85a97d-385fd3f2c0emr10797889f8f.30.1733411883949;
        Thu, 05 Dec 2024 07:18:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYWGJEpkIfFGXIzPlV7ZnY+sjcPxgdHQ0cw9usI/E0FiDiz746U+r28+u6h6camWH6r8h8KA==
X-Received: by 2002:a5d:6d03:0:b0:37d:4833:38f5 with SMTP id ffacd0b85a97d-385fd3f2c0emr10797856f8f.30.1733411883555;
        Thu, 05 Dec 2024 07:18:03 -0800 (PST)
Received: from redhat.com ([2.55.188.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e96c2fsm104968066b.62.2024.12.05.07.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:18:02 -0800 (PST)
Date: Thu, 5 Dec 2024 10:17:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/7] virtio_net: correct
 netdev_tx_reset_queue() invocation point
Message-ID: <20241205101611-mutt-send-email-mst@kernel.org>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
 <20241204050724.307544-2-koichiro.den@canonical.com>
 <20241205052729-mutt-send-email-mst@kernel.org>
 <nmjiptygbpqfcveclpzmpgczd3geir72kkczqixfucpgrl3g7u@6dzpd7qijvdm>
 <cv7ph7yna6d5a37k7hoxplyzrbmrdxrcjd67nrttevsta3r54h@35ztxhqaczqd>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cv7ph7yna6d5a37k7hoxplyzrbmrdxrcjd67nrttevsta3r54h@35ztxhqaczqd>

On Thu, Dec 05, 2024 at 10:16:35PM +0900, Koichiro Den wrote:
> On Thu, Dec 05, 2024 at 09:43:38PM +0900, Koichiro Den wrote:
> > On Thu, Dec 05, 2024 at 05:33:36AM -0500, Michael S. Tsirkin wrote:
> > > On Wed, Dec 04, 2024 at 02:07:18PM +0900, Koichiro Den wrote:
> > > > When virtnet_close is followed by virtnet_open, some TX completions can
> > > > possibly remain unconsumed, until they are finally processed during the
> > > > first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
> > > > [1].
> > > 
> > > 
> > > So it's a bugfix. Why net-next not net?
> > 
> > I was mistaken (I just read netdev-FAQ again). I'll resend to net, with
> > adjustments reflecting your feedback.
> > 
> > > 
> > > > Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() call
> > > > before RX napi enable") was not sufficient to eliminate all BQL crash
> > > > cases for virtio-net.
> > > > 
> > > > This issue can be reproduced with the latest net-next master by running:
> > > > `while :; do ip l set DEV down; ip l set DEV up; done` under heavy network
> > > > TX load from inside the machine.
> > > > 
> > > > netdev_tx_reset_queue() can actually be dropped from virtnet_open path;
> > > > the device is not stopped in any case. For BQL core part, it's just like
> > > > traffic nearly ceases to exist for some period. For stall detector added
> > > > to BQL, even if virtnet_close could somehow lead to some TX completions
> > > > delayed for long, followed by virtnet_open, we can just take it as stall
> > > > as mentioned in commit 6025b9135f7a ("net: dqs: add NIC stall detector
> > > > based on BQL"). Note also that users can still reset stall_max via sysfs.
> > > > 
> > > > So, drop netdev_tx_reset_queue() from virtnet_enable_queue_pair(). This
> > > > eliminates the BQL crashes. Note that netdev_tx_reset_queue() is now
> > > > explicitly required in freeze/restore path, so this patch adds it to
> > > > free_unused_bufs().
> > > 
> > > I don't much like that free_unused_bufs now has this side effect.
> > > I think would be better to just add a loop in virtnet_restore.
> > > Or if you want to keep it there, pls rename the function
> > > to hint it does more.
> > 
> > It makes sense. I would go for the former. Thanks.
> 
> Hmm, as Jacob pointed out in v1
> (https://lore.kernel.org/all/20241202181445.0da50076@kernel.org/),
> it looks better to follow the rule of thumb.

OK then. I'm fine with keeping your code as is, just a squash,
and add a comment

	/*
	 * Rule of thumb is netdev_tx_reset_queue() should follow any
	 * skb freeing not followed by netdev_tx_completed_queue()
	 */

> Taking both suggestions
> from Jacob and you, adding a loop to remove_vq_common(), just after
> free_unused_bufs(), seems more fitting now, like this:
> 
>      static void remove_vq_common(struct virtnet_info *vi)
>      {
>     +       int i;
>     +
>             virtio_reset_device(vi->vdev);
>     
>             /* Free unused buffers in both send and recv, if any. */
>             free_unused_bufs(vi);
>     
>     +       /* Tx unused buffers flushed, so reset BQL counter */
>     +       for (i = 0; i < vi->max_queue_pairs; i++)
>     +               netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
>     +
>             free_receive_bufs(vi);
> 
> What do you think?
> 
> Thanks,
> 
> -Koichiro Den
> 
> > 
> > > 
> > > 
> > > > 
> > > > [1]:
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
> > > >  drivers/net/virtio_net.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 64c87bb48a41..48ce8b3881b6 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -3054,7 +3054,6 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > > >  	if (err < 0)
> > > >  		goto err_xdp_reg_mem_model;
> > > >  
> > > > -	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
> > > >  	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> > > >  	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
> > > >  
> > > > @@ -6243,6 +6242,7 @@ static void free_unused_bufs(struct virtnet_info *vi)
> > > >  		struct virtqueue *vq = vi->sq[i].vq;
> > > >  		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > > >  			virtnet_sq_free_unused_buf(vq, buf);
> > > > +		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
> > > >  		cond_resched();
> > > >  	}
> > > >  
> > > > -- 
> > > > 2.43.0
> > > 


