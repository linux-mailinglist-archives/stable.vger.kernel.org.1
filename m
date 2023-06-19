Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2790735475
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjFSK4h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFSKz7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:55:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944281FE2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75A6160B5F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACB8C433C0;
        Mon, 19 Jun 2023 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172042;
        bh=Vfo4ErLyz+INFU2BisZzvB8XYdc4O22qYJ0XCpDUdAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMMvZ1p94fexnoGd1YpwJhOJhtjEw8knrGd+SgRimsTOzCy1KISSQuL/uBXqxL2dm
         aX4WHSvaS5bmRh1DArTFYU/9gWZprGtSotDNU7GoNv2RIKVL7yQZ65IZHfTxf/86Rt
         rYE2LAr+kfsoYY4bzJmhEtJrtB3RYket1/Z/xgyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 16/89] btrfs: scrub: try harder to mark RAID56 block groups read-only
Date:   Mon, 19 Jun 2023 12:30:04 +0200
Message-ID: <20230619102139.028295593@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 7561551e7ba870b9659083b95feb520fb2dacce3 ]

Currently we allow a block group not to be marked read-only for scrub.

But for RAID56 block groups if we require the block group to be
read-only, then we're allowed to use cached content from scrub stripe to
reduce unnecessary RAID56 reads.

So this patch would:

- Make btrfs_inc_block_group_ro() try harder
  During my tests, for cases like btrfs/061 and btrfs/064, we can hit
  ENOSPC from btrfs_inc_block_group_ro() calls during scrub.

  The reason is if we only have one single data chunk, and trying to
  scrub it, we won't have any space left for any newer data writes.

  But this check should be done by the caller, especially for scrub
  cases we only temporarily mark the chunk read-only.
  And newer data writes would always try to allocate a new data chunk
  when needed.

- Return error for scrub if we failed to mark a RAID56 chunk read-only

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 14 ++++++++++++--
 fs/btrfs/scrub.c       |  9 ++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 889a598b17f6b..d0fecbd28232f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2279,10 +2279,20 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	}
 
 	ret = inc_block_group_ro(cache, 0);
-	if (!do_chunk_alloc || ret == -ETXTBSY)
-		goto unlock_out;
 	if (!ret)
 		goto out;
+	if (ret == -ETXTBSY)
+		goto unlock_out;
+
+	/*
+	 * Skip chunk alloction if the bg is SYSTEM, this is to avoid system
+	 * chunk allocation storm to exhaust the system chunk array.  Otherwise
+	 * we still want to try our best to mark the block group read-only.
+	 */
+	if (!do_chunk_alloc && ret == -ENOSPC &&
+	    (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM))
+		goto unlock_out;
+
 	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 88b9a5394561e..715a0329ba277 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3559,13 +3559,20 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		ret = btrfs_inc_block_group_ro(cache, sctx->is_dev_replace);
 		if (ret == 0) {
 			ro_set = 1;
-		} else if (ret == -ENOSPC && !sctx->is_dev_replace) {
+		} else if (ret == -ENOSPC && !sctx->is_dev_replace &&
+			   !(cache->flags & BTRFS_BLOCK_GROUP_RAID56_MASK)) {
 			/*
 			 * btrfs_inc_block_group_ro return -ENOSPC when it
 			 * failed in creating new chunk for metadata.
 			 * It is not a problem for scrub, because
 			 * metadata are always cowed, and our scrub paused
 			 * commit_transactions.
+			 *
+			 * For RAID56 chunks, we have to mark them read-only
+			 * for scrub, as later we would use our own cache
+			 * out of RAID56 realm.
+			 * Thus we want the RAID56 bg to be marked RO to
+			 * prevent RMW from screwing up out cache.
 			 */
 			ro_set = 0;
 		} else if (ret == -ETXTBSY) {
-- 
2.39.2



