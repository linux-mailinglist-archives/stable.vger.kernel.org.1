Return-Path: <stable+bounces-214497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCIuNQm+hGnG4wMAu9opvQ
	(envelope-from <stable+bounces-214497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:58:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D106F4D9A
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7333301CCE0
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F77423153;
	Thu,  5 Feb 2026 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyAvWgYx"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F43D3D15
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306879; cv=none; b=sN6VFG9JR/WmtNF1WMri+fRorfJklB4RubabKr8XjKn9ToK9IxhEb3MVmvxI0uQNmLuTdQSWNTLb4MTl+ouqS+e3jOYOEHsMPkWb+unWC2qhL8C5Vk7symXSCw6wiLMyZldAUIrdqsl+t8ZOPGx76gJHjR/aakwZx3DBa8B40ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306879; c=relaxed/simple;
	bh=XFEGS6YPAr2cAPFF7UHqKauKrnMV04eAqAL93LscOvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tGKI8seTX+f1ENO3Jt1TUc++a5THGF7Utft5xJLi4qMzhIIUSNKGvWCAtFHh5g5iOjT9+udFGSGIFaa7dSSP9kRhh7ODtHSWiJku13TvIf/MbjcRguxVtj+xFwOpw1o+LGHb1u6U+l2MrPQ7kePjaqMEpH5dwYmTJ5Z7+H7mh7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyAvWgYx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770306878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=unekZ9V6Ccuh1dPtLnAU4rfj+WzTBhAfwBkQdq/2gq4=;
	b=VyAvWgYxlkWJVoHVEgIZXmhmVNo48+jOyjpRcxlAurQujHE7EDwPV6S55zhQgHwXvhUFiJ
	mGfoRJ8Yg9ERys/Oxt9Dm6aWVOk8Xk8x2otzF08JEEXeOpiAYXlESF5hkY1wCQwugdsIlx
	gj5sOcu0AM7xN7mLSptS3kfOoAsBDCQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-E8Zlkf_XPQezgN2S-yAKbA-1; Thu,
 05 Feb 2026 10:54:35 -0500
X-MC-Unique: E8Zlkf_XPQezgN2S-yAKbA-1
X-Mimecast-MFC-AGG-ID: E8Zlkf_XPQezgN2S-yAKbA_1770306873
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FCC31956089;
	Thu,  5 Feb 2026 15:54:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 395ED19373D8;
	Thu,  5 Feb 2026 15:54:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	stable@vger.kernel.org,
	Jay Shin <jaeshin@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Waiman Long <longman@redhat.com>,
	coregee2000@gmail.com,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2] blk-cgroup: fix UAF in __blkcg_rstat_flush()
Date: Thu,  5 Feb 2026 23:54:23 +0800
Message-ID: <20260205155425.342084-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,redhat.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-214497-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.lei@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 5D106F4D9A
X-Rspamd-Action: no action

From: Michal Koutný <mkoutny@suse.com>

When multiple blkgs in the same blkcg are released concurrently,
a use-after-free can occur. The race happens when one blkg's
__blkcg_rstat_flush() removes another blkg's iostat entries via
llist_del_all(). The second blkg sees an empty list and proceeds
to free itself while the first is still iterating over its entries.

Move the flush from __blkg_release() (RCU callback) to blkg_release()
(before call_rcu). This ensures the RCU grace period waits for any
concurrent flush's rcu_read_lock() section to complete before freeing.

Cc: stable@vger.kernel.org
Cc: Jay Shin <jaeshin@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Fixes: 20cb1c2fb756 ("blk-cgroup: Flush stats before releasing blkcg_gq")
Reported-by: coregee2000@gmail.com
Closes: https://lore.kernel.org/linux-block/CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- take simpler approach from Michal Koutný 

 block/blk-cgroup.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3cffb68ba5d8..ec079c2c404e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -163,20 +163,10 @@ static void blkg_free(struct blkcg_gq *blkg)
 static void __blkg_release(struct rcu_head *rcu)
 {
 	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
-	struct blkcg *blkcg = blkg->blkcg;
-	int cpu;
 
 #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
 	WARN_ON(!bio_list_empty(&blkg->async_bios));
 #endif
-	/*
-	 * Flush all the non-empty percpu lockless lists before releasing
-	 * us, given these stat belongs to us.
-	 *
-	 * blkg_stat_lock is for serializing blkg stat update
-	 */
-	for_each_possible_cpu(cpu)
-		__blkcg_rstat_flush(blkcg, cpu);
 
 	/* release the blkcg and parent blkg refs this blkg has been holding */
 	css_put(&blkg->blkcg->css);
@@ -194,6 +184,17 @@ static void __blkg_release(struct rcu_head *rcu)
 static void blkg_release(struct percpu_ref *ref)
 {
 	struct blkcg_gq *blkg = container_of(ref, struct blkcg_gq, refcnt);
+	struct blkcg *blkcg = blkg->blkcg;
+	int cpu;
+
+	/*
+	 * Flush all the non-empty percpu lockless lists before releasing
+	 * us, given these stat belongs to us.
+	 *
+	 * blkg_stat_lock is for serializing blkg stat update
+	 */
+	for_each_possible_cpu(cpu)
+		__blkcg_rstat_flush(blkcg, cpu);
 
 	call_rcu(&blkg->rcu_head, __blkg_release);
 }
-- 
2.47.0


