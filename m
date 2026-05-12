Return-Path: <stable+bounces-246283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EApIG35uA2pS5wEAu9opvQ
	(envelope-from <stable+bounces-246283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:16:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E5527336
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2DFC3085E85
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2583133DEF7;
	Tue, 12 May 2026 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1AfYj92T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0123EDE52;
	Tue, 12 May 2026 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608827; cv=none; b=gVL8XI5jr8YJOLqEOCEtUeL5ShS7j6/pWteP7n44XCov+en4mxSa0lUyPmUzQui9XTZ/4mG5DzvytfRhw5y+MocXG9Nw/tcTKDwXKMLY7ESiMzLiRHYTlvhdyb0CdfRN+pmzH6pJ4vB/SuXTnMyLMPSuf34v0qwbRmnJAWkG1dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608827; c=relaxed/simple;
	bh=d+6K/EId89ycKoGH5D3HuOg5feZNFYj2g+2zpdwoxGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCZqH2hP+lAlG/Di4Hqn5OTy0HwgecuifOj2TLss4XQvisDcpcntIMb6ym5QEkM1IUbfnyWZeT39IoajQjtSwQXgZ+Rw71Q7Xa3VckEw2GHYZPqWjiq6MDljJZxqQUdOp+dvy08NA8DKGJbcz8hTYYeLeNT/dNs41B6WjbD+vJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1AfYj92T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76477C2BCB0;
	Tue, 12 May 2026 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608827;
	bh=d+6K/EId89ycKoGH5D3HuOg5feZNFYj2g+2zpdwoxGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1AfYj92T6PrUTZ50VxQ3iZBK7E/TOBfbu/yhXYcm0KqV+cxpeqNtxzL5+8AYvcXZz
	 xEjE2EA62k0P2LYE2actrPq2IFzHMsdVlKJspZuXxfl4+v4EO/GyldE7iw0TRYjRh4
	 f68Chi3dqmVToKTRbupgqJDEAtDNHD6uuqKvSU3s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.18 230/270] f2fs: refactor f2fs_move_node_folio function
Date: Tue, 12 May 2026 19:40:31 +0200
Message-ID: <20260512173943.288009709@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: BD9E5527336
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246283-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,xiaomi.com:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1821,41 +1821,51 @@ redirty_out:
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



