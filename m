Return-Path: <stable+bounces-49580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF18FEDE6
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76057B25956
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0C01BE842;
	Thu,  6 Jun 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s26yxpD9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6D1BE258;
	Thu,  6 Jun 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683536; cv=none; b=AM+ZXO/zWYNZ7fkhe44D7fKMCQQP8hdc0FbEgn2T5HU8ZfUPtSQP1ErP7t/BFStTHoA1HIkbUJvgxO/WPSF9NJLdgFJjf6Bqud+eWdWxrPzMxKsvfgNptwN0GxW89OJ6ZNw2+VxhcyC6xMCYb+maOWdDvFQIAn43LhXqXI5/CYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683536; c=relaxed/simple;
	bh=HLtJ9bv2nTMEVem5gvhl1HuCasmLpbO1EPOIyZrayQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jehDd/JAjLSHyzf5fjZnmhJGez+CZgtGt8nx8rqEFpfGWYWZ6qAZqUpSjzwlGGWeqxC/YZMm0gt/9c3xszLX/HY7WZYjX8n3Co+1hq3MiaNpxKjficlMQmKsEL5KgoxTZV1lFb8fqbBInU6ft/yYhzDwuUNI+n+sgcUIpoTBj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s26yxpD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAB1C32781;
	Thu,  6 Jun 2024 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683536;
	bh=HLtJ9bv2nTMEVem5gvhl1HuCasmLpbO1EPOIyZrayQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s26yxpD9R0MubOmkMcny71C9nuSiMT5JxeWtJSVRIdJgZdFQnEw+SHvj4iQhPi1/V
	 ca96fGDTMPx502cwoe3bkntAC0CMQ+OHJ/UzVpC13QDkQ2xuXhRf6204NoS7C43bol
	 ksfyjfxRRXlKrTo11I+cwB29VYe6wpsobFpmTykM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 476/744] xfs: convert kmem_free() for kvmalloc users to kvfree()
Date: Thu,  6 Jun 2024 16:02:28 +0200
Message-ID: <20240606131747.723442477@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 49292576136fd2a6b58a51677c53151cf4877fa6 ]

Start getting rid of kmem_free() by converting all the cases where
memory can come from vmalloc interfaces to calling kvfree()
directly.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Stable-dep-of: 45cf976008dd ("xfs: fix log recovery buffer allocation for the legacy h_size fixup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_acl.c           |  4 ++--
 fs/xfs/xfs_attr_item.c     |  4 ++--
 fs/xfs/xfs_bmap_item.c     |  4 ++--
 fs/xfs/xfs_buf_item.c      |  2 +-
 fs/xfs/xfs_dquot.c         |  2 +-
 fs/xfs/xfs_extfree_item.c  |  4 ++--
 fs/xfs/xfs_icreate_item.c  |  2 +-
 fs/xfs/xfs_inode_item.c    |  2 +-
 fs/xfs/xfs_ioctl.c         |  2 +-
 fs/xfs/xfs_log.c           |  4 ++--
 fs/xfs/xfs_log_cil.c       |  2 +-
 fs/xfs/xfs_log_recover.c   | 42 +++++++++++++++++++-------------------
 fs/xfs/xfs_refcount_item.c |  4 ++--
 fs/xfs/xfs_rmap_item.c     |  4 ++--
 fs/xfs/xfs_rtalloc.c       |  6 +++---
 15 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index 6b840301817a9..4bf69c9c088e2 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -167,7 +167,7 @@ xfs_get_acl(struct inode *inode, int type, bool rcu)
 		acl = ERR_PTR(error);
 	}
 
-	kmem_free(args.value);
+	kvfree(args.value);
 	return acl;
 }
 
@@ -204,7 +204,7 @@ __xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	}
 
 	error = xfs_attr_change(&args);
-	kmem_free(args.value);
+	kvfree(args.value);
 
 	/*
 	 * If the attribute didn't exist to start with that's fine.
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index ebf656aaf3012..fc164e8f7e483 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -110,7 +110,7 @@ STATIC void
 xfs_attri_item_free(
 	struct xfs_attri_log_item	*attrip)
 {
-	kmem_free(attrip->attri_item.li_lv_shadow);
+	kvfree(attrip->attri_item.li_lv_shadow);
 	xfs_attri_log_nameval_put(attrip->attri_nameval);
 	kmem_cache_free(xfs_attri_cache, attrip);
 }
@@ -253,7 +253,7 @@ static inline struct xfs_attrd_log_item *ATTRD_ITEM(struct xfs_log_item *lip)
 STATIC void
 xfs_attrd_item_free(struct xfs_attrd_log_item *attrdp)
 {
-	kmem_free(attrdp->attrd_item.li_lv_shadow);
+	kvfree(attrdp->attrd_item.li_lv_shadow);
 	kmem_cache_free(xfs_attrd_cache, attrdp);
 }
 
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index b6d63b8bdad5a..dc4c199fa7af2 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -40,7 +40,7 @@ STATIC void
 xfs_bui_item_free(
 	struct xfs_bui_log_item	*buip)
 {
-	kmem_free(buip->bui_item.li_lv_shadow);
+	kvfree(buip->bui_item.li_lv_shadow);
 	kmem_cache_free(xfs_bui_cache, buip);
 }
 
@@ -201,7 +201,7 @@ xfs_bud_item_release(
 	struct xfs_bud_log_item	*budp = BUD_ITEM(lip);
 
 	xfs_bui_release(budp->bud_buip);
-	kmem_free(budp->bud_item.li_lv_shadow);
+	kvfree(budp->bud_item.li_lv_shadow);
 	kmem_cache_free(xfs_bud_cache, budp);
 }
 
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 023d4e0385dd0..7d447fbcdd983 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -1044,7 +1044,7 @@ xfs_buf_item_free(
 	struct xfs_buf_log_item	*bip)
 {
 	xfs_buf_item_free_format(bip);
-	kmem_free(bip->bli_item.li_lv_shadow);
+	kvfree(bip->bli_item.li_lv_shadow);
 	kmem_cache_free(xfs_buf_item_cache, bip);
 }
 
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index a013b87ab8d5e..5c9fd69d75959 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -53,7 +53,7 @@ xfs_qm_dqdestroy(
 {
 	ASSERT(list_empty(&dqp->q_lru));
 
-	kmem_free(dqp->q_logitem.qli_item.li_lv_shadow);
+	kvfree(dqp->q_logitem.qli_item.li_lv_shadow);
 	mutex_destroy(&dqp->q_qlock);
 
 	XFS_STATS_DEC(dqp->q_mount, xs_qm_dquot);
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index c9908fb337657..8904242f4eb45 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -40,7 +40,7 @@ STATIC void
 xfs_efi_item_free(
 	struct xfs_efi_log_item	*efip)
 {
-	kmem_free(efip->efi_item.li_lv_shadow);
+	kvfree(efip->efi_item.li_lv_shadow);
 	if (efip->efi_format.efi_nextents > XFS_EFI_MAX_FAST_EXTENTS)
 		kmem_free(efip);
 	else
@@ -229,7 +229,7 @@ static inline struct xfs_efd_log_item *EFD_ITEM(struct xfs_log_item *lip)
 STATIC void
 xfs_efd_item_free(struct xfs_efd_log_item *efdp)
 {
-	kmem_free(efdp->efd_item.li_lv_shadow);
+	kvfree(efdp->efd_item.li_lv_shadow);
 	if (efdp->efd_format.efd_nextents > XFS_EFD_MAX_FAST_EXTENTS)
 		kmem_free(efdp);
 	else
diff --git a/fs/xfs/xfs_icreate_item.c b/fs/xfs/xfs_icreate_item.c
index b05314d48176f..4345db501714e 100644
--- a/fs/xfs/xfs_icreate_item.c
+++ b/fs/xfs/xfs_icreate_item.c
@@ -63,7 +63,7 @@ STATIC void
 xfs_icreate_item_release(
 	struct xfs_log_item	*lip)
 {
-	kmem_free(ICR_ITEM(lip)->ic_item.li_lv_shadow);
+	kvfree(ICR_ITEM(lip)->ic_item.li_lv_shadow);
 	kmem_cache_free(xfs_icreate_cache, ICR_ITEM(lip));
 }
 
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 155a8b3128755..7c3f4a3da518b 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -857,7 +857,7 @@ xfs_inode_item_destroy(
 	ASSERT(iip->ili_item.li_buf == NULL);
 
 	ip->i_itemp = NULL;
-	kmem_free(iip->ili_item.li_lv_shadow);
+	kvfree(iip->ili_item.li_lv_shadow);
 	kmem_cache_free(xfs_ili_cache, iip);
 }
 
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 535f6d38cdb54..8d844c7d1c798 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -492,7 +492,7 @@ xfs_attrmulti_attr_get(
 		error = -EFAULT;
 
 out_kfree:
-	kmem_free(args.value);
+	kvfree(args.value);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index a1650fc81382f..04327aaa5bf09 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1661,7 +1661,7 @@ xlog_alloc_log(
 out_free_iclog:
 	for (iclog = log->l_iclog; iclog; iclog = prev_iclog) {
 		prev_iclog = iclog->ic_next;
-		kmem_free(iclog->ic_data);
+		kvfree(iclog->ic_data);
 		kmem_free(iclog);
 		if (prev_iclog == log->l_iclog)
 			break;
@@ -2118,7 +2118,7 @@ xlog_dealloc_log(
 	iclog = log->l_iclog;
 	for (i = 0; i < log->l_iclog_bufs; i++) {
 		next_iclog = iclog->ic_next;
-		kmem_free(iclog->ic_data);
+		kvfree(iclog->ic_data);
 		kmem_free(iclog);
 		iclog = next_iclog;
 	}
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 67a99d94701e5..d2ed2c38e2989 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -339,7 +339,7 @@ xlog_cil_alloc_shadow_bufs(
 			 * the buffer, only the log vector header and the iovec
 			 * storage.
 			 */
-			kmem_free(lip->li_lv_shadow);
+			kvfree(lip->li_lv_shadow);
 			lv = xlog_kvmalloc(buf_size);
 
 			memset(lv, 0, xlog_cil_iovec_space(niovecs));
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index cc14cd1c2282f..f3fcd58349c16 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -361,7 +361,7 @@ xlog_find_verify_cycle(
 	*new_blk = -1;
 
 out:
-	kmem_free(buffer);
+	kvfree(buffer);
 	return error;
 }
 
@@ -477,7 +477,7 @@ xlog_find_verify_log_record(
 		*last_blk = i;
 
 out:
-	kmem_free(buffer);
+	kvfree(buffer);
 	return error;
 }
 
@@ -731,7 +731,7 @@ xlog_find_head(
 			goto out_free_buffer;
 	}
 
-	kmem_free(buffer);
+	kvfree(buffer);
 	if (head_blk == log_bbnum)
 		*return_head_blk = 0;
 	else
@@ -745,7 +745,7 @@ xlog_find_head(
 	return 0;
 
 out_free_buffer:
-	kmem_free(buffer);
+	kvfree(buffer);
 	if (error)
 		xfs_warn(log->l_mp, "failed to find log head");
 	return error;
@@ -999,7 +999,7 @@ xlog_verify_tail(
 		"Tail block (0x%llx) overwrite detected. Updated to 0x%llx",
 			 orig_tail, *tail_blk);
 out:
-	kmem_free(buffer);
+	kvfree(buffer);
 	return error;
 }
 
@@ -1046,7 +1046,7 @@ xlog_verify_head(
 	error = xlog_rseek_logrec_hdr(log, *head_blk, *tail_blk,
 				      XLOG_MAX_ICLOGS, tmp_buffer,
 				      &tmp_rhead_blk, &tmp_rhead, &tmp_wrapped);
-	kmem_free(tmp_buffer);
+	kvfree(tmp_buffer);
 	if (error < 0)
 		return error;
 
@@ -1365,7 +1365,7 @@ xlog_find_tail(
 		error = xlog_clear_stale_blocks(log, tail_lsn);
 
 done:
-	kmem_free(buffer);
+	kvfree(buffer);
 
 	if (error)
 		xfs_warn(log->l_mp, "failed to locate log tail");
@@ -1399,6 +1399,7 @@ xlog_find_zeroed(
 	xfs_daddr_t	new_blk, last_blk, start_blk;
 	xfs_daddr_t     num_scan_bblks;
 	int	        error, log_bbnum = log->l_logBBsize;
+	int		ret = 1;
 
 	*blk_no = 0;
 
@@ -1413,8 +1414,7 @@ xlog_find_zeroed(
 	first_cycle = xlog_get_cycle(offset);
 	if (first_cycle == 0) {		/* completely zeroed log */
 		*blk_no = 0;
-		kmem_free(buffer);
-		return 1;
+		goto out_free_buffer;
 	}
 
 	/* check partially zeroed log */
@@ -1424,8 +1424,8 @@ xlog_find_zeroed(
 
 	last_cycle = xlog_get_cycle(offset);
 	if (last_cycle != 0) {		/* log completely written to */
-		kmem_free(buffer);
-		return 0;
+		ret = 0;
+		goto out_free_buffer;
 	}
 
 	/* we have a partially zeroed log */
@@ -1471,10 +1471,10 @@ xlog_find_zeroed(
 
 	*blk_no = last_blk;
 out_free_buffer:
-	kmem_free(buffer);
+	kvfree(buffer);
 	if (error)
 		return error;
-	return 1;
+	return ret;
 }
 
 /*
@@ -1583,7 +1583,7 @@ xlog_write_log_records(
 	}
 
 out_free_buffer:
-	kmem_free(buffer);
+	kvfree(buffer);
 	return error;
 }
 
@@ -2182,7 +2182,7 @@ xlog_recover_add_to_trans(
 		"bad number of regions (%d) in inode log format",
 				  in_f->ilf_size);
 			ASSERT(0);
-			kmem_free(ptr);
+			kvfree(ptr);
 			return -EFSCORRUPTED;
 		}
 
@@ -2197,7 +2197,7 @@ xlog_recover_add_to_trans(
 	"log item region count (%d) overflowed size (%d)",
 				item->ri_cnt, item->ri_total);
 		ASSERT(0);
-		kmem_free(ptr);
+		kvfree(ptr);
 		return -EFSCORRUPTED;
 	}
 
@@ -2227,7 +2227,7 @@ xlog_recover_free_trans(
 		/* Free the regions in the item. */
 		list_del(&item->ri_list);
 		for (i = 0; i < item->ri_cnt; i++)
-			kmem_free(item->ri_buf[i].i_addr);
+			kvfree(item->ri_buf[i].i_addr);
 		/* Free the item itself */
 		kmem_free(item->ri_buf);
 		kmem_free(item);
@@ -3023,7 +3023,7 @@ xlog_do_recovery_pass(
 
 		hblks = xlog_logrec_hblks(log, rhead);
 		if (hblks != 1) {
-			kmem_free(hbp);
+			kvfree(hbp);
 			hbp = xlog_alloc_buffer(log, hblks);
 		}
 	} else {
@@ -3037,7 +3037,7 @@ xlog_do_recovery_pass(
 		return -ENOMEM;
 	dbp = xlog_alloc_buffer(log, BTOBB(h_size));
 	if (!dbp) {
-		kmem_free(hbp);
+		kvfree(hbp);
 		return -ENOMEM;
 	}
 
@@ -3198,9 +3198,9 @@ xlog_do_recovery_pass(
 	}
 
  bread_err2:
-	kmem_free(dbp);
+	kvfree(dbp);
  bread_err1:
-	kmem_free(hbp);
+	kvfree(hbp);
 
 	/*
 	 * Submit buffers that have been added from the last record processed,
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index f1b2592238022..ea4daf3dc8f07 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -36,7 +36,7 @@ STATIC void
 xfs_cui_item_free(
 	struct xfs_cui_log_item	*cuip)
 {
-	kmem_free(cuip->cui_item.li_lv_shadow);
+	kvfree(cuip->cui_item.li_lv_shadow);
 	if (cuip->cui_format.cui_nextents > XFS_CUI_MAX_FAST_EXTENTS)
 		kmem_free(cuip);
 	else
@@ -207,7 +207,7 @@ xfs_cud_item_release(
 	struct xfs_cud_log_item	*cudp = CUD_ITEM(lip);
 
 	xfs_cui_release(cudp->cud_cuip);
-	kmem_free(cudp->cud_item.li_lv_shadow);
+	kvfree(cudp->cud_item.li_lv_shadow);
 	kmem_cache_free(xfs_cud_cache, cudp);
 }
 
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 5e8a02d2b045d..dd0a562ec79cc 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -36,7 +36,7 @@ STATIC void
 xfs_rui_item_free(
 	struct xfs_rui_log_item	*ruip)
 {
-	kmem_free(ruip->rui_item.li_lv_shadow);
+	kvfree(ruip->rui_item.li_lv_shadow);
 	if (ruip->rui_format.rui_nextents > XFS_RUI_MAX_FAST_EXTENTS)
 		kmem_free(ruip);
 	else
@@ -205,7 +205,7 @@ xfs_rud_item_release(
 	struct xfs_rud_log_item	*rudp = RUD_ITEM(lip);
 
 	xfs_rui_release(rudp->rud_ruip);
-	kmem_free(rudp->rud_item.li_lv_shadow);
+	kvfree(rudp->rud_item.li_lv_shadow);
 	kmem_cache_free(xfs_rud_cache, rudp);
 }
 
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 4bec890d93d2c..0ccadedfdb016 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -1185,10 +1185,10 @@ xfs_growfs_rt(
 	 */
 	if (rsum_cache != mp->m_rsum_cache) {
 		if (error) {
-			kmem_free(mp->m_rsum_cache);
+			kvfree(mp->m_rsum_cache);
 			mp->m_rsum_cache = rsum_cache;
 		} else {
-			kmem_free(rsum_cache);
+			kvfree(rsum_cache);
 		}
 	}
 
@@ -1433,7 +1433,7 @@ void
 xfs_rtunmount_inodes(
 	struct xfs_mount	*mp)
 {
-	kmem_free(mp->m_rsum_cache);
+	kvfree(mp->m_rsum_cache);
 	if (mp->m_rbmip)
 		xfs_irele(mp->m_rbmip);
 	if (mp->m_rsumip)
-- 
2.43.0




