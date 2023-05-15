Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D16703502
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243199AbjEOQzE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243204AbjEOQyj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9317349CE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 296D3629C8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264EBC433D2;
        Mon, 15 May 2023 16:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169657;
        bh=FsPrgsFNzHbbngytaK5Rjwhhpx0OGkf70uSG4ycAFxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rlu4u8XO1My+ltnB0xnPwn2gwhE0Ut3rvT99aevAVAGBYbCX7cHqCxBD7P8m/HeqD
         xR9qrShnq7IhiiN9Lu/RCXgmOrzva4vSI+CTg98xNV5QAXw5x3S2JjcuqVISEj0fEr
         ZocSfU1mlNT8eJOaowpS9A89Es4PBhtDe9hHTKWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.3 129/246] btrfs: properly reject clear_cache and v1 cache for block-group-tree
Date:   Mon, 15 May 2023 18:25:41 +0200
Message-Id: <20230515161726.433200448@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit 64b5d5b2852661284ccbb038c697562cc56231bf upstream.

[BUG]
With block-group-tree feature enabled, mounting it with clear_cache
would cause the following transaction abort at mount or remount:

  BTRFS info (device dm-4): force clearing of disk cache
  BTRFS info (device dm-4): using free space tree
  BTRFS info (device dm-4): auto enabling async discard
  BTRFS info (device dm-4): clearing free space tree
  BTRFS info (device dm-4): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
  BTRFS info (device dm-4): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
  BTRFS error (device dm-4): block-group-tree feature requires fres-space-tree and no-holes
  BTRFS error (device dm-4): super block corruption detected before writing it to disk
  BTRFS: error (device dm-4) in write_all_supers:4288: errno=-117 Filesystem corrupted (unexpected superblock corruption detected)
  BTRFS warning (device dm-4: state E): Skipping commit of aborted transaction.

[CAUSE]
For block-group-tree feature, we have an artificial dependency on
free-space-tree.

This means if we detect block-group-tree without v2 cache, we consider
it a corruption and cause the problem.

For clear_cache mount option, it would temporary disable v2 cache, then
re-enable it.

But unfortunately for that temporary v2 cache disabled status, we refuse
to write a superblock with bg tree only flag, thus leads to the above
transaction abortion.

[FIX]
For now, just reject clear_cache and v1 cache mount option for block
group tree.  So now we got a graceful rejection other than a transaction
abort:

  BTRFS info (device dm-4): force clearing of disk cache
  BTRFS error (device dm-4): cannot disable free space tree with block-group-tree feature
  BTRFS error (device dm-4): open_ctree failed

CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/super.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -826,7 +826,12 @@ out:
 	    !btrfs_test_opt(info, CLEAR_CACHE)) {
 		btrfs_err(info, "cannot disable free space tree");
 		ret = -EINVAL;
-
+	}
+	if (btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE) &&
+	    (btrfs_test_opt(info, CLEAR_CACHE) ||
+	     !btrfs_test_opt(info, FREE_SPACE_TREE))) {
+		btrfs_err(info, "cannot disable free space tree with block-group-tree feature");
+		ret = -EINVAL;
 	}
 	if (!ret)
 		ret = btrfs_check_mountopts_zoned(info);


