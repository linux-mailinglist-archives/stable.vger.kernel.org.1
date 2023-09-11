Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B472779B0CA
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbjIKVFu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242363AbjIKP27 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:28:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F8FE4
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:28:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B13C433CB;
        Mon, 11 Sep 2023 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694446135;
        bh=Fvo/8Z0SCFf2GtY3aklIO8IhKwAAuBP0vdYtFScIkLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aT4TKGVAkSLsi0EWCJ2GCTJCxTZv66IzsL8TAfDIg30mRHJGBCrOXuF0j1Y3WQ8/J
         foSBoDES20/C5Yb1Xe/PGD0OlIT/H/aCuDxeZWHvAHivEZ+KKfuaXzOe7Wq9MmVn3Q
         3tdu6x0uiCdeqLkC6pV1aszUJb2kiDqpYH8WhZuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiao Ni <xni@redhat.com>,
        Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 6.1 594/600] md: Free resources in __md_stop
Date:   Mon, 11 Sep 2023 15:50:27 +0200
Message-ID: <20230911134651.190228216@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiao Ni <xni@redhat.com>

commit 3e453522593d74a87cf68a38e14aa36ebca1dbcd upstream.

If md_run() fails after ->active_io is initialized, then percpu_ref_exit
is called in error path. However, later md_free_disk will call
percpu_ref_exit again which leads to a panic because of null pointer
dereference. It can also trigger this bug when resources are initialized
but are freed in error path, then will be freed again in md_free_disk.

BUG: kernel NULL pointer dereference, address: 0000000000000038
Oops: 0000 [#1] PREEMPT SMP
Workqueue: md_misc mddev_delayed_delete
RIP: 0010:free_percpu+0x110/0x630
Call Trace:
 <TASK>
 __percpu_ref_exit+0x44/0x70
 percpu_ref_exit+0x16/0x90
 md_free_disk+0x2f/0x80
 disk_release+0x101/0x180
 device_release+0x84/0x110
 kobject_put+0x12a/0x380
 kobject_put+0x160/0x380
 mddev_delayed_delete+0x19/0x30
 process_one_work+0x269/0x680
 worker_thread+0x266/0x640
 kthread+0x151/0x1b0
 ret_from_fork+0x1f/0x30

For creating raid device, md raid calls do_md_run->md_run, dm raid calls
md_run. We alloc those memory in md_run. For stopping raid device, md raid
calls do_md_stop->__md_stop, dm raid calls md_stop->__md_stop. So we can
free those memory resources in __md_stop.

Fixes: 72adae23a72c ("md: Change active_io to percpu")
Reported-and-tested-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6277,6 +6277,11 @@ static void __md_stop(struct mddev *mdde
 		mddev->to_remove = &md_redundancy_group;
 	module_put(pers->owner);
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+
+	percpu_ref_exit(&mddev->writes_pending);
+	percpu_ref_exit(&mddev->active_io);
+	bioset_exit(&mddev->bio_set);
+	bioset_exit(&mddev->sync_set);
 }
 
 void md_stop(struct mddev *mddev)
@@ -6288,9 +6293,6 @@ void md_stop(struct mddev *mddev)
 	 */
 	__md_stop_writes(mddev);
 	__md_stop(mddev);
-	percpu_ref_exit(&mddev->active_io);
-	bioset_exit(&mddev->bio_set);
-	bioset_exit(&mddev->sync_set);
 }
 
 EXPORT_SYMBOL_GPL(md_stop);
@@ -7857,11 +7859,6 @@ static void md_free_disk(struct gendisk
 {
 	struct mddev *mddev = disk->private_data;
 
-	percpu_ref_exit(&mddev->writes_pending);
-	percpu_ref_exit(&mddev->active_io);
-	bioset_exit(&mddev->bio_set);
-	bioset_exit(&mddev->sync_set);
-
 	mddev_free(mddev);
 }
 


