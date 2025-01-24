Return-Path: <stable+bounces-110344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF8AA1AE84
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 03:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96CE16861C
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 02:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871F21D3582;
	Fri, 24 Jan 2025 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="GGNFLT+k"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95A2B9BC
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737685757; cv=none; b=LqBopU6SYA2aqSFd1yzkn1n7H5JRQsuO+RhwaqMBFh9tSEMtkqy+E9hhmmGiYFlOeWJgm7M5C/bKjDnRi4688rU74ALCRNvyBjWk/uy0ze44gLvCxYbluD5Wudv8yV+slGdklQlUjatMPy2tPjnoK64l6OBilgB4+ZQL188hEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737685757; c=relaxed/simple;
	bh=VrjDVR7vm6PVdLX0OjRZzVSniXET7cIE/uoVJkA80OY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=UdPTvvaiFM7AQ0iFWmfiCh+n3bcwrn4CbsqOq5BowbuMyXlHyTWRyIaKj/fbunuOw8wNLfrRU+43vuIvHVSK/Xgfpjrfm4a1g+qZZwUnXe+LvAunR9g6KUr1gK4RAIBGx9nGiBRYbQDdasrT1GYZ1FC8DzXZMqHCeyPRIGmhmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=GGNFLT+k; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1737685744;
	bh=9F0ghmmwPLl5OXCu3c6DXMPcdfu2ZV/7OGw3HY7REsk=;
	h=From:To:Cc:Subject:Date;
	b=GGNFLT+kYsuBjyvPgcOeLWST83qj79MlWFXDcSQgPpsQSj0h7ZUEHCZX7KpzlsD8E
	 f39JpuwPeSue69Rv3q77PnsdB9EaYIqLRml25zKo3EXDgzKayjKFaJqeJP+BiooExL
	 uJKIgXrJwT+JP6HHSvBIEiSGALqUnX4UBs4Xfp8Q=
Received: from public ([120.244.194.224])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 5F982EDE; Fri, 24 Jan 2025 10:23:57 +0800
X-QQ-mid: xmsmtpt1737685437t0kibid5c
Message-ID: <tencent_39296D4D4DD6C7BC24B0B51FCE080C53C306@qq.com>
X-QQ-XMAILINFO: OOO9dHjlsLs7ksJlRQEhti3nWzZPFMQQrBsxsRwl/in87mhSdCEdzBYIbL6McP
	 tUp0cMQCD74sjHsRGw4kF4qhKn2IDjrDVK4E8OJQqfKsMP64rGcaao+87snq0BMEd0qInJHOJSda
	 wawq5+c+QashTO/8iL0CYGfjFzDi/eA8lut1VONAyosJyvEl4eV1Fx7TUzLX4ZdiV3fowOH89QCx
	 0HB6RB/8kfXxa9owQcxj7V/G6/03uA2oj8DoTJXM73XZlu/PRDc7+es63QJEcVjXiVYZj/c2c5HE
	 xLmCQMO0XEUqAqfEbuL5f1Rb5wXvyDX15Z95m1ZjLrPLMtpYSfLqMw7lkaOaeYZ8dG+rNciugVA5
	 7z5Vch+aa+73tESddhUzJF3cqqFW6K7yOa91zqfHsEZvgae5HM2Cmzv6u4QBYETt8rCgQRrIG9ZR
	 3+xNjxnN6vJaKyNRGN8bwkouK0qoRveqProo4qezNtK6TBG3mEyDjCQF8sYnyarUfiU47EUEDSpN
	 ZwHlkM3r+TyAHbxhaCFYsN8CMsAK4I8nEYn7CUxXZQBtriRfQ5yJwoAFOGUJS2nLQslX+zf4p9tQ
	 3c++6R1ItRuS87yAcpFVd6fJyhxa5PVntSn9LyW7Hibuo0uCfrFvEq7jph9phCWjJ8czPNrzCvUB
	 cXHph2KwkU218r7sYJZa7B2EXplu7pfRfKz2wBP/h9FoYd9da3uZta74Bxyk34Z0L6jaMRjxvR9T
	 PQaEFSUU2rKmyQQUTUb1ykU9kLEuKH0C+axJhb6JE8DLgZie6xV8X/AjfNACqcr2RR3sJQd4Rjpb
	 Ai4Ajmj4SJN+p1k6PMM3acNPvBd/LApiTWa254nj5Thlk/7OSl1ULEoWL8+8wu1772Z7W1AF3+DX
	 hIvojvCrQOOlSnWDIz2visf1EM9rz6wr7zfxf312z8uslvDyk/IMKjSaI09GkWMCC9i+MpzzBMAy
	 w1yaB0bKvpJiKQ3O1Wp/H7jFusZV+jMq5DtUt9dgyYX1qUabHAy4J2FeHaSw2aqGqRXbcW2aQNPg
	 dOgAfRTBXbuhhBhTnLLlfr2NKuOBeYI/kVK0UdegDMlqYcfAN+
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.15.y] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
Date: Fri, 24 Jan 2025 10:23:57 +0800
X-OQ-MSGID: <20250124022357.1857-1-alvalan9@foxmail.com>
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
index 2906b4329c23..9f9b7768cd19 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -218,7 +218,7 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 	struct ip_tunnel *t = NULL;
 	struct hlist_head *head = ip_bucket(itn, parms);
 
-	hlist_for_each_entry_rcu(t, head, hash_node) {
+	hlist_for_each_entry_rcu(t, head, hash_node, lockdep_rtnl_is_held()) {
 		if (local == t->parms.iph.saddr &&
 		    remote == t->parms.iph.daddr &&
 		    link == t->parms.link &&
-- 
2.43.0


