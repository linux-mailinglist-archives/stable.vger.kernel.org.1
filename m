Return-Path: <stable+bounces-171682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5CCB2B538
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4556F525128
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCD918E3F;
	Tue, 19 Aug 2025 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWbFBOU4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C28134CF
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562496; cv=none; b=Dmoasfhv4lwBZdvljkGseme9VkPRtjbANATN3tKGMmTAP86ElkGFGQ3OqAix1nS6euuPNfEleATEiS/AM0bcQ3I6I8Hj0QJfvUnRpDHABePPVY9jVvNDdCtHvLBXbvXsu8v6UVkAt0y0ZdA+DQKIKSOxR/pMLVPOg0GbebMxUCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562496; c=relaxed/simple;
	bh=uvwmYI3vg594ZHZKTCZTVs3aan2Khj+uMNcil9SSd5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIiqFxrlP7JZFonp3jeK89Lm2IjWShVTNXDy97T4FftHAiP7i1KhlgFQ8tVfu4lqmB4VJlbJTHpCDwMVIlLBiRmoS6vNZI7sY1xxq49oCJpzu0swxc8leO+oEdx9PGX/7OBNyX4GlBG31U2RC8atIjJ/6OqNc6OAmdTWnhT49vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWbFBOU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE51C4CEF1;
	Tue, 19 Aug 2025 00:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755562494;
	bh=uvwmYI3vg594ZHZKTCZTVs3aan2Khj+uMNcil9SSd5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWbFBOU46pEdz6OfKugCEZEvmgdsI6d9nIL/SXjJ57pu1FtBNgzQecsGz7YJ86PwR
	 X6xU4e4BIwHewoR2+TpxPyCzMP6NLcip4G5IJLSZPUtgNauPqFXq5p4SNkaKrER3tW
	 gPyRy2vnwzmlIdIoqE0PjJy7uEu75ux5E8MHPnqVys1Jnr+OlT+1rA5B2UPP+MUTz8
	 JsVhEjkQ7BEgUOf8fEA344klwnGWU14rszkyV5MoPkW+QKlK+261cuTRn8AtRm8cYg
	 +qFZBQ+80Zans8hmUmT29Sf464sGIW3Jii5FQKxAUwZ9ZAvgDDq6nkHLn5Hnt/xGRG
	 9PVLEsrRiUYrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] btrfs: don't skip remaining extrefs if dir not found during log replay
Date: Mon, 18 Aug 2025 20:14:51 -0400
Message-ID: <20250819001451.192078-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081818-rimless-financial-6942@gregkh>
References: <2025081818-rimless-financial-6942@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 24e066ded45b8147b79c7455ac43a5bff7b5f378 ]

During log replay, at add_inode_ref(), if we have an extref item that
contains multiple extrefs and one of them points to a directory that does
not exist in the subvolume tree, we are supposed to ignore it and process
the remaining extrefs encoded in the extref item, since each extref can
point to a different parent inode. However when that happens we just
return from the function and ignore the remaining extrefs.

The problem has been around since extrefs were introduced, in commit
f186373fef00 ("btrfs: extended inode refs"), but it's hard to hit in
practice because getting extref items encoding multiple extref requires
getting a hash collision when computing the offset of the extref's
key. The offset if computed like this:

  key.offset = btrfs_extref_hash(dir_ino, name->name, name->len);

and btrfs_extref_hash() is just a wrapper around crc32c().

Fix this by moving to next iteration of the loop when we don't find
the parent directory that an extref points to.

Fixes: f186373fef00 ("btrfs: extended inode refs")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 16434106c465..c5a6c782f4d9 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1445,6 +1445,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		if (log_ref_ver) {
 			ret = extref_get_fields(eb, ref_ptr, &name,
 						&ref_index, &parent_objectid);
+			if (ret)
+				goto out;
 			/*
 			 * parent object can change from one array
 			 * item to another.
@@ -1456,15 +1458,31 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
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
+					if (ret == -ENOENT) {
+						/*
+						 * The next extref may refer to
+						 * another parent dir that
+						 * exists, so continue.
+						 */
+						ret = 0;
+						goto next;
+					}
 					goto out;
 				}
 				dir = &btrfs_dir->vfs_inode;
 			}
 		} else {
 			ret = ref_get_fields(eb, ref_ptr, &name, &ref_index);
+			if (ret)
+				goto out;
 		}
-		if (ret)
-			goto out;
 
 		ret = inode_in_dir(root, path, btrfs_ino(BTRFS_I(dir)),
 				   btrfs_ino(BTRFS_I(inode)), ref_index, &name);
@@ -1500,10 +1518,11 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		}
 		/* Else, ret == 1, we already have a perfect match, we're done. */
 
+next:
 		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + name.len;
 		kfree(name.name);
 		name.name = NULL;
-		if (log_ref_ver) {
+		if (log_ref_ver && dir) {
 			iput(dir);
 			dir = NULL;
 		}
-- 
2.50.1


