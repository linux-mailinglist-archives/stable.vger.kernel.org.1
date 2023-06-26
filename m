Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB1B73E83B
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjFZSX4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjFZSXf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27912728
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F78060F61
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E422FC433C8;
        Mon, 26 Jun 2023 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803738;
        bh=Z1Bnyqeoc3Iccaq7fxP/0wNkS69L82XABxHWGwS1vXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMW2fACb24yVpEMPewIOfIjmkt8Scn6ZwH8o6aVlgoxeibdFIy2uJcm5qDv0C8mwC
         8nvKoxwxuuK3jjBVD7UNa5WmhSomlY5+ndgh1xT3OQNcFFkLawy9ZUI6P7yrNvLmMK
         b1M9d8mCPrKPH6JdS4deXuGu8MytHrLRBMQFCw8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "min15.li" <min15.li@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 161/199] nvme: fix miss command type check
Date:   Mon, 26 Jun 2023 20:11:07 +0200
Message-ID: <20230626180812.726255895@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: min15.li <min15.li@samsung.com>

[ Upstream commit 31a5978243d24d77be4bacca56c78a0fbc43b00d ]

In the function nvme_passthru_end(), only the value of the command
opcode is checked, without checking the command type (IO command or
Admin command). When we send a Dataset Management command (The opcode
of the Dataset Management command is the same as the Set Feature
command), kernel thinks it is a set feature command, then sets the
controller's keep alive interval, and calls nvme_keep_alive_work().

Signed-off-by: min15.li <min15.li@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c       | 4 +++-
 drivers/nvme/host/ioctl.c      | 2 +-
 drivers/nvme/host/nvme.h       | 2 +-
 drivers/nvme/target/passthru.c | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c015393beeee8..f12109230dc8d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1115,7 +1115,7 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, NVME_TARGET_PASSTHRU);
 
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
@@ -1132,6 +1132,8 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
+	if (ns)
+		return;
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d24ea2e051564..0264ec74a4361 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -254,7 +254,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	blk_mq_free_request(req);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, cmd, ret);
+		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
 
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2d4f59e0535a..2dd52739236e1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1077,7 +1077,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
 int nvme_execute_rq(struct request *rq, bool at_head);
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 511c980d538df..71a9c1cc57f59 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -243,7 +243,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	blk_mq_free_request(rq);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, req->cmd, status);
+		nvme_passthru_end(ctrl, ns, effects, req->cmd, status);
 }
 
 static enum rq_end_io_ret nvmet_passthru_req_done(struct request *rq,
-- 
2.39.2



