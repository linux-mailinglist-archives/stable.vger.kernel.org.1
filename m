Return-Path: <stable+bounces-78506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F798BEB8
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250841F22483
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA711C68B4;
	Tue,  1 Oct 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vvOr1x+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4361C68AF
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791081; cv=none; b=fTRU0hDVaqj1Nl4hBu0OvzahpuSBujkKISxnpTHdEJtLlpsWN7W49Dc6+yppmx1XH1BzphSQgHRvGAwcReoBckJ6upanlAKg6S2vRKkrhjoOkEzLFcZ73m2azPWsq1SROJu9UYFFY1EhmXsOgrbEjKceQwPokpo0CjudXjeWZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791081; c=relaxed/simple;
	bh=WLGr1/bEt/p71G4IukBBzioAqzgYiNbwGTMDn8CL+4w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mmYTr2mka/eKD6XyyabJje1N97Y6IN3M0yWfZRz/5BKdICDsrXv+6WKr3Xi5/DHJrtebjKRCCqSyx7/j6EFftWM+2oX6nYKOfSDxUVQrgZtUsV+YmLXoj/ujm92Y86G9+Ytjif9kz8EA63P68NfhjWXB11CgoUPRFD9c7oSqAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vvOr1x+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF2AC4CEC6;
	Tue,  1 Oct 2024 13:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791081;
	bh=WLGr1/bEt/p71G4IukBBzioAqzgYiNbwGTMDn8CL+4w=;
	h=Subject:To:Cc:From:Date:From;
	b=vvOr1x+4uZLCF/wNgHbtAcBxA3qGD0y+bsUDWUT+iNgII9K8zNCsa2it4eF8kPeEj
	 30VYBTBD7S1y+Fovhghq5qVplXH6VghrpLtv2JilkkkFs544XlbdPg5lxdDR/2aay+
	 1Ft9UMUfCicXnXSfdRcs+J+GMMM4w9YzfxwiIJLs=
Subject: FAILED: patch "[PATCH] f2fs: fix several potential integer overflows in file offsets" failed to apply to 5.4-stable tree
To: n.zhandarovich@fintech.ru,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 15:57:48 +0200
Message-ID: <2024100147-unsolved-revision-357a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 1cade98cf6415897bf9342ee451cc5b40b58c638
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100147-unsolved-revision-357a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


