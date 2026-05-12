Return-Path: <stable+bounces-246601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHXqAsVxA2q55wEAu9opvQ
	(envelope-from <stable+bounces-246601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:30:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 948E7527A96
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2871C31A83D6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E451136B043;
	Tue, 12 May 2026 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lnbn/PAk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E634405B;
	Tue, 12 May 2026 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609643; cv=none; b=KTOQ7AIX076iik3uYtWUiNHViSCtZNUCNBwSrBKi0Jdc50ElYg11U31wm/hTgY2LBRXPNnjCjdJAq+3TXIGCZcg21R0995xooZI8ueuN9WM0w4LUuTlnGOFryiHdcyJE3a4eVujhFUaPXdjO6ixA0DANu3qcDw+EwiNPF5Uv7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609643; c=relaxed/simple;
	bh=FtOdT7WoiA3KLOVYslWDAgrohCDES2RVqOzcxsQzanc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmqCD3RtyoiQ3HimlrDVvrpLm0TgPQ6dGbJoYEIxhCOv2p+E8MLbuK8ix+HJWbmpKeDrCW4uTMBblnZuAvpoXy94L0HPC1dWKtSKCvTfSf0BxDig682kE1rZ/ucJBsKFJXUKRJDgRn/F7Gv27Q0TgDggxijy7xE1nfImarnGPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lnbn/PAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1D8C2BCB0;
	Tue, 12 May 2026 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609643;
	bh=FtOdT7WoiA3KLOVYslWDAgrohCDES2RVqOzcxsQzanc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lnbn/PAkaG1wJla9ktgsvUIm6W37AaiiB3takBk/0sCguJ2K9MiYSfx1PlfQjnVKK
	 W1CpzNLn+d/UoizUVS3WQ+/XXxCI60SRazT7u3x2i/MstHM2yE4/qpB2On33iWLVDT
	 cg4NYSpsEQkA7icH9/Ea9sjVNjAHIyTIuvsI7Daw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 7.0 275/307] f2fs: refactor f2fs_move_node_folio function
Date: Tue, 12 May 2026 19:41:10 +0200
Message-ID: <20260512173945.929190763@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 948E7527A96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246601-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

commit 92c20989366e023b74fa0c1028af9436c1917dbf upstream.

This patch refactor the f2fs_move_node_folio() function. No logical
changes.

Cc: stable@kernel.org
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/node.c |   54 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1842,41 +1842,51 @@ redirty_out:
 	return false;
 }
 
-int f2fs_move_node_folio(struct folio *node_folio, int gc_type)
+static int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
+			bool mark_dirty, enum iostat_type io_type)
 {
 	int err = 0;
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL,
+		.nr_to_write = 1,
+	};
 
-	if (gc_type == FG_GC) {
-		struct writeback_control wbc = {
-			.sync_mode = WB_SYNC_ALL,
-			.nr_to_write = 1,
-		};
+	if (!sync_mode) {
+		/* set page dirty and write it */
+		if (!folio_test_writeback(node_folio))
+			folio_mark_dirty(node_folio);
+		goto out_folio;
+	}
 
-		f2fs_folio_wait_writeback(node_folio, NODE, true, true);
+	f2fs_folio_wait_writeback(node_folio, NODE, true, true);
 
+	if (mark_dirty)
 		folio_mark_dirty(node_folio);
+	else if (!folio_test_dirty(node_folio))
+		goto out_folio;
 
-		if (!folio_clear_dirty_for_io(node_folio)) {
-			err = -EAGAIN;
-			goto out_page;
-		}
-
-		if (!__write_node_folio(node_folio, false, NULL,
-					&wbc, false, FS_GC_NODE_IO, NULL))
-			err = -EAGAIN;
-		goto release_page;
-	} else {
-		/* set page dirty and write it */
-		if (!folio_test_writeback(node_folio))
-			folio_mark_dirty(node_folio);
+	if (!folio_clear_dirty_for_io(node_folio)) {
+		err = -EAGAIN;
+		goto out_folio;
 	}
-out_page:
+
+	if (!__write_node_folio(node_folio, false, NULL,
+				&wbc, false, FS_GC_NODE_IO, NULL))
+		err = -EAGAIN;
+	goto release_folio;
+out_folio:
 	folio_unlock(node_folio);
-release_page:
+release_folio:
 	f2fs_folio_put(node_folio, false);
 	return err;
 }
 
+int f2fs_move_node_folio(struct folio *node_folio, int gc_type)
+{
+	return f2fs_write_single_node_folio(node_folio, gc_type == FG_GC,
+			true, FS_GC_NODE_IO);
+}
+
 int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic,
 			unsigned int *seq_id)



