Return-Path: <stable+bounces-172018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A30B2F94C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD97B1CE5D20
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF8B2EF662;
	Thu, 21 Aug 2025 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/Q/9mIK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30932D3744
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781133; cv=none; b=aIOayVvDb+6I+uGDcKpEkiQxPGunVPbIGnsZR6hn7ynD0ak6fwXm3p/NdFY0JbTiaaSOwI+ziC2zOAm9R5O3/hefIfOIowISz5yxzguvXJvDciM9R9cqxdArQHVECSps2kyCugg9/UMVQzl2m2LoLfcIMZGOQjHpAVSRx4jMxkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781133; c=relaxed/simple;
	bh=gkZFkf7hU/lqvS3H5EdPnX9yBVMl7JL7/en0mAUZO/g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Op0jZ1+WD8Ua3FkRvVwuojhASPKB1aqlNFvJFXrFgnN1ZxR2PD+oDk5CWtv75Q9P2bMxvgyY7s9npba6A6fTvP1uV4Y0XrmfBMDlBeNi7s/YAhgbFRm/Xba0TJCXVG1xc6MlZvNZELS6xV0LDUibBhOnDTvCfGXfxYnNK/6/2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/Q/9mIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AC7C4CEEB;
	Thu, 21 Aug 2025 12:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755781132;
	bh=gkZFkf7hU/lqvS3H5EdPnX9yBVMl7JL7/en0mAUZO/g=;
	h=Subject:To:Cc:From:Date:From;
	b=E/Q/9mIK41ra+ikk3/koIT21iC2tcg9eSalnBQitYoG6AH24ClUNX/1kgpK+fye+k
	 shrpSdnpqThl43E+9NsgHhKLjJj1uG1P3vWmmCjbDyl+Yb12Tp6nEYPkocj5aww8zJ
	 pc6sc684HxzU4GTt5C5mpj6qezPnP1ufBp5NAq+g=
Subject: FAILED: patch "[PATCH] ext4: preserve SB_I_VERSION on remount" failed to apply to 6.1-stable tree
To: libaokun1@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:58:39 +0200
Message-ID: <2025082139-grudging-earplugs-9567@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f2326fd14a224e4cccbab89e14c52279ff79b7ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082139-grudging-earplugs-9567@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2326fd14a224e4cccbab89e14c52279ff79b7ec Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun1@huawei.com>
Date: Thu, 3 Jul 2025 15:39:03 +0800
Subject: [PATCH] ext4: preserve SB_I_VERSION on remount

IMA testing revealed that after an ext4 remount, file accesses triggered
full measurements even without modifications, instead of skipping as
expected when i_version is unchanged.

Debugging showed `SB_I_VERSION` was cleared in reconfigure_super() during
remount due to commit 1ff20307393e ("ext4: unconditionally enable the
i_version counter") removing the fix from commit 960e0ab63b2e ("ext4: fix
i_version handling on remount").

To rectify this, `SB_I_VERSION` is always set for `fc->sb_flags` in
ext4_init_fs_context(), instead of `sb->s_flags` in __ext4_fill_super(),
ensuring it persists across all mounts.

Cc: stable@kernel.org
Fixes: 1ff20307393e ("ext4: unconditionally enable the i_version counter")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250703073903.6952-2-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9203518786e4..ed1b36bd51c8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1998,6 +1998,9 @@ int ext4_init_fs_context(struct fs_context *fc)
 	fc->fs_private = ctx;
 	fc->ops = &ext4_context_ops;
 
+	/* i_version is always enabled now */
+	fc->sb_flags |= SB_I_VERSION;
+
 	return 0;
 }
 
@@ -5316,9 +5319,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 
-	/* i_version is always enabled now */
-	sb->s_flags |= SB_I_VERSION;
-
 	/* HSM events are allowed by default. */
 	sb->s_iflags |= SB_I_ALLOW_HSM;
 


