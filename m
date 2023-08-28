Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3250878AC17
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjH1KhK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjH1Kgo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ABEA6
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA90463ED4
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9474FC433C8;
        Mon, 28 Aug 2023 10:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219001;
        bh=7mdaKESB27qbb/GYyjWMkmt8paf3aeIqy+XApZRbWpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itFKAdfVpLYD6rnIfWOHbggr4a4rG3Wdx1+a3zg8CiS5/TQ9UrTvB4FKJvQ1F10fX
         AlWp+4Xnon+xwpOzeZkJEqJsVtx2QYU3EFXI1YQjkEvkcFwVQTzM5CvkmWB/iG2cEx
         c1ANxeS7z7S/CohPNwIz+O3Yi2UxghgRM4sB/ZAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ye Bin <yebin10@huawei.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 009/158] quota: fix warning in dqgrab()
Date:   Mon, 28 Aug 2023 12:11:46 +0200
Message-ID: <20230828101157.637046737@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit d6a95db3c7ad160bc16b89e36449705309b52bcb ]

There's issue as follows when do fault injection:
WARNING: CPU: 1 PID: 14870 at include/linux/quotaops.h:51 dquot_disable+0x13b7/0x18c0
Modules linked in:
CPU: 1 PID: 14870 Comm: fsconfig Not tainted 6.3.0-next-20230505-00006-g5107a9c821af-dirty #541
RIP: 0010:dquot_disable+0x13b7/0x18c0
RSP: 0018:ffffc9000acc79e0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88825e41b980
RDX: 0000000000000000 RSI: ffff88825e41b980 RDI: 0000000000000002
RBP: ffff888179f68000 R08: ffffffff82087ca7 R09: 0000000000000000
R10: 0000000000000001 R11: ffffed102f3ed026 R12: ffff888179f68130
R13: ffff888179f68110 R14: dffffc0000000000 R15: ffff888179f68118
FS:  00007f450a073740(0000) GS:ffff88882fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe96f2efd8 CR3: 000000025c8ad000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dquot_load_quota_sb+0xd53/0x1060
 dquot_resume+0x172/0x230
 ext4_reconfigure+0x1dc6/0x27b0
 reconfigure_super+0x515/0xa90
 __x64_sys_fsconfig+0xb19/0xd20
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Above issue may happens as follows:
ProcessA              ProcessB                    ProcessC
sys_fsconfig
  vfs_fsconfig_locked
   reconfigure_super
     ext4_remount
      dquot_suspend -> suspend all type quota

                 sys_fsconfig
                  vfs_fsconfig_locked
                    reconfigure_super
                     ext4_remount
                      dquot_resume
                       ret = dquot_load_quota_sb
                        add_dquot_ref
                                           do_open  -> open file O_RDWR
                                            vfs_open
                                             do_dentry_open
                                              get_write_access
                                               atomic_inc_unless_negative(&inode->i_writecount)
                                              ext4_file_open
                                               dquot_file_open
                                                dquot_initialize
                                                  __dquot_initialize
                                                   dqget
						    atomic_inc(&dquot->dq_count);

                          __dquot_initialize
                           __dquot_initialize
                            dqget
                             if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
                               ext4_acquire_dquot
			        -> Return error DQ_ACTIVE_B flag isn't set
                         dquot_disable
			  invalidate_dquots
			   if (atomic_read(&dquot->dq_count))
	                    dqgrab
			     WARN_ON_ONCE(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
	                      -> Trigger warning

In the above scenario, 'dquot->dq_flags' has no DQ_ACTIVE_B is normal when
dqgrab().
To solve above issue just replace the dqgrab() use in invalidate_dquots() with
atomic_inc(&dquot->dq_count).

Signed-off-by: Ye Bin <yebin10@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230605140731.2427629-3-yebin10@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 44175f37bfeb5..3d1a71d2909bb 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -546,7 +546,7 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
-			dqgrab(dquot);
+			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
 			 * Once dqput() wakes us up, we know it's time to free
-- 
2.40.1



