Return-Path: <stable+bounces-100396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9D89EADDB
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 11:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184201651BF
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304541DC982;
	Tue, 10 Dec 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCStdYEl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FE78F40
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826018; cv=none; b=ZbmwMfA6mZpfUyRpf7vlzkWo1/H55e3DxTr//bfXhcUc5tN41FdlGHGaUCb9qH5nxRmS7cIQUJu/xXUOPhaen7hyER+Jntu55tu/vUc2OEfSSQ2S5BBSGxmWmyz8q8rgxy6DYla0vBt14hCzNiXP8cukQq9nKJMZi8n11LQXHp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826018; c=relaxed/simple;
	bh=hCKMGqv40wXMr2vadxbAoiwrAluRIL2zTopknFGintM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lu9v644+HeDT5LpAh65HWOT7NYwgafpnBX6uTvaRXpx691n5xWbVyAZ987bgU1/m6dtd2H8wKsCC7AOw1BmKk3MHsmMiBtuyDN2OJezseWk5DMIKWLmEfcb7FO3VdYwTUymvZgN8Tvib787sQISGOSlyg/jhOeX6yHvW0xuEhLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCStdYEl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733826015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCF2E9mCYdGeADz8ePCZvEf0wcVUvNdfcznRREMbGlI=;
	b=YCStdYElXzH4PVXgtxfqnPvNoxAObKAW/QmPhYMrSulWviDXvDVitjbxQ509+afGDNUuiS
	oTETfSQ19s32iimrTU/Oa+HelaaonCy0J+mBdQn7WxSaGl2s/J2SVqrB4FvVssPID8TfZ9
	0jNvV+sudz/eKLSBfB1YtDnTPFPOwqo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-sNHbXC4fNLOMMW9PWFxYUw-1; Tue, 10 Dec 2024 05:20:14 -0500
X-MC-Unique: sNHbXC4fNLOMMW9PWFxYUw-1
X-Mimecast-MFC-AGG-ID: sNHbXC4fNLOMMW9PWFxYUw
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8d44e17a2so29736876d6.3
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 02:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733826013; x=1734430813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCF2E9mCYdGeADz8ePCZvEf0wcVUvNdfcznRREMbGlI=;
        b=NYLh3kWrm0Lgs0iLpHcgXExkf3ll/UfwDucNH16I4qE7v0V8FuDixej033X5ddahlB
         IL9iytXRz3g8DlYrBVsuKEKOgeRbSbOeycv2GCvVUCN6/9KM7gWfhy07Zn7JDQ57tEoh
         E5kQYlZU9gkr4Ma42c5UkdJL97bGet9bSmaTYhQtLo+xuQ1IoaPCUkWnIzjNhHx9RAoX
         5OT227CrSChKZzm8Keu2HxxqsLdHFaLy0XCpCdDz+vxFd5qJF4xbjef7ezeRJQNX3aZU
         Zml+NffzUKKFps6YADtyt69Hdj3nshQS3ytw2/HpwUsq8JnHY/D8mliCDU3YTF3ybZHt
         qMTA==
X-Forwarded-Encrypted: i=1; AJvYcCVi9KH/K9QUDNMPOkMY0h8sNIQiobYEKxEOpH95l8MGzZsUI0N7Oh2wu5mIqLUUMf0Me55xYWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaD4Dyf4FKGbtslJJXmqyGxPVxdAoHintetjn6ibB+cIeFIJAm
	8j1uKdlLpkw7abwEZNY4DPri8h6I40IUOLC0IN326WqDjXWAmJ2sYK/x242bpD3pDGj3m5swzMH
	qMRTU0F3FBChfH9qaeRNcN9xkKDAoLYi/82flvMrtnIH9mZ1ogvkYcA==
X-Gm-Gg: ASbGncvlFbDBsstZ14OOQB+mpm1IpZgrPRvKob17BmdSrjxu1GZAz+KchgxB9xdM61t
	b35QISMlA+DSOrT7j2I4VaBmbV+p8JUuqJqcKZL3p72g2jgxg53X8McA8n0tCV4et7enlwh7A7u
	N/l0ja0uLOi1iVb9jdLqmrjecFpyNk0ravhvp8zJskNO3DSj7WrPfxssexRVvxotlhGBUB9yx3X
	E5BlD7r+wmeWmiNdGoHkuUzs7xgRiSCxnTaVWmXxXWiH7I1FV6mpSZBIHSy7CUwBJ2c5WbaEADA
	AZMPa+TF4McSbVg7J+yYF6EgoQ==
X-Received: by 2002:ad4:5c49:0:b0:6d4:139c:cef0 with SMTP id 6a1803df08f44-6d91e361a58mr71303036d6.22.1733826013337;
        Tue, 10 Dec 2024 02:20:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGoxN0wLBCmDWM78sXt5u4pFuGJDHHmRq9wGyq58trvWfia+wMtQwT+LoUjwJpmMgQS6SKSA==
X-Received: by 2002:ad4:5c49:0:b0:6d4:139c:cef0 with SMTP id 6a1803df08f44-6d91e361a58mr71302706d6.22.1733826012978;
        Tue, 10 Dec 2024 02:20:12 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6b651asm58363226d6.69.2024.12.10.02.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:20:12 -0800 (PST)
Message-ID: <75967109-85e4-46ce-9952-94dcb98f5513@redhat.com>
Date: Tue, 10 Dec 2024 11:20:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/6] virtio_net: correct netdev_tx_reset_queue()
 invocation point
To: Koichiro Den <koichiro.den@canonical.com>, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241206011047.923923-1-koichiro.den@canonical.com>
 <20241206011047.923923-2-koichiro.den@canonical.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241206011047.923923-2-koichiro.den@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 02:10, Koichiro Den wrote:
> When virtnet_close is followed by virtnet_open, some TX completions can
> possibly remain unconsumed, until they are finally processed during the
> first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
> [1]. Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() call
> before RX napi enable") was not sufficient to eliminate all BQL crash
> cases for virtio-net.
> 
> This issue can be reproduced with the latest net-next master by running:
> `while :; do ip l set DEV down; ip l set DEV up; done` under heavy network
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
> eliminates the BQL crashes. As a result, netdev_tx_reset_queue() is now
> explicitly required in freeze/restore path. This patch adds it to
> immediately after free_unused_bufs(), following the rule of thumb:
> netdev_tx_reset_queue() should follow any SKB freeing not followed by
> netdev_tx_completed_queue(). This seems the most consistent and
> streamlined approach, and now netdev_tx_reset_queue() runs whenever
> free_unused_bufs() is done.
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

IIRC, the above separator used to cause some troubles to backport tools
and to 'next' tree import, trimming the SoB area below. I'm going to
remove it while applying the series.

Cheers,

Paolo


