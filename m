Return-Path: <stable+bounces-210955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFXMFkwkcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-210955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:09:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC05BDA4
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7F7468F269
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3DA37E31E;
	Wed, 21 Jan 2026 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F6DNWoIy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF192F39C2;
	Wed, 21 Jan 2026 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019947; cv=none; b=LYFOgT7EITRB0J2p+uKBetXX9qD4ryRS2YzweoIyJ82k8MMPaUcQy5NsuJyI+RTRFAlK9p20S7WFiNHFhFzJFKwPIF4IwEcyh+f1v8Qif0ED0E6XT/qosBz4Ik5txJJC7YnSIyT9DbZzpSisZEnUNT2O2DWqHUnfoq9kR7I6+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019947; c=relaxed/simple;
	bh=qzty1l0qZdWaCQBToIT6UFBQB5yaivOZcyi3x62v2O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKYCBdMsS61tXNpSU2fi6RAM0ju9Q9JGRpDs66BFezTXtUGVmqBnq4XzTxUzBr5veDxQ7azGWsHquOSBFmGCWmZTHXVTxJXSkJsEUhq5cryhj2KX+O/rHlQEnGEC+VKhEtc8C13rxEONTkXqfYGANmHtzJd7alNu0qNHs48bDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F6DNWoIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE94EC4CEF1;
	Wed, 21 Jan 2026 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019947;
	bh=qzty1l0qZdWaCQBToIT6UFBQB5yaivOZcyi3x62v2O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6DNWoIyfsBDHmYxGWYNwp3ENofB+2NnwF8k5XSlSu5ZFTHDxetmaW+KLElx+3txR
	 iSvf3O343SdS+hHeIk4TOwSiK7YG9DWKziux2Dq23lCe0BTet9wjGsYNeyg8J7EFDK
	 CQd1g1dT2sgiCuEBPM/bblW7DDXUcLcmu+zFkCHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wang Zhaolong <wangzhaolong@huaweicloud.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 015/198] NFS: Fix a deadlock involving nfs_release_folio()
Date: Wed, 21 Jan 2026 19:14:03 +0100
Message-ID: <20260121181419.096184368@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210955-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 74DC05BDA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit cce0be6eb4971456b703aaeafd571650d314bcca ]

Wang Zhaolong reports a deadlock involving NFSv4.1 state recovery
waiting on kthreadd, which is attempting to reclaim memory by calling
nfs_release_folio(). The latter cannot make progress due to state
recovery being needed.

It seems that the only safe thing to do here is to kick off a writeback
of the folio, without waiting for completion, or else kicking off an
asynchronous commit.

Reported-by: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Fixes: 96780ca55e3c ("NFS: fix up nfs_release_folio() to try to release the page")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/file.c          |  3 ++-
 fs/nfs/nfstrace.h      |  3 +++
 fs/nfs/write.c         | 33 +++++++++++++++++++++++++++++++++
 include/linux/nfs_fs.h |  1 +
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d020aab40c64e..d1c138a416cfb 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -511,7 +511,8 @@ static bool nfs_release_folio(struct folio *folio, gfp_t gfp)
 		if ((current_gfp_context(gfp) & GFP_KERNEL) != GFP_KERNEL ||
 		    current_is_kswapd() || current_is_kcompactd())
 			return false;
-		if (nfs_wb_folio(folio->mapping->host, folio) < 0)
+		if (nfs_wb_folio_reclaim(folio->mapping->host, folio) < 0 ||
+		    folio_test_private(folio))
 			return false;
 	}
 	return nfs_fscache_release_folio(folio, gfp);
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 6ce55e8e6b67c..9f9ce4a565ea6 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1062,6 +1062,9 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 DEFINE_NFS_FOLIO_EVENT(nfs_aop_readpage);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_aop_readpage_done);
 
+DEFINE_NFS_FOLIO_EVENT(nfs_writeback_folio_reclaim);
+DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_reclaim_done);
+
 DEFINE_NFS_FOLIO_EVENT(nfs_writeback_folio);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_done);
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 336c510f37502..bf412455e8edf 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2024,6 +2024,39 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
 	return ret;
 }
 
+/**
+ * nfs_wb_folio_reclaim - Write back all requests on one page
+ * @inode: pointer to page
+ * @folio: pointer to folio
+ *
+ * Assumes that the folio has been locked by the caller
+ */
+int nfs_wb_folio_reclaim(struct inode *inode, struct folio *folio)
+{
+	loff_t range_start = folio_pos(folio);
+	size_t len = folio_size(folio);
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL,
+		.nr_to_write = 0,
+		.range_start = range_start,
+		.range_end = range_start + len - 1,
+		.for_sync = 1,
+	};
+	int ret;
+
+	if (folio_test_writeback(folio))
+		return -EBUSY;
+	if (folio_clear_dirty_for_io(folio)) {
+		trace_nfs_writeback_folio_reclaim(inode, range_start, len);
+		ret = nfs_writepage_locked(folio, &wbc);
+		trace_nfs_writeback_folio_reclaim_done(inode, range_start, len,
+						       ret);
+		return ret;
+	}
+	nfs_commit_inode(inode, 0);
+	return 0;
+}
+
 /**
  * nfs_wb_folio - Write back all requests on one page
  * @inode: pointer to page
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index c585939b6cd60..2cf490a3a239b 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -636,6 +636,7 @@ extern int  nfs_update_folio(struct file *file, struct folio *folio,
 extern int nfs_sync_inode(struct inode *inode);
 extern int nfs_wb_all(struct inode *inode);
 extern int nfs_wb_folio(struct inode *inode, struct folio *folio);
+extern int nfs_wb_folio_reclaim(struct inode *inode, struct folio *folio);
 int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(void);
-- 
2.51.0




