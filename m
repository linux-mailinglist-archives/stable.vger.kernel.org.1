Return-Path: <stable+bounces-44859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F0C8C54B4
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C518D1C233E4
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B8512E1DA;
	Tue, 14 May 2024 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a40KjfiW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268354903;
	Tue, 14 May 2024 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687383; cv=none; b=Ruks2Tcwy5PjFT96bJhyF1AVq4IZF8KUL0it5jqbAyrKoSPY0Ta9xDMpRoYEMWBZ557WUrvmJVnCfWGAU7lpBJpwrPg44kJOaUqnMRDvGOGmaUoy+nVAtmBkqSnw6Ex8aI0yFx+s1//r0zTVpVrb0QTwbGC9kS4s4E2VjvHMldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687383; c=relaxed/simple;
	bh=E/eBnnBPLGbDisxHSvBlDECR74/jdqGpDx1gNuDM6sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KK6+u5FJp//v2FTqdPvNGpAVtQj7AWrd17yvq1iYZSzYTNZY7dDERdQ/ZzQ1xdzzBxkDhYxeMquhZ3QwkV4evZCoTPrw7KxTMkf1HbzGAA8AhUknBX+4N/mxcMGP2OqND59dgJ3vlHn/V8mPFR43waYS2IT08peJo1Wf24ac7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a40KjfiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB833C2BD10;
	Tue, 14 May 2024 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687383;
	bh=E/eBnnBPLGbDisxHSvBlDECR74/jdqGpDx1gNuDM6sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a40KjfiWLDZPGF4EExBO5V5tlGPzRydoeUbXwjfu1SwH24gfuflIgYJ6dLADMR9So
	 2p/Je8qCSbkU2wBeNz8vbJF/6gZOn44Ifx25nJY/Bc+4HAeTqWOg9ssfTbWRCDURCG
	 1vUzGhTEX3tYY+WhHcorhf6TUYoteGMb1mjGhFhU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anderson Nascimento <anderson@allelesecurity.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 077/111] tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().
Date: Tue, 14 May 2024 12:20:15 +0200
Message-ID: <20240514101000.058390802@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
References: <20240514100957.114746054@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit f2db7230f73a80dbb179deab78f88a7947f0ab7e ]

Anderson Nascimento reported a use-after-free splat in tcp_twsk_unique()
with nice analysis.

Since commit ec94c2696f0b ("tcp/dccp: avoid one atomic operation for
timewait hashdance"), inet_twsk_hashdance() sets TIME-WAIT socket's
sk_refcnt after putting it into ehash and releasing the bucket lock.

Thus, there is a small race window where other threads could try to
reuse the port during connect() and call sock_hold() in tcp_twsk_unique()
for the TIME-WAIT socket with zero refcnt.

If that happens, the refcnt taken by tcp_twsk_unique() is overwritten
and sock_put() will cause underflow, triggering a real use-after-free
somewhere else.

To avoid the use-after-free, we need to use refcount_inc_not_zero() in
tcp_twsk_unique() and give up on reusing the port if it returns false.

[0]:
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 1039313 at lib/refcount.c:25 refcount_warn_saturate+0xe5/0x110
CPU: 0 PID: 1039313 Comm: trigger Not tainted 6.8.6-200.fc39.x86_64 #1
Hardware name: VMware, Inc. VMware20,1/440BX Desktop Reference Platform, BIOS VMW201.00V.21805430.B64.2305221830 05/22/2023
RIP: 0010:refcount_warn_saturate+0xe5/0x110
Code: 42 8e ff 0f 0b c3 cc cc cc cc 80 3d aa 13 ea 01 00 0f 85 5e ff ff ff 48 c7 c7 f8 8e b7 82 c6 05 96 13 ea 01 01 e8 7b 42 8e ff <0f> 0b c3 cc cc cc cc 48 c7 c7 50 8f b7 82 c6 05 7a 13 ea 01 01 e8
RSP: 0018:ffffc90006b43b60 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888009bb3ef0 RCX: 0000000000000027
RDX: ffff88807be218c8 RSI: 0000000000000001 RDI: ffff88807be218c0
RBP: 0000000000069d70 R08: 0000000000000000 R09: ffffc90006b439f0
R10: ffffc90006b439e8 R11: 0000000000000003 R12: ffff8880029ede84
R13: 0000000000004e20 R14: ffffffff84356dc0 R15: ffff888009bb3ef0
FS:  00007f62c10926c0(0000) GS:ffff88807be00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020ccb000 CR3: 000000004628c005 CR4: 0000000000f70ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? refcount_warn_saturate+0xe5/0x110
 ? __warn+0x81/0x130
 ? refcount_warn_saturate+0xe5/0x110
 ? report_bug+0x171/0x1a0
 ? refcount_warn_saturate+0xe5/0x110
 ? handle_bug+0x3c/0x80
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? refcount_warn_saturate+0xe5/0x110
 tcp_twsk_unique+0x186/0x190
 __inet_check_established+0x176/0x2d0
 __inet_hash_connect+0x74/0x7d0
 ? __pfx___inet_check_established+0x10/0x10
 tcp_v4_connect+0x278/0x530
 __inet_stream_connect+0x10f/0x3d0
 inet_stream_connect+0x3a/0x60
 __sys_connect+0xa8/0xd0
 __x64_sys_connect+0x18/0x20
 do_syscall_64+0x83/0x170
 entry_SYSCALL_64_after_hwframe+0x78/0x80
RIP: 0033:0x7f62c11a885d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a3 45 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007f62c1091e58 EFLAGS: 00000296 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000020ccb004 RCX: 00007f62c11a885d
RDX: 0000000000000010 RSI: 0000000020ccb000 RDI: 0000000000000003
RBP: 00007f62c1091e90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 00007f62c10926c0
R13: ffffffffffffff88 R14: 0000000000000000 R15: 00007ffe237885b0
 </TASK>

Fixes: ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashdance")
Reported-by: Anderson Nascimento <anderson@allelesecurity.com>
Closes: https://lore.kernel.org/netdev/37a477a6-d39e-486b-9577-3463f655a6b7@allelesecurity.com/
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240501213145.62261-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7a94acbd9f142..85d8688933f3c 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -153,6 +153,12 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	if (tcptw->tw_ts_recent_stamp &&
 	    (!twp || (reuse && time_after32(ktime_get_seconds(),
 					    tcptw->tw_ts_recent_stamp)))) {
+		/* inet_twsk_hashdance() sets sk_refcnt after putting twsk
+		 * and releasing the bucket lock.
+		 */
+		if (unlikely(!refcount_inc_not_zero(&sktw->sk_refcnt)))
+			return 0;
+
 		/* In case of repair and re-using TIME-WAIT sockets we still
 		 * want to be sure that it is safe as above but honor the
 		 * sequence numbers and time stamps set as part of the repair
@@ -173,7 +179,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 			tp->rx_opt.ts_recent	   = tcptw->tw_ts_recent;
 			tp->rx_opt.ts_recent_stamp = tcptw->tw_ts_recent_stamp;
 		}
-		sock_hold(sktw);
+
 		return 1;
 	}
 
-- 
2.43.0




