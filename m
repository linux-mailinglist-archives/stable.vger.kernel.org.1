Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D387A7EAB
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjITMTf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjITMTf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:19:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B981093
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:19:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119DCC433C7;
        Wed, 20 Sep 2023 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212369;
        bh=rrriDRej8XGDbpieFpSXHISwSWyOOv1W9XHfVsO8wzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlqMcYHZ56iDynj0l8wBDylmgxNp/osrW7lnfpjHezuWPqYZMaKr5K9CxqiHF1Uds
         e0hEMS/hTcJRjJxnmdNdwwXZOSl3o/Jp/sv/R28x47JNORIfb3UbSsN83WDtFBoyOl
         5QH4OovULg43vqeVrOIB6fLPLkEqAPOPZNFsCmQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+90a11e6b1e810785c6ff@syzkaller.appspotmail.com,
        Liu Shixin <liushixin2@huawei.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 251/273] jfs: fix invalid free of JFS_IP(ipimap)->i_imap in diUnmount
Date:   Wed, 20 Sep 2023 13:31:31 +0200
Message-ID: <20230920112854.054774996@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Shixin via Jfs-discussion <jfs-discussion@lists.sourceforge.net>

[ Upstream commit 6e2bda2c192d0244b5a78b787ef20aa10cb319b7 ]

syzbot found an invalid-free in diUnmount:

BUG: KASAN: double-free in slab_free mm/slub.c:3661 [inline]
BUG: KASAN: double-free in __kmem_cache_free+0x71/0x110 mm/slub.c:3674
Free of addr ffff88806f410000 by task syz-executor131/3632

 CPU: 0 PID: 3632 Comm: syz-executor131 Not tainted 6.1.0-rc7-syzkaller-00012-gca57f02295f1 #0
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
 Call Trace:
  <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
  print_address_description+0x74/0x340 mm/kasan/report.c:284
  print_report+0x107/0x1f0 mm/kasan/report.c:395
  kasan_report_invalid_free+0xac/0xd0 mm/kasan/report.c:460
  ____kasan_slab_free+0xfb/0x120
  kasan_slab_free include/linux/kasan.h:177 [inline]
  slab_free_hook mm/slub.c:1724 [inline]
  slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1750
  slab_free mm/slub.c:3661 [inline]
  __kmem_cache_free+0x71/0x110 mm/slub.c:3674
  diUnmount+0xef/0x100 fs/jfs/jfs_imap.c:195
  jfs_umount+0x108/0x370 fs/jfs/jfs_umount.c:63
  jfs_put_super+0x86/0x190 fs/jfs/super.c:194
  generic_shutdown_super+0x130/0x310 fs/super.c:492
  kill_block_super+0x79/0xd0 fs/super.c:1428
  deactivate_locked_super+0xa7/0xf0 fs/super.c:332
  cleanup_mnt+0x494/0x520 fs/namespace.c:1186
  task_work_run+0x243/0x300 kernel/task_work.c:179
  exit_task_work include/linux/task_work.h:38 [inline]
  do_exit+0x664/0x2070 kernel/exit.c:820
  do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
  __do_sys_exit_group kernel/exit.c:961 [inline]
  __se_sys_exit_group kernel/exit.c:959 [inline]
  __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[...]

JFS_IP(ipimap)->i_imap is not setting to NULL after free in diUnmount.
If jfs_remount() free JFS_IP(ipimap)->i_imap but then failed at diMount().
JFS_IP(ipimap)->i_imap will be freed once again.
Fix this problem by setting JFS_IP(ipimap)->i_imap to NULL after free.

Reported-by: syzbot+90a11e6b1e810785c6ff@syzkaller.appspotmail.com
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_imap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 93e8c590ff5c0..7565e00e88182 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -208,6 +208,7 @@ int diUnmount(struct inode *ipimap, int mounterror)
 	 * free in-memory control structure
 	 */
 	kfree(imap);
+	JFS_IP(ipimap)->i_imap = NULL;
 
 	return (0);
 }
-- 
2.40.1



