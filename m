Return-Path: <stable+bounces-228736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF6sH65TwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:52:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 416282F5576
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C15C9304608A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3569F3A961B;
	Mon, 23 Mar 2026 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kCwbYT1S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E761B3B0ADD;
	Mon, 23 Mar 2026 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276984; cv=none; b=RNdVncZPpUnDK0ARmXpb0nYmPcHmNwhaZuBIDAtzk7Tzu8qZqLIX98+WYZkjVVHNRUIC2KamhYzPzXmstn3E8AGtGRisgE//rPC/qM1qRGPKT/kKIrr2d8oHTlCu6MxLdP996+JGwvNIGBnH8msHVHpLeecpUrdfKCcDNY35feQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276984; c=relaxed/simple;
	bh=ynPs1Uk/Cx6+Xe0yqcriABxD0LL/sgzEERzGlHjjyNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oej7tCr9CpJLWJOe5Kwj8pJeYLKEajNpjRxCaM/O68lHYmTHpJ72s4VieExE0wax0NCgrvNMse4sPyMTavYCTFFIIYVthC6TE0lz3LwYOb473h6y/iJ6wWK97qCTMq7sOZ+agy3stcdoMvmvP944Y/sn8PNQhCzOlL46u/DFtNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kCwbYT1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80396C4CEF7;
	Mon, 23 Mar 2026 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774276983;
	bh=ynPs1Uk/Cx6+Xe0yqcriABxD0LL/sgzEERzGlHjjyNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCwbYT1S2oZzCSpXeNudXxOptv1VCJbQ4Dl7aWXEkaapZ6XYzQdzvC9tLDnmV7IC3
	 ZWgPg+Vsy2hSCP/nbFkETUtGr6Z6W8++i2s8Ynseh3jqoJYvk+jiKqH45fXvpiWm+2
	 /KYiTJB41qiry6c4xew9Ne1mBQ0M+liHEQF94RbI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.12 277/460] btrfs: do not strictly require dirty metadata threshold for metadata writepages
Date: Mon, 23 Mar 2026 14:44:33 +0100
Message-ID: <20260323134533.283502160@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228736-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.cz,bur.io,suse.com,163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 416282F5576
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 4e159150a9a56d66d247f4b5510bed46fe58aa1c ]

[BUG]
There is an internal report that over 1000 processes are
waiting at the io_schedule_timeout() of balance_dirty_pages(), causing
a system hang and trigger a kernel coredump.

The kernel is v6.4 kernel based, but the root problem still applies to
any upstream kernel before v6.18.

[CAUSE]
>From Jan Kara for his wisdom on the dirty page balance behavior first.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c   |   22 ----------------------
 fs/btrfs/extent_io.c |    3 +--
 fs/btrfs/extent_io.h |    3 +--
 3 files changed, 2 insertions(+), 26 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -498,28 +498,6 @@ static int btree_migrate_folio(struct ad
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
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2088,8 +2088,7 @@ static int submit_eb_page(struct folio *
 	return 1;
 }
 
-int btree_write_cache_pages(struct address_space *mapping,
-				   struct writeback_control *wbc)
+int btree_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	struct btrfs_eb_write_context ctx = { .wbc = wbc };
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(mapping->host);
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -244,8 +244,7 @@ void extent_write_locked_range(struct in
 			       u64 start, u64 end, struct writeback_control *wbc,
 			       bool pages_dirty);
 int btrfs_writepages(struct address_space *mapping, struct writeback_control *wbc);
-int btree_write_cache_pages(struct address_space *mapping,
-			    struct writeback_control *wbc);
+int btree_writepages(struct address_space *mapping, struct writeback_control *wbc);
 void btrfs_readahead(struct readahead_control *rac);
 int set_folio_extent_mapped(struct folio *folio);
 int set_page_extent_mapped(struct page *page);



