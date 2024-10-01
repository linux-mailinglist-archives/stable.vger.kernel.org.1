Return-Path: <stable+bounces-78507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A0C98BEB9
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5966FB26462
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEAA1C6F48;
	Tue,  1 Oct 2024 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w1gKjuQS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801021C0DD1
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791084; cv=none; b=sHTnMmsI8m24KCYsnqFw42aHWVyziX62t19EYZTu9TORznDT5/CFWm3mPcKJegHo/HG3vEyjksO+y+ouJ2OXHv8JkLKVuZvkVrDlRyLG2aFLv113sEXdKUtHFHRy8GzbhNPk8RJK2Yu3dQYU0VuG8Vg1EVOisFNQQQQiuwgF4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791084; c=relaxed/simple;
	bh=Lm3jGgNHqhKa8Q6B4njWnP3CklTvSwlqMiuPR0sKNek=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cAPI6EuxRDXVOQ4xL2zrw7YbDFWgR2gXWVZ2rZFlNe9CZWSUeEpgbplamHFWM7nd56uIHkRb+1ydrl0EmM6ig+5KgKqq/1Yvx7dVhYegLD3cYwQ/p5x9V9HIWc4LreKrLza+ZoZ6Cyr+JDl204mtABxZRV1uVVRpCzjpR6aFvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w1gKjuQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB3BC4CEC7;
	Tue,  1 Oct 2024 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791084;
	bh=Lm3jGgNHqhKa8Q6B4njWnP3CklTvSwlqMiuPR0sKNek=;
	h=Subject:To:Cc:From:Date:From;
	b=w1gKjuQSZ/DprTPah5fil4w/k7td6z+eyTONJ+1etkzjXOFPzDVKTf1S+urj0XCQz
	 7U9ErksS5w3ErOZ15RO2PhNrZKt3eQ81NGKXjWLXABmQYU5Ba+9/0NLbFCMsfKSSc1
	 IM4hSIBFXsrDPjMg68Sjr2Dk7aWQlVi/cyNpGhqo=
Subject: FAILED: patch "[PATCH] f2fs: fix several potential integer overflows in file offsets" failed to apply to 4.19-stable tree
To: n.zhandarovich@fintech.ru,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 15:57:49 +0200
Message-ID: <2024100148-utensil-cornbread-3a99@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 1cade98cf6415897bf9342ee451cc5b40b58c638
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100148-utensil-cornbread-3a99@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

1cade98cf641 ("f2fs: fix several potential integer overflows in file offsets")
e7547daccd6a ("f2fs: refactor extent_cache to support for read and more")
749d543c0d45 ("f2fs: remove unnecessary __init_extent_tree")
3bac20a8f011 ("f2fs: move internal functions into extent_cache.c")
12607c1ba763 ("f2fs: specify extent cache for read explicitly")
544b53dadc20 ("f2fs: code clean and fix a type error")
a834aa3ec95b ("f2fs: add "c_len" into trace_f2fs_update_extent_tree_range for compressed file")
07725adc55c0 ("f2fs: fix race condition on setting FI_NO_EXTENT flag")
01fc4b9a6ed8 ("f2fs: use onstack pages instead of pvec")
4f8219f8aa17 ("f2fs: intorduce f2fs_all_cluster_page_ready")
054cb2891b9c ("f2fs: replace F2FS_I(inode) and sbi by the local variable")
3db1de0e582c ("f2fs: change the current atomic write way")
71419129625a ("f2fs: give priority to select unpinned section for foreground GC")
a9163b947ae8 ("f2fs: write checkpoint during FG_GC")
2aaf51dd39af ("f2fs: fix dereference of stale list iterator after loop body")
642c0969916e ("f2fs: don't set GC_FAILURE_PIN for background GC")
a22bb5526d7d ("f2fs: check pinfile in gc_data_segment() in advance")
6b1f86f8e9c7 ("Merge tag 'folio-5.18b' of git://git.infradead.org/users/willy/pagecache")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cade98cf6415897bf9342ee451cc5b40b58c638 Mon Sep 17 00:00:00 2001
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Date: Wed, 24 Jul 2024 10:28:38 -0700
Subject: [PATCH] f2fs: fix several potential integer overflows in file offsets

When dealing with large extents and calculating file offsets by
summing up according extent offsets and lengths of unsigned int type,
one may encounter possible integer overflow if the values are
big enough.

Prevent this from happening by expanding one of the addends to
(pgoff_t) type.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: d323d005ac4a ("f2fs: support file defragment")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index fd1fc06359ee..62ac440d9416 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -366,7 +366,7 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 static void __drop_largest_extent(struct extent_tree *et,
 					pgoff_t fofs, unsigned int len)
 {
-	if (fofs < et->largest.fofs + et->largest.len &&
+	if (fofs < (pgoff_t)et->largest.fofs + et->largest.len &&
 			fofs + len > et->largest.fofs) {
 		et->largest.len = 0;
 		et->largest_updated = true;
@@ -456,7 +456,7 @@ static bool __lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 
 	if (type == EX_READ &&
 			et->largest.fofs <= pgofs &&
-			et->largest.fofs + et->largest.len > pgofs) {
+			(pgoff_t)et->largest.fofs + et->largest.len > pgofs) {
 		*ei = et->largest;
 		ret = true;
 		stat_inc_largest_node_hit(sbi);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 168f08507004..c598cfe5e0ed 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2710,7 +2710,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	 * block addresses are continuous.
 	 */
 	if (f2fs_lookup_read_extent_cache(inode, pg_start, &ei)) {
-		if (ei.fofs + ei.len >= pg_end)
+		if ((pgoff_t)ei.fofs + ei.len >= pg_end)
 			goto out;
 	}
 


