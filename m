Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDC27A80E4
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbjITMlB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbjITMkr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:40:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0946E92
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:40:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C11AC433C8;
        Wed, 20 Sep 2023 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213641;
        bh=D1dND135syvkirxV5pFO4AKBvF/tFlj0vd2kwmf5hlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEMwjnZVFw8KDk5JNB3bW9w18bIZqxgN86aVg32DLUXXhnPNw0b24hSmtsCt07h12
         xDQZ5+kcBToqMctqnd7kvpdffryPEEvkIregUjUOfFL6H74yfi7Vb6hjB8Esf5yZ+F
         SvnU1BJZba1jilCGzoSDrNyo0XUZnywdAH8sMuSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Will Shiu <Will.Shiu@mediatek.com>,
        Jeff Layton <jlayton@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 312/367] locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lock
Date:   Wed, 20 Sep 2023 13:31:29 +0200
Message-ID: <20230920112906.633674860@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Shiu <Will.Shiu@mediatek.com>

[ Upstream commit 74f6f5912693ce454384eaeec48705646a21c74f ]

As following backtrace, the struct file_lock request , in posix_lock_inode
is free before ftrace function using.
Replace the ftrace function ahead free flow could fix the use-after-free
issue.

[name:report&]===============================================
BUG:KASAN: use-after-free in trace_event_raw_event_filelock_lock+0x80/0x12c
[name:report&]Read at addr f6ffff8025622620 by task NativeThread/16753
[name:report_hw_tags&]Pointer tag: [f6], memory tag: [fe]
[name:report&]
BT:
Hardware name: MT6897 (DT)
Call trace:
 dump_backtrace+0xf8/0x148
 show_stack+0x18/0x24
 dump_stack_lvl+0x60/0x7c
 print_report+0x2c8/0xa08
 kasan_report+0xb0/0x120
 __do_kernel_fault+0xc8/0x248
 do_bad_area+0x30/0xdc
 do_tag_check_fault+0x1c/0x30
 do_mem_abort+0x58/0xbc
 el1_abort+0x3c/0x5c
 el1h_64_sync_handler+0x54/0x90
 el1h_64_sync+0x68/0x6c
 trace_event_raw_event_filelock_lock+0x80/0x12c
 posix_lock_inode+0xd0c/0xd60
 do_lock_file_wait+0xb8/0x190
 fcntl_setlk+0x2d8/0x440
...
[name:report&]
[name:report&]Allocated by task 16752:
...
 slab_post_alloc_hook+0x74/0x340
 kmem_cache_alloc+0x1b0/0x2f0
 posix_lock_inode+0xb0/0xd60
...
 [name:report&]
 [name:report&]Freed by task 16752:
...
  kmem_cache_free+0x274/0x5b0
  locks_dispose_list+0x3c/0x148
  posix_lock_inode+0xc40/0xd60
  do_lock_file_wait+0xb8/0x190
  fcntl_setlk+0x2d8/0x440
  do_fcntl+0x150/0xc18
...

Signed-off-by: Will Shiu <Will.Shiu@mediatek.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index b8a31c1c4fff3..90f92784aa554 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1338,6 +1338,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
  out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
+	trace_posix_lock_inode(inode, request, error);
 	/*
 	 * Free any unused locks.
 	 */
@@ -1346,7 +1347,6 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	if (new_fl2)
 		locks_free_lock(new_fl2);
 	locks_dispose_list(&dispose);
-	trace_posix_lock_inode(inode, request, error);
 
 	return error;
 }
-- 
2.40.1



