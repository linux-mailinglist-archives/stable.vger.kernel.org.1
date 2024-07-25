Return-Path: <stable+bounces-61705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7741D93C592
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CC7281A97
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1309319AD9B;
	Thu, 25 Jul 2024 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k1+C+wA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A948468;
	Thu, 25 Jul 2024 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919176; cv=none; b=NL4K0w5PbwoQAz1LyONGN29J7UhC4k6QtmN114PzgQHo/6ik8EQF5d3UpQjmAur+0VYi+CmiJWwZ4uoehmP0IUg+hyF2WzG+/EyF0+8JIJybdcGG9IWY4U/OUSDB58tHAJCJMZ1olwGjuw1O408yGLjyq2rgroRUWHr95jFbfn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919176; c=relaxed/simple;
	bh=Ht+o9l3sqtfa7FZF4mVIROlSS6ZsKpl97mWZ7YoE/Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOcX03hjgYfLusdaEwbGV6LEVGyXHrEwzB4rVFst4tyw2g1lrHP4Cws+zl95V7/ksyrnIj4tvunwuDWs82sUc2DThtA0J6C+Kw2MuVudRwqf5E2JWF7L2n9JkJ7lj8VlSyYoNZ+Ivk/r1F4GciLFx+0ab7lR43uqajiZSShh/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k1+C+wA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4969FC4AF0B;
	Thu, 25 Jul 2024 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721919176;
	bh=Ht+o9l3sqtfa7FZF4mVIROlSS6ZsKpl97mWZ7YoE/Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1+C+wA+VC4AmbFJK+U9KfwAZpeqcY7jJb/EMkeBGzV7We8cxLR0JanANhdY1wvuE
	 WvTX6QFvm5twTwEleI+0N4r5dIkI+S+FrX73qADLsAo7/od+Hp4p50NwyjYRM1ciri
	 0E9VGXKW6s+bjV6h1rfmCYqdiYt8QOCAzVP/Z0+U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 48/87] btrfs: qgroup: fix quota root leak after quota disable failure
Date: Thu, 25 Jul 2024 16:37:21 +0200
Message-ID: <20240725142740.245329612@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142738.422724252@linuxfoundation.org>
References: <20240725142738.422724252@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a7e4c6a3031c74078dba7fa36239d0f4fe476c53 ]

If during the quota disable we fail when cleaning the quota tree or when
deleting the root from the root tree, we jump to the 'out' label without
ever dropping the reference on the quota root, resulting in a leak of the
root since fs_info->quota_root is no longer pointing to the root (we have
set it to NULL just before those steps).

Fix this by always doing a btrfs_put_root() call under the 'out' label.
This is a problem that exists since qgroups were first added in 2012 by
commit bed92eae26cc ("Btrfs: qgroup implementation and prototypes"), but
back then we missed a kfree on the quota root and free_extent_buffer()
calls on its root and commit root nodes, since back then roots were not
yet reference counted.

Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c50cabf69415f..1f5ab51e18dc4 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1196,7 +1196,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_root *quota_root;
+	struct btrfs_root *quota_root = NULL;
 	struct btrfs_trans_handle *trans = NULL;
 	int ret = 0;
 
@@ -1290,9 +1290,9 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
 			      quota_root->node, 0, 1);
 
-	btrfs_put_root(quota_root);
 
 out:
+	btrfs_put_root(quota_root);
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (ret && trans)
 		btrfs_end_transaction(trans);
-- 
2.43.0




