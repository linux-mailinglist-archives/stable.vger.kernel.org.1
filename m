Return-Path: <stable+bounces-102941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB31E9EF56C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8638D17936F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BD5226531;
	Thu, 12 Dec 2024 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="klSADrY5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910422652B;
	Thu, 12 Dec 2024 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023057; cv=none; b=V0+RvvQzLW9WY38eAxKqbZ96sYifCYsiDgzsREkHi1J0MWdz2jNDxVSKeOyP//FHEo9RKjTnFOJwN5WMj5hKTidfrvY2aTUtRTQWUdu7bPKM1FuyfmsQcXhw8bjaedhyr+0meyFLNmUDuPFVdN1e9P2IKEmtdPMd+RUhmoiTlVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023057; c=relaxed/simple;
	bh=Jx/izy/xjAH/OsacyLjyzOjqz8qjgVri507yhZbjDSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBUlE3uoWpjllcWdRpZzK/7ISubCwXAPVCgC1fumbgXj2bNr6aTaFsTYyMcG/Unm3JPcBFN4tnjeI/1M+apwi1p3sA+5coC5FP17EYxmeoHS8Xdec2ECUUzQoeCuClhClk+zFzAXKYR8MV1vE2XV8zEsTIxK/QjDH+jwayFOS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=klSADrY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BFDC4CED0;
	Thu, 12 Dec 2024 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023057;
	bh=Jx/izy/xjAH/OsacyLjyzOjqz8qjgVri507yhZbjDSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=klSADrY5L/Oe0nEtKLTVP717A8j86c5O+x/UdPQj9+rq55pkLBY8nXprMeaJW3qdm
	 ZVnbXQXP+ovkNclvLuW0pi6YsjOAj/Lxc3IPoQPNH36MENcis0OdZRD/7CeQ3siz9n
	 bVVbw6Vexl0OF5tDb6FCt1C3DbQ1yLo4SjOXb9a4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+6c8215822f35fdb35667@syzkaller.appspotmail.com,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 409/565] netfilter: x_tables: fix LED ID check in led_tg_check()
Date: Thu, 12 Dec 2024 16:00:04 +0100
Message-ID: <20241212144327.825245465@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 04317f4eb2aad312ad85c1a17ad81fe75f1f9bc7 ]

Syzbot has reported the following BUG detected by KASAN:

BUG: KASAN: slab-out-of-bounds in strlen+0x58/0x70
Read of size 1 at addr ffff8881022da0c8 by task repro/5879
...
Call Trace:
 <TASK>
 dump_stack_lvl+0x241/0x360
 ? __pfx_dump_stack_lvl+0x10/0x10
 ? __pfx__printk+0x10/0x10
 ? _printk+0xd5/0x120
 ? __virt_addr_valid+0x183/0x530
 ? __virt_addr_valid+0x183/0x530
 print_report+0x169/0x550
 ? __virt_addr_valid+0x183/0x530
 ? __virt_addr_valid+0x183/0x530
 ? __virt_addr_valid+0x45f/0x530
 ? __phys_addr+0xba/0x170
 ? strlen+0x58/0x70
 kasan_report+0x143/0x180
 ? strlen+0x58/0x70
 strlen+0x58/0x70
 kstrdup+0x20/0x80
 led_tg_check+0x18b/0x3c0
 xt_check_target+0x3bb/0xa40
 ? __pfx_xt_check_target+0x10/0x10
 ? stack_depot_save_flags+0x6e4/0x830
 ? nft_target_init+0x174/0xc30
 nft_target_init+0x82d/0xc30
 ? __pfx_nft_target_init+0x10/0x10
 ? nf_tables_newrule+0x1609/0x2980
 ? nf_tables_newrule+0x1609/0x2980
 ? rcu_is_watching+0x15/0xb0
 ? nf_tables_newrule+0x1609/0x2980
 ? nf_tables_newrule+0x1609/0x2980
 ? __kmalloc_noprof+0x21a/0x400
 nf_tables_newrule+0x1860/0x2980
 ? __pfx_nf_tables_newrule+0x10/0x10
 ? __nla_parse+0x40/0x60
 nfnetlink_rcv+0x14e5/0x2ab0
 ? __pfx_validate_chain+0x10/0x10
 ? __pfx_nfnetlink_rcv+0x10/0x10
 ? __lock_acquire+0x1384/0x2050
 ? netlink_deliver_tap+0x2e/0x1b0
 ? __pfx_lock_release+0x10/0x10
 ? netlink_deliver_tap+0x2e/0x1b0
 netlink_unicast+0x7f8/0x990
 ? __pfx_netlink_unicast+0x10/0x10
 ? __virt_addr_valid+0x183/0x530
 ? __check_object_size+0x48e/0x900
 netlink_sendmsg+0x8e4/0xcb0
 ? __pfx_netlink_sendmsg+0x10/0x10
 ? aa_sock_msg_perm+0x91/0x160
 ? __pfx_netlink_sendmsg+0x10/0x10
 __sock_sendmsg+0x223/0x270
 ____sys_sendmsg+0x52a/0x7e0
 ? __pfx_____sys_sendmsg+0x10/0x10
 __sys_sendmsg+0x292/0x380
 ? __pfx___sys_sendmsg+0x10/0x10
 ? lockdep_hardirqs_on_prepare+0x43d/0x780
 ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
 ? exc_page_fault+0x590/0x8c0
 ? do_syscall_64+0xb6/0x230
 do_syscall_64+0xf3/0x230
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
...
 </TASK>

Since an invalid (without '\0' byte at all) byte sequence may be passed
from userspace, add an extra check to ensure that such a sequence is
rejected as possible ID and so never passed to 'kstrdup()' and further.

Reported-by: syzbot+6c8215822f35fdb35667@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c8215822f35fdb35667
Fixes: 268cb38e1802 ("netfilter: x_tables: add LED trigger target")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_LED.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/xt_LED.c b/net/netfilter/xt_LED.c
index 211bfa2a2ac04..c2c10a536cc68 100644
--- a/net/netfilter/xt_LED.c
+++ b/net/netfilter/xt_LED.c
@@ -97,7 +97,9 @@ static int led_tg_check(const struct xt_tgchk_param *par)
 	struct xt_led_info_internal *ledinternal;
 	int err;
 
-	if (ledinfo->id[0] == '\0')
+	/* Bail out if empty string or not a string at all. */
+	if (ledinfo->id[0] == '\0' ||
+	    !memchr(ledinfo->id, '\0', sizeof(ledinfo->id)))
 		return -EINVAL;
 
 	mutex_lock(&xt_led_mutex);
-- 
2.43.0




