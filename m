Return-Path: <stable+bounces-154999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E55AE160F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722F6173685
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D70D244678;
	Fri, 20 Jun 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H+pwUwX/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57898244660
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408217; cv=none; b=Kfzc1jI94bELhJfOfzdgAjY3CRgBGm07iQ/Uuu7GxixoR0D6n5j/pcYzki71bKrOf46cYSBKCiFRcIQ6U4ODzBQ1BG3eYP9eFu48tgxFO9kVFebSt3SQ4ac84rMtRKmUp4g52i4QSJdPaZDwZAHl++fJZVEgrTUcySZmrTAgFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408217; c=relaxed/simple;
	bh=ICd0kwe+oF6H6IP9swaTblQMtUwWQaWIHu/dJpeuVBg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ID6E4zdmH9Xz/4ngu27SeUlB5/DLYqCG7iLMfVBu9C6IYWRlB8kmfMGdF4mqrb9KKgVDxJOknAwTo6QGWJlM1g7CWZHOTsPH++PJret3i4Xdlh13YWoH1vdLTiy4wG+fm5UT1S15vGps/OJpfxaIDVaEB0Im2on6FxQ9NNWURqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H+pwUwX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8214AC4CEF3;
	Fri, 20 Jun 2025 08:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750408216;
	bh=ICd0kwe+oF6H6IP9swaTblQMtUwWQaWIHu/dJpeuVBg=;
	h=Subject:To:Cc:From:Date:From;
	b=H+pwUwX/+eTIfR6W+OcWNVLD6qbP0F1SdO2oaaTY1bqCpE8vLLbFbJsx45QwcWTcQ
	 7qVKtLJbjQ+EjIRC6Y5fXnU+JiOTiE8tZfXcl+dhigZcczD3d6jB6mvGb2jrTVfKnE
	 qbnzfHekNEBbWfgGihhhnD8z4mvMpKe2iNcOMOWw=
Subject: FAILED: patch "[PATCH] f2fs: don't over-report free space or inodes in statvfs" failed to apply to 5.4-stable tree
To: chao@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 10:29:53 +0200
Message-ID: <2025062053-frenzy-grill-65e2@gregkh>
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
git cherry-pick -x a9201960623287927bf5776de3f70fb2fbde7e02
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062053-frenzy-grill-65e2@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9201960623287927bf5776de3f70fb2fbde7e02 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Tue, 13 May 2025 19:25:38 +0800
Subject: [PATCH] f2fs: don't over-report free space or inodes in statvfs

This fixes an analogus bug that was fixed in modern filesystems:
a) xfs in commit 4b8d867ca6e2 ("xfs: don't over-report free space or
inodes in statvfs")
b) ext4 in commit f87d3af74193 ("ext4: don't over-report free space
or inodes in statvfs")
where statfs can report misleading / incorrect information where
project quota is enabled, and the free space is less than the
remaining quota.

This commit will resolve a test failure in generic/762 which tests
for this bug.

generic/762       - output mismatch (see /share/git/fstests/results//generic/762.out.bad)
    --- tests/generic/762.out   2025-04-15 10:21:53.371067071 +0800
    +++ /share/git/fstests/results//generic/762.out.bad 2025-05-13 16:13:37.000000000 +0800
    @@ -6,8 +6,10 @@
     root blocks2 is in range
     dir blocks2 is in range
     root bavail2 is in range
    -dir bavail2 is in range
    +dir bavail2 has value of 1539066
    +dir bavail2 is NOT in range 304734.87 .. 310891.13
     root blocks3 is in range
    ...
    (Run 'diff -u /share/git/fstests/tests/generic/762.out /share/git/fstests/results//generic/762.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      XXXXXXXXXXXXXX xfs: don't over-report free space or inodes in statvfs

Cc: stable@kernel.org
Fixes: ddc34e328d06 ("f2fs: introduce f2fs_statfs_project")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b65d24a39d03..6744b8c65bc8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1808,26 +1808,32 @@ static int f2fs_statfs_project(struct super_block *sb,
 
 	limit = min_not_zero(dquot->dq_dqb.dqb_bsoftlimit,
 					dquot->dq_dqb.dqb_bhardlimit);
-	if (limit)
-		limit >>= sb->s_blocksize_bits;
+	limit >>= sb->s_blocksize_bits;
+
+	if (limit) {
+		uint64_t remaining = 0;
 
-	if (limit && buf->f_blocks > limit) {
 		curblock = (dquot->dq_dqb.dqb_curspace +
 			    dquot->dq_dqb.dqb_rsvspace) >> sb->s_blocksize_bits;
-		buf->f_blocks = limit;
-		buf->f_bfree = buf->f_bavail =
-			(buf->f_blocks > curblock) ?
-			 (buf->f_blocks - curblock) : 0;
+		if (limit > curblock)
+			remaining = limit - curblock;
+
+		buf->f_blocks = min(buf->f_blocks, limit);
+		buf->f_bfree = min(buf->f_bfree, remaining);
+		buf->f_bavail = min(buf->f_bavail, remaining);
 	}
 
 	limit = min_not_zero(dquot->dq_dqb.dqb_isoftlimit,
 					dquot->dq_dqb.dqb_ihardlimit);
 
-	if (limit && buf->f_files > limit) {
-		buf->f_files = limit;
-		buf->f_ffree =
-			(buf->f_files > dquot->dq_dqb.dqb_curinodes) ?
-			 (buf->f_files - dquot->dq_dqb.dqb_curinodes) : 0;
+	if (limit) {
+		uint64_t remaining = 0;
+
+		if (limit > dquot->dq_dqb.dqb_curinodes)
+			remaining = limit - dquot->dq_dqb.dqb_curinodes;
+
+		buf->f_files = min(buf->f_files, limit);
+		buf->f_ffree = min(buf->f_ffree, remaining);
 	}
 
 	spin_unlock(&dquot->dq_dqb_lock);


