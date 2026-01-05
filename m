Return-Path: <stable+bounces-204623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0E7CF2CF5
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 10:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AC673010E50
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E2432ED5C;
	Mon,  5 Jan 2026 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vARfMwsl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72632863E
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606046; cv=none; b=UWKMZsxtS10vo/g7eS9X17AODsUxxPtaWJLpfcjs6GmqR+t0HxYhxceE1vfJ7Lcr3Rd1f+rZWyVizJ0IfJF0e5MKMwQotkGiyMg474cXHPu8REbAExK0o20yJUUROH7Zn5oOVMjRrsjZVhs47s8o5yDoeg1ltEFify7bQWe5ixQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606046; c=relaxed/simple;
	bh=I/17Voj+XJS3R0th9JmhCVtOT+sCjm7G3sQLoQuxznk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kCsaaQlekeNi2lMDwLqkGOv2nGxMb4c88OV8xsDTx4SrfQRyGFtIA4Lxev4CmNOHZAZHY4W36a0FFQsjVR3K1JG3Ij36C5zAFhl0dl7lPUSLLGXbYQK/thoQA50H+IZFcZmFFc+12sAMDO673JXgkfyOzYEphjEcJhras9m23Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vARfMwsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08D7C116D0;
	Mon,  5 Jan 2026 09:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767606045;
	bh=I/17Voj+XJS3R0th9JmhCVtOT+sCjm7G3sQLoQuxznk=;
	h=Subject:To:Cc:From:Date:From;
	b=vARfMwsla/jvx2meIjuLMVU8UkhlT9Q5g7Zxe4MWedsivZbny/nIgVuf7v56hWbBY
	 1k31x5Zgjsc8cDUpLTawDuZDFQtRCtb9l9+oGIQIxVcaD2hdIlLFdfTdMl4F9+giym
	 78MURAqBY2T01uZvF+cfQCwwBTpN+djs+MmlpnCA=
Subject: FAILED: patch "[PATCH] ntfs: Do not overwrite uptodate pages" failed to apply to 5.15-stable tree
To: willy@infradead.org,almaz.alexandrovich@paragon-software.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 10:40:42 +0100
Message-ID: <2026010541-comply-poet-d4a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 68f6bd128e75a032432eda9d16676ed2969a1096
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010541-comply-poet-d4a1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 68f6bd128e75a032432eda9d16676ed2969a1096 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Fri, 18 Jul 2025 20:53:58 +0100
Subject: [PATCH] ntfs: Do not overwrite uptodate pages

When reading a compressed file, we may read several pages in addition to
the one requested.  The current code will overwrite pages in the page
cache with the data from disc which can definitely result in changes
that have been made being lost.

For example if we have four consecutie pages ABCD in the file compressed
into a single extent, on first access, we'll bring in ABCD.  Then we
write to page B.  Memory pressure results in the eviction of ACD.
When we attempt to write to page C, we will overwrite the data in page
B with the data currently on disk.

I haven't investigated the decompression code to check whether it's
OK to overwrite a clean page or whether it might be possible to see
corrupt data.  Out of an abundance of caution, decline to overwrite
uptodate pages, not just dirty pages.

Fixes: 4342306f0f0d (fs/ntfs3: Add file operations and implementation)
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: stable@vger.kernel.org
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index e1832b66718f..e44181185526 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2020,6 +2020,29 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	return err;
 }
 
+static struct page *ntfs_lock_new_page(struct address_space *mapping,
+		pgoff_t index, gfp_t gfp)
+{
+	struct folio *folio = __filemap_get_folio(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+	struct page *page;
+
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
+
+	if (!folio_test_uptodate(folio))
+		return folio_file_page(folio, index);
+
+	/* Use a temporary page to avoid data corruption */
+	folio_unlock(folio);
+	folio_put(folio);
+	page = alloc_page(gfp);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+	__SetPageLocked(page);
+	return page;
+}
+
 /*
  * ni_readpage_cmpr
  *
@@ -2074,9 +2097,9 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct folio *folio)
 		if (i == idx)
 			continue;
 
-		pg = find_or_create_page(mapping, index, gfp_mask);
-		if (!pg) {
-			err = -ENOMEM;
+		pg = ntfs_lock_new_page(mapping, index, gfp_mask);
+		if (IS_ERR(pg)) {
+			err = PTR_ERR(pg);
 			goto out1;
 		}
 		pages[i] = pg;
@@ -2175,13 +2198,13 @@ int ni_decompress_file(struct ntfs_inode *ni)
 		for (i = 0; i < pages_per_frame; i++, index++) {
 			struct page *pg;
 
-			pg = find_or_create_page(mapping, index, gfp_mask);
-			if (!pg) {
+			pg = ntfs_lock_new_page(mapping, index, gfp_mask);
+			if (IS_ERR(pg)) {
 				while (i--) {
 					unlock_page(pages[i]);
 					put_page(pages[i]);
 				}
-				err = -ENOMEM;
+				err = PTR_ERR(pg);
 				goto out;
 			}
 			pages[i] = pg;


