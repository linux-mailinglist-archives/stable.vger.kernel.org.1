Return-Path: <stable+bounces-112163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01602A273FD
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43EAE164B91
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4047C2135D1;
	Tue,  4 Feb 2025 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ifoPJwNF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA50D211A22
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677693; cv=none; b=py3l9Jus1ekBro4xuK50bk0tfl4jxZm8cu2ko+B5UrAju6Ri14rBtZtMjo/K750u3+sxJZ9M/ii4hbqmh8ZM3KZ9OT8gEUZgS3SCAfPjqJlCi/QMbUa+wgkA5A1Nr0Pz9vsvYUs6d35sSe3Dz3FFXT5CGQgHY0KwyTzkT6xJaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677693; c=relaxed/simple;
	bh=G8jgBkZzJwWH6Anb9J21Z57hDv1IMTWnylGyi5Mppmk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=abZrlwGepAmpWSVLV3WX4AcOUhmURI2MCu23dPEq4xtbzy4T6mFCg71JqL7z4sJFTFSszUdvrtwnmM3NmBFoU2St3uJBjF9tEPTNyJdLCOYhv7/zdMp4xRXNBL8v31P9AaSE4SGsyD4XT1UHRlASgTUol4PbS1qf/kNGU5FFPug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ifoPJwNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544F0C4CEDF;
	Tue,  4 Feb 2025 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738677692;
	bh=G8jgBkZzJwWH6Anb9J21Z57hDv1IMTWnylGyi5Mppmk=;
	h=Subject:To:Cc:From:Date:From;
	b=ifoPJwNFJOiLNUKj+rcUaAh+pCichhLxMLosjmTvvpunmVtOc3MhgikIN8mXodC2e
	 TH+7mFn029R05Cl1pPZu6DQIruQ95C6HtOxBhxNvdsaPPi1J89CidURS4Q2gdMreXX
	 bRekkcWX6YRlQW+zVkLpKHSrq3nDKPyj0WKwJD3g=
Subject: FAILED: patch "[PATCH] xfs: don't over-report free space or inodes in statvfs" failed to apply to 5.15-stable tree
To: djwong@kernel.org,eflorac@intellique.com,hch@lst.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Feb 2025 15:01:16 +0100
Message-ID: <2025020416-throng-creamer-864c@gregkh>
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
git cherry-pick -x 4b8d867ca6e2fc6d152f629fdaf027053b81765a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020416-throng-creamer-864c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4b8d867ca6e2fc6d152f629fdaf027053b81765a Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Thu, 12 Dec 2024 14:37:56 -0800
Subject: [PATCH] xfs: don't over-report free space or inodes in statvfs

Emmanual Florac reports a strange occurrence when project quota limits
are enabled, free space is lower than the remaining quota, and someone
runs statvfs:

  # mkfs.xfs -f /dev/sda
  # mount /dev/sda /mnt -o prjquota
  # xfs_quota  -x -c 'limit -p bhard=2G 55' /mnt
  # mkdir /mnt/dir
  # xfs_io -c 'chproj 55' -c 'chattr +P' -c 'stat -vvvv' /mnt/dir
  # fallocate -l 19g /mnt/a
  # df /mnt /mnt/dir
  Filesystem      Size  Used Avail Use% Mounted on
  /dev/sda         20G   20G  345M  99% /mnt
  /dev/sda        2.0G     0  2.0G   0% /mnt

I think the bug here is that xfs_fill_statvfs_from_dquot unconditionally
assigns to f_bfree without checking that the filesystem has enough free
space to fill the remaining project quota.  However, this is a
longstanding behavior of xfs so it's unclear what to do here.

Cc: <stable@vger.kernel.org> # v2.6.18
Fixes: 932f2c323196c2 ("[XFS] statvfs component of directory/project quota support, code originally by Glen.")
Reported-by: Emmanuel Florac <eflorac@intellique.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

diff --git a/fs/xfs/xfs_qm_bhv.c b/fs/xfs/xfs_qm_bhv.c
index 847ba29630e9..db5b8afd9d1b 100644
--- a/fs/xfs/xfs_qm_bhv.c
+++ b/fs/xfs/xfs_qm_bhv.c
@@ -32,21 +32,28 @@ xfs_fill_statvfs_from_dquot(
 	limit = blkres->softlimit ?
 		blkres->softlimit :
 		blkres->hardlimit;
-	if (limit && statp->f_blocks > limit) {
-		statp->f_blocks = limit;
-		statp->f_bfree = statp->f_bavail =
-			(statp->f_blocks > blkres->reserved) ?
-			 (statp->f_blocks - blkres->reserved) : 0;
+	if (limit) {
+		uint64_t	remaining = 0;
+
+		if (limit > blkres->reserved)
+			remaining = limit - blkres->reserved;
+
+		statp->f_blocks = min(statp->f_blocks, limit);
+		statp->f_bfree = min(statp->f_bfree, remaining);
+		statp->f_bavail = min(statp->f_bavail, remaining);
 	}
 
 	limit = dqp->q_ino.softlimit ?
 		dqp->q_ino.softlimit :
 		dqp->q_ino.hardlimit;
-	if (limit && statp->f_files > limit) {
-		statp->f_files = limit;
-		statp->f_ffree =
-			(statp->f_files > dqp->q_ino.reserved) ?
-			 (statp->f_files - dqp->q_ino.reserved) : 0;
+	if (limit) {
+		uint64_t	remaining = 0;
+
+		if (limit > dqp->q_ino.reserved)
+			remaining = limit - dqp->q_ino.reserved;
+
+		statp->f_files = min(statp->f_files, limit);
+		statp->f_ffree = min(statp->f_ffree, remaining);
 	}
 }
 


