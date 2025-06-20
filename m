Return-Path: <stable+bounces-155164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A1EAE1F75
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456DB5A6778
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B862DCC0B;
	Fri, 20 Jun 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CG3NTeXI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C552DF3D1
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434401; cv=none; b=OKYDtPF7IJkdRegZ6n7L2xqxMZTgmLh81d8B6o0KJh5FmVl+ebjpAGrsgNZTwiP31Tmm91mgsXNd6jonkXV5Fn5pa27yGxgi/VVtZ/XLf2cBXseHFijMEaKn7GHErWMmvJfL4OuqqyCAbgvL2rvkHk7M/F5Md/txp7lgJMk7Ytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434401; c=relaxed/simple;
	bh=C/IQ/m1qpO7T1Ze8i7NeL46Wli0AZMtQxfH19BQZtM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lJrKkX3vcPNwSoc/cvbey1o0IB1kZFUJPGoBRcRzn2jZyLYyY3tl6cVWVX6Onx0NdjGlaXYvPuGOIEtuBDaGlK7fwCLHJ+RY1M3GuKaqnJKYStbWoVZxgoMijtAXRF95LEWQgToYXECEpQxHMuuN42QKcQSvSt2WyM+Zq4raTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CG3NTeXI; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a58cd9b142so35805531cf.0
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750434398; x=1751039198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=judRg4QpdlCpkn08LtcNqonSln844QiiG4xQ820FNvY=;
        b=CG3NTeXIC32uajWCI9expEPZO03vlKvzkqFAXjBRSDrdyehaWbLE07S84np+lsD7w8
         cCT63PVRuLCLVzhoDNntYCJwjTUVq6a72l+0RV2QJvDv0kt2ne6sbh76RPEbAmIWeAzT
         H1SlHokXeCNCKdJiOvBtBKVmhVTu+Dvzi/1qL2Tku8ePRWvhBBBrdih46Y8PLbxvxz7A
         9W+SIR8OnSkHKhE3mkPjJ0Q/o1TQcsTJiN2qWDhQFxoV38dggGvtw66n2mu3s91qb5oD
         35QUPS/j50QT9CpURl6RI0ADG2kb35OKHkb+lUtDLp0YbqZhRUvWP+wgVkJuodSk+o2K
         zttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434398; x=1751039198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=judRg4QpdlCpkn08LtcNqonSln844QiiG4xQ820FNvY=;
        b=kbeV8TE4yxmHDa1Vbyyh42y7YDL9CFHYUvyoccpBsgPhY6Y5E2TUWO4MrZnECQz05U
         jGoC6PHb5b1Lvy7t8cxlioKRop984ofcfg4PhQnVXzjAiP/m1M4ENHM3BaukzWYJcLPj
         pScdyJ1qjQ1R8qINo4PKOhmUapsvD4aXHSnKbwHuuhEqZhivBo+2mk7zzT8tLmdoJrar
         YPxzA8EM0TnVTx622m6ofJTm5q1yXcl1MJWsGTI0KVeUhgQ8pku/h3OrY2nmouFH+2Ys
         71Ga6eJUw2o9q+/DEfZRuNwAi1XOXqGJKxpzhvMZ44UO3YH/ieb8pWyVHwMiMEqGOU3u
         SECQ==
X-Gm-Message-State: AOJu0YySJ2F+ohZiK7bgQ/BbCgZ4OxVtnavqzPOdKn1Q77IHY9btCwqj
	25hE8kDw5F0rtJbH8w/wg/34UMCkwy3euOE82UEbDlMlHjYQV+vr8HVhTGlogmV5EpPlKWF/j6n
	nEQkYPofD+JwgVBS3PZ0uoSfZI7Z1xxgh03CWyNOwq1D9k0vZdPRS24Jeif4tAXX+N1ABdlEJVJ
	jfCLjMFlBz6/TgAv/mUyaNDMXf80yUX4J4gVEBuN+N/Ey5e0s=
X-Google-Smtp-Source: AGHT+IFbdHy0FlGwQiGyYx6V2VCEMxJr9/XGCXn954iFejFaYEIl6IIS4Xd8SAyMFii2bGLIXCLc21FC0kzxFA==
X-Received: from qtbcj19.prod.google.com ([2002:a05:622a:2593:b0:4a6:fa3f:f95d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8e:b0:4a5:a7a8:fd83 with SMTP id d75a77b69052e-4a77a246f5fmr51561931cf.44.1750434398445;
 Fri, 20 Jun 2025 08:46:38 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:46:19 +0000
In-Reply-To: <20250620154623.331294-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025062025-unengaged-regroup-c3c7@gregkh> <20250620154623.331294-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620154623.331294-3-edumazet@google.com>
Subject: [PATCH 5.15.y 3/7] net_sched: sch_sfq: don't allow 1 packet limit
From: Eric Dumazet <edumazet@google.com>
To: stable@vger.kernel.org
Cc: Octavian Purdila <tavip@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Octavian Purdila <tavip@google.com>

commit 10685681bafce6febb39770f3387621bf5d67d0b upstream.

The current implementation does not work correctly with a limit of
1. iproute2 actually checks for this and this patch adds the check in
kernel as well.

This fixes the following syzkaller reported crash:

UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:210:6
index 65535 is out of range for type 'struct sfq_head[128]'
CPU: 0 PID: 2569 Comm: syz-executor101 Not tainted 5.10.0-smp-DEV #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
  __dump_stack lib/dump_stack.c:79 [inline]
  dump_stack+0x125/0x19f lib/dump_stack.c:120
  ubsan_epilogue lib/ubsan.c:148 [inline]
  __ubsan_handle_out_of_bounds+0xed/0x120 lib/ubsan.c:347
  sfq_link net/sched/sch_sfq.c:210 [inline]
  sfq_dec+0x528/0x600 net/sched/sch_sfq.c:238
  sfq_dequeue+0x39b/0x9d0 net/sched/sch_sfq.c:500
  sfq_reset+0x13/0x50 net/sched/sch_sfq.c:525
  qdisc_reset+0xfe/0x510 net/sched/sch_generic.c:1026
  tbf_reset+0x3d/0x100 net/sched/sch_tbf.c:319
  qdisc_reset+0xfe/0x510 net/sched/sch_generic.c:1026
  dev_reset_queue+0x8c/0x140 net/sched/sch_generic.c:1296
  netdev_for_each_tx_queue include/linux/netdevice.h:2350 [inline]
  dev_deactivate_many+0x6dc/0xc20 net/sched/sch_generic.c:1362
  __dev_close_many+0x214/0x350 net/core/dev.c:1468
  dev_close_many+0x207/0x510 net/core/dev.c:1506
  unregister_netdevice_many+0x40f/0x16b0 net/core/dev.c:10738
  unregister_netdevice_queue+0x2be/0x310 net/core/dev.c:10695
  unregister_netdevice include/linux/netdevice.h:2893 [inline]
  __tun_detach+0x6b6/0x1600 drivers/net/tun.c:689
  tun_detach drivers/net/tun.c:705 [inline]
  tun_chr_close+0x104/0x1b0 drivers/net/tun.c:3640
  __fput+0x203/0x840 fs/file_table.c:280
  task_work_run+0x129/0x1b0 kernel/task_work.c:185
  exit_task_work include/linux/task_work.h:33 [inline]
  do_exit+0x5ce/0x2200 kernel/exit.c:931
  do_group_exit+0x144/0x310 kernel/exit.c:1046
  __do_sys_exit_group kernel/exit.c:1057 [inline]
  __se_sys_exit_group kernel/exit.c:1055 [inline]
  __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:1055
 do_syscall_64+0x6c/0xd0
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x7fe5e7b52479
Code: Unable to access opcode bytes at RIP 0x7fe5e7b5244f.
RSP: 002b:00007ffd3c800398 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe5e7b52479
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fe5e7bcd2d0 R08: ffffffffffffffb8 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe5e7bcd2d0
R13: 0000000000000000 R14: 00007fe5e7bcdd20 R15: 00007fe5e7b24270

The crash can be also be reproduced with the following (with a tc
recompiled to allow for sfq limits of 1):

tc qdisc add dev dummy0 handle 1: root tbf rate 1Kbit burst 100b lat 1s
../iproute2-6.9.0/tc/tc qdisc add dev dummy0 handle 2: parent 1:10 sfq limit 1
ifconfig dummy0 up
ping -I dummy0 -f -c2 -W0.1 8.8.8.8
sleep 1

Scenario that triggers the crash:

* the first packet is sent and queued in TBF and SFQ; qdisc qlen is 1

* TBF dequeues: it peeks from SFQ which moves the packet to the
  gso_skb list and keeps qdisc qlen set to 1. TBF is out of tokens so
  it schedules itself for later.

* the second packet is sent and TBF tries to queues it to SFQ. qdisc
  qlen is now 2 and because the SFQ limit is 1 the packet is dropped
  by SFQ. At this point qlen is 1, and all of the SFQ slots are empty,
  however q->tail is not NULL.

At this point, assuming no more packets are queued, when sch_dequeue
runs again it will decrement the qlen for the current empty slot
causing an underflow and the subsequent out of bounds access.

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241204030520.2084663-2-tavip@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/sched/sch_sfq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 714bdc2c5a682a9767ce5e8a404aa7b4889604a6..505209a932ab73a91a0b15f990d4c9d7a206a05a 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -649,6 +649,10 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		if (!p)
 			return -ENOMEM;
 	}
+	if (ctl->limit == 1) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
+	}
 	sch_tree_lock(sch);
 	if (ctl->quantum)
 		q->quantum = ctl->quantum;
-- 
2.50.0.rc2.701.gf1e915cc24-goog


