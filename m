Return-Path: <stable+bounces-128894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D68A7FB2F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB99421BFE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539FB264F90;
	Tue,  8 Apr 2025 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uccYrgHE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B298488
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106756; cv=none; b=asuMsl/ImrAFZprWlmZ1eKgaCdT2zAsXK0pl7OUvDlu52AbO7WHzg3ECuD/w0mcs/dJyfpZMrA+PU+EmjKK3AYUxpUfzsvqFUeFAigYCMDOgjFMgiR4EVdJrFKTil4bxHpCu0ypN5pVqYsx7HxJoOFnlPGnXum3+zpf1nabqT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106756; c=relaxed/simple;
	bh=aGJRq8pbqoLaP/ahTYuw/OraiMfDo08IW8EAaNA4t2s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VtbpEBmZ02xSMsliz/x8vh+PLoldbQEomV7wIlGIhDjCVD4a/ZSCU4wGgUq2bHiUrgp/Tup8tme9+DOTNbLR2EME0a9Q3AkDw/MPRbACwHlxYc+BwbT8OHtm+XMIp9gqfQLyy3JrqjR7+gV1NBaYe1SaWFYpQsZve1n9p94NVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uccYrgHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CCBC4CEE5;
	Tue,  8 Apr 2025 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744106755;
	bh=aGJRq8pbqoLaP/ahTYuw/OraiMfDo08IW8EAaNA4t2s=;
	h=Subject:To:Cc:From:Date:From;
	b=uccYrgHEsP6IVxngLSQEG/jDh9jynN4RySXoWcKBjR3wsUg3C2XANd224lhYutPsp
	 8aWJWf65PQhudPh8H58s0Ug/XI74cm5UOAXeZ2uaiX1Xp6dobFQGZS8pX7s5fl5cmn
	 EnkbQm17smC360DPtf/PC3S09rpsQwxaNtyKPDvA=
Subject: FAILED: patch "[PATCH] ext4: don't over-report free space or inodes in statvfs" failed to apply to 5.4-stable tree
To: tytso@mit.edu,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:04:22 +0200
Message-ID: <2025040822-saline-starring-eabe@gregkh>
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
git cherry-pick -x f87d3af7419307ae26e705a2b2db36140db367a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040822-saline-starring-eabe@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f87d3af7419307ae26e705a2b2db36140db367a2 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 14 Mar 2025 00:38:42 -0400
Subject: [PATCH] ext4: don't over-report free space or inodes in statvfs

This fixes an analogus bug that was fixed in xfs in commit
4b8d867ca6e2 ("xfs: don't over-report free space or inodes in
statvfs") where statfs can report misleading / incorrect information
where project quota is enabled, and the free space is less than the
remaining quota.

This commit will resolve a test failure in generic/762 which tests for
this bug.

Cc: stable@kernel.org
Fixes: 689c958cbe6b ("ext4: add project quota support")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4768770715ca..8cafcd3e9f5f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6820,22 +6820,29 @@ static int ext4_statfs_project(struct super_block *sb,
 			     dquot->dq_dqb.dqb_bhardlimit);
 	limit >>= sb->s_blocksize_bits;
 
-	if (limit && buf->f_blocks > limit) {
+	if (limit) {
+		uint64_t	remaining = 0;
+
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
+		uint64_t	remaining = 0;
+
+		if (limit > dquot->dq_dqb.dqb_curinodes)
+			remaining = limit - dquot->dq_dqb.dqb_curinodes;
+
+		buf->f_files = min(buf->f_files, limit);
+		buf->f_ffree = min(buf->f_ffree, remaining);
 	}
 
 	spin_unlock(&dquot->dq_dqb_lock);


