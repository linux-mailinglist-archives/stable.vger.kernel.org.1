Return-Path: <stable+bounces-110343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B219A1AE82
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 03:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D24B3A86B3
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 02:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24091D3582;
	Fri, 24 Jan 2025 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="vj718s8o"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646362B9BC
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737685694; cv=none; b=LBgFJd/AJtUilaRa9QWpCqBpcXenaIvJS7WrCqw3vUtdZRMPH42tdQGDm82oZVSWDEV3y2gqsn00vEXLYgq4+NjPtaiqQ6A5pn4kRQoycJlp9rbPrrfwZTkFFv+Ke5M7jDapvv65xqwYaY0HlAXiaNYw9ng2d5l+D1N2FbBo7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737685694; c=relaxed/simple;
	bh=4gzhe7Y265dPtbt97DP6pNF/N9jPwgWt2JCugzrNhZw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Pbwmr12QzR209KW+0dY5K8xMW9ZHstUNnoZDrQJ47UHlDxSuTTGxLwj92Se+tlivfUB2sviKa3XCK2Zfhgb5y3mp1Ps6aNKYxHZe23xPOlFD1epSMhWhsbRStjc7MRFPTPDBI/cIpC9D9TVgNhPQKAUJSGfbDP6zrsJ0bCgngbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=vj718s8o; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1737685378;
	bh=f7306y+C3V/lbGibrO6xRcAa0Y3IYq/gsLcuyEn5g5g=;
	h=From:To:Cc:Subject:Date;
	b=vj718s8oh3St6RYjrSToW77Hzzprv41UW5rcVdWmuDg80oe+c8k3l2+FDHL9iuPUN
	 rhueMj3xOTAvqMyPg9MdPRIs9K0bTER9Vqu5c8WesJZoTAhYIC5FdrnshjwFAYGIIQ
	 oS+KqjH6/G4HRdVTUbfopNXvjneSI3ahtpFiW0uQ=
Received: from public ([120.244.194.224])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 5AD982F5; Fri, 24 Jan 2025 10:22:45 +0800
X-QQ-mid: xmsmtpt1737685365tvu7lj9am
Message-ID: <tencent_C84F430BAD560DD787812499B5130E0A4C06@qq.com>
X-QQ-XMAILINFO: MoPVgyGdM21etnEDetQGMd+oz6HBJ6UeheTEDJngHM5F+kL77jQGPeGu9PitV4
	 1vPkc3casVMaHQkYvZr0UyGYpdjo7oHUGkUyxRclz8+HsbPv+orVzZfdaS8XZLeeF3pEarECOCfz
	 4BbvkrxWebqbY0CF5Beav8zuqujSxZ0HKOC6teRucYufNb2XjgodRpnAJ2lU4WBXYPzlmC4njdMQ
	 7umM6XrvwsmN6Eirefwk88kSx3Mi9Arbxi9uAgUzH5pI5c3mfTScGovdLgthlFk7Swk5KK3Y/vOk
	 8Tw5HbjsEFcsBKneUkz5sUofYQhyNt/zsS49B6i938p2rF30Dx8L2AqCQkuONLz7dm4bkHtxwy/a
	 jUDfL2vGubmX4AadnoNSZiS1ZkLndaU8oIaSlsTZ9LWt4FNzMG/eLZS68MwaJijtw/sr+wsDcHCb
	 uL5BnVEXFyzi2k2kOjvT8jPWqgqDhiPVj5vjQkrJJ718RZd1+FBDKHMlr6WOdkqcRGnz8CCJmbrA
	 lQH5E0onmMJR6DITb9xZveHGCov+4cLREFSoJKufrTO5Ns/1KNDfAxZOBzBFsKCtrX66N1VU0QyL
	 dOjjqMCCgRHY3ZcXIxP7KKQwzBvL01LeGomSfC5WpIBPjeB3rdeSTYuTILbQh9QAnjDFU/eRYkEj
	 A6B6AVOA5q/jgLE4Bu1mfwSD6dEcTdx5EH6ukn5PSNmxN2rN1VRCLYS3uH0UwPtdl6LvrUwHmBXf
	 9GO8Nft1APiscGZ3lWiF1mVIAnVWHbvaZmIBud6QJ1flIqrNsx0asaehDZOg3vvt4v442riLVxxw
	 o69fAwGikmHzb+3/IlrCmaZlZSGBzZYfUPLY4eeCI6AMjNpajvpXzTYfLAKHANStiw2mR3KlQrXp
	 pe7YFpv432y4u9SEN1AW7sGLfz0bmobCEPDzVfAZCSqCSAsJVrhiE7BX1oYRpOU0H1eBHWm2DIP8
	 +xXhuvLcjcjhvwD9strTtMs6kYc/RyAP/Wku33Bfo=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
Date: Fri, 24 Jan 2025 10:22:45 +0800
X-OQ-MSGID: <20250124022245.1536-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

commit 90e0569dd3d32f4f4d2ca691d3fa5a8a14a13c12 upstream.

The per-netns IP tunnel hash table is protected by the RTNL mutex and
ip_tunnel_find() is only called from the control path where the mutex is
taken.

Add a lockdep expression to hlist_for_each_entry_rcu() in
ip_tunnel_find() in order to validate that the mutex is held and to
silence the suspicious RCU usage warning [1].

[1]
WARNING: suspicious RCU usage
6.12.0-rc3-custom-gd95d9a31aceb #139 Not tainted
-----------------------------
net/ipv4/ip_tunnel.c:221 RCU-list traversed in non-reader section!!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by ip/362:
 #0: ffffffff86fc7cb0 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x377/0xf60

stack backtrace:
CPU: 12 UID: 0 PID: 362 Comm: ip Not tainted 6.12.0-rc3-custom-gd95d9a31aceb #139
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <TASK>
 dump_stack_lvl+0xba/0x110
 lockdep_rcu_suspicious.cold+0x4f/0xd6
 ip_tunnel_find+0x435/0x4d0
 ip_tunnel_newlink+0x517/0x7a0
 ipgre_newlink+0x14c/0x170
 __rtnl_newlink+0x1173/0x19c0
 rtnl_newlink+0x6c/0xa0
 rtnetlink_rcv_msg+0x3cc/0xf60
 netlink_rcv_skb+0x171/0x450
 netlink_unicast+0x539/0x7f0
 netlink_sendmsg+0x8c1/0xd80
 ____sys_sendmsg+0x8f9/0xc20
 ___sys_sendmsg+0x197/0x1e0
 __sys_sendmsg+0x122/0x1f0
 do_syscall_64+0xbb/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241023123009.749764-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 net/ipv4/ip_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index dd1803bf9c5c..b5d64cd3ab0a 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -218,7 +218,7 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 	struct ip_tunnel *t = NULL;
 	struct hlist_head *head = ip_bucket(itn, parms);
 
-	hlist_for_each_entry_rcu(t, head, hash_node) {
+	hlist_for_each_entry_rcu(t, head, hash_node, lockdep_rtnl_is_held()) {
 		if (local == t->parms.iph.saddr &&
 		    remote == t->parms.iph.daddr &&
 		    link == READ_ONCE(t->parms.link) &&
-- 
2.34.1


