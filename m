Return-Path: <stable+bounces-220393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHAqOy80o2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 936E21C5DF4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBC88312C88D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7927E3AABA6;
	Sat, 28 Feb 2026 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD1YugXR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C23AAB9E;
	Sat, 28 Feb 2026 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300286; cv=none; b=lxfIRZmcxkscIGyrnL/XcLSVz4dqRGdWbPbTPRh2cSclFuxCHhfl7gAX7SE4z26jI5mlM8cVWe/amdhsnOOe7NRIteQvpP46fazUvRlEERcLY474jaV1SxommVWzuKvlOETJI4e905V+1LMsggOKgp0Wqchk4m7zEMlH3Pr9ujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300286; c=relaxed/simple;
	bh=8SNhOOm44b/ACAd188vKHovcDjXTTfUaUnS/ehVfOZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OznX9SoN/PqsQcGgVhSOS5cQnCpx3/JSBpL8s5h24YyRbdbr/itKy3wlwT5B/0g+MFqUHNIyKIVz+vPBh6t+mxQhE/xNhGAqrqqZvSCb+T2umQ+A16H9q2L4SBNMG58KerzQXru8BVpg7TIR+HHdI0j3uefFMpsIK6ZG18tZLC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD1YugXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD3AC19423;
	Sat, 28 Feb 2026 17:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300286;
	bh=8SNhOOm44b/ACAd188vKHovcDjXTTfUaUnS/ehVfOZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HD1YugXRKcyL463Pv18PMhg/f1hbrsxxbxGJK7PHq7aY9HJvxErYAurzPr2gEeE5K
	 9oPSWUGo+w8YpgBwOd7FP0+s8v0jCRXmk99i6BOOK/BxjvmVkyhuv84BAnm7m5bQlX
	 iH/BYfoMDGHt8FFzJRSXecfgMKHyhIY1TsZcKg6ePQ9qRmTN0rAmUgj/8/Wb+LtFfZ
	 WrZXti4AfTNaVQkjUeYWcwZxTMPVeH2VTnF1+yiFgNds7XwLzI9q3zq9WEw6/7VW4h
	 xpv7ySCPNt644RuiaT/5/HmFgkbyiBKhDULcWYXLcMP0Pp1gNTbFkpTrdEBEm5ZVEt
	 xQdj2CLwOXT0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	syzbot+d24f940f770afda885cf@syzkaller.appspotmail.com,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 314/844] ipv4: fib: Annotate access to struct fib_alias.fa_state.
Date: Sat, 28 Feb 2026 12:23:47 -0500
Message-ID: <20260228173244.1509663-315-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220393-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,d24f940f770afda885cf];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 936E21C5DF4
X-Rspamd-Action: no action

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 6e84fc395e90465f1418f582a9f7d53c87ab010e ]

syzbot reported that struct fib_alias.fa_state can be
modified locklessly by RCU readers. [0]

Let's use READ_ONCE()/WRITE_ONCE() properly.

[0]:
BUG: KCSAN: data-race in fib_table_lookup / fib_table_lookup

write to 0xffff88811b06a7fa of 1 bytes by task 4167 on cpu 0:
 fib_alias_accessed net/ipv4/fib_lookup.h:32 [inline]
 fib_table_lookup+0x361/0xd60 net/ipv4/fib_trie.c:1565
 fib_lookup include/net/ip_fib.h:390 [inline]
 ip_route_output_key_hash_rcu+0x378/0x1380 net/ipv4/route.c:2814
 ip_route_output_key_hash net/ipv4/route.c:2705 [inline]
 __ip_route_output_key include/net/route.h:169 [inline]
 ip_route_output_flow+0x65/0x110 net/ipv4/route.c:2932
 udp_sendmsg+0x13c3/0x15d0 net/ipv4/udp.c:1450
 inet_sendmsg+0xac/0xd0 net/ipv4/af_inet.c:859
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x53a/0x600 net/socket.c:2592
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
 __sys_sendmmsg+0x185/0x320 net/socket.c:2735
 __do_sys_sendmmsg net/socket.c:2762 [inline]
 __se_sys_sendmmsg net/socket.c:2759 [inline]
 __x64_sys_sendmmsg+0x57/0x70 net/socket.c:2759
 x64_sys_call+0x1e28/0x3000 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811b06a7fa of 1 bytes by task 4168 on cpu 1:
 fib_alias_accessed net/ipv4/fib_lookup.h:31 [inline]
 fib_table_lookup+0x338/0xd60 net/ipv4/fib_trie.c:1565
 fib_lookup include/net/ip_fib.h:390 [inline]
 ip_route_output_key_hash_rcu+0x378/0x1380 net/ipv4/route.c:2814
 ip_route_output_key_hash net/ipv4/route.c:2705 [inline]
 __ip_route_output_key include/net/route.h:169 [inline]
 ip_route_output_flow+0x65/0x110 net/ipv4/route.c:2932
 udp_sendmsg+0x13c3/0x15d0 net/ipv4/udp.c:1450
 inet_sendmsg+0xac/0xd0 net/ipv4/af_inet.c:859
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x53a/0x600 net/socket.c:2592
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
 __sys_sendmmsg+0x185/0x320 net/socket.c:2735
 __do_sys_sendmmsg net/socket.c:2762 [inline]
 __se_sys_sendmmsg net/socket.c:2759 [inline]
 __x64_sys_sendmmsg+0x57/0x70 net/socket.c:2759
 x64_sys_call+0x1e28/0x3000 arch/x86/include/generated/asm/syscalls_64.h:308
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00 -> 0x01

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 4168 Comm: syz.4.206 Not tainted syzkaller #0 PREEMPT(voluntary)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025

Reported-by: syzbot+d24f940f770afda885cf@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69783ead.050a0220.c9109.0013.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260127043528.514160-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fib_lookup.h | 6 ++++--
 net/ipv4/fib_trie.c   | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/fib_lookup.h b/net/ipv4/fib_lookup.h
index f9b9e26c32c19..0b72796dd1ad3 100644
--- a/net/ipv4/fib_lookup.h
+++ b/net/ipv4/fib_lookup.h
@@ -28,8 +28,10 @@ struct fib_alias {
 /* Don't write on fa_state unless needed, to keep it shared on all cpus */
 static inline void fib_alias_accessed(struct fib_alias *fa)
 {
-	if (!(fa->fa_state & FA_S_ACCESSED))
-		fa->fa_state |= FA_S_ACCESSED;
+	u8 fa_state = READ_ONCE(fa->fa_state);
+
+	if (!(fa_state & FA_S_ACCESSED))
+		WRITE_ONCE(fa->fa_state, fa_state | FA_S_ACCESSED);
 }
 
 /* Exported by fib_semantics.c */
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 7e2c17fec3fc4..1308213791f19 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1280,7 +1280,7 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
 			new_fa->fa_dscp = fa->fa_dscp;
 			new_fa->fa_info = fi;
 			new_fa->fa_type = cfg->fc_type;
-			state = fa->fa_state;
+			state = READ_ONCE(fa->fa_state);
 			new_fa->fa_state = state & ~FA_S_ACCESSED;
 			new_fa->fa_slen = fa->fa_slen;
 			new_fa->tb_id = tb->tb_id;
@@ -1745,7 +1745,7 @@ int fib_table_delete(struct net *net, struct fib_table *tb,
 
 	fib_remove_alias(t, tp, l, fa_to_delete);
 
-	if (fa_to_delete->fa_state & FA_S_ACCESSED)
+	if (READ_ONCE(fa_to_delete->fa_state) & FA_S_ACCESSED)
 		rt_cache_flush(cfg->fc_nlinfo.nl_net);
 
 	fib_release_info(fa_to_delete->fa_info);
-- 
2.51.0


