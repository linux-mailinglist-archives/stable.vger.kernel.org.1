Return-Path: <stable+bounces-238062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJkFF11N32mFRQAAu9opvQ
	(envelope-from <stable+bounces-238062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:33:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B0C402055
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C184E300AD81
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13A43CF678;
	Wed, 15 Apr 2026 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="0RD/ZPbm"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A73D093A
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241767; cv=none; b=r+BkVri6OT5JHXgBhthoaEOKkXdjAnXy5EULG1pZKgt3pL57zfKeIUK20T+boir2cJRz5/tyAFvFPlOIr+SdZsw5tLnkzorB9tVwhK5PQucp6RPzplfiOuVymG5Gj8bASi4eLqgZ676xRSEmOcWCF7nHLeF90fzyNNTrPEgy89o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241767; c=relaxed/simple;
	bh=37ogXA36L+pEeDy+dCVgSwskKzpF/RHHEU4lHmrsmSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MHAs3DxrQfmPUHyncIn/JqGOew/pBk6j0M8hXVWLh642nW0/8Kt2Tj/EJMIoQXpiIEn12enHTyM/Aqr9KJ+kojeDvTHljx+dpnFQxhSVm17+5RAFi/GGA/eZSUJxWg43EaNaVTrYLBK8f9MPtEBqtMFoI3RZ8NvfKQxRvSupFzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=0RD/ZPbm; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=0RD/ZPbmsSBdqE/zjK5XOkJBdH6Tjp+3qLsWDpv9QTCooP01PWkK2CLdd7iGzzPXrlIAtOwdgv+EZ
	 7QAQ4QmONy1IydvZaoUFV3PphP6QINDSLDbjKRAyYw+qVSmK7xT0ljCgRKKTTZMoHNPJsc22FfPtWy
	 iUajVwOQafVC9zIs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-kernel-team (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-12-12001 (RichMail) with SMTP id 2ee169df4c4e4cb-024fc;
	Wed, 15 Apr 2026 16:29:11 +0800 (CST)
X-RM-TRANSID:2ee169df4c4e4cb-024fc
From: XiaoHua Wang <561399680@139.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Yin Fengwei <fengwei_yin@linux.alibaba.com>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	XiaoHua Wang <561399680@139.com>
Subject: [PATCH 6.1.y] net: add proper RCU protection to /proc/net/ptype
Date: Wed, 15 Apr 2026 16:28:46 +0800
Message-Id: <20260415082846.375601-1-561399680@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238062-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,linux.alibaba.com,huawei.com,kernel.org,139.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[561399680@139.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[139.com:-];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_SPAM(0.00)[0.785];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B5B0C402055
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f613e8b4afea0cd17c7168e8b00e25bc8d33175d ]

Yin Fengwei reported an RCU stall in ptype_seq_show() and provided
a patch.

Real issue is that ptype_seq_next() and ptype_seq_show() violate
RCU rules.

ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
to get device name without any barrier.

At the same time, concurrent writers can remove a packet_type structure
(which is correctly freed after an RCU grace period) and clear pt->dev
without an RCU grace period.

Define ptype_iter_state to carry a dev pointer along seq_net_private:

struct ptype_iter_state {
	struct seq_net_private	p;
	struct net_device	*dev; // added in this patch
};

We need to record the device pointer in ptype_get_idx() and
ptype_seq_next() so that ptype_seq_show() is safe against
concurrent pt->dev changes.

We also need to add full RCU protection in ptype_seq_next().
(Missing READ_ONCE() when reading list.next values)

Many thanks to Dong Chenchen for providing a repro.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 1d10f8a1f40b ("net-procfs: show net devices bound packet types")
Fixes: c353e8983e0d ("net: introduce per netns packet chains")
Reported-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
Reported-by: Dong Chenchen <dongchenchen2@huawei.com>
Closes: https://lore.kernel.org/netdev/CANn89iKRRKPnWjJmb-_3a=sq+9h6DvTQM4DBZHT5ZRGPMzQaiA@mail.gmail.com/T/#m7b80b9fc9b9267f90e0b7aad557595f686f9c50d

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Tested-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
Link: https://patch.msgid.link/20260202205217.2881198-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Some adjustments have been made. ]
Signed-off-by: XiaoHua Wang <561399680@139.com>
---
 net/core/net-procfs.c | 49 +++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 1ec23bf8b05c..2be3c1f6949b 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -192,8 +192,14 @@ static const struct seq_operations softnet_seq_ops = {
 	.show  = softnet_seq_show,
 };
 
+struct ptype_iter_state {
+	struct seq_net_private	p;
+	struct net_device	*dev;
+};
+
 static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
 {
+	struct ptype_iter_state *iter = seq->private;
 	struct list_head *ptype_list = NULL;
 	struct packet_type *pt = NULL;
 	struct net_device *dev;
@@ -203,12 +209,16 @@ static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
 	for_each_netdev_rcu(seq_file_net(seq), dev) {
 		ptype_list = &dev->ptype_all;
 		list_for_each_entry_rcu(pt, ptype_list, list) {
-			if (i == pos)
+			if (i == pos) {
+				iter->dev = dev;
 				return pt;
+			}
 			++i;
 		}
 	}
 
+	iter->dev = NULL;
+
 	list_for_each_entry_rcu(pt, &ptype_all, list) {
 		if (i == pos)
 			return pt;
@@ -234,6 +244,7 @@ static void *ptype_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
+	struct ptype_iter_state *iter = seq->private;
 	struct net_device *dev;
 	struct packet_type *pt;
 	struct list_head *nxt;
@@ -244,20 +255,21 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		return ptype_get_idx(seq, 0);
 
 	pt = v;
-	nxt = pt->list.next;
-	if (pt->dev) {
-		if (nxt != &pt->dev->ptype_all)
+	nxt = READ_ONCE(pt->list.next);
+	dev = iter->dev;
+	if (dev) {
+		if (nxt != &dev->ptype_all)
 			goto found;
 
-		dev = pt->dev;
 		for_each_netdev_continue_rcu(seq_file_net(seq), dev) {
-			if (!list_empty(&dev->ptype_all)) {
-				nxt = dev->ptype_all.next;
+			nxt = READ_ONCE(dev->ptype_all.next);
+			if (nxt != &dev->ptype_all) {
+				iter->dev = dev;
 				goto found;
 			}
 		}
-
-		nxt = ptype_all.next;
+		iter->dev = NULL;
+		nxt = READ_ONCE(ptype_all.next);
 		goto ptype_all;
 	}
 
@@ -266,14 +278,14 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		if (nxt != &ptype_all)
 			goto found;
 		hash = 0;
-		nxt = ptype_base[0].next;
+		nxt = READ_ONCE(ptype_base[0].next);
 	} else
 		hash = ntohs(pt->type) & PTYPE_HASH_MASK;
 
 	while (nxt == &ptype_base[hash]) {
 		if (++hash >= PTYPE_HASH_SIZE)
 			return NULL;
-		nxt = ptype_base[hash].next;
+		nxt = READ_ONCE(ptype_base[hash].next);
 	}
 found:
 	return list_entry(nxt, struct packet_type, list);
@@ -287,19 +299,24 @@ static void ptype_seq_stop(struct seq_file *seq, void *v)
 
 static int ptype_seq_show(struct seq_file *seq, void *v)
 {
+	struct ptype_iter_state *iter = seq->private;
 	struct packet_type *pt = v;
+	struct net_device *dev;
 
-	if (v == SEQ_START_TOKEN)
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "Type Device      Function\n");
-	else if ((!pt->af_packet_net || net_eq(pt->af_packet_net, seq_file_net(seq))) &&
-		 (!pt->dev || net_eq(dev_net(pt->dev), seq_file_net(seq)))) {
+		return 0;
+	}
+	dev = iter->dev;
+	if ((!pt->af_packet_net || net_eq(pt->af_packet_net, seq_file_net(seq))) &&
+		 (!dev || net_eq(dev_net(dev), seq_file_net(seq)))) {
 		if (pt->type == htons(ETH_P_ALL))
 			seq_puts(seq, "ALL ");
 		else
 			seq_printf(seq, "%04x", ntohs(pt->type));
 
 		seq_printf(seq, " %-8s %ps\n",
-			   pt->dev ? pt->dev->name : "", pt->func);
+			   dev ? dev->name : "", pt->func);
 	}
 
 	return 0;
@@ -323,7 +340,7 @@ static int __net_init dev_proc_net_init(struct net *net)
 			 &softnet_seq_ops))
 		goto out_dev;
 	if (!proc_create_net("ptype", 0444, net->proc_net, &ptype_seq_ops,
-			sizeof(struct seq_net_private)))
+			sizeof(struct ptype_iter_state)))
 		goto out_softnet;
 
 	if (wext_proc_init(net))
-- 
2.43.0



