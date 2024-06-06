Return-Path: <stable+bounces-49899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380578FEF4F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3021C21D89
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97891A01B1;
	Thu,  6 Jun 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wd/ERUm0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EBF1CBE8A;
	Thu,  6 Jun 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683766; cv=none; b=YRDjSt6etczzNIH++8Hs0LV0uP/WjP6vjxG5eWs/c1W+Np9HKoZA8fRP9/0OJnQUp905ADQRd8ZU/vBctP0s/aAkYl3hbD6K1SRqTymMJOkIVteOPwu1rWLzto7pNG4cUj+p0oxlT9gZaxW4jPhP1R8GfBBE7CQKWhKiD5Z9JUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683766; c=relaxed/simple;
	bh=NGK+BqprE4pSM0QERSSILtLSb2/SF+imAwXBFCBVS9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxNUSkHBLYzxLpK9wNkU2VBce7yMABho/kANzhnZ66Gcm2rLMQ49+nG4SLwEarKs69vuMofB2o+GzSN29HjlqSfl84GHj+SvoW/1y2g0YqOppOCIs/Mn4vE8MPDmK14PGy2hR3IGdplG6DokrZibkf4EeDt65Er9kNAuh56Dyqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wd/ERUm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CC4C2BD10;
	Thu,  6 Jun 2024 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683766;
	bh=NGK+BqprE4pSM0QERSSILtLSb2/SF+imAwXBFCBVS9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wd/ERUm0Zl6/4GGhks9ycDlIIfPKGlqg1l8dQ9Nr2Pu+MDjnW01EAIvswRjbFDBpP
	 2wfYntHZsR+tEhJwDYzK5LY4hDcyPVqIfN0ot4Ej83+I9OA9WJ8u1zZ0WOGdlP7JfP
	 JJgQo2s3g3k2MN6yowd1fTsGcknyrFYmrjFPLEu8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzkaller <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 697/744] af_unix: Annotate data-race around unix_sk(sk)->addr.
Date: Thu,  6 Jun 2024 16:06:09 +0200
Message-ID: <20240606131754.841475359@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 97e1db06c7bb948da10ba85acad8030b56886593 ]

Once unix_sk(sk)->addr is assigned under net->unx.table.locks and
unix_sk(sk)->bindlock, *(unix_sk(sk)->addr) and unix_sk(sk)->path are
fully set up, and unix_sk(sk)->addr is never changed.

unix_getname() and unix_copy_addr() access the two fields locklessly,
and commit ae3b564179bf ("missing barriers in some of unix_sock ->addr
and ->path accesses") added smp_store_release() and smp_load_acquire()
pairs.

In other functions, we still read unix_sk(sk)->addr locklessly to check
if the socket is bound, and KCSAN complains about it.  [0]

Given these functions have no dependency for *(unix_sk(sk)->addr) and
unix_sk(sk)->path, READ_ONCE() is enough to annotate the data-race.

Note that it is safe to access unix_sk(sk)->addr locklessly if the socket
is found in the hash table.  For example, the lockless read of otheru->addr
in unix_stream_connect() is safe.

Note also that newu->addr there is of the child socket that is still not
accessible from userspace, and smp_store_release() publishes the address
in case the socket is accept()ed and unix_getname() / unix_copy_addr()
is called.

[0]:
BUG: KCSAN: data-race in unix_bind / unix_listen

write (marked) to 0xffff88805f8d1840 of 8 bytes by task 13723 on cpu 0:
 __unix_set_addr_hash net/unix/af_unix.c:329 [inline]
 unix_bind_bsd net/unix/af_unix.c:1241 [inline]
 unix_bind+0x881/0x1000 net/unix/af_unix.c:1319
 __sys_bind+0x194/0x1e0 net/socket.c:1847
 __do_sys_bind net/socket.c:1858 [inline]
 __se_sys_bind net/socket.c:1856 [inline]
 __x64_sys_bind+0x40/0x50 net/socket.c:1856
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x46/0x4e

read to 0xffff88805f8d1840 of 8 bytes by task 13724 on cpu 1:
 unix_listen+0x72/0x180 net/unix/af_unix.c:734
 __sys_listen+0xdc/0x160 net/socket.c:1881
 __do_sys_listen net/socket.c:1890 [inline]
 __se_sys_listen net/socket.c:1888 [inline]
 __x64_sys_listen+0x2e/0x40 net/socket.c:1888
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x46/0x4e

value changed: 0x0000000000000000 -> 0xffff88807b5b1b40

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 13724 Comm: syz-executor.4 Not tainted 6.8.0-12822-gcd51db110a7e #12
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240522154002.77857-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a4c41906faec1..df6bddca08f89 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -732,7 +732,7 @@ static int unix_listen(struct socket *sock, int backlog)
 	if (sock->type != SOCK_STREAM && sock->type != SOCK_SEQPACKET)
 		goto out;	/* Only stream/seqpacket sockets accept */
 	err = -EINVAL;
-	if (!u->addr)
+	if (!READ_ONCE(u->addr))
 		goto out;	/* No listens on an unbound socket */
 	unix_state_lock(sk);
 	if (sk->sk_state != TCP_CLOSE && sk->sk_state != TCP_LISTEN)
@@ -1379,7 +1379,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 
 		if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
 		     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
-		    !unix_sk(sk)->addr) {
+		    !READ_ONCE(unix_sk(sk)->addr)) {
 			err = unix_autobind(sk);
 			if (err)
 				goto out;
@@ -1487,7 +1487,8 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 
 	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
-	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
+	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
+	    !READ_ONCE(u->addr)) {
 		err = unix_autobind(sk);
 		if (err)
 			goto out;
@@ -1927,7 +1928,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
-	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
+	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
+	    !READ_ONCE(u->addr)) {
 		err = unix_autobind(sk);
 		if (err)
 			goto out;
-- 
2.43.0




