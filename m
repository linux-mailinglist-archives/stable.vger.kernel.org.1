Return-Path: <stable+bounces-131006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFB3A80748
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C70519E08F0
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD626AAA3;
	Tue,  8 Apr 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GCzvu7P7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ECB26A0CF;
	Tue,  8 Apr 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115240; cv=none; b=q0Mv1xDfkpzpiQdBV9VW9/3ZEzpHDaidxfp+1tKcacaBceBsoXhESMTXUgTVGW5p/tvUnclDA6FGQB6/KkG8XA0fvuGnCSbjy062YYVW3OHorBg4W4sdWOeJEifY2AOKyme7JTr+Wx8cItS7O/D42pn75ycU+MmIZLBmpcAdbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115240; c=relaxed/simple;
	bh=AFAN788kI2hVxA0wHpR4/YbLCXBrbypBzxphoLxwjYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKwLbYAWHBbFNLglEw9RQZjL6+DYjydqj3AvipHIxnLpkhbBXdUyyc1LgY55m9kMrPhTPThHXblqGN3yhA7Bes2CjZBYqkpzFtrcXEAbENfu/NxB8IiNJtivSBzay+8Ro2VrRdMJ6eGn8DFAiOQjWmN1i0PgsUdQp3uHPSBRq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GCzvu7P7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0C0C4CEE5;
	Tue,  8 Apr 2025 12:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115240;
	bh=AFAN788kI2hVxA0wHpR4/YbLCXBrbypBzxphoLxwjYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCzvu7P734jSoEi3ea4lLDl2yUu6uEydrUByltlXul1J+tunM3j7OApusS5tExe1o
	 RpSAeifIDOSWyX9bJO+9g2SgLDA10ZKbdziywnsMwp3/LKRX3FY9tG/uJbiO4KXWle
	 9XPc9grFtNyiH/9qFI9rUhoAS05J9zsiTno/YWMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lin Ma <linma@zju.edu.cn>,
	Xin Long <lucien.xin@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 401/499] net: fix geneve_opt length integer overflow
Date: Tue,  8 Apr 2025 12:50:13 +0200
Message-ID: <20250408104901.227731772@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit b27055a08ad4b415dcf15b63034f9cb236f7fb40 ]

struct geneve_opt uses 5 bit length for each single option, which
means every vary size option should be smaller than 128 bytes.

However, all current related Netlink policies cannot promise this
length condition and the attacker can exploit a exact 128-byte size
option to *fake* a zero length option and confuse the parsing logic,
further achieve heap out-of-bounds read.

One example crash log is like below:

[    3.905425] ==================================================================
[    3.905925] BUG: KASAN: slab-out-of-bounds in nla_put+0xa9/0xe0
[    3.906255] Read of size 124 at addr ffff888005f291cc by task poc/177
[    3.906646]
[    3.906775] CPU: 0 PID: 177 Comm: poc-oob-read Not tainted 6.1.132 #1
[    3.907131] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    3.907784] Call Trace:
[    3.907925]  <TASK>
[    3.908048]  dump_stack_lvl+0x44/0x5c
[    3.908258]  print_report+0x184/0x4be
[    3.909151]  kasan_report+0xc5/0x100
[    3.909539]  kasan_check_range+0xf3/0x1a0
[    3.909794]  memcpy+0x1f/0x60
[    3.909968]  nla_put+0xa9/0xe0
[    3.910147]  tunnel_key_dump+0x945/0xba0
[    3.911536]  tcf_action_dump_1+0x1c1/0x340
[    3.912436]  tcf_action_dump+0x101/0x180
[    3.912689]  tcf_exts_dump+0x164/0x1e0
[    3.912905]  fw_dump+0x18b/0x2d0
[    3.913483]  tcf_fill_node+0x2ee/0x460
[    3.914778]  tfilter_notify+0xf4/0x180
[    3.915208]  tc_new_tfilter+0xd51/0x10d0
[    3.918615]  rtnetlink_rcv_msg+0x4a2/0x560
[    3.919118]  netlink_rcv_skb+0xcd/0x200
[    3.919787]  netlink_unicast+0x395/0x530
[    3.921032]  netlink_sendmsg+0x3d0/0x6d0
[    3.921987]  __sock_sendmsg+0x99/0xa0
[    3.922220]  __sys_sendto+0x1b7/0x240
[    3.922682]  __x64_sys_sendto+0x72/0x90
[    3.922906]  do_syscall_64+0x5e/0x90
[    3.923814]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[    3.924122] RIP: 0033:0x7e83eab84407
[    3.924331] Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 faf
[    3.925330] RSP: 002b:00007ffff505e370 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[    3.925752] RAX: ffffffffffffffda RBX: 00007e83eaafa740 RCX: 00007e83eab84407
[    3.926173] RDX: 00000000000001a8 RSI: 00007ffff505e3c0 RDI: 0000000000000003
[    3.926587] RBP: 00007ffff505f460 R08: 00007e83eace1000 R09: 000000000000000c
[    3.926977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffff505f3c0
[    3.927367] R13: 00007ffff505f5c8 R14: 00007e83ead1b000 R15: 00005d4fbbe6dcb8

Fix these issues by enforing correct length condition in related
policies.

Fixes: 925d844696d9 ("netfilter: nft_tunnel: add support for geneve opts")
Fixes: 4ece47787077 ("lwtunnel: add options setting and dumping for geneve")
Fixes: 0ed5269f9e41 ("net/sched: add tunnel option support to act_tunnel_key")
Fixes: 0a6e77784f49 ("net/sched: allow flower to match tunnel options")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Link: https://patch.msgid.link/20250402165632.6958-1-linma@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_tunnel_core.c  | 2 +-
 net/netfilter/nft_tunnel.c | 2 +-
 net/sched/act_tunnel_key.c | 2 +-
 net/sched/cls_flower.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 364ea798511ea..f65d2f7273813 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -451,7 +451,7 @@ static const struct nla_policy
 geneve_opt_policy[LWTUNNEL_IP_OPT_GENEVE_MAX + 1] = {
 	[LWTUNNEL_IP_OPT_GENEVE_CLASS]	= { .type = NLA_U16 },
 	[LWTUNNEL_IP_OPT_GENEVE_TYPE]	= { .type = NLA_U8 },
-	[LWTUNNEL_IP_OPT_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 128 },
+	[LWTUNNEL_IP_OPT_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 127 },
 };
 
 static const struct nla_policy
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 2e40f575aed9f..0c63d1367cf7a 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -335,7 +335,7 @@ static int nft_tunnel_obj_erspan_init(const struct nlattr *attr,
 static const struct nla_policy nft_tunnel_opts_geneve_policy[NFTA_TUNNEL_KEY_GENEVE_MAX + 1] = {
 	[NFTA_TUNNEL_KEY_GENEVE_CLASS]	= { .type = NLA_U16 },
 	[NFTA_TUNNEL_KEY_GENEVE_TYPE]	= { .type = NLA_U8 },
-	[NFTA_TUNNEL_KEY_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 128 },
+	[NFTA_TUNNEL_KEY_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 127 },
 };
 
 static int nft_tunnel_obj_geneve_init(const struct nlattr *attr,
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index af7c998459488..e296714803dc0 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -68,7 +68,7 @@ geneve_opt_policy[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_MAX + 1] = {
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_CLASS]	   = { .type = NLA_U16 },
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_TYPE]	   = { .type = NLA_U8 },
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_DATA]	   = { .type = NLA_BINARY,
-						       .len = 128 },
+						       .len = 127 },
 };
 
 static const struct nla_policy
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 03505673d5234..099ff6a3e1f51 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -766,7 +766,7 @@ geneve_opt_policy[TCA_FLOWER_KEY_ENC_OPT_GENEVE_MAX + 1] = {
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_CLASS]      = { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_TYPE]       = { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_DATA]       = { .type = NLA_BINARY,
-						       .len = 128 },
+						       .len = 127 },
 };
 
 static const struct nla_policy
-- 
2.39.5




