Return-Path: <stable+bounces-43710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 808228C4404
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA95AB23FFE
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA99663C1;
	Mon, 13 May 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNGRaC12"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BE539C;
	Mon, 13 May 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613453; cv=none; b=EKUU6KEDQeAoo20a103sNDYubeXKRLinzqlLlRsucZddHp20vWJ8eycFFPt3Gp0cIhXh4jmaQfkrQCgzWeyz9Pnc01UUE13vPzSG9965GXqceLSnHQATiT6vMIGpLdTJad8m/YQ1j1Aq8fYNdIyhoQZlVPHLnYhtjZ7yM8eQg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613453; c=relaxed/simple;
	bh=OGxZWchEypSsKpfa3B/CsaIUjCyUiDDrD3vCvYiJruQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Du/d91UpVOpujc1k/sTZyaEq8qWUPsZu9CwkcDLxUQyO77BmC57nBWb2gsiaTCxcYS5f6B/qCFGdB6fT4FKTQPOZX1dmjm1j9Y9U12YWMC9KxrTsm70lR8vgjW+hvuiIrXmzGL0Gh5w/pS/Nx49u2VJvjQc6bcvqpiB8STJfPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNGRaC12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438ECC32782;
	Mon, 13 May 2024 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715613453;
	bh=OGxZWchEypSsKpfa3B/CsaIUjCyUiDDrD3vCvYiJruQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uNGRaC12DFncB3jl5Yg4hJjrJ2bDpyX1+HYLs6FrcZOrt4c1+gKaxhet7G361er0J
	 Q8UO37Vt79pWC+kI4gppEGAIZuN+Mo0sigbl6znohUl9GeFFN3N6Mf18Y2G6VSiL4r
	 uoZEHTekG5TQkW7G/a1kK6uWhXR1jT/Z/t3X5v46c9z+Cijj1RQECXqCbUX1Hpqa1e
	 9GtRN/uzScHHZDXOWmK4TS8MA5bnoe4MnXRPN+B7W6xzkWI1CMg0btgjiNUNPVOdgj
	 H87+YIJ/DHAToNS4L0Epy75v7PWA3tq2UmUPP0clT65bCrkZGHocpPg1KuKqIfohiv
	 OLrdtg92zbdgQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] mptcp: ensure snd_nxt is properly initialized on connect
Date: Mon, 13 May 2024 17:17:17 +0200
Message-ID: <20240513151717.2733290-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024051325-dreamt-freebee-5563@gregkh>
References: <2024051325-dreamt-freebee-5563@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3981; i=matttbe@kernel.org; h=from:subject; bh=wVi+G138Ev65xjb0nTcgStUa34bZdk5Q/BHpRrSyQ1s=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmQi79PNUEBmrkPWOxdaFhPvHMWCpkLFegiwWBT ytcPoK+TUWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZkIu/QAKCRD2t4JPQmmg c+mvD/9+TkwjqdIYXGSXjWnHdRy4wpXqPn/2UKoec6p9lhDj4HNA9W6/CO8v8Mm3K/bAj2I+v9/ qcThjWFdCN3Ap80OT0V/BT+X740UM7B6z1AzGYoRUcbrOCHZOSBSOYaDUv9XlwgIVUlhX1FlNzg JoeHpMynXqXrkigyRAelCcKoUpg6RGGomZ4QNyMlCeuVzTratCTH+JzMpTF341LOx3DJfE2XeQP Inf0EmhXYQyZNqd9OICmG+vzUqOCJJMRYarFwVsYbsCzbXsUW3zYjT/L46MnL7nH2k8A+VWfTrH JfhRZmtRg8Wiv8d4fL3l2scCFZAaCKBi1jPwrZ9r29FFPHQteCemiOJ4dOl/u2FZoubf33SGuRG s0LHEKSIjBu3JD5mw8KyQXytC7yOMfUXtmPRJr4RhHjnR5M3b0/FsEOSjGg9hx0SohqkDwK+mv+ VpmurP1LjvCrv7UsiykoyU6slmRObwovMnpTFc1jfQzpnmuaelQvfSM4O69lLsgrzGoS8HLDFcr nN9mQBdMHwOaAaSDMOVkt84NLJL7v4UiMlj2y3Vx6VIh33Hvi7xts0Pl2dFSwZJh+8qMcDjqK1/ 34VGTkdm13e5jlvx4BLRG5X7o7PJTx6gQTQor7grJa8nnNkPo9uOFnNewZi7TKjBCTu7Z+vs6fR VgUlfPWOF8wWLEQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

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
[ snd_nxt field is not available in v5.10.y: before, only write_seq was
  used, see commit eaa2ffabfc35 ("mptcp: introduce MPTCP snd_nxt") for
  more details about that. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6be7e7592291..36fa456f42ba 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2645,6 +2645,8 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk))
 		mptcp_subflow_early_fallback(msk, subflow);
 
+	WRITE_ONCE(msk->write_seq, subflow->idsn);
+
 do_connect:
 	err = ssock->ops->connect(ssock, uaddr, addr_len, flags);
 	sock->state = ssock->state;
-- 
2.43.0


