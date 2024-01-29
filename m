Return-Path: <stable+bounces-17150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88581841007
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461C0284BFE
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AB315B2FC;
	Mon, 29 Jan 2024 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zX/zH2Xs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076B157E62;
	Mon, 29 Jan 2024 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548547; cv=none; b=kxQLoBZdueREgG5r9mW94T3sCyCu4fLNawV6VxAyYUgKoGtGcuuth8NNxhieZxPCxy9jpvMEcGJPfcDc4/SzrNuvh8ut7wu6bZYuEV8b0uGi2pZm5pLd/SGefTx7IBxMhcM0IUTOJN1DXBu755jg/0qXNi+oit8R0XXFkNUy86s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548547; c=relaxed/simple;
	bh=C+n+nFagVjdIhh2G/3iE6Dnsiv1NwRklDoQdLQH25jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjDPRylbSKwD5l7sCH0nGC4GSs18pjhgFomZkh/w7IpurBZIKTbJE19EpRvwx6LdNt544ye4h6L9phKYFJD6XiAln/gMFjh9ygq03NpukFlR54Em+3nQP+yLbY2wjhUbEGrMpSpQAMlYUJF7NATppXlCIpWAZ1ezFewaaqu630A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zX/zH2Xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79211C433F1;
	Mon, 29 Jan 2024 17:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548547;
	bh=C+n+nFagVjdIhh2G/3iE6Dnsiv1NwRklDoQdLQH25jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zX/zH2XsONfDRaMk8ejh+pwiHnPLnPaR5Ukf3sZF0ARhPMzRPtW2ZrOuFm8x3LBVd
	 jUQLjq9O/54TeCtqP+5tyF28R8nzWd+D90cms92wSCwsbqPgcVm9CMuv743u+BiOPK
	 fcZNXijMO50wg4ri89hPe8FCTnxTgM2tpu4zjEtY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 189/331] ipv6: init the accept_queues spinlocks in inet6_create
Date: Mon, 29 Jan 2024 09:04:13 -0800
Message-ID: <20240129170020.417640537@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit 435e202d645c197dcfd39d7372eb2a56529b6640 ]

In commit 198bc90e0e73("tcp: make sure init the accept_queue's spinlocks
once"), the spinlocks of accept_queue are initialized only when socket is
created in the inet4 scenario. The locks are not initialized when socket
is created in the inet6 scenario. The kernel reports the following error:
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
Call Trace:
<TASK>
	dump_stack_lvl (lib/dump_stack.c:107)
	register_lock_class (kernel/locking/lockdep.c:1289)
	__lock_acquire (kernel/locking/lockdep.c:5015)
	lock_acquire.part.0 (kernel/locking/lockdep.c:5756)
	_raw_spin_lock_bh (kernel/locking/spinlock.c:178)
	inet_csk_listen_stop (net/ipv4/inet_connection_sock.c:1386)
	tcp_disconnect (net/ipv4/tcp.c:2981)
	inet_shutdown (net/ipv4/af_inet.c:935)
	__sys_shutdown (./include/linux/file.h:32 net/socket.c:2438)
	__x64_sys_shutdown (net/socket.c:2445)
	do_syscall_64 (arch/x86/entry/common.c:52)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
RIP: 0033:0x7f52ecd05a3d
Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
ff 73 01 c3 48 8b 0d ab a3 0e 00 f7 d8 64 89 01 48
RSP: 002b:00007f52ecf5dde8 EFLAGS: 00000293 ORIG_RAX: 0000000000000030
RAX: ffffffffffffffda RBX: 00007f52ecf5e640 RCX: 00007f52ecd05a3d
RDX: 00007f52ecc8b188 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f52ecf5de20 R08: 00007ffdae45c69f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f52ecf5e640
R13: 0000000000000000 R14: 00007f52ecc8b060 R15: 00007ffdae45c6e0

Fixes: 198bc90e0e73 ("tcp: make sure init the accept_queue's spinlocks once")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240122102001.2851701-1-shaozhengchao@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/af_inet6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 368824fe9719..b6c5b5e25a2f 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -199,6 +199,9 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	if (INET_PROTOSW_REUSE & answer_flags)
 		sk->sk_reuse = SK_CAN_REUSE;
 
+	if (INET_PROTOSW_ICSK & answer_flags)
+		inet_init_csk_locks(sk);
+
 	inet = inet_sk(sk);
 	inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
 
-- 
2.43.0




