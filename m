Return-Path: <stable+bounces-255368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCPlKwSiGGqblggAu9opvQ
	(envelope-from <stable+bounces-255368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:13:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1116D5F81CB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65B313232819
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04167409E1C;
	Thu, 28 May 2026 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IzdDOjU5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E833065C;
	Thu, 28 May 2026 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998713; cv=none; b=XaQslgM8WaKwgM/j+JPaZQUCbwmEjCCtl0ukjO43BVJmpUbOkB4C4yKXeM8Ox0RYoz54OSUMvBvaxTqXbD0whKaZB1LcwLa/JRkcqmbCtT8hoCmkmJAGUQ+msV4B7ZR7kouDr7i0cpXpkkE2CpbNkjkfs+JKNDCsp/+j0hK01pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998713; c=relaxed/simple;
	bh=rZi7BIY6KSq9sP+x3ZPQ6prc9h8upvnCe/ykifN9vEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3w7t8KIE3B26Sb5WKIXqoCDlbR2oNrlPX/ZQ8nsJdJ0Of/5Tw4sSAR0LHCixXu7hNFdXRBH+eCUJuv+YD95w7z+3rx0e7Re7/+HVkEKyI4got76ide4XEOvMBU1CrWDjrn3TZhNfHAjMtLuHY3CxLB3FPa5xV7VlU+/5dGKQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IzdDOjU5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0F61F000E9;
	Thu, 28 May 2026 20:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998712;
	bh=TrWz2AvGzVpJ0jRyFEiX52TuMClE7PYID+L/NfdGNHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IzdDOjU5rGj3/JyH1y6eX9qmz6HPtz0YXxKwcm348w0B8Pjd5vlD/gxpQhpBvBGwx
	 J7MjtDNzTyUd2oigP9nUV70qCm8nV6cRraG8AZKp2llHH1K2ctTrHo3wcqIhJjXxZz
	 bkRSeYrLvpE/8bl45JCRF5ltxMoUZ2VmQax5Wtr4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 270/461] netfs, afs: Fix write skipping in dir/link writepages
Date: Thu, 28 May 2026 21:46:39 +0200
Message-ID: <20260528194654.984963048@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255368-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,auristor.com:email,infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1116D5F81CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 9871938f99cc6cb266a77265491660e2375271f5 ]

Fix netfs_write_single() and afs_single_writepages() to better handle a
write that would be skipped due to lock contention and WB_SYNC_NONE by
returning 1 from netfs_write_single() if it skipped and making
afs_single_writepages() skip also.  If a skip occurs, the inode must be
re-marked as the VFS may have cleared the mark.

This is really only theoretical for directories in netfs_write_single() as
the only path to that is through afs_single_writepages() that takes the
->validate_lock around it, thereby serialising it.

Fixes: 6dd80936618c ("afs: Use netfslib for directories")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260512123404.719402-24-dhowells@redhat.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dir.c           | 11 ++++++++++-
 fs/netfs/write_issue.c |  7 ++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 78caef3f13388..068a892d39c4e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -2206,7 +2206,14 @@ int afs_single_writepages(struct address_space *mapping,
 	/* Need to lock to prevent the folio queue and folios from being thrown
 	 * away.
 	 */
-	down_read(&dvnode->validate_lock);
+	if (!down_read_trylock(&dvnode->validate_lock)) {
+		if (wbc->sync_mode == WB_SYNC_NONE) {
+			/* The VFS will have undirtied the inode. */
+			netfs_single_mark_inode_dirty(&dvnode->netfs.inode);
+			return 0;
+		}
+		down_read(&dvnode->validate_lock);
+	}
 
 	if (is_dir ?
 	    test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) :
@@ -2214,6 +2221,8 @@ int afs_single_writepages(struct address_space *mapping,
 		iov_iter_folio_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0,
 				     i_size_read(&dvnode->netfs.inode));
 		ret = netfs_writeback_single(mapping, wbc, &iter);
+		if (ret == 1)
+			ret = 0; /* Skipped write due to lock conflict. */
 	}
 
 	up_read(&dvnode->validate_lock);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 03961622996be..c03c7cc45e471 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -830,6 +830,9 @@ static int netfs_write_folio_single(struct netfs_io_request *wreq,
  *
  * Write a monolithic, non-pagecache object back to the server and/or
  * the cache.
+ *
+ * Return: 0 if successful; 1 if skipped due to lock conflict and WB_SYNC_NONE;
+ * or a negative error code.
  */
 int netfs_writeback_single(struct address_space *mapping,
 			   struct writeback_control *wbc,
@@ -846,8 +849,10 @@ int netfs_writeback_single(struct address_space *mapping,
 
 	if (!mutex_trylock(&ictx->wb_lock)) {
 		if (wbc->sync_mode == WB_SYNC_NONE) {
+			/* The VFS will have undirtied the inode. */
+			netfs_single_mark_inode_dirty(&ictx->inode);
 			netfs_stat(&netfs_n_wb_lock_skip);
-			return 0;
+			return 1;
 		}
 		netfs_stat(&netfs_n_wb_lock_wait);
 		mutex_lock(&ictx->wb_lock);
-- 
2.53.0




