Return-Path: <stable+bounces-45069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1888C559A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC63281DD5
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487F029D06;
	Tue, 14 May 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PPh8vuuG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DEA1CAA4;
	Tue, 14 May 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687991; cv=none; b=c8VEkHax92O4Cg0jfj0dLfyDtiD+qLm5B5Ozorn9CllBuPMQ9YsQUv7PeFIGcvSDG5YpscRsR+fj0p0lws9WbgHk4C1Rbpsi1+RSDlj+Z/JfAw7/LxXkUzGZTLf+8rF7wffciPyIhKaqGpjso6qlptjv0PLrgPVPEONgU9U3bz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687991; c=relaxed/simple;
	bh=nNWLFitFDnEvSxkYUu+trfAUhA0LRiFqA3VGntHP0Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYBfTAgcEEqJWqC3/CHp3aun6Uf74UKHTkg3ex1IMnuukBAPG+BGgLlKde7aOkBGxH9rQdsdQNvsCIf4FN4qV3yY+m3P3e/QyKg1U0XxCtRUoFd6B69IR1sA529Jt3wzrAxtYKM7/0faFthG+G4VubGgaLL7dyCA/VkdJtV71uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PPh8vuuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8217BC2BD10;
	Tue, 14 May 2024 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687990;
	bh=nNWLFitFDnEvSxkYUu+trfAUhA0LRiFqA3VGntHP0Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPh8vuuGAKfynPY+LEQ4zo212OmztYMn8FRFIk0aSIb48gLy90pb7cSpEpe3zVLsh
	 YK8M1lm7QBNWzWasFfqQZrbHgQueNH4uO4QOlrPG8QhISvuObZm5+r80ILKBwhYHQ3
	 bZq6zzCZJ5ned11DFPPZ/0omWwTZ3nCzsfc9L4Vo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Paasch <cpaasch@apple.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 151/168] mptcp: ensure snd_nxt is properly initialized on connect
Date: Tue, 14 May 2024 12:20:49 +0200
Message-ID: <20240514101012.461204108@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit fb7a0d334894206ae35f023a82cad5a290fd7386 upstream.

Christoph reported a splat hinting at a corrupted snd_una:

  WARNING: CPU: 1 PID: 38 at net/mptcp/protocol.c:1005 __mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
  Modules linked in:
  CPU: 1 PID: 38 Comm: kworker/1:1 Not tainted 6.9.0-rc1-gbbeac67456c9 #59
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
  Workqueue: events mptcp_worker
  RIP: 0010:__mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
  Code: be 06 01 00 00 bf 06 01 00 00 e8 a8 12 e7 fe e9 00 fe ff ff e8
  	8e 1a e7 fe 0f b7 ab 3e 02 00 00 e9 d3 fd ff ff e8 7d 1a e7 fe
  	<0f> 0b 4c 8b bb e0 05 00 00 e9 74 fc ff ff e8 6a 1a e7 fe 0f 0b e9
  RSP: 0018:ffffc9000013fd48 EFLAGS: 00010293
  RAX: 0000000000000000 RBX: ffff8881029bd280 RCX: ffffffff82382fe4
  RDX: ffff8881003cbd00 RSI: ffffffff823833c3 RDI: 0000000000000001
  RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
  R10: 0000000000000000 R11: fefefefefefefeff R12: ffff888138ba8000
  R13: 0000000000000106 R14: ffff8881029bd908 R15: ffff888126560000
  FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f604a5dae38 CR3: 0000000101dac002 CR4: 0000000000170ef0
  Call Trace:
   <TASK>
   __mptcp_clean_una_wakeup net/mptcp/protocol.c:1055 [inline]
   mptcp_clean_una_wakeup net/mptcp/protocol.c:1062 [inline]
   __mptcp_retrans+0x7f/0x7e0 net/mptcp/protocol.c:2615
   mptcp_worker+0x434/0x740 net/mptcp/protocol.c:2767
   process_one_work+0x1e0/0x560 kernel/workqueue.c:3254
   process_scheduled_works kernel/workqueue.c:3335 [inline]
   worker_thread+0x3c7/0x640 kernel/workqueue.c:3416
   kthread+0x121/0x170 kernel/kthread.c:388
   ret_from_fork+0x44/0x50 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   </TASK>

When fallback to TCP happens early on a client socket, snd_nxt
is not yet initialized and any incoming ack will copy such value
into snd_una. If the mptcp worker (dumbly) tries mptcp-level
re-injection after such ack, that would unconditionally trigger a send
buffer cleanup using 'bad' snd_una values.

We could easily disable re-injection for fallback sockets, but such
dumb behavior already helped catching a few subtle issues and a very
low to zero impact in practice.

Instead address the issue always initializing snd_nxt (and write_seq,
for consistency) at connect time.

Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
Tested-by: Christoph Paasch <cpaasch@apple.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240429-upstream-net-20240429-mptcp-snd_nxt-init-connect-v1-1-59ceac0a7dcb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3395,6 +3395,9 @@ static int mptcp_stream_connect(struct s
 		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
 		mptcp_subflow_early_fallback(msk, subflow);
 	}
+
+	WRITE_ONCE(msk->write_seq, subflow->idsn);
+	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sock->sk), MPTCP_MIB_MPCAPABLEACTIVE);
 



