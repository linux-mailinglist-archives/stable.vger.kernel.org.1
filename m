Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0280A7757CC
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjHIKuM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjHIKuL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B101C1BF2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4895A630EF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5502AC433C8;
        Wed,  9 Aug 2023 10:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578209;
        bh=VvH1i0VzzpZvM2i9oy+xpkGVUWzMFaoAyCOuOUCnD5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3jKpOPF/vV7MBDxR+9DSIN99VUZRXYlYW6i/2FqBKtej9YuoMaTrGMW4uFa1O3/e
         M7zcR2FeZUex2Exfh6Sqz64UVIlN0wPyfo/ZeyuEDh65Qy7r6/bNcNwPe5wvbSxCQj
         ngkHXdrfzNI/hmZY5X9Dcb6gz882x2L2/P/SCAVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+3ba856e07b7127889d8c@syzkaller.appspotmail.com,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 145/165] btrfs: remove BUG_ON()s in add_new_free_space()
Date:   Wed,  9 Aug 2023 12:41:16 +0200
Message-ID: <20230809103647.539633507@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit d8ccbd21918fd7fa6ce3226cffc22c444228e8ad upstream.

At add_new_free_space() we have these BUG_ON()'s that are there to deal
with any failure to add free space to the in memory free space cache.
Such failures are mostly -ENOMEM that should be very rare. However there's
no need to have these BUG_ON()'s, we can just return any error to the
caller and all callers and their upper call chain are already dealing with
errors.

So just make add_new_free_space() return any errors, while removing the
BUG_ON()'s, and returning the total amount of added free space to an
optional u64 pointer argument.

Reported-by: syzbot+3ba856e07b7127889d8c@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000e9cb8305ff4e8327@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-group.c     |   51 ++++++++++++++++++++++++++++++---------------
 fs/btrfs/block-group.h     |    4 +--
 fs/btrfs/free-space-tree.c |   24 +++++++++++++++------
 3 files changed, 53 insertions(+), 26 deletions(-)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -499,12 +499,16 @@ static void fragment_free_space(struct b
  * used yet since their free space will be released as soon as the transaction
  * commits.
  */
-u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end)
+int add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end,
+		       u64 *total_added_ret)
 {
 	struct btrfs_fs_info *info = block_group->fs_info;
-	u64 extent_start, extent_end, size, total_added = 0;
+	u64 extent_start, extent_end, size;
 	int ret;
 
+	if (total_added_ret)
+		*total_added_ret = 0;
+
 	while (start < end) {
 		ret = find_first_extent_bit(&info->excluded_extents, start,
 					    &extent_start, &extent_end,
@@ -517,10 +521,12 @@ u64 add_new_free_space(struct btrfs_bloc
 			start = extent_end + 1;
 		} else if (extent_start > start && extent_start < end) {
 			size = extent_start - start;
-			total_added += size;
 			ret = btrfs_add_free_space_async_trimmed(block_group,
 								 start, size);
-			BUG_ON(ret); /* -ENOMEM or logic error */
+			if (ret)
+				return ret;
+			if (total_added_ret)
+				*total_added_ret += size;
 			start = extent_end + 1;
 		} else {
 			break;
@@ -529,13 +535,15 @@ u64 add_new_free_space(struct btrfs_bloc
 
 	if (start < end) {
 		size = end - start;
-		total_added += size;
 		ret = btrfs_add_free_space_async_trimmed(block_group, start,
 							 size);
-		BUG_ON(ret); /* -ENOMEM or logic error */
+		if (ret)
+			return ret;
+		if (total_added_ret)
+			*total_added_ret += size;
 	}
 
-	return total_added;
+	return 0;
 }
 
 /*
@@ -779,8 +787,13 @@ next:
 
 		if (key.type == BTRFS_EXTENT_ITEM_KEY ||
 		    key.type == BTRFS_METADATA_ITEM_KEY) {
-			total_found += add_new_free_space(block_group, last,
-							  key.objectid);
+			u64 space_added;
+
+			ret = add_new_free_space(block_group, last, key.objectid,
+						 &space_added);
+			if (ret)
+				goto out;
+			total_found += space_added;
 			if (key.type == BTRFS_METADATA_ITEM_KEY)
 				last = key.objectid +
 					fs_info->nodesize;
@@ -795,11 +808,10 @@ next:
 		}
 		path->slots[0]++;
 	}
-	ret = 0;
-
-	total_found += add_new_free_space(block_group, last,
-				block_group->start + block_group->length);
 
+	ret = add_new_free_space(block_group, last,
+				 block_group->start + block_group->length,
+				 NULL);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -2290,9 +2302,11 @@ static int read_one_block_group(struct b
 		btrfs_free_excluded_extents(cache);
 	} else if (cache->used == 0) {
 		cache->cached = BTRFS_CACHE_FINISHED;
-		add_new_free_space(cache, cache->start,
-				   cache->start + cache->length);
+		ret = add_new_free_space(cache, cache->start,
+					 cache->start + cache->length, NULL);
 		btrfs_free_excluded_extents(cache);
+		if (ret)
+			goto error;
 	}
 
 	ret = btrfs_add_block_group_cache(info, cache);
@@ -2728,9 +2742,12 @@ struct btrfs_block_group *btrfs_make_blo
 		return ERR_PTR(ret);
 	}
 
-	add_new_free_space(cache, chunk_offset, chunk_offset + size);
-
+	ret = add_new_free_space(cache, chunk_offset, chunk_offset + size, NULL);
 	btrfs_free_excluded_extents(cache);
+	if (ret) {
+		btrfs_put_block_group(cache);
+		return ERR_PTR(ret);
+	}
 
 	/*
 	 * Ensure the corresponding space_info object is created and
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -277,8 +277,8 @@ int btrfs_cache_block_group(struct btrfs
 void btrfs_put_caching_control(struct btrfs_caching_control *ctl);
 struct btrfs_caching_control *btrfs_get_caching_control(
 		struct btrfs_block_group *cache);
-u64 add_new_free_space(struct btrfs_block_group *block_group,
-		       u64 start, u64 end);
+int add_new_free_space(struct btrfs_block_group *block_group,
+		       u64 start, u64 end, u64 *total_added_ret);
 struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 				struct btrfs_fs_info *fs_info,
 				const u64 chunk_offset);
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1515,9 +1515,13 @@ static int load_free_space_bitmaps(struc
 			if (prev_bit == 0 && bit == 1) {
 				extent_start = offset;
 			} else if (prev_bit == 1 && bit == 0) {
-				total_found += add_new_free_space(block_group,
-								  extent_start,
-								  offset);
+				u64 space_added;
+
+				ret = add_new_free_space(block_group, extent_start,
+							 offset, &space_added);
+				if (ret)
+					goto out;
+				total_found += space_added;
 				if (total_found > CACHING_CTL_WAKE_UP) {
 					total_found = 0;
 					wake_up(&caching_ctl->wait);
@@ -1529,8 +1533,9 @@ static int load_free_space_bitmaps(struc
 		}
 	}
 	if (prev_bit == 1) {
-		total_found += add_new_free_space(block_group, extent_start,
-						  end);
+		ret = add_new_free_space(block_group, extent_start, end, NULL);
+		if (ret)
+			goto out;
 		extent_count++;
 	}
 
@@ -1569,6 +1574,8 @@ static int load_free_space_extents(struc
 	end = block_group->start + block_group->length;
 
 	while (1) {
+		u64 space_added;
+
 		ret = btrfs_next_item(root, path);
 		if (ret < 0)
 			goto out;
@@ -1583,8 +1590,11 @@ static int load_free_space_extents(struc
 		ASSERT(key.type == BTRFS_FREE_SPACE_EXTENT_KEY);
 		ASSERT(key.objectid < end && key.objectid + key.offset <= end);
 
-		total_found += add_new_free_space(block_group, key.objectid,
-						  key.objectid + key.offset);
+		ret = add_new_free_space(block_group, key.objectid,
+					 key.objectid + key.offset, &space_added);
+		if (ret)
+			goto out;
+		total_found += space_added;
 		if (total_found > CACHING_CTL_WAKE_UP) {
 			total_found = 0;
 			wake_up(&caching_ctl->wait);


