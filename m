Return-Path: <stable+bounces-141285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD21AAB22E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F334188A9B5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E55367332;
	Tue,  6 May 2025 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLDfKSEI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1792D5CE7;
	Mon,  5 May 2025 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485684; cv=none; b=ivDTBNBWnrGkffTQeF55rLKrxSQ3hzEg2DmubAIFfPLbsBh8KfbkvcB43rq/jgan6g7+4BDOJ2TupnsLhDMq2OAZEe2kXEeUq7iQiajXqQ6Bxi8Jigo3sIxckkGfJOWhSmdivx8lVqLeGvk+RbMThxcK/SKDVOMu5kBsRyY7yzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485684; c=relaxed/simple;
	bh=GEmoE8ZMsXsanwoyXRNDMaRJS40Ti3n9tpU7IktHxQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOkA198UC2whOvFzlyjruDnjW5ETsoEP3iT3wvjSlaUu5aaf4CqxSTi8LAeUS118EFedSsSVlFij5k3b+nM+4yVvPwkrJrveS3Cys00AhBPUFqZ+UMnkU0dQA7yPQlEzCi9pRzPbDWQCpxDJ6adnqMY6MJBL79jIvGkm6ftzwu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLDfKSEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3963C4CEEE;
	Mon,  5 May 2025 22:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485683;
	bh=GEmoE8ZMsXsanwoyXRNDMaRJS40Ti3n9tpU7IktHxQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLDfKSEIAxJAJT72fOvUn3mYzV61edvImObcieIhmpVTai7a10saSCJ3jURcV/e+I
	 gvu9tLkkzfBfozN/87tkkMpysqVCh9cACEpC1RYdx0dtQzKUTR92akRMxcjTC1z7HK
	 mwLfdN+WQfDCu2JWcMXgJ0/fn5ETH7BuRGoyAz6+Y528l3+OEnzSoyYxmaEmkxxhDL
	 2l1FQtf7jXEXiG82ZB3nY5ctWfX9rc2a3MrU+g0FtpCTu/978zx4aHnodye247Ui8v
	 JE1kdvHp4IlHFN//sEEf60tucJZwMrdHrghQ27lJrlbqVYJkaRtlaIlrYVtBYvbdUK
	 8uUiWDLB08rBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	menglong8.dong@gmail.com,
	gnault@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 424/486] vxlan: Annotate FDB data races
Date: Mon,  5 May 2025 18:38:20 -0400
Message-Id: <20250505223922.2682012-424-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit f6205f8215f12a96518ac9469ff76294ae7bd612 ]

The 'used' and 'updated' fields in the FDB entry structure can be
accessed concurrently by multiple threads, leading to reports such as
[1]. Can be reproduced using [2].

Suppress these reports by annotating these accesses using
READ_ONCE() / WRITE_ONCE().

[1]
BUG: KCSAN: data-race in vxlan_xmit / vxlan_xmit

write to 0xffff942604d263a8 of 8 bytes by task 286 on cpu 0:
 vxlan_xmit+0xb29/0x2380
 dev_hard_start_xmit+0x84/0x2f0
 __dev_queue_xmit+0x45a/0x1650
 packet_xmit+0x100/0x150
 packet_sendmsg+0x2114/0x2ac0
 __sys_sendto+0x318/0x330
 __x64_sys_sendto+0x76/0x90
 x64_sys_call+0x14e8/0x1c00
 do_syscall_64+0x9e/0x1a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff942604d263a8 of 8 bytes by task 287 on cpu 2:
 vxlan_xmit+0xadf/0x2380
 dev_hard_start_xmit+0x84/0x2f0
 __dev_queue_xmit+0x45a/0x1650
 packet_xmit+0x100/0x150
 packet_sendmsg+0x2114/0x2ac0
 __sys_sendto+0x318/0x330
 __x64_sys_sendto+0x76/0x90
 x64_sys_call+0x14e8/0x1c00
 do_syscall_64+0x9e/0x1a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000fffbac6e -> 0x00000000fffbac6f

Reported by Kernel Concurrency Sanitizer on:
CPU: 2 UID: 0 PID: 287 Comm: mausezahn Not tainted 6.13.0-rc7-01544-gb4b270f11a02 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014

[2]
 #!/bin/bash

 set +H
 echo whitelist > /sys/kernel/debug/kcsan
 echo !vxlan_xmit > /sys/kernel/debug/kcsan

 ip link add name vx0 up type vxlan id 10010 dstport 4789 local 192.0.2.1
 bridge fdb add 00:11:22:33:44:55 dev vx0 self static dst 198.51.100.1
 taskset -c 0 mausezahn vx0 -a own -b 00:11:22:33:44:55 -c 0 -q &
 taskset -c 2 mausezahn vx0 -a own -b 00:11:22:33:44:55 -c 0 -q &

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20250204145549.1216254-2-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 01f66760e1328..474faccf75fd9 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -227,9 +227,9 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			be32_to_cpu(fdb->vni)))
 		goto nla_put_failure;
 
-	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
+	ci.ndm_used	 = jiffies_to_clock_t(now - READ_ONCE(fdb->used));
 	ci.ndm_confirmed = 0;
-	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
+	ci.ndm_updated	 = jiffies_to_clock_t(now - READ_ONCE(fdb->updated));
 	ci.ndm_refcnt	 = 0;
 
 	if (nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
@@ -434,8 +434,8 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	struct vxlan_fdb *f;
 
 	f = __vxlan_find_mac(vxlan, mac, vni);
-	if (f && f->used != jiffies)
-		f->used = jiffies;
+	if (f && READ_ONCE(f->used) != jiffies)
+		WRITE_ONCE(f->used, jiffies);
 
 	return f;
 }
@@ -1009,12 +1009,12 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	    !(f->flags & NTF_VXLAN_ADDED_BY_USER)) {
 		if (f->state != state) {
 			f->state = state;
-			f->updated = jiffies;
+			WRITE_ONCE(f->updated, jiffies);
 			notify = 1;
 		}
 		if (f->flags != fdb_flags) {
 			f->flags = fdb_flags;
-			f->updated = jiffies;
+			WRITE_ONCE(f->updated, jiffies);
 			notify = 1;
 		}
 	}
@@ -1048,7 +1048,7 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	}
 
 	if (ndm_flags & NTF_USE)
-		f->used = jiffies;
+		WRITE_ONCE(f->used, jiffies);
 
 	if (notify) {
 		if (rd == NULL)
@@ -1477,7 +1477,7 @@ static bool vxlan_snoop(struct net_device *dev,
 				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
 
 		rdst->remote_ip = *src_ip;
-		f->updated = jiffies;
+		WRITE_ONCE(f->updated, jiffies);
 		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
 	} else {
 		u32 hash_index = fdb_head_index(vxlan, src_mac, vni);
@@ -2825,7 +2825,7 @@ static void vxlan_cleanup(struct timer_list *t)
 			if (f->flags & NTF_EXT_LEARNED)
 				continue;
 
-			timeout = f->used + vxlan->cfg.age_interval * HZ;
+			timeout = READ_ONCE(f->used) + vxlan->cfg.age_interval * HZ;
 			if (time_before_eq(timeout, jiffies)) {
 				netdev_dbg(vxlan->dev,
 					   "garbage collect %pM\n",
-- 
2.39.5


