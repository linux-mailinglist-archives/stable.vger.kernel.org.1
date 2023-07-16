Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93437554A1
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjGPUc2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjGPUc1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:32:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6009F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:32:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2B1860EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C68C433C7;
        Sun, 16 Jul 2023 20:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539546;
        bh=xjDmeQhu9wh2E3dfIi6488d6FXt3ReDiKcW7QIYxEgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x8BgQ43HFq+d/mbzkQ+u87zhfigP3NOTSYwNs9eYyrrUctT5EaMnLf0dZtT9ebtn0
         hU4bzFBycDfaAbe7JFIsBJSnYWrUQ7xowkO52CpKlcVKXY3AYjQjagwjd6RqHp6Fm8
         mwUS9GmtWoOBDNPtyH9DB3K+SmWw6u0t0GxhtzzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 018/591] nvme-auth: no need to reset chap contexts on re-authentication
Date:   Sun, 16 Jul 2023 21:42:37 +0200
Message-ID: <20230716194924.334475947@linuxfoundation.org>
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

[ Upstream commit e8a420efb637f52c586596283d6fd96f2a7ecb5c ]

Now that the chap context is reset upon completion, this is no longer
needed. Also remove nvme_auth_reset as no callers are left.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: a836ca33c5b0 ("nvme-core: fix memory leak in dhchap_secret_store")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 13 -------------
 drivers/nvme/host/core.c |  4 ----
 drivers/nvme/host/nvme.h |  1 -
 3 files changed, 18 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 2f823c6b84fd3..1a27d7fb4fa91 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -920,19 +920,6 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_wait);
 
-void nvme_auth_reset(struct nvme_ctrl *ctrl)
-{
-	struct nvme_dhchap_queue_context *chap;
-
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		flush_work(&chap->auth_work);
-		nvme_auth_reset_dhchap(chap);
-	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
-}
-
 static void nvme_ctrl_auth_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7d9b5b42b388..b63511f481a7f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3832,8 +3832,6 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		host_key = ctrl->host_key;
 		ctrl->host_key = key;
 		nvme_auth_free_key(host_key);
-		/* Key has changed; re-authentication with new key */
-		nvme_auth_reset(ctrl);
 	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
@@ -3886,8 +3884,6 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		ctrl_key = ctrl->ctrl_key;
 		ctrl->ctrl_key = key;
 		nvme_auth_free_key(ctrl_key);
-		/* Key has changed; re-authentication with new key */
-		nvme_auth_reset(ctrl);
 	}
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2aa514c3dfa17..5ed771d576c6d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1032,7 +1032,6 @@ void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_auth_stop(struct nvme_ctrl *ctrl);
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
-void nvme_auth_reset(struct nvme_ctrl *ctrl);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
 #else
 static inline void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
-- 
2.39.2



