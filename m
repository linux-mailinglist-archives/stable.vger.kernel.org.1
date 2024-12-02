Return-Path: <stable+bounces-95919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE749DF9D6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 05:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFE9281860
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 04:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DAD1DF240;
	Mon,  2 Dec 2024 04:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLxpwJ2m"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1081494DD
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 04:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113390; cv=none; b=YsjLSNZliqIcuin60GY2tTIjxO3ralwDG2+6CJmPvHiqr+nnFt3MN9hBoubpsh4iC8OoedTdi9fN1UMOrmRSktw+rVHl/p5sGeAVszgwBj7qVLUvwBGbWZOgyPts4CjHH6Q3kgJmMa/PObJyNjs2od3447vxDOIagW7JHvypuXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113390; c=relaxed/simple;
	bh=BtDj3Jn1p4XddOUYKJeUyykmbwIQJEUf7APeL0nqLRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvmmeRmbf52lwerSH250QLJrT6mpG4CZBwYuS5rqPEOBgD3x/acWDKRu1qqHfSqaYmRqje6LQEe/rYbSSfUqW305iVx7hZ0oIvhAs6AGcDCQg5xzY85xCy6L7OSE7wQiM60NoqkFdS/yFmiNtbvWJtA/Le0+ekbbRpChjaIzCxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLxpwJ2m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733113387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bN8jo5o/G23jMRb4xBa2K5RI+g96XY2EN/KaTeqqrcw=;
	b=ZLxpwJ2mHyZ2rE45rPv5NVr7SNogEKDxx6MKCJ7EdlIgeq4lK59kitRqLyp++4SmY2TbGM
	wSgDO09WuW6Xbjq7j4iDJC40CSedOZ1eFeYRJn7w+zBk2VtBv3QsaUNyES+2C+NcGSDm9C
	vYHZ7ml3+YMhJGcE+s2fm6U+Hv9/fc4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-3Rcu_WfLORyA49mpuOdDDA-1; Sun, 01 Dec 2024 23:23:06 -0500
X-MC-Unique: 3Rcu_WfLORyA49mpuOdDDA-1
X-Mimecast-MFC-AGG-ID: 3Rcu_WfLORyA49mpuOdDDA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee4f3785f6so2518135a91.2
        for <stable@vger.kernel.org>; Sun, 01 Dec 2024 20:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113385; x=1733718185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bN8jo5o/G23jMRb4xBa2K5RI+g96XY2EN/KaTeqqrcw=;
        b=ocO7h+yFQSRlsR3+CSbEHOWykE2v2I6c57icJX8P+lun4UEnPGAuLdYm/5AH2l99xD
         m1oQaM0G/Zir4k2iIznBUEzOUiGwZEo1cZ7Dk7vOvNQUYdyjODucBm+Y9gKTaEGQuZ3Y
         vPxpOKCiuUW1yLwSGb2dQclSIcFM9qXgjKzaESpPKIRfS8vpZutriRuxFkqYhCCn3psi
         gz8LgngrJRFB9NE0/Xtrmpf4WQprI1LfJXY6WU4Xh2HHmguSjqqeRbfPDqIKfUf9hZ8A
         CE0caTLRhCg5XXSiBGeXu4jy/xfNShPVYOeLFdLEjYRNUgk5UpGm/kr+kDjwah0IlB67
         7SHg==
X-Forwarded-Encrypted: i=1; AJvYcCXo/Xw93tBo/YpqB8o0/QYwPEZ44v+Etp+rygAfVoJpSN7+TovRkN8Sn7Cyp8mMQf2WT7EEUWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwncH5IqziOIFMlxWM8XXKGoa82B43aeq1JwAqOSoY0zsMFxDtb
	WmFcd3kKaWilwd7JBxo6urmcONoxk5m+loEB9vyntlLtwGprNdcNJ4v81sZsciztbh23KyT6juj
	zGGy11ppJOQMTl96Qk3uXnIYft9YF+5fs7jOHeLqvA8U9eJSyqZzJTY3BY9dn1aiQsBNw4VvAdH
	vdLGHcQo9IWbi4qljCNrzx9Q5tDHON
X-Gm-Gg: ASbGncsbE6yDkJ04pSTApwRluMGVV7Xt5uQvLjKIkuHg6+W3QSe3HhjQ4pTc7qSSfox
	B8xjiKQ3HUDw1jX/qJPdY/ktzLmh29hy3
X-Received: by 2002:a17:90b:3a82:b0:2ea:853b:2776 with SMTP id 98e67ed59e1d1-2ee08e9d51dmr25931914a91.3.1733113385360;
        Sun, 01 Dec 2024 20:23:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoulHhNSHJub0lq6wi98G7/i3YNMT8O4dsEPxox0g8dq7PdRKvgY7rRKGqkjuBwalhSEe2d/MtzZ2f396Mghw=
X-Received: by 2002:a17:90b:3a82:b0:2ea:853b:2776 with SMTP id
 98e67ed59e1d1-2ee08e9d51dmr25931883a91.3.1733113384735; Sun, 01 Dec 2024
 20:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130181744.3772632-1-koichiro.den@canonical.com>
In-Reply-To: <20241130181744.3772632-1-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 2 Dec 2024 12:22:53 +0800
Message-ID: <CACGkMEtmH9ukthh+DGCP5cJDrR=o9ML_1tF8nfS-rFa+NrijdA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: drop netdev_tx_reset_queue() from virtnet_enable_queue_pair()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 2:18=E2=80=AFAM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtnet_close is followed by virtnet_open, some TX completions can
> possibly remain unconsumed, until they are finally processed during the
> first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
> [1]. Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() call
> before RX napi enable") seems not sufficient to eliminate all BQL crash
> scenarios for virtio-net.
>
> This issue can be reproduced with the latest net-next master by running:
> `while :; do ip l set DEV down; ip l set DEV up; done` under heavy networ=
k
> TX load from inside the machine.
>
> netdev_tx_reset_queue() can actually be dropped from virtnet_open path;
> the device is not stopped in any case. For BQL core part, it's just like
> traffic nearly ceases to exist for some period. For stall detector added
> to BQL, even if virtnet_close could somehow lead to some TX completions
> delayed for long, followed by virtnet_open, we can just take it as stall
> as mentioned in commit 6025b9135f7a ("net: dqs: add NIC stall detector
> based on BQL"). Note also that users can still reset stall_max via sysfs.
>
> So, drop netdev_tx_reset_queue() from virtnet_enable_queue_pair(). This
> eliminates the BQL crashes. With this patch, virtio-net performs only
> one dql_reset() per probe.
>
> [1]:
> ------------[ cut here ]------------
> kernel BUG at lib/dynamic_queue_limits.c:99!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0net-next_main+ #2
> Tainted: [N]=3DTEST
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
>  ? security_capable+0x3b/0x70
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
> Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


