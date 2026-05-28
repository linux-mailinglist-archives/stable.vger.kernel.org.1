Return-Path: <stable+bounces-254701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEmnHzqpF2qhMQgAu9opvQ
	(envelope-from <stable+bounces-254701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 04:32:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A8A5EBD08
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 04:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06CCE30B14BF
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 02:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A3E2F745C;
	Thu, 28 May 2026 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HPn8DkKz"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA232F547F;
	Thu, 28 May 2026 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935292; cv=none; b=XerZIHVEUV0fawLu1A22HcfkHlmY87Llt0s4WeJwtL2mdDNzyDPX1OFM/1t8C1Tc2M9n2HnudUiWlE8KpmojJzI26AofsZRrcl0/uYG4iIB15Qj8nqC74OdOzyK10l95TBRkVjrwqgo4v+wKy5Swj8pcP7mMA0+HMxy/I9a3obg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935292; c=relaxed/simple;
	bh=+sI5oBeiA711cTjYazO87vWojX8RwbWyWB48rf5prT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m8LT/nfSLH0aOS/4necsIl+DOIrOWbyqI/Ip6X1wiPwilA8icTlwrL0mrEv6ovXJyF8T50+thqoJYSE5WvP9Bl/+xL4fqzINWz+2t0rkhGQ7deRqrsHv/hZ8YhzBswqiGQroXpV5QhbX0TWHYNbdzVAxQb7b00xk2h/GqGcKtYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HPn8DkKz; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tt
	pY4O/HbToeiRyFQMbvoBRJhNWoVXKYO8MSM4OeT2Y=; b=HPn8DkKzzf2lteZECv
	lYLgNIsSnJuWrdi8V5qM0sW5eOrMCD0k/isPj0eZF/wclzKHC7X98YGtYGxAwyPq
	9cXyTwIr4S52b6eo2a1rYm2CzaesQUyybY2Wb5RIiqtxAiEEfwVmCBg6XBGkU0VO
	YugbOecoQMcgheG/u8zBWgHMs=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCXd1P6pxdqPtEHAA--.1305S2;
	Thu, 28 May 2026 10:27:07 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Manas <ghandatmanas@gmail.com>,
	Rakshit Awasthi <rakshitawasthi17@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Jarek Poplawski <jarkao2@gmail.com>,
	Robert Garcia <rob_garcia@163.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] net/sched: sch_red: Replace direct dequeue call with peek and qdisc_dequeue_peeked
Date: Thu, 28 May 2026 10:27:06 +0800
Message-Id: <20260528022706.2651270-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXd1P6pxdqPtEHAA--.1305S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWrJw13Kr15XFW7Cw1rJFb_yoWrAr13pr
	W3tr4DGFW0qr4UJF4UXF18try5CFsxCFn8X3yxWr1xJFWUuF1Yqr15Jw42qF95GrWUAwn3
	tr1DXw10qr1q9aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piY0PDUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5h2J9GoXp-1QOwAA3K
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254701-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,resnulli.us,davemloft.net,163.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 08A8A5EBD08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jamal Hadi Salim <jhs@mojatatu.com>

[ Upstream commit 458d5615272d3de535748342eb68ca492343048c ]

When red qdisc has children (eg qfq qdisc) whose peek() callback is
qdisc_peek_dequeued(), we could get a kernel panic. When the parent of such
qdiscs (eg illustrated in patch #3 as tbf) wants to retrieve an skb from
its child (red in this case), it will do the following:
 1a. do a peek() - and when sensing there's an skb the child can offer, then
     - the child in this case(red) calls its child's (qfq) peek.
        qfq does the right thing and will return the gso_skb queue packet.
        Note: if there wasnt a gso_skb entry then qfq will store it there.
 1b. invoke a dequeue() on the child (red). And herein lies the problem.
     - red will call the child's dequeue() which will essentially just
       try to grab something of qfq's queue.

[   78.667668][  T363] KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
[   78.667927][  T363] CPU: 1 UID: 0 PID: 363 Comm: ping Not tainted 7.1.0-rc1-00033-g46f74a3f7d57-dirty #790 PREEMPT(full)
[   78.668263][  T363] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   78.668486][  T363] RIP: 0010:qfq_dequeue+0x446/0xc90 [sch_qfq]
[   78.668718][  T363] Code: 54 c0 e8 dd 90 00 f1 48 c7 c7 e0 03 54 c0 48 89 de e8 ce 90 00 f1 48 8d 7b 48 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 <80> 3c 02 00 74 05 e8 ef a1 e1 f1 48 8b 7b 48 48 8d 54 24 58 48 8d
[   78.669312][  T363] RSP: 0018:ffff88810de573e0 EFLAGS: 00010216
[   78.669533][  T363] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   78.669790][  T363] RDX: 0000000000000009 RSI: 0000000000000004 RDI: 0000000000000048
[   78.670044][  T363] RBP: ffff888110dc4000 R08: ffffffffb1b0885a R09: fffffbfff6ba9078
[   78.670297][  T363] R10: 0000000000000003 R11: ffff888110e31c80 R12: 0000001880000000
[   78.670560][  T363] R13: ffff888110dc4150 R14: ffff888110dc42b8 R15: 0000000000000200
[   78.670814][  T363] FS:  00007f66a8f09c40(0000) GS:ffff888163428000(0000) knlGS:0000000000000000
[   78.671110][  T363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.671324][  T363] CR2: 000055db4c6a30a8 CR3: 000000010da67000 CR4: 0000000000750ef0
[   78.671585][  T363] PKRU: 55555554
[   78.671713][  T363] Call Trace:
[   78.671843][  T363]  <TASK>
[   78.671936][  T363]  ? __pfx_qfq_dequeue+0x10/0x10 [sch_qfq]
[   78.672148][  T363]  ? __pfx__printk+0x10/0x10
[   78.672322][  T363]  ? srso_alias_return_thunk+0x5/0xfbef5
[   78.672496][  T363]  ? lockdep_hardirqs_on_prepare+0xa8/0x1a0
[   78.672706][  T363]  ? srso_alias_return_thunk+0x5/0xfbef5
[   78.672875][  T363]  ? trace_hardirqs_on+0x19/0x1a0
[   78.673047][  T363]  red_dequeue+0x65/0x270 [sch_red]
[   78.673217][  T363]  ? srso_alias_return_thunk+0x5/0xfbef5
[   78.673385][  T363]  tbf_dequeue.cold+0xb0/0x70c [sch_tbf]
[   78.673566][  T363]  __qdisc_run+0x169/0x1900

The right thing to do in #1b is to grab the skb off gso_skb queue.
This patchset fixes that issue by changing #1b to use qdisc_dequeue_peeked()
method instead.

Fixes: 77be155cba4e ("pkt_sched: Add peek emulation for non-work-conserving qdiscs.")
Reported-by: Manas <ghandatmanas@gmail.com>
Reported-by: Rakshit Awasthi <rakshitawasthi17@gmail.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260430152957.194015-2-jhs@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 net/sched/sch_red.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 1b69b7b90d85..063431a5ae1d 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -153,7 +153,7 @@ static struct sk_buff *red_dequeue(struct Qdisc *sch)
 	struct red_sched_data *q = qdisc_priv(sch);
 	struct Qdisc *child = q->qdisc;
 
-	skb = child->dequeue(child);
+	skb = qdisc_dequeue_peeked(child);
 	if (skb) {
 		qdisc_bstats_update(sch, skb);
 		qdisc_qstats_backlog_dec(sch, skb);
-- 
2.34.1


