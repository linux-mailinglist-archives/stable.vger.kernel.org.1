Return-Path: <stable+bounces-230583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKo/I50IxmkZFgUAu9opvQ
	(envelope-from <stable+bounces-230583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:33:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D433F1E7
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 723973030BA1
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 04:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCF4214A8B;
	Fri, 27 Mar 2026 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sDjeQMYI"
X-Original-To: stable@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F0346FD0
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774586008; cv=none; b=sbbSWPWMNENc3GdspvswI0h2VWXhdL6iXno03WWfPDQx7VNIB31QlrP4yjk+macn0HDONaYikLfN5baiFRxsIgv7K6hQ2dvXdxYxW3PCiqxoEbP5a5XsfhOtSMgR6DEh7BQTMl9AIA62lo2pKEVAl91TuQNCfEHkmqk593ABCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774586008; c=relaxed/simple;
	bh=irMkOVU2rpyXt8YQlXbTLiQYR3DhJQNncNprGwQmgoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QE/mb8T7fglTH5/25jZUOYmPXjNaxzdSi7uzEOo8VLUDbBm/l4leb+kHXSghqbh2xXXoigduP8V9iMCtW9d3vQU02Bm1/3YVRGGJzbJKPQ+0j1KOiBAYs0XUos7rOsenvUFStN0lnBsCk7mO9GAiI4J5XKyQvkxrM4cZ6uSi8LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sDjeQMYI; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774585999; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qD5WGzY9SirQ9xlNJVoQqH4Rcm41JAwbu6EYRLwDR08=;
	b=sDjeQMYIbbZB7WPK/gGwcM1ChKfsPGawZTaC0SsBAXKkW1j7LTrLc6ZWVJQZkKm58ij/nUDkWMwxRDpoQd9spJFaQ2x4zuHBFmIpg95TPFrEP645+bO97BD5CcLxb1J9Lsi2qkdlrXYMqqp1Q+SJf9Fy4qgnWgzNW4aBfdHYnzE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X.mwfTV_1774585993;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.mwfTV_1774585993 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Mar 2026 12:33:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com,
	syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com,
	syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com,
	Alexey Panov <apanov@astralinux.ru>
Subject: [PATCH 6.1.y 1/2] erofs: handle overlapped pclusters out of crafted images properly
Date: Fri, 27 Mar 2026 12:33:12 +0800
Message-ID: <20260327043312.1118901-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230583-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,4fc98ed414ae63d1ada2,de04e06b28cfecf2281c,c8c8238b394be4a1087d];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 841D433F1E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 9e2f9d34dd12e6e5b244ec488bcebd0c2d566c50 upstream.

syzbot reported a task hang issue due to a deadlock case where it is
waiting for the folio lock of a cached folio that will be used for
cache I/Os.

After looking into the crafted fuzzed image, I found it's formed with
several overlapped big pclusters as below:

 Ext:   logical offset   |  length :     physical offset    |  length
   0:        0..   16384 |   16384 :     151552..    167936 |   16384
   1:    16384..   32768 |   16384 :     155648..    172032 |   16384
   2:    32768..   49152 |   16384 :  537223168.. 537239552 |   16384
...

Here, extent 0/1 are physically overlapped although it's entirely
_impossible_ for normal filesystem images generated by mkfs.

First, managed folios containing compressed data will be marked as
up-to-date and then unlocked immediately (unlike in-place folios) when
compressed I/Os are complete.  If physical blocks are not submitted in
the incremental order, there should be separate BIOs to avoid dependency
issues.  However, the current code mis-arranges z_erofs_fill_bio_vec()
and BIO submission which causes unexpected BIO waits.

Second, managed folios will be connected to their own pclusters for
efficient inter-queries.  However, this is somewhat hard to implement
easily if overlapped big pclusters exist.  Again, these only appear in
fuzzed images so let's simply fall back to temporary short-lived pages
for correctness.

Additionally, it justifies that referenced managed folios cannot be
truncated for now and reverts part of commit 2080ca1ed3e4 ("erofs: tidy
up `struct z_erofs_bvec`") for simplicity although it shouldn't be any
difference.

[Alexey: This patch follows linux 6.6.y conflict resolution changes of
struct folio -> struct page]

Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
Reported-by: syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com
Reported-by: syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
Tested-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/0000000000002fda01061e334873@google.com
Fixes: 8e6c8fa9f2e9 ("erofs: enable big pcluster feature")
Link: https://lore.kernel.org/r/20240910070847.3356592-1-hsiangkao@linux.alibaba.com
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
Link: https://lore.kernel.org/r/20250304110558.8315-2-apanov@astralinux.ru
Link: https://lore.kernel.org/r/20250304110558.8315-1-apanov@astralinux.ru
[ Gao Xiang: re-address the previous Alexey's backport. ]
CVE: CVE-2024-47736
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 60 ++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5e6580217318..aa311aed0dd8 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1328,14 +1328,14 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 		goto out;
 
 	lock_page(page);
-
-	/* only true if page reclaim goes wrong, should never happen */
-	DBG_BUGON(justfound && PagePrivate(page));
-
-	/* the page is still in manage cache */
-	if (page->mapping == mc) {
+	if (likely(page->mapping == mc)) {
 		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
+		oldpage = page;
 
+		/*
+		 * The cached folio is still in managed cache but without
+		 * a valid `->private` pcluster hint.  Let's reconnect them.
+		 */
 		if (!PagePrivate(page)) {
 			/*
 			 * impossible to be !PagePrivate(page) for
@@ -1349,22 +1349,24 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 			SetPagePrivate(page);
 		}
 
-		/* no need to submit io if it is already up-to-date */
-		if (PageUptodate(page)) {
-			unlock_page(page);
-			page = NULL;
+		if (likely(page->private == (unsigned long)pcl)) {
+			/* don't submit cache I/Os again if already uptodate */
+			if (PageUptodate(page)) {
+				unlock_page(page);
+				page = NULL;
+
+			}
+			goto out;
 		}
-		goto out;
+		/*
+		 * Already linked with another pcluster, which only appears in
+		 * crafted images by fuzzers for now.  But handle this anyway.
+		 */
+		tocache = false;	/* use temporary short-lived pages */
+	} else {
+		DBG_BUGON(1); /* referenced managed folios can't be truncated */
+		tocache = true;
 	}
-
-	/*
-	 * the managed page has been truncated, it's unsafe to
-	 * reuse this one, let's allocate a new cache-managed page.
-	 */
-	DBG_BUGON(page->mapping);
-	DBG_BUGON(!justfound);
-
-	tocache = true;
 	unlock_page(page);
 	put_page(page);
 out_allocpage:
@@ -1517,16 +1519,11 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		end = cur + pcl->pclusterpages;
 
 		do {
-			struct page *page;
-
-			page = pickup_page_for_submission(pcl, i++,
-					&f->pagepool, mc);
-			if (!page)
-				continue;
+			struct page *page = NULL;
 
 			if (bio && (cur != last_index + 1 ||
 				    last_bdev != mdev.m_bdev)) {
-submit_bio_retry:
+drain_io:
 				submit_bio(bio);
 				if (memstall) {
 					psi_memstall_leave(&pflags);
@@ -1535,6 +1532,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				bio = NULL;
 			}
 
+			if (!page) {
+				page = pickup_page_for_submission(pcl, i++,
+						&f->pagepool, mc);
+				if (!page)
+					continue;
+			}
+
 			if (unlikely(PageWorkingset(page)) && !memstall) {
 				psi_memstall_enter(&pflags);
 				memstall = 1;
@@ -1555,7 +1559,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			}
 
 			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
-				goto submit_bio_retry;
+				goto drain_io;
 
 			last_index = cur;
 			bypass = false;
-- 
2.43.5


