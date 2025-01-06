Return-Path: <stable+bounces-107050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DB2A029F9
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720657A234A
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B24F15855C;
	Mon,  6 Jan 2025 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vq2eNl8S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A62157A72;
	Mon,  6 Jan 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177303; cv=none; b=gSgWYXRMvo2aqxB/dYxRiIS2QyQQwELsHgHy9/WcG4+hCve1FFRWKvvZHrDaU1JyvntmsQJtxId9dwjo/wg20gZPNoFX64iclNp9+lpSTh+leWBaOIIx1ATf5MPaESEncL4Ni8+xw52s5inAtU+xlIm2en4tqbdNnjqKRG7moA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177303; c=relaxed/simple;
	bh=Lq1eYMU5I0k6MEyt05y0PoOP0hZXGB/mAGM9F+xHtCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=to113zz/2aBrnSUkwWh72+47aMx1ExwdragEidO1YLiUkVxjOzFu3mqlOAxt8Tmlq7HKXJmJ+LjJZ2VVPEr9qcnZMGlkXWUUTBnYq4rk8WeUv4kiaAE5phN6nN/+GQUkzz3TT7ISQ+iOTM9XmXCDxEN3lX3s/yII81rSiIBjnIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vq2eNl8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C14C4CED2;
	Mon,  6 Jan 2025 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177302;
	bh=Lq1eYMU5I0k6MEyt05y0PoOP0hZXGB/mAGM9F+xHtCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vq2eNl8SykXcasl7QSii8SOP1T4jfhXKV1MNVCnwEWwQ6GQfcv7V677Rvjj8s6J+r
	 hJN2AZcakH+/QagfdFD2KtD+KFOF7Uf3gisamnaEvdjcDwPj42C7M23sMjzWMxrKGo
	 rm4ldhlMVV9o8LWrsVx+wog83rThRsyNVsOUoWKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 118/222] ceph: print cluster fsid and client global_id in all debug logs
Date: Mon,  6 Jan 2025 16:15:22 +0100
Message-ID: <20250106151155.069105214@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 38d46409c4639a1d659ebfa70e27a8bed6b8ee1d ]

Multiple CephFS mounts on a host is increasingly common so
disambiguating messages like this is necessary and will make it easier
to debug issues.

At the same this will improve the debug logs to make them easier to
troubleshooting issues, such as print the ino# instead only printing
the memory addresses of the corresponding inodes and print the dentry
names instead of the corresponding memory addresses for the dentry,etc.

Link: https://tracker.ceph.com/issues/61590
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Stable-dep-of: 550f7ca98ee0 ("ceph: give up on paths longer than PATH_MAX")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/acl.c        |   6 +-
 fs/ceph/addr.c       | 279 +++++++++--------
 fs/ceph/caps.c       | 710 +++++++++++++++++++++++++------------------
 fs/ceph/crypto.c     |  39 ++-
 fs/ceph/debugfs.c    |   6 +-
 fs/ceph/dir.c        | 218 +++++++------
 fs/ceph/export.c     |  39 +--
 fs/ceph/file.c       | 245 ++++++++-------
 fs/ceph/inode.c      | 485 ++++++++++++++++-------------
 fs/ceph/ioctl.c      |  13 +-
 fs/ceph/locks.c      |  57 ++--
 fs/ceph/mds_client.c | 558 +++++++++++++++++++---------------
 fs/ceph/mdsmap.c     |  24 +-
 fs/ceph/metric.c     |   5 +-
 fs/ceph/quota.c      |  29 +-
 fs/ceph/snap.c       | 174 ++++++-----
 fs/ceph/super.c      |  70 +++--
 fs/ceph/super.h      |   6 +
 fs/ceph/xattr.c      |  96 +++---
 19 files changed, 1747 insertions(+), 1312 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index c53a1d220622..e95841961397 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 
 #include "super.h"
+#include "mds_client.h"
 
 static inline void ceph_set_cached_acl(struct inode *inode,
 					int type, struct posix_acl *acl)
@@ -31,6 +32,7 @@ static inline void ceph_set_cached_acl(struct inode *inode,
 
 struct posix_acl *ceph_get_acl(struct inode *inode, int type, bool rcu)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int size;
 	unsigned int retry_cnt = 0;
 	const char *name;
@@ -72,8 +74,8 @@ struct posix_acl *ceph_get_acl(struct inode *inode, int type, bool rcu)
 	} else if (size == -ENODATA || size == 0) {
 		acl = NULL;
 	} else {
-		pr_err_ratelimited("get acl %llx.%llx failed, err=%d\n",
-				   ceph_vinop(inode), size);
+		pr_err_ratelimited_client(cl, "%llx.%llx failed, err=%d\n",
+					  ceph_vinop(inode), size);
 		acl = ERR_PTR(-EIO);
 	}
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2c92de964c5a..ffd3ff5ae99b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -79,18 +79,18 @@ static inline struct ceph_snap_context *page_snap_context(struct page *page)
  */
 static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	struct inode *inode;
+	struct inode *inode = mapping->host;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc;
 
 	if (folio_test_dirty(folio)) {
-		dout("%p dirty_folio %p idx %lu -- already dirty\n",
-		     mapping->host, folio, folio->index);
+		doutc(cl, "%llx.%llx %p idx %lu -- already dirty\n",
+		      ceph_vinop(inode), folio, folio->index);
 		VM_BUG_ON_FOLIO(!folio_test_private(folio), folio);
 		return false;
 	}
 
-	inode = mapping->host;
 	ci = ceph_inode(inode);
 
 	/* dirty the head */
@@ -110,12 +110,12 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (ci->i_wrbuffer_ref == 0)
 		ihold(inode);
 	++ci->i_wrbuffer_ref;
-	dout("%p dirty_folio %p idx %lu head %d/%d -> %d/%d "
-	     "snapc %p seq %lld (%d snaps)\n",
-	     mapping->host, folio, folio->index,
-	     ci->i_wrbuffer_ref-1, ci->i_wrbuffer_ref_head-1,
-	     ci->i_wrbuffer_ref, ci->i_wrbuffer_ref_head,
-	     snapc, snapc->seq, snapc->num_snaps);
+	doutc(cl, "%llx.%llx %p idx %lu head %d/%d -> %d/%d "
+	      "snapc %p seq %lld (%d snaps)\n",
+	      ceph_vinop(inode), folio, folio->index,
+	      ci->i_wrbuffer_ref-1, ci->i_wrbuffer_ref_head-1,
+	      ci->i_wrbuffer_ref, ci->i_wrbuffer_ref_head,
+	      snapc, snapc->seq, snapc->num_snaps);
 	spin_unlock(&ci->i_ceph_lock);
 
 	/*
@@ -136,23 +136,22 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 static void ceph_invalidate_folio(struct folio *folio, size_t offset,
 				size_t length)
 {
-	struct inode *inode;
-	struct ceph_inode_info *ci;
+	struct inode *inode = folio->mapping->host;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
 
-	inode = folio->mapping->host;
-	ci = ceph_inode(inode);
 
 	if (offset != 0 || length != folio_size(folio)) {
-		dout("%p invalidate_folio idx %lu partial dirty page %zu~%zu\n",
-		     inode, folio->index, offset, length);
+		doutc(cl, "%llx.%llx idx %lu partial dirty page %zu~%zu\n",
+		      ceph_vinop(inode), folio->index, offset, length);
 		return;
 	}
 
 	WARN_ON(!folio_test_locked(folio));
 	if (folio_test_private(folio)) {
-		dout("%p invalidate_folio idx %lu full dirty page\n",
-		     inode, folio->index);
+		doutc(cl, "%llx.%llx idx %lu full dirty page\n",
+		      ceph_vinop(inode), folio->index);
 
 		snapc = folio_detach_private(folio);
 		ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
@@ -165,10 +164,10 @@ static void ceph_invalidate_folio(struct folio *folio, size_t offset,
 static bool ceph_release_folio(struct folio *folio, gfp_t gfp)
 {
 	struct inode *inode = folio->mapping->host;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 
-	dout("%llx:%llx release_folio idx %lu (%sdirty)\n",
-	     ceph_vinop(inode),
-	     folio->index, folio_test_dirty(folio) ? "" : "not ");
+	doutc(cl, "%llx.%llx idx %lu (%sdirty)\n", ceph_vinop(inode),
+	      folio->index, folio_test_dirty(folio) ? "" : "not ");
 
 	if (folio_test_private(folio))
 		return false;
@@ -244,6 +243,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 {
 	struct inode *inode = req->r_inode;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
 	struct netfs_io_subrequest *subreq = req->r_priv;
 	struct ceph_osd_req_op *op = &req->r_ops[0];
@@ -253,8 +253,8 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	ceph_update_read_metrics(&fsc->mdsc->metric, req->r_start_latency,
 				 req->r_end_latency, osd_data->length, err);
 
-	dout("%s: result %d subreq->len=%zu i_size=%lld\n", __func__, req->r_result,
-	     subreq->len, i_size_read(req->r_inode));
+	doutc(cl, "result %d subreq->len=%zu i_size=%lld\n", req->r_result,
+	      subreq->len, i_size_read(req->r_inode));
 
 	/* no object means success but no data */
 	if (err == -ENOENT)
@@ -348,6 +348,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	struct inode *inode = rreq->inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_request *req = NULL;
 	struct ceph_vino vino = ceph_vino(inode);
 	struct iov_iter iter;
@@ -384,7 +385,8 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 			goto out;
 	}
 
-	dout("%s: pos=%llu orig_len=%zu len=%llu\n", __func__, subreq->start, subreq->len, len);
+	doutc(cl, "%llx.%llx pos=%llu orig_len=%zu len=%llu\n",
+	      ceph_vinop(inode), subreq->start, subreq->len, len);
 
 	iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages, subreq->start, len);
 
@@ -401,8 +403,8 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 
 		err = iov_iter_get_pages_alloc2(&iter, &pages, len, &page_off);
 		if (err < 0) {
-			dout("%s: iov_ter_get_pages_alloc returned %d\n",
-			     __func__, err);
+			doutc(cl, "%llx.%llx failed to allocate pages, %d\n",
+			      ceph_vinop(inode), err);
 			goto out;
 		}
 
@@ -430,12 +432,13 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	ceph_osdc_put_request(req);
 	if (err)
 		netfs_subreq_terminated(subreq, err, false);
-	dout("%s: result %d\n", __func__, err);
+	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
 }
 
 static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct inode *inode = rreq->inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int got = 0, want = CEPH_CAP_FILE_CACHE;
 	struct ceph_netfs_request_data *priv;
 	int ret = 0;
@@ -467,12 +470,12 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	 */
 	ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
 	if (ret < 0) {
-		dout("start_read %p, error getting cap\n", inode);
+		doutc(cl, "%llx.%llx, error getting cap\n", ceph_vinop(inode));
 		goto out;
 	}
 
 	if (!(got & want)) {
-		dout("start_read %p, no cache cap\n", inode);
+		doutc(cl, "%llx.%llx, no cache cap\n", ceph_vinop(inode));
 		ret = -EACCES;
 		goto out;
 	}
@@ -567,13 +570,14 @@ get_oldest_context(struct inode *inode, struct ceph_writeback_ctl *ctl,
 		   struct ceph_snap_context *page_snapc)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_snap_context *snapc = NULL;
 	struct ceph_cap_snap *capsnap = NULL;
 
 	spin_lock(&ci->i_ceph_lock);
 	list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
-		dout(" cap_snap %p snapc %p has %d dirty pages\n", capsnap,
-		     capsnap->context, capsnap->dirty_pages);
+		doutc(cl, " capsnap %p snapc %p has %d dirty pages\n",
+		      capsnap, capsnap->context, capsnap->dirty_pages);
 		if (!capsnap->dirty_pages)
 			continue;
 
@@ -605,8 +609,8 @@ get_oldest_context(struct inode *inode, struct ceph_writeback_ctl *ctl,
 	}
 	if (!snapc && ci->i_wrbuffer_ref_head) {
 		snapc = ceph_get_snap_context(ci->i_head_snapc);
-		dout(" head snapc %p has %d dirty pages\n",
-		     snapc, ci->i_wrbuffer_ref_head);
+		doutc(cl, " head snapc %p has %d dirty pages\n", snapc,
+		      ci->i_wrbuffer_ref_head);
 		if (ctl) {
 			ctl->i_size = i_size_read(inode);
 			ctl->truncate_size = ci->i_truncate_size;
@@ -663,6 +667,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	struct inode *inode = page->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_snap_context *snapc, *oldest;
 	loff_t page_off = page_offset(page);
 	int err;
@@ -674,7 +679,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	bool caching = ceph_is_cache_enabled(inode);
 	struct page *bounce_page = NULL;
 
-	dout("writepage %p idx %lu\n", page, page->index);
+	doutc(cl, "%llx.%llx page %p idx %lu\n", ceph_vinop(inode), page,
+	      page->index);
 
 	if (ceph_inode_is_shutdown(inode))
 		return -EIO;
@@ -682,13 +688,14 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	/* verify this is a writeable snap context */
 	snapc = page_snap_context(page);
 	if (!snapc) {
-		dout("writepage %p page %p not dirty?\n", inode, page);
+		doutc(cl, "%llx.%llx page %p not dirty?\n", ceph_vinop(inode),
+		      page);
 		return 0;
 	}
 	oldest = get_oldest_context(inode, &ceph_wbc, snapc);
 	if (snapc->seq > oldest->seq) {
-		dout("writepage %p page %p snapc %p not writeable - noop\n",
-		     inode, page, snapc);
+		doutc(cl, "%llx.%llx page %p snapc %p not writeable - noop\n",
+		      ceph_vinop(inode), page, snapc);
 		/* we should only noop if called by kswapd */
 		WARN_ON(!(current->flags & PF_MEMALLOC));
 		ceph_put_snap_context(oldest);
@@ -699,8 +706,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 
 	/* is this a partial page at end of file? */
 	if (page_off >= ceph_wbc.i_size) {
-		dout("folio at %lu beyond eof %llu\n", folio->index,
-				ceph_wbc.i_size);
+		doutc(cl, "%llx.%llx folio at %lu beyond eof %llu\n",
+		      ceph_vinop(inode), folio->index, ceph_wbc.i_size);
 		folio_invalidate(folio, 0, folio_size(folio));
 		return 0;
 	}
@@ -709,8 +716,9 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		len = ceph_wbc.i_size - page_off;
 
 	wlen = IS_ENCRYPTED(inode) ? round_up(len, CEPH_FSCRYPT_BLOCK_SIZE) : len;
-	dout("writepage %p page %p index %lu on %llu~%llu snapc %p seq %lld\n",
-	     inode, page, page->index, page_off, wlen, snapc, snapc->seq);
+	doutc(cl, "%llx.%llx page %p index %lu on %llu~%llu snapc %p seq %lld\n",
+	      ceph_vinop(inode), page, page->index, page_off, wlen, snapc,
+	      snapc->seq);
 
 	if (atomic_long_inc_return(&fsc->writeback_count) >
 	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
@@ -751,8 +759,9 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	osd_req_op_extent_osd_data_pages(req, 0,
 			bounce_page ? &bounce_page : &page, wlen, 0,
 			false, false);
-	dout("writepage %llu~%llu (%llu bytes, %sencrypted)\n",
-	     page_off, len, wlen, IS_ENCRYPTED(inode) ? "" : "not ");
+	doutc(cl, "%llx.%llx %llu~%llu (%llu bytes, %sencrypted)\n",
+	      ceph_vinop(inode), page_off, len, wlen,
+	      IS_ENCRYPTED(inode) ? "" : "not ");
 
 	req->r_mtime = inode->i_mtime;
 	ceph_osdc_start_request(osdc, req);
@@ -771,19 +780,21 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 			wbc = &tmp_wbc;
 		if (err == -ERESTARTSYS) {
 			/* killed by SIGKILL */
-			dout("writepage interrupted page %p\n", page);
+			doutc(cl, "%llx.%llx interrupted page %p\n",
+			      ceph_vinop(inode), page);
 			redirty_page_for_writepage(wbc, page);
 			end_page_writeback(page);
 			return err;
 		}
 		if (err == -EBLOCKLISTED)
 			fsc->blocklisted = true;
-		dout("writepage setting page/mapping error %d %p\n",
-		     err, page);
+		doutc(cl, "%llx.%llx setting page/mapping error %d %p\n",
+		      ceph_vinop(inode), err, page);
 		mapping_set_error(&inode->i_data, err);
 		wbc->pages_skipped++;
 	} else {
-		dout("writepage cleaned page %p\n", page);
+		doutc(cl, "%llx.%llx cleaned page %p\n",
+		      ceph_vinop(inode), page);
 		err = 0;  /* vfs expects us to return 0 */
 	}
 	oldest = detach_page_private(page);
@@ -835,6 +846,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 {
 	struct inode *inode = req->r_inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_osd_data *osd_data;
 	struct page *page;
 	int num_pages, total_pages = 0;
@@ -846,7 +858,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 	unsigned int len = 0;
 	bool remove_page;
 
-	dout("writepages_finish %p rc %d\n", inode, rc);
+	doutc(cl, "%llx.%llx rc %d\n", ceph_vinop(inode), rc);
 	if (rc < 0) {
 		mapping_set_error(mapping, rc);
 		ceph_set_error_write(ci);
@@ -868,8 +880,10 @@ static void writepages_finish(struct ceph_osd_request *req)
 	/* clean all pages */
 	for (i = 0; i < req->r_num_ops; i++) {
 		if (req->r_ops[i].op != CEPH_OSD_OP_WRITE) {
-			pr_warn("%s incorrect op %d req %p index %d tid %llu\n",
-				__func__, req->r_ops[i].op, req, i, req->r_tid);
+			pr_warn_client(cl,
+				"%llx.%llx incorrect op %d req %p index %d tid %llu\n",
+				ceph_vinop(inode), req->r_ops[i].op, req, i,
+				req->r_tid);
 			break;
 		}
 
@@ -896,7 +910,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 
 			ceph_put_snap_context(detach_page_private(page));
 			end_page_writeback(page);
-			dout("unlocking %p\n", page);
+			doutc(cl, "unlocking %p\n", page);
 
 			if (remove_page)
 				generic_error_remove_page(inode->i_mapping,
@@ -904,8 +918,9 @@ static void writepages_finish(struct ceph_osd_request *req)
 
 			unlock_page(page);
 		}
-		dout("writepages_finish %p wrote %llu bytes cleaned %d pages\n",
-		     inode, osd_data->length, rc >= 0 ? num_pages : 0);
+		doutc(cl, "%llx.%llx wrote %llu bytes cleaned %d pages\n",
+		      ceph_vinop(inode), osd_data->length,
+		      rc >= 0 ? num_pages : 0);
 
 		release_pages(osd_data->pages, num_pages);
 	}
@@ -933,6 +948,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_vino vino = ceph_vino(inode);
 	pgoff_t index, start_index, end = -1;
 	struct ceph_snap_context *snapc = NULL, *last_snapc = NULL, *pgsnapc;
@@ -950,15 +966,15 @@ static int ceph_writepages_start(struct address_space *mapping,
 	    fsc->write_congested)
 		return 0;
 
-	dout("writepages_start %p (mode=%s)\n", inode,
-	     wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
-	     (wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD"));
+	doutc(cl, "%llx.%llx (mode=%s)\n", ceph_vinop(inode),
+	      wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
+	      (wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD"));
 
 	if (ceph_inode_is_shutdown(inode)) {
 		if (ci->i_wrbuffer_ref > 0) {
-			pr_warn_ratelimited(
-				"writepage_start %p %lld forced umount\n",
-				inode, ceph_ino(inode));
+			pr_warn_ratelimited_client(cl,
+				"%llx.%llx %lld forced umount\n",
+				ceph_vinop(inode), ceph_ino(inode));
 		}
 		mapping_set_error(mapping, -EIO);
 		return -EIO; /* we're in a forced umount, don't write! */
@@ -982,11 +998,11 @@ static int ceph_writepages_start(struct address_space *mapping,
 	if (!snapc) {
 		/* hmm, why does writepages get called when there
 		   is no dirty data? */
-		dout(" no snap context with dirty data?\n");
+		doutc(cl, " no snap context with dirty data?\n");
 		goto out;
 	}
-	dout(" oldest snapc is %p seq %lld (%d snaps)\n",
-	     snapc, snapc->seq, snapc->num_snaps);
+	doutc(cl, " oldest snapc is %p seq %lld (%d snaps)\n", snapc,
+	      snapc->seq, snapc->num_snaps);
 
 	should_loop = false;
 	if (ceph_wbc.head_snapc && snapc != last_snapc) {
@@ -996,13 +1012,13 @@ static int ceph_writepages_start(struct address_space *mapping,
 			end = -1;
 			if (index > 0)
 				should_loop = true;
-			dout(" cyclic, start at %lu\n", index);
+			doutc(cl, " cyclic, start at %lu\n", index);
 		} else {
 			index = wbc->range_start >> PAGE_SHIFT;
 			end = wbc->range_end >> PAGE_SHIFT;
 			if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 				range_whole = true;
-			dout(" not cyclic, %lu to %lu\n", index, end);
+			doutc(cl, " not cyclic, %lu to %lu\n", index, end);
 		}
 	} else if (!ceph_wbc.head_snapc) {
 		/* Do not respect wbc->range_{start,end}. Dirty pages
@@ -1011,7 +1027,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 		 * associated with 'snapc' get written */
 		if (index > 0)
 			should_loop = true;
-		dout(" non-head snapc, range whole\n");
+		doutc(cl, " non-head snapc, range whole\n");
 	}
 
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
@@ -1034,12 +1050,12 @@ static int ceph_writepages_start(struct address_space *mapping,
 get_more_pages:
 		nr_folios = filemap_get_folios_tag(mapping, &index,
 						   end, tag, &fbatch);
-		dout("pagevec_lookup_range_tag got %d\n", nr_folios);
+		doutc(cl, "pagevec_lookup_range_tag got %d\n", nr_folios);
 		if (!nr_folios && !locked_pages)
 			break;
 		for (i = 0; i < nr_folios && locked_pages < max_pages; i++) {
 			page = &fbatch.folios[i]->page;
-			dout("? %p idx %lu\n", page, page->index);
+			doutc(cl, "? %p idx %lu\n", page, page->index);
 			if (locked_pages == 0)
 				lock_page(page);  /* first page */
 			else if (!trylock_page(page))
@@ -1048,15 +1064,15 @@ static int ceph_writepages_start(struct address_space *mapping,
 			/* only dirty pages, or our accounting breaks */
 			if (unlikely(!PageDirty(page)) ||
 			    unlikely(page->mapping != mapping)) {
-				dout("!dirty or !mapping %p\n", page);
+				doutc(cl, "!dirty or !mapping %p\n", page);
 				unlock_page(page);
 				continue;
 			}
 			/* only if matching snap context */
 			pgsnapc = page_snap_context(page);
 			if (pgsnapc != snapc) {
-				dout("page snapc %p %lld != oldest %p %lld\n",
-				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
+				doutc(cl, "page snapc %p %lld != oldest %p %lld\n",
+				      pgsnapc, pgsnapc->seq, snapc, snapc->seq);
 				if (!should_loop &&
 				    !ceph_wbc.head_snapc &&
 				    wbc->sync_mode != WB_SYNC_NONE)
@@ -1067,8 +1083,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 			if (page_offset(page) >= ceph_wbc.i_size) {
 				struct folio *folio = page_folio(page);
 
-				dout("folio at %lu beyond eof %llu\n",
-				     folio->index, ceph_wbc.i_size);
+				doutc(cl, "folio at %lu beyond eof %llu\n",
+				      folio->index, ceph_wbc.i_size);
 				if ((ceph_wbc.size_stable ||
 				    folio_pos(folio) >= i_size_read(inode)) &&
 				    folio_clear_dirty_for_io(folio))
@@ -1078,23 +1094,23 @@ static int ceph_writepages_start(struct address_space *mapping,
 				continue;
 			}
 			if (strip_unit_end && (page->index > strip_unit_end)) {
-				dout("end of strip unit %p\n", page);
+				doutc(cl, "end of strip unit %p\n", page);
 				unlock_page(page);
 				break;
 			}
 			if (PageWriteback(page) || PageFsCache(page)) {
 				if (wbc->sync_mode == WB_SYNC_NONE) {
-					dout("%p under writeback\n", page);
+					doutc(cl, "%p under writeback\n", page);
 					unlock_page(page);
 					continue;
 				}
-				dout("waiting on writeback %p\n", page);
+				doutc(cl, "waiting on writeback %p\n", page);
 				wait_on_page_writeback(page);
 				wait_on_page_fscache(page);
 			}
 
 			if (!clear_page_dirty_for_io(page)) {
-				dout("%p !clear_page_dirty_for_io\n", page);
+				doutc(cl, "%p !clear_page_dirty_for_io\n", page);
 				unlock_page(page);
 				continue;
 			}
@@ -1149,8 +1165,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 			}
 
 			/* note position of first page in fbatch */
-			dout("%p will write page %p idx %lu\n",
-			     inode, page, page->index);
+			doutc(cl, "%llx.%llx will write page %p idx %lu\n",
+			      ceph_vinop(inode), page, page->index);
 
 			if (atomic_long_inc_return(&fsc->writeback_count) >
 			    CONGESTION_ON_THRESH(
@@ -1164,8 +1180,9 @@ static int ceph_writepages_start(struct address_space *mapping,
 						locked_pages ? GFP_NOWAIT : GFP_NOFS);
 				if (IS_ERR(pages[locked_pages])) {
 					if (PTR_ERR(pages[locked_pages]) == -EINVAL)
-						pr_err("%s: inode->i_blkbits=%hhu\n",
-							__func__, inode->i_blkbits);
+						pr_err_client(cl,
+							"inode->i_blkbits=%hhu\n",
+							inode->i_blkbits);
 					/* better not fail on first page! */
 					BUG_ON(locked_pages == 0);
 					pages[locked_pages] = NULL;
@@ -1199,7 +1216,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 			if (nr_folios && i == nr_folios &&
 			    locked_pages < max_pages) {
-				dout("reached end fbatch, trying for more\n");
+				doutc(cl, "reached end fbatch, trying for more\n");
 				folio_batch_release(&fbatch);
 				goto get_more_pages;
 			}
@@ -1260,8 +1277,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 				/* Start a new extent */
 				osd_req_op_extent_dup_last(req, op_idx,
 							   cur_offset - offset);
-				dout("writepages got pages at %llu~%llu\n",
-				     offset, len);
+				doutc(cl, "got pages at %llu~%llu\n", offset,
+				      len);
 				osd_req_op_extent_osd_data_pages(req, op_idx,
 							data_pages, len, 0,
 							from_pool, false);
@@ -1294,12 +1311,13 @@ static int ceph_writepages_start(struct address_space *mapping,
 		if (IS_ENCRYPTED(inode))
 			len = round_up(len, CEPH_FSCRYPT_BLOCK_SIZE);
 
-		dout("writepages got pages at %llu~%llu\n", offset, len);
+		doutc(cl, "got pages at %llu~%llu\n", offset, len);
 
 		if (IS_ENCRYPTED(inode) &&
 		    ((offset | len) & ~CEPH_FSCRYPT_BLOCK_MASK))
-			pr_warn("%s: bad encrypted write offset=%lld len=%llu\n",
-				__func__, offset, len);
+			pr_warn_client(cl,
+				"bad encrypted write offset=%lld len=%llu\n",
+				offset, len);
 
 		osd_req_op_extent_osd_data_pages(req, op_idx, data_pages, len,
 						 0, from_pool, false);
@@ -1351,14 +1369,14 @@ static int ceph_writepages_start(struct address_space *mapping,
 			done = true;
 
 release_folios:
-		dout("folio_batch release on %d folios (%p)\n", (int)fbatch.nr,
-		     fbatch.nr ? fbatch.folios[0] : NULL);
+		doutc(cl, "folio_batch release on %d folios (%p)\n",
+		      (int)fbatch.nr, fbatch.nr ? fbatch.folios[0] : NULL);
 		folio_batch_release(&fbatch);
 	}
 
 	if (should_loop && !done) {
 		/* more to do; loop back to beginning of file */
-		dout("writepages looping back to beginning of file\n");
+		doutc(cl, "looping back to beginning of file\n");
 		end = start_index - 1; /* OK even when start_index == 0 */
 
 		/* to write dirty pages associated with next snapc,
@@ -1396,7 +1414,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 out:
 	ceph_osdc_put_request(req);
 	ceph_put_snap_context(last_snapc);
-	dout("writepages dend - startone, rc = %d\n", rc);
+	doutc(cl, "%llx.%llx dend - startone, rc = %d\n", ceph_vinop(inode),
+	      rc);
 	return rc;
 }
 
@@ -1430,11 +1449,12 @@ static struct ceph_snap_context *
 ceph_find_incompatible(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	if (ceph_inode_is_shutdown(inode)) {
-		dout(" page %p %llx:%llx is shutdown\n", page,
-		     ceph_vinop(inode));
+		doutc(cl, " %llx.%llx page %p is shutdown\n",
+		      ceph_vinop(inode), page);
 		return ERR_PTR(-ESTALE);
 	}
 
@@ -1455,13 +1475,15 @@ ceph_find_incompatible(struct page *page)
 		if (snapc->seq > oldest->seq) {
 			/* not writeable -- return it for the caller to deal with */
 			ceph_put_snap_context(oldest);
-			dout(" page %p snapc %p not current or oldest\n", page, snapc);
+			doutc(cl, " %llx.%llx page %p snapc %p not current or oldest\n",
+			      ceph_vinop(inode), page, snapc);
 			return ceph_get_snap_context(snapc);
 		}
 		ceph_put_snap_context(oldest);
 
 		/* yay, writeable, do it now (without dropping page lock) */
-		dout(" page %p snapc %p not current, but oldest\n", page, snapc);
+		doutc(cl, " %llx.%llx page %p snapc %p not current, but oldest\n",
+		      ceph_vinop(inode), page, snapc);
 		if (clear_page_dirty_for_io(page)) {
 			int r = writepage_nounlock(page, NULL);
 			if (r < 0)
@@ -1530,10 +1552,11 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
 {
 	struct folio *folio = page_folio(subpage);
 	struct inode *inode = file_inode(file);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	bool check_cap = false;
 
-	dout("write_end file %p inode %p folio %p %d~%d (%d)\n", file,
-	     inode, folio, (int)pos, (int)copied, (int)len);
+	doutc(cl, "%llx.%llx file %p folio %p %d~%d (%d)\n", ceph_vinop(inode),
+	      file, folio, (int)pos, (int)copied, (int)len);
 
 	if (!folio_test_uptodate(folio)) {
 		/* just return that nothing was copied on a short copy */
@@ -1593,6 +1616,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_file_info *fi = vma->vm_file->private_data;
 	loff_t off = (loff_t)vmf->pgoff << PAGE_SHIFT;
 	int want, got, err;
@@ -1604,8 +1628,8 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 
 	ceph_block_sigs(&oldset);
 
-	dout("filemap_fault %p %llx.%llx %llu trying to get caps\n",
-	     inode, ceph_vinop(inode), off);
+	doutc(cl, "%llx.%llx %llu trying to get caps\n",
+	      ceph_vinop(inode), off);
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
 	else
@@ -1616,8 +1640,8 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 	if (err < 0)
 		goto out_restore;
 
-	dout("filemap_fault %p %llu got cap refs on %s\n",
-	     inode, off, ceph_cap_string(got));
+	doutc(cl, "%llx.%llx %llu got cap refs on %s\n", ceph_vinop(inode),
+	      off, ceph_cap_string(got));
 
 	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) ||
 	    !ceph_has_inline_data(ci)) {
@@ -1625,8 +1649,8 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		ceph_add_rw_context(fi, &rw_ctx);
 		ret = filemap_fault(vmf);
 		ceph_del_rw_context(fi, &rw_ctx);
-		dout("filemap_fault %p %llu drop cap refs %s ret %x\n",
-		     inode, off, ceph_cap_string(got), ret);
+		doutc(cl, "%llx.%llx %llu drop cap refs %s ret %x\n",
+		      ceph_vinop(inode), off, ceph_cap_string(got), ret);
 	} else
 		err = -EAGAIN;
 
@@ -1667,8 +1691,8 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
 out_inline:
 		filemap_invalidate_unlock_shared(mapping);
-		dout("filemap_fault %p %llu read inline data ret %x\n",
-		     inode, off, ret);
+		doutc(cl, "%llx.%llx %llu read inline data ret %x\n",
+		      ceph_vinop(inode), off, ret);
 	}
 out_restore:
 	ceph_restore_sigs(&oldset);
@@ -1682,6 +1706,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_info *fi = vma->vm_file->private_data;
 	struct ceph_cap_flush *prealloc_cf;
@@ -1708,8 +1733,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	else
 		len = offset_in_thp(page, size);
 
-	dout("page_mkwrite %p %llx.%llx %llu~%zd getting caps i_size %llu\n",
-	     inode, ceph_vinop(inode), off, len, size);
+	doutc(cl, "%llx.%llx %llu~%zd getting caps i_size %llu\n",
+	      ceph_vinop(inode), off, len, size);
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
 	else
@@ -1720,8 +1745,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	if (err < 0)
 		goto out_free;
 
-	dout("page_mkwrite %p %llu~%zd got cap refs on %s\n",
-	     inode, off, len, ceph_cap_string(got));
+	doutc(cl, "%llx.%llx %llu~%zd got cap refs on %s\n", ceph_vinop(inode),
+	      off, len, ceph_cap_string(got));
 
 	/* Update time before taking page lock */
 	file_update_time(vma->vm_file);
@@ -1769,8 +1794,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 			__mark_inode_dirty(inode, dirty);
 	}
 
-	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %x\n",
-	     inode, off, len, ceph_cap_string(got), ret);
+	doutc(cl, "%llx.%llx %llu~%zd dropping cap refs on %s ret %x\n",
+	      ceph_vinop(inode), off, len, ceph_cap_string(got), ret);
 	ceph_put_cap_refs_async(ci, got);
 out_free:
 	ceph_restore_sigs(&oldset);
@@ -1784,6 +1809,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 			   char	*data, size_t len)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
 
@@ -1804,8 +1830,8 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 		}
 	}
 
-	dout("fill_inline_data %p %llx.%llx len %zu locked_page %p\n",
-	     inode, ceph_vinop(inode), len, locked_page);
+	doutc(cl, "%p %llx.%llx len %zu locked_page %p\n", inode,
+	      ceph_vinop(inode), len, locked_page);
 
 	if (len > 0) {
 		void *kaddr = kmap_atomic(page);
@@ -1830,6 +1856,7 @@ int ceph_uninline_data(struct file *file)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_request *req = NULL;
 	struct ceph_cap_flush *prealloc_cf = NULL;
 	struct folio *folio = NULL;
@@ -1842,8 +1869,8 @@ int ceph_uninline_data(struct file *file)
 	inline_version = ci->i_inline_version;
 	spin_unlock(&ci->i_ceph_lock);
 
-	dout("uninline_data %p %llx.%llx inline_version %llu\n",
-	     inode, ceph_vinop(inode), inline_version);
+	doutc(cl, "%llx.%llx inline_version %llu\n", ceph_vinop(inode),
+	      inline_version);
 
 	if (ceph_inode_is_shutdown(inode)) {
 		err = -EIO;
@@ -1955,8 +1982,8 @@ int ceph_uninline_data(struct file *file)
 	}
 out:
 	ceph_free_cap_flush(prealloc_cf);
-	dout("uninline_data %p %llx.%llx inline_version %llu = %d\n",
-	     inode, ceph_vinop(inode), inline_version, err);
+	doutc(cl, "%llx.%llx inline_version %llu = %d\n",
+	      ceph_vinop(inode), inline_version, err);
 	return err;
 }
 
@@ -1985,6 +2012,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(&ci->netfs.inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
+	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_request *rd_req = NULL, *wr_req = NULL;
 	struct rb_node **p, *parent;
 	struct ceph_pool_perm *perm;
@@ -2019,10 +2047,10 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 		goto out;
 
 	if (pool_ns)
-		dout("__ceph_pool_perm_get pool %lld ns %.*s no perm cached\n",
-		     pool, (int)pool_ns->len, pool_ns->str);
+		doutc(cl, "pool %lld ns %.*s no perm cached\n", pool,
+		      (int)pool_ns->len, pool_ns->str);
 	else
-		dout("__ceph_pool_perm_get pool %lld no perm cached\n", pool);
+		doutc(cl, "pool %lld no perm cached\n", pool);
 
 	down_write(&mdsc->pool_perm_rwsem);
 	p = &mdsc->pool_perm_tree.rb_node;
@@ -2147,15 +2175,16 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 	if (!err)
 		err = have;
 	if (pool_ns)
-		dout("__ceph_pool_perm_get pool %lld ns %.*s result = %d\n",
-		     pool, (int)pool_ns->len, pool_ns->str, err);
+		doutc(cl, "pool %lld ns %.*s result = %d\n", pool,
+		      (int)pool_ns->len, pool_ns->str, err);
 	else
-		dout("__ceph_pool_perm_get pool %lld result = %d\n", pool, err);
+		doutc(cl, "pool %lld result = %d\n", pool, err);
 	return err;
 }
 
 int ceph_pool_perm_check(struct inode *inode, int need)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_string *pool_ns;
 	s64 pool;
@@ -2185,13 +2214,11 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 check:
 	if (flags & CEPH_I_POOL_PERM) {
 		if ((need & CEPH_CAP_FILE_RD) && !(flags & CEPH_I_POOL_RD)) {
-			dout("ceph_pool_perm_check pool %lld no read perm\n",
-			     pool);
+			doutc(cl, "pool %lld no read perm\n", pool);
 			return -EPERM;
 		}
 		if ((need & CEPH_CAP_FILE_WR) && !(flags & CEPH_I_POOL_WR)) {
-			dout("ceph_pool_perm_check pool %lld no write perm\n",
-			     pool);
+			doutc(cl, "pool %lld no write perm\n", pool);
 			return -EPERM;
 		}
 		return 0;
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 00045b8eadd1..a0e3f51b5d02 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -186,10 +186,10 @@ static void __ceph_unreserve_caps(struct ceph_mds_client *mdsc, int nr_caps)
 			mdsc->caps_avail_count += nr_caps;
 		}
 
-		dout("%s: caps %d = %d used + %d resv + %d avail\n",
-		     __func__,
-		     mdsc->caps_total_count, mdsc->caps_use_count,
-		     mdsc->caps_reserve_count, mdsc->caps_avail_count);
+		doutc(mdsc->fsc->client,
+		      "caps %d = %d used + %d resv + %d avail\n",
+		      mdsc->caps_total_count, mdsc->caps_use_count,
+		      mdsc->caps_reserve_count, mdsc->caps_avail_count);
 		BUG_ON(mdsc->caps_total_count != mdsc->caps_use_count +
 						 mdsc->caps_reserve_count +
 						 mdsc->caps_avail_count);
@@ -202,6 +202,7 @@ static void __ceph_unreserve_caps(struct ceph_mds_client *mdsc, int nr_caps)
 int ceph_reserve_caps(struct ceph_mds_client *mdsc,
 		      struct ceph_cap_reservation *ctx, int need)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	int i, j;
 	struct ceph_cap *cap;
 	int have;
@@ -212,7 +213,7 @@ int ceph_reserve_caps(struct ceph_mds_client *mdsc,
 	struct ceph_mds_session *s;
 	LIST_HEAD(newcaps);
 
-	dout("reserve caps ctx=%p need=%d\n", ctx, need);
+	doutc(cl, "ctx=%p need=%d\n", ctx, need);
 
 	/* first reserve any caps that are already allocated */
 	spin_lock(&mdsc->caps_list_lock);
@@ -272,8 +273,8 @@ int ceph_reserve_caps(struct ceph_mds_client *mdsc,
 			continue;
 		}
 
-		pr_warn("reserve caps ctx=%p ENOMEM need=%d got=%d\n",
-			ctx, need, have + alloc);
+		pr_warn_client(cl, "ctx=%p ENOMEM need=%d got=%d\n", ctx, need,
+			       have + alloc);
 		err = -ENOMEM;
 		break;
 	}
@@ -298,20 +299,21 @@ int ceph_reserve_caps(struct ceph_mds_client *mdsc,
 
 	spin_unlock(&mdsc->caps_list_lock);
 
-	dout("reserve caps ctx=%p %d = %d used + %d resv + %d avail\n",
-	     ctx, mdsc->caps_total_count, mdsc->caps_use_count,
-	     mdsc->caps_reserve_count, mdsc->caps_avail_count);
+	doutc(cl, "ctx=%p %d = %d used + %d resv + %d avail\n", ctx,
+	      mdsc->caps_total_count, mdsc->caps_use_count,
+	      mdsc->caps_reserve_count, mdsc->caps_avail_count);
 	return err;
 }
 
 void ceph_unreserve_caps(struct ceph_mds_client *mdsc,
 			 struct ceph_cap_reservation *ctx)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	bool reclaim = false;
 	if (!ctx->count)
 		return;
 
-	dout("unreserve caps ctx=%p count=%d\n", ctx, ctx->count);
+	doutc(cl, "ctx=%p count=%d\n", ctx, ctx->count);
 	spin_lock(&mdsc->caps_list_lock);
 	__ceph_unreserve_caps(mdsc, ctx->count);
 	ctx->count = 0;
@@ -328,6 +330,7 @@ void ceph_unreserve_caps(struct ceph_mds_client *mdsc,
 struct ceph_cap *ceph_get_cap(struct ceph_mds_client *mdsc,
 			      struct ceph_cap_reservation *ctx)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_cap *cap = NULL;
 
 	/* temporary, until we do something about cap import/export */
@@ -359,9 +362,9 @@ struct ceph_cap *ceph_get_cap(struct ceph_mds_client *mdsc,
 	}
 
 	spin_lock(&mdsc->caps_list_lock);
-	dout("get_cap ctx=%p (%d) %d = %d used + %d resv + %d avail\n",
-	     ctx, ctx->count, mdsc->caps_total_count, mdsc->caps_use_count,
-	     mdsc->caps_reserve_count, mdsc->caps_avail_count);
+	doutc(cl, "ctx=%p (%d) %d = %d used + %d resv + %d avail\n", ctx,
+	      ctx->count, mdsc->caps_total_count, mdsc->caps_use_count,
+	      mdsc->caps_reserve_count, mdsc->caps_avail_count);
 	BUG_ON(!ctx->count);
 	BUG_ON(ctx->count > mdsc->caps_reserve_count);
 	BUG_ON(list_empty(&mdsc->caps_list));
@@ -382,10 +385,12 @@ struct ceph_cap *ceph_get_cap(struct ceph_mds_client *mdsc,
 
 void ceph_put_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
+
 	spin_lock(&mdsc->caps_list_lock);
-	dout("put_cap %p %d = %d used + %d resv + %d avail\n",
-	     cap, mdsc->caps_total_count, mdsc->caps_use_count,
-	     mdsc->caps_reserve_count, mdsc->caps_avail_count);
+	doutc(cl, "%p %d = %d used + %d resv + %d avail\n", cap,
+	      mdsc->caps_total_count, mdsc->caps_use_count,
+	      mdsc->caps_reserve_count, mdsc->caps_avail_count);
 	mdsc->caps_use_count--;
 	/*
 	 * Keep some preallocated caps around (ceph_min_count), to
@@ -491,11 +496,13 @@ static void __insert_cap_node(struct ceph_inode_info *ci,
 static void __cap_set_timeouts(struct ceph_mds_client *mdsc,
 			       struct ceph_inode_info *ci)
 {
+	struct inode *inode = &ci->netfs.inode;
 	struct ceph_mount_options *opt = mdsc->fsc->mount_options;
+
 	ci->i_hold_caps_max = round_jiffies(jiffies +
 					    opt->caps_wanted_delay_max * HZ);
-	dout("__cap_set_timeouts %p %lu\n", &ci->netfs.inode,
-	     ci->i_hold_caps_max - jiffies);
+	doutc(mdsc->fsc->client, "%p %llx.%llx %lu\n", inode,
+	      ceph_vinop(inode), ci->i_hold_caps_max - jiffies);
 }
 
 /*
@@ -509,8 +516,11 @@ static void __cap_set_timeouts(struct ceph_mds_client *mdsc,
 static void __cap_delay_requeue(struct ceph_mds_client *mdsc,
 				struct ceph_inode_info *ci)
 {
-	dout("__cap_delay_requeue %p flags 0x%lx at %lu\n", &ci->netfs.inode,
-	     ci->i_ceph_flags, ci->i_hold_caps_max);
+	struct inode *inode = &ci->netfs.inode;
+
+	doutc(mdsc->fsc->client, "%p %llx.%llx flags 0x%lx at %lu\n",
+	      inode, ceph_vinop(inode), ci->i_ceph_flags,
+	      ci->i_hold_caps_max);
 	if (!mdsc->stopping) {
 		spin_lock(&mdsc->cap_delay_lock);
 		if (!list_empty(&ci->i_cap_delay_list)) {
@@ -533,7 +543,9 @@ static void __cap_delay_requeue(struct ceph_mds_client *mdsc,
 static void __cap_delay_requeue_front(struct ceph_mds_client *mdsc,
 				      struct ceph_inode_info *ci)
 {
-	dout("__cap_delay_requeue_front %p\n", &ci->netfs.inode);
+	struct inode *inode = &ci->netfs.inode;
+
+	doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	spin_lock(&mdsc->cap_delay_lock);
 	ci->i_ceph_flags |= CEPH_I_FLUSH;
 	if (!list_empty(&ci->i_cap_delay_list))
@@ -550,7 +562,9 @@ static void __cap_delay_requeue_front(struct ceph_mds_client *mdsc,
 static void __cap_delay_cancel(struct ceph_mds_client *mdsc,
 			       struct ceph_inode_info *ci)
 {
-	dout("__cap_delay_cancel %p\n", &ci->netfs.inode);
+	struct inode *inode = &ci->netfs.inode;
+
+	doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	if (list_empty(&ci->i_cap_delay_list))
 		return;
 	spin_lock(&mdsc->cap_delay_lock);
@@ -562,6 +576,9 @@ static void __cap_delay_cancel(struct ceph_mds_client *mdsc,
 static void __check_cap_issue(struct ceph_inode_info *ci, struct ceph_cap *cap,
 			      unsigned issued)
 {
+	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+
 	unsigned had = __ceph_caps_issued(ci, NULL);
 
 	lockdep_assert_held(&ci->i_ceph_lock);
@@ -586,7 +603,7 @@ static void __check_cap_issue(struct ceph_inode_info *ci, struct ceph_cap *cap,
 		if (issued & CEPH_CAP_FILE_SHARED)
 			atomic_inc(&ci->i_shared_gen);
 		if (S_ISDIR(ci->netfs.inode.i_mode)) {
-			dout(" marking %p NOT complete\n", &ci->netfs.inode);
+			doutc(cl, " marking %p NOT complete\n", inode);
 			__ceph_dir_clear_complete(ci);
 		}
 	}
@@ -636,6 +653,7 @@ void ceph_add_cap(struct inode *inode,
 		  struct ceph_cap **new_cap)
 {
 	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_cap *cap;
 	int mds = session->s_mds;
@@ -644,8 +662,9 @@ void ceph_add_cap(struct inode *inode,
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	dout("add_cap %p mds%d cap %llx %s seq %d\n", inode,
-	     session->s_mds, cap_id, ceph_cap_string(issued), seq);
+	doutc(cl, "%p %llx.%llx mds%d cap %llx %s seq %d\n", inode,
+	      ceph_vinop(inode), session->s_mds, cap_id,
+	      ceph_cap_string(issued), seq);
 
 	gen = atomic_read(&session->s_cap_gen);
 
@@ -723,9 +742,9 @@ void ceph_add_cap(struct inode *inode,
 	actual_wanted = __ceph_caps_wanted(ci);
 	if ((wanted & ~actual_wanted) ||
 	    (issued & ~actual_wanted & CEPH_CAP_ANY_WR)) {
-		dout(" issued %s, mds wanted %s, actual %s, queueing\n",
-		     ceph_cap_string(issued), ceph_cap_string(wanted),
-		     ceph_cap_string(actual_wanted));
+		doutc(cl, "issued %s, mds wanted %s, actual %s, queueing\n",
+		      ceph_cap_string(issued), ceph_cap_string(wanted),
+		      ceph_cap_string(actual_wanted));
 		__cap_delay_requeue(mdsc, ci);
 	}
 
@@ -742,9 +761,9 @@ void ceph_add_cap(struct inode *inode,
 		WARN_ON(ci->i_auth_cap == cap);
 	}
 
-	dout("add_cap inode %p (%llx.%llx) cap %p %s now %s seq %d mds%d\n",
-	     inode, ceph_vinop(inode), cap, ceph_cap_string(issued),
-	     ceph_cap_string(issued|cap->issued), seq, mds);
+	doutc(cl, "inode %p %llx.%llx cap %p %s now %s seq %d mds%d\n",
+	      inode, ceph_vinop(inode), cap, ceph_cap_string(issued),
+	      ceph_cap_string(issued|cap->issued), seq, mds);
 	cap->cap_id = cap_id;
 	cap->issued = issued;
 	cap->implemented |= issued;
@@ -766,6 +785,8 @@ void ceph_add_cap(struct inode *inode,
  */
 static int __cap_is_valid(struct ceph_cap *cap)
 {
+	struct inode *inode = &cap->ci->netfs.inode;
+	struct ceph_client *cl = cap->session->s_mdsc->fsc->client;
 	unsigned long ttl;
 	u32 gen;
 
@@ -773,9 +794,9 @@ static int __cap_is_valid(struct ceph_cap *cap)
 	ttl = cap->session->s_cap_ttl;
 
 	if (cap->cap_gen < gen || time_after_eq(jiffies, ttl)) {
-		dout("__cap_is_valid %p cap %p issued %s "
-		     "but STALE (gen %u vs %u)\n", &cap->ci->netfs.inode,
-		     cap, ceph_cap_string(cap->issued), cap->cap_gen, gen);
+		doutc(cl, "%p %llx.%llx cap %p issued %s but STALE (gen %u vs %u)\n",
+		      inode, ceph_vinop(inode), cap,
+		      ceph_cap_string(cap->issued), cap->cap_gen, gen);
 		return 0;
 	}
 
@@ -789,6 +810,8 @@ static int __cap_is_valid(struct ceph_cap *cap)
  */
 int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented)
 {
+	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int have = ci->i_snap_caps;
 	struct ceph_cap *cap;
 	struct rb_node *p;
@@ -799,8 +822,8 @@ int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented)
 		cap = rb_entry(p, struct ceph_cap, ci_node);
 		if (!__cap_is_valid(cap))
 			continue;
-		dout("__ceph_caps_issued %p cap %p issued %s\n",
-		     &ci->netfs.inode, cap, ceph_cap_string(cap->issued));
+		doutc(cl, "%p %llx.%llx cap %p issued %s\n", inode,
+		      ceph_vinop(inode), cap, ceph_cap_string(cap->issued));
 		have |= cap->issued;
 		if (implemented)
 			*implemented |= cap->implemented;
@@ -843,16 +866,18 @@ int __ceph_caps_issued_other(struct ceph_inode_info *ci, struct ceph_cap *ocap)
  */
 static void __touch_cap(struct ceph_cap *cap)
 {
+	struct inode *inode = &cap->ci->netfs.inode;
 	struct ceph_mds_session *s = cap->session;
+	struct ceph_client *cl = s->s_mdsc->fsc->client;
 
 	spin_lock(&s->s_cap_lock);
 	if (!s->s_cap_iterator) {
-		dout("__touch_cap %p cap %p mds%d\n", &cap->ci->netfs.inode, cap,
-		     s->s_mds);
+		doutc(cl, "%p %llx.%llx cap %p mds%d\n", inode,
+		      ceph_vinop(inode), cap, s->s_mds);
 		list_move_tail(&cap->session_caps, &s->s_caps);
 	} else {
-		dout("__touch_cap %p cap %p mds%d NOP, iterating over caps\n",
-		     &cap->ci->netfs.inode, cap, s->s_mds);
+		doutc(cl, "%p %llx.%llx cap %p mds%d NOP, iterating over caps\n",
+		      inode, ceph_vinop(inode), cap, s->s_mds);
 	}
 	spin_unlock(&s->s_cap_lock);
 }
@@ -864,15 +889,16 @@ static void __touch_cap(struct ceph_cap *cap)
  */
 int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 {
+	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_cap *cap;
 	struct rb_node *p;
 	int have = ci->i_snap_caps;
 
 	if ((have & mask) == mask) {
-		dout("__ceph_caps_issued_mask ino 0x%llx snap issued %s"
-		     " (mask %s)\n", ceph_ino(&ci->netfs.inode),
-		     ceph_cap_string(have),
-		     ceph_cap_string(mask));
+		doutc(cl, "mask %p %llx.%llx snap issued %s (mask %s)\n",
+		      inode, ceph_vinop(inode), ceph_cap_string(have),
+		      ceph_cap_string(mask));
 		return 1;
 	}
 
@@ -881,10 +907,10 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 		if (!__cap_is_valid(cap))
 			continue;
 		if ((cap->issued & mask) == mask) {
-			dout("__ceph_caps_issued_mask ino 0x%llx cap %p issued %s"
-			     " (mask %s)\n", ceph_ino(&ci->netfs.inode), cap,
-			     ceph_cap_string(cap->issued),
-			     ceph_cap_string(mask));
+			doutc(cl, "mask %p %llx.%llx cap %p issued %s (mask %s)\n",
+			      inode, ceph_vinop(inode), cap,
+			      ceph_cap_string(cap->issued),
+			      ceph_cap_string(mask));
 			if (touch)
 				__touch_cap(cap);
 			return 1;
@@ -893,10 +919,10 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 		/* does a combination of caps satisfy mask? */
 		have |= cap->issued;
 		if ((have & mask) == mask) {
-			dout("__ceph_caps_issued_mask ino 0x%llx combo issued %s"
-			     " (mask %s)\n", ceph_ino(&ci->netfs.inode),
-			     ceph_cap_string(cap->issued),
-			     ceph_cap_string(mask));
+			doutc(cl, "mask %p %llx.%llx combo issued %s (mask %s)\n",
+			      inode, ceph_vinop(inode),
+			      ceph_cap_string(cap->issued),
+			      ceph_cap_string(mask));
 			if (touch) {
 				struct rb_node *q;
 
@@ -954,13 +980,14 @@ int __ceph_caps_revoking_other(struct ceph_inode_info *ci,
 int ceph_caps_revoking(struct ceph_inode_info *ci, int mask)
 {
 	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int ret;
 
 	spin_lock(&ci->i_ceph_lock);
 	ret = __ceph_caps_revoking_other(ci, NULL, mask);
 	spin_unlock(&ci->i_ceph_lock);
-	dout("ceph_caps_revoking %p %s = %d\n", inode,
-	     ceph_cap_string(mask), ret);
+	doutc(cl, "%p %llx.%llx %s = %d\n", inode, ceph_vinop(inode),
+	      ceph_cap_string(mask), ret);
 	return ret;
 }
 
@@ -1107,19 +1134,21 @@ int ceph_is_any_caps(struct inode *inode)
 void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 {
 	struct ceph_mds_session *session = cap->session;
+	struct ceph_client *cl = session->s_mdsc->fsc->client;
 	struct ceph_inode_info *ci = cap->ci;
+	struct inode *inode = &ci->netfs.inode;
 	struct ceph_mds_client *mdsc;
 	int removed = 0;
 
 	/* 'ci' being NULL means the remove have already occurred */
 	if (!ci) {
-		dout("%s: cap inode is NULL\n", __func__);
+		doutc(cl, "inode is NULL\n");
 		return;
 	}
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	dout("__ceph_remove_cap %p from %p\n", cap, &ci->netfs.inode);
+	doutc(cl, "%p from %p %llx.%llx\n", cap, inode, ceph_vinop(inode));
 
 	mdsc = ceph_inode_to_fs_client(&ci->netfs.inode)->mdsc;
 
@@ -1132,8 +1161,8 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	spin_lock(&session->s_cap_lock);
 	if (session->s_cap_iterator == cap) {
 		/* not yet, we are iterating over this very cap */
-		dout("__ceph_remove_cap  delaying %p removal from session %p\n",
-		     cap, cap->session);
+		doutc(cl, "delaying %p removal from session %p\n", cap,
+		      cap->session);
 	} else {
 		list_del_init(&cap->session_caps);
 		session->s_nr_caps--;
@@ -1186,7 +1215,7 @@ void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 
 	/* 'ci' being NULL means the remove have already occurred */
 	if (!ci) {
-		dout("%s: cap inode is NULL\n", __func__);
+		doutc(mdsc->fsc->client, "inode is NULL\n");
 		return;
 	}
 
@@ -1228,15 +1257,19 @@ static void encode_cap_msg(struct ceph_msg *msg, struct cap_msg_args *arg)
 {
 	struct ceph_mds_caps *fc;
 	void *p;
-	struct ceph_osd_client *osdc = &arg->session->s_mdsc->fsc->client->osdc;
-
-	dout("%s %s %llx %llx caps %s wanted %s dirty %s seq %u/%u tid %llu/%llu mseq %u follows %lld size %llu/%llu xattr_ver %llu xattr_len %d\n",
-	     __func__, ceph_cap_op_name(arg->op), arg->cid, arg->ino,
-	     ceph_cap_string(arg->caps), ceph_cap_string(arg->wanted),
-	     ceph_cap_string(arg->dirty), arg->seq, arg->issue_seq,
-	     arg->flush_tid, arg->oldest_flush_tid, arg->mseq, arg->follows,
-	     arg->size, arg->max_size, arg->xattr_version,
-	     arg->xattr_buf ? (int)arg->xattr_buf->vec.iov_len : 0);
+	struct ceph_mds_client *mdsc = arg->session->s_mdsc;
+	struct ceph_osd_client *osdc = &mdsc->fsc->client->osdc;
+
+	doutc(mdsc->fsc->client,
+	      "%s %llx %llx caps %s wanted %s dirty %s seq %u/%u"
+	      " tid %llu/%llu mseq %u follows %lld size %llu/%llu"
+	      " xattr_ver %llu xattr_len %d\n",
+	      ceph_cap_op_name(arg->op), arg->cid, arg->ino,
+	      ceph_cap_string(arg->caps), ceph_cap_string(arg->wanted),
+	      ceph_cap_string(arg->dirty), arg->seq, arg->issue_seq,
+	      arg->flush_tid, arg->oldest_flush_tid, arg->mseq, arg->follows,
+	      arg->size, arg->max_size, arg->xattr_version,
+	      arg->xattr_buf ? (int)arg->xattr_buf->vec.iov_len : 0);
 
 	msg->hdr.version = cpu_to_le16(12);
 	msg->hdr.tid = cpu_to_le64(arg->flush_tid);
@@ -1373,6 +1406,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 {
 	struct ceph_inode_info *ci = cap->ci;
 	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int held, revoking;
 
 	lockdep_assert_held(&ci->i_ceph_lock);
@@ -1381,10 +1415,10 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	revoking = cap->implemented & ~cap->issued;
 	retain &= ~revoking;
 
-	dout("%s %p cap %p session %p %s -> %s (revoking %s)\n",
-	     __func__, inode, cap, cap->session,
-	     ceph_cap_string(held), ceph_cap_string(held & retain),
-	     ceph_cap_string(revoking));
+	doutc(cl, "%p %llx.%llx cap %p session %p %s -> %s (revoking %s)\n",
+	      inode, ceph_vinop(inode), cap, cap->session,
+	      ceph_cap_string(held), ceph_cap_string(held & retain),
+	      ceph_cap_string(revoking));
 	BUG_ON((retain & CEPH_CAP_PIN) == 0);
 
 	ci->i_ceph_flags &= ~CEPH_I_FLUSH;
@@ -1500,13 +1534,16 @@ static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci)
 {
 	struct ceph_msg *msg;
 	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, cap_msg_size(arg), GFP_NOFS,
 			   false);
 	if (!msg) {
-		pr_err("error allocating cap msg: ino (%llx.%llx) flushing %s tid %llu, requeuing cap.\n",
-		       ceph_vinop(inode), ceph_cap_string(arg->dirty),
-		       arg->flush_tid);
+		pr_err_client(cl,
+			      "error allocating cap msg: ino (%llx.%llx)"
+			      " flushing %s tid %llu, requeuing cap.\n",
+			      ceph_vinop(inode), ceph_cap_string(arg->dirty),
+			      arg->flush_tid);
 		spin_lock(&ci->i_ceph_lock);
 		__cap_delay_requeue(arg->session->s_mdsc, ci);
 		spin_unlock(&ci->i_ceph_lock);
@@ -1596,11 +1633,13 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 {
 	struct inode *inode = &ci->netfs.inode;
 	struct ceph_mds_client *mdsc = session->s_mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_cap_snap *capsnap;
 	u64 oldest_flush_tid = 0;
 	u64 first_tid = 1, last_tid = 0;
 
-	dout("__flush_snaps %p session %p\n", inode, session);
+	doutc(cl, "%p %llx.%llx session %p\n", inode, ceph_vinop(inode),
+	      session);
 
 	list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
 		/*
@@ -1615,7 +1654,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 
 		/* only flush each capsnap once */
 		if (capsnap->cap_flush.tid > 0) {
-			dout(" already flushed %p, skipping\n", capsnap);
+			doutc(cl, "already flushed %p, skipping\n", capsnap);
 			continue;
 		}
 
@@ -1647,8 +1686,8 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 		int ret;
 
 		if (!(cap && cap->session == session)) {
-			dout("__flush_snaps %p auth cap %p not mds%d, "
-			     "stop\n", inode, cap, session->s_mds);
+			doutc(cl, "%p %llx.%llx auth cap %p not mds%d, stop\n",
+			      inode, ceph_vinop(inode), cap, session->s_mds);
 			break;
 		}
 
@@ -1669,15 +1708,17 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 		refcount_inc(&capsnap->nref);
 		spin_unlock(&ci->i_ceph_lock);
 
-		dout("__flush_snaps %p capsnap %p tid %llu %s\n",
-		     inode, capsnap, cf->tid, ceph_cap_string(capsnap->dirty));
+		doutc(cl, "%p %llx.%llx capsnap %p tid %llu %s\n", inode,
+		      ceph_vinop(inode), capsnap, cf->tid,
+		      ceph_cap_string(capsnap->dirty));
 
 		ret = __send_flush_snap(inode, session, capsnap, cap->mseq,
 					oldest_flush_tid);
 		if (ret < 0) {
-			pr_err("__flush_snaps: error sending cap flushsnap, "
-			       "ino (%llx.%llx) tid %llu follows %llu\n",
-				ceph_vinop(inode), cf->tid, capsnap->follows);
+			pr_err_client(cl, "error sending cap flushsnap, "
+				      "ino (%llx.%llx) tid %llu follows %llu\n",
+				      ceph_vinop(inode), cf->tid,
+				      capsnap->follows);
 		}
 
 		ceph_put_cap_snap(capsnap);
@@ -1690,27 +1731,28 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 {
 	struct inode *inode = &ci->netfs.inode;
 	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_mds_session *session = NULL;
 	bool need_put = false;
 	int mds;
 
-	dout("ceph_flush_snaps %p\n", inode);
+	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	if (psession)
 		session = *psession;
 retry:
 	spin_lock(&ci->i_ceph_lock);
 	if (!(ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS)) {
-		dout(" no capsnap needs flush, doing nothing\n");
+		doutc(cl, " no capsnap needs flush, doing nothing\n");
 		goto out;
 	}
 	if (!ci->i_auth_cap) {
-		dout(" no auth cap (migrating?), doing nothing\n");
+		doutc(cl, " no auth cap (migrating?), doing nothing\n");
 		goto out;
 	}
 
 	mds = ci->i_auth_cap->session->s_mds;
 	if (session && session->s_mds != mds) {
-		dout(" oops, wrong session %p mutex\n", session);
+		doutc(cl, " oops, wrong session %p mutex\n", session);
 		ceph_put_mds_session(session);
 		session = NULL;
 	}
@@ -1756,21 +1798,23 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask,
 	struct ceph_mds_client *mdsc =
 		ceph_sb_to_fs_client(ci->netfs.inode.i_sb)->mdsc;
 	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int was = ci->i_dirty_caps;
 	int dirty = 0;
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
 	if (!ci->i_auth_cap) {
-		pr_warn("__mark_dirty_caps %p %llx mask %s, "
-			"but no auth cap (session was closed?)\n",
-			inode, ceph_ino(inode), ceph_cap_string(mask));
+		pr_warn_client(cl, "%p %llx.%llx mask %s, "
+			       "but no auth cap (session was closed?)\n",
+				inode, ceph_vinop(inode),
+				ceph_cap_string(mask));
 		return 0;
 	}
 
-	dout("__mark_dirty_caps %p %s dirty %s -> %s\n", &ci->netfs.inode,
-	     ceph_cap_string(mask), ceph_cap_string(was),
-	     ceph_cap_string(was | mask));
+	doutc(cl, "%p %llx.%llx %s dirty %s -> %s\n", inode,
+	      ceph_vinop(inode), ceph_cap_string(mask),
+	      ceph_cap_string(was), ceph_cap_string(was | mask));
 	ci->i_dirty_caps |= mask;
 	if (was == 0) {
 		struct ceph_mds_session *session = ci->i_auth_cap->session;
@@ -1783,8 +1827,9 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask,
 			ci->i_head_snapc = ceph_get_snap_context(
 				ci->i_snap_realm->cached_context);
 		}
-		dout(" inode %p now dirty snapc %p auth cap %p\n",
-		     &ci->netfs.inode, ci->i_head_snapc, ci->i_auth_cap);
+		doutc(cl, "%p %llx.%llx now dirty snapc %p auth cap %p\n",
+		      inode, ceph_vinop(inode), ci->i_head_snapc,
+		      ci->i_auth_cap);
 		BUG_ON(!list_empty(&ci->i_dirty_item));
 		spin_lock(&mdsc->cap_dirty_lock);
 		list_add(&ci->i_dirty_item, &session->s_cap_dirty);
@@ -1878,6 +1923,7 @@ static u64 __mark_caps_flushing(struct inode *inode,
 				u64 *oldest_flush_tid)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_cap_flush *cf = NULL;
 	int flushing;
@@ -1888,13 +1934,13 @@ static u64 __mark_caps_flushing(struct inode *inode,
 	BUG_ON(!ci->i_prealloc_cap_flush);
 
 	flushing = ci->i_dirty_caps;
-	dout("__mark_caps_flushing flushing %s, flushing_caps %s -> %s\n",
-	     ceph_cap_string(flushing),
-	     ceph_cap_string(ci->i_flushing_caps),
-	     ceph_cap_string(ci->i_flushing_caps | flushing));
+	doutc(cl, "flushing %s, flushing_caps %s -> %s\n",
+	      ceph_cap_string(flushing),
+	      ceph_cap_string(ci->i_flushing_caps),
+	      ceph_cap_string(ci->i_flushing_caps | flushing));
 	ci->i_flushing_caps |= flushing;
 	ci->i_dirty_caps = 0;
-	dout(" inode %p now !dirty\n", inode);
+	doutc(cl, "%p %llx.%llx now !dirty\n", inode, ceph_vinop(inode));
 
 	swap(cf, ci->i_prealloc_cap_flush);
 	cf->caps = flushing;
@@ -1925,6 +1971,7 @@ static int try_nonblocking_invalidate(struct inode *inode)
 	__releases(ci->i_ceph_lock)
 	__acquires(ci->i_ceph_lock)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u32 invalidating_gen = ci->i_rdcache_gen;
 
@@ -1936,12 +1983,13 @@ static int try_nonblocking_invalidate(struct inode *inode)
 	if (inode->i_data.nrpages == 0 &&
 	    invalidating_gen == ci->i_rdcache_gen) {
 		/* success. */
-		dout("try_nonblocking_invalidate %p success\n", inode);
+		doutc(cl, "%p %llx.%llx success\n", inode,
+		      ceph_vinop(inode));
 		/* save any racing async invalidate some trouble */
 		ci->i_rdcache_revoking = ci->i_rdcache_gen - 1;
 		return 0;
 	}
-	dout("try_nonblocking_invalidate %p failed\n", inode);
+	doutc(cl, "%p %llx.%llx failed\n", inode, ceph_vinop(inode));
 	return -1;
 }
 
@@ -1973,6 +2021,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 {
 	struct inode *inode = &ci->netfs.inode;
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_cap *cap;
 	u64 flush_tid, oldest_flush_tid;
 	int file_wanted, used, cap_used;
@@ -2047,9 +2096,9 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 		}
 	}
 
-	dout("check_caps %llx.%llx file_want %s used %s dirty %s flushing %s"
-	     " issued %s revoking %s retain %s %s%s%s\n", ceph_vinop(inode),
-	     ceph_cap_string(file_wanted),
+	doutc(cl, "%p %llx.%llx file_want %s used %s dirty %s "
+	      "flushing %s issued %s revoking %s retain %s %s%s%s\n",
+	     inode, ceph_vinop(inode), ceph_cap_string(file_wanted),
 	     ceph_cap_string(used), ceph_cap_string(ci->i_dirty_caps),
 	     ceph_cap_string(ci->i_flushing_caps),
 	     ceph_cap_string(issued), ceph_cap_string(revoking),
@@ -2070,10 +2119,10 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 	    (revoking & (CEPH_CAP_FILE_CACHE|
 			 CEPH_CAP_FILE_LAZYIO)) && /*  or revoking cache */
 	    !tried_invalidate) {
-		dout("check_caps trying to invalidate on %llx.%llx\n",
-		     ceph_vinop(inode));
+		doutc(cl, "trying to invalidate on %p %llx.%llx\n",
+		      inode, ceph_vinop(inode));
 		if (try_nonblocking_invalidate(inode) < 0) {
-			dout("check_caps queuing invalidate\n");
+			doutc(cl, "queuing invalidate\n");
 			queue_invalidate = true;
 			ci->i_rdcache_revoking = ci->i_rdcache_gen;
 		}
@@ -2101,35 +2150,35 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 			cap_used &= ~ci->i_auth_cap->issued;
 
 		revoking = cap->implemented & ~cap->issued;
-		dout(" mds%d cap %p used %s issued %s implemented %s revoking %s\n",
-		     cap->mds, cap, ceph_cap_string(cap_used),
-		     ceph_cap_string(cap->issued),
-		     ceph_cap_string(cap->implemented),
-		     ceph_cap_string(revoking));
+		doutc(cl, " mds%d cap %p used %s issued %s implemented %s revoking %s\n",
+		      cap->mds, cap, ceph_cap_string(cap_used),
+		      ceph_cap_string(cap->issued),
+		      ceph_cap_string(cap->implemented),
+		      ceph_cap_string(revoking));
 
 		if (cap == ci->i_auth_cap &&
 		    (cap->issued & CEPH_CAP_FILE_WR)) {
 			/* request larger max_size from MDS? */
 			if (ci->i_wanted_max_size > ci->i_max_size &&
 			    ci->i_wanted_max_size > ci->i_requested_max_size) {
-				dout("requesting new max_size\n");
+				doutc(cl, "requesting new max_size\n");
 				goto ack;
 			}
 
 			/* approaching file_max? */
 			if (__ceph_should_report_size(ci)) {
-				dout("i_size approaching max_size\n");
+				doutc(cl, "i_size approaching max_size\n");
 				goto ack;
 			}
 		}
 		/* flush anything dirty? */
 		if (cap == ci->i_auth_cap) {
 			if ((flags & CHECK_CAPS_FLUSH) && ci->i_dirty_caps) {
-				dout("flushing dirty caps\n");
+				doutc(cl, "flushing dirty caps\n");
 				goto ack;
 			}
 			if (ci->i_ceph_flags & CEPH_I_FLUSH_SNAPS) {
-				dout("flushing snap caps\n");
+				doutc(cl, "flushing snap caps\n");
 				goto ack;
 			}
 		}
@@ -2137,7 +2186,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 		/* completed revocation? going down and there are no caps? */
 		if (revoking) {
 			if ((revoking & cap_used) == 0) {
-				dout("completed revocation of %s\n",
+				doutc(cl, "completed revocation of %s\n",
 				      ceph_cap_string(cap->implemented & ~cap->issued));
 				goto ack;
 			}
@@ -2315,6 +2364,7 @@ static int caps_are_flushed(struct inode *inode, u64 flush_tid)
 static int flush_mdlog_and_wait_inode_unsafe_requests(struct inode *inode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req1 = NULL, *req2 = NULL;
 	int ret, err = 0;
@@ -2404,8 +2454,9 @@ static int flush_mdlog_and_wait_inode_unsafe_requests(struct inode *inode)
 		kfree(sessions);
 	}
 
-	dout("%s %p wait on tid %llu %llu\n", __func__,
-	     inode, req1 ? req1->r_tid : 0ULL, req2 ? req2->r_tid : 0ULL);
+	doutc(cl, "%p %llx.%llx wait on tid %llu %llu\n", inode,
+	      ceph_vinop(inode), req1 ? req1->r_tid : 0ULL,
+	      req2 ? req2->r_tid : 0ULL);
 	if (req1) {
 		ret = !wait_for_completion_timeout(&req1->r_safe_completion,
 					ceph_timeout_jiffies(req1->r_timeout));
@@ -2431,11 +2482,13 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = file->f_mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	u64 flush_tid;
 	int ret, err;
 	int dirty;
 
-	dout("fsync %p%s\n", inode, datasync ? " datasync" : "");
+	doutc(cl, "%p %llx.%llx%s\n", inode, ceph_vinop(inode),
+	      datasync ? " datasync" : "");
 
 	ret = file_write_and_wait_range(file, start, end);
 	if (datasync)
@@ -2446,7 +2499,7 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 
 	dirty = try_flush_caps(inode, &flush_tid);
-	dout("fsync dirty caps are %s\n", ceph_cap_string(dirty));
+	doutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
 
 	err = flush_mdlog_and_wait_inode_unsafe_requests(inode);
 
@@ -2467,7 +2520,8 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (err < 0)
 		ret = err;
 out:
-	dout("fsync %p%s result=%d\n", inode, datasync ? " datasync" : "", ret);
+	doutc(cl, "%p %llx.%llx%s result=%d\n", inode, ceph_vinop(inode),
+	      datasync ? " datasync" : "", ret);
 	return ret;
 }
 
@@ -2480,12 +2534,13 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	u64 flush_tid;
 	int err = 0;
 	int dirty;
 	int wait = (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync);
 
-	dout("write_inode %p wait=%d\n", inode, wait);
+	doutc(cl, "%p %llx.%llx wait=%d\n", inode, ceph_vinop(inode), wait);
 	ceph_fscache_unpin_writeback(inode, wbc);
 	if (wait) {
 		err = ceph_wait_on_async_create(inode);
@@ -2515,6 +2570,7 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 	__acquires(ci->i_ceph_lock)
 {
 	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_cap *cap;
 	struct ceph_cap_flush *cf;
 	int ret;
@@ -2540,8 +2596,8 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 
 		cap = ci->i_auth_cap;
 		if (!(cap && cap->session == session)) {
-			pr_err("%p auth cap %p not mds%d ???\n",
-			       inode, cap, session->s_mds);
+			pr_err_client(cl, "%p auth cap %p not mds%d ???\n",
+				      inode, cap, session->s_mds);
 			break;
 		}
 
@@ -2550,8 +2606,9 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 		if (!cf->is_capsnap) {
 			struct cap_msg_args arg;
 
-			dout("kick_flushing_caps %p cap %p tid %llu %s\n",
-			     inode, cap, cf->tid, ceph_cap_string(cf->caps));
+			doutc(cl, "%p %llx.%llx cap %p tid %llu %s\n",
+			      inode, ceph_vinop(inode), cap, cf->tid,
+			      ceph_cap_string(cf->caps));
 			__prep_cap(&arg, cap, CEPH_CAP_OP_FLUSH,
 					 (cf->tid < last_snap_flush ?
 					  CEPH_CLIENT_CAPS_PENDING_CAPSNAP : 0),
@@ -2565,9 +2622,9 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 			struct ceph_cap_snap *capsnap =
 					container_of(cf, struct ceph_cap_snap,
 						    cap_flush);
-			dout("kick_flushing_caps %p capsnap %p tid %llu %s\n",
-			     inode, capsnap, cf->tid,
-			     ceph_cap_string(capsnap->dirty));
+			doutc(cl, "%p %llx.%llx capsnap %p tid %llu %s\n",
+			      inode, ceph_vinop(inode), capsnap, cf->tid,
+			      ceph_cap_string(capsnap->dirty));
 
 			refcount_inc(&capsnap->nref);
 			spin_unlock(&ci->i_ceph_lock);
@@ -2575,11 +2632,10 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 			ret = __send_flush_snap(inode, session, capsnap, cap->mseq,
 						oldest_flush_tid);
 			if (ret < 0) {
-				pr_err("kick_flushing_caps: error sending "
-					"cap flushsnap, ino (%llx.%llx) "
-					"tid %llu follows %llu\n",
-					ceph_vinop(inode), cf->tid,
-					capsnap->follows);
+				pr_err_client(cl, "error sending cap flushsnap,"
+					      " %p %llx.%llx tid %llu follows %llu\n",
+					      inode, ceph_vinop(inode), cf->tid,
+					      capsnap->follows);
 			}
 
 			ceph_put_cap_snap(capsnap);
@@ -2592,22 +2648,26 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 void ceph_early_kick_flushing_caps(struct ceph_mds_client *mdsc,
 				   struct ceph_mds_session *session)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci;
 	struct ceph_cap *cap;
 	u64 oldest_flush_tid;
 
-	dout("early_kick_flushing_caps mds%d\n", session->s_mds);
+	doutc(cl, "mds%d\n", session->s_mds);
 
 	spin_lock(&mdsc->cap_dirty_lock);
 	oldest_flush_tid = __get_oldest_flush_tid(mdsc);
 	spin_unlock(&mdsc->cap_dirty_lock);
 
 	list_for_each_entry(ci, &session->s_cap_flushing, i_flushing_item) {
+		struct inode *inode = &ci->netfs.inode;
+
 		spin_lock(&ci->i_ceph_lock);
 		cap = ci->i_auth_cap;
 		if (!(cap && cap->session == session)) {
-			pr_err("%p auth cap %p not mds%d ???\n",
-				&ci->netfs.inode, cap, session->s_mds);
+			pr_err_client(cl, "%p %llx.%llx auth cap %p not mds%d ???\n",
+				      inode, ceph_vinop(inode), cap,
+				      session->s_mds);
 			spin_unlock(&ci->i_ceph_lock);
 			continue;
 		}
@@ -2640,24 +2700,28 @@ void ceph_early_kick_flushing_caps(struct ceph_mds_client *mdsc,
 void ceph_kick_flushing_caps(struct ceph_mds_client *mdsc,
 			     struct ceph_mds_session *session)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci;
 	struct ceph_cap *cap;
 	u64 oldest_flush_tid;
 
 	lockdep_assert_held(&session->s_mutex);
 
-	dout("kick_flushing_caps mds%d\n", session->s_mds);
+	doutc(cl, "mds%d\n", session->s_mds);
 
 	spin_lock(&mdsc->cap_dirty_lock);
 	oldest_flush_tid = __get_oldest_flush_tid(mdsc);
 	spin_unlock(&mdsc->cap_dirty_lock);
 
 	list_for_each_entry(ci, &session->s_cap_flushing, i_flushing_item) {
+		struct inode *inode = &ci->netfs.inode;
+
 		spin_lock(&ci->i_ceph_lock);
 		cap = ci->i_auth_cap;
 		if (!(cap && cap->session == session)) {
-			pr_err("%p auth cap %p not mds%d ???\n",
-				&ci->netfs.inode, cap, session->s_mds);
+			pr_err_client(cl, "%p %llx.%llx auth cap %p not mds%d ???\n",
+				      inode, ceph_vinop(inode), cap,
+				      session->s_mds);
 			spin_unlock(&ci->i_ceph_lock);
 			continue;
 		}
@@ -2674,11 +2738,13 @@ void ceph_kick_flushing_inode_caps(struct ceph_mds_session *session,
 {
 	struct ceph_mds_client *mdsc = session->s_mdsc;
 	struct ceph_cap *cap = ci->i_auth_cap;
+	struct inode *inode = &ci->netfs.inode;
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	dout("%s %p flushing %s\n", __func__, &ci->netfs.inode,
-	     ceph_cap_string(ci->i_flushing_caps));
+	doutc(mdsc->fsc->client, "%p %llx.%llx flushing %s\n",
+	      inode, ceph_vinop(inode),
+	      ceph_cap_string(ci->i_flushing_caps));
 
 	if (!list_empty(&ci->i_cap_flush_list)) {
 		u64 oldest_flush_tid;
@@ -2700,6 +2766,9 @@ void ceph_kick_flushing_inode_caps(struct ceph_mds_session *session,
 void ceph_take_cap_refs(struct ceph_inode_info *ci, int got,
 			    bool snap_rwsem_locked)
 {
+	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+
 	lockdep_assert_held(&ci->i_ceph_lock);
 
 	if (got & CEPH_CAP_PIN)
@@ -2720,10 +2789,10 @@ void ceph_take_cap_refs(struct ceph_inode_info *ci, int got,
 	}
 	if (got & CEPH_CAP_FILE_BUFFER) {
 		if (ci->i_wb_ref == 0)
-			ihold(&ci->netfs.inode);
+			ihold(inode);
 		ci->i_wb_ref++;
-		dout("%s %p wb %d -> %d (?)\n", __func__,
-		     &ci->netfs.inode, ci->i_wb_ref-1, ci->i_wb_ref);
+		doutc(cl, "%p %llx.%llx wb %d -> %d (?)\n", inode,
+		      ceph_vinop(inode), ci->i_wb_ref-1, ci->i_wb_ref);
 	}
 }
 
@@ -2751,19 +2820,22 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int ret = 0;
 	int have, implemented;
 	bool snap_rwsem_locked = false;
 
-	dout("get_cap_refs %p need %s want %s\n", inode,
-	     ceph_cap_string(need), ceph_cap_string(want));
+	doutc(cl, "%p %llx.%llx need %s want %s\n", inode,
+	      ceph_vinop(inode), ceph_cap_string(need),
+	      ceph_cap_string(want));
 
 again:
 	spin_lock(&ci->i_ceph_lock);
 
 	if ((flags & CHECK_FILELOCK) &&
 	    (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK)) {
-		dout("try_get_cap_refs %p error filelock\n", inode);
+		doutc(cl, "%p %llx.%llx error filelock\n", inode,
+		      ceph_vinop(inode));
 		ret = -EIO;
 		goto out_unlock;
 	}
@@ -2783,8 +2855,8 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 
 	if (have & need & CEPH_CAP_FILE_WR) {
 		if (endoff >= 0 && endoff > (loff_t)ci->i_max_size) {
-			dout("get_cap_refs %p endoff %llu > maxsize %llu\n",
-			     inode, endoff, ci->i_max_size);
+			doutc(cl, "%p %llx.%llx endoff %llu > maxsize %llu\n",
+			      inode, ceph_vinop(inode), endoff, ci->i_max_size);
 			if (endoff > ci->i_requested_max_size)
 				ret = ci->i_auth_cap ? -EFBIG : -EUCLEAN;
 			goto out_unlock;
@@ -2794,7 +2866,8 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 		 * can get a final snapshot value for size+mtime.
 		 */
 		if (__ceph_have_pending_cap_snap(ci)) {
-			dout("get_cap_refs %p cap_snap_pending\n", inode);
+			doutc(cl, "%p %llx.%llx cap_snap_pending\n", inode,
+			      ceph_vinop(inode));
 			goto out_unlock;
 		}
 	}
@@ -2812,9 +2885,9 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 		int not = want & ~(have & need);
 		int revoking = implemented & ~have;
 		int exclude = revoking & not;
-		dout("get_cap_refs %p have %s but not %s (revoking %s)\n",
-		     inode, ceph_cap_string(have), ceph_cap_string(not),
-		     ceph_cap_string(revoking));
+		doutc(cl, "%p %llx.%llx have %s but not %s (revoking %s)\n",
+		      inode, ceph_vinop(inode), ceph_cap_string(have),
+		      ceph_cap_string(not), ceph_cap_string(revoking));
 		if (!exclude || !(exclude & CEPH_CAP_FILE_BUFFER)) {
 			if (!snap_rwsem_locked &&
 			    !ci->i_head_snapc &&
@@ -2854,28 +2927,31 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 			spin_unlock(&s->s_cap_lock);
 		}
 		if (session_readonly) {
-			dout("get_cap_refs %p need %s but mds%d readonly\n",
-			     inode, ceph_cap_string(need), ci->i_auth_cap->mds);
+			doutc(cl, "%p %llx.%llx need %s but mds%d readonly\n",
+			      inode, ceph_vinop(inode), ceph_cap_string(need),
+			      ci->i_auth_cap->mds);
 			ret = -EROFS;
 			goto out_unlock;
 		}
 
 		if (ceph_inode_is_shutdown(inode)) {
-			dout("get_cap_refs %p inode is shutdown\n", inode);
+			doutc(cl, "%p %llx.%llx inode is shutdown\n",
+			      inode, ceph_vinop(inode));
 			ret = -ESTALE;
 			goto out_unlock;
 		}
 		mds_wanted = __ceph_caps_mds_wanted(ci, false);
 		if (need & ~mds_wanted) {
-			dout("get_cap_refs %p need %s > mds_wanted %s\n",
-			     inode, ceph_cap_string(need),
-			     ceph_cap_string(mds_wanted));
+			doutc(cl, "%p %llx.%llx need %s > mds_wanted %s\n",
+			      inode, ceph_vinop(inode), ceph_cap_string(need),
+			      ceph_cap_string(mds_wanted));
 			ret = -EUCLEAN;
 			goto out_unlock;
 		}
 
-		dout("get_cap_refs %p have %s need %s\n", inode,
-		     ceph_cap_string(have), ceph_cap_string(need));
+		doutc(cl, "%p %llx.%llx have %s need %s\n", inode,
+		      ceph_vinop(inode), ceph_cap_string(have),
+		      ceph_cap_string(need));
 	}
 out_unlock:
 
@@ -2890,8 +2966,8 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 	else if (ret == 1)
 		ceph_update_cap_hit(&mdsc->metric);
 
-	dout("get_cap_refs %p ret %d got %s\n", inode,
-	     ret, ceph_cap_string(*got));
+	doutc(cl, "%p %llx.%llx ret %d got %s\n", inode,
+	      ceph_vinop(inode), ret, ceph_cap_string(*got));
 	return ret;
 }
 
@@ -2903,13 +2979,14 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 static void check_max_size(struct inode *inode, loff_t endoff)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int check = 0;
 
 	/* do we need to explicitly request a larger max_size? */
 	spin_lock(&ci->i_ceph_lock);
 	if (endoff >= ci->i_max_size && endoff > ci->i_wanted_max_size) {
-		dout("write %p at large endoff %llu, req max_size\n",
-		     inode, endoff);
+		doutc(cl, "write %p %llx.%llx at large endoff %llu, req max_size\n",
+		      inode, ceph_vinop(inode), endoff);
 		ci->i_wanted_max_size = endoff;
 	}
 	/* duplicate ceph_check_caps()'s logic */
@@ -3119,10 +3196,12 @@ void ceph_get_cap_refs(struct ceph_inode_info *ci, int caps)
 static int ceph_try_drop_cap_snap(struct ceph_inode_info *ci,
 				  struct ceph_cap_snap *capsnap)
 {
+	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+
 	if (!capsnap->need_flush &&
 	    !capsnap->writing && !capsnap->dirty_pages) {
-		dout("dropping cap_snap %p follows %llu\n",
-		     capsnap, capsnap->follows);
+		doutc(cl, "%p follows %llu\n", capsnap, capsnap->follows);
 		BUG_ON(capsnap->cap_flush.tid > 0);
 		ceph_put_snap_context(capsnap->context);
 		if (!list_is_last(&capsnap->ci_item, &ci->i_cap_snaps))
@@ -3154,6 +3233,7 @@ static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
 				enum put_cap_refs_mode mode)
 {
 	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int last = 0, put = 0, flushsnaps = 0, wake = 0;
 	bool check_flushsnaps = false;
 
@@ -3176,8 +3256,8 @@ static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
 			put++;
 			check_flushsnaps = true;
 		}
-		dout("put_cap_refs %p wb %d -> %d (?)\n",
-		     inode, ci->i_wb_ref+1, ci->i_wb_ref);
+		doutc(cl, "%p %llx.%llx wb %d -> %d (?)\n", inode,
+		      ceph_vinop(inode), ci->i_wb_ref+1, ci->i_wb_ref);
 	}
 	if (had & CEPH_CAP_FILE_WR) {
 		if (--ci->i_wr_ref == 0) {
@@ -3217,8 +3297,8 @@ static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
 	}
 	spin_unlock(&ci->i_ceph_lock);
 
-	dout("put_cap_refs %p had %s%s%s\n", inode, ceph_cap_string(had),
-	     last ? " last" : "", put ? " put" : "");
+	doutc(cl, "%p %llx.%llx had %s%s%s\n", inode, ceph_vinop(inode),
+	      ceph_cap_string(had), last ? " last" : "", put ? " put" : "");
 
 	switch (mode) {
 	case PUT_CAP_REFS_SYNC:
@@ -3268,6 +3348,7 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 				struct ceph_snap_context *snapc)
 {
 	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_cap_snap *capsnap = NULL, *iter;
 	int put = 0;
 	bool last = false;
@@ -3291,11 +3372,10 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 			ceph_put_snap_context(ci->i_head_snapc);
 			ci->i_head_snapc = NULL;
 		}
-		dout("put_wrbuffer_cap_refs on %p head %d/%d -> %d/%d %s\n",
-		     inode,
-		     ci->i_wrbuffer_ref+nr, ci->i_wrbuffer_ref_head+nr,
-		     ci->i_wrbuffer_ref, ci->i_wrbuffer_ref_head,
-		     last ? " LAST" : "");
+		doutc(cl, "on %p %llx.%llx head %d/%d -> %d/%d %s\n",
+		      inode, ceph_vinop(inode), ci->i_wrbuffer_ref+nr,
+		      ci->i_wrbuffer_ref_head+nr, ci->i_wrbuffer_ref,
+		      ci->i_wrbuffer_ref_head, last ? " LAST" : "");
 	} else {
 		list_for_each_entry(iter, &ci->i_cap_snaps, ci_item) {
 			if (iter->context == snapc) {
@@ -3325,13 +3405,12 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 				}
 			}
 		}
-		dout("put_wrbuffer_cap_refs on %p cap_snap %p "
-		     " snap %lld %d/%d -> %d/%d %s%s\n",
-		     inode, capsnap, capsnap->context->seq,
-		     ci->i_wrbuffer_ref+nr, capsnap->dirty_pages + nr,
-		     ci->i_wrbuffer_ref, capsnap->dirty_pages,
-		     last ? " (wrbuffer last)" : "",
-		     complete_capsnap ? " (complete capsnap)" : "");
+		doutc(cl, "%p %llx.%llx cap_snap %p snap %lld %d/%d -> %d/%d %s%s\n",
+		      inode, ceph_vinop(inode), capsnap, capsnap->context->seq,
+		      ci->i_wrbuffer_ref+nr, capsnap->dirty_pages + nr,
+		      ci->i_wrbuffer_ref, capsnap->dirty_pages,
+		      last ? " (wrbuffer last)" : "",
+		      complete_capsnap ? " (complete capsnap)" : "");
 	}
 
 unlock:
@@ -3354,9 +3433,10 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
  */
 static void invalidate_aliases(struct inode *inode)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct dentry *dn, *prev = NULL;
 
-	dout("invalidate_aliases inode %p\n", inode);
+	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	d_prune_aliases(inode);
 	/*
 	 * For non-directory inode, d_find_alias() only returns
@@ -3415,6 +3495,7 @@ static void handle_cap_grant(struct inode *inode,
 	__releases(ci->i_ceph_lock)
 	__releases(session->s_mdsc->snap_rwsem)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int seq = le32_to_cpu(grant->seq);
 	int newcaps = le32_to_cpu(grant->caps);
@@ -3438,10 +3519,11 @@ static void handle_cap_grant(struct inode *inode,
 	if (IS_ENCRYPTED(inode) && size)
 		size = extra_info->fscrypt_file_size;
 
-	dout("handle_cap_grant inode %p cap %p mds%d seq %d %s\n",
-	     inode, cap, session->s_mds, seq, ceph_cap_string(newcaps));
-	dout(" size %llu max_size %llu, i_size %llu\n", size, max_size,
-		i_size_read(inode));
+	doutc(cl, "%p %llx.%llx cap %p mds%d seq %d %s\n", inode,
+	      ceph_vinop(inode), cap, session->s_mds, seq,
+	      ceph_cap_string(newcaps));
+	doutc(cl, " size %llu max_size %llu, i_size %llu\n", size,
+	      max_size, i_size_read(inode));
 
 
 	/*
@@ -3501,15 +3583,17 @@ static void handle_cap_grant(struct inode *inode,
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(grant->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(grant->gid));
 		ci->i_btime = extra_info->btime;
-		dout("%p mode 0%o uid.gid %d.%d\n", inode, inode->i_mode,
-		     from_kuid(&init_user_ns, inode->i_uid),
-		     from_kgid(&init_user_ns, inode->i_gid));
+		doutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
+		      ceph_vinop(inode), inode->i_mode,
+		      from_kuid(&init_user_ns, inode->i_uid),
+		      from_kgid(&init_user_ns, inode->i_gid));
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
 		if (ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
 		    memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
 			   ci->fscrypt_auth_len))
-			pr_warn_ratelimited("%s: cap grant attempt to change fscrypt_auth on non-I_NEW inode (old len %d new len %d)\n",
-				__func__, ci->fscrypt_auth_len,
+			pr_warn_ratelimited_client(cl,
+				"cap grant attempt to change fscrypt_auth on non-I_NEW inode (old len %d new len %d)\n",
+				ci->fscrypt_auth_len,
 				extra_info->fscrypt_auth_len);
 #endif
 	}
@@ -3527,8 +3611,8 @@ static void handle_cap_grant(struct inode *inode,
 		u64 version = le64_to_cpu(grant->xattr_version);
 
 		if (version > ci->i_xattrs.version) {
-			dout(" got new xattrs v%llu on %p len %d\n",
-			     version, inode, len);
+			doutc(cl, " got new xattrs v%llu on %p %llx.%llx len %d\n",
+			      version, inode, ceph_vinop(inode), len);
 			if (ci->i_xattrs.blob)
 				ceph_buffer_put(ci->i_xattrs.blob);
 			ci->i_xattrs.blob = ceph_buffer_get(xattr_buf);
@@ -3579,8 +3663,8 @@ static void handle_cap_grant(struct inode *inode,
 
 	if (ci->i_auth_cap == cap && (newcaps & CEPH_CAP_ANY_FILE_WR)) {
 		if (max_size != ci->i_max_size) {
-			dout("max_size %lld -> %llu\n",
-			     ci->i_max_size, max_size);
+			doutc(cl, "max_size %lld -> %llu\n", ci->i_max_size,
+			      max_size);
 			ci->i_max_size = max_size;
 			if (max_size >= ci->i_wanted_max_size) {
 				ci->i_wanted_max_size = 0;  /* reset */
@@ -3594,10 +3678,9 @@ static void handle_cap_grant(struct inode *inode,
 	wanted = __ceph_caps_wanted(ci);
 	used = __ceph_caps_used(ci);
 	dirty = __ceph_caps_dirty(ci);
-	dout(" my wanted = %s, used = %s, dirty %s\n",
-	     ceph_cap_string(wanted),
-	     ceph_cap_string(used),
-	     ceph_cap_string(dirty));
+	doutc(cl, " my wanted = %s, used = %s, dirty %s\n",
+	      ceph_cap_string(wanted), ceph_cap_string(used),
+	      ceph_cap_string(dirty));
 
 	if ((was_stale || le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT) &&
 	    (wanted & ~(cap->mds_wanted | newcaps))) {
@@ -3618,10 +3701,9 @@ static void handle_cap_grant(struct inode *inode,
 	if (cap->issued & ~newcaps) {
 		int revoking = cap->issued & ~newcaps;
 
-		dout("revocation: %s -> %s (revoking %s)\n",
-		     ceph_cap_string(cap->issued),
-		     ceph_cap_string(newcaps),
-		     ceph_cap_string(revoking));
+		doutc(cl, "revocation: %s -> %s (revoking %s)\n",
+		      ceph_cap_string(cap->issued), ceph_cap_string(newcaps),
+		      ceph_cap_string(revoking));
 		if (S_ISREG(inode->i_mode) &&
 		    (revoking & used & CEPH_CAP_FILE_BUFFER))
 			writeback = true;  /* initiate writeback; will delay ack */
@@ -3639,11 +3721,12 @@ static void handle_cap_grant(struct inode *inode,
 		cap->issued = newcaps;
 		cap->implemented |= newcaps;
 	} else if (cap->issued == newcaps) {
-		dout("caps unchanged: %s -> %s\n",
-		     ceph_cap_string(cap->issued), ceph_cap_string(newcaps));
+		doutc(cl, "caps unchanged: %s -> %s\n",
+		      ceph_cap_string(cap->issued),
+		      ceph_cap_string(newcaps));
 	} else {
-		dout("grant: %s -> %s\n", ceph_cap_string(cap->issued),
-		     ceph_cap_string(newcaps));
+		doutc(cl, "grant: %s -> %s\n", ceph_cap_string(cap->issued),
+		      ceph_cap_string(newcaps));
 		/* non-auth MDS is revoking the newly grant caps ? */
 		if (cap == ci->i_auth_cap &&
 		    __ceph_caps_revoking_other(ci, cap, newcaps))
@@ -3732,6 +3815,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_cap_flush *cf, *tmp_cf;
 	LIST_HEAD(to_remove);
 	unsigned seq = le32_to_cpu(m->seq);
@@ -3768,11 +3852,11 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 		}
 	}
 
-	dout("handle_cap_flush_ack inode %p mds%d seq %d on %s cleaned %s,"
-	     " flushing %s -> %s\n",
-	     inode, session->s_mds, seq, ceph_cap_string(dirty),
-	     ceph_cap_string(cleaned), ceph_cap_string(ci->i_flushing_caps),
-	     ceph_cap_string(ci->i_flushing_caps & ~cleaned));
+	doutc(cl, "%p %llx.%llx mds%d seq %d on %s cleaned %s, flushing %s -> %s\n",
+	      inode, ceph_vinop(inode), session->s_mds, seq,
+	      ceph_cap_string(dirty), ceph_cap_string(cleaned),
+	      ceph_cap_string(ci->i_flushing_caps),
+	      ceph_cap_string(ci->i_flushing_caps & ~cleaned));
 
 	if (list_empty(&to_remove) && !cleaned)
 		goto out;
@@ -3788,18 +3872,21 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 		if (list_empty(&ci->i_cap_flush_list)) {
 			list_del_init(&ci->i_flushing_item);
 			if (!list_empty(&session->s_cap_flushing)) {
-				dout(" mds%d still flushing cap on %p\n",
-				     session->s_mds,
-				     &list_first_entry(&session->s_cap_flushing,
-						struct ceph_inode_info,
-						i_flushing_item)->netfs.inode);
+				struct inode *inode =
+					    &list_first_entry(&session->s_cap_flushing,
+							      struct ceph_inode_info,
+							      i_flushing_item)->netfs.inode;
+				doutc(cl, " mds%d still flushing cap on %p %llx.%llx\n",
+				      session->s_mds, inode, ceph_vinop(inode));
 			}
 		}
 		mdsc->num_cap_flushing--;
-		dout(" inode %p now !flushing\n", inode);
+		doutc(cl, " %p %llx.%llx now !flushing\n", inode,
+		      ceph_vinop(inode));
 
 		if (ci->i_dirty_caps == 0) {
-			dout(" inode %p now clean\n", inode);
+			doutc(cl, " %p %llx.%llx now clean\n", inode,
+			      ceph_vinop(inode));
 			BUG_ON(!list_empty(&ci->i_dirty_item));
 			drop = true;
 			if (ci->i_wr_ref == 0 &&
@@ -3838,11 +3925,13 @@ void __ceph_remove_capsnap(struct inode *inode, struct ceph_cap_snap *capsnap,
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	bool ret;
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	dout("removing capsnap %p, inode %p ci %p\n", capsnap, inode, ci);
+	doutc(cl, "removing capsnap %p, %p %llx.%llx ci %p\n", capsnap,
+	      inode, ceph_vinop(inode), ci);
 
 	list_del_init(&capsnap->ci_item);
 	ret = __detach_cap_flush_from_ci(ci, &capsnap->cap_flush);
@@ -3882,28 +3971,30 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	u64 follows = le64_to_cpu(m->snap_follows);
 	struct ceph_cap_snap *capsnap = NULL, *iter;
 	bool wake_ci = false;
 	bool wake_mdsc = false;
 
-	dout("handle_cap_flushsnap_ack inode %p ci %p mds%d follows %lld\n",
-	     inode, ci, session->s_mds, follows);
+	doutc(cl, "%p %llx.%llx ci %p mds%d follows %lld\n", inode,
+	      ceph_vinop(inode), ci, session->s_mds, follows);
 
 	spin_lock(&ci->i_ceph_lock);
 	list_for_each_entry(iter, &ci->i_cap_snaps, ci_item) {
 		if (iter->follows == follows) {
 			if (iter->cap_flush.tid != flush_tid) {
-				dout(" cap_snap %p follows %lld tid %lld !="
-				     " %lld\n", iter, follows,
-				     flush_tid, iter->cap_flush.tid);
+				doutc(cl, " cap_snap %p follows %lld "
+				      "tid %lld != %lld\n", iter,
+				      follows, flush_tid,
+				      iter->cap_flush.tid);
 				break;
 			}
 			capsnap = iter;
 			break;
 		} else {
-			dout(" skipping cap_snap %p follows %lld\n",
-			     iter, iter->follows);
+			doutc(cl, " skipping cap_snap %p follows %lld\n",
+			      iter, iter->follows);
 		}
 	}
 	if (capsnap)
@@ -3932,6 +4023,7 @@ static bool handle_cap_trunc(struct inode *inode,
 			     struct cap_extra_info *extra_info)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int mds = session->s_mds;
 	int seq = le32_to_cpu(trunc->seq);
 	u32 truncate_seq = le32_to_cpu(trunc->truncate_seq);
@@ -3954,8 +4046,8 @@ static bool handle_cap_trunc(struct inode *inode,
 	if (IS_ENCRYPTED(inode) && size)
 		size = extra_info->fscrypt_file_size;
 
-	dout("%s inode %p mds%d seq %d to %lld truncate seq %d\n",
-	     __func__, inode, mds, seq, truncate_size, truncate_seq);
+	doutc(cl, "%p %llx.%llx mds%d seq %d to %lld truncate seq %d\n",
+	      inode, ceph_vinop(inode), mds, seq, truncate_size, truncate_seq);
 	queue_trunc = ceph_fill_file_size(inode, issued,
 					  truncate_seq, truncate_size, size);
 	return queue_trunc;
@@ -3974,6 +4066,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 			      struct ceph_mds_session *session)
 {
 	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_session *tsession = NULL;
 	struct ceph_cap *cap, *tcap, *new_cap = NULL;
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -3993,8 +4086,8 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		target = -1;
 	}
 
-	dout("handle_cap_export inode %p ci %p mds%d mseq %d target %d\n",
-	     inode, ci, mds, mseq, target);
+	doutc(cl, "%p %llx.%llx ci %p mds%d mseq %d target %d\n",
+	      inode, ceph_vinop(inode), ci, mds, mseq, target);
 retry:
 	down_read(&mdsc->snap_rwsem);
 	spin_lock(&ci->i_ceph_lock);
@@ -4014,12 +4107,13 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 
 	issued = cap->issued;
 	if (issued != cap->implemented)
-		pr_err_ratelimited("handle_cap_export: issued != implemented: "
-				"ino (%llx.%llx) mds%d seq %d mseq %d "
-				"issued %s implemented %s\n",
-				ceph_vinop(inode), mds, cap->seq, cap->mseq,
-				ceph_cap_string(issued),
-				ceph_cap_string(cap->implemented));
+		pr_err_ratelimited_client(cl, "issued != implemented: "
+					  "%p %llx.%llx mds%d seq %d mseq %d"
+					  " issued %s implemented %s\n",
+					  inode, ceph_vinop(inode), mds,
+					  cap->seq, cap->mseq,
+					  ceph_cap_string(issued),
+					  ceph_cap_string(cap->implemented));
 
 
 	tcap = __get_cap_for_mds(ci, target);
@@ -4027,7 +4121,8 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		/* already have caps from the target */
 		if (tcap->cap_id == t_cap_id &&
 		    ceph_seq_cmp(tcap->seq, t_seq) < 0) {
-			dout(" updating import cap %p mds%d\n", tcap, target);
+			doutc(cl, " updating import cap %p mds%d\n", tcap,
+			      target);
 			tcap->cap_id = t_cap_id;
 			tcap->seq = t_seq - 1;
 			tcap->issue_seq = t_seq - 1;
@@ -4108,6 +4203,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 			      struct ceph_cap **target_cap, int *old_issued)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_cap *cap, *ocap, *new_cap = NULL;
 	int mds = session->s_mds;
 	int issued;
@@ -4128,8 +4224,8 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 		peer = -1;
 	}
 
-	dout("handle_cap_import inode %p ci %p mds%d mseq %d peer %d\n",
-	     inode, ci, mds, mseq, peer);
+	doutc(cl, "%p %llx.%llx ci %p mds%d mseq %d peer %d\n",
+	      inode, ceph_vinop(inode), ci, mds, mseq, peer);
 retry:
 	cap = __get_cap_for_mds(ci, mds);
 	if (!cap) {
@@ -4155,17 +4251,17 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 
 	ocap = peer >= 0 ? __get_cap_for_mds(ci, peer) : NULL;
 	if (ocap && ocap->cap_id == p_cap_id) {
-		dout(" remove export cap %p mds%d flags %d\n",
-		     ocap, peer, ph->flags);
+		doutc(cl, " remove export cap %p mds%d flags %d\n",
+		      ocap, peer, ph->flags);
 		if ((ph->flags & CEPH_CAP_FLAG_AUTH) &&
 		    (ocap->seq != le32_to_cpu(ph->seq) ||
 		     ocap->mseq != le32_to_cpu(ph->mseq))) {
-			pr_err_ratelimited("handle_cap_import: "
-					"mismatched seq/mseq: ino (%llx.%llx) "
-					"mds%d seq %d mseq %d importer mds%d "
-					"has peer seq %d mseq %d\n",
-					ceph_vinop(inode), peer, ocap->seq,
-					ocap->mseq, mds, le32_to_cpu(ph->seq),
+			pr_err_ratelimited_client(cl, "mismatched seq/mseq: "
+					"%p %llx.%llx mds%d seq %d mseq %d"
+					" importer mds%d has peer seq %d mseq %d\n",
+					inode, ceph_vinop(inode), peer,
+					ocap->seq, ocap->mseq, mds,
+					le32_to_cpu(ph->seq),
 					le32_to_cpu(ph->mseq));
 		}
 		ceph_remove_cap(mdsc, ocap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
@@ -4231,6 +4327,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		      struct ceph_msg *msg)
 {
 	struct ceph_mds_client *mdsc = session->s_mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct inode *inode;
 	struct ceph_inode_info *ci;
 	struct ceph_cap *cap;
@@ -4249,7 +4346,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	bool close_sessions = false;
 	bool do_cap_release = false;
 
-	dout("handle_caps from mds%d\n", session->s_mds);
+	doutc(cl, "from mds%d\n", session->s_mds);
 
 	if (!ceph_inc_mds_stopping_blocker(mdsc, session))
 		return;
@@ -4351,15 +4448,15 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 
 	/* lookup ino */
 	inode = ceph_find_inode(mdsc->fsc->sb, vino);
-	dout(" op %s ino %llx.%llx inode %p\n", ceph_cap_op_name(op), vino.ino,
-	     vino.snap, inode);
+	doutc(cl, " op %s ino %llx.%llx inode %p\n", ceph_cap_op_name(op),
+	      vino.ino, vino.snap, inode);
 
 	mutex_lock(&session->s_mutex);
-	dout(" mds%d seq %lld cap seq %u\n", session->s_mds, session->s_seq,
-	     (unsigned)seq);
+	doutc(cl, " mds%d seq %lld cap seq %u\n", session->s_mds,
+	      session->s_seq, (unsigned)seq);
 
 	if (!inode) {
-		dout(" i don't have ino %llx\n", vino.ino);
+		doutc(cl, " i don't have ino %llx\n", vino.ino);
 
 		switch (op) {
 		case CEPH_CAP_OP_IMPORT:
@@ -4414,9 +4511,9 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	spin_lock(&ci->i_ceph_lock);
 	cap = __get_cap_for_mds(ceph_inode(inode), session->s_mds);
 	if (!cap) {
-		dout(" no cap on %p ino %llx.%llx from mds%d\n",
-		     inode, ceph_ino(inode), ceph_snap(inode),
-		     session->s_mds);
+		doutc(cl, " no cap on %p ino %llx.%llx from mds%d\n",
+		      inode, ceph_ino(inode), ceph_snap(inode),
+		      session->s_mds);
 		spin_unlock(&ci->i_ceph_lock);
 		switch (op) {
 		case CEPH_CAP_OP_REVOKE:
@@ -4454,8 +4551,8 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 
 	default:
 		spin_unlock(&ci->i_ceph_lock);
-		pr_err("ceph_handle_caps: unknown cap op %d %s\n", op,
-		       ceph_cap_op_name(op));
+		pr_err_client(cl, "unknown cap op %d %s\n", op,
+			      ceph_cap_op_name(op));
 	}
 
 done:
@@ -4496,7 +4593,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	goto done;
 
 bad:
-	pr_err("ceph_handle_caps: corrupt message\n");
+	pr_err_client(cl, "corrupt message\n");
 	ceph_msg_dump(msg);
 	goto out;
 }
@@ -4510,6 +4607,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
  */
 unsigned long ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct inode *inode;
 	struct ceph_inode_info *ci;
 	struct ceph_mount_options *opt = mdsc->fsc->mount_options;
@@ -4517,14 +4615,14 @@ unsigned long ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 	unsigned long loop_start = jiffies;
 	unsigned long delay = 0;
 
-	dout("check_delayed_caps\n");
+	doutc(cl, "begin\n");
 	spin_lock(&mdsc->cap_delay_lock);
 	while (!list_empty(&mdsc->cap_delay_list)) {
 		ci = list_first_entry(&mdsc->cap_delay_list,
 				      struct ceph_inode_info,
 				      i_cap_delay_list);
 		if (time_before(loop_start, ci->i_hold_caps_max - delay_max)) {
-			dout("%s caps added recently.  Exiting loop", __func__);
+			doutc(cl, "caps added recently.  Exiting loop");
 			delay = ci->i_hold_caps_max;
 			break;
 		}
@@ -4536,13 +4634,15 @@ unsigned long ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 		inode = igrab(&ci->netfs.inode);
 		if (inode) {
 			spin_unlock(&mdsc->cap_delay_lock);
-			dout("check_delayed_caps on %p\n", inode);
+			doutc(cl, "on %p %llx.%llx\n", inode,
+			      ceph_vinop(inode));
 			ceph_check_caps(ci, 0);
 			iput(inode);
 			spin_lock(&mdsc->cap_delay_lock);
 		}
 	}
 	spin_unlock(&mdsc->cap_delay_lock);
+	doutc(cl, "done\n");
 
 	return delay;
 }
@@ -4553,17 +4653,18 @@ unsigned long ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 static void flush_dirty_session_caps(struct ceph_mds_session *s)
 {
 	struct ceph_mds_client *mdsc = s->s_mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci;
 	struct inode *inode;
 
-	dout("flush_dirty_caps\n");
+	doutc(cl, "begin\n");
 	spin_lock(&mdsc->cap_dirty_lock);
 	while (!list_empty(&s->s_cap_dirty)) {
 		ci = list_first_entry(&s->s_cap_dirty, struct ceph_inode_info,
 				      i_dirty_item);
 		inode = &ci->netfs.inode;
 		ihold(inode);
-		dout("flush_dirty_caps %llx.%llx\n", ceph_vinop(inode));
+		doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 		spin_unlock(&mdsc->cap_dirty_lock);
 		ceph_wait_on_async_create(inode);
 		ceph_check_caps(ci, CHECK_CAPS_FLUSH);
@@ -4571,7 +4672,7 @@ static void flush_dirty_session_caps(struct ceph_mds_session *s)
 		spin_lock(&mdsc->cap_dirty_lock);
 	}
 	spin_unlock(&mdsc->cap_dirty_lock);
-	dout("flush_dirty_caps done\n");
+	doutc(cl, "done\n");
 }
 
 void ceph_flush_dirty_caps(struct ceph_mds_client *mdsc)
@@ -4696,6 +4797,7 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 			      int mds, int drop, int unless, int force)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_cap *cap;
 	struct ceph_mds_request_release *rel = *p;
 	int used, dirty;
@@ -4705,9 +4807,9 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 	used = __ceph_caps_used(ci);
 	dirty = __ceph_caps_dirty(ci);
 
-	dout("encode_inode_release %p mds%d used|dirty %s drop %s unless %s\n",
-	     inode, mds, ceph_cap_string(used|dirty), ceph_cap_string(drop),
-	     ceph_cap_string(unless));
+	doutc(cl, "%p %llx.%llx mds%d used|dirty %s drop %s unless %s\n",
+	      inode, ceph_vinop(inode), mds, ceph_cap_string(used|dirty),
+	      ceph_cap_string(drop), ceph_cap_string(unless));
 
 	/* only drop unused, clean caps */
 	drop &= ~(used | dirty);
@@ -4729,12 +4831,13 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 		if (force || (cap->issued & drop)) {
 			if (cap->issued & drop) {
 				int wanted = __ceph_caps_wanted(ci);
-				dout("encode_inode_release %p cap %p "
-				     "%s -> %s, wanted %s -> %s\n", inode, cap,
-				     ceph_cap_string(cap->issued),
-				     ceph_cap_string(cap->issued & ~drop),
-				     ceph_cap_string(cap->mds_wanted),
-				     ceph_cap_string(wanted));
+				doutc(cl, "%p %llx.%llx cap %p %s -> %s, "
+				      "wanted %s -> %s\n", inode,
+				      ceph_vinop(inode), cap,
+				      ceph_cap_string(cap->issued),
+				      ceph_cap_string(cap->issued & ~drop),
+				      ceph_cap_string(cap->mds_wanted),
+				      ceph_cap_string(wanted));
 
 				cap->issued &= ~drop;
 				cap->implemented &= ~drop;
@@ -4743,9 +4846,9 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 				    !(wanted & CEPH_CAP_ANY_FILE_WR))
 					ci->i_requested_max_size = 0;
 			} else {
-				dout("encode_inode_release %p cap %p %s"
-				     " (force)\n", inode, cap,
-				     ceph_cap_string(cap->issued));
+				doutc(cl, "%p %llx.%llx cap %p %s (force)\n",
+				      inode, ceph_vinop(inode), cap,
+				      ceph_cap_string(cap->issued));
 			}
 
 			rel->ino = cpu_to_le64(ceph_ino(inode));
@@ -4760,8 +4863,9 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 			*p += sizeof(*rel);
 			ret = 1;
 		} else {
-			dout("encode_inode_release %p cap %p %s (noop)\n",
-			     inode, cap, ceph_cap_string(cap->issued));
+			doutc(cl, "%p %llx.%llx cap %p %s (noop)\n",
+			      inode, ceph_vinop(inode), cap,
+			      ceph_cap_string(cap->issued));
 		}
 	}
 	spin_unlock(&ci->i_ceph_lock);
@@ -4786,6 +4890,7 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 {
 	struct ceph_mds_request_release *rel = *p;
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
+	struct ceph_client *cl;
 	int force = 0;
 	int ret;
 
@@ -4805,10 +4910,11 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 
 	ret = ceph_encode_inode_release(p, dir, mds, drop, unless, force);
 
+	cl = ceph_inode_to_client(dir);
 	spin_lock(&dentry->d_lock);
 	if (ret && di->lease_session && di->lease_session->s_mds == mds) {
-		dout("encode_dentry_release %p mds%d seq %d\n",
-		     dentry, mds, (int)di->lease_seq);
+		doutc(cl, "%p mds%d seq %d\n",  dentry, mds,
+		      (int)di->lease_seq);
 		rel->dname_seq = cpu_to_le32(di->lease_seq);
 		__ceph_mdsc_drop_dentry_lease(dentry);
 		spin_unlock(&dentry->d_lock);
@@ -4834,12 +4940,14 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 static int remove_capsnaps(struct ceph_mds_client *mdsc, struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_cap_snap *capsnap;
 	int capsnap_release = 0;
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	dout("removing capsnaps, ci is %p, inode is %p\n", ci, inode);
+	doutc(cl, "removing capsnaps, ci is %p, %p %llx.%llx\n",
+	      ci, inode, ceph_vinop(inode));
 
 	while (!list_empty(&ci->i_cap_snaps)) {
 		capsnap = list_first_entry(&ci->i_cap_snaps,
@@ -4858,6 +4966,7 @@ int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invali
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
+	struct ceph_client *cl = fsc->client;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	bool is_auth;
 	bool dirty_dropped = false;
@@ -4865,8 +4974,8 @@ int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invali
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	dout("removing cap %p, ci is %p, inode is %p\n",
-	     cap, ci, &ci->netfs.inode);
+	doutc(cl, "removing cap %p, ci is %p, %p %llx.%llx\n",
+	      cap, ci, inode, ceph_vinop(inode));
 
 	is_auth = (cap == ci->i_auth_cap);
 	__ceph_remove_cap(cap, false);
@@ -4893,19 +5002,19 @@ int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invali
 		}
 
 		if (!list_empty(&ci->i_dirty_item)) {
-			pr_warn_ratelimited(
-				" dropping dirty %s state for %p %lld\n",
+			pr_warn_ratelimited_client(cl,
+				" dropping dirty %s state for %p %llx.%llx\n",
 				ceph_cap_string(ci->i_dirty_caps),
-				inode, ceph_ino(inode));
+				inode, ceph_vinop(inode));
 			ci->i_dirty_caps = 0;
 			list_del_init(&ci->i_dirty_item);
 			dirty_dropped = true;
 		}
 		if (!list_empty(&ci->i_flushing_item)) {
-			pr_warn_ratelimited(
-				" dropping dirty+flushing %s state for %p %lld\n",
+			pr_warn_ratelimited_client(cl,
+				" dropping dirty+flushing %s state for %p %llx.%llx\n",
 				ceph_cap_string(ci->i_flushing_caps),
-				inode, ceph_ino(inode));
+				inode, ceph_vinop(inode));
 			ci->i_flushing_caps = 0;
 			list_del_init(&ci->i_flushing_item);
 			mdsc->num_cap_flushing--;
@@ -4928,8 +5037,9 @@ int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invali
 		if (atomic_read(&ci->i_filelock_ref) > 0) {
 			/* make further file lock syscall return -EIO */
 			ci->i_ceph_flags |= CEPH_I_ERROR_FILELOCK;
-			pr_warn_ratelimited(" dropping file locks for %p %lld\n",
-					    inode, ceph_ino(inode));
+			pr_warn_ratelimited_client(cl,
+				" dropping file locks for %p %llx.%llx\n",
+				inode, ceph_vinop(inode));
 		}
 
 		if (!ci->i_dirty_caps && ci->i_prealloc_cap_flush) {
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 08c385610731..d692ebfddedb 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -211,6 +211,7 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
 static struct inode *parse_longname(const struct inode *parent,
 				    const char *name, int *name_len)
 {
+	struct ceph_client *cl = ceph_inode_to_client(parent);
 	struct inode *dir = NULL;
 	struct ceph_vino vino = { .snap = CEPH_NOSNAP };
 	char *inode_number;
@@ -222,12 +223,12 @@ static struct inode *parse_longname(const struct inode *parent,
 	name++;
 	name_end = strrchr(name, '_');
 	if (!name_end) {
-		dout("Failed to parse long snapshot name: %s\n", name);
+		doutc(cl, "failed to parse long snapshot name: %s\n", name);
 		return ERR_PTR(-EIO);
 	}
 	*name_len = (name_end - name);
 	if (*name_len <= 0) {
-		pr_err("Failed to parse long snapshot name\n");
+		pr_err_client(cl, "failed to parse long snapshot name\n");
 		return ERR_PTR(-EIO);
 	}
 
@@ -239,7 +240,7 @@ static struct inode *parse_longname(const struct inode *parent,
 		return ERR_PTR(-ENOMEM);
 	ret = kstrtou64(inode_number, 10, &vino.ino);
 	if (ret) {
-		dout("Failed to parse inode number: %s\n", name);
+		doutc(cl, "failed to parse inode number: %s\n", name);
 		dir = ERR_PTR(ret);
 		goto out;
 	}
@@ -250,7 +251,7 @@ static struct inode *parse_longname(const struct inode *parent,
 		/* This can happen if we're not mounting cephfs on the root */
 		dir = ceph_get_inode(parent->i_sb, vino, NULL);
 		if (IS_ERR(dir))
-			dout("Can't find inode %s (%s)\n", inode_number, name);
+			doutc(cl, "can't find inode %s (%s)\n", inode_number, name);
 	}
 
 out:
@@ -261,6 +262,7 @@ static struct inode *parse_longname(const struct inode *parent,
 int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
 				char *buf)
 {
+	struct ceph_client *cl = ceph_inode_to_client(parent);
 	struct inode *dir = parent;
 	struct qstr iname;
 	u32 len;
@@ -329,7 +331,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, struct qstr *d_name,
 
 	/* base64 encode the encrypted name */
 	elen = ceph_base64_encode(cryptbuf, len, buf);
-	dout("base64-encoded ciphertext name = %.*s\n", elen, buf);
+	doutc(cl, "base64-encoded ciphertext name = %.*s\n", elen, buf);
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
 	WARN_ON(elen > 240);
@@ -504,7 +506,10 @@ int ceph_fscrypt_decrypt_block_inplace(const struct inode *inode,
 				  struct page *page, unsigned int len,
 				  unsigned int offs, u64 lblk_num)
 {
-	dout("%s: len %u offs %u blk %llu\n", __func__, len, offs, lblk_num);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+
+	doutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
+	      ceph_vinop(inode), len, offs, lblk_num);
 	return fscrypt_decrypt_block_inplace(inode, page, len, offs, lblk_num);
 }
 
@@ -513,7 +518,10 @@ int ceph_fscrypt_encrypt_block_inplace(const struct inode *inode,
 				  unsigned int offs, u64 lblk_num,
 				  gfp_t gfp_flags)
 {
-	dout("%s: len %u offs %u blk %llu\n", __func__, len, offs, lblk_num);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+
+	doutc(cl, "%p %llx.%llx len %u offs %u blk %llu\n", inode,
+	      ceph_vinop(inode), len, offs, lblk_num);
 	return fscrypt_encrypt_block_inplace(inode, page, len, offs, lblk_num,
 					     gfp_flags);
 }
@@ -582,6 +590,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 				 u64 off, struct ceph_sparse_extent *map,
 				 u32 ext_cnt)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int i, ret = 0;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u64 objno, objoff;
@@ -589,7 +598,8 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 
 	/* Nothing to do for empty array */
 	if (ext_cnt == 0) {
-		dout("%s: empty array, ret 0\n", __func__);
+		doutc(cl, "%p %llx.%llx empty array, ret 0\n", inode,
+		      ceph_vinop(inode));
 		return 0;
 	}
 
@@ -603,14 +613,17 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 		int fret;
 
 		if ((ext->off | ext->len) & ~CEPH_FSCRYPT_BLOCK_MASK) {
-			pr_warn("%s: bad encrypted sparse extent idx %d off %llx len %llx\n",
-				__func__, i, ext->off, ext->len);
+			pr_warn_client(cl,
+				"%p %llx.%llx bad encrypted sparse extent "
+				"idx %d off %llx len %llx\n",
+				inode, ceph_vinop(inode), i, ext->off,
+				ext->len);
 			return -EIO;
 		}
 		fret = ceph_fscrypt_decrypt_pages(inode, &page[pgidx],
 						 off + pgsoff, ext->len);
-		dout("%s: [%d] 0x%llx~0x%llx fret %d\n", __func__, i,
-				ext->off, ext->len, fret);
+		doutc(cl, "%p %llx.%llx [%d] 0x%llx~0x%llx fret %d\n", inode,
+		      ceph_vinop(inode), i, ext->off, ext->len, fret);
 		if (fret < 0) {
 			if (ret == 0)
 				ret = fret;
@@ -618,7 +631,7 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 		}
 		ret = pgsoff + fret;
 	}
-	dout("%s: ret %d\n", __func__, ret);
+	doutc(cl, "ret %d\n", ret);
 	return ret;
 }
 
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 2f1e7498cd74..24c08078f5aa 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -398,7 +398,7 @@ DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
 
 void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 {
-	dout("ceph_fs_debugfs_cleanup\n");
+	doutc(fsc->client, "begin\n");
 	debugfs_remove(fsc->debugfs_bdi);
 	debugfs_remove(fsc->debugfs_congestion_kb);
 	debugfs_remove(fsc->debugfs_mdsmap);
@@ -407,13 +407,14 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 	debugfs_remove(fsc->debugfs_status);
 	debugfs_remove(fsc->debugfs_mdsc);
 	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
+	doutc(fsc->client, "done\n");
 }
 
 void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 {
 	char name[100];
 
-	dout("ceph_fs_debugfs_init\n");
+	doutc(fsc->client, "begin\n");
 	fsc->debugfs_congestion_kb =
 		debugfs_create_file("writeback_congestion_kb",
 				    0600,
@@ -469,6 +470,7 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 			    &metrics_size_fops);
 	debugfs_create_file("caps", 0400, fsc->debugfs_metrics_dir, fsc,
 			    &metrics_caps_fops);
+	doutc(fsc->client, "done\n");
 }
 
 
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 1395b71df5cc..6bb95b4e93a8 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -109,7 +109,9 @@ static int fpos_cmp(loff_t l, loff_t r)
  * regardless of what dir changes take place on the
  * server.
  */
-static int note_last_dentry(struct ceph_dir_file_info *dfi, const char *name,
+static int note_last_dentry(struct ceph_fs_client *fsc,
+			    struct ceph_dir_file_info *dfi,
+			    const char *name,
 		            int len, unsigned next_offset)
 {
 	char *buf = kmalloc(len+1, GFP_KERNEL);
@@ -120,7 +122,7 @@ static int note_last_dentry(struct ceph_dir_file_info *dfi, const char *name,
 	memcpy(dfi->last_name, name, len);
 	dfi->last_name[len] = 0;
 	dfi->next_offset = next_offset;
-	dout("note_last_dentry '%s'\n", dfi->last_name);
+	doutc(fsc->client, "'%s'\n", dfi->last_name);
 	return 0;
 }
 
@@ -130,6 +132,7 @@ __dcache_find_get_entry(struct dentry *parent, u64 idx,
 			struct ceph_readdir_cache_control *cache_ctl)
 {
 	struct inode *dir = d_inode(parent);
+	struct ceph_client *cl = ceph_inode_to_client(dir);
 	struct dentry *dentry;
 	unsigned idx_mask = (PAGE_SIZE / sizeof(struct dentry *)) - 1;
 	loff_t ptr_pos = idx * sizeof(struct dentry *);
@@ -142,7 +145,7 @@ __dcache_find_get_entry(struct dentry *parent, u64 idx,
 		ceph_readdir_cache_release(cache_ctl);
 		cache_ctl->page = find_lock_page(&dir->i_data, ptr_pgoff);
 		if (!cache_ctl->page) {
-			dout(" page %lu not found\n", ptr_pgoff);
+			doutc(cl, " page %lu not found\n", ptr_pgoff);
 			return ERR_PTR(-EAGAIN);
 		}
 		/* reading/filling the cache are serialized by
@@ -185,13 +188,16 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 	struct ceph_dir_file_info *dfi = file->private_data;
 	struct dentry *parent = file->f_path.dentry;
 	struct inode *dir = d_inode(parent);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(dir);
+	struct ceph_client *cl = ceph_inode_to_client(dir);
 	struct dentry *dentry, *last = NULL;
 	struct ceph_dentry_info *di;
 	struct ceph_readdir_cache_control cache_ctl = {};
 	u64 idx = 0;
 	int err = 0;
 
-	dout("__dcache_readdir %p v%u at %llx\n", dir, (unsigned)shared_gen, ctx->pos);
+	doutc(cl, "%p %llx.%llx v%u at %llx\n", dir, ceph_vinop(dir),
+	      (unsigned)shared_gen, ctx->pos);
 
 	/* search start position */
 	if (ctx->pos > 2) {
@@ -221,7 +227,8 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 			dput(dentry);
 		}
 
-		dout("__dcache_readdir %p cache idx %llu\n", dir, idx);
+		doutc(cl, "%p %llx.%llx cache idx %llu\n", dir,
+		      ceph_vinop(dir), idx);
 	}
 
 
@@ -257,8 +264,8 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 		spin_unlock(&dentry->d_lock);
 
 		if (emit_dentry) {
-			dout(" %llx dentry %p %pd %p\n", di->offset,
-			     dentry, dentry, d_inode(dentry));
+			doutc(cl, " %llx dentry %p %pd %p\n", di->offset,
+			      dentry, dentry, d_inode(dentry));
 			ctx->pos = di->offset;
 			if (!dir_emit(ctx, dentry->d_name.name,
 				      dentry->d_name.len, ceph_present_inode(d_inode(dentry)),
@@ -281,7 +288,8 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 	if (last) {
 		int ret;
 		di = ceph_dentry(last);
-		ret = note_last_dentry(dfi, last->d_name.name, last->d_name.len,
+		ret = note_last_dentry(fsc, dfi, last->d_name.name,
+				       last->d_name.len,
 				       fpos_off(di->offset) + 1);
 		if (ret < 0)
 			err = ret;
@@ -312,18 +320,21 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
+	struct ceph_client *cl = fsc->client;
 	int i;
 	int err;
 	unsigned frag = -1;
 	struct ceph_mds_reply_info_parsed *rinfo;
 
-	dout("readdir %p file %p pos %llx\n", inode, file, ctx->pos);
+	doutc(cl, "%p %llx.%llx file %p pos %llx\n", inode,
+	      ceph_vinop(inode), file, ctx->pos);
 	if (dfi->file_info.flags & CEPH_F_ATEND)
 		return 0;
 
 	/* always start with . and .. */
 	if (ctx->pos == 0) {
-		dout("readdir off 0 -> '.'\n");
+		doutc(cl, "%p %llx.%llx off 0 -> '.'\n", inode,
+		      ceph_vinop(inode));
 		if (!dir_emit(ctx, ".", 1, ceph_present_inode(inode),
 			    inode->i_mode >> 12))
 			return 0;
@@ -337,7 +348,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		ino = ceph_present_inode(dentry->d_parent->d_inode);
 		spin_unlock(&dentry->d_lock);
 
-		dout("readdir off 1 -> '..'\n");
+		doutc(cl, "%p %llx.%llx off 1 -> '..'\n", inode,
+		      ceph_vinop(inode));
 		if (!dir_emit(ctx, "..", 2, ino, inode->i_mode >> 12))
 			return 0;
 		ctx->pos = 2;
@@ -391,8 +403,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			frag = fpos_frag(ctx->pos);
 		}
 
-		dout("readdir fetching %llx.%llx frag %x offset '%s'\n",
-		     ceph_vinop(inode), frag, dfi->last_name);
+		doutc(cl, "fetching %p %llx.%llx frag %x offset '%s'\n",
+		      inode, ceph_vinop(inode), frag, dfi->last_name);
 		req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
 		if (IS_ERR(req))
 			return PTR_ERR(req);
@@ -446,12 +458,12 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			ceph_mdsc_put_request(req);
 			return err;
 		}
-		dout("readdir got and parsed readdir result=%d on "
-		     "frag %x, end=%d, complete=%d, hash_order=%d\n",
-		     err, frag,
-		     (int)req->r_reply_info.dir_end,
-		     (int)req->r_reply_info.dir_complete,
-		     (int)req->r_reply_info.hash_order);
+		doutc(cl, "%p %llx.%llx got and parsed readdir result=%d"
+		      "on frag %x, end=%d, complete=%d, hash_order=%d\n",
+		      inode, ceph_vinop(inode), err, frag,
+		      (int)req->r_reply_info.dir_end,
+		      (int)req->r_reply_info.dir_complete,
+		      (int)req->r_reply_info.hash_order);
 
 		rinfo = &req->r_reply_info;
 		if (le32_to_cpu(rinfo->dir_dir->frag) != frag) {
@@ -481,7 +493,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 				dfi->dir_ordered_count = req->r_dir_ordered_cnt;
 			}
 		} else {
-			dout("readdir !did_prepopulate\n");
+			doutc(cl, "%p %llx.%llx !did_prepopulate\n", inode,
+			      ceph_vinop(inode));
 			/* disable readdir cache */
 			dfi->readdir_cache_idx = -1;
 			/* preclude from marking dir complete */
@@ -494,8 +507,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 					rinfo->dir_entries + (rinfo->dir_nr-1);
 			unsigned next_offset = req->r_reply_info.dir_end ?
 					2 : (fpos_off(rde->offset) + 1);
-			err = note_last_dentry(dfi, rde->name, rde->name_len,
-					       next_offset);
+			err = note_last_dentry(fsc, dfi, rde->name,
+					       rde->name_len, next_offset);
 			if (err) {
 				ceph_mdsc_put_request(dfi->last_readdir);
 				dfi->last_readdir = NULL;
@@ -508,9 +521,9 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	}
 
 	rinfo = &dfi->last_readdir->r_reply_info;
-	dout("readdir frag %x num %d pos %llx chunk first %llx\n",
-	     dfi->frag, rinfo->dir_nr, ctx->pos,
-	     rinfo->dir_nr ? rinfo->dir_entries[0].offset : 0LL);
+	doutc(cl, "%p %llx.%llx frag %x num %d pos %llx chunk first %llx\n",
+	      inode, ceph_vinop(inode), dfi->frag, rinfo->dir_nr, ctx->pos,
+	      rinfo->dir_nr ? rinfo->dir_entries[0].offset : 0LL);
 
 	i = 0;
 	/* search start position */
@@ -530,8 +543,9 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
 
 		if (rde->offset < ctx->pos) {
-			pr_warn("%s: rde->offset 0x%llx ctx->pos 0x%llx\n",
-				__func__, rde->offset, ctx->pos);
+			pr_warn_client(cl,
+				"%p %llx.%llx rde->offset 0x%llx ctx->pos 0x%llx\n",
+				inode, ceph_vinop(inode), rde->offset, ctx->pos);
 			return -EIO;
 		}
 
@@ -539,9 +553,9 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			return -EIO;
 
 		ctx->pos = rde->offset;
-		dout("readdir (%d/%d) -> %llx '%.*s' %p\n",
-		     i, rinfo->dir_nr, ctx->pos,
-		     rde->name_len, rde->name, &rde->inode.in);
+		doutc(cl, "%p %llx.%llx (%d/%d) -> %llx '%.*s' %p\n", inode,
+		      ceph_vinop(inode), i, rinfo->dir_nr, ctx->pos,
+		      rde->name_len, rde->name, &rde->inode.in);
 
 		if (!dir_emit(ctx, rde->name, rde->name_len,
 			      ceph_present_ino(inode->i_sb, le64_to_cpu(rde->inode.in->ino)),
@@ -552,7 +566,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			 * doesn't have enough memory, etc. So for next readdir
 			 * it will continue.
 			 */
-			dout("filldir stopping us...\n");
+			doutc(cl, "filldir stopping us...\n");
 			return 0;
 		}
 
@@ -583,7 +597,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			kfree(dfi->last_name);
 			dfi->last_name = NULL;
 		}
-		dout("readdir next frag is %x\n", frag);
+		doutc(cl, "%p %llx.%llx next frag is %x\n", inode,
+		      ceph_vinop(inode), frag);
 		goto more;
 	}
 	dfi->file_info.flags |= CEPH_F_ATEND;
@@ -598,20 +613,23 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		spin_lock(&ci->i_ceph_lock);
 		if (dfi->dir_ordered_count ==
 				atomic64_read(&ci->i_ordered_count)) {
-			dout(" marking %p complete and ordered\n", inode);
+			doutc(cl, " marking %p %llx.%llx complete and ordered\n",
+			      inode, ceph_vinop(inode));
 			/* use i_size to track number of entries in
 			 * readdir cache */
 			BUG_ON(dfi->readdir_cache_idx < 0);
 			i_size_write(inode, dfi->readdir_cache_idx *
 				     sizeof(struct dentry*));
 		} else {
-			dout(" marking %p complete\n", inode);
+			doutc(cl, " marking %llx.%llx complete\n",
+			      ceph_vinop(inode));
 		}
 		__ceph_dir_set_complete(ci, dfi->dir_release_count,
 					dfi->dir_ordered_count);
 		spin_unlock(&ci->i_ceph_lock);
 	}
-	dout("readdir %p file %p done.\n", inode, file);
+	doutc(cl, "%p %llx.%llx file %p done.\n", inode, ceph_vinop(inode),
+	      file);
 	return 0;
 }
 
@@ -657,6 +675,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct ceph_dir_file_info *dfi = file->private_data;
 	struct inode *inode = file->f_mapping->host;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	loff_t retval;
 
 	inode_lock(inode);
@@ -676,7 +695,8 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 
 	if (offset >= 0) {
 		if (need_reset_readdir(dfi, offset)) {
-			dout("dir_llseek dropping %p content\n", file);
+			doutc(cl, "%p %llx.%llx dropping %p content\n",
+			      inode, ceph_vinop(inode), file);
 			reset_readdir(dfi);
 		} else if (is_hash_order(offset) && offset > file->f_pos) {
 			/* for hash offset, we don't know if a forward seek
@@ -705,6 +725,7 @@ struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dentry->d_sb);
 	struct inode *parent = d_inode(dentry->d_parent); /* we hold i_rwsem */
+	struct ceph_client *cl = ceph_inode_to_client(parent);
 
 	/* .snap dir? */
 	if (ceph_snap(parent) == CEPH_NOSNAP &&
@@ -713,8 +734,9 @@ struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
 		struct inode *inode = ceph_get_snapdir(parent);
 
 		res = d_splice_alias(inode, dentry);
-		dout("ENOENT on snapdir %p '%pd', linking to snapdir %p. Spliced dentry %p\n",
-		     dentry, dentry, inode, res);
+		doutc(cl, "ENOENT on snapdir %p '%pd', linking to "
+		      "snapdir %p %llx.%llx. Spliced dentry %p\n",
+		      dentry, dentry, inode, ceph_vinop(inode), res);
 		if (res)
 			dentry = res;
 	}
@@ -735,12 +757,15 @@ struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
 struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 				  struct dentry *dentry, int err)
 {
+	struct ceph_client *cl = req->r_mdsc->fsc->client;
+
 	if (err == -ENOENT) {
 		/* no trace? */
 		err = 0;
 		if (!req->r_reply_info.head->is_dentry) {
-			dout("ENOENT and no trace, dentry %p inode %p\n",
-			     dentry, d_inode(dentry));
+			doutc(cl,
+			      "ENOENT and no trace, dentry %p inode %llx.%llx\n",
+			      dentry, ceph_vinop(d_inode(dentry)));
 			if (d_really_is_positive(dentry)) {
 				d_drop(dentry);
 				err = -ENOENT;
@@ -773,13 +798,14 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_mds_request *req;
 	int op;
 	int mask;
 	int err;
 
-	dout("lookup %p dentry %p '%pd'\n",
-	     dir, dentry, dentry);
+	doutc(cl, "%p %llx.%llx/'%pd' dentry %p\n", dir, ceph_vinop(dir),
+	      dentry, dentry);
 
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
@@ -802,7 +828,8 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 		struct ceph_dentry_info *di = ceph_dentry(dentry);
 
 		spin_lock(&ci->i_ceph_lock);
-		dout(" dir %p flags are 0x%lx\n", dir, ci->i_ceph_flags);
+		doutc(cl, " dir %llx.%llx flags are 0x%lx\n",
+		      ceph_vinop(dir), ci->i_ceph_flags);
 		if (strncmp(dentry->d_name.name,
 			    fsc->mount_options->snapdir_name,
 			    dentry->d_name.len) &&
@@ -812,7 +839,8 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 		    __ceph_caps_issued_mask_metric(ci, CEPH_CAP_FILE_SHARED, 1)) {
 			__ceph_touch_fmode(ci, mdsc, CEPH_FILE_MODE_RD);
 			spin_unlock(&ci->i_ceph_lock);
-			dout(" dir %p complete, -ENOENT\n", dir);
+			doutc(cl, " dir %llx.%llx complete, -ENOENT\n",
+			      ceph_vinop(dir));
 			d_add(dentry, NULL);
 			di->lease_shared_gen = atomic_read(&ci->i_shared_gen);
 			return NULL;
@@ -850,7 +878,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	}
 	dentry = ceph_finish_lookup(req, dentry, err);
 	ceph_mdsc_put_request(req);  /* will dput(dentry) */
-	dout("lookup result=%p\n", dentry);
+	doutc(cl, "result=%p\n", dentry);
 	return dentry;
 }
 
@@ -885,6 +913,7 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
 	int err;
@@ -901,8 +930,8 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 	}
 
-	dout("mknod in dir %p dentry %p mode 0%ho rdev %d\n",
-	     dir, dentry, mode, rdev);
+	doutc(cl, "%p %llx.%llx/'%pd' dentry %p mode 0%ho rdev %d\n",
+	      dir, ceph_vinop(dir), dentry, dentry, mode, rdev);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_MKNOD, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -993,6 +1022,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *dest)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
 	umode_t mode = S_IFLNK | 0777;
@@ -1010,7 +1040,8 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 	}
 
-	dout("symlink in dir %p dentry %p to '%s'\n", dir, dentry, dest);
+	doutc(cl, "%p %llx.%llx/'%pd' to '%s'\n", dir, ceph_vinop(dir), dentry,
+	      dest);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SYMLINK, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -1064,6 +1095,7 @@ static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
 	int err;
@@ -1076,10 +1108,11 @@ static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (ceph_snap(dir) == CEPH_SNAPDIR) {
 		/* mkdir .snap/foo is a MKSNAP */
 		op = CEPH_MDS_OP_MKSNAP;
-		dout("mksnap dir %p snap '%pd' dn %p\n", dir,
-		     dentry, dentry);
+		doutc(cl, "mksnap %llx.%llx/'%pd' dentry %p\n",
+		      ceph_vinop(dir), dentry, dentry);
 	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
-		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
+		doutc(cl, "mkdir %llx.%llx/'%pd' dentry %p mode 0%ho\n",
+		      ceph_vinop(dir), dentry, dentry, mode);
 		op = CEPH_MDS_OP_MKDIR;
 	} else {
 		err = -EROFS;
@@ -1144,6 +1177,7 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 		     struct dentry *dentry)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	int err;
 
@@ -1161,8 +1195,8 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 	if (err)
 		return err;
 
-	dout("link in dir %p %llx.%llx old_dentry %p:'%pd' dentry %p:'%pd'\n",
-	     dir, ceph_vinop(dir), old_dentry, old_dentry, dentry, dentry);
+	doutc(cl, "%p %llx.%llx/'%pd' to '%pd'\n", dir, ceph_vinop(dir),
+	      old_dentry, dentry);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LINK, USE_AUTH_MDS);
 	if (IS_ERR(req)) {
 		d_drop(dentry);
@@ -1200,13 +1234,15 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 {
 	struct dentry *dentry = req->r_dentry;
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dentry->d_sb);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	int result = req->r_err ? req->r_err :
 			le32_to_cpu(req->r_reply_info.head->result);
 
 	if (!test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags))
-		pr_warn("%s dentry %p:%pd async unlink bit is not set\n",
-			__func__, dentry, dentry);
+		pr_warn_client(cl,
+			"dentry %p:%pd async unlink bit is not set\n",
+			dentry, dentry);
 
 	spin_lock(&fsc->async_unlink_conflict_lock);
 	hash_del_rcu(&di->hnode);
@@ -1240,8 +1276,8 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 		/* mark inode itself for an error (since metadata is bogus) */
 		mapping_set_error(req->r_old_inode->i_mapping, result);
 
-		pr_warn("async unlink failure path=(%llx)%s result=%d!\n",
-			base, IS_ERR(path) ? "<<bad>>" : path, result);
+		pr_warn_client(cl, "failure path=(%llx)%s result=%d!\n",
+			       base, IS_ERR(path) ? "<<bad>>" : path, result);
 		ceph_mdsc_free_path(path, pathlen);
 	}
 out:
@@ -1291,6 +1327,7 @@ static int get_caps_for_async_unlink(struct inode *dir, struct dentry *dentry)
 static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct inode *inode = d_inode(dentry);
 	struct ceph_mds_request *req;
@@ -1300,11 +1337,12 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (ceph_snap(dir) == CEPH_SNAPDIR) {
 		/* rmdir .snap/foo is RMSNAP */
-		dout("rmsnap dir %p '%pd' dn %p\n", dir, dentry, dentry);
+		doutc(cl, "rmsnap %llx.%llx/'%pd' dn\n", ceph_vinop(dir),
+		      dentry);
 		op = CEPH_MDS_OP_RMSNAP;
 	} else if (ceph_snap(dir) == CEPH_NOSNAP) {
-		dout("unlink/rmdir dir %p dn %p inode %p\n",
-		     dir, dentry, inode);
+		doutc(cl, "unlink/rmdir %llx.%llx/'%pd' inode %llx.%llx\n",
+		      ceph_vinop(dir), dentry, ceph_vinop(inode));
 		op = d_is_dir(dentry) ?
 			CEPH_MDS_OP_RMDIR : CEPH_MDS_OP_UNLINK;
 	} else
@@ -1327,9 +1365,9 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	    (req->r_dir_caps = get_caps_for_async_unlink(dir, dentry))) {
 		struct ceph_dentry_info *di = ceph_dentry(dentry);
 
-		dout("async unlink on %llu/%.*s caps=%s", ceph_ino(dir),
-		     dentry->d_name.len, dentry->d_name.name,
-		     ceph_cap_string(req->r_dir_caps));
+		doutc(cl, "async unlink on %llx.%llx/'%pd' caps=%s",
+		      ceph_vinop(dir), dentry,
+		      ceph_cap_string(req->r_dir_caps));
 		set_bit(CEPH_MDS_R_ASYNC, &req->r_req_flags);
 		req->r_callback = ceph_async_unlink_cb;
 		req->r_old_inode = d_inode(dentry);
@@ -1384,6 +1422,7 @@ static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		       struct dentry *new_dentry, unsigned int flags)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(old_dir->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	int op = CEPH_MDS_OP_RENAME;
 	int err;
@@ -1413,8 +1452,9 @@ static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (err)
 		return err;
 
-	dout("rename dir %p dentry %p to dir %p dentry %p\n",
-	     old_dir, old_dentry, new_dir, new_dentry);
+	doutc(cl, "%llx.%llx/'%pd' to %llx.%llx/'%pd'\n",
+	      ceph_vinop(old_dir), old_dentry, ceph_vinop(new_dir),
+	      new_dentry);
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -1459,9 +1499,10 @@ static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 void __ceph_dentry_lease_touch(struct ceph_dentry_info *di)
 {
 	struct dentry *dn = di->dentry;
-	struct ceph_mds_client *mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 
-	dout("dentry_lease_touch %p %p '%pd'\n", di, dn, dn);
+	doutc(cl, "%p %p '%pd'\n", di, dn, dn);
 
 	di->flags |= CEPH_DENTRY_LEASE_LIST;
 	if (di->flags & CEPH_DENTRY_SHRINK_LIST) {
@@ -1469,7 +1510,6 @@ void __ceph_dentry_lease_touch(struct ceph_dentry_info *di)
 		return;
 	}
 
-	mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
 	spin_lock(&mdsc->dentry_list_lock);
 	list_move_tail(&di->lease_list, &mdsc->dentry_leases);
 	spin_unlock(&mdsc->dentry_list_lock);
@@ -1493,10 +1533,10 @@ static void __dentry_dir_lease_touch(struct ceph_mds_client* mdsc,
 void __ceph_dentry_dir_lease_touch(struct ceph_dentry_info *di)
 {
 	struct dentry *dn = di->dentry;
-	struct ceph_mds_client *mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 
-	dout("dentry_dir_lease_touch %p %p '%pd' (offset 0x%llx)\n",
-	     di, dn, dn, di->offset);
+	doutc(cl, "%p %p '%pd' (offset 0x%llx)\n", di, dn, dn, di->offset);
 
 	if (!list_empty(&di->lease_list)) {
 		if (di->flags & CEPH_DENTRY_LEASE_LIST) {
@@ -1516,7 +1556,6 @@ void __ceph_dentry_dir_lease_touch(struct ceph_dentry_info *di)
 		return;
 	}
 
-	mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
 	spin_lock(&mdsc->dentry_list_lock);
 	__dentry_dir_lease_touch(mdsc, di),
 	spin_unlock(&mdsc->dentry_list_lock);
@@ -1757,6 +1796,8 @@ static int dentry_lease_is_valid(struct dentry *dentry, unsigned int flags)
 {
 	struct ceph_dentry_info *di;
 	struct ceph_mds_session *session = NULL;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(dentry->d_sb)->mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	u32 seq = 0;
 	int valid = 0;
 
@@ -1789,7 +1830,7 @@ static int dentry_lease_is_valid(struct dentry *dentry, unsigned int flags)
 					 CEPH_MDS_LEASE_RENEW, seq);
 		ceph_put_mds_session(session);
 	}
-	dout("dentry_lease_is_valid - dentry %p = %d\n", dentry, valid);
+	doutc(cl, "dentry %p = %d\n", dentry, valid);
 	return valid;
 }
 
@@ -1832,6 +1873,7 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry,
 			      struct ceph_mds_client *mdsc)
 {
 	struct ceph_inode_info *ci = ceph_inode(dir);
+	struct ceph_client *cl = mdsc->fsc->client;
 	int valid;
 	int shared_gen;
 
@@ -1853,8 +1895,9 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry,
 			valid = 0;
 		spin_unlock(&dentry->d_lock);
 	}
-	dout("dir_lease_is_valid dir %p v%u dentry %p = %d\n",
-	     dir, (unsigned)atomic_read(&ci->i_shared_gen), dentry, valid);
+	doutc(cl, "dir %p %llx.%llx v%u dentry %p '%pd' = %d\n", dir,
+	      ceph_vinop(dir), (unsigned)atomic_read(&ci->i_shared_gen),
+	      dentry, dentry, valid);
 	return valid;
 }
 
@@ -1863,10 +1906,11 @@ static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry,
  */
 static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(dentry->d_sb)->mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	int valid = 0;
 	struct dentry *parent;
 	struct inode *dir, *inode;
-	struct ceph_mds_client *mdsc;
 
 	valid = fscrypt_d_revalidate(dentry, flags);
 	if (valid <= 0)
@@ -1884,16 +1928,16 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 		inode = d_inode(dentry);
 	}
 
-	dout("d_revalidate %p '%pd' inode %p offset 0x%llx nokey %d\n", dentry,
-	     dentry, inode, ceph_dentry(dentry)->offset,
-	     !!(dentry->d_flags & DCACHE_NOKEY_NAME));
+	doutc(cl, "%p '%pd' inode %p offset 0x%llx nokey %d\n",
+	      dentry, dentry, inode, ceph_dentry(dentry)->offset,
+	      !!(dentry->d_flags & DCACHE_NOKEY_NAME));
 
 	mdsc = ceph_sb_to_fs_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
 	if (ceph_snap(dir) != CEPH_NOSNAP) {
-		dout("d_revalidate %p '%pd' inode %p is SNAPPED\n", dentry,
-		     dentry, inode);
+		doutc(cl, "%p '%pd' inode %p is SNAPPED\n", dentry,
+		      dentry, inode);
 		valid = 1;
 	} else if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
 		valid = 1;
@@ -1948,14 +1992,14 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 				break;
 			}
 			ceph_mdsc_put_request(req);
-			dout("d_revalidate %p lookup result=%d\n",
-			     dentry, err);
+			doutc(cl, "%p '%pd', lookup result=%d\n", dentry,
+			      dentry, err);
 		}
 	} else {
 		percpu_counter_inc(&mdsc->metric.d_lease_hit);
 	}
 
-	dout("d_revalidate %p %s\n", dentry, valid ? "valid" : "invalid");
+	doutc(cl, "%p '%pd' %s\n", dentry, dentry, valid ? "valid" : "invalid");
 	if (!valid)
 		ceph_dir_clear_complete(dir);
 
@@ -1997,7 +2041,7 @@ static void ceph_d_release(struct dentry *dentry)
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dentry->d_sb);
 
-	dout("d_release %p\n", dentry);
+	doutc(fsc->client, "dentry %p '%pd'\n", dentry, dentry);
 
 	atomic64_dec(&fsc->mdsc->metric.total_dentries);
 
@@ -2018,10 +2062,12 @@ static void ceph_d_release(struct dentry *dentry)
  */
 static void ceph_d_prune(struct dentry *dentry)
 {
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dentry->d_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *dir_ci;
 	struct ceph_dentry_info *di;
 
-	dout("ceph_d_prune %pd %p\n", dentry, dentry);
+	doutc(cl, "dentry %p '%pd'\n", dentry, dentry);
 
 	/* do we have a valid parent? */
 	if (IS_ROOT(dentry))
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 52c4daf2447d..726af69d4d62 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -36,6 +36,7 @@ struct ceph_nfs_snapfh {
 static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_len,
 			      struct inode *parent_inode)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	static const int snap_handle_length =
 		sizeof(struct ceph_nfs_snapfh) >> 2;
 	struct ceph_nfs_snapfh *sfh = (void *)rawfh;
@@ -79,13 +80,14 @@ static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_len,
 	*max_len = snap_handle_length;
 	ret = FILEID_BTRFS_WITH_PARENT;
 out:
-	dout("encode_snapfh %llx.%llx ret=%d\n", ceph_vinop(inode), ret);
+	doutc(cl, "%p %llx.%llx ret=%d\n", inode, ceph_vinop(inode), ret);
 	return ret;
 }
 
 static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 			  struct inode *parent_inode)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	static const int handle_length =
 		sizeof(struct ceph_nfs_fh) >> 2;
 	static const int connected_handle_length =
@@ -105,15 +107,15 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 
 	if (parent_inode) {
 		struct ceph_nfs_confh *cfh = (void *)rawfh;
-		dout("encode_fh %llx with parent %llx\n",
-		     ceph_ino(inode), ceph_ino(parent_inode));
+		doutc(cl, "%p %llx.%llx with parent %p %llx.%llx\n", inode,
+		      ceph_vinop(inode), parent_inode, ceph_vinop(parent_inode));
 		cfh->ino = ceph_ino(inode);
 		cfh->parent_ino = ceph_ino(parent_inode);
 		*max_len = connected_handle_length;
 		type = FILEID_INO32_GEN_PARENT;
 	} else {
 		struct ceph_nfs_fh *fh = (void *)rawfh;
-		dout("encode_fh %llx\n", ceph_ino(inode));
+		doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 		fh->ino = ceph_ino(inode);
 		*max_len = handle_length;
 		type = FILEID_INO32_GEN;
@@ -206,6 +208,7 @@ static struct dentry *__snapfh_to_dentry(struct super_block *sb,
 					  bool want_parent)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(sb)->mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct inode *inode;
 	struct ceph_vino vino;
@@ -278,11 +281,10 @@ static struct dentry *__snapfh_to_dentry(struct super_block *sb,
 	ceph_mdsc_put_request(req);
 
 	if (want_parent) {
-		dout("snapfh_to_parent %llx.%llx\n err=%d\n",
-		     vino.ino, vino.snap, err);
+		doutc(cl, "%llx.%llx\n err=%d\n", vino.ino, vino.snap, err);
 	} else {
-		dout("snapfh_to_dentry %llx.%llx parent %llx hash %x err=%d",
-		      vino.ino, vino.snap, sfh->parent_ino, sfh->hash, err);
+		doutc(cl, "%llx.%llx parent %llx hash %x err=%d", vino.ino,
+		      vino.snap, sfh->parent_ino, sfh->hash, err);
 	}
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
@@ -297,6 +299,7 @@ static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
 					struct fid *fid,
 					int fh_len, int fh_type)
 {
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_nfs_fh *fh = (void *)fid->raw;
 
 	if (fh_type == FILEID_BTRFS_WITH_PARENT) {
@@ -310,7 +313,7 @@ static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
 	if (fh_len < sizeof(*fh) / 4)
 		return NULL;
 
-	dout("fh_to_dentry %llx\n", fh->ino);
+	doutc(fsc->client, "%llx\n", fh->ino);
 	return __fh_to_dentry(sb, fh->ino);
 }
 
@@ -363,6 +366,7 @@ static struct dentry *__get_parent(struct super_block *sb,
 static struct dentry *ceph_get_parent(struct dentry *child)
 {
 	struct inode *inode = d_inode(child);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct dentry *dn;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP) {
@@ -402,8 +406,8 @@ static struct dentry *ceph_get_parent(struct dentry *child)
 		dn = __get_parent(child->d_sb, child, 0);
 	}
 out:
-	dout("get_parent %p ino %llx.%llx err=%ld\n",
-	     child, ceph_vinop(inode), (long)PTR_ERR_OR_ZERO(dn));
+	doutc(cl, "child %p %p %llx.%llx err=%ld\n", child, inode,
+	      ceph_vinop(inode), (long)PTR_ERR_OR_ZERO(dn));
 	return dn;
 }
 
@@ -414,6 +418,7 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 					struct fid *fid,
 					int fh_len, int fh_type)
 {
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_nfs_confh *cfh = (void *)fid->raw;
 	struct dentry *dentry;
 
@@ -427,7 +432,7 @@ static struct dentry *ceph_fh_to_parent(struct super_block *sb,
 	if (fh_len < sizeof(*cfh) / 4)
 		return NULL;
 
-	dout("fh_to_parent %llx\n", cfh->parent_ino);
+	doutc(fsc->client, "%llx\n", cfh->parent_ino);
 	dentry = __get_parent(sb, NULL, cfh->ino);
 	if (unlikely(dentry == ERR_PTR(-ENOENT)))
 		dentry = __fh_to_dentry(sb, cfh->parent_ino);
@@ -526,8 +531,8 @@ static int __get_snap_name(struct dentry *parent, char *name,
 	if (req)
 		ceph_mdsc_put_request(req);
 	kfree(last_name);
-	dout("get_snap_name %p ino %llx.%llx err=%d\n",
-	     child, ceph_vinop(inode), err);
+	doutc(fsc->client, "child dentry %p %p %llx.%llx err=%d\n", child,
+	      inode, ceph_vinop(inode), err);
 	return err;
 }
 
@@ -588,9 +593,9 @@ static int ceph_get_name(struct dentry *parent, char *name,
 		ceph_fname_free_buffer(dir, &oname);
 	}
 out:
-	dout("get_name %p ino %llx.%llx err %d %s%s\n",
-		     child, ceph_vinop(inode), err,
-		     err ? "" : "name ", err ? "" : name);
+	doutc(mdsc->fsc->client, "child dentry %p %p %llx.%llx err %d %s%s\n",
+	      child, inode, ceph_vinop(inode), err, err ? "" : "name ",
+	      err ? "" : name);
 	ceph_mdsc_put_request(req);
 	return err;
 }
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a03b11cf7887..59a0f149ec82 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -19,8 +19,9 @@
 #include "io.h"
 #include "metric.h"
 
-static __le32 ceph_flags_sys2wire(u32 flags)
+static __le32 ceph_flags_sys2wire(struct ceph_mds_client *mdsc, u32 flags)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	u32 wire_flags = 0;
 
 	switch (flags & O_ACCMODE) {
@@ -48,7 +49,7 @@ static __le32 ceph_flags_sys2wire(u32 flags)
 #undef ceph_sys2wire
 
 	if (flags)
-		dout("unused open flags: %x\n", flags);
+		doutc(cl, "unused open flags: %x\n", flags);
 
 	return cpu_to_le32(wire_flags);
 }
@@ -189,7 +190,7 @@ prepare_open_request(struct super_block *sb, int flags, int create_mode)
 	if (IS_ERR(req))
 		goto out;
 	req->r_fmode = ceph_flags_to_mode(flags);
-	req->r_args.open.flags = ceph_flags_sys2wire(flags);
+	req->r_args.open.flags = ceph_flags_sys2wire(mdsc, flags);
 	req->r_args.open.mode = cpu_to_le32(create_mode);
 out:
 	return req;
@@ -201,11 +202,12 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mount_options *opt =
 		ceph_inode_to_fs_client(&ci->netfs.inode)->mount_options;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_file_info *fi;
 	int ret;
 
-	dout("%s %p %p 0%o (%s)\n", __func__, inode, file,
-			inode->i_mode, isdir ? "dir" : "regular");
+	doutc(cl, "%p %llx.%llx %p 0%o (%s)\n", inode, ceph_vinop(inode),
+	      file, inode->i_mode, isdir ? "dir" : "regular");
 	BUG_ON(inode->i_fop->release != ceph_release);
 
 	if (isdir) {
@@ -259,6 +261,7 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
  */
 static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int ret = 0;
 
 	switch (inode->i_mode & S_IFMT) {
@@ -271,13 +274,13 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 		break;
 
 	case S_IFLNK:
-		dout("init_file %p %p 0%o (symlink)\n", inode, file,
-		     inode->i_mode);
+		doutc(cl, "%p %llx.%llx %p 0%o (symlink)\n", inode,
+		      ceph_vinop(inode), file, inode->i_mode);
 		break;
 
 	default:
-		dout("init_file %p %p 0%o (special)\n", inode, file,
-		     inode->i_mode);
+		doutc(cl, "%p %llx.%llx %p 0%o (special)\n", inode,
+		      ceph_vinop(inode), file, inode->i_mode);
 		/*
 		 * we need to drop the open ref now, since we don't
 		 * have .release set to ceph_release.
@@ -296,6 +299,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 int ceph_renew_caps(struct inode *inode, int fmode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
 	int err, flags, wanted;
@@ -307,8 +311,9 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap)) {
 		int issued = __ceph_caps_issued(ci, NULL);
 		spin_unlock(&ci->i_ceph_lock);
-		dout("renew caps %p want %s issued %s updating mds_wanted\n",
-		     inode, ceph_cap_string(wanted), ceph_cap_string(issued));
+		doutc(cl, "%p %llx.%llx want %s issued %s updating mds_wanted\n",
+		      inode, ceph_vinop(inode), ceph_cap_string(wanted),
+		      ceph_cap_string(issued));
 		ceph_check_caps(ci, 0);
 		return 0;
 	}
@@ -339,7 +344,8 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	ceph_mdsc_put_request(req);
 out:
-	dout("renew caps %p open result=%d\n", inode, err);
+	doutc(cl, "%p %llx.%llx open result=%d\n", inode, ceph_vinop(inode),
+	      err);
 	return err < 0 ? err : 0;
 }
 
@@ -353,6 +359,7 @@ int ceph_open(struct inode *inode, struct file *file)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_file_info *fi = file->private_data;
@@ -360,7 +367,7 @@ int ceph_open(struct inode *inode, struct file *file)
 	int flags, fmode, wanted;
 
 	if (fi) {
-		dout("open file %p is already opened\n", file);
+		doutc(cl, "file %p is already opened\n", file);
 		return 0;
 	}
 
@@ -374,8 +381,8 @@ int ceph_open(struct inode *inode, struct file *file)
 			return err;
 	}
 
-	dout("open inode %p ino %llx.%llx file %p flags %d (%d)\n", inode,
-	     ceph_vinop(inode), file, flags, file->f_flags);
+	doutc(cl, "%p %llx.%llx file %p flags %d (%d)\n", inode,
+	      ceph_vinop(inode), file, flags, file->f_flags);
 	fmode = ceph_flags_to_mode(flags);
 	wanted = ceph_caps_for_mode(fmode);
 
@@ -399,9 +406,9 @@ int ceph_open(struct inode *inode, struct file *file)
 		int mds_wanted = __ceph_caps_mds_wanted(ci, true);
 		int issued = __ceph_caps_issued(ci, NULL);
 
-		dout("open %p fmode %d want %s issued %s using existing\n",
-		     inode, fmode, ceph_cap_string(wanted),
-		     ceph_cap_string(issued));
+		doutc(cl, "open %p fmode %d want %s issued %s using existing\n",
+		      inode, fmode, ceph_cap_string(wanted),
+		      ceph_cap_string(issued));
 		__ceph_touch_fmode(ci, mdsc, fmode);
 		spin_unlock(&ci->i_ceph_lock);
 
@@ -421,7 +428,7 @@ int ceph_open(struct inode *inode, struct file *file)
 
 	spin_unlock(&ci->i_ceph_lock);
 
-	dout("open fmode %d wants %s\n", fmode, ceph_cap_string(wanted));
+	doutc(cl, "open fmode %d wants %s\n", fmode, ceph_cap_string(wanted));
 	req = prepare_open_request(inode->i_sb, flags, 0);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -435,7 +442,7 @@ int ceph_open(struct inode *inode, struct file *file)
 	if (!err)
 		err = ceph_init_file(inode, file, req->r_fmode);
 	ceph_mdsc_put_request(req);
-	dout("open result=%d on %llx.%llx\n", err, ceph_vinop(inode));
+	doutc(cl, "open result=%d on %llx.%llx\n", err, ceph_vinop(inode));
 out:
 	return err;
 }
@@ -515,6 +522,7 @@ static int try_prep_async_create(struct inode *dir, struct dentry *dentry,
 
 static void restore_deleg_ino(struct inode *dir, u64 ino)
 {
+	struct ceph_client *cl = ceph_inode_to_client(dir);
 	struct ceph_inode_info *ci = ceph_inode(dir);
 	struct ceph_mds_session *s = NULL;
 
@@ -525,7 +533,8 @@ static void restore_deleg_ino(struct inode *dir, u64 ino)
 	if (s) {
 		int err = ceph_restore_deleg_ino(s, ino);
 		if (err)
-			pr_warn("ceph: unable to restore delegated ino 0x%llx to session: %d\n",
+			pr_warn_client(cl,
+				"unable to restore delegated ino 0x%llx to session: %d\n",
 				ino, err);
 		ceph_put_mds_session(s);
 	}
@@ -557,6 +566,7 @@ static void wake_async_create_waiters(struct inode *inode,
 static void ceph_async_create_cb(struct ceph_mds_client *mdsc,
                                  struct ceph_mds_request *req)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct dentry *dentry = req->r_dentry;
 	struct inode *dinode = d_inode(dentry);
 	struct inode *tinode = req->r_target_inode;
@@ -577,7 +587,8 @@ static void ceph_async_create_cb(struct ceph_mds_client *mdsc,
 		char *path = ceph_mdsc_build_path(mdsc, req->r_dentry, &pathlen,
 						  &base, 0);
 
-		pr_warn("async create failure path=(%llx)%s result=%d!\n",
+		pr_warn_client(cl,
+			"async create failure path=(%llx)%s result=%d!\n",
 			base, IS_ERR(path) ? "<<bad>>" : path, result);
 		ceph_mdsc_free_path(path, pathlen);
 
@@ -596,14 +607,15 @@ static void ceph_async_create_cb(struct ceph_mds_client *mdsc,
 		u64 ino = ceph_vino(tinode).ino;
 
 		if (req->r_deleg_ino != ino)
-			pr_warn("%s: inode number mismatch! err=%d deleg_ino=0x%llx target=0x%llx\n",
-				__func__, req->r_err, req->r_deleg_ino, ino);
+			pr_warn_client(cl,
+				"inode number mismatch! err=%d deleg_ino=0x%llx target=0x%llx\n",
+				req->r_err, req->r_deleg_ino, ino);
 
 		mapping_set_error(tinode->i_mapping, result);
 		wake_async_create_waiters(tinode, req->r_session);
 	} else if (!result) {
-		pr_warn("%s: no req->r_target_inode for 0x%llx\n", __func__,
-			req->r_deleg_ino);
+		pr_warn_client(cl, "no req->r_target_inode for 0x%llx\n",
+			       req->r_deleg_ino);
 	}
 out:
 	ceph_mdsc_release_dir_caps(req);
@@ -625,6 +637,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 	struct timespec64 now;
 	struct ceph_string *pool_ns;
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_vino vino = { .ino = req->r_deleg_ino,
 				  .snap = CEPH_NOSNAP };
 
@@ -683,7 +696,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 			      req->r_fmode, NULL);
 	up_read(&mdsc->snap_rwsem);
 	if (ret) {
-		dout("%s failed to fill inode: %d\n", __func__, ret);
+		doutc(cl, "failed to fill inode: %d\n", ret);
 		ceph_dir_clear_complete(dir);
 		if (!d_unhashed(dentry))
 			d_drop(dentry);
@@ -691,8 +704,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 	} else {
 		struct dentry *dn;
 
-		dout("%s d_adding new inode 0x%llx to 0x%llx/%s\n", __func__,
-			vino.ino, ceph_ino(dir), dentry->d_name.name);
+		doutc(cl, "d_adding new inode 0x%llx to 0x%llx/%s\n",
+		      vino.ino, ceph_ino(dir), dentry->d_name.name);
 		ceph_dir_clear_ordered(dir);
 		ceph_init_inode_acls(inode, as_ctx);
 		if (inode->i_state & I_NEW) {
@@ -731,6 +744,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		     struct file *file, unsigned flags, umode_t mode)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct inode *new_inode = NULL;
@@ -740,9 +754,9 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	int mask;
 	int err;
 
-	dout("atomic_open %p dentry %p '%pd' %s flags %d mode 0%o\n",
-	     dir, dentry, dentry,
-	     d_unhashed(dentry) ? "unhashed" : "hashed", flags, mode);
+	doutc(cl, "%p %llx.%llx dentry %p '%pd' %s flags %d mode 0%o\n",
+	      dir, ceph_vinop(dir), dentry, dentry,
+	      d_unhashed(dentry) ? "unhashed" : "hashed", flags, mode);
 
 	if (dentry->d_name.len > NAME_MAX)
 		return -ENAMETOOLONG;
@@ -880,17 +894,18 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		goto out_req;
 	if (dn || d_really_is_negative(dentry) || d_is_symlink(dentry)) {
 		/* make vfs retry on splice, ENOENT, or symlink */
-		dout("atomic_open finish_no_open on dn %p\n", dn);
+		doutc(cl, "finish_no_open on dn %p\n", dn);
 		err = finish_no_open(file, dn);
 	} else {
 		if (IS_ENCRYPTED(dir) &&
 		    !fscrypt_has_permitted_context(dir, d_inode(dentry))) {
-			pr_warn("Inconsistent encryption context (parent %llx:%llx child %llx:%llx)\n",
+			pr_warn_client(cl,
+				"Inconsistent encryption context (parent %llx:%llx child %llx:%llx)\n",
 				ceph_vinop(dir), ceph_vinop(d_inode(dentry)));
 			goto out_req;
 		}
 
-		dout("atomic_open finish_open on dn %p\n", dn);
+		doutc(cl, "finish_open on dn %p\n", dn);
 		if (req->r_op == CEPH_MDS_OP_CREATE && req->r_reply_info.has_create_ino) {
 			struct inode *newino = d_inode(dentry);
 
@@ -905,17 +920,19 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	iput(new_inode);
 out_ctx:
 	ceph_release_acl_sec_ctx(&as_ctx);
-	dout("atomic_open result=%d\n", err);
+	doutc(cl, "result=%d\n", err);
 	return err;
 }
 
 int ceph_release(struct inode *inode, struct file *file)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	if (S_ISDIR(inode->i_mode)) {
 		struct ceph_dir_file_info *dfi = file->private_data;
-		dout("release inode %p dir file %p\n", inode, file);
+		doutc(cl, "%p %llx.%llx dir file %p\n", inode,
+		      ceph_vinop(inode), file);
 		WARN_ON(!list_empty(&dfi->file_info.rw_contexts));
 
 		ceph_put_fmode(ci, dfi->file_info.fmode, 1);
@@ -927,7 +944,8 @@ int ceph_release(struct inode *inode, struct file *file)
 		kmem_cache_free(ceph_dir_file_cachep, dfi);
 	} else {
 		struct ceph_file_info *fi = file->private_data;
-		dout("release inode %p regular file %p\n", inode, file);
+		doutc(cl, "%p %llx.%llx regular file %p\n", inode,
+		      ceph_vinop(inode), file);
 		WARN_ON(!list_empty(&fi->rw_contexts));
 
 		ceph_fscache_unuse_cookie(inode, file->f_mode & FMODE_WRITE);
@@ -963,6 +981,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	ssize_t ret;
 	u64 off = *ki_pos;
@@ -971,7 +990,8 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 	bool sparse = IS_ENCRYPTED(inode) || ceph_test_mount_opt(fsc, SPARSEREAD);
 	u64 objver = 0;
 
-	dout("sync_read on inode %p %llx~%llx\n", inode, *ki_pos, len);
+	doutc(cl, "on inode %p %llx.%llx %llx~%llx\n", inode,
+	      ceph_vinop(inode), *ki_pos, len);
 
 	if (ceph_inode_is_shutdown(inode))
 		return -EIO;
@@ -1006,8 +1026,8 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		/* determine new offset/length if encrypted */
 		ceph_fscrypt_adjust_off_and_len(inode, &read_off, &read_len);
 
-		dout("sync_read orig %llu~%llu reading %llu~%llu",
-		     off, len, read_off, read_len);
+		doutc(cl, "orig %llu~%llu reading %llu~%llu", off, len,
+		      read_off, read_len);
 
 		req = ceph_osdc_new_request(osdc, &ci->i_layout,
 					ci->i_vino, read_off, &read_len, 0, 1,
@@ -1061,8 +1081,8 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 			objver = req->r_version;
 
 		i_size = i_size_read(inode);
-		dout("sync_read %llu~%llu got %zd i_size %llu%s\n",
-		     off, len, ret, i_size, (more ? " MORE" : ""));
+		doutc(cl, "%llu~%llu got %zd i_size %llu%s\n", off, len,
+		      ret, i_size, (more ? " MORE" : ""));
 
 		/* Fix it to go to end of extent map */
 		if (sparse && ret >= 0)
@@ -1108,8 +1128,8 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 			int zlen = min(len - ret, i_size - off - ret);
 			int zoff = page_off + ret;
 
-			dout("sync_read zero gap %llu~%llu\n",
-				off + ret, off + ret + zlen);
+			doutc(cl, "zero gap %llu~%llu\n", off + ret,
+			      off + ret + zlen);
 			ceph_zero_page_vector_range(zoff, zlen, pages);
 			ret += zlen;
 		}
@@ -1154,7 +1174,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		if (last_objver)
 			*last_objver = objver;
 	}
-	dout("sync_read result %zd retry_op %d\n", ret, *retry_op);
+	doutc(cl, "result %zd retry_op %d\n", ret, *retry_op);
 	return ret;
 }
 
@@ -1163,9 +1183,11 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 
-	dout("sync_read on file %p %llx~%zx %s\n", file, iocb->ki_pos,
-	     iov_iter_count(to), (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
+	doutc(cl, "on file %p %llx~%zx %s\n", file, iocb->ki_pos,
+	      iov_iter_count(to),
+	      (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
 
 	return __ceph_sync_read(inode, &iocb->ki_pos, to, retry_op, NULL);
 }
@@ -1193,6 +1215,7 @@ static void ceph_aio_retry_work(struct work_struct *work);
 static void ceph_aio_complete(struct inode *inode,
 			      struct ceph_aio_request *aio_req)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int ret;
 
@@ -1206,7 +1229,7 @@ static void ceph_aio_complete(struct inode *inode,
 	if (!ret)
 		ret = aio_req->total_len;
 
-	dout("ceph_aio_complete %p rc %d\n", inode, ret);
+	doutc(cl, "%p %llx.%llx rc %d\n", inode, ceph_vinop(inode), ret);
 
 	if (ret >= 0 && aio_req->write) {
 		int dirty;
@@ -1245,11 +1268,13 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 	struct ceph_client_metric *metric = &ceph_sb_to_mdsc(inode->i_sb)->metric;
 	unsigned int len = osd_data->bvec_pos.iter.bi_size;
 	bool sparse = (op->op == CEPH_OSD_OP_SPARSE_READ);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 
 	BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_BVECS);
 	BUG_ON(!osd_data->num_bvecs);
 
-	dout("ceph_aio_complete_req %p rc %d bytes %u\n", inode, rc, len);
+	doutc(cl, "req %p inode %p %llx.%llx, rc %d bytes %u\n", req,
+	      inode, ceph_vinop(inode), rc, len);
 
 	if (rc == -EOLDSNAPC) {
 		struct ceph_aio_work *aio_work;
@@ -1390,6 +1415,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_client_metric *metric = &fsc->mdsc->metric;
 	struct ceph_vino vino;
 	struct ceph_osd_request *req;
@@ -1408,9 +1434,9 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
 		return -EROFS;
 
-	dout("sync_direct_%s on file %p %lld~%u snapc %p seq %lld\n",
-	     (write ? "write" : "read"), file, pos, (unsigned)count,
-	     snapc, snapc ? snapc->seq : 0);
+	doutc(cl, "sync_direct_%s on file %p %lld~%u snapc %p seq %lld\n",
+	      (write ? "write" : "read"), file, pos, (unsigned)count,
+	      snapc, snapc ? snapc->seq : 0);
 
 	if (write) {
 		int ret2;
@@ -1421,7 +1447,8 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 					pos >> PAGE_SHIFT,
 					(pos + count - 1) >> PAGE_SHIFT);
 		if (ret2 < 0)
-			dout("invalidate_inode_pages2_range returned %d\n", ret2);
+			doutc(cl, "invalidate_inode_pages2_range returned %d\n",
+			      ret2);
 
 		flags = /* CEPH_OSD_FLAG_ORDERSNAP | */ CEPH_OSD_FLAG_WRITE;
 	} else {
@@ -1617,6 +1644,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_osd_request *req;
 	struct page **pages;
@@ -1631,8 +1659,8 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
 		return -EROFS;
 
-	dout("sync_write on file %p %lld~%u snapc %p seq %lld\n",
-	     file, pos, (unsigned)count, snapc, snapc->seq);
+	doutc(cl, "on file %p %lld~%u snapc %p seq %lld\n", file, pos,
+	      (unsigned)count, snapc, snapc->seq);
 
 	ret = filemap_write_and_wait_range(inode->i_mapping,
 					   pos, pos + count - 1);
@@ -1676,9 +1704,9 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		last = (pos + len) != (write_pos + write_len);
 		rmw = first || last;
 
-		dout("sync_write ino %llx %lld~%llu adjusted %lld~%llu -- %srmw\n",
-		     ci->i_vino.ino, pos, len, write_pos, write_len,
-		     rmw ? "" : "no ");
+		doutc(cl, "ino %llx %lld~%llu adjusted %lld~%llu -- %srmw\n",
+		      ci->i_vino.ino, pos, len, write_pos, write_len,
+		      rmw ? "" : "no ");
 
 		/*
 		 * The data is emplaced into the page as it would be if it were
@@ -1887,7 +1915,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			left -= ret;
 		}
 		if (ret < 0) {
-			dout("sync_write write failed with %d\n", ret);
+			doutc(cl, "write failed with %d\n", ret);
 			ceph_release_page_vector(pages, num_pages);
 			break;
 		}
@@ -1897,7 +1925,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 							 write_pos, write_len,
 							 GFP_KERNEL);
 			if (ret < 0) {
-				dout("encryption failed with %d\n", ret);
+				doutc(cl, "encryption failed with %d\n", ret);
 				ceph_release_page_vector(pages, num_pages);
 				break;
 			}
@@ -1916,7 +1944,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			break;
 		}
 
-		dout("sync_write write op %lld~%llu\n", write_pos, write_len);
+		doutc(cl, "write op %lld~%llu\n", write_pos, write_len);
 		osd_req_op_extent_osd_data_pages(req, rmw ? 1 : 0, pages, write_len,
 						 offset_in_page(write_pos), false,
 						 true);
@@ -1947,7 +1975,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 					  req->r_end_latency, len, ret);
 		ceph_osdc_put_request(req);
 		if (ret != 0) {
-			dout("sync_write osd write returned %d\n", ret);
+			doutc(cl, "osd write returned %d\n", ret);
 			/* Version changed! Must re-do the rmw cycle */
 			if ((assert_ver && (ret == -ERANGE || ret == -EOVERFLOW)) ||
 			    (!assert_ver && ret == -EEXIST)) {
@@ -1977,13 +2005,13 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 				pos >> PAGE_SHIFT,
 				(pos + len - 1) >> PAGE_SHIFT);
 		if (ret < 0) {
-			dout("invalidate_inode_pages2_range returned %d\n",
-			     ret);
+			doutc(cl, "invalidate_inode_pages2_range returned %d\n",
+			      ret);
 			ret = 0;
 		}
 		pos += len;
 		written += len;
-		dout("sync_write written %d\n", written);
+		doutc(cl, "written %d\n", written);
 		if (pos > i_size_read(inode)) {
 			check_caps = ceph_inode_set_size(inode, pos);
 			if (check_caps)
@@ -1997,7 +2025,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		ret = written;
 		iocb->ki_pos = pos;
 	}
-	dout("sync_write returning %d\n", ret);
+	doutc(cl, "returning %d\n", ret);
 	return ret;
 }
 
@@ -2016,13 +2044,14 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	bool direct_lock = iocb->ki_flags & IOCB_DIRECT;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	ssize_t ret;
 	int want = 0, got = 0;
 	int retry_op = 0, read = 0;
 
 again:
-	dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
-	     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len, inode);
+	doutc(cl, "%llu~%u trying to get caps on %p %llx.%llx\n",
+	      iocb->ki_pos, (unsigned)len, inode, ceph_vinop(inode));
 
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
@@ -2050,9 +2079,9 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	    (iocb->ki_flags & IOCB_DIRECT) ||
 	    (fi->flags & CEPH_F_SYNC)) {
 
-		dout("aio_sync_read %p %llx.%llx %llu~%u got cap refs on %s\n",
-		     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
-		     ceph_cap_string(got));
+		doutc(cl, "sync %p %llx.%llx %llu~%u got cap refs on %s\n",
+		      inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
+		      ceph_cap_string(got));
 
 		if (!ceph_has_inline_data(ci)) {
 			if (!retry_op &&
@@ -2070,16 +2099,16 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 	} else {
 		CEPH_DEFINE_RW_CONTEXT(rw_ctx, got);
-		dout("aio_read %p %llx.%llx %llu~%u got cap refs on %s\n",
-		     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
-		     ceph_cap_string(got));
+		doutc(cl, "async %p %llx.%llx %llu~%u got cap refs on %s\n",
+		      inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
+		      ceph_cap_string(got));
 		ceph_add_rw_context(fi, &rw_ctx);
 		ret = generic_file_read_iter(iocb, to);
 		ceph_del_rw_context(fi, &rw_ctx);
 	}
 
-	dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
-	     inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
+	doutc(cl, "%p %llx.%llx dropping cap refs on %s = %d\n",
+	      inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
 	ceph_put_cap_refs(ci, got);
 
 	if (direct_lock)
@@ -2139,8 +2168,8 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		/* hit EOF or hole? */
 		if (retry_op == CHECK_EOF && iocb->ki_pos < i_size &&
 		    ret < len) {
-			dout("sync_read hit hole, ppos %lld < size %lld"
-			     ", reading more\n", iocb->ki_pos, i_size);
+			doutc(cl, "hit hole, ppos %lld < size %lld, reading more\n",
+			      iocb->ki_pos, i_size);
 
 			read += ret;
 			len -= ret;
@@ -2235,6 +2264,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_cap_flush *prealloc_cf;
 	ssize_t count, written = 0;
@@ -2302,8 +2332,9 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (err)
 		goto out;
 
-	dout("aio_write %p %llx.%llx %llu~%zd getting caps. i_size %llu\n",
-	     inode, ceph_vinop(inode), pos, count, i_size_read(inode));
+	doutc(cl, "%p %llx.%llx %llu~%zd getting caps. i_size %llu\n",
+	      inode, ceph_vinop(inode), pos, count,
+	      i_size_read(inode));
 	if (!(fi->flags & CEPH_F_SYNC) && !direct_lock)
 		want |= CEPH_CAP_FILE_BUFFER;
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
@@ -2319,8 +2350,8 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	inode_inc_iversion_raw(inode);
 
-	dout("aio_write %p %llx.%llx %llu~%zd got cap refs on %s\n",
-	     inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
+	doutc(cl, "%p %llx.%llx %llu~%zd got cap refs on %s\n",
+	      inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
 
 	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
 	    (iocb->ki_flags & IOCB_DIRECT) || (fi->flags & CEPH_F_SYNC) ||
@@ -2380,14 +2411,14 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ceph_check_caps(ci, CHECK_CAPS_FLUSH);
 	}
 
-	dout("aio_write %p %llx.%llx %llu~%u  dropping cap refs on %s\n",
-	     inode, ceph_vinop(inode), pos, (unsigned)count,
-	     ceph_cap_string(got));
+	doutc(cl, "%p %llx.%llx %llu~%u  dropping cap refs on %s\n",
+	      inode, ceph_vinop(inode), pos, (unsigned)count,
+	      ceph_cap_string(got));
 	ceph_put_cap_refs(ci, got);
 
 	if (written == -EOLDSNAPC) {
-		dout("aio_write %p %llx.%llx %llu~%u" "got EOLDSNAPC, retrying\n",
-		     inode, ceph_vinop(inode), pos, (unsigned)count);
+		doutc(cl, "%p %llx.%llx %llu~%u" "got EOLDSNAPC, retrying\n",
+		      inode, ceph_vinop(inode), pos, (unsigned)count);
 		goto retry_snap;
 	}
 
@@ -2559,14 +2590,15 @@ static long ceph_fallocate(struct file *file, int mode,
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_cap_flush *prealloc_cf;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int want, got = 0;
 	int dirty;
 	int ret = 0;
 	loff_t endoff = 0;
 	loff_t size;
 
-	dout("%s %p %llx.%llx mode %x, offset %llu length %llu\n", __func__,
-	     inode, ceph_vinop(inode), mode, offset, length);
+	doutc(cl, "%p %llx.%llx mode %x, offset %llu length %llu\n",
+	      inode, ceph_vinop(inode), mode, offset, length);
 
 	if (mode != (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
@@ -2695,6 +2727,7 @@ static void put_rd_wr_caps(struct ceph_inode_info *src_ci, int src_got,
 static int is_file_size_ok(struct inode *src_inode, struct inode *dst_inode,
 			   loff_t src_off, loff_t dst_off, size_t len)
 {
+	struct ceph_client *cl = ceph_inode_to_client(src_inode);
 	loff_t size, endoff;
 
 	size = i_size_read(src_inode);
@@ -2705,8 +2738,8 @@ static int is_file_size_ok(struct inode *src_inode, struct inode *dst_inode,
 	 * inode.
 	 */
 	if (src_off + len > size) {
-		dout("Copy beyond EOF (%llu + %zu > %llu)\n",
-		     src_off, len, size);
+		doutc(cl, "Copy beyond EOF (%llu + %zu > %llu)\n", src_off,
+		      len, size);
 		return -EOPNOTSUPP;
 	}
 	size = i_size_read(dst_inode);
@@ -2782,6 +2815,7 @@ static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 *src_off
 	u64 src_objnum, src_objoff, dst_objnum, dst_objoff;
 	u32 src_objlen, dst_objlen;
 	u32 object_size = src_ci->i_layout.object_size;
+	struct ceph_client *cl = fsc->client;
 	int ret;
 
 	src_oloc.pool = src_ci->i_layout.pool_id;
@@ -2823,9 +2857,10 @@ static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 *src_off
 		if (ret) {
 			if (ret == -EOPNOTSUPP) {
 				fsc->have_copy_from2 = false;
-				pr_notice("OSDs don't support copy-from2; disabling copy offload\n");
+				pr_notice_client(cl,
+					"OSDs don't support copy-from2; disabling copy offload\n");
 			}
-			dout("ceph_osdc_copy_from returned %d\n", ret);
+			doutc(cl, "returned %d\n", ret);
 			if (!bytes)
 				bytes = ret;
 			goto out;
@@ -2852,6 +2887,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	struct ceph_inode_info *dst_ci = ceph_inode(dst_inode);
 	struct ceph_cap_flush *prealloc_cf;
 	struct ceph_fs_client *src_fsc = ceph_inode_to_fs_client(src_inode);
+	struct ceph_client *cl = src_fsc->client;
 	loff_t size;
 	ssize_t ret = -EIO, bytes;
 	u64 src_objnum, dst_objnum, src_objoff, dst_objoff;
@@ -2894,7 +2930,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	    (src_ci->i_layout.stripe_count != 1) ||
 	    (dst_ci->i_layout.stripe_count != 1) ||
 	    (src_ci->i_layout.object_size != dst_ci->i_layout.object_size)) {
-		dout("Invalid src/dst files layout\n");
+		doutc(cl, "Invalid src/dst files layout\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -2912,12 +2948,12 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	/* Start by sync'ing the source and destination files */
 	ret = file_write_and_wait_range(src_file, src_off, (src_off + len));
 	if (ret < 0) {
-		dout("failed to write src file (%zd)\n", ret);
+		doutc(cl, "failed to write src file (%zd)\n", ret);
 		goto out;
 	}
 	ret = file_write_and_wait_range(dst_file, dst_off, (dst_off + len));
 	if (ret < 0) {
-		dout("failed to write dst file (%zd)\n", ret);
+		doutc(cl, "failed to write dst file (%zd)\n", ret);
 		goto out;
 	}
 
@@ -2929,7 +2965,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	err = get_rd_wr_caps(src_file, &src_got,
 			     dst_file, (dst_off + len), &dst_got);
 	if (err < 0) {
-		dout("get_rd_wr_caps returned %d\n", err);
+		doutc(cl, "get_rd_wr_caps returned %d\n", err);
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -2944,7 +2980,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 					    dst_off >> PAGE_SHIFT,
 					    (dst_off + len) >> PAGE_SHIFT);
 	if (ret < 0) {
-		dout("Failed to invalidate inode pages (%zd)\n", ret);
+		doutc(cl, "Failed to invalidate inode pages (%zd)\n",
+			    ret);
 		ret = 0; /* XXX */
 	}
 	ceph_calc_file_object_mapping(&src_ci->i_layout, src_off,
@@ -2965,7 +3002,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	 * starting at the src_off
 	 */
 	if (src_objoff) {
-		dout("Initial partial copy of %u bytes\n", src_objlen);
+		doutc(cl, "Initial partial copy of %u bytes\n", src_objlen);
 
 		/*
 		 * we need to temporarily drop all caps as we'll be calling
@@ -2976,7 +3013,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 				       &dst_off, src_objlen, flags);
 		/* Abort on short copies or on error */
 		if (ret < (long)src_objlen) {
-			dout("Failed partial copy (%zd)\n", ret);
+			doutc(cl, "Failed partial copy (%zd)\n", ret);
 			goto out;
 		}
 		len -= ret;
@@ -2998,7 +3035,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 			ret = bytes;
 		goto out_caps;
 	}
-	dout("Copied %zu bytes out of %zu\n", bytes, len);
+	doutc(cl, "Copied %zu bytes out of %zu\n", bytes, len);
 	len -= bytes;
 	ret += bytes;
 
@@ -3026,13 +3063,13 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	 * there were errors in remote object copies (len >= object_size).
 	 */
 	if (len && (len < src_ci->i_layout.object_size)) {
-		dout("Final partial copy of %zu bytes\n", len);
+		doutc(cl, "Final partial copy of %zu bytes\n", len);
 		bytes = do_splice_direct(src_file, &src_off, dst_file,
 					 &dst_off, len, flags);
 		if (bytes > 0)
 			ret += bytes;
 		else
-			dout("Failed partial copy (%zd)\n", bytes);
+			doutc(cl, "Failed partial copy (%zd)\n", bytes);
 	}
 
 out:
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index db6977c15c28..808b5a69f028 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -129,6 +129,8 @@ void ceph_as_ctx_to_req(struct ceph_mds_request *req,
 struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino,
 			     struct inode *newino)
 {
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct inode *inode;
 
 	if (ceph_vino_is_reserved(vino))
@@ -145,12 +147,13 @@ struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino,
 	}
 
 	if (!inode) {
-		dout("No inode found for %llx.%llx\n", vino.ino, vino.snap);
+		doutc(cl, "no inode found for %llx.%llx\n", vino.ino, vino.snap);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	dout("get_inode on %llu=%llx.%llx got %p new %d\n", ceph_present_inode(inode),
-	     ceph_vinop(inode), inode, !!(inode->i_state & I_NEW));
+	doutc(cl, "on %llx=%llx.%llx got %p new %d\n",
+	      ceph_present_inode(inode), ceph_vinop(inode), inode,
+	      !!(inode->i_state & I_NEW));
 	return inode;
 }
 
@@ -159,6 +162,7 @@ struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino,
  */
 struct inode *ceph_get_snapdir(struct inode *parent)
 {
+	struct ceph_client *cl = ceph_inode_to_client(parent);
 	struct ceph_vino vino = {
 		.ino = ceph_ino(parent),
 		.snap = CEPH_SNAPDIR,
@@ -171,14 +175,14 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		return inode;
 
 	if (!S_ISDIR(parent->i_mode)) {
-		pr_warn_once("bad snapdir parent type (mode=0%o)\n",
-			     parent->i_mode);
+		pr_warn_once_client(cl, "bad snapdir parent type (mode=0%o)\n",
+				    parent->i_mode);
 		goto err;
 	}
 
 	if (!(inode->i_state & I_NEW) && !S_ISDIR(inode->i_mode)) {
-		pr_warn_once("bad snapdir inode type (mode=0%o)\n",
-			     inode->i_mode);
+		pr_warn_once_client(cl, "bad snapdir inode type (mode=0%o)\n",
+				    inode->i_mode);
 		goto err;
 	}
 
@@ -203,7 +207,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 			inode->i_flags |= S_ENCRYPTED;
 			ci->fscrypt_auth_len = pci->fscrypt_auth_len;
 		} else {
-			dout("Failed to alloc snapdir fscrypt_auth\n");
+			doutc(cl, "Failed to alloc snapdir fscrypt_auth\n");
 			ret = -ENOMEM;
 			goto err;
 		}
@@ -249,6 +253,8 @@ const struct inode_operations ceph_file_iops = {
 static struct ceph_inode_frag *__get_or_create_frag(struct ceph_inode_info *ci,
 						    u32 f)
 {
+	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct ceph_inode_frag *frag;
@@ -279,8 +285,7 @@ static struct ceph_inode_frag *__get_or_create_frag(struct ceph_inode_info *ci,
 	rb_link_node(&frag->node, parent, p);
 	rb_insert_color(&frag->node, &ci->i_fragtree);
 
-	dout("get_or_create_frag added %llx.%llx frag %x\n",
-	     ceph_vinop(&ci->netfs.inode), f);
+	doutc(cl, "added %p %llx.%llx frag %x\n", inode, ceph_vinop(inode), f);
 	return frag;
 }
 
@@ -313,6 +318,7 @@ struct ceph_inode_frag *__ceph_find_frag(struct ceph_inode_info *ci, u32 f)
 static u32 __ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
 			      struct ceph_inode_frag *pfrag, int *found)
 {
+	struct ceph_client *cl = ceph_inode_to_client(&ci->netfs.inode);
 	u32 t = ceph_frag_make(0, 0);
 	struct ceph_inode_frag *frag;
 	unsigned nway, i;
@@ -336,8 +342,8 @@ static u32 __ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
 
 		/* choose child */
 		nway = 1 << frag->split_by;
-		dout("choose_frag(%x) %x splits by %d (%d ways)\n", v, t,
-		     frag->split_by, nway);
+		doutc(cl, "frag(%x) %x splits by %d (%d ways)\n", v, t,
+		      frag->split_by, nway);
 		for (i = 0; i < nway; i++) {
 			n = ceph_frag_make_child(t, frag->split_by, i);
 			if (ceph_frag_contains_value(n, v)) {
@@ -347,7 +353,7 @@ static u32 __ceph_choose_frag(struct ceph_inode_info *ci, u32 v,
 		}
 		BUG_ON(i == nway);
 	}
-	dout("choose_frag(%x) = %x\n", v, t);
+	doutc(cl, "frag(%x) = %x\n", v, t);
 
 	return t;
 }
@@ -371,6 +377,7 @@ static int ceph_fill_dirfrag(struct inode *inode,
 			     struct ceph_mds_reply_dirfrag *dirinfo)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_frag *frag;
 	u32 id = le32_to_cpu(dirinfo->frag);
 	int mds = le32_to_cpu(dirinfo->auth);
@@ -395,14 +402,14 @@ static int ceph_fill_dirfrag(struct inode *inode,
 			goto out;
 		if (frag->split_by == 0) {
 			/* tree leaf, remove */
-			dout("fill_dirfrag removed %llx.%llx frag %x"
-			     " (no ref)\n", ceph_vinop(inode), id);
+			doutc(cl, "removed %p %llx.%llx frag %x (no ref)\n",
+			      inode, ceph_vinop(inode), id);
 			rb_erase(&frag->node, &ci->i_fragtree);
 			kfree(frag);
 		} else {
 			/* tree branch, keep and clear */
-			dout("fill_dirfrag cleared %llx.%llx frag %x"
-			     " referral\n", ceph_vinop(inode), id);
+			doutc(cl, "cleared %p %llx.%llx frag %x referral\n",
+			      inode, ceph_vinop(inode), id);
 			frag->mds = -1;
 			frag->ndist = 0;
 		}
@@ -415,8 +422,9 @@ static int ceph_fill_dirfrag(struct inode *inode,
 	if (IS_ERR(frag)) {
 		/* this is not the end of the world; we can continue
 		   with bad/inaccurate delegation info */
-		pr_err("fill_dirfrag ENOMEM on mds ref %llx.%llx fg %x\n",
-		       ceph_vinop(inode), le32_to_cpu(dirinfo->frag));
+		pr_err_client(cl, "ENOMEM on mds ref %p %llx.%llx fg %x\n",
+			      inode, ceph_vinop(inode),
+			      le32_to_cpu(dirinfo->frag));
 		err = -ENOMEM;
 		goto out;
 	}
@@ -425,8 +433,8 @@ static int ceph_fill_dirfrag(struct inode *inode,
 	frag->ndist = min_t(u32, ndist, CEPH_MAX_DIRFRAG_REP);
 	for (i = 0; i < frag->ndist; i++)
 		frag->dist[i] = le32_to_cpu(dirinfo->dist[i]);
-	dout("fill_dirfrag %llx.%llx frag %x ndist=%d\n",
-	     ceph_vinop(inode), frag->frag, frag->ndist);
+	doutc(cl, "%p %llx.%llx frag %x ndist=%d\n", inode,
+	      ceph_vinop(inode), frag->frag, frag->ndist);
 
 out:
 	mutex_unlock(&ci->i_fragtree_mutex);
@@ -454,6 +462,7 @@ static int ceph_fill_fragtree(struct inode *inode,
 			      struct ceph_frag_tree_head *fragtree,
 			      struct ceph_mds_reply_dirfrag *dirinfo)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_inode_frag *frag, *prev_frag = NULL;
 	struct rb_node *rb_node;
@@ -489,15 +498,15 @@ static int ceph_fill_fragtree(struct inode *inode,
 		     frag_tree_split_cmp, NULL);
 	}
 
-	dout("fill_fragtree %llx.%llx\n", ceph_vinop(inode));
+	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	rb_node = rb_first(&ci->i_fragtree);
 	for (i = 0; i < nsplits; i++) {
 		id = le32_to_cpu(fragtree->splits[i].frag);
 		split_by = le32_to_cpu(fragtree->splits[i].by);
 		if (split_by == 0 || ceph_frag_bits(id) + split_by > 24) {
-			pr_err("fill_fragtree %llx.%llx invalid split %d/%u, "
-			       "frag %x split by %d\n", ceph_vinop(inode),
-			       i, nsplits, id, split_by);
+			pr_err_client(cl, "%p %llx.%llx invalid split %d/%u, "
+			       "frag %x split by %d\n", inode,
+			       ceph_vinop(inode), i, nsplits, id, split_by);
 			continue;
 		}
 		frag = NULL;
@@ -529,7 +538,7 @@ static int ceph_fill_fragtree(struct inode *inode,
 		if (frag->split_by == 0)
 			ci->i_fragtree_nsplits++;
 		frag->split_by = split_by;
-		dout(" frag %x split by %d\n", frag->frag, frag->split_by);
+		doutc(cl, " frag %x split by %d\n", frag->frag, frag->split_by);
 		prev_frag = frag;
 	}
 	while (rb_node) {
@@ -554,6 +563,7 @@ static int ceph_fill_fragtree(struct inode *inode,
  */
 struct inode *ceph_alloc_inode(struct super_block *sb)
 {
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_inode_info *ci;
 	int i;
 
@@ -561,7 +571,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	if (!ci)
 		return NULL;
 
-	dout("alloc_inode %p\n", &ci->netfs.inode);
+	doutc(fsc->client, "%p\n", &ci->netfs.inode);
 
 	/* Set parameters for the netfs library */
 	netfs_inode_init(&ci->netfs, &ceph_netfs_ops);
@@ -675,10 +685,11 @@ void ceph_evict_inode(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_frag *frag;
 	struct rb_node *n;
 
-	dout("evict_inode %p ino %llx.%llx\n", inode, ceph_vinop(inode));
+	doutc(cl, "%p ino %llx.%llx\n", inode, ceph_vinop(inode));
 
 	percpu_counter_dec(&mdsc->metric.total_inodes);
 
@@ -701,8 +712,8 @@ void ceph_evict_inode(struct inode *inode)
 	 */
 	if (ci->i_snap_realm) {
 		if (ceph_snap(inode) == CEPH_NOSNAP) {
-			dout(" dropping residual ref to snap realm %p\n",
-			     ci->i_snap_realm);
+			doutc(cl, " dropping residual ref to snap realm %p\n",
+			      ci->i_snap_realm);
 			ceph_change_snap_realm(inode, NULL);
 		} else {
 			ceph_put_snapid_map(mdsc, ci->i_snapid_map);
@@ -743,15 +754,16 @@ static inline blkcnt_t calc_inode_blocks(u64 size)
 int ceph_fill_file_size(struct inode *inode, int issued,
 			u32 truncate_seq, u64 truncate_size, u64 size)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int queue_trunc = 0;
 	loff_t isize = i_size_read(inode);
 
 	if (ceph_seq_cmp(truncate_seq, ci->i_truncate_seq) > 0 ||
 	    (truncate_seq == ci->i_truncate_seq && size > isize)) {
-		dout("size %lld -> %llu\n", isize, size);
+		doutc(cl, "size %lld -> %llu\n", isize, size);
 		if (size > 0 && S_ISDIR(inode->i_mode)) {
-			pr_err("fill_file_size non-zero size for directory\n");
+			pr_err_client(cl, "non-zero size for directory\n");
 			size = 0;
 		}
 		i_size_write(inode, size);
@@ -764,8 +776,8 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 			ceph_fscache_update(inode);
 		ci->i_reported_size = size;
 		if (truncate_seq != ci->i_truncate_seq) {
-			dout("%s truncate_seq %u -> %u\n", __func__,
-			     ci->i_truncate_seq, truncate_seq);
+			doutc(cl, "truncate_seq %u -> %u\n",
+			      ci->i_truncate_seq, truncate_seq);
 			ci->i_truncate_seq = truncate_seq;
 
 			/* the MDS should have revoked these caps */
@@ -794,14 +806,15 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 	 * anyway.
 	 */
 	if (ceph_seq_cmp(truncate_seq, ci->i_truncate_seq) >= 0) {
-		dout("%s truncate_size %lld -> %llu, encrypted %d\n", __func__,
-		     ci->i_truncate_size, truncate_size, !!IS_ENCRYPTED(inode));
+		doutc(cl, "truncate_size %lld -> %llu, encrypted %d\n",
+		      ci->i_truncate_size, truncate_size,
+		      !!IS_ENCRYPTED(inode));
 
 		ci->i_truncate_size = truncate_size;
 
 		if (IS_ENCRYPTED(inode)) {
-			dout("%s truncate_pagecache_size %lld -> %llu\n",
-			     __func__, ci->i_truncate_pagecache_size, size);
+			doutc(cl, "truncate_pagecache_size %lld -> %llu\n",
+			      ci->i_truncate_pagecache_size, size);
 			ci->i_truncate_pagecache_size = size;
 		} else {
 			ci->i_truncate_pagecache_size = truncate_size;
@@ -814,6 +827,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 			 u64 time_warp_seq, struct timespec64 *ctime,
 			 struct timespec64 *mtime, struct timespec64 *atime)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct timespec64 ictime = inode_get_ctime(inode);
 	int warn = 0;
@@ -825,7 +839,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		      CEPH_CAP_XATTR_EXCL)) {
 		if (ci->i_version == 0 ||
 		    timespec64_compare(ctime, &ictime) > 0) {
-			dout("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
+			doutc(cl, "ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
 			     ictime.tv_sec, ictime.tv_nsec,
 			     ctime->tv_sec, ctime->tv_nsec);
 			inode_set_ctime_to_ts(inode, *ctime);
@@ -833,11 +847,10 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		if (ci->i_version == 0 ||
 		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
 			/* the MDS did a utimes() */
-			dout("mtime %lld.%09ld -> %lld.%09ld "
-			     "tw %d -> %d\n",
-			     inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
-			     mtime->tv_sec, mtime->tv_nsec,
-			     ci->i_time_warp_seq, (int)time_warp_seq);
+			doutc(cl, "mtime %lld.%09ld -> %lld.%09ld tw %d -> %d\n",
+			      inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
+			      mtime->tv_sec, mtime->tv_nsec,
+			      ci->i_time_warp_seq, (int)time_warp_seq);
 
 			inode->i_mtime = *mtime;
 			inode->i_atime = *atime;
@@ -845,17 +858,17 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		} else if (time_warp_seq == ci->i_time_warp_seq) {
 			/* nobody did utimes(); take the max */
 			if (timespec64_compare(mtime, &inode->i_mtime) > 0) {
-				dout("mtime %lld.%09ld -> %lld.%09ld inc\n",
-				     inode->i_mtime.tv_sec,
-				     inode->i_mtime.tv_nsec,
-				     mtime->tv_sec, mtime->tv_nsec);
+				doutc(cl, "mtime %lld.%09ld -> %lld.%09ld inc\n",
+				      inode->i_mtime.tv_sec,
+				      inode->i_mtime.tv_nsec,
+				      mtime->tv_sec, mtime->tv_nsec);
 				inode->i_mtime = *mtime;
 			}
 			if (timespec64_compare(atime, &inode->i_atime) > 0) {
-				dout("atime %lld.%09ld -> %lld.%09ld inc\n",
-				     inode->i_atime.tv_sec,
-				     inode->i_atime.tv_nsec,
-				     atime->tv_sec, atime->tv_nsec);
+				doutc(cl, "atime %lld.%09ld -> %lld.%09ld inc\n",
+				      inode->i_atime.tv_sec,
+				      inode->i_atime.tv_nsec,
+				      atime->tv_sec, atime->tv_nsec);
 				inode->i_atime = *atime;
 			}
 		} else if (issued & CEPH_CAP_FILE_EXCL) {
@@ -875,13 +888,16 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		}
 	}
 	if (warn) /* time_warp_seq shouldn't go backwards */
-		dout("%p mds time_warp_seq %llu < %u\n",
-		     inode, time_warp_seq, ci->i_time_warp_seq);
+		doutc(cl, "%p mds time_warp_seq %llu < %u\n", inode,
+		      time_warp_seq, ci->i_time_warp_seq);
 }
 
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
-static int decode_encrypted_symlink(const char *encsym, int enclen, u8 **decsym)
+static int decode_encrypted_symlink(struct ceph_mds_client *mdsc,
+				    const char *encsym,
+				    int enclen, u8 **decsym)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	int declen;
 	u8 *sym;
 
@@ -891,8 +907,9 @@ static int decode_encrypted_symlink(const char *encsym, int enclen, u8 **decsym)
 
 	declen = ceph_base64_decode(encsym, enclen, sym);
 	if (declen < 0) {
-		pr_err("%s: can't decode symlink (%d). Content: %.*s\n",
-		       __func__, declen, enclen, encsym);
+		pr_err_client(cl,
+			"can't decode symlink (%d). Content: %.*s\n",
+			declen, enclen, encsym);
 		kfree(sym);
 		return -EIO;
 	}
@@ -901,7 +918,9 @@ static int decode_encrypted_symlink(const char *encsym, int enclen, u8 **decsym)
 	return declen;
 }
 #else
-static int decode_encrypted_symlink(const char *encsym, int symlen, u8 **decsym)
+static int decode_encrypted_symlink(struct ceph_mds_client *mdsc,
+				    const char *encsym,
+				    int symlen, u8 **decsym)
 {
 	return -EOPNOTSUPP;
 }
@@ -918,6 +937,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		    struct ceph_cap_reservation *caps_reservation)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_reply_inode *info = iinfo->in;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int issued, new_issued, info_caps;
@@ -936,25 +956,26 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	lockdep_assert_held(&mdsc->snap_rwsem);
 
-	dout("%s %p ino %llx.%llx v %llu had %llu\n", __func__,
-	     inode, ceph_vinop(inode), le64_to_cpu(info->version),
-	     ci->i_version);
+	doutc(cl, "%p ino %llx.%llx v %llu had %llu\n", inode, ceph_vinop(inode),
+	      le64_to_cpu(info->version), ci->i_version);
 
 	/* Once I_NEW is cleared, we can't change type or dev numbers */
 	if (inode->i_state & I_NEW) {
 		inode->i_mode = mode;
 	} else {
 		if (inode_wrong_type(inode, mode)) {
-			pr_warn_once("inode type changed! (ino %llx.%llx is 0%o, mds says 0%o)\n",
-				     ceph_vinop(inode), inode->i_mode, mode);
+			pr_warn_once_client(cl,
+				"inode type changed! (ino %llx.%llx is 0%o, mds says 0%o)\n",
+				ceph_vinop(inode), inode->i_mode, mode);
 			return -ESTALE;
 		}
 
 		if ((S_ISCHR(mode) || S_ISBLK(mode)) && inode->i_rdev != rdev) {
-			pr_warn_once("dev inode rdev changed! (ino %llx.%llx is %u:%u, mds says %u:%u)\n",
-				     ceph_vinop(inode), MAJOR(inode->i_rdev),
-				     MINOR(inode->i_rdev), MAJOR(rdev),
-				     MINOR(rdev));
+			pr_warn_once_client(cl,
+				"dev inode rdev changed! (ino %llx.%llx is %u:%u, mds says %u:%u)\n",
+				ceph_vinop(inode), MAJOR(inode->i_rdev),
+				MINOR(inode->i_rdev), MAJOR(rdev),
+				MINOR(rdev));
 			return -ESTALE;
 		}
 	}
@@ -976,8 +997,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	if (iinfo->xattr_len > 4) {
 		xattr_blob = ceph_buffer_new(iinfo->xattr_len, GFP_NOFS);
 		if (!xattr_blob)
-			pr_err("%s ENOMEM xattr blob %d bytes\n", __func__,
-			       iinfo->xattr_len);
+			pr_err_client(cl, "ENOMEM xattr blob %d bytes\n",
+				      iinfo->xattr_len);
 	}
 
 	if (iinfo->pool_ns_len > 0)
@@ -1031,9 +1052,10 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		inode->i_mode = mode;
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(info->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(info->gid));
-		dout("%p mode 0%o uid.gid %d.%d\n", inode, inode->i_mode,
-		     from_kuid(&init_user_ns, inode->i_uid),
-		     from_kgid(&init_user_ns, inode->i_gid));
+		doutc(cl, "%p %llx.%llx mode 0%o uid.gid %d.%d\n", inode,
+		      ceph_vinop(inode), inode->i_mode,
+		      from_kuid(&init_user_ns, inode->i_uid),
+		      from_kgid(&init_user_ns, inode->i_gid));
 		ceph_decode_timespec64(&ci->i_btime, &iinfo->btime);
 		ceph_decode_timespec64(&ci->i_snap_btime, &iinfo->snap_btime);
 	}
@@ -1089,7 +1111,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 			if (size == round_up(fsize, CEPH_FSCRYPT_BLOCK_SIZE)) {
 				size = fsize;
 			} else {
-				pr_warn("fscrypt size mismatch: size=%llu fscrypt_file=%llu, discarding fscrypt_file size.\n",
+				pr_warn_client(cl,
+					"fscrypt size mismatch: size=%llu fscrypt_file=%llu, discarding fscrypt_file size.\n",
 					info->size, size);
 			}
 		}
@@ -1101,8 +1124,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		/* only update max_size on auth cap */
 		if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
 		    ci->i_max_size != le64_to_cpu(info->max_size)) {
-			dout("max_size %lld -> %llu\n", ci->i_max_size,
-					le64_to_cpu(info->max_size));
+			doutc(cl, "max_size %lld -> %llu\n",
+			    ci->i_max_size, le64_to_cpu(info->max_size));
 			ci->i_max_size = le64_to_cpu(info->max_size);
 		}
 	}
@@ -1165,15 +1188,17 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 			if (IS_ENCRYPTED(inode)) {
 				if (symlen != i_size_read(inode))
-					pr_err("%s %llx.%llx BAD symlink size %lld\n",
-						__func__, ceph_vinop(inode),
+					pr_err_client(cl,
+						"%p %llx.%llx BAD symlink size %lld\n",
+						inode, ceph_vinop(inode),
 						i_size_read(inode));
 
-				err = decode_encrypted_symlink(iinfo->symlink,
+				err = decode_encrypted_symlink(mdsc, iinfo->symlink,
 							       symlen, (u8 **)&sym);
 				if (err < 0) {
-					pr_err("%s decoding encrypted symlink failed: %d\n",
-						__func__, err);
+					pr_err_client(cl,
+						"decoding encrypted symlink failed: %d\n",
+						err);
 					goto out;
 				}
 				symlen = err;
@@ -1181,8 +1206,9 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 				inode->i_blocks = calc_inode_blocks(symlen);
 			} else {
 				if (symlen != i_size_read(inode)) {
-					pr_err("%s %llx.%llx BAD symlink size %lld\n",
-						__func__, ceph_vinop(inode),
+					pr_err_client(cl,
+						"%p %llx.%llx BAD symlink size %lld\n",
+						inode, ceph_vinop(inode),
 						i_size_read(inode));
 					i_size_write(inode, symlen);
 					inode->i_blocks = calc_inode_blocks(symlen);
@@ -1217,8 +1243,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		inode->i_fop = &ceph_dir_fops;
 		break;
 	default:
-		pr_err("%s %llx.%llx BAD mode 0%o\n", __func__,
-		       ceph_vinop(inode), inode->i_mode);
+		pr_err_client(cl, "%p %llx.%llx BAD mode 0%o\n", inode,
+			      ceph_vinop(inode), inode->i_mode);
 	}
 
 	/* were we issued a capability? */
@@ -1239,7 +1265,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 			    (info_caps & CEPH_CAP_FILE_SHARED) &&
 			    (issued & CEPH_CAP_FILE_EXCL) == 0 &&
 			    !__ceph_dir_is_complete(ci)) {
-				dout(" marking %p complete (empty)\n", inode);
+				doutc(cl, " marking %p complete (empty)\n",
+				      inode);
 				i_size_write(inode, 0);
 				__ceph_dir_set_complete(ci,
 					atomic64_read(&ci->i_release_count),
@@ -1248,8 +1275,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 			wake = true;
 		} else {
-			dout(" %p got snap_caps %s\n", inode,
-			     ceph_cap_string(info_caps));
+			doutc(cl, " %p got snap_caps %s\n", inode,
+			      ceph_cap_string(info_caps));
 			ci->i_snap_caps |= info_caps;
 		}
 	}
@@ -1265,8 +1292,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	if (cap_fmode >= 0) {
 		if (!info_caps)
-			pr_warn("mds issued no caps on %llx.%llx\n",
-				ceph_vinop(inode));
+			pr_warn_client(cl, "mds issued no caps on %llx.%llx\n",
+				       ceph_vinop(inode));
 		__ceph_touch_fmode(ci, mdsc, cap_fmode);
 	}
 
@@ -1312,14 +1339,14 @@ static void __update_dentry_lease(struct inode *dir, struct dentry *dentry,
 				  unsigned long from_time,
 				  struct ceph_mds_session **old_lease_session)
 {
+	struct ceph_client *cl = ceph_inode_to_client(dir);
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	unsigned mask = le16_to_cpu(lease->mask);
 	long unsigned duration = le32_to_cpu(lease->duration_ms);
 	long unsigned ttl = from_time + (duration * HZ) / 1000;
 	long unsigned half_ttl = from_time + (duration * HZ / 2) / 1000;
 
-	dout("update_dentry_lease %p duration %lu ms ttl %lu\n",
-	     dentry, duration, ttl);
+	doutc(cl, "%p duration %lu ms ttl %lu\n", dentry, duration, ttl);
 
 	/* only track leases on regular dentries */
 	if (ceph_snap(dir) != CEPH_NOSNAP)
@@ -1420,6 +1447,7 @@ static void update_dentry_lease_careful(struct dentry *dentry,
  */
 static int splice_dentry(struct dentry **pdn, struct inode *in)
 {
+	struct ceph_client *cl = ceph_inode_to_client(in);
 	struct dentry *dn = *pdn;
 	struct dentry *realdn;
 
@@ -1451,23 +1479,21 @@ static int splice_dentry(struct dentry **pdn, struct inode *in)
 		d_drop(dn);
 	realdn = d_splice_alias(in, dn);
 	if (IS_ERR(realdn)) {
-		pr_err("splice_dentry error %ld %p inode %p ino %llx.%llx\n",
-		       PTR_ERR(realdn), dn, in, ceph_vinop(in));
+		pr_err_client(cl, "error %ld %p inode %p ino %llx.%llx\n",
+			      PTR_ERR(realdn), dn, in, ceph_vinop(in));
 		return PTR_ERR(realdn);
 	}
 
 	if (realdn) {
-		dout("dn %p (%d) spliced with %p (%d) "
-		     "inode %p ino %llx.%llx\n",
-		     dn, d_count(dn),
-		     realdn, d_count(realdn),
-		     d_inode(realdn), ceph_vinop(d_inode(realdn)));
+		doutc(cl, "dn %p (%d) spliced with %p (%d) inode %p ino %llx.%llx\n",
+		      dn, d_count(dn), realdn, d_count(realdn),
+		      d_inode(realdn), ceph_vinop(d_inode(realdn)));
 		dput(dn);
 		*pdn = realdn;
 	} else {
 		BUG_ON(!ceph_dentry(dn));
-		dout("dn %p attached to %p ino %llx.%llx\n",
-		     dn, d_inode(dn), ceph_vinop(d_inode(dn)));
+		doutc(cl, "dn %p attached to %p ino %llx.%llx\n", dn,
+		      d_inode(dn), ceph_vinop(d_inode(dn)));
 	}
 	return 0;
 }
@@ -1490,13 +1516,14 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	struct inode *in = NULL;
 	struct ceph_vino tvino, dvino;
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
+	struct ceph_client *cl = fsc->client;
 	int err = 0;
 
-	dout("fill_trace %p is_dentry %d is_target %d\n", req,
-	     rinfo->head->is_dentry, rinfo->head->is_target);
+	doutc(cl, "%p is_dentry %d is_target %d\n", req,
+	      rinfo->head->is_dentry, rinfo->head->is_target);
 
 	if (!rinfo->head->is_target && !rinfo->head->is_dentry) {
-		dout("fill_trace reply is empty!\n");
+		doutc(cl, "reply is empty!\n");
 		if (rinfo->head->result == 0 && req->r_parent)
 			ceph_invalidate_dir_request(req);
 		return 0;
@@ -1553,13 +1580,13 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
 retry_lookup:
 			dn = d_lookup(parent, &dname);
-			dout("d_lookup on parent=%p name=%.*s got %p\n",
-			     parent, dname.len, dname.name, dn);
+			doutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
+			      parent, dname.len, dname.name, dn);
 
 			if (!dn) {
 				dn = d_alloc(parent, &dname);
-				dout("d_alloc %p '%.*s' = %p\n", parent,
-				     dname.len, dname.name, dn);
+				doutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
+				      dname.len, dname.name, dn);
 				if (!dn) {
 					dput(parent);
 					ceph_fname_free_buffer(dir, &oname);
@@ -1575,8 +1602,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			} else if (d_really_is_positive(dn) &&
 				   (ceph_ino(d_inode(dn)) != tvino.ino ||
 				    ceph_snap(d_inode(dn)) != tvino.snap)) {
-				dout(" dn %p points to wrong inode %p\n",
-				     dn, d_inode(dn));
+				doutc(cl, " dn %p points to wrong inode %p\n",
+				      dn, d_inode(dn));
 				ceph_dir_clear_ordered(dir);
 				d_delete(dn);
 				dput(dn);
@@ -1601,8 +1628,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				 rinfo->head->result == 0) ?  req->r_fmode : -1,
 				&req->r_caps_reservation);
 		if (err < 0) {
-			pr_err("ceph_fill_inode badness %p %llx.%llx\n",
-				in, ceph_vinop(in));
+			pr_err_client(cl, "badness %p %llx.%llx\n", in,
+				      ceph_vinop(in));
 			req->r_target_inode = NULL;
 			if (in->i_state & I_NEW)
 				discard_new_inode(in);
@@ -1652,36 +1679,32 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		have_lease = have_dir_cap ||
 			le32_to_cpu(rinfo->dlease->duration_ms);
 		if (!have_lease)
-			dout("fill_trace  no dentry lease or dir cap\n");
+			doutc(cl, "no dentry lease or dir cap\n");
 
 		/* rename? */
 		if (req->r_old_dentry && req->r_op == CEPH_MDS_OP_RENAME) {
 			struct inode *olddir = req->r_old_dentry_dir;
 			BUG_ON(!olddir);
 
-			dout(" src %p '%pd' dst %p '%pd'\n",
-			     req->r_old_dentry,
-			     req->r_old_dentry,
-			     dn, dn);
-			dout("fill_trace doing d_move %p -> %p\n",
-			     req->r_old_dentry, dn);
+			doutc(cl, " src %p '%pd' dst %p '%pd'\n",
+			      req->r_old_dentry, req->r_old_dentry, dn, dn);
+			doutc(cl, "doing d_move %p -> %p\n", req->r_old_dentry, dn);
 
 			/* d_move screws up sibling dentries' offsets */
 			ceph_dir_clear_ordered(dir);
 			ceph_dir_clear_ordered(olddir);
 
 			d_move(req->r_old_dentry, dn);
-			dout(" src %p '%pd' dst %p '%pd'\n",
-			     req->r_old_dentry,
-			     req->r_old_dentry,
-			     dn, dn);
+			doutc(cl, " src %p '%pd' dst %p '%pd'\n",
+			      req->r_old_dentry, req->r_old_dentry, dn, dn);
 
 			/* ensure target dentry is invalidated, despite
 			   rehashing bug in vfs_rename_dir */
 			ceph_invalidate_dentry_lease(dn);
 
-			dout("dn %p gets new offset %lld\n", req->r_old_dentry,
-			     ceph_dentry(req->r_old_dentry)->offset);
+			doutc(cl, "dn %p gets new offset %lld\n",
+			      req->r_old_dentry,
+			      ceph_dentry(req->r_old_dentry)->offset);
 
 			/* swap r_dentry and r_old_dentry in case that
 			 * splice_dentry() gets called later. This is safe
@@ -1693,9 +1716,9 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 
 		/* null dentry? */
 		if (!rinfo->head->is_target) {
-			dout("fill_trace null dentry\n");
+			doutc(cl, "null dentry\n");
 			if (d_really_is_positive(dn)) {
-				dout("d_delete %p\n", dn);
+				doutc(cl, "d_delete %p\n", dn);
 				ceph_dir_clear_ordered(dir);
 				d_delete(dn);
 			} else if (have_lease) {
@@ -1719,9 +1742,9 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				goto done;
 			dn = req->r_dentry;  /* may have spliced */
 		} else if (d_really_is_positive(dn) && d_inode(dn) != in) {
-			dout(" %p links to %p %llx.%llx, not %llx.%llx\n",
-			     dn, d_inode(dn), ceph_vinop(d_inode(dn)),
-			     ceph_vinop(in));
+			doutc(cl, " %p links to %p %llx.%llx, not %llx.%llx\n",
+			      dn, d_inode(dn), ceph_vinop(d_inode(dn)),
+			      ceph_vinop(in));
 			d_invalidate(dn);
 			have_lease = false;
 		}
@@ -1731,7 +1754,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 					    rinfo->dlease, session,
 					    req->r_request_started);
 		}
-		dout(" final dn %p\n", dn);
+		doutc(cl, " final dn %p\n", dn);
 	} else if ((req->r_op == CEPH_MDS_OP_LOOKUPSNAP ||
 		    req->r_op == CEPH_MDS_OP_MKSNAP) &&
 	           test_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags) &&
@@ -1742,7 +1765,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		BUG_ON(!dir);
 		BUG_ON(ceph_snap(dir) != CEPH_SNAPDIR);
 		BUG_ON(!req->r_dentry);
-		dout(" linking snapped dir %p to dn %p\n", in, req->r_dentry);
+		doutc(cl, " linking snapped dir %p to dn %p\n", in,
+		      req->r_dentry);
 		ceph_dir_clear_ordered(dir);
 		ihold(in);
 		err = splice_dentry(&req->r_dentry, in);
@@ -1764,7 +1788,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 					    &dvino, ptvino);
 	}
 done:
-	dout("fill_trace done err=%d\n", err);
+	doutc(cl, "done err=%d\n", err);
 	return err;
 }
 
@@ -1775,6 +1799,7 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
 					   struct ceph_mds_session *session)
 {
 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
+	struct ceph_client *cl = session->s_mdsc->fsc->client;
 	int i, err = 0;
 
 	for (i = 0; i < rinfo->dir_nr; i++) {
@@ -1789,14 +1814,14 @@ static int readdir_prepopulate_inodes_only(struct ceph_mds_request *req,
 		in = ceph_get_inode(req->r_dentry->d_sb, vino, NULL);
 		if (IS_ERR(in)) {
 			err = PTR_ERR(in);
-			dout("new_inode badness got %d\n", err);
+			doutc(cl, "badness got %d\n", err);
 			continue;
 		}
 		rc = ceph_fill_inode(in, NULL, &rde->inode, NULL, session,
 				     -1, &req->r_caps_reservation);
 		if (rc < 0) {
-			pr_err("ceph_fill_inode badness on %p got %d\n",
-			       in, rc);
+			pr_err_client(cl, "inode badness on %p got %d\n", in,
+				      rc);
 			err = rc;
 			if (in->i_state & I_NEW) {
 				ihold(in);
@@ -1825,6 +1850,7 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
 			      struct ceph_readdir_cache_control *ctl,
 			      struct ceph_mds_request *req)
 {
+	struct ceph_client *cl = ceph_inode_to_client(dir);
 	struct ceph_inode_info *ci = ceph_inode(dir);
 	unsigned nsize = PAGE_SIZE / sizeof(struct dentry*);
 	unsigned idx = ctl->index % nsize;
@@ -1850,11 +1876,11 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
 
 	if (req->r_dir_release_cnt == atomic64_read(&ci->i_release_count) &&
 	    req->r_dir_ordered_cnt == atomic64_read(&ci->i_ordered_count)) {
-		dout("readdir cache dn %p idx %d\n", dn, ctl->index);
+		doutc(cl, "dn %p idx %d\n", dn, ctl->index);
 		ctl->dentries[idx] = dn;
 		ctl->index++;
 	} else {
-		dout("disable readdir cache\n");
+		doutc(cl, "disable readdir cache\n");
 		ctl->index = -1;
 	}
 	return 0;
@@ -1867,6 +1893,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	struct inode *inode = d_inode(parent);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
+	struct ceph_client *cl = session->s_mdsc->fsc->client;
 	struct qstr dname;
 	struct dentry *dn;
 	struct inode *in;
@@ -1894,19 +1921,18 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 	if (rinfo->dir_dir &&
 	    le32_to_cpu(rinfo->dir_dir->frag) != frag) {
-		dout("readdir_prepopulate got new frag %x -> %x\n",
-		     frag, le32_to_cpu(rinfo->dir_dir->frag));
+		doutc(cl, "got new frag %x -> %x\n", frag,
+			    le32_to_cpu(rinfo->dir_dir->frag));
 		frag = le32_to_cpu(rinfo->dir_dir->frag);
 		if (!rinfo->hash_order)
 			req->r_readdir_offset = 2;
 	}
 
 	if (le32_to_cpu(rinfo->head->op) == CEPH_MDS_OP_LSSNAP) {
-		dout("readdir_prepopulate %d items under SNAPDIR dn %p\n",
-		     rinfo->dir_nr, parent);
+		doutc(cl, "%d items under SNAPDIR dn %p\n",
+		      rinfo->dir_nr, parent);
 	} else {
-		dout("readdir_prepopulate %d items under dn %p\n",
-		     rinfo->dir_nr, parent);
+		doutc(cl, "%d items under dn %p\n", rinfo->dir_nr, parent);
 		if (rinfo->dir_dir)
 			ceph_fill_dirfrag(d_inode(parent), rinfo->dir_dir);
 
@@ -1950,15 +1976,15 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 retry_lookup:
 		dn = d_lookup(parent, &dname);
-		dout("d_lookup on parent=%p name=%.*s got %p\n",
-		     parent, dname.len, dname.name, dn);
+		doutc(cl, "d_lookup on parent=%p name=%.*s got %p\n",
+		      parent, dname.len, dname.name, dn);
 
 		if (!dn) {
 			dn = d_alloc(parent, &dname);
-			dout("d_alloc %p '%.*s' = %p\n", parent,
-			     dname.len, dname.name, dn);
+			doutc(cl, "d_alloc %p '%.*s' = %p\n", parent,
+			      dname.len, dname.name, dn);
 			if (!dn) {
-				dout("d_alloc badness\n");
+				doutc(cl, "d_alloc badness\n");
 				err = -ENOMEM;
 				goto out;
 			}
@@ -1971,8 +1997,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			   (ceph_ino(d_inode(dn)) != tvino.ino ||
 			    ceph_snap(d_inode(dn)) != tvino.snap)) {
 			struct ceph_dentry_info *di = ceph_dentry(dn);
-			dout(" dn %p points to wrong inode %p\n",
-			     dn, d_inode(dn));
+			doutc(cl, " dn %p points to wrong inode %p\n",
+			      dn, d_inode(dn));
 
 			spin_lock(&dn->d_lock);
 			if (di->offset > 0 &&
@@ -1994,7 +2020,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		} else {
 			in = ceph_get_inode(parent->d_sb, tvino, NULL);
 			if (IS_ERR(in)) {
-				dout("new_inode badness\n");
+				doutc(cl, "new_inode badness\n");
 				d_drop(dn);
 				dput(dn);
 				err = PTR_ERR(in);
@@ -2005,7 +2031,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		ret = ceph_fill_inode(in, NULL, &rde->inode, NULL, session,
 				      -1, &req->r_caps_reservation);
 		if (ret < 0) {
-			pr_err("ceph_fill_inode badness on %p\n", in);
+			pr_err_client(cl, "badness on %p %llx.%llx\n", in,
+				      ceph_vinop(in));
 			if (d_really_is_negative(dn)) {
 				if (in->i_state & I_NEW) {
 					ihold(in);
@@ -2022,8 +2049,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 
 		if (d_really_is_negative(dn)) {
 			if (ceph_security_xattr_deadlock(in)) {
-				dout(" skip splicing dn %p to inode %p"
-				     " (security xattr deadlock)\n", dn, in);
+				doutc(cl, " skip splicing dn %p to inode %p"
+				      " (security xattr deadlock)\n", dn, in);
 				iput(in);
 				skipped++;
 				goto next_item;
@@ -2055,17 +2082,18 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		req->r_readdir_cache_idx = cache_ctl.index;
 	}
 	ceph_readdir_cache_release(&cache_ctl);
-	dout("readdir_prepopulate done\n");
+	doutc(cl, "done\n");
 	return err;
 }
 
 bool ceph_inode_set_size(struct inode *inode, loff_t size)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	bool ret;
 
 	spin_lock(&ci->i_ceph_lock);
-	dout("set_size %p %llu -> %llu\n", inode, i_size_read(inode), size);
+	doutc(cl, "set_size %p %llu -> %llu\n", inode, i_size_read(inode), size);
 	i_size_write(inode, size);
 	ceph_fscache_update(inode);
 	inode->i_blocks = calc_inode_blocks(size);
@@ -2080,21 +2108,24 @@ bool ceph_inode_set_size(struct inode *inode, loff_t size)
 void ceph_queue_inode_work(struct inode *inode, int work_bit)
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	set_bit(work_bit, &ci->i_work_mask);
 
 	ihold(inode);
 	if (queue_work(fsc->inode_wq, &ci->i_work)) {
-		dout("queue_inode_work %p, mask=%lx\n", inode, ci->i_work_mask);
+		doutc(cl, "%p %llx.%llx mask=%lx\n", inode,
+		      ceph_vinop(inode), ci->i_work_mask);
 	} else {
-		dout("queue_inode_work %p already queued, mask=%lx\n",
-		     inode, ci->i_work_mask);
+		doutc(cl, "%p %llx.%llx already queued, mask=%lx\n",
+		      inode, ceph_vinop(inode), ci->i_work_mask);
 		iput(inode);
 	}
 }
 
 static void ceph_do_invalidate_pages(struct inode *inode)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u32 orig_gen;
 	int check = 0;
@@ -2104,8 +2135,9 @@ static void ceph_do_invalidate_pages(struct inode *inode)
 	mutex_lock(&ci->i_truncate_mutex);
 
 	if (ceph_inode_is_shutdown(inode)) {
-		pr_warn_ratelimited("%s: inode %llx.%llx is shut down\n",
-				    __func__, ceph_vinop(inode));
+		pr_warn_ratelimited_client(cl,
+			"%p %llx.%llx is shut down\n", inode,
+			ceph_vinop(inode));
 		mapping_set_error(inode->i_mapping, -EIO);
 		truncate_pagecache(inode, 0);
 		mutex_unlock(&ci->i_truncate_mutex);
@@ -2113,8 +2145,8 @@ static void ceph_do_invalidate_pages(struct inode *inode)
 	}
 
 	spin_lock(&ci->i_ceph_lock);
-	dout("invalidate_pages %p gen %d revoking %d\n", inode,
-	     ci->i_rdcache_gen, ci->i_rdcache_revoking);
+	doutc(cl, "%p %llx.%llx gen %d revoking %d\n", inode,
+	      ceph_vinop(inode), ci->i_rdcache_gen, ci->i_rdcache_revoking);
 	if (ci->i_rdcache_revoking != ci->i_rdcache_gen) {
 		if (__ceph_caps_revoking_other(ci, NULL, CEPH_CAP_FILE_CACHE))
 			check = 1;
@@ -2126,21 +2158,21 @@ static void ceph_do_invalidate_pages(struct inode *inode)
 	spin_unlock(&ci->i_ceph_lock);
 
 	if (invalidate_inode_pages2(inode->i_mapping) < 0) {
-		pr_err("invalidate_inode_pages2 %llx.%llx failed\n",
-		       ceph_vinop(inode));
+		pr_err_client(cl, "invalidate_inode_pages2 %llx.%llx failed\n",
+			      ceph_vinop(inode));
 	}
 
 	spin_lock(&ci->i_ceph_lock);
 	if (orig_gen == ci->i_rdcache_gen &&
 	    orig_gen == ci->i_rdcache_revoking) {
-		dout("invalidate_pages %p gen %d successful\n", inode,
-		     ci->i_rdcache_gen);
+		doutc(cl, "%p %llx.%llx gen %d successful\n", inode,
+		      ceph_vinop(inode), ci->i_rdcache_gen);
 		ci->i_rdcache_revoking--;
 		check = 1;
 	} else {
-		dout("invalidate_pages %p gen %d raced, now %d revoking %d\n",
-		     inode, orig_gen, ci->i_rdcache_gen,
-		     ci->i_rdcache_revoking);
+		doutc(cl, "%p %llx.%llx gen %d raced, now %d revoking %d\n",
+		      inode, ceph_vinop(inode), orig_gen, ci->i_rdcache_gen,
+		      ci->i_rdcache_revoking);
 		if (__ceph_caps_revoking_other(ci, NULL, CEPH_CAP_FILE_CACHE))
 			check = 1;
 	}
@@ -2157,6 +2189,7 @@ static void ceph_do_invalidate_pages(struct inode *inode)
  */
 void __ceph_do_pending_vmtruncate(struct inode *inode)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u64 to;
 	int wrbuffer_refs, finish = 0;
@@ -2165,7 +2198,8 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 retry:
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_truncate_pending == 0) {
-		dout("%s %p none pending\n", __func__, inode);
+		doutc(cl, "%p %llx.%llx none pending\n", inode,
+		      ceph_vinop(inode));
 		spin_unlock(&ci->i_ceph_lock);
 		mutex_unlock(&ci->i_truncate_mutex);
 		return;
@@ -2177,7 +2211,8 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	 */
 	if (ci->i_wrbuffer_ref_head < ci->i_wrbuffer_ref) {
 		spin_unlock(&ci->i_ceph_lock);
-		dout("%s %p flushing snaps first\n", __func__, inode);
+		doutc(cl, "%p %llx.%llx flushing snaps first\n", inode,
+		      ceph_vinop(inode));
 		filemap_write_and_wait_range(&inode->i_data, 0,
 					     inode->i_sb->s_maxbytes);
 		goto retry;
@@ -2188,8 +2223,8 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 
 	to = ci->i_truncate_pagecache_size;
 	wrbuffer_refs = ci->i_wrbuffer_ref;
-	dout("%s %p (%d) to %lld\n", __func__, inode,
-	     ci->i_truncate_pending, to);
+	doutc(cl, "%p %llx.%llx (%d) to %lld\n", inode, ceph_vinop(inode),
+	      ci->i_truncate_pending, to);
 	spin_unlock(&ci->i_ceph_lock);
 
 	ceph_fscache_resize(inode, to);
@@ -2217,9 +2252,10 @@ static void ceph_inode_work(struct work_struct *work)
 	struct ceph_inode_info *ci = container_of(work, struct ceph_inode_info,
 						 i_work);
 	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 
 	if (test_and_clear_bit(CEPH_I_WORK_WRITEBACK, &ci->i_work_mask)) {
-		dout("writeback %p\n", inode);
+		doutc(cl, "writeback %p %llx.%llx\n", inode, ceph_vinop(inode));
 		filemap_fdatawrite(&inode->i_data);
 	}
 	if (test_and_clear_bit(CEPH_I_WORK_INVALIDATE_PAGES, &ci->i_work_mask))
@@ -2291,6 +2327,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 				 struct ceph_mds_request *req,
 				 struct iattr *attr)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int boff = attr->ia_size % CEPH_FSCRYPT_BLOCK_SIZE;
 	loff_t pos, orig_pos = round_down(attr->ia_size,
@@ -2313,9 +2350,9 @@ static int fill_fscrypt_truncate(struct inode *inode,
 
 	issued = __ceph_caps_issued(ci, NULL);
 
-	dout("%s size %lld -> %lld got cap refs on %s, issued %s\n", __func__,
-	     i_size, attr->ia_size, ceph_cap_string(got),
-	     ceph_cap_string(issued));
+	doutc(cl, "size %lld -> %lld got cap refs on %s, issued %s\n",
+	      i_size, attr->ia_size, ceph_cap_string(got),
+	      ceph_cap_string(issued));
 
 	/* Try to writeback the dirty pagecaches */
 	if (issued & (CEPH_CAP_FILE_BUFFER)) {
@@ -2370,8 +2407,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	 * If the Rados object doesn't exist, it will be set to 0.
 	 */
 	if (!objver) {
-		dout("%s hit hole, ppos %lld < size %lld\n", __func__,
-		     pos, i_size);
+		doutc(cl, "hit hole, ppos %lld < size %lld\n", pos, i_size);
 
 		header.data_len = cpu_to_le32(8 + 8 + 4);
 		header.file_offset = 0;
@@ -2380,8 +2416,8 @@ static int fill_fscrypt_truncate(struct inode *inode,
 		header.data_len = cpu_to_le32(8 + 8 + 4 + CEPH_FSCRYPT_BLOCK_SIZE);
 		header.file_offset = cpu_to_le64(orig_pos);
 
-		dout("%s encrypt block boff/bsize %d/%lu\n", __func__,
-		     boff, CEPH_FSCRYPT_BLOCK_SIZE);
+		doutc(cl, "encrypt block boff/bsize %d/%lu\n", boff,
+		      CEPH_FSCRYPT_BLOCK_SIZE);
 
 		/* truncate and zero out the extra contents for the last block */
 		memset(iov.iov_base + boff, 0, PAGE_SIZE - boff);
@@ -2409,8 +2445,8 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	}
 	req->r_pagelist = pagelist;
 out:
-	dout("%s %p size dropping cap refs on %s\n", __func__,
-	     inode, ceph_cap_string(got));
+	doutc(cl, "%p %llx.%llx size dropping cap refs on %s\n", inode,
+	      ceph_vinop(inode), ceph_cap_string(got));
 	ceph_put_cap_refs(ci, got);
 	if (iov.iov_base)
 		kunmap_local(iov.iov_base);
@@ -2428,6 +2464,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 	unsigned int ia_valid = attr->ia_valid;
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_cap_flush *prealloc_cf;
 	loff_t isize = i_size_read(inode);
 	int issued;
@@ -2466,7 +2503,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 		}
 	}
 
-	dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
+	doutc(cl, "%p %llx.%llx issued %s\n", inode, ceph_vinop(inode),
+	      ceph_cap_string(issued));
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
 	if (cia && cia->fscrypt_auth) {
 		u32 len = ceph_fscrypt_auth_len(cia->fscrypt_auth);
@@ -2477,8 +2515,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 			goto out;
 		}
 
-		dout("setattr %llx:%llx fscrypt_auth len %u to %u)\n",
-			ceph_vinop(inode), ci->fscrypt_auth_len, len);
+		doutc(cl, "%p %llx.%llx fscrypt_auth len %u to %u)\n", inode,
+		      ceph_vinop(inode), ci->fscrypt_auth_len, len);
 
 		/* It should never be re-set once set */
 		WARN_ON_ONCE(ci->fscrypt_auth);
@@ -2506,9 +2544,10 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 #endif /* CONFIG_FS_ENCRYPTION */
 
 	if (ia_valid & ATTR_UID) {
-		dout("setattr %p uid %d -> %d\n", inode,
-		     from_kuid(&init_user_ns, inode->i_uid),
-		     from_kuid(&init_user_ns, attr->ia_uid));
+		doutc(cl, "%p %llx.%llx uid %d -> %d\n", inode,
+		      ceph_vinop(inode),
+		      from_kuid(&init_user_ns, inode->i_uid),
+		      from_kuid(&init_user_ns, attr->ia_uid));
 		if (issued & CEPH_CAP_AUTH_EXCL) {
 			inode->i_uid = attr->ia_uid;
 			dirtied |= CEPH_CAP_AUTH_EXCL;
@@ -2521,9 +2560,10 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 		}
 	}
 	if (ia_valid & ATTR_GID) {
-		dout("setattr %p gid %d -> %d\n", inode,
-		     from_kgid(&init_user_ns, inode->i_gid),
-		     from_kgid(&init_user_ns, attr->ia_gid));
+		doutc(cl, "%p %llx.%llx gid %d -> %d\n", inode,
+		      ceph_vinop(inode),
+		      from_kgid(&init_user_ns, inode->i_gid),
+		      from_kgid(&init_user_ns, attr->ia_gid));
 		if (issued & CEPH_CAP_AUTH_EXCL) {
 			inode->i_gid = attr->ia_gid;
 			dirtied |= CEPH_CAP_AUTH_EXCL;
@@ -2536,8 +2576,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 		}
 	}
 	if (ia_valid & ATTR_MODE) {
-		dout("setattr %p mode 0%o -> 0%o\n", inode, inode->i_mode,
-		     attr->ia_mode);
+		doutc(cl, "%p %llx.%llx mode 0%o -> 0%o\n", inode,
+		      ceph_vinop(inode), inode->i_mode, attr->ia_mode);
 		if (issued & CEPH_CAP_AUTH_EXCL) {
 			inode->i_mode = attr->ia_mode;
 			dirtied |= CEPH_CAP_AUTH_EXCL;
@@ -2551,9 +2591,10 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 	}
 
 	if (ia_valid & ATTR_ATIME) {
-		dout("setattr %p atime %lld.%ld -> %lld.%ld\n", inode,
-		     inode->i_atime.tv_sec, inode->i_atime.tv_nsec,
-		     attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec);
+		doutc(cl, "%p %llx.%llx atime %lld.%ld -> %lld.%ld\n",
+		      inode, ceph_vinop(inode), inode->i_atime.tv_sec,
+		      inode->i_atime.tv_nsec, attr->ia_atime.tv_sec,
+		      attr->ia_atime.tv_nsec);
 		if (issued & CEPH_CAP_FILE_EXCL) {
 			ci->i_time_warp_seq++;
 			inode->i_atime = attr->ia_atime;
@@ -2573,7 +2614,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 		}
 	}
 	if (ia_valid & ATTR_SIZE) {
-		dout("setattr %p size %lld -> %lld\n", inode, isize, attr->ia_size);
+		doutc(cl, "%p %llx.%llx size %lld -> %lld\n", inode,
+		      ceph_vinop(inode), isize, attr->ia_size);
 		/*
 		 * Only when the new size is smaller and not aligned to
 		 * CEPH_FSCRYPT_BLOCK_SIZE will the RMW is needed.
@@ -2624,9 +2666,10 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 		}
 	}
 	if (ia_valid & ATTR_MTIME) {
-		dout("setattr %p mtime %lld.%ld -> %lld.%ld\n", inode,
-		     inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
-		     attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec);
+		doutc(cl, "%p %llx.%llx mtime %lld.%ld -> %lld.%ld\n",
+		      inode, ceph_vinop(inode), inode->i_mtime.tv_sec,
+		      inode->i_mtime.tv_nsec, attr->ia_mtime.tv_sec,
+		      attr->ia_mtime.tv_nsec);
 		if (issued & CEPH_CAP_FILE_EXCL) {
 			ci->i_time_warp_seq++;
 			inode->i_mtime = attr->ia_mtime;
@@ -2650,11 +2693,12 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 	if (ia_valid & ATTR_CTIME) {
 		bool only = (ia_valid & (ATTR_SIZE|ATTR_MTIME|ATTR_ATIME|
 					 ATTR_MODE|ATTR_UID|ATTR_GID)) == 0;
-		dout("setattr %p ctime %lld.%ld -> %lld.%ld (%s)\n", inode,
-		     inode_get_ctime(inode).tv_sec,
-		     inode_get_ctime(inode).tv_nsec,
-		     attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
-		     only ? "ctime only" : "ignored");
+		doutc(cl, "%p %llx.%llx ctime %lld.%ld -> %lld.%ld (%s)\n",
+		      inode, ceph_vinop(inode), inode_get_ctime(inode).tv_sec,
+		      inode_get_ctime(inode).tv_nsec,
+		      attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
+		      only ? "ctime only" : "ignored");
+
 		if (only) {
 			/*
 			 * if kernel wants to dirty ctime but nothing else,
@@ -2672,7 +2716,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 		}
 	}
 	if (ia_valid & ATTR_FILE)
-		dout("setattr %p ATTR_FILE ... hrm!\n", inode);
+		doutc(cl, "%p %llx.%llx ATTR_FILE ... hrm!\n", inode,
+		      ceph_vinop(inode));
 
 	if (dirtied) {
 		inode_dirty_flags = __ceph_mark_dirty_caps(ci, dirtied,
@@ -2713,16 +2758,17 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr,
 		 */
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 		if (err == -EAGAIN && truncate_retry--) {
-			dout("setattr %p result=%d (%s locally, %d remote), retry it!\n",
-			     inode, err, ceph_cap_string(dirtied), mask);
+			doutc(cl, "%p %llx.%llx result=%d (%s locally, %d remote), retry it!\n",
+			      inode, ceph_vinop(inode), err,
+			      ceph_cap_string(dirtied), mask);
 			ceph_mdsc_put_request(req);
 			ceph_free_cap_flush(prealloc_cf);
 			goto retry;
 		}
 	}
 out:
-	dout("setattr %p result=%d (%s locally, %d remote)\n", inode, err,
-	     ceph_cap_string(dirtied), mask);
+	doutc(cl, "%p %llx.%llx result=%d (%s locally, %d remote)\n", inode,
+	      ceph_vinop(inode), err, ceph_cap_string(dirtied), mask);
 
 	ceph_mdsc_put_request(req);
 	ceph_free_cap_flush(prealloc_cf);
@@ -2811,18 +2857,20 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 		      int mask, bool force)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	int mode;
 	int err;
 
 	if (ceph_snap(inode) == CEPH_SNAPDIR) {
-		dout("do_getattr inode %p SNAPDIR\n", inode);
+		doutc(cl, "inode %p %llx.%llx SNAPDIR\n", inode,
+		      ceph_vinop(inode));
 		return 0;
 	}
 
-	dout("do_getattr inode %p mask %s mode 0%o\n",
-	     inode, ceph_cap_string(mask), inode->i_mode);
+	doutc(cl, "inode %p %llx.%llx mask %s mode 0%o\n", inode,
+	      ceph_vinop(inode), ceph_cap_string(mask), inode->i_mode);
 	if (!force && ceph_caps_issued_mask_metric(ceph_inode(inode), mask, 1))
 			return 0;
 
@@ -2849,7 +2897,7 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 		}
 	}
 	ceph_mdsc_put_request(req);
-	dout("do_getattr result=%d\n", err);
+	doutc(cl, "result=%d\n", err);
 	return err;
 }
 
@@ -2857,6 +2905,7 @@ int ceph_do_getvxattr(struct inode *inode, const char *name, void *value,
 		      size_t size)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	int mode = USE_AUTH_MDS;
@@ -2886,7 +2935,7 @@ int ceph_do_getvxattr(struct inode *inode, const char *name, void *value,
 	xattr_value = req->r_reply_info.xattr_info.xattr_value;
 	xattr_value_len = req->r_reply_info.xattr_info.xattr_value_len;
 
-	dout("do_getvxattr xattr_value_len:%zu, size:%zu\n", xattr_value_len, size);
+	doutc(cl, "xattr_value_len:%zu, size:%zu\n", xattr_value_len, size);
 
 	err = (int)xattr_value_len;
 	if (size == 0)
@@ -2901,7 +2950,7 @@ int ceph_do_getvxattr(struct inode *inode, const char *name, void *value,
 put:
 	ceph_mdsc_put_request(req);
 out:
-	dout("do_getvxattr result=%d\n", err);
+	doutc(cl, "result=%d\n", err);
 	return err;
 }
 
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 3f617146e4ad..e861de3c79b9 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -245,6 +245,7 @@ static long ceph_ioctl_lazyio(struct file *file)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 
 	if ((fi->fmode & CEPH_FILE_MODE_LAZY) == 0) {
 		spin_lock(&ci->i_ceph_lock);
@@ -252,11 +253,13 @@ static long ceph_ioctl_lazyio(struct file *file)
 		ci->i_nr_by_mode[ffs(CEPH_FILE_MODE_LAZY)]++;
 		__ceph_touch_fmode(ci, mdsc, fi->fmode);
 		spin_unlock(&ci->i_ceph_lock);
-		dout("ioctl_layzio: file %p marked lazy\n", file);
+		doutc(cl, "file %p %p %llx.%llx marked lazy\n", file, inode,
+		      ceph_vinop(inode));
 
 		ceph_check_caps(ci, 0);
 	} else {
-		dout("ioctl_layzio: file %p already lazy\n", file);
+		doutc(cl, "file %p %p %llx.%llx already lazy\n", file, inode,
+		      ceph_vinop(inode));
 	}
 	return 0;
 }
@@ -355,10 +358,12 @@ static const char *ceph_ioctl_cmd_name(const unsigned int cmd)
 
 long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
+	struct inode *inode = file_inode(file);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int ret;
 
-	dout("ioctl file %p cmd %s arg %lu\n", file,
-	     ceph_ioctl_cmd_name(cmd), arg);
+	doutc(fsc->client, "file %p %p %llx.%llx cmd %s arg %lu\n", file,
+	      inode, ceph_vinop(inode), ceph_ioctl_cmd_name(cmd), arg);
 	switch (cmd) {
 	case CEPH_IOC_GET_LAYOUT:
 		return ceph_ioctl_get_layout(file, (void __user *)arg);
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index cb51c7e9c8e2..e07ad29ff8b9 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -77,6 +77,7 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 			     int cmd, u8 wait, struct file_lock *fl)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	int err;
 	u64 length = 0;
@@ -111,10 +112,10 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 
 	owner = secure_addr(fl->fl_owner);
 
-	dout("ceph_lock_message: rule: %d, op: %d, owner: %llx, pid: %llu, "
-	     "start: %llu, length: %llu, wait: %d, type: %d\n", (int)lock_type,
-	     (int)operation, owner, (u64)fl->fl_pid, fl->fl_start, length,
-	     wait, fl->fl_type);
+	doutc(cl, "rule: %d, op: %d, owner: %llx, pid: %llu, "
+		    "start: %llu, length: %llu, wait: %d, type: %d\n",
+		    (int)lock_type, (int)operation, owner, (u64)fl->fl_pid,
+		    fl->fl_start, length, wait, fl->fl_type);
 
 	req->r_args.filelock_change.rule = lock_type;
 	req->r_args.filelock_change.type = cmd;
@@ -147,16 +148,17 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 
 	}
 	ceph_mdsc_put_request(req);
-	dout("ceph_lock_message: rule: %d, op: %d, pid: %llu, start: %llu, "
-	     "length: %llu, wait: %d, type: %d, err code %d\n", (int)lock_type,
-	     (int)operation, (u64)fl->fl_pid, fl->fl_start,
-	     length, wait, fl->fl_type, err);
+	doutc(cl, "rule: %d, op: %d, pid: %llu, start: %llu, "
+	      "length: %llu, wait: %d, type: %d, err code %d\n",
+	      (int)lock_type, (int)operation, (u64)fl->fl_pid,
+	      fl->fl_start, length, wait, fl->fl_type, err);
 	return err;
 }
 
 static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
                                          struct ceph_mds_request *req)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *intr_req;
 	struct inode *inode = req->r_inode;
 	int err, lock_type;
@@ -174,8 +176,7 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 	if (!err)
 		return 0;
 
-	dout("ceph_lock_wait_for_completion: request %llu was interrupted\n",
-	     req->r_tid);
+	doutc(cl, "request %llu was interrupted\n", req->r_tid);
 
 	mutex_lock(&mdsc->mutex);
 	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
@@ -246,6 +247,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int err = 0;
 	u16 op = CEPH_MDS_OP_SETFILELOCK;
 	u8 wait = 0;
@@ -257,7 +259,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	dout("ceph_lock, fl_owner: %p\n", fl->fl_owner);
+	doutc(cl, "fl_owner: %p\n", fl->fl_owner);
 
 	/* set wait bit as appropriate, then make command as Ceph expects it*/
 	if (IS_GETLK(cmd))
@@ -292,7 +294,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, inode, lock_cmd, wait, fl);
 	if (!err) {
 		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK != fl->fl_type) {
-			dout("mds locked, locking locally\n");
+			doutc(cl, "locking locally\n");
 			err = posix_lock_file(file, fl, NULL);
 			if (err) {
 				/* undo! This should only happen if
@@ -300,8 +302,8 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 				 * deadlock. */
 				ceph_lock_message(CEPH_LOCK_FCNTL, op, inode,
 						  CEPH_LOCK_UNLOCK, 0, fl);
-				dout("got %d on posix_lock_file, undid lock\n",
-				     err);
+				doutc(cl, "got %d on posix_lock_file, undid lock\n",
+				      err);
 			}
 		}
 	}
@@ -312,6 +314,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int err = 0;
 	u8 wait = 0;
 	u8 lock_cmd;
@@ -322,7 +325,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	dout("ceph_flock, fl_file: %p\n", fl->fl_file);
+	doutc(cl, "fl_file: %p\n", fl->fl_file);
 
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
@@ -359,7 +362,8 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 			ceph_lock_message(CEPH_LOCK_FLOCK,
 					  CEPH_MDS_OP_SETFILELOCK,
 					  inode, CEPH_LOCK_UNLOCK, 0, fl);
-			dout("got %d on locks_lock_file_wait, undid lock\n", err);
+			doutc(cl, "got %d on locks_lock_file_wait, undid lock\n",
+			      err);
 		}
 	}
 	return err;
@@ -371,6 +375,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
  */
 void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct file_lock *lock;
 	struct file_lock_context *ctx;
 
@@ -386,17 +391,20 @@ void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
 			++(*flock_count);
 		spin_unlock(&ctx->flc_lock);
 	}
-	dout("counted %d flock locks and %d fcntl locks\n",
-	     *flock_count, *fcntl_count);
+	doutc(cl, "counted %d flock locks and %d fcntl locks\n",
+	      *flock_count, *fcntl_count);
 }
 
 /*
  * Given a pointer to a lock, convert it to a ceph filelock
  */
-static int lock_to_ceph_filelock(struct file_lock *lock,
+static int lock_to_ceph_filelock(struct inode *inode,
+				 struct file_lock *lock,
 				 struct ceph_filelock *cephlock)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int err = 0;
+
 	cephlock->start = cpu_to_le64(lock->fl_start);
 	cephlock->length = cpu_to_le64(lock->fl_end - lock->fl_start + 1);
 	cephlock->client = cpu_to_le64(0);
@@ -414,7 +422,7 @@ static int lock_to_ceph_filelock(struct file_lock *lock,
 		cephlock->type = CEPH_LOCK_UNLOCK;
 		break;
 	default:
-		dout("Have unknown lock type %d\n", lock->fl_type);
+		doutc(cl, "Have unknown lock type %d\n", lock->fl_type);
 		err = -EINVAL;
 	}
 
@@ -432,13 +440,14 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 {
 	struct file_lock *lock;
 	struct file_lock_context *ctx = locks_inode_context(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int err = 0;
 	int seen_fcntl = 0;
 	int seen_flock = 0;
 	int l = 0;
 
-	dout("encoding %d flock and %d fcntl locks\n", num_flock_locks,
-	     num_fcntl_locks);
+	doutc(cl, "encoding %d flock and %d fcntl locks\n", num_flock_locks,
+	      num_fcntl_locks);
 
 	if (!ctx)
 		return 0;
@@ -450,7 +459,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 			err = -ENOSPC;
 			goto fail;
 		}
-		err = lock_to_ceph_filelock(lock, &flocks[l]);
+		err = lock_to_ceph_filelock(inode, lock, &flocks[l]);
 		if (err)
 			goto fail;
 		++l;
@@ -461,7 +470,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 			err = -ENOSPC;
 			goto fail;
 		}
-		err = lock_to_ceph_filelock(lock, &flocks[l]);
+		err = lock_to_ceph_filelock(inode, lock, &flocks[l]);
 		if (err)
 			goto fail;
 		++l;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 11289ce8a8cc..56609b80880c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -411,6 +411,7 @@ static int parse_reply_info_readdir(void **p, void *end,
 				    u64 features)
 {
 	struct ceph_mds_reply_info_parsed *info = &req->r_reply_info;
+	struct ceph_client *cl = req->r_mdsc->fsc->client;
 	u32 num, i = 0;
 	int err;
 
@@ -433,7 +434,7 @@ static int parse_reply_info_readdir(void **p, void *end,
 	BUG_ON(!info->dir_entries);
 	if ((unsigned long)(info->dir_entries + num) >
 	    (unsigned long)info->dir_entries + info->dir_buf_size) {
-		pr_err("dir contents are larger than expected\n");
+		pr_err_client(cl, "dir contents are larger than expected\n");
 		WARN_ON(1);
 		goto bad;
 	}
@@ -454,7 +455,7 @@ static int parse_reply_info_readdir(void **p, void *end,
 		ceph_decode_need(p, end, _name_len, bad);
 		_name = *p;
 		*p += _name_len;
-		dout("parsed dir dname '%.*s'\n", _name_len, _name);
+		doutc(cl, "parsed dir dname '%.*s'\n", _name_len, _name);
 
 		if (info->hash_order)
 			rde->raw_hash = ceph_str_hash(ci->i_dir_layout.dl_dir_hash,
@@ -514,8 +515,8 @@ static int parse_reply_info_readdir(void **p, void *end,
 		rde->is_nokey = false;
 		err = ceph_fname_to_usr(&fname, &tname, &oname, &rde->is_nokey);
 		if (err) {
-			pr_err("%s unable to decode %.*s, got %d\n", __func__,
-			       _name_len, _name, err);
+			pr_err_client(cl, "unable to decode %.*s, got %d\n",
+				      _name_len, _name, err);
 			goto out_bad;
 		}
 		rde->name = oname.name;
@@ -539,7 +540,7 @@ static int parse_reply_info_readdir(void **p, void *end,
 bad:
 	err = -EIO;
 out_bad:
-	pr_err("problem parsing dir contents %d\n", err);
+	pr_err_client(cl, "problem parsing dir contents %d\n", err);
 	return err;
 }
 
@@ -570,10 +571,11 @@ static int parse_reply_info_filelock(void **p, void *end,
 static int ceph_parse_deleg_inos(void **p, void *end,
 				 struct ceph_mds_session *s)
 {
+	struct ceph_client *cl = s->s_mdsc->fsc->client;
 	u32 sets;
 
 	ceph_decode_32_safe(p, end, sets, bad);
-	dout("got %u sets of delegated inodes\n", sets);
+	doutc(cl, "got %u sets of delegated inodes\n", sets);
 	while (sets--) {
 		u64 start, len;
 
@@ -582,8 +584,9 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 
 		/* Don't accept a delegation of system inodes */
 		if (start < CEPH_INO_SYSTEM_BASE) {
-			pr_warn_ratelimited("ceph: ignoring reserved inode range delegation (start=0x%llx len=0x%llx)\n",
-					start, len);
+			pr_warn_ratelimited_client(cl,
+				"ignoring reserved inode range delegation (start=0x%llx len=0x%llx)\n",
+				start, len);
 			continue;
 		}
 		while (len--) {
@@ -591,10 +594,10 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 					    DELEGATED_INO_AVAILABLE,
 					    GFP_KERNEL);
 			if (!err) {
-				dout("added delegated inode 0x%llx\n",
-				     start - 1);
+				doutc(cl, "added delegated inode 0x%llx\n", start - 1);
 			} else if (err == -EBUSY) {
-				pr_warn("MDS delegated inode 0x%llx more than once.\n",
+				pr_warn_client(cl,
+					"MDS delegated inode 0x%llx more than once.\n",
 					start - 1);
 			} else {
 				return err;
@@ -744,6 +747,7 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 			    struct ceph_mds_request *req, u64 features)
 {
 	struct ceph_mds_reply_info_parsed *info = &req->r_reply_info;
+	struct ceph_client *cl = s->s_mdsc->fsc->client;
 	void *p, *end;
 	u32 len;
 	int err;
@@ -783,7 +787,7 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 bad:
 	err = -EIO;
 out_bad:
-	pr_err("mds parse_reply err %d\n", err);
+	pr_err_client(cl, "mds parse_reply err %d\n", err);
 	ceph_msg_dump(msg);
 	return err;
 }
@@ -831,6 +835,7 @@ static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
 int ceph_wait_on_conflict_unlink(struct dentry *dentry)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dentry->d_sb);
+	struct ceph_client *cl = fsc->client;
 	struct dentry *pdentry = dentry->d_parent;
 	struct dentry *udentry, *found = NULL;
 	struct ceph_dentry_info *di;
@@ -855,8 +860,8 @@ int ceph_wait_on_conflict_unlink(struct dentry *dentry)
 			goto next;
 
 		if (!test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags))
-			pr_warn("%s dentry %p:%pd async unlink bit is not set\n",
-				__func__, dentry, dentry);
+			pr_warn_client(cl, "dentry %p:%pd async unlink bit is not set\n",
+				       dentry, dentry);
 
 		if (!d_same_name(udentry, pdentry, &dname))
 			goto next;
@@ -872,8 +877,8 @@ int ceph_wait_on_conflict_unlink(struct dentry *dentry)
 	if (likely(!found))
 		return 0;
 
-	dout("%s dentry %p:%pd conflict with old %p:%pd\n", __func__,
-	     dentry, dentry, found, found);
+	doutc(cl, "dentry %p:%pd conflict with old %p:%pd\n", dentry, dentry,
+	      found, found);
 
 	err = wait_on_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT,
 			  TASK_KILLABLE);
@@ -957,6 +962,7 @@ static int __verify_registered_session(struct ceph_mds_client *mdsc,
 static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 						 int mds)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_session *s;
 
 	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_FENCE_IO)
@@ -973,7 +979,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 		int newmax = 1 << get_count_order(mds + 1);
 		struct ceph_mds_session **sa;
 
-		dout("%s: realloc to %d\n", __func__, newmax);
+		doutc(cl, "realloc to %d\n", newmax);
 		sa = kcalloc(newmax, sizeof(void *), GFP_NOFS);
 		if (!sa)
 			goto fail_realloc;
@@ -986,7 +992,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 		mdsc->max_sessions = newmax;
 	}
 
-	dout("%s: mds%d\n", __func__, mds);
+	doutc(cl, "mds%d\n", mds);
 	s->s_mdsc = mdsc;
 	s->s_mds = mds;
 	s->s_state = CEPH_MDS_SESSION_NEW;
@@ -1029,7 +1035,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 static void __unregister_session(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_session *s)
 {
-	dout("__unregister_session mds%d %p\n", s->s_mds, s);
+	doutc(mdsc->fsc->client, "mds%d %p\n", s->s_mds, s);
 	BUG_ON(mdsc->sessions[s->s_mds] != s);
 	mdsc->sessions[s->s_mds] = NULL;
 	ceph_con_close(&s->s_con);
@@ -1155,6 +1161,7 @@ static void __register_request(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_request *req,
 			       struct inode *dir)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	int ret = 0;
 
 	req->r_tid = ++mdsc->last_tid;
@@ -1162,14 +1169,14 @@ static void __register_request(struct ceph_mds_client *mdsc,
 		ret = ceph_reserve_caps(mdsc, &req->r_caps_reservation,
 					req->r_num_caps);
 		if (ret < 0) {
-			pr_err("__register_request %p "
-			       "failed to reserve caps: %d\n", req, ret);
+			pr_err_client(cl, "%p failed to reserve caps: %d\n",
+				      req, ret);
 			/* set req->r_err to fail early from __do_request */
 			req->r_err = ret;
 			return;
 		}
 	}
-	dout("__register_request %p tid %lld\n", req, req->r_tid);
+	doutc(cl, "%p tid %lld\n", req, req->r_tid);
 	ceph_mdsc_get_request(req);
 	insert_request(&mdsc->request_tree, req);
 
@@ -1192,7 +1199,7 @@ static void __register_request(struct ceph_mds_client *mdsc,
 static void __unregister_request(struct ceph_mds_client *mdsc,
 				 struct ceph_mds_request *req)
 {
-	dout("__unregister_request %p tid %lld\n", req, req->r_tid);
+	doutc(mdsc->fsc->client, "%p tid %lld\n", req, req->r_tid);
 
 	/* Never leave an unregistered request on an unsafe list! */
 	list_del_init(&req->r_unsafe_item);
@@ -1278,6 +1285,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 	int mds = -1;
 	u32 hash = req->r_direct_hash;
 	bool is_hash = test_bit(CEPH_MDS_R_DIRECT_IS_HASH, &req->r_req_flags);
+	struct ceph_client *cl = mdsc->fsc->client;
 
 	if (random)
 		*random = false;
@@ -1289,8 +1297,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 	if (req->r_resend_mds >= 0 &&
 	    (__have_session(mdsc, req->r_resend_mds) ||
 	     ceph_mdsmap_get_state(mdsc->mdsmap, req->r_resend_mds) > 0)) {
-		dout("%s using resend_mds mds%d\n", __func__,
-		     req->r_resend_mds);
+		doutc(cl, "using resend_mds mds%d\n", req->r_resend_mds);
 		return req->r_resend_mds;
 	}
 
@@ -1307,7 +1314,8 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			rcu_read_lock();
 			inode = get_nonsnap_parent(req->r_dentry);
 			rcu_read_unlock();
-			dout("%s using snapdir's parent %p\n", __func__, inode);
+			doutc(cl, "using snapdir's parent %p %llx.%llx\n",
+			      inode, ceph_vinop(inode));
 		}
 	} else if (req->r_dentry) {
 		/* ignore race with rename; old or new d_parent is okay */
@@ -1327,7 +1335,8 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			/* direct snapped/virtual snapdir requests
 			 * based on parent dir inode */
 			inode = get_nonsnap_parent(parent);
-			dout("%s using nonsnap parent %p\n", __func__, inode);
+			doutc(cl, "using nonsnap parent %p %llx.%llx\n",
+			      inode, ceph_vinop(inode));
 		} else {
 			/* dentry target */
 			inode = d_inode(req->r_dentry);
@@ -1343,10 +1352,11 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		rcu_read_unlock();
 	}
 
-	dout("%s %p is_hash=%d (0x%x) mode %d\n", __func__, inode, (int)is_hash,
-	     hash, mode);
 	if (!inode)
 		goto random;
+
+	doutc(cl, "%p %llx.%llx is_hash=%d (0x%x) mode %d\n", inode,
+	      ceph_vinop(inode), (int)is_hash, hash, mode);
 	ci = ceph_inode(inode);
 
 	if (is_hash && S_ISDIR(inode->i_mode)) {
@@ -1362,9 +1372,9 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 				get_random_bytes(&r, 1);
 				r %= frag.ndist;
 				mds = frag.dist[r];
-				dout("%s %p %llx.%llx frag %u mds%d (%d/%d)\n",
-				     __func__, inode, ceph_vinop(inode),
-				     frag.frag, mds, (int)r, frag.ndist);
+				doutc(cl, "%p %llx.%llx frag %u mds%d (%d/%d)\n",
+				      inode, ceph_vinop(inode), frag.frag,
+				      mds, (int)r, frag.ndist);
 				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
 				    CEPH_MDS_STATE_ACTIVE &&
 				    !ceph_mdsmap_is_laggy(mdsc->mdsmap, mds))
@@ -1377,9 +1387,8 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 			if (frag.mds >= 0) {
 				/* choose auth mds */
 				mds = frag.mds;
-				dout("%s %p %llx.%llx frag %u mds%d (auth)\n",
-				     __func__, inode, ceph_vinop(inode),
-				     frag.frag, mds);
+				doutc(cl, "%p %llx.%llx frag %u mds%d (auth)\n",
+				      inode, ceph_vinop(inode), frag.frag, mds);
 				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
 				    CEPH_MDS_STATE_ACTIVE) {
 					if (!ceph_mdsmap_is_laggy(mdsc->mdsmap,
@@ -1403,9 +1412,9 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		goto random;
 	}
 	mds = cap->session->s_mds;
-	dout("%s %p %llx.%llx mds%d (%scap %p)\n", __func__,
-	     inode, ceph_vinop(inode), mds,
-	     cap == ci->i_auth_cap ? "auth " : "", cap);
+	doutc(cl, "%p %llx.%llx mds%d (%scap %p)\n", inode,
+	      ceph_vinop(inode), mds,
+	      cap == ci->i_auth_cap ? "auth " : "", cap);
 	spin_unlock(&ci->i_ceph_lock);
 out:
 	iput(inode);
@@ -1416,7 +1425,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		*random = true;
 
 	mds = ceph_mdsmap_get_random_mds(mdsc->mdsmap);
-	dout("%s chose random mds%d\n", __func__, mds);
+	doutc(cl, "chose random mds%d\n", mds);
 	return mds;
 }
 
@@ -1529,6 +1538,7 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
 	int metadata_key_count = 0;
 	struct ceph_options *opt = mdsc->fsc->client->options;
 	struct ceph_mount_options *fsopt = mdsc->fsc->mount_options;
+	struct ceph_client *cl = mdsc->fsc->client;
 	size_t size, count;
 	void *p, *end;
 	int ret;
@@ -1567,7 +1577,7 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_SESSION, sizeof(*h) + extra_bytes,
 			   GFP_NOFS, false);
 	if (!msg) {
-		pr_err("ENOMEM creating session open msg\n");
+		pr_err_client(cl, "ENOMEM creating session open msg\n");
 		return ERR_PTR(-ENOMEM);
 	}
 	p = msg->front.iov_base;
@@ -1607,14 +1617,14 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
 
 	ret = encode_supported_features(&p, end);
 	if (ret) {
-		pr_err("encode_supported_features failed!\n");
+		pr_err_client(cl, "encode_supported_features failed!\n");
 		ceph_msg_put(msg);
 		return ERR_PTR(ret);
 	}
 
 	ret = encode_metric_spec(&p, end);
 	if (ret) {
-		pr_err("encode_metric_spec failed!\n");
+		pr_err_client(cl, "encode_metric_spec failed!\n");
 		ceph_msg_put(msg);
 		return ERR_PTR(ret);
 	}
@@ -1642,8 +1652,8 @@ static int __open_session(struct ceph_mds_client *mdsc,
 
 	/* wait for mds to go active? */
 	mstate = ceph_mdsmap_get_state(mdsc->mdsmap, mds);
-	dout("open_session to mds%d (%s)\n", mds,
-	     ceph_mds_state_name(mstate));
+	doutc(mdsc->fsc->client, "open_session to mds%d (%s)\n", mds,
+	      ceph_mds_state_name(mstate));
 	session->s_state = CEPH_MDS_SESSION_OPENING;
 	session->s_renew_requested = jiffies;
 
@@ -1686,8 +1696,9 @@ struct ceph_mds_session *
 ceph_mdsc_open_export_target_session(struct ceph_mds_client *mdsc, int target)
 {
 	struct ceph_mds_session *session;
+	struct ceph_client *cl = mdsc->fsc->client;
 
-	dout("open_export_target_session to mds%d\n", target);
+	doutc(cl, "to mds%d\n", target);
 
 	mutex_lock(&mdsc->mutex);
 	session = __open_export_target_session(mdsc, target);
@@ -1702,13 +1713,14 @@ static void __open_export_target_sessions(struct ceph_mds_client *mdsc,
 	struct ceph_mds_info *mi;
 	struct ceph_mds_session *ts;
 	int i, mds = session->s_mds;
+	struct ceph_client *cl = mdsc->fsc->client;
 
 	if (mds >= mdsc->mdsmap->possible_max_rank)
 		return;
 
 	mi = &mdsc->mdsmap->m_info[mds];
-	dout("open_export_target_sessions for mds%d (%d targets)\n",
-	     session->s_mds, mi->num_export_targets);
+	doutc(cl, "for mds%d (%d targets)\n", session->s_mds,
+	      mi->num_export_targets);
 
 	for (i = 0; i < mi->num_export_targets; i++) {
 		ts = __open_export_target_session(mdsc, mi->export_targets[i]);
@@ -1731,11 +1743,13 @@ void ceph_mdsc_open_export_target_sessions(struct ceph_mds_client *mdsc,
 static void detach_cap_releases(struct ceph_mds_session *session,
 				struct list_head *target)
 {
+	struct ceph_client *cl = session->s_mdsc->fsc->client;
+
 	lockdep_assert_held(&session->s_cap_lock);
 
 	list_splice_init(&session->s_cap_releases, target);
 	session->s_num_cap_releases = 0;
-	dout("dispose_cap_releases mds%d\n", session->s_mds);
+	doutc(cl, "mds%d\n", session->s_mds);
 }
 
 static void dispose_cap_releases(struct ceph_mds_client *mdsc,
@@ -1753,16 +1767,17 @@ static void dispose_cap_releases(struct ceph_mds_client *mdsc,
 static void cleanup_session_requests(struct ceph_mds_client *mdsc,
 				     struct ceph_mds_session *session)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct rb_node *p;
 
-	dout("cleanup_session_requests mds%d\n", session->s_mds);
+	doutc(cl, "mds%d\n", session->s_mds);
 	mutex_lock(&mdsc->mutex);
 	while (!list_empty(&session->s_unsafe)) {
 		req = list_first_entry(&session->s_unsafe,
 				       struct ceph_mds_request, r_unsafe_item);
-		pr_warn_ratelimited(" dropping unsafe request %llu\n",
-				    req->r_tid);
+		pr_warn_ratelimited_client(cl, " dropping unsafe request %llu\n",
+					   req->r_tid);
 		if (req->r_target_inode)
 			mapping_set_error(req->r_target_inode->i_mapping, -EIO);
 		if (req->r_unsafe_dir)
@@ -1791,13 +1806,14 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 			      int (*cb)(struct inode *, int mds, void *),
 			      void *arg)
 {
+	struct ceph_client *cl = session->s_mdsc->fsc->client;
 	struct list_head *p;
 	struct ceph_cap *cap;
 	struct inode *inode, *last_inode = NULL;
 	struct ceph_cap *old_cap = NULL;
 	int ret;
 
-	dout("iterate_session_caps %p mds%d\n", session, session->s_mds);
+	doutc(cl, "%p mds%d\n", session, session->s_mds);
 	spin_lock(&session->s_cap_lock);
 	p = session->s_caps.next;
 	while (p != &session->s_caps) {
@@ -1828,8 +1844,7 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 		spin_lock(&session->s_cap_lock);
 		p = p->next;
 		if (!cap->ci) {
-			dout("iterate_session_caps  finishing cap %p removal\n",
-			     cap);
+			doutc(cl, "finishing cap %p removal\n", cap);
 			BUG_ON(cap->session != session);
 			cap->session = NULL;
 			list_del_init(&cap->session_caps);
@@ -1858,6 +1873,7 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 static int remove_session_caps_cb(struct inode *inode, int mds, void *arg)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	bool invalidate = false;
 	struct ceph_cap *cap;
 	int iputs = 0;
@@ -1865,8 +1881,8 @@ static int remove_session_caps_cb(struct inode *inode, int mds, void *arg)
 	spin_lock(&ci->i_ceph_lock);
 	cap = __get_cap_for_mds(ci, mds);
 	if (cap) {
-		dout(" removing cap %p, ci is %p, inode is %p\n",
-		     cap, ci, &ci->netfs.inode);
+		doutc(cl, " removing cap %p, ci is %p, inode is %p\n",
+		      cap, ci, &ci->netfs.inode);
 
 		iputs = ceph_purge_inode_cap(inode, cap, &invalidate);
 	}
@@ -1890,7 +1906,7 @@ static void remove_session_caps(struct ceph_mds_session *session)
 	struct super_block *sb = fsc->sb;
 	LIST_HEAD(dispose);
 
-	dout("remove_session_caps on %p\n", session);
+	doutc(fsc->client, "on %p\n", session);
 	ceph_iterate_session_caps(session, remove_session_caps_cb, fsc);
 
 	wake_up_all(&fsc->mdsc->cap_flushing_wq);
@@ -1971,7 +1987,9 @@ static int wake_up_session_cb(struct inode *inode, int mds, void *arg)
 
 static void wake_up_session_caps(struct ceph_mds_session *session, int ev)
 {
-	dout("wake_up_session_caps %p mds%d\n", session, session->s_mds);
+	struct ceph_client *cl = session->s_mdsc->fsc->client;
+
+	doutc(cl, "session %p mds%d\n", session, session->s_mds);
 	ceph_iterate_session_caps(session, wake_up_session_cb,
 				  (void *)(unsigned long)ev);
 }
@@ -1985,25 +2003,26 @@ static void wake_up_session_caps(struct ceph_mds_session *session, int ev)
 static int send_renew_caps(struct ceph_mds_client *mdsc,
 			   struct ceph_mds_session *session)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *msg;
 	int state;
 
 	if (time_after_eq(jiffies, session->s_cap_ttl) &&
 	    time_after_eq(session->s_cap_ttl, session->s_renew_requested))
-		pr_info("mds%d caps stale\n", session->s_mds);
+		pr_info_client(cl, "mds%d caps stale\n", session->s_mds);
 	session->s_renew_requested = jiffies;
 
 	/* do not try to renew caps until a recovering mds has reconnected
 	 * with its clients. */
 	state = ceph_mdsmap_get_state(mdsc->mdsmap, session->s_mds);
 	if (state < CEPH_MDS_STATE_RECONNECT) {
-		dout("send_renew_caps ignoring mds%d (%s)\n",
-		     session->s_mds, ceph_mds_state_name(state));
+		doutc(cl, "ignoring mds%d (%s)\n", session->s_mds,
+		      ceph_mds_state_name(state));
 		return 0;
 	}
 
-	dout("send_renew_caps to mds%d (%s)\n", session->s_mds,
-		ceph_mds_state_name(state));
+	doutc(cl, "to mds%d (%s)\n", session->s_mds,
+	      ceph_mds_state_name(state));
 	msg = ceph_create_session_msg(CEPH_SESSION_REQUEST_RENEWCAPS,
 				      ++session->s_renew_seq);
 	if (!msg)
@@ -2015,10 +2034,11 @@ static int send_renew_caps(struct ceph_mds_client *mdsc,
 static int send_flushmsg_ack(struct ceph_mds_client *mdsc,
 			     struct ceph_mds_session *session, u64 seq)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *msg;
 
-	dout("send_flushmsg_ack to mds%d (%s)s seq %lld\n",
-	     session->s_mds, ceph_session_state_name(session->s_state), seq);
+	doutc(cl, "to mds%d (%s)s seq %lld\n", session->s_mds,
+	      ceph_session_state_name(session->s_state), seq);
 	msg = ceph_create_session_msg(CEPH_SESSION_FLUSHMSG_ACK, seq);
 	if (!msg)
 		return -ENOMEM;
@@ -2035,6 +2055,7 @@ static int send_flushmsg_ack(struct ceph_mds_client *mdsc,
 static void renewed_caps(struct ceph_mds_client *mdsc,
 			 struct ceph_mds_session *session, int is_renew)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	int was_stale;
 	int wake = 0;
 
@@ -2046,15 +2067,17 @@ static void renewed_caps(struct ceph_mds_client *mdsc,
 
 	if (was_stale) {
 		if (time_before(jiffies, session->s_cap_ttl)) {
-			pr_info("mds%d caps renewed\n", session->s_mds);
+			pr_info_client(cl, "mds%d caps renewed\n",
+				       session->s_mds);
 			wake = 1;
 		} else {
-			pr_info("mds%d caps still stale\n", session->s_mds);
+			pr_info_client(cl, "mds%d caps still stale\n",
+				       session->s_mds);
 		}
 	}
-	dout("renewed_caps mds%d ttl now %lu, was %s, now %s\n",
-	     session->s_mds, session->s_cap_ttl, was_stale ? "stale" : "fresh",
-	     time_before(jiffies, session->s_cap_ttl) ? "stale" : "fresh");
+	doutc(cl, "mds%d ttl now %lu, was %s, now %s\n", session->s_mds,
+	      session->s_cap_ttl, was_stale ? "stale" : "fresh",
+	      time_before(jiffies, session->s_cap_ttl) ? "stale" : "fresh");
 	spin_unlock(&session->s_cap_lock);
 
 	if (wake)
@@ -2066,11 +2089,11 @@ static void renewed_caps(struct ceph_mds_client *mdsc,
  */
 static int request_close_session(struct ceph_mds_session *session)
 {
+	struct ceph_client *cl = session->s_mdsc->fsc->client;
 	struct ceph_msg *msg;
 
-	dout("request_close_session mds%d state %s seq %lld\n",
-	     session->s_mds, ceph_session_state_name(session->s_state),
-	     session->s_seq);
+	doutc(cl, "mds%d state %s seq %lld\n", session->s_mds,
+	      ceph_session_state_name(session->s_state), session->s_seq);
 	msg = ceph_create_session_msg(CEPH_SESSION_REQUEST_CLOSE,
 				      session->s_seq);
 	if (!msg)
@@ -2127,6 +2150,7 @@ static bool drop_negative_children(struct dentry *dentry)
 static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	int *remaining = arg;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int used, wanted, oissued, mine;
@@ -2146,9 +2170,10 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 	wanted = __ceph_caps_file_wanted(ci);
 	oissued = __ceph_caps_issued_other(ci, cap);
 
-	dout("trim_caps_cb %p cap %p mine %s oissued %s used %s wanted %s\n",
-	     inode, cap, ceph_cap_string(mine), ceph_cap_string(oissued),
-	     ceph_cap_string(used), ceph_cap_string(wanted));
+	doutc(cl, "%p %llx.%llx cap %p mine %s oissued %s used %s wanted %s\n",
+	      inode, ceph_vinop(inode), cap, ceph_cap_string(mine),
+	      ceph_cap_string(oissued), ceph_cap_string(used),
+	      ceph_cap_string(wanted));
 	if (cap == ci->i_auth_cap) {
 		if (ci->i_dirty_caps || ci->i_flushing_caps ||
 		    !list_empty(&ci->i_cap_snaps))
@@ -2188,8 +2213,8 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 			count = atomic_read(&inode->i_count);
 			if (count == 1)
 				(*remaining)--;
-			dout("trim_caps_cb %p cap %p pruned, count now %d\n",
-			     inode, cap, count);
+			doutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
+			      inode, ceph_vinop(inode), cap, count);
 		} else {
 			dput(dentry);
 		}
@@ -2208,17 +2233,18 @@ int ceph_trim_caps(struct ceph_mds_client *mdsc,
 		   struct ceph_mds_session *session,
 		   int max_caps)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	int trim_caps = session->s_nr_caps - max_caps;
 
-	dout("trim_caps mds%d start: %d / %d, trim %d\n",
-	     session->s_mds, session->s_nr_caps, max_caps, trim_caps);
+	doutc(cl, "mds%d start: %d / %d, trim %d\n", session->s_mds,
+	      session->s_nr_caps, max_caps, trim_caps);
 	if (trim_caps > 0) {
 		int remaining = trim_caps;
 
 		ceph_iterate_session_caps(session, trim_caps_cb, &remaining);
-		dout("trim_caps mds%d done: %d / %d, trimmed %d\n",
-		     session->s_mds, session->s_nr_caps, max_caps,
-			trim_caps - remaining);
+		doutc(cl, "mds%d done: %d / %d, trimmed %d\n",
+		      session->s_mds, session->s_nr_caps, max_caps,
+		      trim_caps - remaining);
 	}
 
 	ceph_flush_cap_releases(mdsc, session);
@@ -2228,6 +2254,7 @@ int ceph_trim_caps(struct ceph_mds_client *mdsc,
 static int check_caps_flush(struct ceph_mds_client *mdsc,
 			    u64 want_flush_tid)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	int ret = 1;
 
 	spin_lock(&mdsc->cap_dirty_lock);
@@ -2236,8 +2263,8 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
 			list_first_entry(&mdsc->cap_flush_list,
 					 struct ceph_cap_flush, g_list);
 		if (cf->tid <= want_flush_tid) {
-			dout("check_caps_flush still flushing tid "
-			     "%llu <= %llu\n", cf->tid, want_flush_tid);
+			doutc(cl, "still flushing tid %llu <= %llu\n",
+			      cf->tid, want_flush_tid);
 			ret = 0;
 		}
 	}
@@ -2253,12 +2280,14 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
 static void wait_caps_flush(struct ceph_mds_client *mdsc,
 			    u64 want_flush_tid)
 {
-	dout("check_caps_flush want %llu\n", want_flush_tid);
+	struct ceph_client *cl = mdsc->fsc->client;
+
+	doutc(cl, "want %llu\n", want_flush_tid);
 
 	wait_event(mdsc->cap_flushing_wq,
 		   check_caps_flush(mdsc, want_flush_tid));
 
-	dout("check_caps_flush ok, flushed thru %llu\n", want_flush_tid);
+	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
 }
 
 /*
@@ -2267,6 +2296,7 @@ static void wait_caps_flush(struct ceph_mds_client *mdsc,
 static void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 				   struct ceph_mds_session *session)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *msg = NULL;
 	struct ceph_mds_cap_release *head;
 	struct ceph_mds_cap_item *item;
@@ -2325,7 +2355,7 @@ static void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 			msg->front.iov_len += sizeof(*cap_barrier);
 
 			msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
-			dout("send_cap_releases mds%d %p\n", session->s_mds, msg);
+			doutc(cl, "mds%d %p\n", session->s_mds, msg);
 			ceph_con_send(&session->s_con, msg);
 			msg = NULL;
 		}
@@ -2345,13 +2375,13 @@ static void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 		msg->front.iov_len += sizeof(*cap_barrier);
 
 		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
-		dout("send_cap_releases mds%d %p\n", session->s_mds, msg);
+		doutc(cl, "mds%d %p\n", session->s_mds, msg);
 		ceph_con_send(&session->s_con, msg);
 	}
 	return;
 out_err:
-	pr_err("send_cap_releases mds%d, failed to allocate message\n",
-		session->s_mds);
+	pr_err_client(cl, "mds%d, failed to allocate message\n",
+		      session->s_mds);
 	spin_lock(&session->s_cap_lock);
 	list_splice(&tmp_list, &session->s_cap_releases);
 	session->s_num_cap_releases += num_cap_releases;
@@ -2374,16 +2404,17 @@ static void ceph_cap_release_work(struct work_struct *work)
 void ceph_flush_cap_releases(struct ceph_mds_client *mdsc,
 		             struct ceph_mds_session *session)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	if (mdsc->stopping)
 		return;
 
 	ceph_get_mds_session(session);
 	if (queue_work(mdsc->fsc->cap_wq,
 		       &session->s_cap_release_work)) {
-		dout("cap release work queued\n");
+		doutc(cl, "cap release work queued\n");
 	} else {
 		ceph_put_mds_session(session);
-		dout("failed to queue cap release work\n");
+		doutc(cl, "failed to queue cap release work\n");
 	}
 }
 
@@ -2411,13 +2442,14 @@ static void ceph_cap_reclaim_work(struct work_struct *work)
 
 void ceph_queue_cap_reclaim_work(struct ceph_mds_client *mdsc)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	if (mdsc->stopping)
 		return;
 
         if (queue_work(mdsc->fsc->cap_wq, &mdsc->cap_reclaim_work)) {
-                dout("caps reclaim work queued\n");
+                doutc(cl, "caps reclaim work queued\n");
         } else {
-                dout("failed to queue caps release work\n");
+                doutc(cl, "failed to queue caps release work\n");
         }
 }
 
@@ -2612,6 +2644,7 @@ static u8 *get_fscrypt_altname(const struct ceph_mds_request *req, u32 *plen)
 char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 			   int *plen, u64 *pbase, int for_wire)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct dentry *cur;
 	struct inode *inode;
 	char *path;
@@ -2637,8 +2670,7 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 		spin_lock(&cur->d_lock);
 		inode = d_inode(cur);
 		if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
-			dout("build_path path+%d: %p SNAPDIR\n",
-			     pos, cur);
+			doutc(cl, "path+%d: %p SNAPDIR\n", pos, cur);
 			spin_unlock(&cur->d_lock);
 			parent = dget_parent(cur);
 		} else if (for_wire && inode && dentry != cur &&
@@ -2716,15 +2748,15 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 		 * A rename didn't occur, but somehow we didn't end up where
 		 * we thought we would. Throw a warning and try again.
 		 */
-		pr_warn("build_path did not end path lookup where expected (pos = %d)\n",
-			pos);
+		pr_warn_client(cl, "did not end path lookup where expected (pos = %d)\n",
+			       pos);
 		goto retry;
 	}
 
 	*pbase = base;
 	*plen = PATH_MAX - 1 - pos;
-	dout("build_path on %p %d built %llx '%.*s'\n",
-	     dentry, d_count(dentry), base, *plen, path + pos);
+	doutc(cl, "on %p %d built %llx '%.*s'\n", dentry, d_count(dentry),
+	      base, *plen, path + pos);
 	return path + pos;
 }
 
@@ -2787,22 +2819,22 @@ static int set_request_path_attr(struct ceph_mds_client *mdsc, struct inode *rin
 				 int *pathlen, u64 *ino, bool *freepath,
 				 bool parent_locked)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	int r = 0;
 
 	if (rinode) {
 		r = build_inode_path(rinode, ppath, pathlen, ino, freepath);
-		dout(" inode %p %llx.%llx\n", rinode, ceph_ino(rinode),
-		     ceph_snap(rinode));
+		doutc(cl, " inode %p %llx.%llx\n", rinode, ceph_ino(rinode),
+		      ceph_snap(rinode));
 	} else if (rdentry) {
 		r = build_dentry_path(mdsc, rdentry, rdiri, ppath, pathlen, ino,
 					freepath, parent_locked);
-		dout(" dentry %p %llx/%.*s\n", rdentry, *ino, *pathlen,
-		     *ppath);
+		doutc(cl, " dentry %p %llx/%.*s\n", rdentry, *ino, *pathlen, *ppath);
 	} else if (rpath || rino) {
 		*ino = rino;
 		*ppath = rpath;
 		*pathlen = rpath ? strlen(rpath) : 0;
-		dout(" path %.*s\n", *pathlen, rpath);
+		doutc(cl, " path %.*s\n", *pathlen, rpath);
 	}
 
 	return r;
@@ -3103,6 +3135,7 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 {
 	int mds = session->s_mds;
 	struct ceph_mds_client *mdsc = session->s_mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request_head_legacy *lhead;
 	struct ceph_mds_request_head *nhead;
 	struct ceph_msg *msg;
@@ -3121,8 +3154,8 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 	       old_max_retry = 1 << (old_max_retry * BITS_PER_BYTE);
 	       if ((old_version && req->r_attempts >= old_max_retry) ||
 		   ((uint32_t)req->r_attempts >= U32_MAX)) {
-			pr_warn_ratelimited("%s request tid %llu seq overflow\n",
-					    __func__, req->r_tid);
+			pr_warn_ratelimited_client(cl, "request tid %llu seq overflow\n",
+						   req->r_tid);
 			return -EMULTIHOP;
 	       }
 	}
@@ -3137,8 +3170,8 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 		else
 			req->r_sent_on_mseq = -1;
 	}
-	dout("%s %p tid %lld %s (attempt %d)\n", __func__, req,
-	     req->r_tid, ceph_mds_op_name(req->r_op), req->r_attempts);
+	doutc(cl, "%p tid %lld %s (attempt %d)\n", req, req->r_tid,
+	      ceph_mds_op_name(req->r_op), req->r_attempts);
 
 	if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags)) {
 		void *p;
@@ -3206,7 +3239,7 @@ static int __prepare_send_request(struct ceph_mds_session *session,
 		nhead->ext_num_retry = cpu_to_le32(req->r_attempts - 1);
 	}
 
-	dout(" r_parent = %p\n", req->r_parent);
+	doutc(cl, " r_parent = %p\n", req->r_parent);
 	return 0;
 }
 
@@ -3234,6 +3267,7 @@ static int __send_request(struct ceph_mds_session *session,
 static void __do_request(struct ceph_mds_client *mdsc,
 			struct ceph_mds_request *req)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_session *session = NULL;
 	int mds = -1;
 	int err = 0;
@@ -3246,29 +3280,29 @@ static void __do_request(struct ceph_mds_client *mdsc,
 	}
 
 	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_FENCE_IO) {
-		dout("do_request metadata corrupted\n");
+		doutc(cl, "metadata corrupted\n");
 		err = -EIO;
 		goto finish;
 	}
 	if (req->r_timeout &&
 	    time_after_eq(jiffies, req->r_started + req->r_timeout)) {
-		dout("do_request timed out\n");
+		doutc(cl, "timed out\n");
 		err = -ETIMEDOUT;
 		goto finish;
 	}
 	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
-		dout("do_request forced umount\n");
+		doutc(cl, "forced umount\n");
 		err = -EIO;
 		goto finish;
 	}
 	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_MOUNTING) {
 		if (mdsc->mdsmap_err) {
 			err = mdsc->mdsmap_err;
-			dout("do_request mdsmap err %d\n", err);
+			doutc(cl, "mdsmap err %d\n", err);
 			goto finish;
 		}
 		if (mdsc->mdsmap->m_epoch == 0) {
-			dout("do_request no mdsmap, waiting for map\n");
+			doutc(cl, "no mdsmap, waiting for map\n");
 			list_add(&req->r_wait, &mdsc->waiting_for_map);
 			return;
 		}
@@ -3289,7 +3323,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 			err = -EJUKEBOX;
 			goto finish;
 		}
-		dout("do_request no mds or not active, waiting for map\n");
+		doutc(cl, "no mds or not active, waiting for map\n");
 		list_add(&req->r_wait, &mdsc->waiting_for_map);
 		return;
 	}
@@ -3305,8 +3339,8 @@ static void __do_request(struct ceph_mds_client *mdsc,
 	}
 	req->r_session = ceph_get_mds_session(session);
 
-	dout("do_request mds%d session %p state %s\n", mds, session,
-	     ceph_session_state_name(session->s_state));
+	doutc(cl, "mds%d session %p state %s\n", mds, session,
+	      ceph_session_state_name(session->s_state));
 
 	/*
 	 * The old ceph will crash the MDSs when see unknown OPs
@@ -3397,8 +3431,8 @@ static void __do_request(struct ceph_mds_client *mdsc,
 		spin_lock(&ci->i_ceph_lock);
 		cap = ci->i_auth_cap;
 		if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds != cap->mds) {
-			dout("do_request session changed for auth cap %d -> %d\n",
-			     cap->session->s_mds, session->s_mds);
+			doutc(cl, "session changed for auth cap %d -> %d\n",
+			      cap->session->s_mds, session->s_mds);
 
 			/* Remove the auth cap from old session */
 			spin_lock(&cap->session->s_cap_lock);
@@ -3425,7 +3459,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 	ceph_put_mds_session(session);
 finish:
 	if (err) {
-		dout("__do_request early error %d\n", err);
+		doutc(cl, "early error %d\n", err);
 		req->r_err = err;
 		complete_request(mdsc, req);
 		__unregister_request(mdsc, req);
@@ -3439,6 +3473,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
 static void __wake_requests(struct ceph_mds_client *mdsc,
 			    struct list_head *head)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	LIST_HEAD(tmp_list);
 
@@ -3448,7 +3483,8 @@ static void __wake_requests(struct ceph_mds_client *mdsc,
 		req = list_entry(tmp_list.next,
 				 struct ceph_mds_request, r_wait);
 		list_del_init(&req->r_wait);
-		dout(" wake request %p tid %llu\n", req, req->r_tid);
+		doutc(cl, " wake request %p tid %llu\n", req,
+		      req->r_tid);
 		__do_request(mdsc, req);
 	}
 }
@@ -3459,10 +3495,11 @@ static void __wake_requests(struct ceph_mds_client *mdsc,
  */
 static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct rb_node *p = rb_first(&mdsc->request_tree);
 
-	dout("kick_requests mds%d\n", mds);
+	doutc(cl, "kick_requests mds%d\n", mds);
 	while (p) {
 		req = rb_entry(p, struct ceph_mds_request, r_node);
 		p = rb_next(p);
@@ -3472,7 +3509,7 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 			continue; /* only new requests */
 		if (req->r_session &&
 		    req->r_session->s_mds == mds) {
-			dout(" kicking tid %llu\n", req->r_tid);
+			doutc(cl, " kicking tid %llu\n", req->r_tid);
 			list_del_init(&req->r_wait);
 			__do_request(mdsc, req);
 		}
@@ -3482,6 +3519,7 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 			      struct ceph_mds_request *req)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	int err = 0;
 
 	/* take CAP_PIN refs for r_inode, r_parent, r_old_dentry */
@@ -3503,8 +3541,7 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 	if (req->r_inode) {
 		err = ceph_wait_on_async_create(req->r_inode);
 		if (err) {
-			dout("%s: wait for async create returned: %d\n",
-			     __func__, err);
+			doutc(cl, "wait for async create returned: %d\n", err);
 			return err;
 		}
 	}
@@ -3512,13 +3549,12 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 	if (!err && req->r_old_inode) {
 		err = ceph_wait_on_async_create(req->r_old_inode);
 		if (err) {
-			dout("%s: wait for async create returned: %d\n",
-			     __func__, err);
+			doutc(cl, "wait for async create returned: %d\n", err);
 			return err;
 		}
 	}
 
-	dout("submit_request on %p for inode %p\n", req, dir);
+	doutc(cl, "submit_request on %p for inode %p\n", req, dir);
 	mutex_lock(&mdsc->mutex);
 	__register_request(mdsc, req, dir);
 	__do_request(mdsc, req);
@@ -3531,10 +3567,11 @@ int ceph_mdsc_wait_request(struct ceph_mds_client *mdsc,
 			   struct ceph_mds_request *req,
 			   ceph_mds_request_wait_callback_t wait_func)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	int err;
 
 	/* wait */
-	dout("do_request waiting\n");
+	doutc(cl, "do_request waiting\n");
 	if (wait_func) {
 		err = wait_func(mdsc, req);
 	} else {
@@ -3548,14 +3585,14 @@ int ceph_mdsc_wait_request(struct ceph_mds_client *mdsc,
 		else
 			err = timeleft;  /* killed */
 	}
-	dout("do_request waited, got %d\n", err);
+	doutc(cl, "do_request waited, got %d\n", err);
 	mutex_lock(&mdsc->mutex);
 
 	/* only abort if we didn't race with a real reply */
 	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
 		err = le32_to_cpu(req->r_reply_info.head->result);
 	} else if (err < 0) {
-		dout("aborted request %lld with %d\n", req->r_tid, err);
+		doutc(cl, "aborted request %lld with %d\n", req->r_tid, err);
 
 		/*
 		 * ensure we aren't running concurrently with
@@ -3586,15 +3623,16 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
 			 struct inode *dir,
 			 struct ceph_mds_request *req)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	int err;
 
-	dout("do_request on %p\n", req);
+	doutc(cl, "do_request on %p\n", req);
 
 	/* issue */
 	err = ceph_mdsc_submit_request(mdsc, dir, req);
 	if (!err)
 		err = ceph_mdsc_wait_request(mdsc, req, NULL);
-	dout("do_request %p done, result %d\n", req, err);
+	doutc(cl, "do_request %p done, result %d\n", req, err);
 	return err;
 }
 
@@ -3606,8 +3644,10 @@ void ceph_invalidate_dir_request(struct ceph_mds_request *req)
 {
 	struct inode *dir = req->r_parent;
 	struct inode *old_dir = req->r_old_dentry_dir;
+	struct ceph_client *cl = req->r_mdsc->fsc->client;
 
-	dout("invalidate_dir_request %p %p (complete, lease(s))\n", dir, old_dir);
+	doutc(cl, "invalidate_dir_request %p %p (complete, lease(s))\n",
+	      dir, old_dir);
 
 	ceph_dir_clear_complete(dir);
 	if (old_dir)
@@ -3628,6 +3668,7 @@ void ceph_invalidate_dir_request(struct ceph_mds_request *req)
 static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 {
 	struct ceph_mds_client *mdsc = session->s_mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct ceph_mds_reply_head *head = msg->front.iov_base;
 	struct ceph_mds_reply_info_parsed *rinfo;  /* parsed reply info */
@@ -3638,7 +3679,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	bool close_sessions = false;
 
 	if (msg->front.iov_len < sizeof(*head)) {
-		pr_err("mdsc_handle_reply got corrupt (short) reply\n");
+		pr_err_client(cl, "got corrupt (short) reply\n");
 		ceph_msg_dump(msg);
 		return;
 	}
@@ -3648,17 +3689,17 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	mutex_lock(&mdsc->mutex);
 	req = lookup_get_request(mdsc, tid);
 	if (!req) {
-		dout("handle_reply on unknown tid %llu\n", tid);
+		doutc(cl, "on unknown tid %llu\n", tid);
 		mutex_unlock(&mdsc->mutex);
 		return;
 	}
-	dout("handle_reply %p\n", req);
+	doutc(cl, "handle_reply %p\n", req);
 
 	/* correct session? */
 	if (req->r_session != session) {
-		pr_err("mdsc_handle_reply got %llu on session mds%d"
-		       " not mds%d\n", tid, session->s_mds,
-		       req->r_session ? req->r_session->s_mds : -1);
+		pr_err_client(cl, "got %llu on session mds%d not mds%d\n",
+			      tid, session->s_mds,
+			      req->r_session ? req->r_session->s_mds : -1);
 		mutex_unlock(&mdsc->mutex);
 		goto out;
 	}
@@ -3666,14 +3707,14 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	/* dup? */
 	if ((test_bit(CEPH_MDS_R_GOT_UNSAFE, &req->r_req_flags) && !head->safe) ||
 	    (test_bit(CEPH_MDS_R_GOT_SAFE, &req->r_req_flags) && head->safe)) {
-		pr_warn("got a dup %s reply on %llu from mds%d\n",
-			   head->safe ? "safe" : "unsafe", tid, mds);
+		pr_warn_client(cl, "got a dup %s reply on %llu from mds%d\n",
+			       head->safe ? "safe" : "unsafe", tid, mds);
 		mutex_unlock(&mdsc->mutex);
 		goto out;
 	}
 	if (test_bit(CEPH_MDS_R_GOT_SAFE, &req->r_req_flags)) {
-		pr_warn("got unsafe after safe on %llu from mds%d\n",
-			   tid, mds);
+		pr_warn_client(cl, "got unsafe after safe on %llu from mds%d\n",
+			       tid, mds);
 		mutex_unlock(&mdsc->mutex);
 		goto out;
 	}
@@ -3696,7 +3737,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			 * response.  And even if it did, there is nothing
 			 * useful we could do with a revised return value.
 			 */
-			dout("got safe reply %llu, mds%d\n", tid, mds);
+			doutc(cl, "got safe reply %llu, mds%d\n", tid, mds);
 
 			mutex_unlock(&mdsc->mutex);
 			goto out;
@@ -3706,7 +3747,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 		list_add_tail(&req->r_unsafe_item, &req->r_session->s_unsafe);
 	}
 
-	dout("handle_reply tid %lld result %d\n", tid, result);
+	doutc(cl, "tid %lld result %d\n", tid, result);
 	if (test_bit(CEPHFS_FEATURE_REPLY_ENCODING, &session->s_features))
 		err = parse_reply_info(session, msg, req, (u64)-1);
 	else
@@ -3746,7 +3787,8 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 
 	mutex_lock(&session->s_mutex);
 	if (err < 0) {
-		pr_err("mdsc_handle_reply got corrupt reply mds%d(tid:%lld)\n", mds, tid);
+		pr_err_client(cl, "got corrupt reply mds%d(tid:%lld)\n",
+			      mds, tid);
 		ceph_msg_dump(msg);
 		goto out_err;
 	}
@@ -3810,7 +3852,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			set_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags);
 		}
 	} else {
-		dout("reply arrived after request %lld was aborted\n", tid);
+		doutc(cl, "reply arrived after request %lld was aborted\n", tid);
 	}
 	mutex_unlock(&mdsc->mutex);
 
@@ -3839,6 +3881,7 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 			   struct ceph_mds_session *session,
 			   struct ceph_msg *msg)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	u64 tid = le64_to_cpu(msg->hdr.tid);
 	u32 next_mds;
@@ -3856,12 +3899,12 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 	req = lookup_get_request(mdsc, tid);
 	if (!req) {
 		mutex_unlock(&mdsc->mutex);
-		dout("forward tid %llu to mds%d - req dne\n", tid, next_mds);
+		doutc(cl, "forward tid %llu to mds%d - req dne\n", tid, next_mds);
 		return;  /* dup reply? */
 	}
 
 	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags)) {
-		dout("forward tid %llu aborted, unregistering\n", tid);
+		doutc(cl, "forward tid %llu aborted, unregistering\n", tid);
 		__unregister_request(mdsc, req);
 	} else if (fwd_seq <= req->r_num_fwd || (uint32_t)fwd_seq >= U32_MAX) {
 		/*
@@ -3877,10 +3920,11 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 		set_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags);
 		mutex_unlock(&req->r_fill_mutex);
 		aborted = true;
-		pr_warn_ratelimited("forward tid %llu seq overflow\n", tid);
+		pr_warn_ratelimited_client(cl, "forward tid %llu seq overflow\n",
+					   tid);
 	} else {
 		/* resend. forward race not possible; mds would drop */
-		dout("forward tid %llu to mds%d (we resend)\n", tid, next_mds);
+		doutc(cl, "forward tid %llu to mds%d (we resend)\n", tid, next_mds);
 		BUG_ON(req->r_err);
 		BUG_ON(test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags));
 		req->r_attempts = 0;
@@ -3898,7 +3942,7 @@ static void handle_forward(struct ceph_mds_client *mdsc,
 	return;
 
 bad:
-	pr_err("mdsc_handle_forward decode error err=%d\n", err);
+	pr_err_client(cl, "decode error err=%d\n", err);
 	ceph_msg_dump(msg);
 }
 
@@ -3937,6 +3981,7 @@ static void handle_session(struct ceph_mds_session *session,
 			   struct ceph_msg *msg)
 {
 	struct ceph_mds_client *mdsc = session->s_mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	int mds = session->s_mds;
 	int msg_version = le16_to_cpu(msg->hdr.version);
 	void *p = msg->front.iov_base;
@@ -3984,7 +4029,8 @@ static void handle_session(struct ceph_mds_session *session,
 		/* version >= 5, flags   */
 		ceph_decode_32_safe(&p, end, flags, bad);
 		if (flags & CEPH_SESSION_BLOCKLISTED) {
-			pr_warn("mds%d session blocklisted\n", session->s_mds);
+			pr_warn_client(cl, "mds%d session blocklisted\n",
+				       session->s_mds);
 			blocklisted = true;
 		}
 	}
@@ -4000,23 +4046,25 @@ static void handle_session(struct ceph_mds_session *session,
 
 	mutex_lock(&session->s_mutex);
 
-	dout("handle_session mds%d %s %p state %s seq %llu\n",
-	     mds, ceph_session_op_name(op), session,
-	     ceph_session_state_name(session->s_state), seq);
+	doutc(cl, "mds%d %s %p state %s seq %llu\n", mds,
+	      ceph_session_op_name(op), session,
+	      ceph_session_state_name(session->s_state), seq);
 
 	if (session->s_state == CEPH_MDS_SESSION_HUNG) {
 		session->s_state = CEPH_MDS_SESSION_OPEN;
-		pr_info("mds%d came back\n", session->s_mds);
+		pr_info_client(cl, "mds%d came back\n", session->s_mds);
 	}
 
 	switch (op) {
 	case CEPH_SESSION_OPEN:
 		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
-			pr_info("mds%d reconnect success\n", session->s_mds);
+			pr_info_client(cl, "mds%d reconnect success\n",
+				       session->s_mds);
 
 		session->s_features = features;
 		if (session->s_state == CEPH_MDS_SESSION_OPEN) {
-			pr_notice("mds%d is already opened\n", session->s_mds);
+			pr_notice_client(cl, "mds%d is already opened\n",
+					 session->s_mds);
 		} else {
 			session->s_state = CEPH_MDS_SESSION_OPEN;
 			renewed_caps(mdsc, session, 0);
@@ -4045,7 +4093,8 @@ static void handle_session(struct ceph_mds_session *session,
 
 	case CEPH_SESSION_CLOSE:
 		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
-			pr_info("mds%d reconnect denied\n", session->s_mds);
+			pr_info_client(cl, "mds%d reconnect denied\n",
+				       session->s_mds);
 		session->s_state = CEPH_MDS_SESSION_CLOSED;
 		cleanup_session_requests(mdsc, session);
 		remove_session_caps(session);
@@ -4054,8 +4103,8 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_STALE:
-		pr_info("mds%d caps went stale, renewing\n",
-			session->s_mds);
+		pr_info_client(cl, "mds%d caps went stale, renewing\n",
+			       session->s_mds);
 		atomic_inc(&session->s_cap_gen);
 		session->s_cap_ttl = jiffies - 1;
 		send_renew_caps(mdsc, session);
@@ -4076,7 +4125,7 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_FORCE_RO:
-		dout("force_session_readonly %p\n", session);
+		doutc(cl, "force_session_readonly %p\n", session);
 		spin_lock(&session->s_cap_lock);
 		session->s_readonly = true;
 		spin_unlock(&session->s_cap_lock);
@@ -4085,7 +4134,8 @@ static void handle_session(struct ceph_mds_session *session,
 
 	case CEPH_SESSION_REJECT:
 		WARN_ON(session->s_state != CEPH_MDS_SESSION_OPENING);
-		pr_info("mds%d rejected session\n", session->s_mds);
+		pr_info_client(cl, "mds%d rejected session\n",
+			       session->s_mds);
 		session->s_state = CEPH_MDS_SESSION_REJECTED;
 		cleanup_session_requests(mdsc, session);
 		remove_session_caps(session);
@@ -4095,7 +4145,7 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	default:
-		pr_err("mdsc_handle_session bad op %d mds%d\n", op, mds);
+		pr_err_client(cl, "bad op %d mds%d\n", op, mds);
 		WARN_ON(1);
 	}
 
@@ -4112,30 +4162,32 @@ static void handle_session(struct ceph_mds_session *session,
 	return;
 
 bad:
-	pr_err("mdsc_handle_session corrupt message mds%d len %d\n", mds,
-	       (int)msg->front.iov_len);
+	pr_err_client(cl, "corrupt message mds%d len %d\n", mds,
+		      (int)msg->front.iov_len);
 	ceph_msg_dump(msg);
 	return;
 }
 
 void ceph_mdsc_release_dir_caps(struct ceph_mds_request *req)
 {
+	struct ceph_client *cl = req->r_mdsc->fsc->client;
 	int dcaps;
 
 	dcaps = xchg(&req->r_dir_caps, 0);
 	if (dcaps) {
-		dout("releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
+		doutc(cl, "releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
 		ceph_put_cap_refs(ceph_inode(req->r_parent), dcaps);
 	}
 }
 
 void ceph_mdsc_release_dir_caps_no_check(struct ceph_mds_request *req)
 {
+	struct ceph_client *cl = req->r_mdsc->fsc->client;
 	int dcaps;
 
 	dcaps = xchg(&req->r_dir_caps, 0);
 	if (dcaps) {
-		dout("releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
+		doutc(cl, "releasing r_dir_caps=%s\n", ceph_cap_string(dcaps));
 		ceph_put_cap_refs_no_check_caps(ceph_inode(req->r_parent),
 						dcaps);
 	}
@@ -4150,7 +4202,7 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 	struct ceph_mds_request *req, *nreq;
 	struct rb_node *p;
 
-	dout("replay_unsafe_requests mds%d\n", session->s_mds);
+	doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
 
 	mutex_lock(&mdsc->mutex);
 	list_for_each_entry_safe(req, nreq, &session->s_unsafe, r_unsafe_item)
@@ -4295,6 +4347,7 @@ static struct dentry* d_find_primary(struct inode *inode)
 static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	union {
 		struct ceph_mds_cap_reconnect v2;
 		struct ceph_mds_cap_reconnect_v1 v1;
@@ -4331,9 +4384,9 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		err = 0;
 		goto out_err;
 	}
-	dout(" adding %p ino %llx.%llx cap %p %lld %s\n",
-	     inode, ceph_vinop(inode), cap, cap->cap_id,
-	     ceph_cap_string(cap->issued));
+	doutc(cl, " adding %p ino %llx.%llx cap %p %lld %s\n", inode,
+	      ceph_vinop(inode), cap, cap->cap_id,
+	      ceph_cap_string(cap->issued));
 
 	cap->seq = 0;        /* reset cap seq */
 	cap->issue_seq = 0;  /* and issue_seq */
@@ -4483,6 +4536,7 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 {
 	struct rb_node *p;
 	struct ceph_pagelist *pagelist = recon_state->pagelist;
+	struct ceph_client *cl = mdsc->fsc->client;
 	int err = 0;
 
 	if (recon_state->msg_version >= 4) {
@@ -4521,8 +4575,8 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 			ceph_pagelist_encode_32(pagelist, sizeof(sr_rec));
 		}
 
-		dout(" adding snap realm %llx seq %lld parent %llx\n",
-		     realm->ino, realm->seq, realm->parent_ino);
+		doutc(cl, " adding snap realm %llx seq %lld parent %llx\n",
+		      realm->ino, realm->seq, realm->parent_ino);
 		sr_rec.ino = cpu_to_le64(realm->ino);
 		sr_rec.seq = cpu_to_le64(realm->seq);
 		sr_rec.parent = cpu_to_le64(realm->parent_ino);
@@ -4551,6 +4605,7 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_session *session)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *reply;
 	int mds = session->s_mds;
 	int err = -ENOMEM;
@@ -4559,7 +4614,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	};
 	LIST_HEAD(dispose);
 
-	pr_info("mds%d reconnect start\n", mds);
+	pr_info_client(cl, "mds%d reconnect start\n", mds);
 
 	recon_state.pagelist = ceph_pagelist_alloc(GFP_NOFS);
 	if (!recon_state.pagelist)
@@ -4575,8 +4630,8 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
-	dout("session %p state %s\n", session,
-	     ceph_session_state_name(session->s_state));
+	doutc(cl, "session %p state %s\n", session,
+	      ceph_session_state_name(session->s_state));
 
 	atomic_inc(&session->s_cap_gen);
 
@@ -4710,7 +4765,8 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 fail_nomsg:
 	ceph_pagelist_release(recon_state.pagelist);
 fail_nopagelist:
-	pr_err("error %d preparing reconnect for mds%d\n", err, mds);
+	pr_err_client(cl, "error %d preparing reconnect for mds%d\n",
+		      err, mds);
 	return;
 }
 
@@ -4729,9 +4785,9 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 	int oldstate, newstate;
 	struct ceph_mds_session *s;
 	unsigned long targets[DIV_ROUND_UP(CEPH_MAX_MDS, sizeof(unsigned long))] = {0};
+	struct ceph_client *cl = mdsc->fsc->client;
 
-	dout("check_new_map new %u old %u\n",
-	     newmap->m_epoch, oldmap->m_epoch);
+	doutc(cl, "new %u old %u\n", newmap->m_epoch, oldmap->m_epoch);
 
 	if (newmap->m_info) {
 		for (i = 0; i < newmap->possible_max_rank; i++) {
@@ -4747,12 +4803,12 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		oldstate = ceph_mdsmap_get_state(oldmap, i);
 		newstate = ceph_mdsmap_get_state(newmap, i);
 
-		dout("check_new_map mds%d state %s%s -> %s%s (session %s)\n",
-		     i, ceph_mds_state_name(oldstate),
-		     ceph_mdsmap_is_laggy(oldmap, i) ? " (laggy)" : "",
-		     ceph_mds_state_name(newstate),
-		     ceph_mdsmap_is_laggy(newmap, i) ? " (laggy)" : "",
-		     ceph_session_state_name(s->s_state));
+		doutc(cl, "mds%d state %s%s -> %s%s (session %s)\n",
+		      i, ceph_mds_state_name(oldstate),
+		      ceph_mdsmap_is_laggy(oldmap, i) ? " (laggy)" : "",
+		      ceph_mds_state_name(newstate),
+		      ceph_mdsmap_is_laggy(newmap, i) ? " (laggy)" : "",
+		      ceph_session_state_name(s->s_state));
 
 		if (i >= newmap->possible_max_rank) {
 			/* force close session for stopped mds */
@@ -4805,7 +4861,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		    newstate >= CEPH_MDS_STATE_ACTIVE) {
 			if (oldstate != CEPH_MDS_STATE_CREATING &&
 			    oldstate != CEPH_MDS_STATE_STARTING)
-				pr_info("mds%d recovery completed\n", s->s_mds);
+				pr_info_client(cl, "mds%d recovery completed\n",
+					       s->s_mds);
 			kick_requests(mdsc, i);
 			mutex_unlock(&mdsc->mutex);
 			mutex_lock(&s->s_mutex);
@@ -4849,12 +4906,13 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 			s = __open_export_target_session(mdsc, i);
 			if (IS_ERR(s)) {
 				err = PTR_ERR(s);
-				pr_err("failed to open export target session, err %d\n",
-				       err);
+				pr_err_client(cl,
+					      "failed to open export target session, err %d\n",
+					      err);
 				continue;
 			}
 		}
-		dout("send reconnect to export target mds.%d\n", i);
+		doutc(cl, "send reconnect to export target mds.%d\n", i);
 		mutex_unlock(&mdsc->mutex);
 		send_mds_reconnect(mdsc, s);
 		ceph_put_mds_session(s);
@@ -4870,8 +4928,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		if (s->s_state == CEPH_MDS_SESSION_OPEN ||
 		    s->s_state == CEPH_MDS_SESSION_HUNG ||
 		    s->s_state == CEPH_MDS_SESSION_CLOSING) {
-			dout(" connecting to export targets of laggy mds%d\n",
-			     i);
+			doutc(cl, " connecting to export targets of laggy mds%d\n", i);
 			__open_export_target_sessions(mdsc, s);
 		}
 	}
@@ -4898,6 +4955,7 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 			 struct ceph_mds_session *session,
 			 struct ceph_msg *msg)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct super_block *sb = mdsc->fsc->sb;
 	struct inode *inode;
 	struct dentry *parent, *dentry;
@@ -4909,7 +4967,7 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 	struct qstr dname;
 	int release = 0;
 
-	dout("handle_lease from mds%d\n", mds);
+	doutc(cl, "from mds%d\n", mds);
 
 	if (!ceph_inc_mds_stopping_blocker(mdsc, session))
 		return;
@@ -4927,20 +4985,19 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 
 	/* lookup inode */
 	inode = ceph_find_inode(sb, vino);
-	dout("handle_lease %s, ino %llx %p %.*s\n",
-	     ceph_lease_op_name(h->action), vino.ino, inode,
-	     dname.len, dname.name);
+	doutc(cl, "%s, ino %llx %p %.*s\n", ceph_lease_op_name(h->action),
+	      vino.ino, inode, dname.len, dname.name);
 
 	mutex_lock(&session->s_mutex);
 	if (!inode) {
-		dout("handle_lease no inode %llx\n", vino.ino);
+		doutc(cl, "no inode %llx\n", vino.ino);
 		goto release;
 	}
 
 	/* dentry */
 	parent = d_find_alias(inode);
 	if (!parent) {
-		dout("no parent dentry on inode %p\n", inode);
+		doutc(cl, "no parent dentry on inode %p\n", inode);
 		WARN_ON(1);
 		goto release;  /* hrm... */
 	}
@@ -5000,7 +5057,7 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 bad:
 	ceph_dec_mds_stopping_blocker(mdsc);
 
-	pr_err("corrupt lease message\n");
+	pr_err_client(cl, "corrupt lease message\n");
 	ceph_msg_dump(msg);
 }
 
@@ -5008,13 +5065,14 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_session *session,
 			      struct dentry *dentry, char action,
 			      u32 seq)
 {
+	struct ceph_client *cl = session->s_mdsc->fsc->client;
 	struct ceph_msg *msg;
 	struct ceph_mds_lease *lease;
 	struct inode *dir;
 	int len = sizeof(*lease) + sizeof(u32) + NAME_MAX;
 
-	dout("lease_send_msg identry %p %s to mds%d\n",
-	     dentry, ceph_lease_op_name(action), session->s_mds);
+	doutc(cl, "identry %p %s to mds%d\n", dentry, ceph_lease_op_name(action),
+	      session->s_mds);
 
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_LEASE, len, GFP_NOFS, false);
 	if (!msg)
@@ -5047,6 +5105,7 @@ static void lock_unlock_session(struct ceph_mds_session *s)
 
 static void maybe_recover_session(struct ceph_mds_client *mdsc)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_fs_client *fsc = mdsc->fsc;
 
 	if (!ceph_test_mount_opt(fsc, CLEANRECOVER))
@@ -5058,17 +5117,19 @@ static void maybe_recover_session(struct ceph_mds_client *mdsc)
 	if (!READ_ONCE(fsc->blocklisted))
 		return;
 
-	pr_info("auto reconnect after blocklisted\n");
+	pr_info_client(cl, "auto reconnect after blocklisted\n");
 	ceph_force_reconnect(fsc->sb);
 }
 
 bool check_session_state(struct ceph_mds_session *s)
 {
+	struct ceph_client *cl = s->s_mdsc->fsc->client;
+
 	switch (s->s_state) {
 	case CEPH_MDS_SESSION_OPEN:
 		if (s->s_ttl && time_after(jiffies, s->s_ttl)) {
 			s->s_state = CEPH_MDS_SESSION_HUNG;
-			pr_info("mds%d hung\n", s->s_mds);
+			pr_info_client(cl, "mds%d hung\n", s->s_mds);
 		}
 		break;
 	case CEPH_MDS_SESSION_CLOSING:
@@ -5088,6 +5149,8 @@ bool check_session_state(struct ceph_mds_session *s)
  */
 void inc_session_sequence(struct ceph_mds_session *s)
 {
+	struct ceph_client *cl = s->s_mdsc->fsc->client;
+
 	lockdep_assert_held(&s->s_mutex);
 
 	s->s_seq++;
@@ -5095,11 +5158,11 @@ void inc_session_sequence(struct ceph_mds_session *s)
 	if (s->s_state == CEPH_MDS_SESSION_CLOSING) {
 		int ret;
 
-		dout("resending session close request for mds%d\n", s->s_mds);
+		doutc(cl, "resending session close request for mds%d\n", s->s_mds);
 		ret = request_close_session(s);
 		if (ret < 0)
-			pr_err("unable to close session to mds%d: %d\n",
-			       s->s_mds, ret);
+			pr_err_client(cl, "unable to close session to mds%d: %d\n",
+				      s->s_mds, ret);
 	}
 }
 
@@ -5128,7 +5191,7 @@ static void delayed_work(struct work_struct *work)
 	int renew_caps;
 	int i;
 
-	dout("mdsc delayed_work\n");
+	doutc(mdsc->fsc->client, "mdsc delayed_work\n");
 
 	if (mdsc->stopping >= CEPH_MDSC_STOPPING_FLUSHED)
 		return;
@@ -5257,6 +5320,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
  */
 static void wait_requests(struct ceph_mds_client *mdsc)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_options *opts = mdsc->fsc->client->options;
 	struct ceph_mds_request *req;
 
@@ -5264,25 +5328,25 @@ static void wait_requests(struct ceph_mds_client *mdsc)
 	if (__get_oldest_req(mdsc)) {
 		mutex_unlock(&mdsc->mutex);
 
-		dout("wait_requests waiting for requests\n");
+		doutc(cl, "waiting for requests\n");
 		wait_for_completion_timeout(&mdsc->safe_umount_waiters,
 				    ceph_timeout_jiffies(opts->mount_timeout));
 
 		/* tear down remaining requests */
 		mutex_lock(&mdsc->mutex);
 		while ((req = __get_oldest_req(mdsc))) {
-			dout("wait_requests timed out on tid %llu\n",
-			     req->r_tid);
+			doutc(cl, "timed out on tid %llu\n", req->r_tid);
 			list_del_init(&req->r_wait);
 			__unregister_request(mdsc, req);
 		}
 	}
 	mutex_unlock(&mdsc->mutex);
-	dout("wait_requests done\n");
+	doutc(cl, "done\n");
 }
 
 void send_flush_mdlog(struct ceph_mds_session *s)
 {
+	struct ceph_client *cl = s->s_mdsc->fsc->client;
 	struct ceph_msg *msg;
 
 	/*
@@ -5292,13 +5356,13 @@ void send_flush_mdlog(struct ceph_mds_session *s)
 		return;
 
 	mutex_lock(&s->s_mutex);
-	dout("request mdlog flush to mds%d (%s)s seq %lld\n", s->s_mds,
-	     ceph_session_state_name(s->s_state), s->s_seq);
+	doutc(cl, "request mdlog flush to mds%d (%s)s seq %lld\n",
+	      s->s_mds, ceph_session_state_name(s->s_state), s->s_seq);
 	msg = ceph_create_session_msg(CEPH_SESSION_REQUEST_FLUSH_MDLOG,
 				      s->s_seq);
 	if (!msg) {
-		pr_err("failed to request mdlog flush to mds%d (%s) seq %lld\n",
-		       s->s_mds, ceph_session_state_name(s->s_state), s->s_seq);
+		pr_err_client(cl, "failed to request mdlog flush to mds%d (%s) seq %lld\n",
+			      s->s_mds, ceph_session_state_name(s->s_state), s->s_seq);
 	} else {
 		ceph_con_send(&s->s_con, msg);
 	}
@@ -5311,7 +5375,7 @@ void send_flush_mdlog(struct ceph_mds_session *s)
  */
 void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 {
-	dout("pre_umount\n");
+	doutc(mdsc->fsc->client, "begin\n");
 	mdsc->stopping = CEPH_MDSC_STOPPING_BEGIN;
 
 	ceph_mdsc_iterate_sessions(mdsc, send_flush_mdlog, true);
@@ -5326,6 +5390,7 @@ void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 	ceph_msgr_flush();
 
 	ceph_cleanup_quotarealms_inodes(mdsc);
+	doutc(mdsc->fsc->client, "done\n");
 }
 
 /*
@@ -5334,12 +5399,13 @@ void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *mdsc,
 						 u64 want_tid)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req = NULL, *nextreq;
 	struct ceph_mds_session *last_session = NULL;
 	struct rb_node *n;
 
 	mutex_lock(&mdsc->mutex);
-	dout("%s want %lld\n", __func__, want_tid);
+	doutc(cl, "want %lld\n", want_tid);
 restart:
 	req = __get_oldest_req(mdsc);
 	while (req && req->r_tid <= want_tid) {
@@ -5373,8 +5439,8 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 			} else {
 				ceph_put_mds_session(s);
 			}
-			dout("%s wait on %llu (want %llu)\n", __func__,
-			     req->r_tid, want_tid);
+			doutc(cl, "wait on %llu (want %llu)\n",
+			      req->r_tid, want_tid);
 			wait_for_completion(&req->r_safe_completion);
 
 			mutex_lock(&mdsc->mutex);
@@ -5392,17 +5458,18 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 	}
 	mutex_unlock(&mdsc->mutex);
 	ceph_put_mds_session(last_session);
-	dout("%s done\n", __func__);
+	doutc(cl, "done\n");
 }
 
 void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	u64 want_tid, want_flush;
 
 	if (READ_ONCE(mdsc->fsc->mount_state) >= CEPH_MOUNT_SHUTDOWN)
 		return;
 
-	dout("sync\n");
+	doutc(cl, "sync\n");
 	mutex_lock(&mdsc->mutex);
 	want_tid = mdsc->last_tid;
 	mutex_unlock(&mdsc->mutex);
@@ -5418,8 +5485,7 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 	}
 	spin_unlock(&mdsc->cap_dirty_lock);
 
-	dout("sync want tid %lld flush_seq %lld\n",
-	     want_tid, want_flush);
+	doutc(cl, "sync want tid %lld flush_seq %lld\n", want_tid, want_flush);
 
 	flush_mdlog_and_wait_mdsc_unsafe_requests(mdsc, want_tid);
 	wait_caps_flush(mdsc, want_flush);
@@ -5441,11 +5507,12 @@ static bool done_closing_sessions(struct ceph_mds_client *mdsc, int skipped)
 void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 {
 	struct ceph_options *opts = mdsc->fsc->client->options;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_session *session;
 	int i;
 	int skipped = 0;
 
-	dout("close_sessions\n");
+	doutc(cl, "begin\n");
 
 	/* close sessions */
 	mutex_lock(&mdsc->mutex);
@@ -5463,7 +5530,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	}
 	mutex_unlock(&mdsc->mutex);
 
-	dout("waiting for sessions to close\n");
+	doutc(cl, "waiting for sessions to close\n");
 	wait_event_timeout(mdsc->session_close_wq,
 			   done_closing_sessions(mdsc, skipped),
 			   ceph_timeout_jiffies(opts->mount_timeout));
@@ -5491,7 +5558,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	cancel_work_sync(&mdsc->cap_reclaim_work);
 	cancel_delayed_work_sync(&mdsc->delayed_work); /* cancel timer */
 
-	dout("stopped\n");
+	doutc(cl, "done\n");
 }
 
 void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
@@ -5499,7 +5566,7 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
 	struct ceph_mds_session *session;
 	int mds;
 
-	dout("force umount\n");
+	doutc(mdsc->fsc->client, "force umount\n");
 
 	mutex_lock(&mdsc->mutex);
 	for (mds = 0; mds < mdsc->max_sessions; mds++) {
@@ -5530,7 +5597,7 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
 
 static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 {
-	dout("stop\n");
+	doutc(mdsc->fsc->client, "stop\n");
 	/*
 	 * Make sure the delayed work stopped before releasing
 	 * the resources.
@@ -5551,7 +5618,7 @@ static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 {
 	struct ceph_mds_client *mdsc = fsc->mdsc;
-	dout("mdsc_destroy %p\n", mdsc);
+	doutc(fsc->client, "%p\n", mdsc);
 
 	if (!mdsc)
 		return;
@@ -5565,12 +5632,13 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 
 	fsc->mdsc = NULL;
 	kfree(mdsc);
-	dout("mdsc_destroy %p done\n", mdsc);
+	doutc(fsc->client, "%p done\n", mdsc);
 }
 
 void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 {
 	struct ceph_fs_client *fsc = mdsc->fsc;
+	struct ceph_client *cl = fsc->client;
 	const char *mds_namespace = fsc->mount_options->mds_namespace;
 	void *p = msg->front.iov_base;
 	void *end = p + msg->front.iov_len;
@@ -5582,7 +5650,7 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	ceph_decode_need(&p, end, sizeof(u32), bad);
 	epoch = ceph_decode_32(&p);
 
-	dout("handle_fsmap epoch %u\n", epoch);
+	doutc(cl, "epoch %u\n", epoch);
 
 	/* struct_v, struct_cv, map_len, epoch, legacy_client_fscid */
 	ceph_decode_skip_n(&p, end, 2 + sizeof(u32) * 3, bad);
@@ -5627,7 +5695,8 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	return;
 
 bad:
-	pr_err("error decoding fsmap %d. Shutting down mount.\n", err);
+	pr_err_client(cl, "error decoding fsmap %d. Shutting down mount.\n",
+		      err);
 	ceph_umount_begin(mdsc->fsc->sb);
 	ceph_msg_dump(msg);
 err_out:
@@ -5642,6 +5711,7 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
  */
 void ceph_mdsc_handle_mdsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	u32 epoch;
 	u32 maplen;
 	void *p = msg->front.iov_base;
@@ -5656,13 +5726,12 @@ void ceph_mdsc_handle_mdsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 		return;
 	epoch = ceph_decode_32(&p);
 	maplen = ceph_decode_32(&p);
-	dout("handle_map epoch %u len %d\n", epoch, (int)maplen);
+	doutc(cl, "epoch %u len %d\n", epoch, (int)maplen);
 
 	/* do we need it? */
 	mutex_lock(&mdsc->mutex);
 	if (mdsc->mdsmap && epoch <= mdsc->mdsmap->m_epoch) {
-		dout("handle_map epoch %u <= our %u\n",
-		     epoch, mdsc->mdsmap->m_epoch);
+		doutc(cl, "epoch %u <= our %u\n", epoch, mdsc->mdsmap->m_epoch);
 		mutex_unlock(&mdsc->mutex);
 		return;
 	}
@@ -5696,7 +5765,8 @@ void ceph_mdsc_handle_mdsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 bad_unlock:
 	mutex_unlock(&mdsc->mutex);
 bad:
-	pr_err("error decoding mdsmap %d. Shutting down mount.\n", err);
+	pr_err_client(cl, "error decoding mdsmap %d. Shutting down mount.\n",
+		      err);
 	ceph_umount_begin(mdsc->fsc->sb);
 	ceph_msg_dump(msg);
 	return;
@@ -5727,7 +5797,8 @@ static void mds_peer_reset(struct ceph_connection *con)
 	struct ceph_mds_session *s = con->private;
 	struct ceph_mds_client *mdsc = s->s_mdsc;
 
-	pr_warn("mds%d closed our session\n", s->s_mds);
+	pr_warn_client(mdsc->fsc->client, "mds%d closed our session\n",
+		       s->s_mds);
 	if (READ_ONCE(mdsc->fsc->mount_state) != CEPH_MOUNT_FENCE_IO)
 		send_mds_reconnect(mdsc, s);
 }
@@ -5736,6 +5807,7 @@ static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 {
 	struct ceph_mds_session *s = con->private;
 	struct ceph_mds_client *mdsc = s->s_mdsc;
+	struct ceph_client *cl = mdsc->fsc->client;
 	int type = le16_to_cpu(msg->hdr.type);
 
 	mutex_lock(&mdsc->mutex);
@@ -5775,8 +5847,8 @@ static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 		break;
 
 	default:
-		pr_err("received unknown message type %d %s\n", type,
-		       ceph_msg_type_name(type));
+		pr_err_client(cl, "received unknown message type %d %s\n",
+			      type, ceph_msg_type_name(type));
 	}
 out:
 	ceph_msg_put(msg);
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 66afb18df76b..a476d5e6d39f 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -11,6 +11,7 @@
 #include <linux/ceph/messenger.h>
 #include <linux/ceph/decode.h>
 
+#include "mds_client.h"
 #include "super.h"
 
 #define CEPH_MDS_IS_READY(i, ignore_laggy) \
@@ -117,6 +118,7 @@ static int __decode_and_drop_compat_set(void **p, void* end)
 struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 				       void *end, bool msgr2)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mdsmap *m;
 	const void *start = *p;
 	int i, j, n;
@@ -234,20 +236,18 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 			*p = info_end;
 		}
 
-		dout("mdsmap_decode %d/%d %lld mds%d.%d %s %s%s\n",
-		     i+1, n, global_id, mds, inc,
-		     ceph_pr_addr(&addr),
-		     ceph_mds_state_name(state),
-		     laggy ? "(laggy)" : "");
+		doutc(cl, "%d/%d %lld mds%d.%d %s %s%s\n", i+1, n, global_id,
+		      mds, inc, ceph_pr_addr(&addr),
+		      ceph_mds_state_name(state), laggy ? "(laggy)" : "");
 
 		if (mds < 0 || mds >= m->possible_max_rank) {
-			pr_warn("mdsmap_decode got incorrect mds(%d)\n", mds);
+			pr_warn_client(cl, "got incorrect mds(%d)\n", mds);
 			continue;
 		}
 
 		if (state <= 0) {
-			dout("mdsmap_decode got incorrect state(%s)\n",
-			     ceph_mds_state_name(state));
+			doutc(cl, "got incorrect state(%s)\n",
+			      ceph_mds_state_name(state));
 			continue;
 		}
 
@@ -387,16 +387,16 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
 	}
 bad_ext:
-	dout("mdsmap_decode m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
-	     !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
+	doutc(cl, "m_enabled: %d, m_damaged: %d, m_num_laggy: %d\n",
+	      !!m->m_enabled, !!m->m_damaged, m->m_num_laggy);
 	*p = end;
-	dout("mdsmap_decode success epoch %u\n", m->m_epoch);
+	doutc(cl, "success epoch %u\n", m->m_epoch);
 	return m;
 nomem:
 	err = -ENOMEM;
 	goto out_err;
 corrupt:
-	pr_err("corrupt mdsmap\n");
+	pr_err_client(cl, "corrupt mdsmap\n");
 	print_hex_dump(KERN_DEBUG, "mdsmap: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
 		       start, end - start, true);
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index 6d3584f16f9a..871c1090e520 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -31,6 +31,7 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 	struct ceph_client_metric *m = &mdsc->metric;
 	u64 nr_caps = atomic64_read(&m->total_caps);
 	u32 header_len = sizeof(struct ceph_metric_header);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *msg;
 	s64 sum;
 	s32 items = 0;
@@ -51,8 +52,8 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_METRICS, len, GFP_NOFS, true);
 	if (!msg) {
-		pr_err("send metrics to mds%d, failed to allocate message\n",
-		       s->s_mds);
+		pr_err_client(cl, "to mds%d, failed to allocate message\n",
+			      s->s_mds);
 		return false;
 	}
 
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index ca4932e6f71b..06ee397e0c3a 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -43,6 +43,7 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
 {
 	struct super_block *sb = mdsc->fsc->sb;
 	struct ceph_mds_quota *h = msg->front.iov_base;
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_vino vino;
 	struct inode *inode;
 	struct ceph_inode_info *ci;
@@ -51,8 +52,8 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
 		return;
 
 	if (msg->front.iov_len < sizeof(*h)) {
-		pr_err("%s corrupt message mds%d len %d\n", __func__,
-		       session->s_mds, (int)msg->front.iov_len);
+		pr_err_client(cl, "corrupt message mds%d len %d\n",
+			      session->s_mds, (int)msg->front.iov_len);
 		ceph_msg_dump(msg);
 		goto out;
 	}
@@ -62,7 +63,7 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
 	vino.snap = CEPH_NOSNAP;
 	inode = ceph_find_inode(sb, vino);
 	if (!inode) {
-		pr_warn("Failed to find inode %llu\n", vino.ino);
+		pr_warn_client(cl, "failed to find inode %llx\n", vino.ino);
 		goto out;
 	}
 	ci = ceph_inode(inode);
@@ -85,6 +86,7 @@ find_quotarealm_inode(struct ceph_mds_client *mdsc, u64 ino)
 {
 	struct ceph_quotarealm_inode *qri = NULL;
 	struct rb_node **node, *parent = NULL;
+	struct ceph_client *cl = mdsc->fsc->client;
 
 	mutex_lock(&mdsc->quotarealms_inodes_mutex);
 	node = &(mdsc->quotarealms_inodes.rb_node);
@@ -110,7 +112,7 @@ find_quotarealm_inode(struct ceph_mds_client *mdsc, u64 ino)
 			rb_link_node(&qri->node, parent, node);
 			rb_insert_color(&qri->node, &mdsc->quotarealms_inodes);
 		} else
-			pr_warn("Failed to alloc quotarealms_inode\n");
+			pr_warn_client(cl, "Failed to alloc quotarealms_inode\n");
 	}
 	mutex_unlock(&mdsc->quotarealms_inodes_mutex);
 
@@ -129,6 +131,7 @@ static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mdsc,
 					     struct super_block *sb,
 					     struct ceph_snap_realm *realm)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_quotarealm_inode *qri;
 	struct inode *in;
 
@@ -161,8 +164,8 @@ static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mdsc,
 	}
 
 	if (IS_ERR(in)) {
-		dout("Can't lookup inode %llx (err: %ld)\n",
-		     realm->ino, PTR_ERR(in));
+		doutc(cl, "Can't lookup inode %llx (err: %ld)\n", realm->ino,
+		      PTR_ERR(in));
 		qri->timeout = jiffies + msecs_to_jiffies(60 * 1000); /* XXX */
 	} else {
 		qri->timeout = 0;
@@ -212,6 +215,7 @@ static int get_quota_realm(struct ceph_mds_client *mdsc, struct inode *inode,
 			   enum quota_get_realm which_quota,
 			   struct ceph_snap_realm **realmp, bool retry)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci = NULL;
 	struct ceph_snap_realm *realm, *next;
 	struct inode *in;
@@ -227,8 +231,9 @@ static int get_quota_realm(struct ceph_mds_client *mdsc, struct inode *inode,
 	if (realm)
 		ceph_get_snap_realm(mdsc, realm);
 	else
-		pr_err_ratelimited("get_quota_realm: ino (%llx.%llx) "
-				   "null i_snap_realm\n", ceph_vinop(inode));
+		pr_err_ratelimited_client(cl,
+				"%p %llx.%llx null i_snap_realm\n",
+				inode, ceph_vinop(inode));
 	while (realm) {
 		bool has_inode;
 
@@ -322,6 +327,7 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 				 loff_t delta)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci;
 	struct ceph_snap_realm *realm, *next;
 	struct inode *in;
@@ -337,8 +343,9 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 	if (realm)
 		ceph_get_snap_realm(mdsc, realm);
 	else
-		pr_err_ratelimited("check_quota_exceeded: ino (%llx.%llx) "
-				   "null i_snap_realm\n", ceph_vinop(inode));
+		pr_err_ratelimited_client(cl,
+				"%p %llx.%llx null i_snap_realm\n",
+				inode, ceph_vinop(inode));
 	while (realm) {
 		bool has_inode;
 
@@ -388,7 +395,7 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 			break;
 		default:
 			/* Shouldn't happen */
-			pr_warn("Invalid quota check op (%d)\n", op);
+			pr_warn_client(cl, "Invalid quota check op (%d)\n", op);
 			exceeded = true; /* Just break the loop */
 		}
 		iput(in);
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index d0d3612f28f0..73c526954749 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -138,7 +138,7 @@ static struct ceph_snap_realm *ceph_create_snap_realm(
 	__insert_snap_realm(&mdsc->snap_realms, realm);
 	mdsc->num_snap_realms++;
 
-	dout("%s %llx %p\n", __func__, realm->ino, realm);
+	doutc(mdsc->fsc->client, "%llx %p\n", realm->ino, realm);
 	return realm;
 }
 
@@ -150,6 +150,7 @@ static struct ceph_snap_realm *ceph_create_snap_realm(
 static struct ceph_snap_realm *__lookup_snap_realm(struct ceph_mds_client *mdsc,
 						   u64 ino)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct rb_node *n = mdsc->snap_realms.rb_node;
 	struct ceph_snap_realm *r;
 
@@ -162,7 +163,7 @@ static struct ceph_snap_realm *__lookup_snap_realm(struct ceph_mds_client *mdsc,
 		else if (ino > r->ino)
 			n = n->rb_right;
 		else {
-			dout("%s %llx %p\n", __func__, r->ino, r);
+			doutc(cl, "%llx %p\n", r->ino, r);
 			return r;
 		}
 	}
@@ -188,9 +189,10 @@ static void __put_snap_realm(struct ceph_mds_client *mdsc,
 static void __destroy_snap_realm(struct ceph_mds_client *mdsc,
 				 struct ceph_snap_realm *realm)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	lockdep_assert_held_write(&mdsc->snap_rwsem);
 
-	dout("%s %p %llx\n", __func__, realm, realm->ino);
+	doutc(cl, "%p %llx\n", realm, realm->ino);
 
 	rb_erase(&realm->node, &mdsc->snap_realms);
 	mdsc->num_snap_realms--;
@@ -290,6 +292,7 @@ static int adjust_snap_realm_parent(struct ceph_mds_client *mdsc,
 				    struct ceph_snap_realm *realm,
 				    u64 parentino)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_snap_realm *parent;
 
 	lockdep_assert_held_write(&mdsc->snap_rwsem);
@@ -303,8 +306,8 @@ static int adjust_snap_realm_parent(struct ceph_mds_client *mdsc,
 		if (IS_ERR(parent))
 			return PTR_ERR(parent);
 	}
-	dout("%s %llx %p: %llx %p -> %llx %p\n", __func__, realm->ino,
-	     realm, realm->parent_ino, realm->parent, parentino, parent);
+	doutc(cl, "%llx %p: %llx %p -> %llx %p\n", realm->ino, realm,
+	      realm->parent_ino, realm->parent, parentino, parent);
 	if (realm->parent) {
 		list_del_init(&realm->child_item);
 		ceph_put_snap_realm(mdsc, realm->parent);
@@ -334,6 +337,7 @@ static int build_snap_context(struct ceph_mds_client *mdsc,
 			      struct list_head *realm_queue,
 			      struct list_head *dirty_realms)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_snap_realm *parent = realm->parent;
 	struct ceph_snap_context *snapc;
 	int err = 0;
@@ -361,10 +365,10 @@ static int build_snap_context(struct ceph_mds_client *mdsc,
 	    realm->cached_context->seq == realm->seq &&
 	    (!parent ||
 	     realm->cached_context->seq >= parent->cached_context->seq)) {
-		dout("%s %llx %p: %p seq %lld (%u snaps) (unchanged)\n",
-		     __func__, realm->ino, realm, realm->cached_context,
-		     realm->cached_context->seq,
-		     (unsigned int)realm->cached_context->num_snaps);
+		doutc(cl, "%llx %p: %p seq %lld (%u snaps) (unchanged)\n",
+		      realm->ino, realm, realm->cached_context,
+		      realm->cached_context->seq,
+		      (unsigned int)realm->cached_context->num_snaps);
 		return 0;
 	}
 
@@ -401,8 +405,8 @@ static int build_snap_context(struct ceph_mds_client *mdsc,
 
 	sort(snapc->snaps, num, sizeof(u64), cmpu64_rev, NULL);
 	snapc->num_snaps = num;
-	dout("%s %llx %p: %p seq %lld (%u snaps)\n", __func__, realm->ino,
-	     realm, snapc, snapc->seq, (unsigned int) snapc->num_snaps);
+	doutc(cl, "%llx %p: %p seq %lld (%u snaps)\n", realm->ino, realm,
+	      snapc, snapc->seq, (unsigned int) snapc->num_snaps);
 
 	ceph_put_snap_context(realm->cached_context);
 	realm->cached_context = snapc;
@@ -419,7 +423,7 @@ static int build_snap_context(struct ceph_mds_client *mdsc,
 		ceph_put_snap_context(realm->cached_context);
 		realm->cached_context = NULL;
 	}
-	pr_err("%s %llx %p fail %d\n", __func__, realm->ino, realm, err);
+	pr_err_client(cl, "%llx %p fail %d\n", realm->ino, realm, err);
 	return err;
 }
 
@@ -430,6 +434,7 @@ static void rebuild_snap_realms(struct ceph_mds_client *mdsc,
 				struct ceph_snap_realm *realm,
 				struct list_head *dirty_realms)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	LIST_HEAD(realm_queue);
 	int last = 0;
 	bool skip = false;
@@ -455,8 +460,8 @@ static void rebuild_snap_realms(struct ceph_mds_client *mdsc,
 
 		last = build_snap_context(mdsc, _realm, &realm_queue,
 					  dirty_realms);
-		dout("%s %llx %p, %s\n", __func__, _realm->ino, _realm,
-		     last > 0 ? "is deferred" : !last ? "succeeded" : "failed");
+		doutc(cl, "%llx %p, %s\n", realm->ino, realm,
+		      last > 0 ? "is deferred" : !last ? "succeeded" : "failed");
 
 		/* is any child in the list ? */
 		list_for_each_entry(child, &_realm->children, child_item) {
@@ -526,6 +531,7 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
 				struct ceph_cap_snap **pcapsnap)
 {
 	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_snap_context *old_snapc, *new_snapc;
 	struct ceph_cap_snap *capsnap = *pcapsnap;
 	struct ceph_buffer *old_blob = NULL;
@@ -551,14 +557,14 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
 		   as no new writes are allowed to start when pending, so any
 		   writes in progress now were started before the previous
 		   cap_snap.  lucky us. */
-		dout("%s %p %llx.%llx already pending\n",
-		     __func__, inode, ceph_vinop(inode));
+		doutc(cl, "%p %llx.%llx already pending\n", inode,
+		      ceph_vinop(inode));
 		goto update_snapc;
 	}
 	if (ci->i_wrbuffer_ref_head == 0 &&
 	    !(dirty & (CEPH_CAP_ANY_EXCL|CEPH_CAP_FILE_WR))) {
-		dout("%s %p %llx.%llx nothing dirty|writing\n",
-		     __func__, inode, ceph_vinop(inode));
+		doutc(cl, "%p %llx.%llx nothing dirty|writing\n", inode,
+		      ceph_vinop(inode));
 		goto update_snapc;
 	}
 
@@ -578,15 +584,15 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
 	} else {
 		if (!(used & CEPH_CAP_FILE_WR) &&
 		    ci->i_wrbuffer_ref_head == 0) {
-			dout("%s %p %llx.%llx no new_snap|dirty_page|writing\n",
-			     __func__, inode, ceph_vinop(inode));
+			doutc(cl, "%p %llx.%llx no new_snap|dirty_page|writing\n",
+			      inode, ceph_vinop(inode));
 			goto update_snapc;
 		}
 	}
 
-	dout("%s %p %llx.%llx cap_snap %p queuing under %p %s %s\n",
-	     __func__, inode, ceph_vinop(inode), capsnap, old_snapc,
-	     ceph_cap_string(dirty), capsnap->need_flush ? "" : "no_flush");
+	doutc(cl, "%p %llx.%llx cap_snap %p queuing under %p %s %s\n",
+	      inode, ceph_vinop(inode), capsnap, old_snapc,
+	      ceph_cap_string(dirty), capsnap->need_flush ? "" : "no_flush");
 	ihold(inode);
 
 	capsnap->follows = old_snapc->seq;
@@ -618,9 +624,9 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
 	list_add_tail(&capsnap->ci_item, &ci->i_cap_snaps);
 
 	if (used & CEPH_CAP_FILE_WR) {
-		dout("%s %p %llx.%llx cap_snap %p snapc %p seq %llu used WR,"
-		     " now pending\n", __func__, inode, ceph_vinop(inode),
-		     capsnap, old_snapc, old_snapc->seq);
+		doutc(cl, "%p %llx.%llx cap_snap %p snapc %p seq %llu used WR,"
+		      " now pending\n", inode, ceph_vinop(inode), capsnap,
+		      old_snapc, old_snapc->seq);
 		capsnap->writing = 1;
 	} else {
 		/* note mtime, size NOW. */
@@ -637,7 +643,7 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
 		ci->i_head_snapc = NULL;
 	} else {
 		ci->i_head_snapc = ceph_get_snap_context(new_snapc);
-		dout(" new snapc is %p\n", new_snapc);
+		doutc(cl, " new snapc is %p\n", new_snapc);
 	}
 	spin_unlock(&ci->i_ceph_lock);
 
@@ -658,6 +664,7 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 {
 	struct inode *inode = &ci->netfs.inode;
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 
 	BUG_ON(capsnap->writing);
 	capsnap->size = i_size_read(inode);
@@ -670,11 +677,12 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 	capsnap->truncate_size = ci->i_truncate_size;
 	capsnap->truncate_seq = ci->i_truncate_seq;
 	if (capsnap->dirty_pages) {
-		dout("%s %p %llx.%llx cap_snap %p snapc %p %llu %s s=%llu "
-		     "still has %d dirty pages\n", __func__, inode,
-		     ceph_vinop(inode), capsnap, capsnap->context,
-		     capsnap->context->seq, ceph_cap_string(capsnap->dirty),
-		     capsnap->size, capsnap->dirty_pages);
+		doutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s "
+		      "s=%llu still has %d dirty pages\n", inode,
+		      ceph_vinop(inode), capsnap, capsnap->context,
+		      capsnap->context->seq,
+		      ceph_cap_string(capsnap->dirty),
+		      capsnap->size, capsnap->dirty_pages);
 		return 0;
 	}
 
@@ -683,20 +691,20 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 	 * And trigger to flush the buffer immediately.
 	 */
 	if (ci->i_wrbuffer_ref) {
-		dout("%s %p %llx.%llx cap_snap %p snapc %p %llu %s s=%llu "
-		     "used WRBUFFER, delaying\n", __func__, inode,
-		     ceph_vinop(inode), capsnap, capsnap->context,
-		     capsnap->context->seq, ceph_cap_string(capsnap->dirty),
-		     capsnap->size);
+		doutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s "
+		      "s=%llu used WRBUFFER, delaying\n", inode,
+		      ceph_vinop(inode), capsnap, capsnap->context,
+		      capsnap->context->seq, ceph_cap_string(capsnap->dirty),
+		      capsnap->size);
 		ceph_queue_writeback(inode);
 		return 0;
 	}
 
 	ci->i_ceph_flags |= CEPH_I_FLUSH_SNAPS;
-	dout("%s %p %llx.%llx cap_snap %p snapc %p %llu %s s=%llu\n",
-	     __func__, inode, ceph_vinop(inode), capsnap, capsnap->context,
-	     capsnap->context->seq, ceph_cap_string(capsnap->dirty),
-	     capsnap->size);
+	doutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s s=%llu\n",
+	      inode, ceph_vinop(inode), capsnap, capsnap->context,
+	      capsnap->context->seq, ceph_cap_string(capsnap->dirty),
+	      capsnap->size);
 
 	spin_lock(&mdsc->snap_flush_lock);
 	if (list_empty(&ci->i_snap_flush_item)) {
@@ -714,11 +722,12 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 static void queue_realm_cap_snaps(struct ceph_mds_client *mdsc,
 				  struct ceph_snap_realm *realm)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci;
 	struct inode *lastinode = NULL;
 	struct ceph_cap_snap *capsnap = NULL;
 
-	dout("%s %p %llx inode\n", __func__, realm, realm->ino);
+	doutc(cl, "%p %llx inode\n", realm, realm->ino);
 
 	spin_lock(&realm->inodes_with_caps_lock);
 	list_for_each_entry(ci, &realm->inodes_with_caps, i_snap_realm_item) {
@@ -737,8 +746,9 @@ static void queue_realm_cap_snaps(struct ceph_mds_client *mdsc,
 		if (!capsnap) {
 			capsnap = kmem_cache_zalloc(ceph_cap_snap_cachep, GFP_NOFS);
 			if (!capsnap) {
-				pr_err("ENOMEM allocating ceph_cap_snap on %p\n",
-				       inode);
+				pr_err_client(cl,
+					"ENOMEM allocating ceph_cap_snap on %p\n",
+					inode);
 				return;
 			}
 		}
@@ -756,7 +766,7 @@ static void queue_realm_cap_snaps(struct ceph_mds_client *mdsc,
 
 	if (capsnap)
 		kmem_cache_free(ceph_cap_snap_cachep, capsnap);
-	dout("%s %p %llx done\n", __func__, realm, realm->ino);
+	doutc(cl, "%p %llx done\n", realm, realm->ino);
 }
 
 /*
@@ -770,6 +780,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 			   void *p, void *e, bool deletion,
 			   struct ceph_snap_realm **realm_ret)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_snap_realm *ri;    /* encoded */
 	__le64 *snaps;                     /* encoded */
 	__le64 *prior_parent_snaps;        /* encoded */
@@ -784,7 +795,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 
 	lockdep_assert_held_write(&mdsc->snap_rwsem);
 
-	dout("%s deletion=%d\n", __func__, deletion);
+	doutc(cl, "deletion=%d\n", deletion);
 more:
 	realm = NULL;
 	rebuild_snapcs = 0;
@@ -814,8 +825,8 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 	rebuild_snapcs += err;
 
 	if (le64_to_cpu(ri->seq) > realm->seq) {
-		dout("%s updating %llx %p %lld -> %lld\n", __func__,
-		     realm->ino, realm, realm->seq, le64_to_cpu(ri->seq));
+		doutc(cl, "updating %llx %p %lld -> %lld\n", realm->ino,
+		      realm, realm->seq, le64_to_cpu(ri->seq));
 		/* update realm parameters, snap lists */
 		realm->seq = le64_to_cpu(ri->seq);
 		realm->created = le64_to_cpu(ri->created);
@@ -838,16 +849,16 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 
 		rebuild_snapcs = 1;
 	} else if (!realm->cached_context) {
-		dout("%s %llx %p seq %lld new\n", __func__,
-		     realm->ino, realm, realm->seq);
+		doutc(cl, "%llx %p seq %lld new\n", realm->ino, realm,
+		      realm->seq);
 		rebuild_snapcs = 1;
 	} else {
-		dout("%s %llx %p seq %lld unchanged\n", __func__,
-		     realm->ino, realm, realm->seq);
+		doutc(cl, "%llx %p seq %lld unchanged\n", realm->ino, realm,
+		      realm->seq);
 	}
 
-	dout("done with %llx %p, rebuild_snapcs=%d, %p %p\n", realm->ino,
-	     realm, rebuild_snapcs, p, e);
+	doutc(cl, "done with %llx %p, rebuild_snapcs=%d, %p %p\n", realm->ino,
+	      realm, rebuild_snapcs, p, e);
 
 	/*
 	 * this will always track the uppest parent realm from which
@@ -895,7 +906,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 		ceph_put_snap_realm(mdsc, realm);
 	if (first_realm)
 		ceph_put_snap_realm(mdsc, first_realm);
-	pr_err("%s error %d\n", __func__, err);
+	pr_err_client(cl, "error %d\n", err);
 
 	/*
 	 * When receiving a corrupted snap trace we don't know what
@@ -909,11 +920,12 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 	WRITE_ONCE(mdsc->fsc->mount_state, CEPH_MOUNT_FENCE_IO);
 	ret = ceph_monc_blocklist_add(&client->monc, &client->msgr.inst.addr);
 	if (ret)
-		pr_err("%s failed to blocklist %s: %d\n", __func__,
-		       ceph_pr_addr(&client->msgr.inst.addr), ret);
+		pr_err_client(cl, "failed to blocklist %s: %d\n",
+			      ceph_pr_addr(&client->msgr.inst.addr), ret);
 
-	WARN(1, "%s: %s%sdo remount to continue%s",
-	     __func__, ret ? "" : ceph_pr_addr(&client->msgr.inst.addr),
+	WARN(1, "[client.%lld] %s %s%sdo remount to continue%s",
+	     client->monc.auth->global_id, __func__,
+	     ret ? "" : ceph_pr_addr(&client->msgr.inst.addr),
 	     ret ? "" : " was blocklisted, ",
 	     err == -EIO ? " after corrupted snaptrace is fixed" : "");
 
@@ -929,11 +941,12 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
  */
 static void flush_snaps(struct ceph_mds_client *mdsc)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci;
 	struct inode *inode;
 	struct ceph_mds_session *session = NULL;
 
-	dout("%s\n", __func__);
+	doutc(cl, "begin\n");
 	spin_lock(&mdsc->snap_flush_lock);
 	while (!list_empty(&mdsc->snap_flush_list)) {
 		ci = list_first_entry(&mdsc->snap_flush_list,
@@ -948,7 +961,7 @@ static void flush_snaps(struct ceph_mds_client *mdsc)
 	spin_unlock(&mdsc->snap_flush_lock);
 
 	ceph_put_mds_session(session);
-	dout("%s done\n", __func__);
+	doutc(cl, "done\n");
 }
 
 /**
@@ -1004,6 +1017,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 		      struct ceph_mds_session *session,
 		      struct ceph_msg *msg)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct super_block *sb = mdsc->fsc->sb;
 	int mds = session->s_mds;
 	u64 split;
@@ -1034,8 +1048,8 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	trace_len = le32_to_cpu(h->trace_len);
 	p += sizeof(*h);
 
-	dout("%s from mds%d op %s split %llx tracelen %d\n", __func__,
-	     mds, ceph_snap_op_name(op), split, trace_len);
+	doutc(cl, "from mds%d op %s split %llx tracelen %d\n", mds,
+	      ceph_snap_op_name(op), split, trace_len);
 
 	down_write(&mdsc->snap_rwsem);
 	locked_rwsem = 1;
@@ -1066,7 +1080,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 				goto out;
 		}
 
-		dout("splitting snap_realm %llx %p\n", realm->ino, realm);
+		doutc(cl, "splitting snap_realm %llx %p\n", realm->ino, realm);
 		for (i = 0; i < num_split_inos; i++) {
 			struct ceph_vino vino = {
 				.ino = le64_to_cpu(split_inos[i]),
@@ -1091,13 +1105,13 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 			 */
 			if (ci->i_snap_realm->created >
 			    le64_to_cpu(ri->created)) {
-				dout(" leaving %p %llx.%llx in newer realm %llx %p\n",
-				     inode, ceph_vinop(inode), ci->i_snap_realm->ino,
-				     ci->i_snap_realm);
+				doutc(cl, " leaving %p %llx.%llx in newer realm %llx %p\n",
+				      inode, ceph_vinop(inode), ci->i_snap_realm->ino,
+				      ci->i_snap_realm);
 				goto skip_inode;
 			}
-			dout(" will move %p %llx.%llx to split realm %llx %p\n",
-			     inode, ceph_vinop(inode), realm->ino, realm);
+			doutc(cl, " will move %p %llx.%llx to split realm %llx %p\n",
+			      inode, ceph_vinop(inode), realm->ino, realm);
 
 			ceph_get_snap_realm(mdsc, realm);
 			ceph_change_snap_realm(inode, realm);
@@ -1158,7 +1172,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	return;
 
 bad:
-	pr_err("%s corrupt snap message from mds%d\n", __func__, mds);
+	pr_err_client(cl, "corrupt snap message from mds%d\n", mds);
 	ceph_msg_dump(msg);
 out:
 	if (locked_rwsem)
@@ -1174,6 +1188,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 struct ceph_snapid_map* ceph_get_snapid_map(struct ceph_mds_client *mdsc,
 					    u64 snap)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_snapid_map *sm, *exist;
 	struct rb_node **p, *parent;
 	int ret;
@@ -1196,8 +1211,8 @@ struct ceph_snapid_map* ceph_get_snapid_map(struct ceph_mds_client *mdsc,
 	}
 	spin_unlock(&mdsc->snapid_map_lock);
 	if (exist) {
-		dout("%s found snapid map %llx -> %x\n", __func__,
-		     exist->snap, exist->dev);
+		doutc(cl, "found snapid map %llx -> %x\n", exist->snap,
+		      exist->dev);
 		return exist;
 	}
 
@@ -1241,13 +1256,12 @@ struct ceph_snapid_map* ceph_get_snapid_map(struct ceph_mds_client *mdsc,
 	if (exist) {
 		free_anon_bdev(sm->dev);
 		kfree(sm);
-		dout("%s found snapid map %llx -> %x\n", __func__,
-		     exist->snap, exist->dev);
+		doutc(cl, "found snapid map %llx -> %x\n", exist->snap,
+		      exist->dev);
 		return exist;
 	}
 
-	dout("%s create snapid map %llx -> %x\n", __func__,
-	     sm->snap, sm->dev);
+	doutc(cl, "create snapid map %llx -> %x\n", sm->snap, sm->dev);
 	return sm;
 }
 
@@ -1272,6 +1286,7 @@ void ceph_put_snapid_map(struct ceph_mds_client* mdsc,
 
 void ceph_trim_snapid_map(struct ceph_mds_client *mdsc)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_snapid_map *sm;
 	unsigned long now;
 	LIST_HEAD(to_free);
@@ -1293,7 +1308,7 @@ void ceph_trim_snapid_map(struct ceph_mds_client *mdsc)
 	while (!list_empty(&to_free)) {
 		sm = list_first_entry(&to_free, struct ceph_snapid_map, lru);
 		list_del(&sm->lru);
-		dout("trim snapid map %llx -> %x\n", sm->snap, sm->dev);
+		doutc(cl, "trim snapid map %llx -> %x\n", sm->snap, sm->dev);
 		free_anon_bdev(sm->dev);
 		kfree(sm);
 	}
@@ -1301,6 +1316,7 @@ void ceph_trim_snapid_map(struct ceph_mds_client *mdsc)
 
 void ceph_cleanup_snapid_map(struct ceph_mds_client *mdsc)
 {
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_snapid_map *sm;
 	struct rb_node *p;
 	LIST_HEAD(to_free);
@@ -1319,8 +1335,8 @@ void ceph_cleanup_snapid_map(struct ceph_mds_client *mdsc)
 		list_del(&sm->lru);
 		free_anon_bdev(sm->dev);
 		if (WARN_ON_ONCE(atomic_read(&sm->ref))) {
-			pr_err("snapid map %llx -> %x still in use\n",
-			       sm->snap, sm->dev);
+			pr_err_client(cl, "snapid map %llx -> %x still in use\n",
+				      sm->snap, sm->dev);
 		}
 		kfree(sm);
 	}
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 29026ba4f022..9139f102351b 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -46,9 +46,10 @@ static void ceph_put_super(struct super_block *s)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(s);
 
-	dout("put_super\n");
+	doutc(fsc->client, "begin\n");
 	ceph_fscrypt_free_dummy_policy(fsc);
 	ceph_mdsc_close_sessions(fsc->mdsc);
+	doutc(fsc->client, "done\n");
 }
 
 static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
@@ -59,13 +60,13 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	int i, err;
 	u64 data_pool;
 
+	doutc(fsc->client, "begin\n");
 	if (fsc->mdsc->mdsmap->m_num_data_pg_pools == 1) {
 		data_pool = fsc->mdsc->mdsmap->m_data_pg_pools[0];
 	} else {
 		data_pool = CEPH_NOPOOL;
 	}
 
-	dout("statfs\n");
 	err = ceph_monc_do_statfs(monc, data_pool, &st);
 	if (err < 0)
 		return err;
@@ -113,24 +114,26 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	/* fold the fs_cluster_id into the upper bits */
 	buf->f_fsid.val[1] = monc->fs_cluster_id;
 
+	doutc(fsc->client, "done\n");
 	return 0;
 }
 
 static int ceph_sync_fs(struct super_block *sb, int wait)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
+	struct ceph_client *cl = fsc->client;
 
 	if (!wait) {
-		dout("sync_fs (non-blocking)\n");
+		doutc(cl, "(non-blocking)\n");
 		ceph_flush_dirty_caps(fsc->mdsc);
-		dout("sync_fs (non-blocking) done\n");
+		doutc(cl, "(non-blocking) done\n");
 		return 0;
 	}
 
-	dout("sync_fs (blocking)\n");
+	doutc(cl, "(blocking)\n");
 	ceph_osdc_sync(&fsc->client->osdc);
 	ceph_mdsc_sync(fsc->mdsc);
-	dout("sync_fs (blocking) done\n");
+	doutc(cl, "(blocking) done\n");
 	return 0;
 }
 
@@ -349,7 +352,7 @@ static int ceph_parse_source(struct fs_parameter *param, struct fs_context *fc)
 	char *dev_name = param->string, *dev_name_end;
 	int ret;
 
-	dout("%s '%s'\n", __func__, dev_name);
+	dout("'%s'\n", dev_name);
 	if (!dev_name || !*dev_name)
 		return invalfc(fc, "Empty source");
 
@@ -421,7 +424,7 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 		return ret;
 
 	token = fs_parse(fc, ceph_mount_parameters, param, &result);
-	dout("%s fs_parse '%s' token %d\n", __func__, param->key, token);
+	dout("%s: fs_parse '%s' token %d\n",__func__, param->key, token);
 	if (token < 0)
 		return token;
 
@@ -891,7 +894,7 @@ static void flush_fs_workqueues(struct ceph_fs_client *fsc)
 
 static void destroy_fs_client(struct ceph_fs_client *fsc)
 {
-	dout("destroy_fs_client %p\n", fsc);
+	doutc(fsc->client, "%p\n", fsc);
 
 	spin_lock(&ceph_fsc_lock);
 	list_del(&fsc->metric_wakeup);
@@ -906,7 +909,7 @@ static void destroy_fs_client(struct ceph_fs_client *fsc)
 	ceph_destroy_client(fsc->client);
 
 	kfree(fsc);
-	dout("destroy_fs_client %p done\n", fsc);
+	dout("%s: %p done\n", __func__, fsc);
 }
 
 /*
@@ -1028,7 +1031,7 @@ void ceph_umount_begin(struct super_block *sb)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 
-	dout("ceph_umount_begin - starting forced umount\n");
+	doutc(fsc->client, "starting forced umount\n");
 	if (!fsc)
 		return;
 	fsc->mount_state = CEPH_MOUNT_SHUTDOWN;
@@ -1056,13 +1059,14 @@ static struct dentry *open_root_dentry(struct ceph_fs_client *fsc,
 				       const char *path,
 				       unsigned long started)
 {
+	struct ceph_client *cl = fsc->client;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req = NULL;
 	int err;
 	struct dentry *root;
 
 	/* open dir */
-	dout("open_root_inode opening '%s'\n", path);
+	doutc(cl, "opening '%s'\n", path);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR, USE_ANY_MDS);
 	if (IS_ERR(req))
 		return ERR_CAST(req);
@@ -1082,13 +1086,13 @@ static struct dentry *open_root_dentry(struct ceph_fs_client *fsc,
 	if (err == 0) {
 		struct inode *inode = req->r_target_inode;
 		req->r_target_inode = NULL;
-		dout("open_root_inode success\n");
+		doutc(cl, "success\n");
 		root = d_make_root(inode);
 		if (!root) {
 			root = ERR_PTR(-ENOMEM);
 			goto out;
 		}
-		dout("open_root_inode success, root dentry is %p\n", root);
+		doutc(cl, "success, root dentry is %p\n", root);
 	} else {
 		root = ERR_PTR(err);
 	}
@@ -1147,11 +1151,12 @@ static int ceph_apply_test_dummy_encryption(struct super_block *sb,
 static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 				      struct fs_context *fc)
 {
+	struct ceph_client *cl = fsc->client;
 	int err;
 	unsigned long started = jiffies;  /* note the start time */
 	struct dentry *root;
 
-	dout("mount start %p\n", fsc);
+	doutc(cl, "mount start %p\n", fsc);
 	mutex_lock(&fsc->client->mount_mutex);
 
 	if (!fsc->sb->s_root) {
@@ -1174,7 +1179,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 		if (err)
 			goto out;
 
-		dout("mount opening path '%s'\n", path);
+		doutc(cl, "mount opening path '%s'\n", path);
 
 		ceph_fs_debugfs_init(fsc);
 
@@ -1189,7 +1194,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 	}
 
 	fsc->mount_state = CEPH_MOUNT_MOUNTED;
-	dout("mount success\n");
+	doutc(cl, "mount success\n");
 	mutex_unlock(&fsc->client->mount_mutex);
 	return root;
 
@@ -1202,9 +1207,10 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 {
 	struct ceph_fs_client *fsc = s->s_fs_info;
+	struct ceph_client *cl = fsc->client;
 	int ret;
 
-	dout("set_super %p\n", s);
+	doutc(cl, "%p\n", s);
 
 	s->s_maxbytes = MAX_LFS_FILESIZE;
 
@@ -1238,30 +1244,31 @@ static int ceph_compare_super(struct super_block *sb, struct fs_context *fc)
 	struct ceph_mount_options *fsopt = new->mount_options;
 	struct ceph_options *opt = new->client->options;
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
+	struct ceph_client *cl = fsc->client;
 
-	dout("ceph_compare_super %p\n", sb);
+	doutc(cl, "%p\n", sb);
 
 	if (compare_mount_options(fsopt, opt, fsc)) {
-		dout("monitor(s)/mount options don't match\n");
+		doutc(cl, "monitor(s)/mount options don't match\n");
 		return 0;
 	}
 	if ((opt->flags & CEPH_OPT_FSID) &&
 	    ceph_fsid_compare(&opt->fsid, &fsc->client->fsid)) {
-		dout("fsid doesn't match\n");
+		doutc(cl, "fsid doesn't match\n");
 		return 0;
 	}
 	if (fc->sb_flags != (sb->s_flags & ~SB_BORN)) {
-		dout("flags differ\n");
+		doutc(cl, "flags differ\n");
 		return 0;
 	}
 
 	if (fsc->blocklisted && !ceph_test_mount_opt(fsc, CLEANRECOVER)) {
-		dout("client is blocklisted (and CLEANRECOVER is not set)\n");
+		doutc(cl, "client is blocklisted (and CLEANRECOVER is not set)\n");
 		return 0;
 	}
 
 	if (fsc->mount_state == CEPH_MOUNT_SHUTDOWN) {
-		dout("client has been forcibly unmounted\n");
+		doutc(cl, "client has been forcibly unmounted\n");
 		return 0;
 	}
 
@@ -1349,8 +1356,9 @@ static int ceph_get_tree(struct fs_context *fc)
 		err = PTR_ERR(res);
 		goto out_splat;
 	}
-	dout("root %p inode %p ino %llx.%llx\n", res,
-	     d_inode(res), ceph_vinop(d_inode(res)));
+
+	doutc(fsc->client, "root %p inode %p ino %llx.%llx\n", res,
+		    d_inode(res), ceph_vinop(d_inode(res)));
 	fc->root = fsc->sb->s_root;
 	return 0;
 
@@ -1408,7 +1416,8 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
 		kfree(fsc->mount_options->mon_addr);
 		fsc->mount_options->mon_addr = fsopt->mon_addr;
 		fsopt->mon_addr = NULL;
-		pr_notice("ceph: monitor addresses recorded, but not used for reconnection");
+		pr_notice_client(fsc->client,
+			"monitor addresses recorded, but not used for reconnection");
 	}
 
 	sync_filesystem(sb);
@@ -1528,10 +1537,11 @@ void ceph_dec_osd_stopping_blocker(struct ceph_mds_client *mdsc)
 static void ceph_kill_sb(struct super_block *s)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(s);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	bool wait;
 
-	dout("kill_sb %p\n", s);
+	doutc(cl, "%p\n", s);
 
 	ceph_mdsc_pre_umount(mdsc);
 	flush_fs_workqueues(fsc);
@@ -1562,9 +1572,9 @@ static void ceph_kill_sb(struct super_block *s)
 					&mdsc->stopping_waiter,
 					fsc->client->options->mount_timeout);
 		if (!timeleft) /* timed out */
-			pr_warn("umount timed out, %ld\n", timeleft);
+			pr_warn_client(cl, "umount timed out, %ld\n", timeleft);
 		else if (timeleft < 0) /* killed */
-			pr_warn("umount was killed, %ld\n", timeleft);
+			pr_warn_client(cl, "umount was killed, %ld\n", timeleft);
 	}
 
 	mdsc->stopping = CEPH_MDSC_STOPPING_FLUSHED;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 5903e3fb6d75..e31ecbed609d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -506,6 +506,12 @@ ceph_sb_to_mdsc(const struct super_block *sb)
 	return (struct ceph_mds_client *)ceph_sb_to_fs_client(sb)->mdsc;
 }
 
+static inline struct ceph_client *
+ceph_inode_to_client(const struct inode *inode)
+{
+	return (struct ceph_client *)ceph_inode_to_fs_client(inode)->client;
+}
+
 static inline struct ceph_vino
 ceph_vino(const struct inode *inode)
 {
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 558f64554b59..04d031467193 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -58,6 +58,7 @@ static ssize_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 				    size_t size)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->netfs.inode.i_sb);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_string *pool_ns;
 	s64 pool = ci->i_layout.pool_id;
@@ -69,7 +70,7 @@ static ssize_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 
 	pool_ns = ceph_try_get_string(ci->i_layout.pool_ns);
 
-	dout("ceph_vxattrcb_layout %p\n", &ci->netfs.inode);
+	doutc(cl, "%p\n", &ci->netfs.inode);
 	down_read(&osdc->lock);
 	pool_name = ceph_pg_pool_name_by_id(osdc->osdmap, pool);
 	if (pool_name) {
@@ -570,6 +571,8 @@ static int __set_xattr(struct ceph_inode_info *ci,
 			   int flags, int update_xattr,
 			   struct ceph_inode_xattr **newxattr)
 {
+	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct ceph_inode_xattr *xattr = NULL;
@@ -626,7 +629,7 @@ static int __set_xattr(struct ceph_inode_info *ci,
 		xattr->should_free_name = update_xattr;
 
 		ci->i_xattrs.count++;
-		dout("%s count=%d\n", __func__, ci->i_xattrs.count);
+		doutc(cl, "count=%d\n", ci->i_xattrs.count);
 	} else {
 		kfree(*newxattr);
 		*newxattr = NULL;
@@ -654,13 +657,13 @@ static int __set_xattr(struct ceph_inode_info *ci,
 	if (new) {
 		rb_link_node(&xattr->node, parent, p);
 		rb_insert_color(&xattr->node, &ci->i_xattrs.index);
-		dout("%s p=%p\n", __func__, p);
+		doutc(cl, "p=%p\n", p);
 	}
 
-	dout("%s added %llx.%llx xattr %p %.*s=%.*s%s\n", __func__,
-	     ceph_vinop(&ci->netfs.inode), xattr, name_len, name,
-	     min(val_len, MAX_XATTR_VAL_PRINT_LEN), val,
-	     val_len > MAX_XATTR_VAL_PRINT_LEN ? "..." : "");
+	doutc(cl, "added %p %llx.%llx xattr %p %.*s=%.*s%s\n", inode,
+	      ceph_vinop(inode), xattr, name_len, name, min(val_len,
+	      MAX_XATTR_VAL_PRINT_LEN), val,
+	      val_len > MAX_XATTR_VAL_PRINT_LEN ? "..." : "");
 
 	return 0;
 }
@@ -668,6 +671,7 @@ static int __set_xattr(struct ceph_inode_info *ci,
 static struct ceph_inode_xattr *__get_xattr(struct ceph_inode_info *ci,
 			   const char *name)
 {
+	struct ceph_client *cl = ceph_inode_to_client(&ci->netfs.inode);
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct ceph_inode_xattr *xattr = NULL;
@@ -688,13 +692,13 @@ static struct ceph_inode_xattr *__get_xattr(struct ceph_inode_info *ci,
 		else {
 			int len = min(xattr->val_len, MAX_XATTR_VAL_PRINT_LEN);
 
-			dout("%s %s: found %.*s%s\n", __func__, name, len,
-			     xattr->val, xattr->val_len > len ? "..." : "");
+			doutc(cl, "%s found %.*s%s\n", name, len, xattr->val,
+			      xattr->val_len > len ? "..." : "");
 			return xattr;
 		}
 	}
 
-	dout("%s %s: not found\n", __func__, name);
+	doutc(cl, "%s not found\n", name);
 
 	return NULL;
 }
@@ -735,19 +739,20 @@ static int __remove_xattr(struct ceph_inode_info *ci,
 static char *__copy_xattr_names(struct ceph_inode_info *ci,
 				char *dest)
 {
+	struct ceph_client *cl = ceph_inode_to_client(&ci->netfs.inode);
 	struct rb_node *p;
 	struct ceph_inode_xattr *xattr = NULL;
 
 	p = rb_first(&ci->i_xattrs.index);
-	dout("__copy_xattr_names count=%d\n", ci->i_xattrs.count);
+	doutc(cl, "count=%d\n", ci->i_xattrs.count);
 
 	while (p) {
 		xattr = rb_entry(p, struct ceph_inode_xattr, node);
 		memcpy(dest, xattr->name, xattr->name_len);
 		dest[xattr->name_len] = '\0';
 
-		dout("dest=%s %p (%s) (%d/%d)\n", dest, xattr, xattr->name,
-		     xattr->name_len, ci->i_xattrs.names_size);
+		doutc(cl, "dest=%s %p (%s) (%d/%d)\n", dest, xattr, xattr->name,
+		      xattr->name_len, ci->i_xattrs.names_size);
 
 		dest += xattr->name_len + 1;
 		p = rb_next(p);
@@ -758,19 +763,19 @@ static char *__copy_xattr_names(struct ceph_inode_info *ci,
 
 void __ceph_destroy_xattrs(struct ceph_inode_info *ci)
 {
+	struct ceph_client *cl = ceph_inode_to_client(&ci->netfs.inode);
 	struct rb_node *p, *tmp;
 	struct ceph_inode_xattr *xattr = NULL;
 
 	p = rb_first(&ci->i_xattrs.index);
 
-	dout("__ceph_destroy_xattrs p=%p\n", p);
+	doutc(cl, "p=%p\n", p);
 
 	while (p) {
 		xattr = rb_entry(p, struct ceph_inode_xattr, node);
 		tmp = p;
 		p = rb_next(tmp);
-		dout("__ceph_destroy_xattrs next p=%p (%.*s)\n", p,
-		     xattr->name_len, xattr->name);
+		doutc(cl, "next p=%p (%.*s)\n", p, xattr->name_len, xattr->name);
 		rb_erase(tmp, &ci->i_xattrs.index);
 
 		__free_xattr(xattr);
@@ -787,6 +792,7 @@ static int __build_xattrs(struct inode *inode)
 	__releases(ci->i_ceph_lock)
 	__acquires(ci->i_ceph_lock)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	u32 namelen;
 	u32 numattr = 0;
 	void *p, *end;
@@ -798,8 +804,8 @@ static int __build_xattrs(struct inode *inode)
 	int err = 0;
 	int i;
 
-	dout("__build_xattrs() len=%d\n",
-	     ci->i_xattrs.blob ? (int)ci->i_xattrs.blob->vec.iov_len : 0);
+	doutc(cl, "len=%d\n",
+	      ci->i_xattrs.blob ? (int)ci->i_xattrs.blob->vec.iov_len : 0);
 
 	if (ci->i_xattrs.index_version >= ci->i_xattrs.version)
 		return 0; /* already built */
@@ -874,6 +880,8 @@ static int __build_xattrs(struct inode *inode)
 static int __get_required_blob_size(struct ceph_inode_info *ci, int name_size,
 				    int val_size)
 {
+	struct ceph_client *cl = ceph_inode_to_client(&ci->netfs.inode);
+
 	/*
 	 * 4 bytes for the length, and additional 4 bytes per each xattr name,
 	 * 4 bytes per each value
@@ -881,9 +889,8 @@ static int __get_required_blob_size(struct ceph_inode_info *ci, int name_size,
 	int size = 4 + ci->i_xattrs.count*(4 + 4) +
 			     ci->i_xattrs.names_size +
 			     ci->i_xattrs.vals_size;
-	dout("__get_required_blob_size c=%d names.size=%d vals.size=%d\n",
-	     ci->i_xattrs.count, ci->i_xattrs.names_size,
-	     ci->i_xattrs.vals_size);
+	doutc(cl, "c=%d names.size=%d vals.size=%d\n", ci->i_xattrs.count,
+	      ci->i_xattrs.names_size, ci->i_xattrs.vals_size);
 
 	if (name_size)
 		size += 4 + 4 + name_size + val_size;
@@ -899,12 +906,14 @@ static int __get_required_blob_size(struct ceph_inode_info *ci, int name_size,
  */
 struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_info *ci)
 {
+	struct inode *inode = &ci->netfs.inode;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct rb_node *p;
 	struct ceph_inode_xattr *xattr = NULL;
 	struct ceph_buffer *old_blob = NULL;
 	void *dest;
 
-	dout("__build_xattrs_blob %p\n", &ci->netfs.inode);
+	doutc(cl, "%p %llx.%llx\n", inode, ceph_vinop(inode));
 	if (ci->i_xattrs.dirty) {
 		int need = __get_required_blob_size(ci, 0, 0);
 
@@ -962,6 +971,7 @@ static inline int __get_request_mask(struct inode *in) {
 ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 		      size_t size)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_inode_xattr *xattr;
 	struct ceph_vxattr *vxattr;
@@ -1000,8 +1010,9 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 	req_mask = __get_request_mask(inode);
 
 	spin_lock(&ci->i_ceph_lock);
-	dout("getxattr %p name '%s' ver=%lld index_ver=%lld\n", inode, name,
-	     ci->i_xattrs.version, ci->i_xattrs.index_version);
+	doutc(cl, "%p %llx.%llx name '%s' ver=%lld index_ver=%lld\n", inode,
+	      ceph_vinop(inode), name, ci->i_xattrs.version,
+	      ci->i_xattrs.index_version);
 
 	if (ci->i_xattrs.version == 0 ||
 	    !((req_mask & CEPH_CAP_XATTR_SHARED) ||
@@ -1010,8 +1021,9 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 
 		/* security module gets xattr while filling trace */
 		if (current->journal_info) {
-			pr_warn_ratelimited("sync getxattr %p "
-					    "during filling trace\n", inode);
+			pr_warn_ratelimited_client(cl,
+				"sync %p %llx.%llx during filling trace\n",
+				inode, ceph_vinop(inode));
 			return -EBUSY;
 		}
 
@@ -1053,14 +1065,16 @@ ssize_t __ceph_getxattr(struct inode *inode, const char *name, void *value,
 ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 {
 	struct inode *inode = d_inode(dentry);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	bool len_only = (size == 0);
 	u32 namelen;
 	int err;
 
 	spin_lock(&ci->i_ceph_lock);
-	dout("listxattr %p ver=%lld index_ver=%lld\n", inode,
-	     ci->i_xattrs.version, ci->i_xattrs.index_version);
+	doutc(cl, "%p %llx.%llx ver=%lld index_ver=%lld\n", inode,
+	      ceph_vinop(inode), ci->i_xattrs.version,
+	      ci->i_xattrs.index_version);
 
 	if (ci->i_xattrs.version == 0 ||
 	    !__ceph_caps_issued_mask_metric(ci, CEPH_CAP_XATTR_SHARED, 1)) {
@@ -1095,6 +1109,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 			      const char *value, size_t size, int flags)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -1119,7 +1134,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 			flags |= CEPH_XATTR_REMOVE;
 	}
 
-	dout("setxattr value size: %zu\n", size);
+	doutc(cl, "name %s value size %zu\n", name, size);
 
 	/* do request */
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
@@ -1148,10 +1163,10 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 	req->r_num_caps = 1;
 	req->r_inode_drop = CEPH_CAP_XATTR_SHARED;
 
-	dout("xattr.ver (before): %lld\n", ci->i_xattrs.version);
+	doutc(cl, "xattr.ver (before): %lld\n", ci->i_xattrs.version);
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	ceph_mdsc_put_request(req);
-	dout("xattr.ver (after): %lld\n", ci->i_xattrs.version);
+	doutc(cl, "xattr.ver (after): %lld\n", ci->i_xattrs.version);
 
 out:
 	if (pagelist)
@@ -1162,6 +1177,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 int __ceph_setxattr(struct inode *inode, const char *name,
 			const void *value, size_t size, int flags)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_vxattr *vxattr;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
@@ -1220,9 +1236,9 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
 	if ((ci->i_xattrs.version == 0) || !(issued & CEPH_CAP_XATTR_EXCL) ||
 	    (required_blob_size > mdsc->mdsmap->m_max_xattr_size)) {
-		dout("%s do sync setxattr: version: %llu size: %d max: %llu\n",
-		     __func__, ci->i_xattrs.version, required_blob_size,
-		     mdsc->mdsmap->m_max_xattr_size);
+		doutc(cl, "sync version: %llu size: %d max: %llu\n",
+		      ci->i_xattrs.version, required_blob_size,
+		      mdsc->mdsmap->m_max_xattr_size);
 		goto do_sync;
 	}
 
@@ -1236,8 +1252,8 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 		}
 	}
 
-	dout("setxattr %p name '%s' issued %s\n", inode, name,
-	     ceph_cap_string(issued));
+	doutc(cl, "%p %llx.%llx name '%s' issued %s\n", inode,
+	      ceph_vinop(inode), name, ceph_cap_string(issued));
 	__build_xattrs(inode);
 
 	if (!ci->i_xattrs.prealloc_blob ||
@@ -1246,7 +1262,8 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 
 		spin_unlock(&ci->i_ceph_lock);
 		ceph_buffer_put(old_blob); /* Shouldn't be required */
-		dout(" pre-allocating new blob size=%d\n", required_blob_size);
+		doutc(cl, " pre-allocating new blob size=%d\n",
+		      required_blob_size);
 		blob = ceph_buffer_new(required_blob_size, GFP_NOFS);
 		if (!blob)
 			goto do_sync_unlocked;
@@ -1285,8 +1302,9 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 
 	/* security module set xattr while filling trace */
 	if (current->journal_info) {
-		pr_warn_ratelimited("sync setxattr %p "
-				    "during filling trace\n", inode);
+		pr_warn_ratelimited_client(cl,
+				"sync %p %llx.%llx during filling trace\n",
+				inode, ceph_vinop(inode));
 		err = -EBUSY;
 	} else {
 		err = ceph_sync_setxattr(inode, name, value, size, flags);
-- 
2.39.5




