Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3A4755487
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjGPUbV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjGPUbU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:31:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5729F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5991860E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC51C433C8;
        Sun, 16 Jul 2023 20:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539478;
        bh=gi6bl1L5R6UYGDoOwdY9l7MyoGfhc0hEWHGcsODqnIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVmE99dQNQbzPt7a3gYBF0MR8Xu0u+3LafQ+gINqqGzMfA3ElzA2lgfIxFr5A4Bhe
         9Y3TeTryZ2PaZD8sLUIe1fYi6HL4ogRqJgMIYw3olBWDjQy+EyyuvRaEkyMt0QZZ/m
         Fixhh2l2qEmP9geEG2yQOqxW7zUZgUzfrPHKUGVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chaitanya Kulkarni <kch@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 022/591] nvme-core: add missing fault-injection cleanup
Date:   Sun, 16 Jul 2023 21:42:41 +0200
Message-ID: <20230716194924.437527830@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Chaitanya Kulkarni <kch@nvidia.com>

[ Upstream commit 3a12a0b868a512fcada564699d00f5e652c0998c ]

Add missing fault-injection cleanup in nvme_init_ctrl() in the error
unwind path that also fixes following message for blktests:-

linux-block (for-next) # grep debugfs debugfs-err.log
[  147.853464] debugfs: Directory 'nvme1' with parent '/' already present!
[  147.853973] nvme1: failed to create debugfs attr
[  148.802490] debugfs: Directory 'nvme1' with parent '/' already present!
[  148.803244] nvme1: failed to create debugfs attr
[  148.877304] debugfs: Directory 'nvme1' with parent '/' already present!
[  148.877775] nvme1: failed to create debugfs attr
[  149.816652] debugfs: Directory 'nvme1' with parent '/' already present!
[  149.818011] nvme1: failed to create debugfs attr

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: 7ed5cf8e6d9b ("nvme-core: fix dev_pm_qos memleak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 09ff0d75aaf38..8414e1a036464 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5177,6 +5177,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	return 0;
 out_free_cdev:
+	nvme_fault_inject_fini(&ctrl->fault_inject);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 out_free_name:
 	nvme_put_ctrl(ctrl);
-- 
2.39.2



