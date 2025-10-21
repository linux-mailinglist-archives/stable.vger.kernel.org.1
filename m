Return-Path: <stable+bounces-188288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AFBBF4A01
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 07:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F21F3AF268
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 05:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DBA22B8B0;
	Tue, 21 Oct 2025 05:14:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1AC2556E;
	Tue, 21 Oct 2025 05:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761023670; cv=none; b=i8SeRD15E7EQ86VWufrgRMT9v5myYuSWKbTnr90udFTE5Amt3MLz/I1Na6KGBLN0WmD397RHn9XS4lIljpxpLcrmjXxs9s+TWBUrvNqczRippqYGEcl6yIRmxYtg0Jf6Q0a/lOEzRDTkbmA9XfnUMHc66bLWkrbZYw6hVlwx6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761023670; c=relaxed/simple;
	bh=xy8cNH6sTwXVBTkTDDbECNc1/pqnDa6gGjanwWWIMp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PsI28rkHVOBtP4trErTrzyanhhX/KIR3gVUd8c0b/fYeP+aDJryknKGhPp/XXxoBi7BV5uu5iHqGL+7nqVb2Lbavd78qJ4cwDUBWAwQGTj5tmIcXKHCWvdJ8CK1Lm0tRirN8c62GkNdzfYxF+4lcK38N4PDI5He7OfNaS0GtsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz4t1761023579t34c21be9
X-QQ-Originating-IP: qGMv6aoSEDb63nVxt9x1iPy8Vvy2daGnc5g4UZVP11M=
Received: from localhost.localdomain ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Oct 2025 13:12:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12081062612498682095
EX-QQ-RecipientCnt: 11
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vincent Bernat <vincent@bernat.ch>,
	stable@vger.kernel.org
Subject: [PATCH net] net: bonding: fix possible peer notify event loss or dup issue
Date: Tue, 21 Oct 2025 13:09:33 +0800
Message-Id: <20251021050933.46412-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NiFdmnmiW14nXvW8MnAcrigq1zelh5DavZX82X8a628gbZN4f6jWSmGv
	o5rd87U4P+Wi0/CUCoOUle3jVKoIbRMuFwUvWOCKNbZV/HhgP8sWYBhiNJ5FrqGtACcMo4M
	znQD4CPsTQ4YFD8F2vtJVYycEthaHl50kuUx3moRV6Bs132XhxRAZNxqxZDjIp43WX6L0ak
	Zhyro7yDbgZmogb1fxhLyS491Wqts+0ON+Wk7VJ3leCP3pke8bjk0ISIfotLrXgQ3OTPqeW
	oECu49Lu+y5VhghoZKPdVBsHgBfXq82BLq6+CFlOOc9biDjwFNGyEuwoHMn5IWEWhIEdw9P
	lmrWdJ1n0eBR7ob3W1FlU3sVLMsrOTclXAjeiJjWW7uESUCGsgdTBX22JoHW3jXzOrUgikF
	T5gA2sG6YZjxyt1Zy0krIZ3Sr8luSRgmXISX5+sGGIhO1yshMzg+5DSNFvJDUOrkolGrWc8
	FSNVdrJVAJ1eYs+fvYeL21WZ2hblUU0A9ymwiWQJNhRkd9oysCipf3NB344k/Ri/kJtSG4Q
	Z2y2VLGHBreoASfssTHITP3iejLmUeEhN1DSG4pk3UvlsjdpP1UPuwoRM1on01Kf9X42IiL
	oMJph4AL6yDBQrIeGGRoX035s1ghhEdiiaZWJGMUCLc0Z/wS1Dx/XxJN3KvH63gxeRunRaP
	GUv1hj/EmiEZB4RqsbnErpx0xE4EoT9TpVgPGwr2U5ftQJx2/bX9LDz8piZqAftm4qWllEX
	SzxWZL6tyoTwda8i6bVLS6LE3bWwMBNPc99AEYYuScjsVqwA9iQau5/LDy+XNtSS7nlcGvm
	0FeSWlaCJiL7rfgXXO5DGicx10GsmFBC1lqsjbuMyWLDBDxlPAlSFjOU+GG8M5WkdlJ13P6
	sWFPnfyUiilTxE4QCbWdsViCsipEJlhGfU803gpw1ojx+pYF3Def7tJ2PPjgSEvqnPfLiYH
	+6EsKr/39LQzc6iBosI4FOU7LXlcPdUD9W6YruVjF/k/ilBq7dPfaM9fnXWs0ncTx/6U=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

If the send_peer_notif counter and the peer event notify are not synchronized.
It may cause problems such as the loss or dup of peer notify event.

Before this patch:
- If should_notify_peers is true and the lock for send_peer_notif-- fails, peer
  event may be sent again in next mii_monitor loop, because should_notify_peers
  is still true.
- If should_notify_peers is true and the lock for send_peer_notif-- succeeded,
  but the lock for peer event fails, the peer event will be lost.

This patch locks the RTNL for send_peer_notif, events, and commit simultaneously.

Fixes: 07a4ddec3ce9 ("bonding: add an option to specify a delay between peer notifications")
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Vincent Bernat <vincent@bernat.ch>
Cc: <stable@vger.kernel.org>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>

---
 drivers/net/bonding/bond_main.c | 40 +++++++++++++++------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5791c3e39baa..52b7ac8ddfbc 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2971,7 +2971,7 @@ static void bond_mii_monitor(struct work_struct *work)
 {
 	struct bonding *bond = container_of(work, struct bonding,
 					    mii_work.work);
-	bool should_notify_peers = false;
+	bool should_notify_peers;
 	bool commit;
 	unsigned long delay;
 	struct slave *slave;
@@ -2983,30 +2983,33 @@ static void bond_mii_monitor(struct work_struct *work)
 		goto re_arm;
 
 	rcu_read_lock();
+
 	should_notify_peers = bond_should_notify_peers(bond);
 	commit = !!bond_miimon_inspect(bond);
-	if (bond->send_peer_notif) {
-		rcu_read_unlock();
-		if (rtnl_trylock()) {
-			bond->send_peer_notif--;
-			rtnl_unlock();
-		}
-	} else {
-		rcu_read_unlock();
-	}
 
-	if (commit) {
+	rcu_read_unlock();
+
+	if (commit || bond->send_peer_notif) {
 		/* Race avoidance with bond_close cancel of workqueue */
 		if (!rtnl_trylock()) {
 			delay = 1;
-			should_notify_peers = false;
 			goto re_arm;
 		}
 
-		bond_for_each_slave(bond, slave, iter) {
-			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
+		if (commit) {
+			bond_for_each_slave(bond, slave, iter) {
+				bond_commit_link_state(slave,
+						       BOND_SLAVE_NOTIFY_LATER);
+			}
+			bond_miimon_commit(bond);
+		}
+
+		if (bond->send_peer_notif) {
+			bond->send_peer_notif--;
+			if (should_notify_peers)
+				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
+							 bond->dev);
 		}
-		bond_miimon_commit(bond);
 
 		rtnl_unlock();	/* might sleep, hold no other locks */
 	}
@@ -3014,13 +3017,6 @@ static void bond_mii_monitor(struct work_struct *work)
 re_arm:
 	if (bond->params.miimon)
 		queue_delayed_work(bond->wq, &bond->mii_work, delay);
-
-	if (should_notify_peers) {
-		if (!rtnl_trylock())
-			return;
-		call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
-		rtnl_unlock();
-	}
 }
 
 static int bond_upper_dev_walk(struct net_device *upper,
-- 
2.34.1


