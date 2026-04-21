Return-Path: <stable+bounces-240166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ms5HaN752nC9QEAu9opvQ
	(envelope-from <stable+bounces-240166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:29:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A77D43B5A5
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 472CE302293C
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2973D668F;
	Tue, 21 Apr 2026 13:28:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F29F19CD1D;
	Tue, 21 Apr 2026 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776778124; cv=none; b=h7mI1JqdVccKNETkt5DNs7fEDyMeJEjVaqs795uwC8oIlQNqk+EPSvC9aQrdpJeomGYzNaM94RcVCd5/2QuZV9qAdGNx5KJwH1Y10yj5GN+R0WIPzh8svP/cTVt00lptSVTTZ6mPscDcli1SLKcU2lbzyv2FcgeqTcO5mah2c2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776778124; c=relaxed/simple;
	bh=CiIjqDjOBSPjKpkKMpR2vhnowJiMDTX30GTHEgLni5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cv+ELtDAKyTcNcTUc+IMfuXs+jRVDUEeJ2Slra6TbUGTu3E9pScCXPXfEsF3A2XMTdkUzJWDzboTaMOdsAhq0R9V9+LpsYShU8x+i9Q/nQdkzo5IXgT4zaqiE4mvYM9G1rQ8X0AuDinqryN7VNES2++d6w4hJLzDToKlU8Ly1EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 9A5F723394;
	Tue, 21 Apr 2026 16:28:40 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Liu Jian <liujian56@huawei.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] bpf, sockmap: Fix an infinite loop error when len is 0 in tcp_bpf_recvmsg_parser()
Date: Tue, 21 Apr 2026 16:28:39 +0300
Message-Id: <20260421132839.38703-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240166-lists,stable=lfdr.de];
	DMARC_NA(0.00)[altlinux.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[kovalev@altlinux.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,altlinux.org:mid,altlinux.org:email,cloudflare.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A77D43B5A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Liu Jian <liujian56@huawei.com>

commit d900f3d20cc3169ce42ec72acc850e662a4d4db2 upstream.

When the buffer length of the recvmsg system call is 0, we got the
flollowing soft lockup problem:

watchdog: BUG: soft lockup - CPU#3 stuck for 27s! [a.out:6149]
CPU: 3 PID: 6149 Comm: a.out Kdump: loaded Not tainted 6.2.0+ #30
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
RIP: 0010:remove_wait_queue+0xb/0xc0
Code: 5e 41 5f c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 57 <41> 56 41 55 41 54 55 48 89 fd 53 48 89 f3 4c 8d 6b 18 4c 8d 73 20
RSP: 0018:ffff88811b5978b8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff88811a7d3780 RCX: ffffffffb7a4d768
RDX: dffffc0000000000 RSI: ffff88811b597908 RDI: ffff888115408040
RBP: 1ffff110236b2f1b R08: 0000000000000000 R09: ffff88811a7d37e7
R10: ffffed10234fa6fc R11: 0000000000000001 R12: ffff88811179b800
R13: 0000000000000001 R14: ffff88811a7d38a8 R15: ffff88811a7d37e0
FS:  00007f6fb5398740(0000) GS:ffff888237180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000010b6ba002 CR4: 0000000000370ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tcp_msg_wait_data+0x279/0x2f0
 tcp_bpf_recvmsg_parser+0x3c6/0x490
 inet_recvmsg+0x280/0x290
 sock_recvmsg+0xfc/0x120
 ____sys_recvmsg+0x160/0x3d0
 ___sys_recvmsg+0xf0/0x180
 __sys_recvmsg+0xea/0x1a0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

The logic in tcp_bpf_recvmsg_parser is as follows:

msg_bytes_ready:
	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
	if (!copied) {
		wait data;
		goto msg_bytes_ready;
	}

In this case, "copied" always is 0, the infinite loop occurs.

According to the Linux system call man page, 0 should be returned in this
case. Therefore, in tcp_bpf_recvmsg_parser(), if the length is 0, directly
return. Also modify several other functions with the same problem.

Fixes: 1f5be6b3b063 ("udp: Implement udp_bpf_recvmsg() for sockmap")
Fixes: 9825d866ce0d ("af_unix: Implement unix_dgram_bpf_recvmsg()")
Fixes: c5d2177a72a1 ("bpf, sockmap: Fix race in ingress receive verdict with redirect to self")
Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Liu Jian <liujian56@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20230303080946.1146638-1-liujian56@huawei.com
[ kovalev: bp to fix CVE-2023-53133; applied only to tcp_bpf_recvmsg as the
  older kernel lacks tcp_bpf_recvmsg_parser, udp_bpf_recvmsg and
  unix_bpf_recvmsg (see upstream commits c5d2177a72a1, 1f5be6b3b063 and
  9825d866ce0d) ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 net/ipv4/tcp_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index bcd5fc484f77..76cd97488777 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -277,6 +277,9 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len, addr_len);
 
+	if (!len)
+		return 0;
+
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
 		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
-- 
2.50.1


