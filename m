Return-Path: <stable+bounces-171678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63142B2B509
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD2523155
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 23:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295AF1D5146;
	Mon, 18 Aug 2025 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMbo0SHG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3D1A2547
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560846; cv=none; b=uIy+so3/gcoYCxuuBTclcOKSeovAuMC4HKPKTz7VP7ypKAaG2ZniY2KI/ELQRq5N78Lo59gzgSYN25p4c+TosKp+/lAZ1dIT1O1PO/MuN8M6RiUOZN8tOwWRFZwM9KpyLZnaEXaqJ7oihPxrlZ8Hrc//rsEnphhdOeHlOotRZ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560846; c=relaxed/simple;
	bh=1Xti9tZfXNihVt99e1MO7FdtNeB+SaXoMJwmlX5ymy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St45EyZB/ljxA9p2+5uepholdhqPYKDVjkEuXe+BGEq/3jh954FABA5Tug9jq3U0i4veshVfDXHPJTyDonksAVpnnxuv+K5Ls9tDywIosXxt82r5Y8OYN7HZGrpWjCNRZyNndDh/0AM2GHhJjMG8TCsLA4/knLIdzx2DiPtLIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMbo0SHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6556C4CEF1;
	Mon, 18 Aug 2025 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755560846;
	bh=1Xti9tZfXNihVt99e1MO7FdtNeB+SaXoMJwmlX5ymy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XMbo0SHGeZ7lK94B5dvx50DnX2pcBIf79PDtkZYhFdflQHV/FWSMYK3OrKghzziyw
	 nfs9H5VjM/DrF2PZAmwzC+zcvZMm9OA+Mg1+skrYyv+PeDdXUQd0mbAye3Dq+XX+q4
	 bpkob6EHHPzxdraVJmGsPxUav2HAY6n9hSfXRw5pGKFa8Vs2oVL9EeXXFnpuETOY5m
	 PYipah4vrgzsPRcAq+of6ld/CKOvcDECCPTyA4G+tIp87CKBmhW42WqeleH261QcUg
	 YIHfLtP6GlEx76D6xCpC0hpWg2OH+deGZzbMPYhPJnXuV6dHEP7TY62eWL2Y+pYtuP
	 kEzlLUEy89ugg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] btrfs: don't ignore inode missing when replaying log tree
Date: Mon, 18 Aug 2025 19:47:23 -0400
Message-ID: <20250818234723.154435-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081805-strongly-container-0be3@gregkh>
References: <2025081805-strongly-container-0be3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 7ebf381a69421a88265d3c49cd0f007ba7336c9d ]

During log replay, at add_inode_ref(), we return -ENOENT if our current
inode isn't found on the subvolume tree or if a parent directory isn't
found. The error comes from btrfs_iget_logging() <- btrfs_iget() <-
btrfs_read_locked_inode().

The single caller of add_inode_ref(), replay_one_buffer(), ignores an
-ENOENT error because it expects that error to mean only that a parent
directory wasn't found and that is ok.

Before commit 5f61b961599a ("btrfs: fix inode lookup error handling during
log replay") we were converting any error when getting a parent directory
to -ENOENT and any error when getting the current inode to -EIO, so our
caller would fail log replay in case we can't find the current inode.
After that commit however in case the current inode is not found we return
-ENOENT to the caller and therefore it ignores the critical fact that the
current inode was not found in the subvolume tree.

Fix this by converting -ENOENT to 0 when we don't find a parent directory,
returning -ENOENT when we don't find the current inode and making the
caller, replay_one_buffer(), not ignore -ENOENT anymore.

Fixes: 5f61b961599a ("btrfs: fix inode lookup error handling during log replay")
CC: stable@vger.kernel.org # 6.16
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ adapted btrfs_inode pointer usage to older inode API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 16434106c465..a64c525f647f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1423,6 +1423,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		btrfs_dir = btrfs_iget_logging(parent_objectid, root);
 		if (IS_ERR(btrfs_dir)) {
 			ret = PTR_ERR(btrfs_dir);
+			if (ret == -ENOENT)
+				ret = 0;
 			dir = NULL;
 			goto out;
 		}
@@ -1456,6 +1458,15 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 				if (IS_ERR(btrfs_dir)) {
 					ret = PTR_ERR(btrfs_dir);
 					dir = NULL;
+					/*
+					 * A new parent dir may have not been
+					 * logged and not exist in the subvolume
+					 * tree, see the comment above before
+					 * the loop when getting the first
+					 * parent dir.
+					 */
+					if (ret == -ENOENT)
+						ret = 0;
 					goto out;
 				}
 				dir = &btrfs_dir->vfs_inode;
@@ -2611,9 +2622,8 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			   key.type == BTRFS_INODE_EXTREF_KEY) {
 			ret = add_inode_ref(wc->trans, root, log, path,
 					    eb, i, &key);
-			if (ret && ret != -ENOENT)
+			if (ret)
 				break;
-			ret = 0;
 		} else if (key.type == BTRFS_EXTENT_DATA_KEY) {
 			ret = replay_one_extent(wc->trans, root, path,
 						eb, i, &key);
-- 
2.50.1


