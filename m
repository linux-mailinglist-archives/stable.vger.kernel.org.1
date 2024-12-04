Return-Path: <stable+bounces-98227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F759E32D8
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 06:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B56E16438B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 05:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A566F17A597;
	Wed,  4 Dec 2024 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sXXBhTxw"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD314A4E9
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288880; cv=none; b=Q8g1y0gyUWh9+do7h/22ym1I1fFN6JMCk0mpdEaTDKBvklglqysqOmS0ZWCmghokwdwLqtJ8T6gIhDqnZVePGzo99WNZ9Oc3TKDc4BbNSPte+E1H7cI6ESS4EQHr9akXIQ7m1TYQJA+AMVakM+9VZHYQn54IyDDxRHoof6szf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288880; c=relaxed/simple;
	bh=E6K2qhXKBZqacA8cIcKWmp7q2R60C0PDZf74XcJ1ptE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itnmUGaZ7EwsnwF2d7vz2Mz0ap8hZ5XknQ5HzISraH+JcpMrih5cNDruClJXuGNE57a5Be/kRYM/6Hw+XLXJ43its+mWrRHG29hRk0ljeA6JJ9FzTryOvyiIHymt6/DHQEelw+EUX/rTq01WJXusk8e7zGYUr23+aHB6njTZZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sXXBhTxw; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CD01740C4B
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288875;
	bh=HPspYRYMA8Krw+dq7W0oGtPutTxQv4jYXZxqmAy++mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=sXXBhTxwpJiCk3Fe+QjfWnEpmUi9v/jPS2kPckUQQ0m/i2GtM6juHh3yBkna0p4Wy
	 N6ouGobQdFeXoH1Dk0oQXqH6wRj99sI9jxZmBBbiOHI9W5J91aNMZzI/hTg8kIg+aS
	 BJOmN/on4KndtXx9n5SRY9ub2O9kOoDC5b4CaqbOomL2fHQjnwXCRfEFnjRyKt5AcT
	 OjjRG7nSHUXuIcGmnWFTpmgyVgoF6TeWbFJ/Ehxj5B1KEhPGRRP5hDLartYAnAM0p6
	 o69s4HVTIIfaXuahbracjazcPzWFMGRkh8chFe4fLZ5WcAI7oG6/I5/uHdFfyTANDG
	 Goe0TUFjNwFdw==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7fcff306a20so306631a12.0
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 21:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288874; x=1733893674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPspYRYMA8Krw+dq7W0oGtPutTxQv4jYXZxqmAy++mo=;
        b=Q33D2tMqlZsSngLJF+R1C1Hjut6fc8yGtoaWlEAo6CAqrlD35PHyZqnoe6+PtgX38d
         O9tcCmMJpYjBdne+RjRZK+BacRAVUvroK1XzVQI8h5N9emAts+FF+EfikCkgXkX7uZ2H
         HWZwlk10URUbRqB1ea+xMWeM2d+2Mdlxeobr+W5idRdyPKDIHUuCG8uELmbUcofJ41Q/
         RgwXNkmyyshj9WLskjfL8+4pbzPhcVI2XXcsytpRJFaSPvqtsHpieLLQQxpY5ZaSl2cm
         +OlfOb0iGInDXhPlfonSoBseOx1HbN6FdzNpit6p4Iv3VaewOjS4hoZtjsTtChlkw+SR
         b8HA==
X-Forwarded-Encrypted: i=1; AJvYcCWXEZdGcE+Y/nMY8x6RGEsKrwOceLHolT5DjfA1nu0bVkLJaGO3q6QaNWToqRLxXhEOY6Teooo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrnUIqtaGx2f0sC8kHFudlRrZfoygSX1ipiVjFAnuXlrKhHrRL
	SRhW2PEojWMRC89NHjJT9aVxG88GYnLrdqJE8QSB6oN5Lfl8WnHu0g299HJLuNaia+uFK49qrs9
	uJAMt+D6dchKCcAABOekAy5ghNL6NduHbIcJAeCezajB+XePX5k46sMCEbibLyGjGzNB4KQ==
X-Gm-Gg: ASbGnctR3I06ub8k6ztcxGfV3IrNR53v3/pCI4UMStSZXzIMx9SkdzMzAOoluBfLiYa
	ARZv0wG0JdD97MUFyWMWEPHSCm6rgnlHmw0ktkWP/YiV8QuqbWeXjuOMZzooan9YdnoCtEWGW8/
	NC5b1ni1cOfcU2l7o9iiZqy5f4byw7EgGV42VUzN9x35uR9AFHivkU1WU935VYKYiIpRCpa0qRR
	wJtlFbibFYc+hNwPkp51Je3lVhLZzvvIYlqZPIH11lXq6Ce0bAnN+5+FBI099UQfOBg
X-Received: by 2002:a05:6a21:33a1:b0:1d9:19bc:9085 with SMTP id adf61e73a8af0-1e165aac0e4mr8466215637.14.1733288874082;
        Tue, 03 Dec 2024 21:07:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsN9k6xrnXp0/S+euHyL/sc1Zt915RrbukH8WMzqI+Lfptb/W6Kj4WHOBELiBcGyANMEVGBw==
X-Received: by 2002:a05:6a21:33a1:b0:1d9:19bc:9085 with SMTP id adf61e73a8af0-1e165aac0e4mr8466178637.14.1733288873702;
        Tue, 03 Dec 2024 21:07:53 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:07:53 -0800 (PST)
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
Subject: [PATCH net-next v3 0/7] virtio_net: correct netdev_tx_reset_queue() invocation points
Date: Wed,  4 Dec 2024 14:07:17 +0900
Message-ID: <20241204050724.307544-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
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

This patch series resolves the issue and also addresses similar existing
problems:

(a). Drop netdev_tx_reset_queue() from open/close path. This eliminates the
     BQL crashes due to the problematic open/close path.

(b). As a result of (a), netdev_tx_reset_queue() is now explicitly required
     in freeze/restore path. Add netdev_tx_reset_queue() to
     free_unused_bufs().

(c). Fix missing resetting in virtnet_tx_resize().
     virtnet_tx_resize() has lacked proper resetting since commit
     c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits").

(d). Fix missing resetting in the XDP_SETUP_XSK_POOL path.
     Similar to (c), this path lacked proper resetting. Call
     netdev_tx_reset_queue() when virtqueue_reset() has actually recycled
     unused buffers.

This patch series consists of five commits:
  [1/7]: Resolves (a) and (b).
  [2/7[: Minor fix to make [3/7] streamlined.
  [3/7]: Prerequisite for (c) and (d).
  [4/7]: Prerequisite for (c).
  [5/7]: Resolves (c).
  [6/7]: Preresuisite for (d).
  [7/7]: Resolves (d).

Changes for v3:
  - replace 'flushed' argument with 'recycle_done'
Changes for v2:
  - add tx queue resetting for (b) to (d) above

v2: https://lore.kernel.org/all/20241203073025.67065-1-koichiro.den@canonical.com/
v1: https://lore.kernel.org/all/20241130181744.3772632-1-koichiro.den@canonical.com/


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
 ? security_capable+0x3b/0x7[I0
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


Koichiro Den (7):
  virtio_net: correct netdev_tx_reset_queue() invocation point
  virtio_ring: add a func argument 'recycle_done' to virtqueue_resize()
  virtio_net: replace vq2rxq with vq2txq where appropriate
  virtio_net: introduce virtnet_sq_free_unused_buf_done()
  virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
  virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
  virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx

 drivers/net/virtio_net.c     | 23 +++++++++++++++++------
 drivers/virtio/virtio_ring.c | 12 ++++++++++--
 include/linux/virtio.h       |  6 ++++--
 3 files changed, 31 insertions(+), 10 deletions(-)

-- 
2.43.0


