Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07275D48B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjGUTWS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjGUTWR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:22:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955D82733
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E50261D5F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7FCC433C9;
        Fri, 21 Jul 2023 19:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967335;
        bh=lawTK2nqP3aPtKpJ07V3oKPv+2tPg7nrUGQy2uM8iFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+Lhp1kK4yyhWlRo+BioN52GoXsx3IMKUDBV6aSsA/ealS7WGveaipnglZnS8//eu
         wtD7eDWiWx7/tGEn5RdQcYFOlfvnQL7puF4kL0RNmHo0Q9lQRMFefUyj/OXSYYfUR6
         AmgvgWPHKr+gvgEW0xOMRKa2jW1RfqaMicuobvnU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Zhang Yi <yi.zhang@huawei.com>,
        Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.1 109/223] ext4: turn quotas off if mount failed after enabling quotas
Date:   Fri, 21 Jul 2023 18:06:02 +0200
Message-ID: <20230721160525.517533607@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Baokun Li <libaokun1@huawei.com>

commit d13f99632748462c32fc95d729f5e754bab06064 upstream.

Yi found during a review of the patch "ext4: don't BUG on inconsistent
journal feature" that when ext4_mark_recovery_complete() returns an error
value, the error handling path does not turn off the enabled quotas,
which triggers the following kmemleak:

================================================================
unreferenced object 0xffff8cf68678e7c0 (size 64):
comm "mount", pid 746, jiffies 4294871231 (age 11.540s)
hex dump (first 32 bytes):
00 90 ef 82 f6 8c ff ff 00 00 00 00 41 01 00 00  ............A...
c7 00 00 00 bd 00 00 00 0a 00 00 00 48 00 00 00  ............H...
backtrace:
[<00000000c561ef24>] __kmem_cache_alloc_node+0x4d4/0x880
[<00000000d4e621d7>] kmalloc_trace+0x39/0x140
[<00000000837eee74>] v2_read_file_info+0x18a/0x3a0
[<0000000088f6c877>] dquot_load_quota_sb+0x2ed/0x770
[<00000000340a4782>] dquot_load_quota_inode+0xc6/0x1c0
[<0000000089a18bd5>] ext4_enable_quotas+0x17e/0x3a0 [ext4]
[<000000003a0268fa>] __ext4_fill_super+0x3448/0x3910 [ext4]
[<00000000b0f2a8a8>] ext4_fill_super+0x13d/0x340 [ext4]
[<000000004a9489c4>] get_tree_bdev+0x1dc/0x370
[<000000006e723bf1>] ext4_get_tree+0x1d/0x30 [ext4]
[<00000000c7cb663d>] vfs_get_tree+0x31/0x160
[<00000000320e1bed>] do_new_mount+0x1d5/0x480
[<00000000c074654c>] path_mount+0x22e/0xbe0
[<0000000003e97a8e>] do_mount+0x95/0xc0
[<000000002f3d3736>] __x64_sys_mount+0xc4/0x160
[<0000000027d2140c>] do_syscall_64+0x3f/0x90
================================================================

To solve this problem, we add a "failed_mount10" tag, and call
ext4_quota_off_umount() in this tag to release the enabled qoutas.

Fixes: 11215630aada ("ext4: don't BUG on inconsistent journal feature")
Cc: stable@kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20230327141630.156875-2-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5544,7 +5544,7 @@ static int __ext4_fill_super(struct fs_c
 		ext4_msg(sb, KERN_INFO, "recovery complete");
 		err = ext4_mark_recovery_complete(sb, es);
 		if (err)
-			goto failed_mount9;
+			goto failed_mount10;
 	}
 
 	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
@@ -5563,7 +5563,9 @@ static int __ext4_fill_super(struct fs_c
 
 	return 0;
 
-failed_mount9:
+failed_mount10:
+	ext4_quota_off_umount(sb);
+failed_mount9: __maybe_unused
 	ext4_release_orphan_info(sb);
 failed_mount8:
 	ext4_unregister_sysfs(sb);


