Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B7B72C259
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbjFLLEY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbjFLLEK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:04:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79F1E56
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45ED0614D7
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A33C4339B;
        Mon, 12 Jun 2023 10:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567132;
        bh=fpU5ZPUABeF7SQPQqbq1KpwVGT5Cgz00Eyj2p31Gq9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5IcQ0NZN7oSh4Dibo+42oD3hNZowY7nrHPBUnVGCcSq5EwgTs9ogXV6UkHb1wnsy
         WDrbK0DAbXUB3YNL+VUhZ8hIOCfXVbQ2WJZQU6xO9dj2WVeF9I9wZJhScqCRd8Z7k6
         3/CsGJOnadjj76M4ZwXvGxv5jBsojBAKFuGWHuHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Xie Yongji" <xieyongji@bytedance.com>,
        Xianjun Zeng <zengxianjun@bytedance.com>,
        Sheng Zhao <sheng.zhao@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 145/160] vduse: avoid empty string for dev name
Date:   Mon, 12 Jun 2023 12:27:57 +0200
Message-ID: <20230612101721.711650734@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Sheng Zhao <sheng.zhao@bytedance.com>

[ Upstream commit a90e8608eb0ed93d31ac0feb055f77ce59512542 ]

Syzkaller hits a kernel WARN when the first character of the dev name
provided is NULL. Solution is to add a NULL check before calling
cdev_device_add() in vduse_create_dev().

kobject: (0000000072042169): attempted to be registered with empty name!
WARNING: CPU: 0 PID: 112695 at lib/kobject.c:236
Call Trace:
 kobject_add_varg linux/src/lib/kobject.c:390 [inline]
 kobject_add+0xf6/0x150 linux/src/lib/kobject.c:442
 device_add+0x28f/0xc20 linux/src/drivers/base/core.c:2167
 cdev_device_add+0x83/0xc0 linux/src/fs/char_dev.c:546
 vduse_create_dev linux/src/drivers/vdpa/vdpa_user/vduse_dev.c:2254 [inline]
 vduse_ioctl+0x7b5/0xf30 linux/src/drivers/vdpa/vdpa_user/vduse_dev.c:2316
 vfs_ioctl linux/src/fs/ioctl.c:47 [inline]
 file_ioctl linux/src/fs/ioctl.c:510 [inline]
 do_vfs_ioctl+0x14b/0xa80 linux/src/fs/ioctl.c:697
 ksys_ioctl+0x7c/0xa0 linux/src/fs/ioctl.c:714
 __do_sys_ioctl linux/src/fs/ioctl.c:721 [inline]
 __se_sys_ioctl linux/src/fs/ioctl.c:719 [inline]
 __x64_sys_ioctl+0x42/0x50 linux/src/fs/ioctl.c:719
 do_syscall_64+0x94/0x330 linux/src/arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Cc: "Xie Yongji" <xieyongji@bytedance.com>
Reported-by: Xianjun Zeng <zengxianjun@bytedance.com>
Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
Message-Id: <20230530033626.1266794-1-sheng.zhao@bytedance.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Cc: "Michael S. Tsirkin"<mst@redhat.com>, "Jason Wang"<jasowang@redhat.com>,
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0c3b48616a9f3..695b20b17e010 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1443,6 +1443,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
 	if (config->vq_num > 0xffff)
 		return false;
 
+	if (!config->name[0])
+		return false;
+
 	if (!device_is_allowed(config->device_id))
 		return false;
 
-- 
2.39.2



