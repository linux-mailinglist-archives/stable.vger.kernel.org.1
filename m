Return-Path: <stable+bounces-219891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBWCLnf6oGlXogQAu9opvQ
	(envelope-from <stable+bounces-219891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 02:59:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B6F1B1B6C
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 02:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAAE6304B44E
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 01:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EC02C033C;
	Fri, 27 Feb 2026 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XihaBDqH"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C32BEC55;
	Fri, 27 Feb 2026 01:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157455; cv=none; b=aLcEJrJRP5nd3kDDI1nTWH/UnCegBvrwSp6UXYbHlyLP6hdpiTkVvzKejBdSrZS1xMiuoRIbGwtckra01zuX77YyrNmfaG0B5iibqficceivI2sI4WVVQwipNJThK5tCl5fyRNxIJI/vAHg1zzfNlKXCQ6D4y+8El8+9J0px+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157455; c=relaxed/simple;
	bh=H/vCX3vRyMzvEV0CDlcLSqDHuryxbwtGhllo+DLM+pY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zf8ACRtP+PXA+Xoltm5IbMKMtP1QnqsPZulWtm7675I5bOTK78H3epjTyt98RyVQpua6MKL78bfRPMtOp8jO5oAQyzFbqlQ1HwOLHjw7oD3UeJxhSZ65wEO8RnIaAW22KgmBGBdmJLCXZ9D9wTSbjmV3b9qlSmdhvaDSrUq2dxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XihaBDqH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Po
	ZRk2Z6MjzIOIinjNuVstv21/HMOoHWfX8CYuyImG4=; b=XihaBDqHLgT4LESX/O
	sRERKPIPSIWQ4K8yGxXwY/eJNXvB+WvqqWkEpboYrCR1AwWGToChSPUx08ZCA/Fi
	iwTAW8zzeTk7GXIueN2twaP8QM5T/MbW/Os7reUSa/2kKimdY3aFkWMS/BbB871r
	OKALq5+HAaO+NnYJzPk9mnRbE=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnr+Hs+aBpD3WwNg--.22325S2;
	Fri, 27 Feb 2026 09:57:01 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>,
	Jan Kara <jack@suse.cz>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.12.y] btrfs: do not strictly require dirty metadata threshold for metadata writepages
Date: Fri, 27 Feb 2026 09:56:58 +0800
Message-Id: <20260227015658.1116424-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr+Hs+aBpD3WwNg--.22325S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xry7KF4rWr15CrWrWw43Awb_yoWxWFWrpF
	WakwnxJw4DX3WUWrZ3uayqv34SvrZ7J3y7Cr95G3ySvFnxCryIgryj9r10vFW8JrWxGrWa
	vr4Yya48X3WqyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_OJ5DUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+Q081Wmg+e1bqQAA3y
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219891-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email,bur.io:email]
X-Rspamd-Queue-Id: E6B6F1B1B6C
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
[ The context change is due to the commit 5e121ae687b8
("btrfs: use buffer xarray for extent buffer writeback operations")
in v6.16 which is irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 fs/btrfs/disk-io.c   | 22 ----------------------
 fs/btrfs/extent_io.c |  3 +--
 fs/btrfs/extent_io.h |  3 +--
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 034cd7b1d0f5..a03b7a217314 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -498,28 +498,6 @@ static int btree_migrate_folio(struct address_space *mapping,
 #define btree_migrate_folio NULL
 #endif
 
-static int btree_writepages(struct address_space *mapping,
-			    struct writeback_control *wbc)
-{
-	int ret;
-
-	if (wbc->sync_mode == WB_SYNC_NONE) {
-		struct btrfs_fs_info *fs_info;
-
-		if (wbc->for_kupdate)
-			return 0;
-
-		fs_info = inode_to_fs_info(mapping->host);
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
index 1e855c5854ce..2e8dc928621c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2088,8 +2088,7 @@ static int submit_eb_page(struct folio *folio, struct btrfs_eb_write_context *ct
 	return 1;
 }
 
-int btree_write_cache_pages(struct address_space *mapping,
-				   struct writeback_control *wbc)
+int btree_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	struct btrfs_eb_write_context ctx = { .wbc = wbc };
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(mapping->host);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 039a73731135..c63ccfb9fc37 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -244,8 +244,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 			       u64 start, u64 end, struct writeback_control *wbc,
 			       bool pages_dirty);
 int btrfs_writepages(struct address_space *mapping, struct writeback_control *wbc);
-int btree_write_cache_pages(struct address_space *mapping,
-			    struct writeback_control *wbc);
+int btree_writepages(struct address_space *mapping, struct writeback_control *wbc);
 void btrfs_readahead(struct readahead_control *rac);
 int set_folio_extent_mapped(struct folio *folio);
 int set_page_extent_mapped(struct page *page);
-- 
2.34.1


