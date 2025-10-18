Return-Path: <stable+bounces-187846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E29BED356
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 18:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2019C302D
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25F924397A;
	Sat, 18 Oct 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPI58d9v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170D243387
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803321; cv=none; b=AJMGwY1QOmPO8IqP8ZbGDMOrW7zNfYJnQi0u+9YyOrhyXtka4LWgMd4SI3YE8MZKzDUQFBaRaDNwFJrKpIIVCs+D6NPBEZjekBdx+v4mQyuXjuY8ZlADCY1ivFj0YfNHQs4wma2p/gmL8ndY6GG8tCEmwGuNwVuiRGawL5I9G4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803321; c=relaxed/simple;
	bh=6TPhmgh8Mc2FtwdkesNLRfqGLZphtF3mTTN0m2X5XrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3493owFWUki42u6Ai1/7/8JTy5oROMzILwBrujbOGonWiKQZQOa2NjYyTJKIE5lcKoAEeJj+QURYjwUT9CcrN4nl1mBI/oHtkjKhlBatH1ASbzwsuMpebLyiWZDPkZlJ0XlLYA0fUyj6aog1pGGkvT7HMPzkelZYZk4u+P7mo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPI58d9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AEBC4CEF8;
	Sat, 18 Oct 2025 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760803321;
	bh=6TPhmgh8Mc2FtwdkesNLRfqGLZphtF3mTTN0m2X5XrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPI58d9vauoehhs0ljaPHgaxkSOWlnWCRGdsy9ima5iSqmSZzCHuvhDcK6UM3ifhW
	 8drbYVioAOn82reu6W6mxYK/JJhgDP9Cn0CcoCrK4YbxR1bN8tIiNyIGp7lhBiVcdn
	 VsP1/6iDA5dx8ACs5ZAZl7papEhqbS+reEWuFbzld7ry0mMHMXa+IhEA/ZVWp4kErN
	 WXcseYzZYBOQxFUU+WwtWiuArXA5DXn7qlFeBMsb7Lhr+OfNrFCBX3iVFj9q4eCxB3
	 TYspBTPaHKEdEAyaFIm2Nu3inR8R1izEUGoy8q3Apt4SHSPvaaSVAITf1zY21ZQMer
	 Ss185DgZFL46A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anderson Nascimento <anderson@allelesecurity.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] btrfs: avoid potential out-of-bounds in btrfs_encode_fh()
Date: Sat, 18 Oct 2025 12:01:58 -0400
Message-ID: <20251018160158.831532-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101645-ceremony-playlist-e997@gregkh>
References: <2025101645-ceremony-playlist-e997@gregkh>
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
index d908afa1f313c..b0cceebd5b3da 100644
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


