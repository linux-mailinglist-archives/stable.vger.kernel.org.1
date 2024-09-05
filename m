Return-Path: <stable+bounces-73183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B27796D397
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 091D6B22C7D
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE1B196446;
	Thu,  5 Sep 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zp5OIMIO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A170194A60;
	Thu,  5 Sep 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529412; cv=none; b=oY82/1FaFf3Mjrx9bmVsMXGuJ7q1dSZBCWs/Pk0BNkr/+9VU5Rn2ib3sHJ0/oNEg4cnIJUSPo0DeD/wyczfScfgQ2WdEdPcrs08Z/O9bC4CU7YExb3WWwzDhwCsXKhEVVtgmZlGEtoEVoxgNJ9jkz14H2IJZfyOK9avfmlptRBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529412; c=relaxed/simple;
	bh=+mfpbb3WNE2gxzqgWhPf64Rt0sBwr5BTUMo8h/2nkZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJ3yIuAHMoQvicSmXAF8onGVmYw2vo7bslqBzlkj2ffe/uDNyyHtsfJnO6+759wQEDomJciepYVqt8Nh44V+vd5IfRhdgaEnO2VpY5RibtmWaLg+ADCuw4AmrnzetG5ITTrNc/zngGF8ggjDF86i8bDnTBXTtATg+jrLtkK7xLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zp5OIMIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DB7C4CEC3;
	Thu,  5 Sep 2024 09:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529412;
	bh=+mfpbb3WNE2gxzqgWhPf64Rt0sBwr5BTUMo8h/2nkZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zp5OIMIOdp6CK9jk//AnaWsWpETgX9UqIOReHnarkG4LHj7vYOQZmR8/3443elQEw
	 03HRvRu8WdlPkYiTW4Z+Q44S2Fvh4k5NC1x3aJHnuG8fC3NF/qYeUtlmyTl8T0x3V3
	 wjapYAXRTmKKue6YNhB9ZsH9hrM+b3K2uc2cF084=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kai Krakow <hurikhan77@gmail.com>,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 005/184] btrfs: tree-checker: validate dref root and objectid
Date: Thu,  5 Sep 2024 11:38:38 +0200
Message-ID: <20240905093732.452467029@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit f333a3c7e8323499aa65038e77fe8f3199d4e283 ]

[CORRUPTION]
There is a bug report that btrfs flips RO due to a corruption in the
extent tree, the involved dumps looks like this:

 	item 188 key (402811572224 168 4096) itemoff 14598 itemsize 79
 		extent refs 3 gen 3678544 flags 1
 		ref#0: extent data backref root 13835058055282163977 objectid 281473384125923 offset 81432576 count 1
 		ref#1: shared data backref parent 1947073626112 count 1
 		ref#2: shared data backref parent 1156030103552 count 1
 BTRFS critical (device vdc1: state EA): unable to find ref byte nr 402811572224 parent 0 root 265 owner 28703026 offset 81432576 slot 189
 BTRFS error (device vdc1: state EA): failed to run delayed ref for logical 402811572224 num_bytes 4096 type 178 action 2 ref_mod 1: -2

[CAUSE]
The corrupted entry is ref#0 of item 188.
The root number 13835058055282163977 is beyond the upper limit for root
items (the current limit is 1 << 48), and the objectid also looks
suspicious.

Only the offset and count is correct.

[ENHANCEMENT]
Although it's still unknown why we have such many bytes corrupted
randomly, we can still enhance the tree-checker for data backrefs by:

- Validate the root value
  For now there should only be 3 types of roots can have data backref:
  * subvolume trees
  * data reloc trees
  * root tree
    Only for v1 space cache

- validate the objectid value
  The objectid should be a valid inode number.

Hopefully we can catch such problem in the future with the new checkers.

Reported-by: Kai Krakow <hurikhan77@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com/#t
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-checker.c | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 897e19790522d..de1c063bc39db 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1272,6 +1272,19 @@ static void extent_err(const struct extent_buffer *eb, int slot,
 	va_end(args);
 }
 
+static bool is_valid_dref_root(u64 rootid)
+{
+	/*
+	 * The following tree root objectids are allowed to have a data backref:
+	 * - subvolume trees
+	 * - data reloc tree
+	 * - tree root
+	 *   For v1 space cache
+	 */
+	return is_fstree(rootid) || rootid == BTRFS_DATA_RELOC_TREE_OBJECTID ||
+	       rootid == BTRFS_ROOT_TREE_OBJECTID;
+}
+
 static int check_extent_item(struct extent_buffer *leaf,
 			     struct btrfs_key *key, int slot,
 			     struct btrfs_key *prev_key)
@@ -1424,6 +1437,8 @@ static int check_extent_item(struct extent_buffer *leaf,
 		struct btrfs_extent_data_ref *dref;
 		struct btrfs_shared_data_ref *sref;
 		u64 seq;
+		u64 dref_root;
+		u64 dref_objectid;
 		u64 dref_offset;
 		u64 inline_offset;
 		u8 inline_type;
@@ -1467,11 +1482,26 @@ static int check_extent_item(struct extent_buffer *leaf,
 		 */
 		case BTRFS_EXTENT_DATA_REF_KEY:
 			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
+			dref_root = btrfs_extent_data_ref_root(leaf, dref);
+			dref_objectid = btrfs_extent_data_ref_objectid(leaf, dref);
 			dref_offset = btrfs_extent_data_ref_offset(leaf, dref);
 			seq = hash_extent_data_ref(
 					btrfs_extent_data_ref_root(leaf, dref),
 					btrfs_extent_data_ref_objectid(leaf, dref),
 					btrfs_extent_data_ref_offset(leaf, dref));
+			if (unlikely(!is_valid_dref_root(dref_root))) {
+				extent_err(leaf, slot,
+					   "invalid data ref root value %llu",
+					   dref_root);
+				return -EUCLEAN;
+			}
+			if (unlikely(dref_objectid < BTRFS_FIRST_FREE_OBJECTID ||
+				     dref_objectid > BTRFS_LAST_FREE_OBJECTID)) {
+				extent_err(leaf, slot,
+					   "invalid data ref objectid value %llu",
+					   dref_root);
+				return -EUCLEAN;
+			}
 			if (unlikely(!IS_ALIGNED(dref_offset,
 						 fs_info->sectorsize))) {
 				extent_err(leaf, slot,
@@ -1610,6 +1640,8 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 	for (; ptr < end; ptr += sizeof(*dref)) {
+		u64 root;
+		u64 objectid;
 		u64 offset;
 
 		/*
@@ -1617,7 +1649,22 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 		 * overflow from the leaf due to hash collisions.
 		 */
 		dref = (struct btrfs_extent_data_ref *)ptr;
+		root = btrfs_extent_data_ref_root(leaf, dref);
+		objectid = btrfs_extent_data_ref_objectid(leaf, dref);
 		offset = btrfs_extent_data_ref_offset(leaf, dref);
+		if (unlikely(!is_valid_dref_root(root))) {
+			extent_err(leaf, slot,
+				   "invalid extent data backref root value %llu",
+				   root);
+			return -EUCLEAN;
+		}
+		if (unlikely(objectid < BTRFS_FIRST_FREE_OBJECTID ||
+			     objectid > BTRFS_LAST_FREE_OBJECTID)) {
+			extent_err(leaf, slot,
+				   "invalid extent data backref objectid value %llu",
+				   root);
+			return -EUCLEAN;
+		}
 		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsize))) {
 			extent_err(leaf, slot,
 	"invalid extent data backref offset, have %llu expect aligned to %u",
-- 
2.43.0




