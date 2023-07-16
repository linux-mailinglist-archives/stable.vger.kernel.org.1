Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE79975515B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjGPTzc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGPTzb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:55:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3E1E59
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F20B160EAD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A40C433C7;
        Sun, 16 Jul 2023 19:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537328;
        bh=8PeE0NeHfxqHH9fz+9T4gSWagrat7kxe+235Slk2JQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLJvQLYyK/u0ELaTBQbF3y+aZolkIOaIqbejphLinx0pRuXIYvO1FfwT/x3ZYuo90
         nqdmzxgUvt6mnU4nywNYZ6yHD8lEdkFbiKh4tLYdqpWUESjl7GLSrO0kO7GqZoFf6Z
         zNfCF5bibNreHPnhotn2trYON6Xj3venbAr25QBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chaitanya Kulkarni <kch@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 029/800] nvme-core: fix memory leak in dhchap_secret_store
Date:   Sun, 16 Jul 2023 21:38:02 +0200
Message-ID: <20230716194949.775438639@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

[ Upstream commit a836ca33c5b07d34dd5347af9f64d25651d12674 ]

Free dhchap_secret in nvme_ctrl_dhchap_secret_store() before we return
fix following kmemleack:-

unreferenced object 0xffff8886376ea800 (size 64):
  comm "check", pid 22048, jiffies 4344316705 (age 92.199s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 6e 78 72 35 4b 67  DHHC-1:00:nxr5Kg
    75 58 34 75 6f 41 78 73 4a 61 34 63 2f 68 75 4c  uX4uoAxsJa4c/huL
  backtrace:
    [<0000000030ce5d4b>] __kmalloc+0x4b/0x130
    [<000000009be1cdc1>] nvme_ctrl_dhchap_secret_store+0x8f/0x160 [nvme_core]
    [<00000000ac06c96a>] kernfs_fop_write_iter+0x12b/0x1c0
    [<00000000437e7ced>] vfs_write+0x2ba/0x3c0
    [<00000000f9491baf>] ksys_write+0x5f/0xe0
    [<000000001c46513d>] do_syscall_64+0x3b/0x90
    [<00000000ecf348fe>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff8886376eaf00 (size 64):
  comm "check", pid 22048, jiffies 4344316736 (age 92.168s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 6e 78 72 35 4b 67  DHHC-1:00:nxr5Kg
    75 58 34 75 6f 41 78 73 4a 61 34 63 2f 68 75 4c  uX4uoAxsJa4c/huL
  backtrace:
    [<0000000030ce5d4b>] __kmalloc+0x4b/0x130
    [<000000009be1cdc1>] nvme_ctrl_dhchap_secret_store+0x8f/0x160 [nvme_core]
    [<00000000ac06c96a>] kernfs_fop_write_iter+0x12b/0x1c0
    [<00000000437e7ced>] vfs_write+0x2ba/0x3c0
    [<00000000f9491baf>] ksys_write+0x5f/0xe0
    [<000000001c46513d>] do_syscall_64+0x3b/0x90
    [<00000000ecf348fe>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3ec38e2b91732..c2096f0d50537 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3872,8 +3872,10 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		int ret;
 
 		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
+		if (ret) {
+			kfree(dhchap_secret);
 			return ret;
+		}
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		host_key = ctrl->host_key;
@@ -3881,7 +3883,8 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		ctrl->host_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		nvme_auth_free_key(host_key);
-	}
+	} else
+		kfree(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-- 
2.39.2



