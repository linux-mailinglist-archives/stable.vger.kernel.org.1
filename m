Return-Path: <stable+bounces-98228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9679E32DE
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 06:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC93B23FC8
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 05:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E609185B54;
	Wed,  4 Dec 2024 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="I6baVxVz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CD5181CE1
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288884; cv=none; b=mv7fkbMX2C+5NzbByqUEgzA+atfK4yfmrhvmZdZ8Mjdiev0ZDsQgN0jCXp7UEjEvbuhIkZ1qejpglq6nb556+rroSOGI7T0KVQlk0HWVEW1nkeHEbLeR9+7wcNs/KWVxhsNWOidNhrseK1gGmydPspctFmnm2242qcjUW/eCZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288884; c=relaxed/simple;
	bh=hM3TSWI+eWAZK1GQuQ4ljeW5GtUNvTvSlHAiQfkse1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrHfbbM8O4uPSMdQhlHPhjL52ecNxvbt/tX801PAPR2yE3YoOX5K/3qxNTs4Tc2xKkG8wHAI8AmN4oy99yI47SijLKXjC8K9Nr78Z/qXNSjbP2W79jx0+DCkvtKk8pJFb+QDCfkYvFWrdpsV48VxZ6LxbcUJs/lUDA0gHrTK9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=I6baVxVz; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D4C7440CD6
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288879;
	bh=rn0yafvxR+rgXFWM/3BvoQL8ErZXVisWsjUhy9aKjNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=I6baVxVzaJoROpEDsE/3ey2a/MR95NEYvdS2ZbXTchMDbkaTPeXujg6bd/MDD6xav
	 1iZzK7EHwTXDtiuvbrujMULmu5770LJbqMfYZ6PPRbb9halC0FIR3LMDeKLH2ebqAH
	 G2veu2XGTH+KJDCXSZd0E7eQH2swHOeDVZPQ3l1T6m/6IzimOMoxNHi4d3inziN2io
	 Opq5CNH2FPaG2kSSUkNysJyLU0GBLlJeMZLPxx/47yehdWdJSqnKLIF6RQ1E/v+QLm
	 O5twUyLgsf0eyDaQHbnmJnM/Dav00udrIZgh66ukhOh0iteDRZuCshyqhV+8QvSErh
	 6ejeoQXR147eQ==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7ea8baba60dso7556400a12.3
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 21:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288878; x=1733893678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rn0yafvxR+rgXFWM/3BvoQL8ErZXVisWsjUhy9aKjNw=;
        b=Emygd1/MpzXwdZzMaRbzovi87NkPSeGMDNYOUNPkqjZo1Th1RwAs8ErndO996htmAt
         gzUuxJshR8coV5yUWC68xxrrqoTYZIuZ55N2e8xKy6pwKcA6JORcoAlvBdwWgT0r5Vy3
         OoC21oCKHA/3ZzSwQP1k12h+Y0BJPV235DFV3nphdv2F+11PwXFFfb6qsgl1UVy77edS
         AAILugqfzLWWijop7kq8IaUIyU06HMif1dQHgOSQC9EVIvX6dgjfK7hkK+8IcXvLHwem
         0ka9LVG1bcA7DQiVx2OrXkPdCY3K5iU4TbKlwnyVABeT777W27W5qCEQu7TCyolIplX5
         BHQw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Q/47mQvkdO/GvHtkurzp1t4sgTON32nQYV7GcfRbt6oletL6cAPjvxibHe8xUHP5Dsew/qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRdCBXsDQLQu7KB3uu7SB+mcvYghFzBSNxWFRBMus4f8CnIJ5Q
	vEoqNASq2Cn7epIKZRd4gfpERlO93Cdw4zHIhc+7IbJtnwlW01crDiTYmU7E7AlNmZx6q091UhU
	aRsCWouhX9Mxi22gZN9mxh92y7ke4XBZnPTs91gfg23bK1VP59Il6M9AJXeVdSWkN6FNYKA==
X-Gm-Gg: ASbGncuLEJyeFtsqTnABIwPLjR+XU0H2NfKaJkpbUSWVDbqJP/HdObBCZ5ZBcOUbq+E
	3gWzEa5u9vXOF3yt1+KMek7DDs+lqW434gRAnePrfTIaoou9k/JNJxcXCmW92S7v9737ZQRtHjO
	LGhgWnOXXhKGlOBs9cixl2zufgi+T9xjtv5klCasB3XqKhUAU+ZsMCKdLlePTo3md9kzYfd0Ii0
	c1D6jm9ObArmmut/gkgGtlNrom1kKXwM67RIpr/OLgI3W4kZWAL1IiaIDcCmk+KyRHk
X-Received: by 2002:a05:6a21:99a7:b0:1e0:cfc0:df34 with SMTP id adf61e73a8af0-1e1653b7b73mr7608971637.16.1733288878288;
        Tue, 03 Dec 2024 21:07:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEysp0HtOVqClK9sw+sZa+rGz782YX2HQNluIEnhdoS3IDFDXbm7mTKBDtu+0lCElrabYClkw==
X-Received: by 2002:a05:6a21:99a7:b0:1e0:cfc0:df34 with SMTP id adf61e73a8af0-1e1653b7b73mr7608940637.16.1733288877916;
        Tue, 03 Dec 2024 21:07:57 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:07:57 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v3 1/7] virtio_net: correct netdev_tx_reset_queue() invocation point
Date: Wed,  4 Dec 2024 14:07:18 +0900
Message-ID: <20241204050724.307544-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204050724.307544-1-koichiro.den@canonical.com>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When virtnet_close is followed by virtnet_open, some TX completions can
possibly remain unconsumed, until they are finally processed during the
first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
[1]. Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() call
before RX napi enable") was not sufficient to eliminate all BQL crash
cases for virtio-net.

This issue can be reproduced with the latest net-next master by running:
`while :; do ip l set DEV down; ip l set DEV up; done` under heavy network
TX load from inside the machine.

netdev_tx_reset_queue() can actually be dropped from virtnet_open path;
the device is not stopped in any case. For BQL core part, it's just like
traffic nearly ceases to exist for some period. For stall detector added
to BQL, even if virtnet_close could somehow lead to some TX completions
delayed for long, followed by virtnet_open, we can just take it as stall
as mentioned in commit 6025b9135f7a ("net: dqs: add NIC stall detector
based on BQL"). Note also that users can still reset stall_max via sysfs.

So, drop netdev_tx_reset_queue() from virtnet_enable_queue_pair(). This
eliminates the BQL crashes. Note that netdev_tx_reset_queue() is now
explicitly required in freeze/restore path, so this patch adds it to
free_unused_bufs().

[1]:
------------[ cut here ]------------
kernel BUG at lib/dynamic_queue_limits.c:99!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0net-next_main+ #2
Tainted: [N]=TEST
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), \
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:dql_completed+0x26b/0x290
Code: b7 c2 49 89 e9 44 89 da 89 c6 4c 89 d7 e8 ed 17 47 00 58 65 ff 0d
4d 27 90 7e 0f 85 fd fe ff ff e8 ea 53 8d ff e9 f3 fe ff ff <0f> 0b 01
d2 44 89 d1 29 d1 ba 00 00 00 00 0f 48 ca e9 28 ff ff ff
RSP: 0018:ffffc900002b0d08 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffff888102398c80 RCX: 0000000080190009
RDX: 0000000000000000 RSI: 000000000000006a RDI: 0000000000000000
RBP: ffff888102398c00 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000000ca R11: 0000000000015681 R12: 0000000000000001
R13: ffffc900002b0d68 R14: ffff88811115e000 R15: ffff8881107aca40
FS:  00007f41ded69500(0000) GS:ffff888667dc0000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556ccc2dc1a0 CR3: 0000000104fd8003 CR4: 0000000000772ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 ? die+0x32/0x80
 ? do_trap+0xd9/0x100
 ? dql_completed+0x26b/0x290
 ? dql_completed+0x26b/0x290
 ? do_error_trap+0x6d/0xb0
 ? dql_completed+0x26b/0x290
 ? exc_invalid_op+0x4c/0x60
 ? dql_completed+0x26b/0x290
 ? asm_exc_invalid_op+0x16/0x20
 ? dql_completed+0x26b/0x290
 __free_old_xmit+0xff/0x170 [virtio_net]
 free_old_xmit+0x54/0xc0 [virtio_net]
 virtnet_poll+0xf4/0xe30 [virtio_net]
 ? __update_load_avg_cfs_rq+0x264/0x2d0
 ? update_curr+0x35/0x260
 ? reweight_entity+0x1be/0x260
 __napi_poll.constprop.0+0x28/0x1c0
 net_rx_action+0x329/0x420
 ? enqueue_hrtimer+0x35/0x90
 ? trace_hardirqs_on+0x1d/0x80
 ? kvm_sched_clock_read+0xd/0x20
 ? sched_clock+0xc/0x30
 ? kvm_sched_clock_read+0xd/0x20
 ? sched_clock+0xc/0x30
 ? sched_clock_cpu+0xd/0x1a0
 handle_softirqs+0x138/0x3e0
 do_softirq.part.0+0x89/0xc0
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xa7/0xb0
 virtnet_open+0xc8/0x310 [virtio_net]
 __dev_open+0xfa/0x1b0
 __dev_change_flags+0x1de/0x250
 dev_change_flags+0x22/0x60
 do_setlink.isra.0+0x2df/0x10b0
 ? rtnetlink_rcv_msg+0x34f/0x3f0
 ? netlink_rcv_skb+0x54/0x100
 ? netlink_unicast+0x23e/0x390
 ? netlink_sendmsg+0x21e/0x490
 ? ____sys_sendmsg+0x31b/0x350
 ? avc_has_perm_noaudit+0x67/0xf0
 ? cred_has_capability.isra.0+0x75/0x110
 ? __nla_validate_parse+0x5f/0xee0
 ? __pfx___probestub_irq_enable+0x3/0x10
 ? __create_object+0x5e/0x90
 ? security_capable+0x3b/0x70
 rtnl_newlink+0x784/0xaf0
 ? avc_has_perm_noaudit+0x67/0xf0
 ? cred_has_capability.isra.0+0x75/0x110
 ? stack_depot_save_flags+0x24/0x6d0
 ? __pfx_rtnl_newlink+0x10/0x10
 rtnetlink_rcv_msg+0x34f/0x3f0
 ? do_syscall_64+0x6c/0x180
 ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
 ? __pfx_rtnetlink_rcv_msg+0x10/0x10
 netlink_rcv_skb+0x54/0x100
 netlink_unicast+0x23e/0x390
 netlink_sendmsg+0x21e/0x490
 ____sys_sendmsg+0x31b/0x350
 ? copy_msghdr_from_user+0x6d/0xa0
 ___sys_sendmsg+0x86/0xd0
 ? __pte_offset_map+0x17/0x160
 ? preempt_count_add+0x69/0xa0
 ? __call_rcu_common.constprop.0+0x147/0x610
 ? preempt_count_add+0x69/0xa0
 ? preempt_count_add+0x69/0xa0
 ? _raw_spin_trylock+0x13/0x60
 ? trace_hardirqs_on+0x1d/0x80
 __sys_sendmsg+0x66/0xc0
 do_syscall_64+0x6c/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f41defe5b34
Code: 15 e1 12 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00
f3 0f 1e fa 80 3d 35 95 0f 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00
f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
RSP: 002b:00007ffe5336ecc8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f41defe5b34
RDX: 0000000000000000 RSI: 00007ffe5336ed30 RDI: 0000000000000003
RBP: 00007ffe5336eda0 R08: 0000000000000010 R09: 0000000000000001
R10: 00007ffe5336f6f9 R11: 0000000000000202 R12: 0000000000000003
R13: 0000000067452259 R14: 0000556ccc28b040 R15: 0000000000000000
 </TASK>
[...]
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 64c87bb48a41..48ce8b3881b6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3054,7 +3054,6 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
-	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
 	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
 
@@ -6243,6 +6242,7 @@ static void free_unused_bufs(struct virtnet_info *vi)
 		struct virtqueue *vq = vi->sq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_sq_free_unused_buf(vq, buf);
+		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
 		cond_resched();
 	}
 
-- 
2.43.0


