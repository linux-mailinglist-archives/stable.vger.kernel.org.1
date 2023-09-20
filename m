Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC787A7B41
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjITLul (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjITLuj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:50:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAFCD6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:50:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1788AC433C7;
        Wed, 20 Sep 2023 11:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210630;
        bh=aUq/5WVFouFn+L5zSQ2YTbMGplzl05jxCm+Jw/8nF+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+dGZW2wcGIusRbOMfiM8swYhkQ+cGieVJiYfVVzN6woL9Fbhc8ZbMz6/Rgw4ZlrD
         SJeUzJs3VGSicK2dtFaJ6IXkLUZtjWvXBjzeCtLpFnhxOXtMO2QIJZH830I+9igxOX
         yc/sWj/SJVuY3kksySc3p4fgCKqW61q6NX5LLdnU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 146/211] md: dont dereference mddev after export_rdev()
Date:   Wed, 20 Sep 2023 13:29:50 +0200
Message-ID: <20230920112850.380502337@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 7deac114be5fb25a4e865212ed0feaf5f85f2a28 ]

Except for initial reference, mddev->kobject is referenced by
rdev->kobject, and if the last rdev is freed, there is no guarantee that
mddev is still valid. Hence mddev should not be used anymore after
export_rdev().

This problem can be triggered by following test for mdadm at very
low rate:

New file: mdadm/tests/23rdev-lifetime

devname=${dev0##*/}
devt=`cat /sys/block/$devname/dev`
pid=""
runtime=2

clean_up_test() {
        pill -9 $pid
        echo clear > /sys/block/md0/md/array_state
}

trap 'clean_up_test' EXIT

add_by_sysfs() {
        while true; do
                echo $devt > /sys/block/md0/md/new_dev
        done
}

remove_by_sysfs(){
        while true; do
                echo remove > /sys/block/md0/md/dev-${devname}/state
        done
}

echo md0 > /sys/module/md_mod/parameters/new_array || die "create md0 failed"

add_by_sysfs &
pid="$pid $!"

remove_by_sysfs &
pid="$pid $!"

sleep $runtime
exit 0

Test cmd:

./test --save-logs --logdir=/tmp/ --keep-going --dev=loop --tests=23rdev-lifetime

Test result:

general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6bcb: 0000 [#4] PREEMPT SMP
CPU: 0 PID: 1292 Comm: test Tainted: G      D W          6.5.0-rc2-00121-g01e55c376936 #562
RIP: 0010:md_wakeup_thread+0x9e/0x320 [md_mod]
Call Trace:
 <TASK>
 mddev_unlock+0x1b6/0x310 [md_mod]
 rdev_attr_store+0xec/0x190 [md_mod]
 sysfs_kf_write+0x52/0x70
 kernfs_fop_write_iter+0x19a/0x2a0
 vfs_write+0x3b5/0x770
 ksys_write+0x74/0x150
 __x64_sys_write+0x22/0x30
 do_syscall_64+0x40/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fix this problem by don't dereference mddev after export_rdev().

Fixes: 3ce94ce5d05a ("md: fix duplicate filename for rdev")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230825025532.1523008-2-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2a4a3d3039fae..fba2809cd384a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -798,14 +798,14 @@ void mddev_unlock(struct mddev *mddev)
 	} else
 		mutex_unlock(&mddev->reconfig_mutex);
 
+	md_wakeup_thread(mddev->thread);
+	wake_up(&mddev->sb_wait);
+
 	list_for_each_entry_safe(rdev, tmp, &delete, same_set) {
 		list_del_init(&rdev->same_set);
 		kobject_del(&rdev->kobj);
 		export_rdev(rdev, mddev);
 	}
-
-	md_wakeup_thread(mddev->thread);
-	wake_up(&mddev->sb_wait);
 }
 EXPORT_SYMBOL_GPL(mddev_unlock);
 
-- 
2.40.1



