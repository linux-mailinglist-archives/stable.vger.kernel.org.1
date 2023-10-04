Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B957B877E
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243804AbjJDSGB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243802AbjJDSGA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:06:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E876A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:05:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BABC433C7;
        Wed,  4 Oct 2023 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442756;
        bh=iDL2b2gx1KRz0McPMyUnQh+1EMysc9N7tNDk8ZY2KrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXFWtE8shxhIzfAOkv/VSTU8YguQovNqiJmOltzLSlWi7GuLq3mo11BjGumqND7ok
         8wF6tcKT3ZNT49eMyoDSTa+XlvLqg5jsFglkJnWACC+tqER82XF9M0aceHohB4xyWF
         SNCi9SCLsBwtkKJNwDOCQW5rKV8c+3JAXQOs+egI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 090/183] btrfs: reset destination buffer when read_extent_buffer() gets invalid range
Date:   Wed,  4 Oct 2023 19:55:21 +0200
Message-ID: <20231004175207.651789157@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 74ee79142c0a344d4eae2eb7012ebc4e82254109 ]

Commit f98b6215d7d1 ("btrfs: extent_io: do extra check for extent buffer
read write functions") changed how we handle invalid extent buffer range
for read_extent_buffer().

Previously if the range is invalid we just set the destination to zero,
but after the patch we do nothing and error out.

This can lead to smatch static checker errors like:

  fs/btrfs/print-tree.c:186 print_uuid_item() error: uninitialized symbol 'subvol_id'.
  fs/btrfs/tests/extent-io-tests.c:338 check_eb_bitmap() error: uninitialized symbol 'has'.
  fs/btrfs/tests/extent-io-tests.c:353 check_eb_bitmap() error: uninitialized symbol 'has'.
  fs/btrfs/uuid-tree.c:203 btrfs_uuid_tree_remove() error: uninitialized symbol 'read_subid'.
  fs/btrfs/uuid-tree.c:353 btrfs_uuid_tree_iterate() error: uninitialized symbol 'subid_le'.
  fs/btrfs/uuid-tree.c:72 btrfs_uuid_tree_lookup() error: uninitialized symbol 'data'.
  fs/btrfs/volumes.c:7415 btrfs_dev_stats_value() error: uninitialized symbol 'val'.

Fix those warnings by reverting back to the old memset() behavior.
By this we keep the static checker happy and would still make a lot of
noise when such invalid ranges are passed in.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: f98b6215d7d1 ("btrfs: extent_io: do extra check for extent buffer read write functions")
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f9f6dfbc86bcd..346fc46d019bf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6722,8 +6722,14 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	char *dst = (char *)dstv;
 	unsigned long i = get_eb_page_index(start);
 
-	if (check_eb_range(eb, start, len))
+	if (check_eb_range(eb, start, len)) {
+		/*
+		 * Invalid range hit, reset the memory, so callers won't get
+		 * some random garbage for their uninitialzed memory.
+		 */
+		memset(dstv, 0, len);
 		return;
+	}
 
 	offset = get_eb_offset_in_page(eb, start);
 
-- 
2.40.1



