Return-Path: <stable+bounces-43656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9778C4264
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8735286CDC
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF5D1534F5;
	Mon, 13 May 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="INfJCtQs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8731474BB
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607809; cv=none; b=am1Rx9NywkN5N3NqIwFjg9wNDyMCos6yt4OP0wDClwJbby/AACBVqsL75ggBeS/dOlkVDTIR27cq+nWc11hlNSIpPs1sFjtUFuqbBArBSXLXftMFpCUL7Y5h+yvMShU8gmZgJ+Bir9heYz2CiM8UQMfzxPyRtvvuKrYnDb74AZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607809; c=relaxed/simple;
	bh=1nPiLjM48WxluV6sYzgabZGX95Dfa5FerW0D5jCBwiU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kL4SlHtRawhueYcqAkXxkoVWllbN6FrZOQuR/WFmjJ2s4DKAZoO/rW/mGAItk1wzZbB2rqzlPk+EsFKPqRS3bLgxHH7r1BFtbN+3H6HF7AOTJyW4x3Uh6DsFbmMeXxHShVwPx84HnDCwIW7PamhZ9+gzz/ejG6DRGEcJADPIj6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=INfJCtQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6CDC113CC;
	Mon, 13 May 2024 13:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715607809;
	bh=1nPiLjM48WxluV6sYzgabZGX95Dfa5FerW0D5jCBwiU=;
	h=Subject:To:Cc:From:Date:From;
	b=INfJCtQssjGgoxmecapcUdHmdSLB2f5vvWuezRUqjT8q9wjQO4GUmehVNh9lsU0yT
	 qcSuLqU0MrsXRWmWqOmsyWjSI8FobQZ4QQjnprmTFKH8L5XECXec3jQBA1fOpiZwR1
	 HhYzIR2D+Dc45sRDSI/AeJIVNHUcoMdgsI/SfDfY=
Subject: FAILED: patch "[PATCH] mptcp: ensure snd_nxt is properly initialized on connect" failed to apply to 5.10-stable tree
To: pabeni@redhat.com,cpaasch@apple.com,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:43:26 +0200
Message-ID: <2024051325-dreamt-freebee-5563@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x fb7a0d334894206ae35f023a82cad5a290fd7386
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051325-dreamt-freebee-5563@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

fb7a0d334894 ("mptcp: ensure snd_nxt is properly initialized on connect")
54f1944ed6d2 ("mptcp: factor out mptcp_connect()")
a42cf9d18278 ("mptcp: poll allow write call before actual connect")
d98a82a6afc7 ("mptcp: handle defer connect in mptcp_sendmsg")
3e5014909b56 ("mptcp: cleanup MPJ subflow list handling")
3d1d6d66e156 ("mptcp: implement support for user-space disconnect")
b29fcfb54cd7 ("mptcp: full disconnect implementation")
3ce0852c86b9 ("mptcp: enforce HoL-blocking estimation")
7cd2802d7496 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb7a0d334894206ae35f023a82cad5a290fd7386 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Mon, 29 Apr 2024 20:00:31 +0200
Subject: [PATCH] mptcp: ensure snd_nxt is properly initialized on connect

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

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7e74b812e366..965eb69dc5de 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3723,6 +3723,9 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
 		mptcp_subflow_early_fallback(msk, subflow);
 	}
+
+	WRITE_ONCE(msk->write_seq, subflow->idsn);
+	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
 


