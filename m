Return-Path: <stable+bounces-273103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TSAbBW5UUGpnwwIAu9opvQ
	(envelope-from <stable+bounces-273103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 04:09:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F39F73697F
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 04:09:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=fLjnQk1n;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273103-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273103-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B14E830297B7
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 02:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA25C22D4E9;
	Fri, 10 Jul 2026 02:09:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF484499A9;
	Fri, 10 Jul 2026 02:09:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649384; cv=none; b=ZoXmiv3qbFd2/OTwRZCzYpIzcEnOPFnESyNrKxYyXyaxQGtFGV8sS893vh08Lgbx0Yjo535xrMKofe8z3QGviTkJKVd2itK+BayG3xlmrhODh//cRhtScgoRgiEwyhumauzf6ief+7+IkWuv10XIC/stGXmam5mHopeaHVRIqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649384; c=relaxed/simple;
	bh=BBBFDkp9Gq6Jq4Fpeo/cZyD1Jn688V2OALpnoJ9HQGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utJcaA4I4ytfMVgpjRoRGGQeREuxIf6Ar0Rfa6lFpt4IeJrv1stODV2X1omLpi1ptPpKLdPKopAhylbvP83JIDYsCCzOE3iDMklWZ/0OdlidZeAPZfGZ451pUrlOrMkFsSGg4CGFvJ4fQyCiS2uyc1bLMK9yJY+cmzTQ8dbnISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fLjnQk1n; arc=none smtp.client-ip=115.124.30.111
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783649373; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4sPb2w2Kp8Vex0lFa0KYOZ0Mh/KcMKyi6fG7aRgEeLA=;
	b=fLjnQk1ngjqbUpq/81ARTvAsePs8G1s8fhXDq4ScLniiM/euP7ELi5EQ6RraqNDPyDLmd/iaGxZBbpEQM+JCw1UwCsGV5WNkJPlGCB+nfvwmhQbLMxvp08RxcOop0MEmONY70wy37eeZ80dFf5Zp8UbxvKwkLLf5LpddxMQdDcQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X6mBlmQ_1783649372;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X6mBlmQ_1783649372 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Jul 2026 10:09:32 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com,
	stable@vger.kernel.org
Cc: kasong@tencent.com,
	baohua@kernel.org,
	machao26@xiaomi.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.18.y v2] mm: shmem: fix potential livelock issue for shmem direct swapin
Date: Fri, 10 Jul 2026 10:09:22 +0800
Message-ID: <c0b158fe3f25709543b48a9d81b1933120a9e2ba.1783648317.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:hughd@google.com,m:stable@vger.kernel.org,m:kasong@tencent.com,m:baohua@kernel.org,m:machao26@xiaomi.com,m:baolin.wang@linux.alibaba.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273103-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xiaomi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F39F73697F

When skipping swapcache for synchronous IO swap devices, swapcache_prepare()
is used to prevent parallel swapin from proceeding with the swap cache flag.
However, on PREEMPT kernels this can lead to a livelock, as reported by Chao[1]:

Thread A starts direct swapin of a shmem folio and calls swapcache_prepare()
to set SWAP_HAS_CACHE. It may then be preempted inside workingset_refault().
Meanwhile, a higher priority thread B also attempts direct swapin of the same
shmem swap entry. Since swapcache_prepare() already marks the entry, thread B
repeatedly gets -EEXIST and busy-loops waiting for thread A to finish. But as
thread B runs at higher priority, thread A cannot preempt it, resulting in
starvation and a livelock.

Fix it by yielding the CPU with schedule_timeout_uninterruptible(1) when
swapcache_prepare() fails, following the same approach used in commit
029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead") and
commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache").

However, commit 01626a1823 ("mm: avoid unconditional one-tick sleep when
swapcache_prepare fails") found that the unconditional one-tick sleep can
cause UI stuttering on latency-sensitive Android devices. So we can follow
the same approach by adding a waitqueue to wake up tasks when needed,
instead of always sleeping for a full tick.

Note that mainline does not have this potential issue, which has already been
resolved by Kairui's swap refactoring work[2].

[1] https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.com/
[2] https://lore.kernel.org/all/20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com/
Fixes: 1dd44c0af4fa ("mm: shmem: skip swapcache for swapin of synchronous swap device")
Reported-by: Ma Chao <machao26@xiaomi.com>
Closes: https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.com/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - Add a waitqueue to wake up tasks when needed.

Hi Chao, could you try this patch to check if fix your issue? Thanks.
---
 mm/shmem.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 94c5b0d78ac3..3c329b794ae4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2005,11 +2005,14 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 	return ERR_PTR(error);
 }
 
+static DECLARE_WAIT_QUEUE_HEAD(shmem_swapcache_wq);
+
 static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 		struct vm_area_struct *vma, pgoff_t index,
 		swp_entry_t entry, int order, gfp_t gfp)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	DECLARE_WAITQUEUE(wait, current);
 	int nr_pages = 1 << order;
 	struct folio *new;
 	gfp_t alloc_gfp;
@@ -2066,6 +2069,10 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	if (swapcache_prepare(entry, nr_pages)) {
 		folio_put(new);
 		new = ERR_PTR(-EEXIST);
+		/* Relax a bit to prevent rapid repeated page faults */
+		add_wait_queue(&shmem_swapcache_wq, &wait);
+		schedule_timeout_uninterruptible(1);
+		remove_wait_queue(&shmem_swapcache_wq, &wait);
 		/* Try smaller folio to avoid cache conflict */
 		goto fallback;
 	}
@@ -2423,6 +2430,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (skip_swapcache) {
 		folio->swap.val = 0;
 		swapcache_clear(si, swap, nr_pages);
+		if (waitqueue_active(&shmem_swapcache_wq))
+			wake_up(&shmem_swapcache_wq);
 	} else {
 		swap_cache_del_folio(folio);
 	}
@@ -2442,8 +2451,11 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (folio)
 		folio_unlock(folio);
 failed_nolock:
-	if (skip_swapcache)
+	if (skip_swapcache) {
 		swapcache_clear(si, folio->swap, folio_nr_pages(folio));
+		if (waitqueue_active(&shmem_swapcache_wq))
+			wake_up(&shmem_swapcache_wq);
+	}
 	if (folio)
 		folio_put(folio);
 	put_swap_device(si);
-- 
2.47.3


