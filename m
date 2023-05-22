Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8033970C47D
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjEVRlc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjEVRlT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D1BB9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 10:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49AFE61D65
        for <stable@vger.kernel.org>; Mon, 22 May 2023 17:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EA3C433D2;
        Mon, 22 May 2023 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684777276;
        bh=x3ykZOIOBT2onzvboRHr2r4GxYryrH17V087QClXCmA=;
        h=Subject:To:Cc:From:Date:From;
        b=ipCVCsFOBY3NS53/a14wSvsitJugWpOtPHPRG1BUS0thmrQpHsOlJeqBmPyTFs2XM
         KixFSFOlLKw/qm8CQfSevLUp7I0teH632It1UvEEFGqGH0+uox6+rCFXX9xHvfU46X
         YAz+gY3C1gB982f2QMVFOx5g97dBTYB7JDZgkb+c=
Subject: FAILED: patch "[PATCH] vc_screen: reload load of struct vc_data pointer in" failed to apply to 5.4-stable tree
To:     george.kennedy@oracle.com, gregkh@linuxfoundation.org,
        linux@weissschuh.net, stable@kernel.org, syzkaller@googlegroups.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 18:41:14 +0100
Message-ID: <2023052214-juniper-cradle-5aaf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8fb9ea65c9d1338b0d2bb0a9122dc942cdd32357
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052214-juniper-cradle-5aaf@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

8fb9ea65c9d1 ("vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF")
71d4abfab322 ("vc_screen: rewrite vcs_size to accept vc, not inode")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8fb9ea65c9d1338b0d2bb0a9122dc942cdd32357 Mon Sep 17 00:00:00 2001
From: George Kennedy <george.kennedy@oracle.com>
Date: Fri, 12 May 2023 06:08:48 -0500
Subject: [PATCH] vc_screen: reload load of struct vc_data pointer in
 vcs_write() to avoid UAF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After a call to console_unlock() in vcs_write() the vc_data struct can be
freed by vc_port_destruct(). Because of that, the struct vc_data pointer
must be reloaded in the while loop in vcs_write() after console_lock() to
avoid a UAF when vcs_size() is called.

Syzkaller reported a UAF in vcs_size().

BUG: KASAN: slab-use-after-free in vcs_size (drivers/tty/vt/vc_screen.c:215)
Read of size 4 at addr ffff8880beab89a8 by task repro_vcs_size/4119

Call Trace:
 <TASK>
__asan_report_load4_noabort (mm/kasan/report_generic.c:380)
vcs_size (drivers/tty/vt/vc_screen.c:215)
vcs_write (drivers/tty/vt/vc_screen.c:664)
vfs_write (fs/read_write.c:582 fs/read_write.c:564)
...
 <TASK>

Allocated by task 1213:
kmalloc_trace (mm/slab_common.c:1064)
vc_allocate (./include/linux/slab.h:559 ./include/linux/slab.h:680
    drivers/tty/vt/vt.c:1078 drivers/tty/vt/vt.c:1058)
con_install (drivers/tty/vt/vt.c:3334)
tty_init_dev (drivers/tty/tty_io.c:1303 drivers/tty/tty_io.c:1415
    drivers/tty/tty_io.c:1392)
tty_open (drivers/tty/tty_io.c:2082 drivers/tty/tty_io.c:2128)
chrdev_open (fs/char_dev.c:415)
do_dentry_open (fs/open.c:921)
vfs_open (fs/open.c:1052)
...

Freed by task 4116:
kfree (mm/slab_common.c:1016)
vc_port_destruct (drivers/tty/vt/vt.c:1044)
tty_port_destructor (drivers/tty/tty_port.c:296)
tty_port_put (drivers/tty/tty_port.c:312)
vt_disallocate_all (drivers/tty/vt/vt_ioctl.c:662 (discriminator 2))
vt_ioctl (drivers/tty/vt/vt_ioctl.c:903)
tty_ioctl (drivers/tty/tty_io.c:2778)
...

The buggy address belongs to the object at ffff8880beab8800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 424 bytes inside of
 freed 1024-byte region [ffff8880beab8800, ffff8880beab8c00)

The buggy address belongs to the physical page:
page:00000000afc77580 refcount:1 mapcount:0 mapping:0000000000000000
    index:0x0 pfn:0xbeab8
head:00000000afc77580 order:3 entire_mapcount:0 nr_pages_mapped:0
    pincount:0
flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
page_type: 0xffffffff()
raw: 000fffffc0010200 ffff888100042dc0 ffffea000426de00 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880beab8880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880beab8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880beab8980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff8880beab8a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880beab8a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Disabling lock debugging due to kernel taint

Fixes: ac751efa6a0d ("console: rename acquire/release_console_sem() to console_lock/unlock()")
Cc: stable <stable@kernel.org>
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/1683889728-10411-1-git-send-email-george.kennedy@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 498ba9c0ee93..829c4be66f3b 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -656,10 +656,17 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 			}
 		}
 
-		/* The vcs_size might have changed while we slept to grab
-		 * the user buffer, so recheck.
+		/* The vc might have been freed or vcs_size might have changed
+		 * while we slept to grab the user buffer, so recheck.
 		 * Return data written up to now on failure.
 		 */
+		vc = vcs_vc(inode, &viewed);
+		if (!vc) {
+			if (written)
+				break;
+			ret = -ENXIO;
+			goto unlock_out;
+		}
 		size = vcs_size(vc, attr, false);
 		if (size < 0) {
 			if (written)

