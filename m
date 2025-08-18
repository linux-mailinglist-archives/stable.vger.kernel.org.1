Return-Path: <stable+bounces-171676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C49B2B48F
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF112177832
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 23:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3E31EFF8B;
	Mon, 18 Aug 2025 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3edze91"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3DF3451A4
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755559281; cv=none; b=WMn+b2IHAvAsbW/rNGxttvS8qePDbErQBSFCaBTG9WVd0XWGJ+B6uixsjCePUYQsWyYNaZB4xV9pbtfjkLCIRdFvEs7TQFK4nt8MRyIDkLT3WCoeA55mgDcvJjVsqgvZnwSy7u1Exmo/wDbQXs3kKq6INmNMj8LXQzTXK4oohLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755559281; c=relaxed/simple;
	bh=a2AsdplPgrEqxVmpdOL3oXt/tASZmN31Lcf4/JdfdyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lN2oNAjPAk4WuZ4pjUtD9FIvLFR5XF/tMQUpSKQtseKeMinDy8hB+4dbWfI+Jax9oOQJpx2puVwqnqz9lDZUU3H1P/S+IiyT/FoDZUd5aCsRLE+hTBPA1WYTYq/WVp4gmaO+XYFUv3+r278Uz4RcPrCMOvOA+oot5DkNwbn8XKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3edze91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0562C4CEF1;
	Mon, 18 Aug 2025 23:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755559281;
	bh=a2AsdplPgrEqxVmpdOL3oXt/tASZmN31Lcf4/JdfdyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3edze91NCzmkSCRx+4XPq29SpppuvvP9K+ZLp5Rh+BkIjdHgyCYe+f/7gEOn5Thq
	 tGKp5Me4U9/xQf7otEmDRbqH4qFQ/NAZ/lXpfBLLvWGq+BVi4dsctDsXoIIToK70ia
	 w17zQasRahHmnBsQz3LUFBQQcM2T1PZNflJn+QO4RC7tLd4GujZZW9JEHJxUIEJteR
	 hKCUCQmyEA4xh+tWK2OHUg/qjwKEJfuzropdlwiD8ySyPzTSys+9KfpFrftGM7QHIJ
	 5azhHxbNDbq3AKgOU/ZXyJU7NFFEMwCFg8AGOpXUDc3S66MGsQ9iI5CY3qDuVYXFNb
	 RgzSMLs0b7bFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] btrfs: qgroup: drop unused parameter fs_info from __del_qgroup_rb()
Date: Mon, 18 Aug 2025 19:21:17 -0400
Message-ID: <20250818232119.141306-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081830-legroom-preshow-e033@gregkh>
References: <2025081830-legroom-preshow-e033@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 2651f43274109f2d09b74a404b82722213ef9b2d ]

We don't need fs_info here, everything is reachable from qgroup.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: e12496677503 ("btrfs: qgroup: fix race between quota disable and quota rescan ioctl")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index e9f58cdeeb5f..e7e3760770c6 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -226,8 +226,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 	return qgroup;
 }
 
-static void __del_qgroup_rb(struct btrfs_fs_info *fs_info,
-			    struct btrfs_qgroup *qgroup)
+static void __del_qgroup_rb(struct btrfs_qgroup *qgroup)
 {
 	struct btrfs_qgroup_list *list;
 
@@ -258,7 +257,7 @@ static int del_qgroup_rb(struct btrfs_fs_info *fs_info, u64 qgroupid)
 		return -ENOENT;
 
 	rb_erase(&qgroup->node, &fs_info->qgroup_tree);
-	__del_qgroup_rb(fs_info, qgroup);
+	__del_qgroup_rb(qgroup);
 	return 0;
 }
 
@@ -643,7 +642,7 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 	while ((n = rb_first(&fs_info->qgroup_tree))) {
 		qgroup = rb_entry(n, struct btrfs_qgroup, node);
 		rb_erase(n, &fs_info->qgroup_tree);
-		__del_qgroup_rb(fs_info, qgroup);
+		__del_qgroup_rb(qgroup);
 		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
 		kfree(qgroup);
 	}
-- 
2.50.1


