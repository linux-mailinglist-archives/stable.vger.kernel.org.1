Return-Path: <stable+bounces-187849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D90D2BED392
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 18:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB0419C0F30
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910972459EA;
	Sat, 18 Oct 2025 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic4iDmd0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52110245033
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803848; cv=none; b=VlC/We4k4mHuZbTiRG1KJQAwamJWg+3Pbhn8ubsJ13CvQAehpWfqMCEAxqhSXbvsaNbN57YrEsvDo20WppektWR8pzQpkwheYP+0Gwmp+nNDGoBlCrF8BO25q/ivmfJtYzEDKlnEd5sIimNF4a381dMPbOsQvo4DwUi0Le/27ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803848; c=relaxed/simple;
	bh=bLWVPb2wOE/rEICjO1E2qLOdafjoglvxlf0XX8gz6A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dV4CkLqMjkKgUhzGVP4MhX6skT1H54SDHzxZZyYX/xHc8nFsIl5PYLJW7r3vZQwZrCAOphVjUE77UWDuLSSdNL42r/9cCfE2xIiRS+RxD6Q4mNaZX9kRWLAJMtKp4JjprtGjs2Nz5nCmY8KBAJZPYr4GgGKYloGqhtSf3jAzYwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic4iDmd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5345AC116B1;
	Sat, 18 Oct 2025 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760803846;
	bh=bLWVPb2wOE/rEICjO1E2qLOdafjoglvxlf0XX8gz6A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ic4iDmd07vl26GMZVWimllwMy5u9QX5Qrd3jaZetS+qS4PrzNI0VGGModQbV/Iw7D
	 ptv6btzs1o5CIAmFK/Y6t8hanm5Hflynmt194hfnVvbWnuWDTZ339zUL8lxZKKyR2e
	 9W3ygRtFPn/9KNShJTQe7sqPwTGeTurDV4jkGifSsAkRcTWUxeR7yDVu50rGGVPEqn
	 6zD8Jo3fNFSV1SAVQI815cPwvliJkejHQjxjHgS422sLRGtkVFk0p5kmxZI1xclI9E
	 +QTJue20wfB1eoRM+22MIFfgiUi2fSDFIQKDQImSn2tfwRZWFxnF6U4SIECXGWzGb7
	 Z75pUj3quhsow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anderson Nascimento <anderson@allelesecurity.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] btrfs: avoid potential out-of-bounds in btrfs_encode_fh()
Date: Sat, 18 Oct 2025 12:10:44 -0400
Message-ID: <20251018161044.834880-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101644-legacy-starch-6a67@gregkh>
References: <2025101644-legacy-starch-6a67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anderson Nascimento <anderson@allelesecurity.com>

[ Upstream commit dff4f9ff5d7f289e4545cc936362e01ed3252742 ]

The function btrfs_encode_fh() does not properly account for the three
cases it handles.

Before writing to the file handle (fh), the function only returns to the
user BTRFS_FID_SIZE_NON_CONNECTABLE (5 dwords, 20 bytes) or
BTRFS_FID_SIZE_CONNECTABLE (8 dwords, 32 bytes).

However, when a parent exists and the root ID of the parent and the
inode are different, the function writes BTRFS_FID_SIZE_CONNECTABLE_ROOT
(10 dwords, 40 bytes).

If *max_len is not large enough, this write goes out of bounds because
BTRFS_FID_SIZE_CONNECTABLE_ROOT is greater than
BTRFS_FID_SIZE_CONNECTABLE originally returned.

This results in an 8-byte out-of-bounds write at
fid->parent_root_objectid = parent_root_id.

A previous attempt to fix this issue was made but was lost.

https://lore.kernel.org/all/4CADAEEC020000780001B32C@vpn.id2.novell.com/

Although this issue does not seem to be easily triggerable, it is a
potential memory corruption bug that should be fixed. This patch
resolves the issue by ensuring the function returns the appropriate size
for all three cases and validates that *max_len is large enough before
writing any data.

Fixes: be6e8dc0ba84 ("NFS support for btrfs - v3")
CC: stable@vger.kernel.org # 3.0+
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ replaced btrfs_root_id() calls with direct ->root->root_key.objectid access ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/export.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 08d1d456e2f0f..c244b4cc8ba11 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -22,7 +22,11 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	int type;
 
 	if (parent && (len < BTRFS_FID_SIZE_CONNECTABLE)) {
-		*max_len = BTRFS_FID_SIZE_CONNECTABLE;
+		if (BTRFS_I(inode)->root->root_key.objectid !=
+		    BTRFS_I(parent)->root->root_key.objectid)
+			*max_len = BTRFS_FID_SIZE_CONNECTABLE_ROOT;
+		else
+			*max_len = BTRFS_FID_SIZE_CONNECTABLE;
 		return FILEID_INVALID;
 	} else if (len < BTRFS_FID_SIZE_NON_CONNECTABLE) {
 		*max_len = BTRFS_FID_SIZE_NON_CONNECTABLE;
@@ -44,6 +48,8 @@ static int btrfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 		parent_root_id = BTRFS_I(parent)->root->root_key.objectid;
 
 		if (parent_root_id != fid->root_objectid) {
+			if (*max_len < BTRFS_FID_SIZE_CONNECTABLE_ROOT)
+				return FILEID_INVALID;
 			fid->parent_root_objectid = parent_root_id;
 			len = BTRFS_FID_SIZE_CONNECTABLE_ROOT;
 			type = FILEID_BTRFS_WITH_PARENT_ROOT;
-- 
2.51.0


