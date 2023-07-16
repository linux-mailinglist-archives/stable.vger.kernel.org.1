Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CAA7554A4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjGPUci (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjGPUcg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:32:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980AEBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:32:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E7860EBB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B0FC433C8;
        Sun, 16 Jul 2023 20:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539554;
        bh=YXvYdF+Qwxgwp1C3JL3h5U5vYkGcLm1MqW0tFTIq1Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUutq2mCxEh8GEPXSaqsLjBdBRTSyvypKGfo9IWibDbKqzJZSYh6qkiNIuvI7DrRy
         RJ0Z2FwHSQOCdhBUIO3LJ+tfiv6VpQJE5g8b2fTVQzZDMcZQ36Rlbs5h7bGizpDj2q
         QyOLqIsl+XZ7qqMyAZ7dgw7F2tQ4rKyzISbQqp9Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 021/591] nvme-auth: dont ignore key generation failures when initializing ctrl keys
Date:   Sun, 16 Jul 2023 21:42:40 +0200
Message-ID: <20230716194924.412386163@linuxfoundation.org>
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 193a8c7e5f1a8481841636cec9c185543ec5c759 ]

nvme_auth_generate_key can fail, don't ignore it upon initialization.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 7ed5cf8e6d9b ("nvme-core: fix dev_pm_qos memleak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 19 +++++++++++++++----
 drivers/nvme/host/core.c |  6 +++++-
 drivers/nvme/host/nvme.h |  7 +++++--
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 1a27d7fb4fa91..9dfd3d0293054 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -956,15 +956,26 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 	 */
 }
 
-void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
+int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
+	int ret;
+
 	INIT_LIST_HEAD(&ctrl->dhchap_auth_list);
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	mutex_init(&ctrl->dhchap_auth_mutex);
 	if (!ctrl->opts)
-		return;
-	nvme_auth_generate_key(ctrl->opts->dhchap_secret, &ctrl->host_key);
-	nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret, &ctrl->ctrl_key);
+		return 0;
+	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
+			&ctrl->host_key);
+	if (ret)
+		return ret;
+	ret = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
+			&ctrl->ctrl_key);
+	if (ret) {
+		nvme_auth_free_key(ctrl->host_key);
+		ctrl->host_key = NULL;
+	}
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2b07a67958b46..09ff0d75aaf38 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5171,9 +5171,13 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 	nvme_mpath_init_ctrl(ctrl);
-	nvme_auth_init_ctrl(ctrl);
+	ret = nvme_auth_init_ctrl(ctrl);
+	if (ret)
+		goto out_free_cdev;
 
 	return 0;
+out_free_cdev:
+	cdev_device_del(&ctrl->cdev, ctrl->device);
 out_free_name:
 	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5ed771d576c6d..69f9e69208f68 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1028,13 +1028,16 @@ static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 }
 
 #ifdef CONFIG_NVME_AUTH
-void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
+int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_auth_stop(struct nvme_ctrl *ctrl);
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
 #else
-static inline void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
+static inline int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
+{
+	return 0;
+}
 static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
 static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 {
-- 
2.39.2



