Return-Path: <stable+bounces-42260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5948B7222
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918FB1C21377
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5C12C819;
	Tue, 30 Apr 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CQXzcwEV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8312C462;
	Tue, 30 Apr 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475085; cv=none; b=YDY+GJfFdmL142RfFcUHXUpNMNHuDsZ1CGSIqvHW6WDjJixurJNxvqfTw5R7zu3tgGvaT2zd9ydhyRKIbeQYj5AKvu4QHTGVMBIUaCOBnifV8XoJbMT2gbXIv9Q5XKiQokHZKaNV+0iWYhwLssTBDxwGAqTct2AORVuaVvRclnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475085; c=relaxed/simple;
	bh=VbsZ9jOMhUoGUDEQgrprzQOZN3KJBfTmIzLkJhQ8D5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9rlT0nEfalK8/ZPuoMYuZZqi91SxJJL59crF68K8nE+v83UKu4N8XuXj+tW6Jl2hthE+l+IYHYV0kxYVY59TnrKVj+benEnd+FD9wW09XTALLE1Uktz3X4O7dygUHJZKqhvnXBhIwYmYgpNkxJC2/f6E96hH1jwPhpZPfu1JFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CQXzcwEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2576C2BBFC;
	Tue, 30 Apr 2024 11:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475085;
	bh=VbsZ9jOMhUoGUDEQgrprzQOZN3KJBfTmIzLkJhQ8D5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQXzcwEV2GCHSbZ81jsLzOCxotyH35WQDEs3PqXo3fptq2D3IL2IAGJsZYC7aA8OI
	 bYlHQLMgootGEbkmt10Kw6CMB4QQllvQ3g75pSaPeO0LdgJScumMZEnt9R8gjtu77s
	 Ydk78w+oK8ebhhtJ0uFy+X8YWgOsD00nsG9B4TWg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 088/138] ipv4: check for NULL idev in ip_route_use_hint()
Date: Tue, 30 Apr 2024 12:39:33 +0200
Message-ID: <20240430103052.011314896@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103049.422035273@linuxfoundation.org>
References: <20240430103049.422035273@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 58a4c9b1e5a3e53c9148e80b90e1e43897ce77d1 ]

syzbot was able to trigger a NULL deref in fib_validate_source()
in an old tree [1].

It appears the bug exists in latest trees.

All calls to __in_dev_get_rcu() must be checked for a NULL result.

[1]
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 2 PID: 3257 Comm: syz-executor.3 Not tainted 5.10.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 RIP: 0010:fib_validate_source+0xbf/0x15a0 net/ipv4/fib_frontend.c:425
Code: 18 f2 f2 f2 f2 42 c7 44 20 23 f3 f3 f3 f3 48 89 44 24 78 42 c6 44 20 27 f3 e8 5d 88 48 fc 4c 89 e8 48 c1 e8 03 48 89 44 24 18 <42> 80 3c 20 00 74 08 4c 89 ef e8 d2 15 98 fc 48 89 5c 24 10 41 bf
RSP: 0018:ffffc900015fee40 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88800f7a4000 RCX: ffff88800f4f90c0
RDX: 0000000000000000 RSI: 0000000004001eac RDI: ffff8880160c64c0
RBP: ffffc900015ff060 R08: 0000000000000000 R09: ffff88800f7a4000
R10: 0000000000000002 R11: ffff88800f4f90c0 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88800f7a4000
FS:  00007f938acfe6c0(0000) GS:ffff888058c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f938acddd58 CR3: 000000001248e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ip_route_use_hint+0x410/0x9b0 net/ipv4/route.c:2231
  ip_rcv_finish_core+0x2c4/0x1a30 net/ipv4/ip_input.c:327
  ip_list_rcv_finish net/ipv4/ip_input.c:612 [inline]
  ip_sublist_rcv+0x3ed/0xe50 net/ipv4/ip_input.c:638
  ip_list_rcv+0x422/0x470 net/ipv4/ip_input.c:673
  __netif_receive_skb_list_ptype net/core/dev.c:5572 [inline]
  __netif_receive_skb_list_core+0x6b1/0x890 net/core/dev.c:5620
  __netif_receive_skb_list net/core/dev.c:5672 [inline]
  netif_receive_skb_list_internal+0x9f9/0xdc0 net/core/dev.c:5764
  netif_receive_skb_list+0x55/0x3e0 net/core/dev.c:5816
  xdp_recv_frames net/bpf/test_run.c:257 [inline]
  xdp_test_run_batch net/bpf/test_run.c:335 [inline]
  bpf_test_run_xdp_live+0x1818/0x1d00 net/bpf/test_run.c:363
  bpf_prog_test_run_xdp+0x81f/0x1170 net/bpf/test_run.c:1376
  bpf_prog_test_run+0x349/0x3c0 kernel/bpf/syscall.c:3736
  __sys_bpf+0x45c/0x710 kernel/bpf/syscall.c:5115
  __do_sys_bpf kernel/bpf/syscall.c:5201 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:5199 [inline]
  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5199

Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240421184326.1704930-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/route.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b7cba4bdc5786..cc409cc0789c8 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2088,6 +2088,9 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	int err = -EINVAL;
 	u32 tag = 0;
 
+	if (!in_dev)
+		return -EINVAL;
+
 	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
 		goto martian_source;
 
-- 
2.43.0




