Return-Path: <stable+bounces-172017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE16B2F94B
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707E2189C2CC
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D47931DDB2;
	Thu, 21 Aug 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZJreoM/w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B231AF38
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781130; cv=none; b=kTvKfjCxPzXRdXpT7I3OnbDzyUhe0Ryiu3CRsj6HGZy3hy+Fo3AAyah+2RglCiFP5JE29/QvJbwUpLQ9KNvFNY5k+fkKzmy/WqvKTS5IQ9MYtVzWPflmDDM7anBBBGtazYI9GJe03MMvoVIL84oHhejWfhirXubd9iLkKW2QhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781130; c=relaxed/simple;
	bh=N9ao8iT9Ul3ofjDHfucd79j4nvLKjsLRErYJXhgN2GY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WvnwXM7dpoDC+c+H4JTxirxYJb8PzQDf1/KdbjyHtpd1Y+sGoL711lfvFACuN851t6tQPKb7TPl+hLh+tgFyejdkfzVWy0cTiyhbTCZr1h+tRpQAoVEQ8muTGghTv0GNHEbKLfynfX3yeI1oXMUvR8MuWCNaquY5C7g4C7Sv64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZJreoM/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F74C4CEEB;
	Thu, 21 Aug 2025 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755781129;
	bh=N9ao8iT9Ul3ofjDHfucd79j4nvLKjsLRErYJXhgN2GY=;
	h=Subject:To:Cc:From:Date:From;
	b=ZJreoM/wD2BwVyqBrpLVv1bfFAcr37p2jdgv0oHhCReadJLP3wfeZn0PzJx2Z88TY
	 6e+DE3xgBVf8/OLxltUSbaW2QxtFbubrwNW9xYo+jaxmeWZQ4s4ykPGMsh653OGrBH
	 KT8swizK5652u77kS5akjCLqv/7WFvxtqRrRvyZA=
Subject: FAILED: patch "[PATCH] ext4: preserve SB_I_VERSION on remount" failed to apply to 6.6-stable tree
To: libaokun1@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:58:38 +0200
Message-ID: <2025082138-barracuda-engorge-cf38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f2326fd14a224e4cccbab89e14c52279ff79b7ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082138-barracuda-engorge-cf38@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


