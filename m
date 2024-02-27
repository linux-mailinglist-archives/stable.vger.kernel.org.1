Return-Path: <stable+bounces-24989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437E8869739
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE79B28D8EB
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D91448FE;
	Tue, 27 Feb 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rCCPGa1Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661381448C3;
	Tue, 27 Feb 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043547; cv=none; b=RDN3/2/YR6sq+CYum3ZCjYLSm1mVKd4F1evwO6ahFA/rHKRp2n7eT0ssHI+uQ7QMduwEfyEdjyqJkHGBLSBMRBoXxVEJqVYf8RD6i1UXVVTM86nwhWH6/SiLyWSlgWqs30x93+nSkmHcL0lTzfbc/QkZ9jW3y7Ryy+WWskc+cfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043547; c=relaxed/simple;
	bh=/7zeFvPhqNWcJvMejAGcfDfVlCddgXMhlyfwrhp+7Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAbkauW6E8ycin7G9hITQFgo2X2YroCiDOnmdE2xH8IJSE7avPJ8Q8vn0zTsE2GHxuFScnAVMngABBgJvLfjAUXr7z3R2+vCgfxumrmVtSp9IHhNzUNsOvLoNg9fBFB5Xdy+YXE0WwvLCuj6wthYcuY5AV6alLq7Y+20CnEK0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rCCPGa1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBECC433F1;
	Tue, 27 Feb 2024 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043547;
	bh=/7zeFvPhqNWcJvMejAGcfDfVlCddgXMhlyfwrhp+7Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rCCPGa1YowuN5lQdeoH6rP1s4BZsttqYgcQDM/JzTogHs33OzLTo+hBq+y1Z3O3uS
	 JS8GBJ2NsmLrxC3NcpbGN9EFK3SksNwxh50lthRTBsvBtPwcoN1xoKJ3nt9TyfMR3V
	 hex+to4vqateF3J++kI7mhKYSIEjBvvh+PHQPEU8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzkaller <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 148/195] dccp/tcp: Unhash sk from ehash for tb2 alloc failure after check_estalblished().
Date: Tue, 27 Feb 2024 14:26:49 +0100
Message-ID: <20240227131615.308430502@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 66b60b0c8c4a163b022a9f0ad6769b0fd3dc662f ]

syzkaller reported a warning [0] in inet_csk_destroy_sock() with no
repro.

  WARN_ON(inet_sk(sk)->inet_num && !inet_csk(sk)->icsk_bind_hash);

However, the syzkaller's log hinted that connect() failed just before
the warning due to FAULT_INJECTION.  [1]

When connect() is called for an unbound socket, we search for an
available ephemeral port.  If a bhash bucket exists for the port, we
call __inet_check_established() or __inet6_check_established() to check
if the bucket is reusable.

If reusable, we add the socket into ehash and set inet_sk(sk)->inet_num.

Later, we look up the corresponding bhash2 bucket and try to allocate
it if it does not exist.

Although it rarely occurs in real use, if the allocation fails, we must
revert the changes by check_established().  Otherwise, an unconnected
socket could illegally occupy an ehash entry.

Note that we do not put tw back into ehash because sk might have
already responded to a packet for tw and it would be better to free
tw earlier under such memory presure.

[0]:
WARNING: CPU: 0 PID: 350830 at net/ipv4/inet_connection_sock.c:1193 inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1193)
Modules linked in:
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1193)
Code: 41 5c 41 5d 41 5e e9 2d 4a 3d fd e8 28 4a 3d fd 48 89 ef e8 f0 cd 7d ff 5b 5d 41 5c 41 5d 41 5e e9 13 4a 3d fd e8 0e 4a 3d fd <0f> 0b e9 61 fe ff ff e8 02 4a 3d fd 4c 89 e7 be 03 00 00 00 e8 05
RSP: 0018:ffffc9000b21fd38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000009e78 RCX: ffffffff840bae40
RDX: ffff88806e46c600 RSI: ffffffff840bb012 RDI: ffff88811755cca8
RBP: ffff88811755c880 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000009e78 R11: 0000000000000000 R12: ffff88811755c8e0
R13: ffff88811755c892 R14: ffff88811755c918 R15: 0000000000000000
FS:  00007f03e5243800(0000) GS:ffff88811ae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32f21000 CR3: 0000000112ffe001 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? inet_csk_destroy_sock (net/ipv4/inet_connection_sock.c:1193)
 dccp_close (net/dccp/proto.c:1078)
 inet_release (net/ipv4/af_inet.c:434)
 __sock_release (net/socket.c:660)
 sock_close (net/socket.c:1423)
 __fput (fs/file_table.c:377)
 __fput_sync (fs/file_table.c:462)
 __x64_sys_close (fs/open.c:1557 fs/open.c:1539 fs/open.c:1539)
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
RIP: 0033:0x7f03e53852bb
Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 43 c9 f5 ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 c9 f5 ff 8b 44
RSP: 002b:00000000005dfba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f03e53852bb
RDX: 0000000000000002 RSI: 0000000000000002 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000167c
R10: 0000000008a79680 R11: 0000000000000293 R12: 00007f03e4e43000
R13: 00007f03e4e43170 R14: 00007f03e4e43178 R15: 00007f03e4e43170
 </TASK>

[1]:
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 350833 Comm: syz-executor.1 Not tainted 6.7.0-12272-g2121c43f88f5 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
 should_fail_ex (lib/fault-inject.c:52 lib/fault-inject.c:153)
 should_failslab (mm/slub.c:3748)
 kmem_cache_alloc (mm/slub.c:3763 mm/slub.c:3842 mm/slub.c:3867)
 inet_bind2_bucket_create (net/ipv4/inet_hashtables.c:135)
 __inet_hash_connect (net/ipv4/inet_hashtables.c:1100)
 dccp_v4_connect (net/dccp/ipv4.c:116)
 __inet_stream_connect (net/ipv4/af_inet.c:676)
 inet_stream_connect (net/ipv4/af_inet.c:747)
 __sys_connect_file (net/socket.c:2048 (discriminator 2))
 __sys_connect (net/socket.c:2065)
 __x64_sys_connect (net/socket.c:2072)
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
RIP: 0033:0x7f03e5284e5d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
RSP: 002b:00007f03e4641cc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00000000004bbf80 RCX: 00007f03e5284e5d
RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000004bbf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000000b R14: 00007f03e52e5530 R15: 0000000000000000
 </TASK>

Reported-by: syzkaller <syzkaller@googlegroups.com>
Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_hashtables.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index f2ed2aed08ab3..56776e1b1de52 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1111,10 +1111,33 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	return 0;
 
 error:
+	if (sk_hashed(sk)) {
+		spinlock_t *lock = inet_ehash_lockp(hinfo, sk->sk_hash);
+
+		sock_prot_inuse_add(net, sk->sk_prot, -1);
+
+		spin_lock(lock);
+		sk_nulls_del_node_init_rcu(sk);
+		spin_unlock(lock);
+
+		sk->sk_hash = 0;
+		inet_sk(sk)->inet_sport = 0;
+		inet_sk(sk)->inet_num = 0;
+
+		if (tw)
+			inet_twsk_bind_unhash(tw, hinfo);
+	}
+
 	spin_unlock(&head2->lock);
 	if (tb_created)
 		inet_bind_bucket_destroy(hinfo->bind_bucket_cachep, tb);
-	spin_unlock_bh(&head->lock);
+	spin_unlock(&head->lock);
+
+	if (tw)
+		inet_twsk_deschedule_put(tw);
+
+	local_bh_enable();
+
 	return -ENOMEM;
 }
 
-- 
2.43.0




