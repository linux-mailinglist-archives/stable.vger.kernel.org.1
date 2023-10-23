Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2957D315D
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjJWLIY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjJWLIX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:08:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CDBC1
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:08:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33CCC433C9;
        Mon, 23 Oct 2023 11:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059301;
        bh=66/pjuUVMXrWiTyuatPfOQnUhxKgtgHjQ9wE56kKY/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixFe0yLzL5qkm2ur2mED1To4S5NfxnrDoxmcHTSG/vmubiVWHTx25Fy0VeggyN2pH
         +2dvUze8c25Kzq7HoanTjbVUDkESVwNmmLTDVfTvq1gT1BK62cnQK74jVnIaA3SheS
         4dve+LfgKkh7W3m+Xtd67NUwaApElqANvGkJNL6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 132/241] btrfs: fix some -Wmaybe-uninitialized warnings in ioctl.c
Date:   Mon, 23 Oct 2023 12:55:18 +0200
Message-ID: <20231023104837.091564576@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 9147b9ded499d9853bdf0e9804b7eaa99c4429ed ]

Jens reported the following warnings from -Wmaybe-uninitialized recent
Linus' branch.

  In file included from ./include/asm-generic/rwonce.h:26,
		   from ./arch/arm64/include/asm/rwonce.h:71,
		   from ./include/linux/compiler.h:246,
		   from ./include/linux/export.h:5,
		   from ./include/linux/linkage.h:7,
		   from ./include/linux/kernel.h:17,
		   from fs/btrfs/ioctl.c:6:
  In function ‘instrument_copy_from_user_before’,
      inlined from ‘_copy_from_user’ at ./include/linux/uaccess.h:148:3,
      inlined from ‘copy_from_user’ at ./include/linux/uaccess.h:183:7,
      inlined from ‘btrfs_ioctl_space_info’ at fs/btrfs/ioctl.c:2999:6,
      inlined from ‘btrfs_ioctl’ at fs/btrfs/ioctl.c:4616:10:
  ./include/linux/kasan-checks.h:38:27: warning: ‘space_args’ may be used
  uninitialized [-Wmaybe-uninitialized]
     38 | #define kasan_check_write __kasan_check_write
  ./include/linux/instrumented.h:129:9: note: in expansion of macro
  ‘kasan_check_write’
    129 |         kasan_check_write(to, n);
	|         ^~~~~~~~~~~~~~~~~
  ./include/linux/kasan-checks.h: In function ‘btrfs_ioctl’:
  ./include/linux/kasan-checks.h:20:6: note: by argument 1 of type ‘const
  volatile void *’ to ‘__kasan_check_write’ declared here
     20 | bool __kasan_check_write(const volatile void *p, unsigned int
	size);
	|      ^~~~~~~~~~~~~~~~~~~
  fs/btrfs/ioctl.c:2981:39: note: ‘space_args’ declared here
   2981 |         struct btrfs_ioctl_space_args space_args;
	|                                       ^~~~~~~~~~
  In function ‘instrument_copy_from_user_before’,
      inlined from ‘_copy_from_user’ at ./include/linux/uaccess.h:148:3,
      inlined from ‘copy_from_user’ at ./include/linux/uaccess.h:183:7,
      inlined from ‘_btrfs_ioctl_send’ at fs/btrfs/ioctl.c:4343:9,
      inlined from ‘btrfs_ioctl’ at fs/btrfs/ioctl.c:4658:10:
  ./include/linux/kasan-checks.h:38:27: warning: ‘args32’ may be used
  uninitialized [-Wmaybe-uninitialized]
     38 | #define kasan_check_write __kasan_check_write
  ./include/linux/instrumented.h:129:9: note: in expansion of macro
  ‘kasan_check_write’
    129 |         kasan_check_write(to, n);
	|         ^~~~~~~~~~~~~~~~~
  ./include/linux/kasan-checks.h: In function ‘btrfs_ioctl’:
  ./include/linux/kasan-checks.h:20:6: note: by argument 1 of type ‘const
  volatile void *’ to ‘__kasan_check_write’ declared here
     20 | bool __kasan_check_write(const volatile void *p, unsigned int
	size);
	|      ^~~~~~~~~~~~~~~~~~~
  fs/btrfs/ioctl.c:4341:49: note: ‘args32’ declared here
   4341 |                 struct btrfs_ioctl_send_args_32 args32;
	|                                                 ^~~~~~

This was due to his config options and having KASAN turned on,
which adds some extra checks around copy_from_user(), which then
triggered the -Wmaybe-uninitialized checker for these cases.

Fix the warnings by initializing the different structs we're copying
into.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d27b0d86b8e2c..bf35b6fce8f07 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2978,7 +2978,7 @@ static void get_block_group_info(struct list_head *groups_list,
 static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 				   void __user *arg)
 {
-	struct btrfs_ioctl_space_args space_args;
+	struct btrfs_ioctl_space_args space_args = { 0 };
 	struct btrfs_ioctl_space_info space;
 	struct btrfs_ioctl_space_info *dest;
 	struct btrfs_ioctl_space_info *dest_orig;
@@ -4338,7 +4338,7 @@ static int _btrfs_ioctl_send(struct inode *inode, void __user *argp, bool compat
 
 	if (compat) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
-		struct btrfs_ioctl_send_args_32 args32;
+		struct btrfs_ioctl_send_args_32 args32 = { 0 };
 
 		ret = copy_from_user(&args32, argp, sizeof(args32));
 		if (ret)
-- 
2.40.1



