Return-Path: <stable+bounces-192228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46938C2D256
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 17:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1163B6162
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDA3316196;
	Mon,  3 Nov 2025 16:17:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A66286D40
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186666; cv=none; b=RL1122vYB5C9t3sm0QWyW5k2RXkj0vzEdADh/IUF+EyGIby23m/piDqSnaNmdv6ReHDP9C3zXJRmELVz+7nx9hdsN/KRFp0gMeu1w5F3VkKWXrcqRpqQxuu6cUubxQF0UNhqSiyaHdvgFTY90yLkWvKtR7rXc01HnC2dtffD88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186666; c=relaxed/simple;
	bh=r2rySTaYxjQXHz7M6uOXLZqDQeXeQ4NfFm8VycxDyQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tPvtX4SLKcj2a/t1IZg9691yj1V1sQjC8DJeLy0tPKOBCZlBsLNFfjkDFf5uT9o47yNVbPzdzf3QLgUBCTqcrSyj3cfUlzUFYcYtbf9BcM1F3TIzYpTh/HbmKt297svvvtMLEly7DHs7Y2hbH08hLiAENDVaVFVEe+8A864AFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id D8D322333B;
	Mon,  3 Nov 2025 19:17:40 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10/5.15] vxlan: Fix NPD when refreshing an FDB entry with a nexthop object
Date: Mon,  3 Nov 2025 19:17:40 +0300
Message-Id: <20251103161740.488314-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

commit 6ead38147ebb813f08be6ea8ef547a0e4c09559a upstream.

VXLAN FDB entries can point to either a remote destination or an FDB
nexthop group. The latter is usually used in EVPN deployments where
learning is disabled.

However, when learning is enabled, an incoming packet might try to
refresh an FDB entry that points to an FDB nexthop group and therefore
does not have a remote. Such packets should be dropped, but they are
only dropped after dereferencing the non-existent remote, resulting in a
NPD [1] which can be reproduced using [2].

Fix by dropping such packets earlier. Remove the misleading comment from
first_remote_rcu().

[1]
BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
CPU: 13 UID: 0 PID: 361 Comm: mausezahn Not tainted 6.17.0-rc1-virtme-g9f6b606b6b37 #1 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
RIP: 0010:vxlan_snoop+0x98/0x1e0
[...]
Call Trace:
 <TASK>
 vxlan_encap_bypass+0x209/0x240
 encap_bypass_if_local+0xb1/0x100
 vxlan_xmit_one+0x1375/0x17e0
 vxlan_xmit+0x6b4/0x15f0
 dev_hard_start_xmit+0x5d/0x1c0
 __dev_queue_xmit+0x246/0xfd0
 packet_sendmsg+0x113a/0x1850
 __sock_sendmsg+0x38/0x70
 __sys_sendto+0x126/0x180
 __x64_sys_sendto+0x24/0x30
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

[2]
 #!/bin/bash

 ip address add 192.0.2.1/32 dev lo
 ip address add 192.0.2.2/32 dev lo

 ip nexthop add id 1 via 192.0.2.3 fdb
 ip nexthop add id 10 group 1 fdb

 ip link add name vx0 up type vxlan id 10010 local 192.0.2.1 dstport 12345 localbypass
 ip link add name vx1 up type vxlan id 10020 local 192.0.2.2 dstport 54321 learning

 bridge fdb add 00:11:22:33:44:55 dev vx0 self static dst 192.0.2.2 port 54321 vni 10020
 bridge fdb add 00:aa:bb:cc:dd:ee dev vx1 self static nhid 10

 mausezahn vx0 -a 00:aa:bb:cc:dd:ee -b 00:11:22:33:44:55 -c 1 -q

Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Reported-by: Marlin Cremers <mcremers@cloudbear.nl>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20250901065035.159644-2-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ kovalev: bp to fix CVE-2025-39851 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/net/vxlan/vxlan_core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 5a7008136100..8872cb7a2dbb 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -174,9 +174,7 @@ static inline struct hlist_head *vs_head(struct net *net, __be16 port)
 	return &vn->sock_list[hash_32(ntohs(port), PORT_HASH_BITS)];
 }
 
-/* First remote destination for a forwarding entry.
- * Guaranteed to be non-NULL because remotes are never deleted.
- */
+/* First remote destination for a forwarding entry. */
 static inline struct vxlan_rdst *first_remote_rcu(struct vxlan_fdb *fdb)
 {
 	if (rcu_access_pointer(fdb->nh))
@@ -1507,6 +1505,10 @@ static bool vxlan_snoop(struct net_device *dev,
 	if (likely(f)) {
 		struct vxlan_rdst *rdst = first_remote_rcu(f);
 
+		/* Don't override an fdb with nexthop with a learnt entry */
+		if (rcu_access_pointer(f->nh))
+			return true;
+
 		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
 			   rdst->remote_ifindex == ifindex))
 			return false;
@@ -1515,10 +1517,6 @@ static bool vxlan_snoop(struct net_device *dev,
 		if (f->state & (NUD_PERMANENT | NUD_NOARP))
 			return true;
 
-		/* Don't override an fdb with nexthop with a learnt entry */
-		if (rcu_access_pointer(f->nh))
-			return true;
-
 		if (net_ratelimit())
 			netdev_info(dev,
 				    "%pM migrated from %pIS to %pIS\n",
-- 
2.50.1


