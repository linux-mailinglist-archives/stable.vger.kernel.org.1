Return-Path: <stable+bounces-131313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7543AA80990
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EF14E5351
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8E926A0E2;
	Tue,  8 Apr 2025 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qZ1KWDEe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80826A0C5;
	Tue,  8 Apr 2025 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116059; cv=none; b=Hrik7dDELv2HzSOdkRW0DSVb6pMCRktvl/cGYcCCs3w/x5YcPrg/ROQEfSHWXCx7dm9Ww8gta3Q71ZLaFa78U8qRetj9f8mmsExTROCL0VhLwXn8KBZHn6vO0mSPlCdWKno8LHrQvgjfij6wVw3Z1doxKuBVfbNmLHRjxHAkgYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116059; c=relaxed/simple;
	bh=kvOBQYxJzwAZuYE3DIo/aOr32ITIx12bGTdRDef8fcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRPseLdKzxn4kPqvajYBnu5QjnfMnnqmdVOTYEd+kGjzoUiTZq5wN6ndBLq51HKtMALoa/BRK0Zt1oOo3LNbKnLoye6t1Wuf7ijvAhrxDTZrQosY+z7BVxzHweslUjzmSapFgWjevZQwX2O8Z1byBbQHeMeye/oo0kxdGTgh7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qZ1KWDEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71685C4CEE5;
	Tue,  8 Apr 2025 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116058;
	bh=kvOBQYxJzwAZuYE3DIo/aOr32ITIx12bGTdRDef8fcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZ1KWDEeHg4lOKMsTlQXxHwbA2ipK2WSupYisHftNSUV5+cr6CEiqMxStM61A3aYP
	 mM7y22pEY8n7LHplemonykywv9NxeUeCko/K2//477GpiFvyHmV9RMFQApNv4zgW3D
	 u447MMd1u749eoR+w1bcJCvmDYrJujAEHtEIi8xg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lin Ma <linma@zju.edu.cn>,
	Xin Long <lucien.xin@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 165/204] net: fix geneve_opt length integer overflow
Date: Tue,  8 Apr 2025 12:51:35 +0200
Message-ID: <20250408104825.160356431@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index fda08e2c72899..deb08cab44640 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -450,7 +450,7 @@ static const struct nla_policy
 geneve_opt_policy[LWTUNNEL_IP_OPT_GENEVE_MAX + 1] = {
 	[LWTUNNEL_IP_OPT_GENEVE_CLASS]	= { .type = NLA_U16 },
 	[LWTUNNEL_IP_OPT_GENEVE_TYPE]	= { .type = NLA_U8 },
-	[LWTUNNEL_IP_OPT_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 128 },
+	[LWTUNNEL_IP_OPT_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 127 },
 };
 
 static const struct nla_policy
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 01ce65dd2078e..d026982a00fc4 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -333,7 +333,7 @@ static int nft_tunnel_obj_erspan_init(const struct nlattr *attr,
 static const struct nla_policy nft_tunnel_opts_geneve_policy[NFTA_TUNNEL_KEY_GENEVE_MAX + 1] = {
 	[NFTA_TUNNEL_KEY_GENEVE_CLASS]	= { .type = NLA_U16 },
 	[NFTA_TUNNEL_KEY_GENEVE_TYPE]	= { .type = NLA_U8 },
-	[NFTA_TUNNEL_KEY_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 128 },
+	[NFTA_TUNNEL_KEY_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 127 },
 };
 
 static int nft_tunnel_obj_geneve_init(const struct nlattr *attr,
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 2691a3d8e4511..55a9dff1cc1e6 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -66,7 +66,7 @@ geneve_opt_policy[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_MAX + 1] = {
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_CLASS]	   = { .type = NLA_U16 },
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_TYPE]	   = { .type = NLA_U8 },
 	[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_DATA]	   = { .type = NLA_BINARY,
-						       .len = 128 },
+						       .len = 127 },
 };
 
 static const struct nla_policy
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index b4a7952c5d7da..a40a9e84c75f4 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -732,7 +732,7 @@ geneve_opt_policy[TCA_FLOWER_KEY_ENC_OPT_GENEVE_MAX + 1] = {
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_CLASS]      = { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_TYPE]       = { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ENC_OPT_GENEVE_DATA]       = { .type = NLA_BINARY,
-						       .len = 128 },
+						       .len = 127 },
 };
 
 static const struct nla_policy
-- 
2.39.5




