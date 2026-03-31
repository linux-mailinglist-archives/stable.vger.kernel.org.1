Return-Path: <stable+bounces-231345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNZuJpB0y2ksIAYAu9opvQ
	(envelope-from <stable+bounces-231345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:15:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCB5364EAE
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33219302EA50
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2FB36E476;
	Tue, 31 Mar 2026 07:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="LpO7alF6"
X-Original-To: stable@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10BC19049B;
	Tue, 31 Mar 2026 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941166; cv=none; b=X9k0jQGaWi8OA9+jxTQfwJlUvSLTrsUQWOqOcvrrsACDIuars7JXFc/cSI4dENw8oFa7X4cO1Sm+3fAI8mbfGA+C8q/OxZ9NRU/UJ+dsXJfhI6hV/9I5HfiGMcjGvnDeIgQBG8MgDnqsyu3WKawYZq95x9WSYiDDLeDExLpnmlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941166; c=relaxed/simple;
	bh=2D4WdNTfPcZiRKss3zeGyGmEM9m4XEU75L4+0XLw77w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IoroK8rhQYYKXJ1Fzm3uldw2ymGti3Qkn2owORnZ4ck70NVN7cD6KfKfUaSOldBHmvvLeYxCeESWceu0vjg475sN2zghGVbzJjM3ftEuV8sVks4SH7NcBvgYfdur9kDGwkIQODA/444q9f/6w3l2MZ2bLgFs1L85Uj4HMgDxalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=LpO7alF6; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=LpO7alF6D8hRGID1vONgJQxepW+F9VKh5ugbB6XsY38KsN/k+p6gkE8BmSbDcEhVZ793uXcEP0c4r
	 MyNGanb/ndEAe3G38if4nzFLH5fl6fqmE9MEw6VCZiQkg+bSNwI1OdD3iQlvYyE4qPamUakS48cP0x
	 8oDkDWbat3+ZccNc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from Ubuntu24 (unknown[2409:8A00:DD3:9760:EC02:B35:F13F:3469])
	by rmsmtp-lg-appmail-45-12076 (RichMail) with SMTP id 2f2c69cb73d6a26-00a34;
	Tue, 31 Mar 2026 15:12:31 +0800 (CST)
X-RM-TRANSID:2f2c69cb73d6a26-00a34
From: XiaoHua Wang <561399680@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Yin Fengwei <fengwei_yin@linux.alibaba.com>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	XiaoHua Wang <561399680@139.com>
Subject: [PATCH 6.12.y] net: add proper RCU protection to /proc/net/ptype
Date: Tue, 31 Mar 2026 15:12:24 +0800
Message-ID: <20260331071224.14601-1-561399680@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231345-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,linux.alibaba.com,huawei.com,kernel.org,139.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[561399680@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alibaba.com:email,ptype_all.next:url,139.com:email,139.com:mid,list.next:url]
X-Rspamd-Queue-Id: CCCB5364EAE
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
index fa6d3969734a..e29d43fe11fa 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -168,8 +168,14 @@ static const struct seq_operations softnet_seq_ops = {
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
@@ -179,12 +185,16 @@ static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
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
 	list_for_each_entry_rcu(pt, &net_hotdata.ptype_all, list) {
 		if (i == pos)
 			return pt;
@@ -210,6 +220,7 @@ static void *ptype_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
+	struct ptype_iter_state *iter = seq->private;
 	struct net_device *dev;
 	struct packet_type *pt;
 	struct list_head *nxt;
@@ -220,20 +231,21 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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
-		nxt = net_hotdata.ptype_all.next;
+		iter->dev = NULL;
+		nxt = READ_ONCE(net_hotdata.ptype_all.next);
 		goto ptype_all;
 	}
 
@@ -242,14 +254,14 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		if (nxt != &net_hotdata.ptype_all)
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
@@ -263,19 +275,24 @@ static void ptype_seq_stop(struct seq_file *seq, void *v)
 
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
@@ -299,7 +316,7 @@ static int __net_init dev_proc_net_init(struct net *net)
 			 &softnet_seq_ops))
 		goto out_dev;
 	if (!proc_create_net("ptype", 0444, net->proc_net, &ptype_seq_ops,
-			sizeof(struct seq_net_private)))
+			sizeof(struct ptype_iter_state)))
 		goto out_softnet;
 
 	if (wext_proc_init(net))
-- 
2.43.0



