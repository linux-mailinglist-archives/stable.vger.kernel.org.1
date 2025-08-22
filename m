Return-Path: <stable+bounces-172414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3790B31B0D
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7E03B69D6
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7712F999F;
	Fri, 22 Aug 2025 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPIJhkx4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBB37260D
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871890; cv=none; b=jXvsv5y4OWMiHsAMyozWbVYBWV6i38E1y6trBBpLvNetw/nSu7SJV9sdfhIidsgQ/NFEARg4Y4kxrfKODdLpMbCXiUg/gItHeap1vetWmqOOYO51tpzgVaVLWoyYdAdtZ9B9qYQEwwkzRtrPxLcNysizOjnK92CbbSthc5TU5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871890; c=relaxed/simple;
	bh=R/kVrFwpCjRP45uQS4AchIV0SsPFoHKGsg7MCw8NGuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtad71eF3r0iJ63VBZUGIQWcM/G95KooMlsrwkMtqG8JkC+K8dAQsAeCDXGSXD7yq/WWS0B/0qqgLxmOuEoeSJ0VY4BykrRjRxzDOYSU4M9XhktwAIS48GHsWcMJtHEDNzNQKE56Qk1HB4IN2OXmDbAwUxycjlvVHGtG/tGJPtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPIJhkx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD5BC4CEED;
	Fri, 22 Aug 2025 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871889;
	bh=R/kVrFwpCjRP45uQS4AchIV0SsPFoHKGsg7MCw8NGuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPIJhkx4Nlotg7rnrP2qJda0kjzqZ3zXQznXuvj+Tv75BrAOECEDrGKfa39zRocHs
	 tni4VHcsb/3+WgP+iRNsyLCnVwI0YWWAoJ6wUIWZo5+Mljei39GCUTT8Brq4vy6Fo7
	 lXmDUG5udkXjQlqCJ6WPfX8mGQ6HruOGUHQZjJX4GKCG7o8KUnmlFvDovdaQ+n2ihi
	 qRrA4KQHLOYYhIW/1WjPgmnLmqNTGJYbURF+8d1S4Kk8sDppaKoGajsF58HGWu8yVj
	 yrMaYTczlM8wyKv+8II39ZDlk2+E7JTaIea88/SJu367npiM/37mGZQsp/KDxTuDmW
	 eLEIFbWOhLdhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ext4: preserve SB_I_VERSION on remount
Date: Fri, 22 Aug 2025 10:11:26 -0400
Message-ID: <20250822141126.1253416-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082138-qualm-causation-5828@gregkh>
References: <2025082138-qualm-causation-5828@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit f2326fd14a224e4cccbab89e14c52279ff79b7ec ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 99117d1e1bdd..cc083eed496a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2019,6 +2019,9 @@ int ext4_init_fs_context(struct fs_context *fc)
 	fc->fs_private = ctx;
 	fc->ops = &ext4_context_ops;
 
+	/* i_version is always enabled now */
+	fc->sb_flags |= SB_I_VERSION;
+
 	return 0;
 }
 
@@ -5277,9 +5280,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 
-	/* i_version is always enabled now */
-	sb->s_flags |= SB_I_VERSION;
-
 	err = ext4_check_feature_compatibility(sb, es, silent);
 	if (err)
 		goto failed_mount;
-- 
2.50.1


