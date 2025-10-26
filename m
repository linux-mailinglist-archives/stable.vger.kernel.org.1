Return-Path: <stable+bounces-189815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75DC0AA86
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E3E3B2964
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193E924CEEA;
	Sun, 26 Oct 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YEQHgh3V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96C245028
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761489481; cv=none; b=VGZTMtcPzA997+URVdh56PQaDa04n2+iZLYHpS0hainTjQ/r0GzTZ7HQE+YpyQarreI+IsGTXhc1ryg8uxUOyjxe58Z8uMZo+wHOhqXm5VvVMXIEdEZCGMnjKvxQA3uh4B/8T/XoHeHPGMIg2iHEt9qaH8kqHzgVVgiMJ+SiXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761489481; c=relaxed/simple;
	bh=gPmegGdIDaLqSfY+y1oqLxj89Ca5tE4Ge2U4QRmShaU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hvRNjW5Bjvuxb4w/vGy8J+XismtJTZgCl3gIhQku02UXtESHQ2I4luSs/fo8kaxuuc52qeo9xRCw4fICAcbkGQQ/C5A8oeXIziB+Ifj+CRMtvpJLnUdE3Ib/wN/fUT5x5j9AwtfYIQx/orElL6zWWYwR7QtPGUasmcgdlMUYDV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YEQHgh3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0707AC4CEE7;
	Sun, 26 Oct 2025 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761489481;
	bh=gPmegGdIDaLqSfY+y1oqLxj89Ca5tE4Ge2U4QRmShaU=;
	h=Subject:To:Cc:From:Date:From;
	b=YEQHgh3VrjlMoblbDzNk5qNXP/6AsKUW+0st+NFynCHpbbkTIJhVhTiuUm46l1xY3
	 4CyDPIxHqI+QikCAgopLTSFCmHSBbn04y81HhDlzKOGqs1qzUCWdOUMhrN1ojy+WeI
	 OrIXZbBykFllLf8lO6dfEYiSQjS7PLA+ekZDlWn8=
Subject: FAILED: patch "[PATCH] xfs: always warn about deprecated mount options" failed to apply to 6.12-stable tree
To: djwong@kernel.org,cem@kernel.org,cmaiolino@redhat.com,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:37:45 +0100
Message-ID: <2025102645-oblivion-whoopee-576c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 630785bfbe12c3ee3ebccd8b530a98d632b7e39d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102645-oblivion-whoopee-576c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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
 


