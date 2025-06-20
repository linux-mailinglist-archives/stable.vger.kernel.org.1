Return-Path: <stable+bounces-154998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7033AE1615
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B629419E5CB1
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC0824291B;
	Fri, 20 Jun 2025 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gDIXz1bm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F72417C8
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408214; cv=none; b=fPDRCMmFY1ZghzRRPv1gO1Q8n9T+ai/QoMMby0w4CWqPwdNkbtBDhPi2vemx3wVKGRClYh6X0RvKqq9fgchgXyk64ZZ1ZCAf/FbmPokCQoW5aHvy7sRx1Ja/j21G0pbm42KlmhCuIhtbfiL+fJVnqwOq0k9qpZwYYLF0xbQuhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408214; c=relaxed/simple;
	bh=KvXCLL4GIBxO7ttWP7V6vf2zV8q9okk+qfd0RX05Yvw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sRmO09RaoI2XX/FCq3jAZI3hoefvFF+QTvM91YtANy15C3Kbpz2VCl8c4ToypuddeTDe3boWNgXvXDWsQcMfGTjVQKmQC1H43r8t+xLSlc+MPsh9DvwExSCSFpwiRciM5Vo3SkThq+sEnbajI4/lTPxdAE2kGTEcmeMoLCqSugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gDIXz1bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797AEC4CEF0;
	Fri, 20 Jun 2025 08:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750408214;
	bh=KvXCLL4GIBxO7ttWP7V6vf2zV8q9okk+qfd0RX05Yvw=;
	h=Subject:To:Cc:From:Date:From;
	b=gDIXz1bmkxStRv1qqJ5Y/IA2mT5pRe/TPf41t2UDSRqKbptMM5FI8S8cHWsT/GoY0
	 jpkc8bHLeo97BVVML29dMccMSVBnwSoDEL+He7zwuHN8LIzbJwJwnhO7HWBZK90r7E
	 cE88qq7i2FBSHYxHsHnFFDV4SpChiCHrF6rLEukA=
Subject: FAILED: patch "[PATCH] f2fs: don't over-report free space or inodes in statvfs" failed to apply to 5.15-stable tree
To: chao@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 10:29:52 +0200
Message-ID: <2025062052-clamp-tried-33e9@gregkh>
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
git cherry-pick -x a9201960623287927bf5776de3f70fb2fbde7e02
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062052-clamp-tried-33e9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


