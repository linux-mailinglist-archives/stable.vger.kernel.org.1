Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C471A72C0B1
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbjFLKyI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjFLKxr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:53:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B280E46B2
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91D1161BD9
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EBCC433EF;
        Mon, 12 Jun 2023 10:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566333;
        bh=zkcYIc5sPGXzuj58X5j25whufhu7Btaiwh7++5t5GBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CXDLPOSEI/Gp2LE16JuL8WhtF0rlEw1fmxmyiqeDeDmz5NDqQ8DOrvH4z4ifvNCrY
         1XBqUKXXrie4dbS+Zj2GogXBZcCEnGcEgUuQJidL0LSI9dQOERkgs5hrWGKP9Cvpdz
         tcroU3PIPFgsKTgYm7q3evvNnqyIT4jjXBk0k6Vc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Xie Yongji" <xieyongji@bytedance.com>,
        Xianjun Zeng <zengxianjun@bytedance.com>,
        Sheng Zhao <sheng.zhao@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 84/91] vduse: avoid empty string for dev name
Date:   Mon, 12 Jun 2023 12:27:13 +0200
Message-ID: <20230612101705.626294763@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 3467c75f310a5..30ae4237f3dd4 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1254,6 +1254,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
 	if (config->vq_num > 0xffff)
 		return false;
 
+	if (!config->name[0])
+		return false;
+
 	if (!device_is_allowed(config->device_id))
 		return false;
 
-- 
2.39.2



