Return-Path: <stable+bounces-98777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B764A9E52AA
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7391B2810B1
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D0A1DB350;
	Thu,  5 Dec 2024 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpAiZszd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153C1D5AB8
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395312; cv=none; b=RVC67DHWo5Ts9085BkShIVvz8wCzJv7Z6ARfbnsexCdC25bZ92DZljwoadjfCsSdBNhkSf18UcqdmJ4DaJiN6NNP6QMGzt1lPVNqEBK6zCwA3QW8yvzsB501vuGfnMWe8WiIrCdCzB2vXuvVQhOYhUApd6kFAxDn/SGLdh8kS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395312; c=relaxed/simple;
	bh=TSZ4SO05quR2N/tCLeccMJzDLdG/4r5sRNkt9RfPCkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8nG3ckDdmVH5jxNpXebFhG8sFxbVZScoAHID9FkUooXsYYio8debe2NXIOv4eI/a/7wbpD1ueW+sAGIYCc/l03zYJhczy+FPbmeH9ErcJRX+/CXGMFdZqPqbRX7gLQ3Z69147fnd90llbhQ495NNoe3l/sMtkulrSG3bhusc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpAiZszd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733395308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FW+Wg7pQ3qsEcbqboe84VPuYnkq5MUKmVJHnWAGTL9I=;
	b=UpAiZszdVGkPamq/Yrx1GO2qTSs9vbRJCwfrPS0CbSHXdTNKRMdoMTSEOlJrZ2UgPiaHae
	fIQtIgsMm5icgihUcP3Tos81lneE7oYmKwHl7OWAnuhIK5C3XBDKXwkf4Ix4F8cAtYMJP3
	uCQicVC5I3uzhcd9A1YXtpmNAeFvshU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-Do13cj05P6aYJc3TgATbeA-1; Thu, 05 Dec 2024 05:41:47 -0500
X-MC-Unique: Do13cj05P6aYJc3TgATbeA-1
X-Mimecast-MFC-AGG-ID: Do13cj05P6aYJc3TgATbeA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385eb060d4fso1015690f8f.1
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 02:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395306; x=1734000106;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW+Wg7pQ3qsEcbqboe84VPuYnkq5MUKmVJHnWAGTL9I=;
        b=S8Aj7s2P0HbSYhlkcEPOQJf16FKUv/9OZcJtv+UzrXxPTv6e2aiz1fpSky01iI+HIw
         1Dz6UWkOVLsQVvLES+lQlTth/1EDZYodgWILy6ZJoEEFcrBHTGS4VP2ECMmwtucVQ6l8
         JgbXmg3WHXWeCi7BLwfHWaYb0JXCrPV6ZDJe4g+KhYJ8dFzvBU3sihhDsJ9UUjBLL1c2
         z8pZ5CKc5093R1BJLk14FV31A8mMDx8YoxAuV6cHm5ffuhFI9AuVMqD0EIBZP9EeNQuI
         8iGsXaE0Wd5kovRrH+pLAeZqcLJG6T8kNkdhR/B0Q/eKL9t2PWwRdTvu3CNZS7ZiVhJB
         Crvw==
X-Forwarded-Encrypted: i=1; AJvYcCWeyBYn+y51+m75tr2BzuVqE9CWawe2RGmihf7g4E0OzjctN7M464hNUxR8SKPnwTBnTkXHYwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF40KXrliJfO0hNKmuF/7r37w5duo6QCxu5TKyy6U+6Dye5FSk
	ELfBVkOJBGIyR1S/CkEY9rxwO2P2mY2RynGC44j5/wWbS3N3dj34Wxwr4pA8m/sMBogp0U1DDLf
	CKnfsVTZb1KTPs029yB7U+UpWNhrWHCKEggfXB5hcRinYVrUJWNPh7g==
X-Gm-Gg: ASbGnctgLzBtdoZ6v+bTuMrvbuu0QkuHaJCbCTDsn0RrQX4/d7HZaGa7QxGO3QSFxIl
	/T+4m098M+FIk/4Cc2HaPUvKtzZuw6T9Adsv0SUUNVAp5B2Ui+Y+13hql9NeDEYelQhNONllZuh
	JdA2EqyVybg8JvK7VG8/IdAhWT+/JpyWw/Qqyt05Ilixor7UOt7SisjNNbTVu6cev5GHcft+amW
	qX9/Y44Fb0KNISUA+c/5iKeJm0OfkSqs/uapyk=
X-Received: by 2002:a5d:5f4b:0:b0:385:e879:45cf with SMTP id ffacd0b85a97d-3861bb4c763mr2295325f8f.1.1733395305996;
        Thu, 05 Dec 2024 02:41:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGL2yo4llIHnvMvig5JL3mvdVA/OxJnDLLXJIS5OXUqG2qNZSrXvpP6Ku+Mc1G3x72lXMnRZA==
X-Received: by 2002:a5d:5f4b:0:b0:385:e879:45cf with SMTP id ffacd0b85a97d-3861bb4c763mr2295298f8f.1.1733395305568;
        Thu, 05 Dec 2024 02:41:45 -0800 (PST)
Received: from redhat.com ([2.55.188.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219096d8sm1623386f8f.78.2024.12.05.02.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:41:43 -0800 (PST)
Date: Thu, 5 Dec 2024 05:41:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/7] virtio_net: correct
 netdev_tx_reset_queue() invocation points
Message-ID: <20241205054100-mutt-send-email-mst@kernel.org>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241204050724.307544-1-koichiro.den@canonical.com>

On Wed, Dec 04, 2024 at 02:07:17PM +0900, Koichiro Den wrote:
> When virtnet_close is followed by virtnet_open, some TX completions can
> possibly remain unconsumed, until they are finally processed during the
> first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
> [1]. Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() call
> before RX napi enable") was not sufficient to eliminate all BQL crash
> cases for virtio-net.
>=20
> This issue can be reproduced with the latest net-next master by running:
> `while :; do ip l set DEV down; ip l set DEV up; done` under heavy network
> TX load from inside the machine.
>=20
> This patch series resolves the issue and also addresses similar existing
> problems:
>=20
> (a). Drop netdev_tx_reset_queue() from open/close path. This eliminates t=
he
>      BQL crashes due to the problematic open/close path.
>=20
> (b). As a result of (a), netdev_tx_reset_queue() is now explicitly requir=
ed
>      in freeze/restore path. Add netdev_tx_reset_queue() to
>      free_unused_bufs().
>=20
> (c). Fix missing resetting in virtnet_tx_resize().
>      virtnet_tx_resize() has lacked proper resetting since commit
>      c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits").
>=20
> (d). Fix missing resetting in the XDP_SETUP_XSK_POOL path.
>      Similar to (c), this path lacked proper resetting. Call
>      netdev_tx_reset_queue() when virtqueue_reset() has actually recycled
>      unused buffers.
>=20
> This patch series consists of five commits:
>   [1/7]: Resolves (a) and (b).
>   [2/7[: Minor fix to make [3/7] streamlined.
>   [3/7]: Prerequisite for (c) and (d).
>   [4/7]: Prerequisite for (c).
>   [5/7]: Resolves (c).
>   [6/7]: Preresuisite for (d).
>   [7/7]: Resolves (d).
>=20
> Changes for v3:
>   - replace 'flushed' argument with 'recycle_done'
> Changes for v2:
>   - add tx queue resetting for (b) to (d) above
>=20
> v2: https://lore.kernel.org/all/20241203073025.67065-1-koichiro.den@canon=
ical.com/
> v1: https://lore.kernel.org/all/20241130181744.3772632-1-koichiro.den@can=
onical.com/



Overall looks good, but I think this is net material, not net-next.

Sent some suggestions for cosmetic changes.

>=20
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
>  ? security_capable+0x3b/0x7=1B[I0
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
>=20
>=20
> Koichiro Den (7):
>   virtio_net: correct netdev_tx_reset_queue() invocation point
>   virtio_ring: add a func argument 'recycle_done' to virtqueue_resize()
>   virtio_net: replace vq2rxq with vq2txq where appropriate
>   virtio_net: introduce virtnet_sq_free_unused_buf_done()
>   virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
>   virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
>   virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx
>=20
>  drivers/net/virtio_net.c     | 23 +++++++++++++++++------
>  drivers/virtio/virtio_ring.c | 12 ++++++++++--
>  include/linux/virtio.h       |  6 ++++--
>  3 files changed, 31 insertions(+), 10 deletions(-)
>=20
> --=20
> 2.43.0


