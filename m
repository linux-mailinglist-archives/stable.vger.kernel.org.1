Return-Path: <stable+bounces-71014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D16D96112E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B253D1C23435
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5268A1C6F6D;
	Tue, 27 Aug 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rt5eqv0H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EABE1C6F69;
	Tue, 27 Aug 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771810; cv=none; b=BDzAtVbNDGszDBbQoap9Ww5IBXlJqmSYZsNdzOQk0q/PdMt6txymygpbCoMCLvPhSxNXJWj77fKPGch3ulZb55kdkZR0ES4FbA8iS/3/jbceRyDQDFcy/tQ9lbv0yKKWXA0l2bfbyOkCmq6xSN+3fOBFmFbYM95GcO3IivJd/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771810; c=relaxed/simple;
	bh=eAHFbg1mszAQu2kGZ27kaLU/BB3Dp8QSbZcUdA6D6PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/AHUJKlElgKTh4N/dro5QW69aWQzJftgjgMpYKn94IZAcDRyDeC1fXiiFRTFEdOrLARTICjdSyc8Dji1+68orx3m7X3o0CtEiNevwwhMKnkZh0oFOrnl3CG0x/qcm7Few5JXdNA+uhuzsxwnS5O8WyQabKcCrrO9b18QzAddm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rt5eqv0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375D2C4DE16;
	Tue, 27 Aug 2024 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771809;
	bh=eAHFbg1mszAQu2kGZ27kaLU/BB3Dp8QSbZcUdA6D6PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rt5eqv0HzrHvc8fyX1nKZI0j7AeKU3Et6/1AYpBYmPdr9SLXcYfOSrF0Sqrl6jz4R
	 BwvaAU4MekAAfQR6v0nIIhN7c6xkrHzD4rylMjo0eD2ZU8ydh+WO/znf2NWiJrQUCs
	 hlbGGz1Tq9LZM81ERNWZUyKlxSzCGvivg3v5V/NM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anand Jain <anand.jain@oracle.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 027/321] btrfs: tree-checker: add dev extent item checks
Date: Tue, 27 Aug 2024 16:35:35 +0200
Message-ID: <20240827143839.248820110@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit 008e2512dc5696ab2dc5bf264e98a9fe9ceb830e upstream.

[REPORT]
There is a corruption report that btrfs refused to mount a fs that has
overlapping dev extents:

  BTRFS error (device sdc): dev extent devid 4 physical offset 14263979671552 overlap with previous dev extent end 14263980982272
  BTRFS error (device sdc): failed to verify dev extents against chunks: -117
  BTRFS error (device sdc): open_ctree failed

[CAUSE]
The direct cause is very obvious, there is a bad dev extent item with
incorrect length.

With btrfs check reporting two overlapping extents, the second one shows
some clue on the cause:

  ERROR: dev extent devid 4 offset 14263979671552 len 6488064 overlap with previous dev extent end 14263980982272
  ERROR: dev extent devid 13 offset 2257707008000 len 6488064 overlap with previous dev extent end 2257707270144
  ERROR: errors found in extent allocation tree or chunk allocation

The second one looks like a bitflip happened during new chunk
allocation:
hex(2257707008000) = 0x20da9d30000
hex(2257707270144) = 0x20da9d70000
diff               = 0x00000040000

So it looks like a bitflip happened during new dev extent allocation,
resulting the second overlap.

Currently we only do the dev-extent verification at mount time, but if the
corruption is caused by memory bitflip, we really want to catch it before
writing the corruption to the storage.

Furthermore the dev extent items has the following key definition:

	(<device id> DEV_EXTENT <physical offset>)

Thus we can not just rely on the generic key order check to make sure
there is no overlapping.

[ENHANCEMENT]
Introduce dedicated dev extent checks, including:

- Fixed member checks
  * chunk_tree should always be BTRFS_CHUNK_TREE_OBJECTID (3)
  * chunk_objectid should always be
    BTRFS_FIRST_CHUNK_CHUNK_TREE_OBJECTID (256)

- Alignment checks
  * chunk_offset should be aligned to sectorsize
  * length should be aligned to sectorsize
  * key.offset should be aligned to sectorsize

- Overlap checks
  If the previous key is also a dev-extent item, with the same
  device id, make sure we do not overlap with the previous dev extent.

Reported: Stefan N <stefannnau@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CA+W5K0rSO3koYTo=nzxxTm1-Pdu1HYgVxEpgJ=aGc7d=E8mGEg@mail.gmail.com/
CC: stable@vger.kernel.org # 5.10+
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-checker.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1613,6 +1613,72 @@ static int check_inode_ref(struct extent
 	return 0;
 }
 
+static int check_dev_extent_item(const struct extent_buffer *leaf,
+				 const struct btrfs_key *key,
+				 int slot,
+				 struct btrfs_key *prev_key)
+{
+	struct btrfs_dev_extent *de;
+	const u32 sectorsize = leaf->fs_info->sectorsize;
+
+	de = btrfs_item_ptr(leaf, slot, struct btrfs_dev_extent);
+	/* Basic fixed member checks. */
+	if (unlikely(btrfs_dev_extent_chunk_tree(leaf, de) !=
+		     BTRFS_CHUNK_TREE_OBJECTID)) {
+		generic_err(leaf, slot,
+			    "invalid dev extent chunk tree id, has %llu expect %llu",
+			    btrfs_dev_extent_chunk_tree(leaf, de),
+			    BTRFS_CHUNK_TREE_OBJECTID);
+		return -EUCLEAN;
+	}
+	if (unlikely(btrfs_dev_extent_chunk_objectid(leaf, de) !=
+		     BTRFS_FIRST_CHUNK_TREE_OBJECTID)) {
+		generic_err(leaf, slot,
+			    "invalid dev extent chunk objectid, has %llu expect %llu",
+			    btrfs_dev_extent_chunk_objectid(leaf, de),
+			    BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+		return -EUCLEAN;
+	}
+	/* Alignment check. */
+	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
+		generic_err(leaf, slot,
+			    "invalid dev extent key.offset, has %llu not aligned to %u",
+			    key->offset, sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(btrfs_dev_extent_chunk_offset(leaf, de),
+				 sectorsize))) {
+		generic_err(leaf, slot,
+			    "invalid dev extent chunk offset, has %llu not aligned to %u",
+			    btrfs_dev_extent_chunk_objectid(leaf, de),
+			    sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(btrfs_dev_extent_length(leaf, de),
+				 sectorsize))) {
+		generic_err(leaf, slot,
+			    "invalid dev extent length, has %llu not aligned to %u",
+			    btrfs_dev_extent_length(leaf, de), sectorsize);
+		return -EUCLEAN;
+	}
+	/* Overlap check with previous dev extent. */
+	if (slot && prev_key->objectid == key->objectid &&
+	    prev_key->type == key->type) {
+		struct btrfs_dev_extent *prev_de;
+		u64 prev_len;
+
+		prev_de = btrfs_item_ptr(leaf, slot - 1, struct btrfs_dev_extent);
+		prev_len = btrfs_dev_extent_length(leaf, prev_de);
+		if (unlikely(prev_key->offset + prev_len > key->offset)) {
+			generic_err(leaf, slot,
+		"dev extent overlap, prev offset %llu len %llu current offset %llu",
+				    prev_key->objectid, prev_len, key->offset);
+			return -EUCLEAN;
+		}
+	}
+	return 0;
+}
+
 /*
  * Common point to switch the item-specific validation.
  */
@@ -1648,6 +1714,9 @@ static int check_leaf_item(struct extent
 	case BTRFS_DEV_ITEM_KEY:
 		ret = check_dev_item(leaf, key, slot);
 		break;
+	case BTRFS_DEV_EXTENT_KEY:
+		ret = check_dev_extent_item(leaf, key, slot, prev_key);
+		break;
 	case BTRFS_INODE_ITEM_KEY:
 		ret = check_inode_item(leaf, key, slot);
 		break;



