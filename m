Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38574C222
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjGILRJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGILRI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:17:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DB0B5
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58A6760BCA
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4197DC433C7;
        Sun,  9 Jul 2023 11:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901426;
        bh=LZ6cU4wVkeQV9MtcwOUSUpz8d6DAXAFfJ6MRTPmq8ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CskBbvyr/nAttZ/GqFa6+uzgxwdqs7QSUUOKxYO96fQRKZhwKb4g5tadXKI/tCim8
         HCc5DLxJ2UxKRMmCtJyPythtZbmljz+7H/17I5PMPUYpxThakaOju0u+F440YNOeaA
         xL27NCThqc+lKa3TRLWbGiI9XMfvCiAs5QBLBX/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chaitanya Kulkarni <kch@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 017/431] nvme-core: fix dev_pm_qos memleak
Date:   Sun,  9 Jul 2023 13:09:25 +0200
Message-ID: <20230709111451.510283413@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

[ Upstream commit 7ed5cf8e6d9bfb6a78d0471317edff14f0f2b4dd ]

Call dev_pm_qos_hide_latency_tolerance() in the error unwind patch to
avoid following kmemleak:-

blktests (master) # kmemleak-clear; ./check nvme/044;
blktests (master) # kmemleak-scan ; kmemleak-show
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  2.111s  ...  2.124s
unreferenced object 0xffff888110c46240 (size 96):
  comm "nvme", pid 33461, jiffies 4345365353 (age 75.586s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000069ac2cec>] kmalloc_trace+0x25/0x90
    [<000000006acc66d5>] dev_pm_qos_update_user_latency_tolerance+0x6f/0x100
    [<00000000cc376ea7>] nvme_init_ctrl+0x38e/0x410 [nvme_core]
    [<000000007df61b4b>] 0xffffffffc05e88b3
    [<00000000d152b985>] 0xffffffffc05744cb
    [<00000000f04a4041>] vfs_write+0xc5/0x3c0
    [<00000000f9491baf>] ksys_write+0x5f/0xe0
    [<000000001c46513d>] do_syscall_64+0x3b/0x90
    [<00000000ecf348fe>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

Link: https://lore.kernel.org/linux-nvme/CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+StmzOUgWUrA@mail.gmail.com/
Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f07fd2fed3f9d..8d8403b65e1b3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5250,6 +5250,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	return 0;
 out_free_cdev:
 	nvme_fault_inject_fini(&ctrl->fault_inject);
+	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 out_free_name:
 	nvme_put_ctrl(ctrl);
-- 
2.39.2



