Return-Path: <stable+bounces-167243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A9BB22E1F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46308189F75E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE7B2FF145;
	Tue, 12 Aug 2025 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrsUf7/o"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F32FE58A
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016910; cv=none; b=OblXhVuhNGP5cMSDNUinRo6h7cM460VdVuXaxUQdCuvVOLKiMGZ7AgHBG4qSki5yMO/9M8B64J58f9pS6P9BN17esgjfXDrykolWB5L7UzhlhfFOd8uBaesccMYW1CvMH6mUQLPOjfD4cf65Xg1ENWdaayliVmvphvmg0/iXlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016910; c=relaxed/simple;
	bh=pW9Xlt0noymOxihDNZEZCxbxnTP1UNfb8ddqpI5D5NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxvy2nSX6pUoWaNhi58F92oGe98UGV77V15cHIYPt4zT3s+QWLVaLJzOtGKQucTDA5azcbrwjbLpHjg2D3QKN7Cw8eFVAVcMD81x9KOy0p2M284z1FwQP0eU4V31ALKLocryOLQakXIVEyqleuy4Mv4OsEap7yRTGrQ36sOnUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TrsUf7/o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755016907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OziBGSalyINd/c64SbiUncItpJslg2EaRjYL0FGUwU=;
	b=TrsUf7/o0TwaHGpvUNd3C6QHQCfxo3hzO+3jrUZKO19/mZi77hCc6Ow/czIUjhRGFsdL4d
	Kh/dklN4thHc42L1iSNxShdK7QQBhJVz2ChBI9TMExZ/GFGRF/qTFuJkjvbIkzaAhFA/hx
	bUyWdxK1ktfexZbQi30rjY6UCH+X/zg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-PC0_Shv5Py-r6ehNv5mIWw-1; Tue,
 12 Aug 2025 12:41:44 -0400
X-MC-Unique: PC0_Shv5Py-r6ehNv5mIWw-1
X-Mimecast-MFC-AGG-ID: PC0_Shv5Py-r6ehNv5mIWw_1755016902
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F0D119560B7;
	Tue, 12 Aug 2025 16:41:42 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.32.60])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66C9B195608F;
	Tue, 12 Aug 2025 16:41:37 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Lion Ackermann <nnamrec@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org,
	Ivan Vecera <ivecera@redhat.com>,
	Li Shuang <shuali@redhat.com>
Cc: stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net/sched: ets: use old 'nbands' while purging unused classes
Date: Tue, 12 Aug 2025 18:40:29 +0200
Message-ID: <7928ff6d17db47a2ae7cc205c44777b1f1950545.1755016081.git.dcaratti@redhat.com>
In-Reply-To: <cover.1755016081.git.dcaratti@redhat.com>
References: <cover.1755016081.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Shuang reported sch_ets test-case [1] crashing in ets_class_qlen_notify()
after recent changes from Lion [2]. The problem is: in ets_qdisc_change()
we purge unused DWRR queues; the value of 'q->nbands' is the new one, and
the cleanup should be done with the old one. The problem is here since my
first attempts to fix ets_qdisc_change(), but it surfaced again after the
recent qdisc len accounting fixes. Fix it purging idle DWRR queues before
assigning a new value of 'q->nbands', so that all purge operations find a
consistent configuration:

 - old 'q->nbands' because it's needed by ets_class_find()
 - old 'q->nstrict' because it's needed by ets_class_is_strict()

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 62 UID: 0 PID: 39457 Comm: tc Kdump: loaded Not tainted 6.12.0-116.el10.x86_64 #1 PREEMPT(voluntary)
 Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS 2.12.2 07/09/2021
 RIP: 0010:__list_del_entry_valid_or_report+0x4/0x80
 Code: ff 4c 39 c7 0f 84 39 19 8e ff b8 01 00 00 00 c3 cc cc cc cc 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <48> 8b 17 48 8b 4f 08 48 85 d2 0f 84 56 19 8e ff 48 85 c9 0f 84 ab
 RSP: 0018:ffffba186009f400 EFLAGS: 00010202
 RAX: 00000000000000d6 RBX: 0000000000000000 RCX: 0000000000000004
 RDX: ffff9f0fa29b69c0 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: ffffffffc12c2400 R08: 0000000000000008 R09: 0000000000000004
 R10: ffffffffffffffff R11: 0000000000000004 R12: 0000000000000000
 R13: ffff9f0f8cfe0000 R14: 0000000000100005 R15: 0000000000000000
 FS:  00007f2154f37480(0000) GS:ffff9f269c1c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 00000001530be001 CR4: 00000000007726f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ets_class_qlen_notify+0x65/0x90 [sch_ets]
  qdisc_tree_reduce_backlog+0x74/0x110
  ets_qdisc_change+0x630/0xa40 [sch_ets]
  __tc_modify_qdisc.constprop.0+0x216/0x7f0
  tc_modify_qdisc+0x7c/0x120
  rtnetlink_rcv_msg+0x145/0x3f0
  netlink_rcv_skb+0x53/0x100
  netlink_unicast+0x245/0x390
  netlink_sendmsg+0x21b/0x470
  ____sys_sendmsg+0x39d/0x3d0
  ___sys_sendmsg+0x9a/0xe0
  __sys_sendmsg+0x7a/0xd0
  do_syscall_64+0x7d/0x160
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f2155114084
 Code: 89 02 b8 ff ff ff ff eb bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 80 3d 25 f0 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89
 RSP: 002b:00007fff1fd7a988 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 0000560ec063e5e0 RCX: 00007f2155114084
 RDX: 0000000000000000 RSI: 00007fff1fd7a9f0 RDI: 0000000000000003
 RBP: 00007fff1fd7aa60 R08: 0000000000000010 R09: 000000000000003f
 R10: 0000560ee9b3a010 R11: 0000000000000202 R12: 00007fff1fd7aae0
 R13: 000000006891ccde R14: 0000560ec063e5e0 R15: 00007fff1fd7aad0
  </TASK>

 [1] https://lore.kernel.org/netdev/e08c7f4a6882f260011909a868311c6e9b54f3e4.1639153474.git.dcaratti@redhat.com/
 [2] https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com/

Cc: stable@vger.kernel.org
Fixes: 103406b38c60 ("net/sched: Always pass notifications when child class becomes empty")
Fixes: c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from the round-robin list")
Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
Reported-by: Li Shuang <shuali@redhat.com>
Closes: https://issues.redhat.com/browse/RHEL-108026
Reviewed-by: Petr Machata <petrm@nvidia.com>
Co-developed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/sched/sch_ets.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 037f764822b9..82635dd2cfa5 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -651,6 +651,12 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 
 	sch_tree_lock(sch);
 
+	for (i = nbands; i < oldbands; i++) {
+		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
+			list_del_init(&q->classes[i].alist);
+		qdisc_purge_queue(q->classes[i].qdisc);
+	}
+
 	WRITE_ONCE(q->nbands, nbands);
 	for (i = nstrict; i < q->nstrict; i++) {
 		if (q->classes[i].qdisc->q.qlen) {
@@ -658,11 +664,6 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 			q->classes[i].deficit = quanta[i];
 		}
 	}
-	for (i = q->nbands; i < oldbands; i++) {
-		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
-			list_del_init(&q->classes[i].alist);
-		qdisc_purge_queue(q->classes[i].qdisc);
-	}
 	WRITE_ONCE(q->nstrict, nstrict);
 	memcpy(q->prio2band, priomap, sizeof(priomap));
 
-- 
2.47.0


