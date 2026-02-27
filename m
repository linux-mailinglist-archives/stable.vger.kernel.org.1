Return-Path: <stable+bounces-219902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCAwJW4ToWlwqAQAu9opvQ
	(envelope-from <stable+bounces-219902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:45:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDFD1B25B9
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 959B930D911A
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 03:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06343335567;
	Fri, 27 Feb 2026 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m54Y22tE"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3C3346A9;
	Fri, 27 Feb 2026 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163874; cv=none; b=rho1ADqTXFXnDD7v25a7Zsp0Yu+3EHZNTLtZ23eHHS/uVGQWDK0UKGKQA6KXK3yXZ1snMdysT9avfzY2sPcZIBLrFNK4L1coRjFdUsaVVFg34mlxsIuEocPXHMh4RE2Th4Hf0W2Q5jzItj5UeSVJu2EwosHsMkDgrBmKjs5q5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163874; c=relaxed/simple;
	bh=TdPQaD21vz2GHdSeIzuPBRj0NGRnd9aQi9mET1Mb7Hw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TI7wSfVS8dmRru3HeznC5wc81b0dEmiZ7gJS/66ukHXWJ7w832Pbsx+j5j6PtTiviw6Tjbvm9O0cUMjXlTag+Yh6whqkfTrxaGekynLiQTvK0hLg6jGW2mNoFCFkJyEoYpdxW5S5Kx+sWj596xsZPMs6mCn98TPOI8h3lURX+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m54Y22tE; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7E
	He2ik1HE1CV2rjuaMf4jBXy6EwaMksXD63DaAO4r4=; b=m54Y22tE3as+TYRdfs
	Ed4l8zYb410o7pKaHoSbLQUDa4Ev2L5HljqsA2QcDJwrtJmXQOYKcAUPo708ylbv
	iTGo63DZOycbtMGs0pVNIoLx9vGs1Qr0nrG82DczWY96RWFX3Sbdz88ZyvZlyqmJ
	xSvTayJWDt2vUX8B2BhsJqP+c=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgA3K83XEqFpoMyuPg--.10365S2;
	Fri, 27 Feb 2026 11:43:21 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>,
	Jan Kara <jack@suse.cz>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.6.y] btrfs: do not strictly require dirty metadata threshold for metadata writepages
Date: Fri, 27 Feb 2026 11:43:00 +0800
Message-Id: <20260227034300.1505150-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgA3K83XEqFpoMyuPg--.10365S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xry7KF4rWr15CrWrWw43Awb_yoWxAr4DpF
	W3C3ZxJr4qq3WUWr93uayqv34Svrs7J3y7Gr95G3yFvFnxCryIgryj9r10vFW8ArWxGr4Y
	vr4jya48J3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_uWlDUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+hp9F2mhEtpiEgAA36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219902-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,suse.cz,bur.io,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bur.io:email]
X-Rspamd-Queue-Id: EDDFD1B25B9
X-Rspamd-Action: no action

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 4e159150a9a56d66d247f4b5510bed46fe58aa1c ]

[BUG]
There is an internal report that over 1000 processes are
waiting at the io_schedule_timeout() of balance_dirty_pages(), causing
a system hang and trigger a kernel coredump.

The kernel is v6.4 kernel based, but the root problem still applies to
any upstream kernel before v6.18.

[CAUSE]
From Jan Kara for his wisdom on the dirty page balance behavior first.

  This cgroup dirty limit was what was actually playing the role here
  because the cgroup had only a small amount of memory and so the dirty
  limit for it was something like 16MB.

  Dirty throttling is responsible for enforcing that nobody can dirty
  (significantly) more dirty memory than there's dirty limit. Thus when
  a task is dirtying pages it periodically enters into balance_dirty_pages()
  and we let it sleep there to slow down the dirtying.

  When the system is over dirty limit already (either globally or within
  a cgroup of the running task), we will not let the task exit from
  balance_dirty_pages() until the number of dirty pages drops below the
  limit.

  So in this particular case, as I already mentioned, there was a cgroup
  with relatively small amount of memory and as a result with dirty limit
  set at 16MB. A task from that cgroup has dirtied about 28MB worth of
  pages in btrfs btree inode and these were practically the only dirty
  pages in that cgroup.

So that means the only way to reduce the dirty pages of that cgroup is
to writeback the dirty pages of btrfs btree inode, and only after that
those processes can exit balance_dirty_pages().

Now back to the btrfs part, btree_writepages() is responsible for
writing back dirty btree inode pages.

The problem here is, there is a btrfs internal threshold that if the
btree inode's dirty bytes are below the 32M threshold, it will not
do any writeback.

This behavior is to batch as much metadata as possible so we won't write
back those tree blocks and then later re-COW them again for another
modification.

This internal 32MiB is higher than the existing dirty page size (28MiB),
meaning no writeback will happen, causing a deadlock between btrfs and
cgroup:

- Btrfs doesn't want to write back btree inode until more dirty pages

- Cgroup/MM doesn't want more dirty pages for btrfs btree inode
  Thus any process touching that btree inode is put into sleep until
  the number of dirty pages is reduced.

Thanks Jan Kara a lot for the analysis of the root cause.

[ENHANCEMENT]
Since kernel commit b55102826d7d ("btrfs: set AS_KERNEL_FILE on the
btree_inode"), btrfs btree inode pages will only be charged to the root
cgroup which should have a much larger limit than btrfs' 32MiB
threshold.
So it should not affect newer kernels.

But for all current LTS kernels, they are all affected by this problem,
and backporting the whole AS_KERNEL_FILE may not be a good idea.

Even for newer kernels I still think it's a good idea to get
rid of the internal threshold at btree_writepages(), since for most cases
cgroup/MM has a better view of full system memory usage than btrfs' fixed
threshold.

For internal callers using btrfs_btree_balance_dirty() since that
function is already doing internal threshold check, we don't need to
bother them.

But for external callers of btree_writepages(), just respect their
requests and write back whatever they want, ignoring the internal
btrfs threshold to avoid such deadlock on btree inode dirty page
balancing.

CC: stable@vger.kernel.org
CC: Jan Kara <jack@suse.cz>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ The context change is due to the commit 41044b41ad2c
("btrfs: add helper to get fs_info from struct inode pointer")
in v6.9 and the commit c66f2afc7148
("btrfs: remove pointless writepages callback wrapper")
in v6.10 which are irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 fs/btrfs/disk-io.c   | 22 ----------------------
 fs/btrfs/extent_io.c |  3 +--
 fs/btrfs/extent_io.h |  3 +--
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3c26e91a8055..d5a83d8b3427 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -470,28 +470,6 @@ static int btree_migrate_folio(struct address_space *mapping,
 #define btree_migrate_folio NULL
 #endif
 
-static int btree_writepages(struct address_space *mapping,
-			    struct writeback_control *wbc)
-{
-	struct btrfs_fs_info *fs_info;
-	int ret;
-
-	if (wbc->sync_mode == WB_SYNC_NONE) {
-
-		if (wbc->for_kupdate)
-			return 0;
-
-		fs_info = BTRFS_I(mapping->host)->root->fs_info;
-		/* this is a bit racy, but that's ok */
-		ret = __percpu_counter_compare(&fs_info->dirty_metadata_bytes,
-					     BTRFS_DIRTY_METADATA_THRESH,
-					     fs_info->dirty_metadata_batch);
-		if (ret < 0)
-			return 0;
-	}
-	return btree_write_cache_pages(mapping, wbc);
-}
-
 static bool btree_release_folio(struct folio *folio, gfp_t gfp_flags)
 {
 	if (folio_test_writeback(folio) || folio_test_dirty(folio))
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fab8ffb3a2f8..536c400e5964 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1921,8 +1921,7 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 	return 1;
 }
 
-int btree_write_cache_pages(struct address_space *mapping,
-				   struct writeback_control *wbc)
+int btree_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	struct btrfs_eb_write_context ctx = { .wbc = wbc };
 	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 68368ba99321..ee955527f298 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -189,8 +189,7 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 			       bool pages_dirty);
 int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
-int btree_write_cache_pages(struct address_space *mapping,
-			    struct writeback_control *wbc);
+int btree_writepages(struct address_space *mapping, struct writeback_control *wbc);
 void extent_readahead(struct readahead_control *rac);
 int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		  u64 start, u64 len);
-- 
2.34.1


