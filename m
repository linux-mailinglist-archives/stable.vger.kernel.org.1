Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8515C726F7F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbjFGU66 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjFGU6z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:58:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B351BE2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 881C664899
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E03C433EF;
        Wed,  7 Jun 2023 20:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171511;
        bh=pqzdTNgUwHqgceYCq0XJCIoUPvNv3LVkJxE36qND4w4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEuMimvKTfkVv9rpqYc8sEhl/p5EHhUBv8kuxiMwoi2493y5sM1ojFPHB3GwQ2NLF
         37MJlOPUXeqnZPtN/dVpcUbibrpmfNAqt8f3WgoOnIiLZOI/LrMsgypFeVjvUDhC2t
         sEC9pBZfUC4kq9+cUaRUevII0HEmUHgkdhvlkXIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lee Jones <lee@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 044/159] mailbox: mailbox-test: Fix potential double-free in mbox_test_message_write()
Date:   Wed,  7 Jun 2023 22:15:47 +0200
Message-ID: <20230607200905.128076620@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lee Jones <lee@kernel.org>

[ Upstream commit 2d1e952a2b8e5e92d8d55ac88a7cf7ca5ea591ad ]

If a user can make copy_from_user() fail, there is a potential for
UAF/DF due to a lack of locking around the allocation, use and freeing
of the data buffers.

This issue is not theoretical.  I managed to author a POC for it:

    BUG: KASAN: double-free in kfree+0x5c/0xac
    Free of addr ffff29280be5de00 by task poc/356
    CPU: 1 PID: 356 Comm: poc Not tainted 6.1.0-00001-g961aa6552c04-dirty #20
    Hardware name: linux,dummy-virt (DT)
    Call trace:
     dump_backtrace.part.0+0xe0/0xf0
     show_stack+0x18/0x40
     dump_stack_lvl+0x64/0x80
     print_report+0x188/0x48c
     kasan_report_invalid_free+0xa0/0xc0
     ____kasan_slab_free+0x174/0x1b0
     __kasan_slab_free+0x18/0x24
     __kmem_cache_free+0x130/0x2e0
     kfree+0x5c/0xac
     mbox_test_message_write+0x208/0x29c
     full_proxy_write+0x90/0xf0
     vfs_write+0x154/0x440
     ksys_write+0xcc/0x180
     __arm64_sys_write+0x44/0x60
     invoke_syscall+0x60/0x190
     el0_svc_common.constprop.0+0x7c/0x160
     do_el0_svc+0x40/0xf0
     el0_svc+0x2c/0x6c
     el0t_64_sync_handler+0xf4/0x120
     el0t_64_sync+0x18c/0x190

    Allocated by task 356:
     kasan_save_stack+0x3c/0x70
     kasan_set_track+0x2c/0x40
     kasan_save_alloc_info+0x24/0x34
     __kasan_kmalloc+0xb8/0xc0
     kmalloc_trace+0x58/0x70
     mbox_test_message_write+0x6c/0x29c
     full_proxy_write+0x90/0xf0
     vfs_write+0x154/0x440
     ksys_write+0xcc/0x180
     __arm64_sys_write+0x44/0x60
     invoke_syscall+0x60/0x190
     el0_svc_common.constprop.0+0x7c/0x160
     do_el0_svc+0x40/0xf0
     el0_svc+0x2c/0x6c
     el0t_64_sync_handler+0xf4/0x120
     el0t_64_sync+0x18c/0x190

    Freed by task 357:
     kasan_save_stack+0x3c/0x70
     kasan_set_track+0x2c/0x40
     kasan_save_free_info+0x38/0x5c
     ____kasan_slab_free+0x13c/0x1b0
     __kasan_slab_free+0x18/0x24
     __kmem_cache_free+0x130/0x2e0
     kfree+0x5c/0xac
     mbox_test_message_write+0x208/0x29c
     full_proxy_write+0x90/0xf0
     vfs_write+0x154/0x440
     ksys_write+0xcc/0x180
     __arm64_sys_write+0x44/0x60
     invoke_syscall+0x60/0x190
     el0_svc_common.constprop.0+0x7c/0x160
     do_el0_svc+0x40/0xf0
     el0_svc+0x2c/0x6c
     el0t_64_sync_handler+0xf4/0x120
     el0t_64_sync+0x18c/0x190

Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 4555d678fadda..6dd5b9614452b 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
@@ -38,6 +39,7 @@ struct mbox_test_device {
 	char			*signal;
 	char			*message;
 	spinlock_t		lock;
+	struct mutex		mutex;
 	wait_queue_head_t	waitq;
 	struct fasync_struct	*async_queue;
 	struct dentry		*root_debugfs_dir;
@@ -110,6 +112,8 @@ static ssize_t mbox_test_message_write(struct file *filp,
 		return -EINVAL;
 	}
 
+	mutex_lock(&tdev->mutex);
+
 	tdev->message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
 	if (!tdev->message)
 		return -ENOMEM;
@@ -144,6 +148,8 @@ static ssize_t mbox_test_message_write(struct file *filp,
 	kfree(tdev->message);
 	tdev->signal = NULL;
 
+	mutex_unlock(&tdev->mutex);
+
 	return ret < 0 ? ret : count;
 }
 
@@ -392,6 +398,7 @@ static int mbox_test_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, tdev);
 
 	spin_lock_init(&tdev->lock);
+	mutex_init(&tdev->mutex);
 
 	if (tdev->rx_channel) {
 		tdev->rx_buffer = devm_kzalloc(&pdev->dev,
-- 
2.39.2



