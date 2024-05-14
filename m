Return-Path: <stable+bounces-43975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA578C508B
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6C51F2101E
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EB113D8B4;
	Tue, 14 May 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y9GjNlIS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E25A6A352;
	Tue, 14 May 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683456; cv=none; b=OFQTGey3dAQmkq1j1qcI7Xu5O6lwEzMPq3lKwE/UDiCdw36eosBwx9v0FVqrDCp3z7SR1foXmGlTjZFfWKArhjbAjGFs2ZLes1HEas1e4QM4obzHUx1oFGKef+292dPsKkzaIHmgHfI4IWpaql/ovJmfenuOwlHHPMLSXgQL9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683456; c=relaxed/simple;
	bh=GOFHee/8sa9AMsNPWuMKOS6hNu9MrREpQ0dSHOSqfXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/yexuS510wvkT3BsFS3b3VHnwOEJ42sGv6B5vnyXfbhyHZSgYsEoLbOOKLpwCW/RKw/NXtgYHz275/KEr089O/XSDgy2UVW3ysLijiY/vrC+07WhnpOjgheH66Kerqv1kFWtJyIM974leHKw6u8MvRoAsXnc9Vz+VNpi0dJtp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y9GjNlIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBE8C2BD10;
	Tue, 14 May 2024 10:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683456;
	bh=GOFHee/8sa9AMsNPWuMKOS6hNu9MrREpQ0dSHOSqfXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y9GjNlISIGz1ms8zZMQag7pUw6djzlN5olmdurSwWn78YmVCSjqkLfF4H+mnJEt4c
	 OF7cUaqzKd6KFGNZ6Ir9PFDkDEi+S3bsUJTvULxn42txXthP8u6L/HJnRXhH+ubHar
	 sT4cZuICp/hsQHQJbvSvIjTN+RiqHgE8pjQopD4Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 220/336] ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action()
Date: Tue, 14 May 2024 12:17:04 +0200
Message-ID: <20240514101046.921313587@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d101291b2681e5ab938554e3e323f7a7ee33e3aa ]

syzbot is able to trigger the following crash [1],
caused by unsafe ip6_dst_idev() use.

Indeed ip6_dst_idev() can return NULL, and must always be checked.

[1]

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 31648 Comm: syz-executor.0 Not tainted 6.9.0-rc4-next-20240417-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
 RIP: 0010:__fib6_rule_action net/ipv6/fib6_rules.c:237 [inline]
 RIP: 0010:fib6_rule_action+0x241/0x7b0 net/ipv6/fib6_rules.c:267
Code: 02 00 00 49 8d 9f d8 00 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 f9 32 bf f7 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 e0 32 bf f7 4c 8b 03 48 89 ef 4c
RSP: 0018:ffffc9000fc1f2f0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1a772f98c8186700
RDX: 0000000000000003 RSI: ffffffff8bcac4e0 RDI: ffffffff8c1f9760
RBP: ffff8880673fb980 R08: ffffffff8fac15ef R09: 1ffffffff1f582bd
R10: dffffc0000000000 R11: fffffbfff1f582be R12: dffffc0000000000
R13: 0000000000000080 R14: ffff888076509000 R15: ffff88807a029a00
FS:  00007f55e82ca6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31d23000 CR3: 0000000022b66000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  fib_rules_lookup+0x62c/0xdb0 net/core/fib_rules.c:317
  fib6_rule_lookup+0x1fd/0x790 net/ipv6/fib6_rules.c:108
  ip6_route_output_flags_noref net/ipv6/route.c:2637 [inline]
  ip6_route_output_flags+0x38e/0x610 net/ipv6/route.c:2649
  ip6_route_output include/net/ip6_route.h:93 [inline]
  ip6_dst_lookup_tail+0x189/0x11a0 net/ipv6/ip6_output.c:1120
  ip6_dst_lookup_flow+0xb9/0x180 net/ipv6/ip6_output.c:1250
  sctp_v6_get_dst+0x792/0x1e20 net/sctp/ipv6.c:326
  sctp_transport_route+0x12c/0x2e0 net/sctp/transport.c:455
  sctp_assoc_add_peer+0x614/0x15c0 net/sctp/associola.c:662
  sctp_connect_new_asoc+0x31d/0x6c0 net/sctp/socket.c:1099
  __sctp_connect+0x66d/0xe30 net/sctp/socket.c:1197
  sctp_connect net/sctp/socket.c:4819 [inline]
  sctp_inet_connect+0x149/0x1f0 net/sctp/socket.c:4834
  __sys_connect_file net/socket.c:2048 [inline]
  __sys_connect+0x2df/0x310 net/socket.c:2065
  __do_sys_connect net/socket.c:2075 [inline]
  __se_sys_connect net/socket.c:2072 [inline]
  __x64_sys_connect+0x7a/0x90 net/socket.c:2072
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 5e5f3f0f8013 ("[IPV6] ADDRCONF: Convert ipv6_get_saddr() to ipv6_dev_get_saddr().")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20240507163145.835254-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/fib6_rules.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 52c04f0ac4981..9e254de7462fb 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -233,8 +233,12 @@ static int __fib6_rule_action(struct fib_rule *rule, struct flowi *flp,
 	rt = pol_lookup_func(lookup,
 			     net, table, flp6, arg->lookup_data, flags);
 	if (rt != net->ipv6.ip6_null_entry) {
+		struct inet6_dev *idev = ip6_dst_idev(&rt->dst);
+
+		if (!idev)
+			goto again;
 		err = fib6_rule_saddr(net, rule, flags, flp6,
-				      ip6_dst_idev(&rt->dst)->dev);
+				      idev->dev);
 
 		if (err == -EAGAIN)
 			goto again;
-- 
2.43.0




