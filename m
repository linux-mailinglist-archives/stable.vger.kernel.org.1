Return-Path: <stable+bounces-131653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA43A80B44
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F99501D0B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8B126F451;
	Tue,  8 Apr 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AxT8luyQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A85269823;
	Tue,  8 Apr 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116975; cv=none; b=UZui+gsgymdHXwP3V2i+NY2EVKs0iNJu8usj2kSfTs1Wme7++Tt2bH0qAP7c/QHcVn+Nr3KY07yIfDQb5df0jZ00kpKgCPf8CF375EuJme2E1AHcL9NFnYhGClxJQQ/1vxkgcgGmTjhdPgqeUTIJZgAKc2b9Lxg0uljtqrBPES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116975; c=relaxed/simple;
	bh=ikLHNDsz3NUQz+zb76U/Fv6ImxGCrdQvyrJNTwGqErM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtPWeeRULGwRYiV4djWq1ZcH2QX/YDyel7qpXc+xpOCn7PlXXLqpCZpJ5K3BNFm5bBLyRQN20KTFtXX5koxqrTM6QX6OHuOdw63l38hGFLXUJ4KQX2Qqis+vVDsHIyZeQyDi6jMCn5Uidd8JgnYQVN9ADFlCcXZpvKAIQOC1kdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AxT8luyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B611C4CEE5;
	Tue,  8 Apr 2025 12:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116975;
	bh=ikLHNDsz3NUQz+zb76U/Fv6ImxGCrdQvyrJNTwGqErM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxT8luyQ6pEpBtrHEJX9RhDKUvhRaYjB3fS0jiUaN5WXKC/MSD/ZyTpiuRdidsNs2
	 yPMUFw/IKwZ8u4MHhJfcib7P9Au/QwPQaembD8Yu+hjof19/e0h4Izw3xwQ20RtRNz
	 h6wkhxYp/TXxPA5F19UN5lggCPPzL6s2AoELR4sw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lin Ma <linma@zju.edu.cn>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 337/423] netfilter: nft_tunnel: fix geneve_opt type confusion addition
Date: Tue,  8 Apr 2025 12:51:03 +0200
Message-ID: <20250408104853.683854150@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 1b755d8eb1ace3870789d48fbd94f386ad6e30be ]

When handling multiple NFTA_TUNNEL_KEY_OPTS_GENEVE attributes, the
parsing logic should place every geneve_opt structure one by one
compactly. Hence, when deciding the next geneve_opt position, the
pointer addition should be in units of char *.

However, the current implementation erroneously does type conversion
before the addition, which will lead to heap out-of-bounds write.

[    6.989857] ==================================================================
[    6.990293] BUG: KASAN: slab-out-of-bounds in nft_tunnel_obj_init+0x977/0xa70
[    6.990725] Write of size 124 at addr ffff888005f18974 by task poc/178
[    6.991162]
[    6.991259] CPU: 0 PID: 178 Comm: poc-oob-write Not tainted 6.1.132 #1
[    6.991655] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    6.992281] Call Trace:
[    6.992423]  <TASK>
[    6.992586]  dump_stack_lvl+0x44/0x5c
[    6.992801]  print_report+0x184/0x4be
[    6.993790]  kasan_report+0xc5/0x100
[    6.994252]  kasan_check_range+0xf3/0x1a0
[    6.994486]  memcpy+0x38/0x60
[    6.994692]  nft_tunnel_obj_init+0x977/0xa70
[    6.995677]  nft_obj_init+0x10c/0x1b0
[    6.995891]  nf_tables_newobj+0x585/0x950
[    6.996922]  nfnetlink_rcv_batch+0xdf9/0x1020
[    6.998997]  nfnetlink_rcv+0x1df/0x220
[    6.999537]  netlink_unicast+0x395/0x530
[    7.000771]  netlink_sendmsg+0x3d0/0x6d0
[    7.001462]  __sock_sendmsg+0x99/0xa0
[    7.001707]  ____sys_sendmsg+0x409/0x450
[    7.002391]  ___sys_sendmsg+0xfd/0x170
[    7.003145]  __sys_sendmsg+0xea/0x170
[    7.004359]  do_syscall_64+0x5e/0x90
[    7.005817]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[    7.006127] RIP: 0033:0x7ec756d4e407
[    7.006339] Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 faf
[    7.007364] RSP: 002b:00007ffed5d46760 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[    7.007827] RAX: ffffffffffffffda RBX: 00007ec756cc4740 RCX: 00007ec756d4e407
[    7.008223] RDX: 0000000000000000 RSI: 00007ffed5d467f0 RDI: 0000000000000003
[    7.008620] RBP: 00007ffed5d468a0 R08: 0000000000000000 R09: 0000000000000000
[    7.009039] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[    7.009429] R13: 00007ffed5d478b0 R14: 00007ec756ee5000 R15: 00005cbd4e655cb8

Fix this bug with correct pointer addition and conversion in parse
and dump code.

Fixes: 925d844696d9 ("netfilter: nft_tunnel: add support for geneve opts")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_tunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 5c6ed68cc6e05..52d76b8d15db2 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -341,7 +341,7 @@ static const struct nla_policy nft_tunnel_opts_geneve_policy[NFTA_TUNNEL_KEY_GEN
 static int nft_tunnel_obj_geneve_init(const struct nlattr *attr,
 				      struct nft_tunnel_opts *opts)
 {
-	struct geneve_opt *opt = (struct geneve_opt *)opts->u.data + opts->len;
+	struct geneve_opt *opt = (struct geneve_opt *)(opts->u.data + opts->len);
 	struct nlattr *tb[NFTA_TUNNEL_KEY_GENEVE_MAX + 1];
 	int err, data_len;
 
@@ -628,7 +628,7 @@ static int nft_tunnel_opts_dump(struct sk_buff *skb,
 		if (!inner)
 			goto failure;
 		while (opts->len > offset) {
-			opt = (struct geneve_opt *)opts->u.data + offset;
+			opt = (struct geneve_opt *)(opts->u.data + offset);
 			if (nla_put_be16(skb, NFTA_TUNNEL_KEY_GENEVE_CLASS,
 					 opt->opt_class) ||
 			    nla_put_u8(skb, NFTA_TUNNEL_KEY_GENEVE_TYPE,
-- 
2.39.5




