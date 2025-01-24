Return-Path: <stable+bounces-110346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F3FA1AE8A
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 03:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F1916B616
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 02:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE03B1D61A3;
	Fri, 24 Jan 2025 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="rgO+3NrA"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662321D516B
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 02:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737685804; cv=none; b=Zm8utVOimcruFciVsYRsyXNVZyaIxWxMICiMuJbpNs4cmQ0+fkDPVVQm2CNatV+R6JszUpziZUyMgygMXkjkfjZjqVhlzdGMy7W1+NX6reZa39lIsskmxjl+DjsiMJyovdXBZPdvbY8M43/HO+qRg9gGY5P5Rnu6MOzFiygUjVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737685804; c=relaxed/simple;
	bh=F47Tca2MYrT5IQOk2awPCOzMhxNzzQ6LZYtdDnBtjtM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=KqUG0LPlAD5rar3CQK0rvLVJKd+6vg5g/Tpg6spT0w0p3A7lQZ14Swig/anNc/iXslKRetNtX1cT75wXOMaUM30G9KUDiNRbKf9G5miV3sG1XpztgrsUsjFlmY8f7sBjG9rVpxve0EcWaKfvUdzS3P880k0w9TneLuAq+4QPuUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=rgO+3NrA; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1737685797;
	bh=NKcbWtHOsUQi4WJxoE5pmVKonACAisSO0rIsjXTSVZQ=;
	h=From:To:Cc:Subject:Date;
	b=rgO+3NrAJmtw32WPbIDGdPx6lDVPM5YjFl0eRnzZGbAl2KatcA1SbsTQmB0Ab8Gaf
	 4PY1e58nFppWqERxuOLsDIkIZ01vodcPgd1aRBAQ1MeUkeT10xJgEIIujEvXhIMju/
	 LCtugrjjZ5FdDuHpeOdZE7+sSUdWtAE7bFabE6mU=
Received: from public ([120.244.194.224])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 5E319473; Fri, 24 Jan 2025 10:23:35 +0800
X-QQ-mid: xmsmtpt1737685415tewa7a7v0
Message-ID: <tencent_998136A306E5834F52C53A0B6701A6AFE105@qq.com>
X-QQ-XMAILINFO: NgC/0953ejcurC0Sd0otzM0Q+BDPwYTOTxUp8VuTINnZun3a2UoO9PvFpU2YLk
	 s3xi74uaB0MTYgLNte9rXqOKeBHYdqexZsN6dsTXakPQvxUD3PQujXQXdWqHDMqNOSoDtnLgnWuz
	 7nkjpa15h9pnMdP3MD3X3UkqkekvQC7ker5WUT+OI7hA/3hNWOMQF/HibcsU4f0X8GEpv8YLw2jT
	 V4REhv5e6KN2/MBRQJV72qlGcSdqqNB/aj3im0vxlRo79huNJm/RyODANMCvwuApRs5DMOBPYLak
	 vmZYFul3i0fb9/ReZGaHBXXd3L4whNt8mSJxksldVlTk11WSnXDxY8jOTFKTOG5OTDwjPfuad62T
	 JOj07s24iFVf4uiZx5QVpt9iLf9s20Lall9O/3p8A2b432zDBDhgbaSbuGl/QFTRfZodzKDb6qSG
	 m0/+zbiI65ua1Ilb0enq8MVhUjMH8P63aoN1CA3Ckgt11JBU9I5oMqCeWOwC9ufZkIzVEPafGwGi
	 NP3K8vqB4RvOq3ga3htUn2HvKotFSw0KXZgiOHYzBYJXjvXPPxfY8FaAwXqg437cOApGf84dXWCZ
	 ZqbeVMm0JhAzSx+UTRht053Hz3cdof977Qc0SL4DmgDm/KYcsPGCxBkbPqdmExZFc26/5U8dBvx6
	 DlO65cC7Y8705qaI1e6E7OOOauifFcIh8svSCRL8WLw66Oc93foXevzoGj3md+vf20JlRuTNBC4W
	 Ydrm7GHcoNWocqC+OsiIuna8GFi6gogGl2mXSJp1cEs4LSxb4RN5NdWeYrk5P78W7gNpOaXo0rRX
	 2+dUvGidwYzPT8pzWz6g1KIwMorbRvpV8Sp65nI2M9LDAin/iZC7MXOIo5r8Hj4NZ1pHC5ySyL32
	 HA6kSQdmtO0DO3i0iYjphXMLtA7k7vPcBRxqABHesccnH8tOKr1N654eFcjES244w8/tyVKYn1dy
	 IulSsBZ7baWExumXOHoJpRwXTYXUBELIWOnZiNomm6NjAtviDdbCQPqtT+z2uUSXpTJ7nRABfD1i
	 mB5Z0xWHEhasHlkoL1hFPuuQ1Fqe27gGz9FPvers37ZG9fGgN8
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
Date: Fri, 24 Jan 2025 10:23:35 +0800
X-OQ-MSGID: <20250124022335.1749-1-alvalan9@foxmail.com>
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
index 67cabc40f1dc..73d7372afb43 100644
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


