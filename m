Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6876AF4A
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjHAJqq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjHAJqY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:46:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A292421D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF62461511
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE952C433C8;
        Tue,  1 Aug 2023 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883096;
        bh=hZiqTLPZXYoX5V1TR41waoId9oi2nQrkl5lKTbqUuQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scDBGB3VbHKF1MyvJKT63nxlhFPWfXEHNpILlzKE0C0OZ5OvklnNvq91LoOI3HeaC
         fRXOoVCcBHkrRlpx9ZrDdsnOqVPfa0rkZq1TGrZCVLC+6O26cyyVZRtfKJAcVUVDht
         e8rbOxOIMoWg3eG+hKuOjU5OTxXfdxnirwXVj7U0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 113/239] RDMA/bnxt_re: use shadow qd while posting non blocking rcfw command
Date:   Tue,  1 Aug 2023 11:19:37 +0200
Message-ID: <20230801091929.810834555@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kashyap Desai <kashyap.desai@broadcom.com>

[ Upstream commit 65288a22ddd81422a2a2a10c15df976a5332e41b ]

Whenever there is a fast path IO and create/destroy resources from
the slow path is happening in parallel, we may notice high latency
of slow path command completion.

Introduces a shadow queue depth to prevent the outstanding requests
to the FW. Driver will not allow more than #RCFW_CMD_NON_BLOCKING_SHADOW_QD
non-blocking commands to the Firmware.

Shadow queue depth is a soft limit only for non-blocking
commands. Blocking commands will be posted to the firmware
as long as there is a free slot.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/1686308514-11996-8-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 29900bf351e1 ("RDMA/bnxt_re: Fix hang during driver unload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 60 +++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  3 ++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index bfa0f29c7abf4..42484a1149c7c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -281,8 +281,21 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	return 0;
 }
 
-int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
-				 struct bnxt_qplib_cmdqmsg *msg)
+/**
+ * __bnxt_qplib_rcfw_send_message   -	qplib interface to send
+ * and complete rcfw command.
+ * @rcfw      -   rcfw channel instance of rdev
+ * @msg      -    qplib message internal
+ *
+ * This function does not account shadow queue depth. It will send
+ * all the command unconditionally as long as send queue is not full.
+ *
+ * Returns:
+ * 0 if command completed by firmware.
+ * Non zero if the command is not completed by firmware.
+ */
+static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
+					  struct bnxt_qplib_cmdqmsg *msg)
 {
 	struct creq_qp_event *evnt = (struct creq_qp_event *)msg->resp;
 	u16 cookie;
@@ -331,6 +344,48 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	return rc;
 }
+
+/**
+ * bnxt_qplib_rcfw_send_message   -	qplib interface to send
+ * and complete rcfw command.
+ * @rcfw      -   rcfw channel instance of rdev
+ * @msg      -    qplib message internal
+ *
+ * Driver interact with Firmware through rcfw channel/slow path in two ways.
+ * a. Blocking rcfw command send. In this path, driver cannot hold
+ * the context for longer period since it is holding cpu until
+ * command is not completed.
+ * b. Non-blocking rcfw command send. In this path, driver can hold the
+ * context for longer period. There may be many pending command waiting
+ * for completion because of non-blocking nature.
+ *
+ * Driver will use shadow queue depth. Current queue depth of 8K
+ * (due to size of rcfw message there can be actual ~4K rcfw outstanding)
+ * is not optimal for rcfw command processing in firmware.
+ *
+ * Restrict at max #RCFW_CMD_NON_BLOCKING_SHADOW_QD Non-Blocking rcfw commands.
+ * Allow all blocking commands until there is no queue full.
+ *
+ * Returns:
+ * 0 if command completed by firmware.
+ * Non zero if the command is not completed by firmware.
+ */
+int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
+				 struct bnxt_qplib_cmdqmsg *msg)
+{
+	int ret;
+
+	if (!msg->block) {
+		down(&rcfw->rcfw_inflight);
+		ret = __bnxt_qplib_rcfw_send_message(rcfw, msg);
+		up(&rcfw->rcfw_inflight);
+	} else {
+		ret = __bnxt_qplib_rcfw_send_message(rcfw, msg);
+	}
+
+	return ret;
+}
+
 /* Completions */
 static int bnxt_qplib_process_func_event(struct bnxt_qplib_rcfw *rcfw,
 					 struct creq_func_event *func_event)
@@ -937,6 +992,7 @@ int bnxt_qplib_enable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw,
 		return rc;
 	}
 
+	sema_init(&rcfw->rcfw_inflight, RCFW_CMD_NON_BLOCKING_SHADOW_QD);
 	bnxt_qplib_start_rcfw(rcfw);
 
 	return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 92f7a25533d3b..675c388348827 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -67,6 +67,8 @@ static inline void bnxt_qplib_rcfw_cmd_prep(struct cmdq_base *req,
 	req->cmd_size = cmd_size;
 }
 
+/* Shadow queue depth for non blocking command */
+#define RCFW_CMD_NON_BLOCKING_SHADOW_QD	64
 #define RCFW_CMD_WAIT_TIME_MS		20000 /* 20 Seconds timeout */
 
 /* CMDQ elements */
@@ -201,6 +203,7 @@ struct bnxt_qplib_rcfw {
 	u64 oos_prev;
 	u32 init_oos_stats;
 	u32 cmdq_depth;
+	struct semaphore rcfw_inflight;
 };
 
 struct bnxt_qplib_cmdqmsg {
-- 
2.40.1



