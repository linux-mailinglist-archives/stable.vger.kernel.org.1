Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535306F1697
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbjD1L2g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbjD1L2d (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57ED55BF
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47D1E61445
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6178AC4339E;
        Fri, 28 Apr 2023 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681308;
        bh=DUOgbj3ylczUFgnL/1sfqoQHw7sNRVWbevLEH3Y2wV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2BU4OYTReP556vf3MbRgoGgHiFfZcXAk6WA+yurHopqGCvZSgheN7xOmKZDvxg+8E
         SrLKAsN5z4G+vKyTuDOf1Axs/+SkBtyD9otg9dH7DOZ9fDo5B28hyLFKOStFQ+FxeW
         adIHFAuKQW3eJYkvVZ2IaiyqqFg/R9RgueX3O+40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, k2ci <kernel-bot@kylinos.cn>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        David Sterba <dsterba@suse.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 6.2 10/15] btrfs: fix uninitialized variable warnings
Date:   Fri, 28 Apr 2023 13:27:54 +0200
Message-Id: <20230428112040.458450917@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112040.137898986@linuxfoundation.org>
References: <20230428112040.137898986@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Genjian Zhang <zhanggenjian@kylinos.cn>

commit 8ba7d5f5ba931be68a94b8c91bcced1622934e7a upstream.

There are some warnings on older compilers (gcc 10, 7) or non-x86_64
architectures (aarch64).  As btrfs wants to enable -Wmaybe-uninitialized
by default, fix the warnings even though it's not necessary on recent
compilers (gcc 12+).

../fs/btrfs/volumes.c: In function ‘btrfs_init_new_device’:
../fs/btrfs/volumes.c:2703:3: error: ‘seed_devices’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
 2703 |   btrfs_setup_sprout(fs_info, seed_devices);
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

../fs/btrfs/send.c: In function ‘get_cur_inode_state’:
../include/linux/compiler.h:70:32: error: ‘right_gen’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
   70 |   (__if_trace.miss_hit[1]++,1) :  \
      |                                ^
../fs/btrfs/send.c:1878:6: note: ‘right_gen’ was declared here
 1878 |  u64 right_gen;
      |      ^~~~~~~~~

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
Reviewed-by: David Sterba <dsterba@suse.com>
[ update changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/send.c    |    2 +-
 fs/btrfs/volumes.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1892,7 +1892,7 @@ static int get_cur_inode_state(struct se
 	int left_ret;
 	int right_ret;
 	u64 left_gen;
-	u64 right_gen;
+	u64 right_gen = 0;
 	struct btrfs_inode_info info;
 
 	ret = get_inode_info(sctx->send_root, ino, &info);
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2618,7 +2618,7 @@ int btrfs_init_new_device(struct btrfs_f
 	struct block_device *bdev;
 	struct super_block *sb = fs_info->sb;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	struct btrfs_fs_devices *seed_devices;
+	struct btrfs_fs_devices *seed_devices = NULL;
 	u64 orig_super_total_bytes;
 	u64 orig_super_num_devices;
 	int ret = 0;


