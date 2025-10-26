Return-Path: <stable+bounces-189778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1108CC0A9C6
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36D963495F0
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EB6246BA9;
	Sun, 26 Oct 2025 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m3UbyFjF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1B215191
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488661; cv=none; b=REaEMapziOJyriVoRQHrxHJllTjPGGdWGXk40faOvixt1BGKpy8VDG9JGz0ZRaoMG/04CBYdOo1BRykkG7kscZ69F8TpsXMVEijmof45MOdVGZssosUmpBoA/JZn3Z4dPuvMxf24e8YK9xREJWGyybIie9KYyvVSfCyzehbsR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488661; c=relaxed/simple;
	bh=kbZH0dUBukePVEM1RwZUExcAdBM5ZISox1sHvk4KRU4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qNcQLftt8FsT5jTNKdmKgi4g4Myld0mx4PHHZwtd+3nPoSh8IN1nsToSj8TK+OAi74mR5lGUdALFYRUBEG6vUg8Bz+deYNLGX4uQ3DXWKg+QHBOA4iIxIoQ6K/FzsIbVjPGq124IYnzfNu6Gz8Pux1xvxabJH8w66OS7iPif2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m3UbyFjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F1C4CEFB;
	Sun, 26 Oct 2025 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761488660;
	bh=kbZH0dUBukePVEM1RwZUExcAdBM5ZISox1sHvk4KRU4=;
	h=Subject:To:Cc:From:Date:From;
	b=m3UbyFjFz5we0Iyz/hIRW7ZoUUQVultTcTS0wUFB8GGymC31wjq74AtZYSr0Mb80U
	 o/GbirKoUxJa75x5qtEHjvFZOwoo2qWJbio69i52SuhmfNDXLmF6ZouliwG/FpjhWg
	 n3P/xZYvwgjAmInL1ifsLntGWlvZ/Mfki7fqo45g=
Subject: FAILED: patch "[PATCH] xfs: always warn about deprecated mount options" failed to apply to 5.10-stable tree
To: djwong@kernel.org,cem@kernel.org,cmaiolino@redhat.com,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:24:17 +0100
Message-ID: <2025102617-untrimmed-ideally-b80b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 630785bfbe12c3ee3ebccd8b530a98d632b7e39d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102617-untrimmed-ideally-b80b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 630785bfbe12c3ee3ebccd8b530a98d632b7e39d Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Tue, 21 Oct 2025 11:30:12 -0700
Subject: [PATCH] xfs: always warn about deprecated mount options

The deprecation of the 'attr2' mount option in 6.18 wasn't entirely
successful because nobody noticed that the kernel never printed a
warning about attr2 being set in fstab if the only xfs filesystem is the
root fs; the initramfs mounts the root fs with no mount options; and the
init scripts only conveyed the fstab options by remounting the root fs.

Fix this by making it complain all the time.

Cc: stable@vger.kernel.org # v5.13
Fixes: 92cf7d36384b99 ("xfs: Skip repetitive warnings about mount options")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 9d51186b24dd..c53f2edf92e7 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1379,16 +1379,25 @@ suffix_kstrtoull(
 static inline void
 xfs_fs_warn_deprecated(
 	struct fs_context	*fc,
-	struct fs_parameter	*param,
-	uint64_t		flag,
-	bool			value)
+	struct fs_parameter	*param)
 {
-	/* Don't print the warning if reconfiguring and current mount point
-	 * already had the flag set
+	/*
+	 * Always warn about someone passing in a deprecated mount option.
+	 * Previously we wouldn't print the warning if we were reconfiguring
+	 * and current mount point already had the flag set, but that was not
+	 * the right thing to do.
+	 *
+	 * Many distributions mount the root filesystem with no options in the
+	 * initramfs and rely on mount -a to remount the root fs with the
+	 * options in fstab.  However, the old behavior meant that there would
+	 * never be a warning about deprecated mount options for the root fs in
+	 * /etc/fstab.  On a single-fs system, that means no warning at all.
+	 *
+	 * Compounding this problem are distribution scripts that copy
+	 * /proc/mounts to fstab, which means that we can't remove mount
+	 * options unless we're 100% sure they have only ever been advertised
+	 * in /proc/mounts in response to explicitly provided mount options.
 	 */
-	if ((fc->purpose & FS_CONTEXT_FOR_RECONFIGURE) &&
-            !!(XFS_M(fc->root->d_sb)->m_features & flag) == value)
-		return;
 	xfs_warn(fc->s_fs_info, "%s mount option is deprecated.", param->key);
 }
 


