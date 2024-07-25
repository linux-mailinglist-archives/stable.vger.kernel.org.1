Return-Path: <stable+bounces-61372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CF693BED6
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 11:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AAB1F21821
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEFB13A414;
	Thu, 25 Jul 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="X3tflaXn"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26613AA46
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898938; cv=none; b=OXWjuUoxgc7Q94EdVeKz4FB7I4ps4zPKXE2PlnqE66XKBlnvXiu+jKy6Jz8cRaEEgWQkAImwrL5V54KzHbdDSHK/gAiXo20eZKE5+uinRJaXb9zGMrDi582N2tB/JyYfAtLfrowT3nxXkXxgNozneBlZdj02n/wT9tPXyct2B84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898938; c=relaxed/simple;
	bh=wJdGkOSrDUI9Stb8W8GNNg19+R0mWHXTlEvz2vVpXzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tpvaWJdUY8OrW+EnDHmIPGhMwOGdgPE+EXw3fAK52ETXTDoYeiT74+NOdSHuKyBrc9rYr00RdM3kEWJ6dMhSx0OnnWtb/Lm4svyockKVeMy4S7UCMKG6OQqpOKo1zeJiWvWExepugICPr8RFnoRP3zQ4hXNBsqHVrHamJNyIggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=X3tflaXn; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:25c3:0:640:236:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 51EB560DBB;
	Thu, 25 Jul 2024 12:15:29 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:b67f::1:2f])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id JFM7IR0Pj8c0-tJuvobK6;
	Thu, 25 Jul 2024 12:15:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1721898928;
	bh=7Wkq9dhdjsSMsLbquL+0IloEWZ0vGb45na4TNKlZ9Ws=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=X3tflaXnC14wLNrU1CaPkj/Y7vtY5qHmhOYFWjYLOe2FcFngA0IQb4O2OlVzBQYVN
	 G6nUyDPgFYzs3/wMm2Cte+RO5xJVOoS+CRWZaHmEuZXqJZ8K4jBv4jxXMw4Ac8oPVL
	 /W0PaETmIc9bygX0vIhXN55OiRy0A8VnxMplawv4=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Christoph Paasch <cpaasch@apple.com>,
	Eric Dumazet <edumazet@google.com>,
	lvc-project@linuxtesting.org,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH 4.19 5.4 5.10 5.15] net: relax socket state check at accept time.
Date: Thu, 25 Jul 2024 12:15:02 +0300
Message-Id: <20240725091502.2808792-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 26afda78cda3da974fd4c287962c169e9462c495 ]

Christoph reported the following splat:

WARNING: CPU: 1 PID: 772 at net/ipv4/af_inet.c:761 __inet_accept+0x1f4/0x4a0
Modules linked in:
CPU: 1 PID: 772 Comm: syz-executor510 Not tainted 6.9.0-rc7-g7da7119fe22b #56
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
RIP: 0010:__inet_accept+0x1f4/0x4a0 net/ipv4/af_inet.c:759
Code: 04 38 84 c0 0f 85 87 00 00 00 41 c7 04 24 03 00 00 00 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ec b7 da fd <0f> 0b e9 7f fe ff ff e8 e0 b7 da fd 0f 0b e9 fe fe ff ff 89 d9 80
RSP: 0018:ffffc90000c2fc58 EFLAGS: 00010293
RAX: ffffffff836bdd14 RBX: 0000000000000000 RCX: ffff888104668000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff836bdb89 R09: fffff52000185f64
R10: dffffc0000000000 R11: fffff52000185f64 R12: dffffc0000000000
R13: 1ffff92000185f98 R14: ffff88810754d880 R15: ffff8881007b7800
FS:  000000001c772880(0000) GS:ffff88811b280000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb9fcf2e178 CR3: 00000001045d2002 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 inet_accept+0x138/0x1d0 net/ipv4/af_inet.c:786
 do_accept+0x435/0x620 net/socket.c:1929
 __sys_accept4_file net/socket.c:1969 [inline]
 __sys_accept4+0x9b/0x110 net/socket.c:1999
 __do_sys_accept net/socket.c:2016 [inline]
 __se_sys_accept net/socket.c:2013 [inline]
 __x64_sys_accept+0x7d/0x90 net/socket.c:2013
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x58/0x100 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x4315f9
Code: fd ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 ab b4 fd ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdb26d9c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
RAX: ffffffffffffffda RBX: 0000000000400300 RCX: 00000000004315f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000006e1018 R08: 0000000000400300 R09: 0000000000400300
R10: 0000000000400300 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000040cdf0 R14: 000000000040ce80 R15: 0000000000000055
 </TASK>

The reproducer invokes shutdown() before entering the listener status.
After commit 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for
TCP_SYN_RECV sockets"), the above causes the child to reach the accept
syscall in FIN_WAIT1 status.

Eric noted we can relax the existing assertion in __inet_accept()

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/490
Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets")
Link: https://lore.kernel.org/r/23ab880a44d8cfd967e84de8b93dbf48848e3d8c.1716299669.git.pabeni@redhat.com
Link: https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-36484-375b@gregkh
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 net/ipv4/af_inet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 475a19db3713..ce42626663de 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -758,7 +758,9 @@ int inet_accept(struct socket *sock, struct socket *newsock, int flags,
 	sock_rps_record_flow(sk2);
 	WARN_ON(!((1 << sk2->sk_state) &
 		  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
-		  TCPF_CLOSE_WAIT | TCPF_CLOSE)));
+		   TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 |
+		   TCPF_CLOSING | TCPF_CLOSE_WAIT |
+		   TCPF_CLOSE)));
 
 	sock_graft(sk2, newsock);
 
-- 
2.34.1


