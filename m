Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741AE73530D
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjFSKlP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjFSKkq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E27CD
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62FD360670
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DF1C433C8;
        Mon, 19 Jun 2023 10:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171244;
        bh=WPH0VvRM0KpFY/Q8zsTcLLIl9hcYu6t5Ivq+VTtOinw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAH7b8AiWZYELDsdskojgjlBiPxnsorhMhEhpd4wzeqxYWJ5HALrjU//jh8rIckfY
         hXzQcel34BeAXUGMtvoBdK8REcbvIUcta01fbr1MmqQT5tgc7De5tAp3zyqjPmsifZ
         mfL6XafL0Jn/wi+hB/tqWYb+V9m0EDY2R7H9LfYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 12/49] ocfs2: fix use-after-free when unmounting read-only filesystem
Date:   Mon, 19 Jun 2023 12:29:50 +0200
Message-ID: <20230619102130.497164166@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
References: <20230619102129.856988902@linuxfoundation.org>
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

From: Luís Henriques <ocfs2-devel@oss.oracle.com>

commit 50d927880e0f90d5cb25e897e9d03e5edacc79a8 upstream.

It's trivial to trigger a use-after-free bug in the ocfs2 quotas code using
fstest generic/452.  After a read-only remount, quotas are suspended and
ocfs2_mem_dqinfo is freed through ->ocfs2_local_free_info().  When unmounting
the filesystem, an UAF access to the oinfo will eventually cause a crash.

BUG: KASAN: slab-use-after-free in timer_delete+0x54/0xc0
Read of size 8 at addr ffff8880389a8208 by task umount/669
...
Call Trace:
 <TASK>
 ...
 timer_delete+0x54/0xc0
 try_to_grab_pending+0x31/0x230
 __cancel_work_timer+0x6c/0x270
 ocfs2_disable_quotas.isra.0+0x3e/0xf0 [ocfs2]
 ocfs2_dismount_volume+0xdd/0x450 [ocfs2]
 generic_shutdown_super+0xaa/0x280
 kill_block_super+0x46/0x70
 deactivate_locked_super+0x4d/0xb0
 cleanup_mnt+0x135/0x1f0
 ...
 </TASK>

Allocated by task 632:
 kasan_save_stack+0x1c/0x40
 kasan_set_track+0x21/0x30
 __kasan_kmalloc+0x8b/0x90
 ocfs2_local_read_info+0xe3/0x9a0 [ocfs2]
 dquot_load_quota_sb+0x34b/0x680
 dquot_load_quota_inode+0xfe/0x1a0
 ocfs2_enable_quotas+0x190/0x2f0 [ocfs2]
 ocfs2_fill_super+0x14ef/0x2120 [ocfs2]
 mount_bdev+0x1be/0x200
 legacy_get_tree+0x6c/0xb0
 vfs_get_tree+0x3e/0x110
 path_mount+0xa90/0xe10
 __x64_sys_mount+0x16f/0x1a0
 do_syscall_64+0x43/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

Freed by task 650:
 kasan_save_stack+0x1c/0x40
 kasan_set_track+0x21/0x30
 kasan_save_free_info+0x2a/0x50
 __kasan_slab_free+0xf9/0x150
 __kmem_cache_free+0x89/0x180
 ocfs2_local_free_info+0x2ba/0x3f0 [ocfs2]
 dquot_disable+0x35f/0xa70
 ocfs2_susp_quotas.isra.0+0x159/0x1a0 [ocfs2]
 ocfs2_remount+0x150/0x580 [ocfs2]
 reconfigure_super+0x1a5/0x3a0
 path_mount+0xc8a/0xe10
 __x64_sys_mount+0x16f/0x1a0
 do_syscall_64+0x43/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

Link: https://lkml.kernel.org/r/20230522102112.9031-1-lhenriques@suse.de
Signed-off-by: Luís Henriques <lhenriques@suse.de>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/super.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -985,8 +985,10 @@ static void ocfs2_disable_quotas(struct
 	for (type = 0; type < OCFS2_MAXQUOTAS; type++) {
 		if (!sb_has_quota_loaded(sb, type))
 			continue;
-		oinfo = sb_dqinfo(sb, type)->dqi_priv;
-		cancel_delayed_work_sync(&oinfo->dqi_sync_work);
+		if (!sb_has_quota_suspended(sb, type)) {
+			oinfo = sb_dqinfo(sb, type)->dqi_priv;
+			cancel_delayed_work_sync(&oinfo->dqi_sync_work);
+		}
 		inode = igrab(sb->s_dquot.files[type]);
 		/* Turn off quotas. This will remove all dquot structures from
 		 * memory and so they will be automatically synced to global


