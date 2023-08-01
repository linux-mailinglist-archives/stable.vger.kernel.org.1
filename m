Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88E576AF4C
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjHAJqs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjHAJq0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:46:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BC94225
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB9EB61521
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70E6C433C7;
        Tue,  1 Aug 2023 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883099;
        bh=Tw6hD+fiFWKtO5y1N4QWvgp8CyJLAdZvCdTCpTmNrvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GpDnZ/fLjcniHDbf25OSdaGORWu5vAmADlZ3sm16hEoNw0+hg1ILpXJWjtlfzChB+
         Z7Bz/bh0Yce6eGtKnq9weguCi4I0X38I7u1DCxoe6wSJQ8zprPAF2hsoxKrUq3ol1J
         w10BtYmciNXAtrvAKtKYTbvQDNsBT34r2pHuwwMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 114/239] RDMA/bnxt_re: Simplify the function that sends the FW commands
Date:   Tue,  1 Aug 2023 11:19:38 +0200
Message-ID: <20230801091929.844728441@linuxfoundation.org>
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

[ Upstream commit 159cf95e42a7ca7375646fab82c0056cbb71f9e9 ]

 - Use __send_message_basic_sanity helper function.
 - Do not retry posting same command if there is a queue full detection.
 - ENXIO is used to indicate controller recovery.
 - In the case of ERR_DEVICE_DETACHED state, the driver should not post
   commands to the firmware, but also return fabricated written code.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/1686308514-11996-9-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 29900bf351e1 ("RDMA/bnxt_re: Fix hang during driver unload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 125 +++++++++++----------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  22 ++++
 2 files changed, 86 insertions(+), 61 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 42484a1149c7c..f867507d427f9 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -170,34 +170,22 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 			  struct bnxt_qplib_cmdqmsg *msg)
 {
-	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
-	struct bnxt_qplib_hwq *hwq = &cmdq->hwq;
+	u32 bsize, opcode, free_slots, required_slots;
+	struct bnxt_qplib_cmdq_ctx *cmdq;
 	struct bnxt_qplib_crsqe *crsqe;
 	struct bnxt_qplib_cmdqe *cmdqe;
+	struct bnxt_qplib_hwq *hwq;
 	u32 sw_prod, cmdq_prod;
 	struct pci_dev *pdev;
 	unsigned long flags;
-	u32 bsize, opcode;
 	u16 cookie, cbit;
 	u8 *preq;
 
+	cmdq = &rcfw->cmdq;
+	hwq = &cmdq->hwq;
 	pdev = rcfw->pdev;
 
 	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
-	if (!test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
-	    (opcode != CMDQ_BASE_OPCODE_QUERY_FUNC &&
-	     opcode != CMDQ_BASE_OPCODE_INITIALIZE_FW &&
-	     opcode != CMDQ_BASE_OPCODE_QUERY_VERSION)) {
-		dev_err(&pdev->dev,
-			"RCFW not initialized, reject opcode 0x%x\n", opcode);
-		return -EINVAL;
-	}
-
-	if (test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
-	    opcode == CMDQ_BASE_OPCODE_INITIALIZE_FW) {
-		dev_err(&pdev->dev, "RCFW already initialized!\n");
-		return -EINVAL;
-	}
 
 	if (test_bit(FIRMWARE_TIMED_OUT, &cmdq->flags))
 		return -ETIMEDOUT;
@@ -206,40 +194,37 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	 * cmdqe
 	 */
 	spin_lock_irqsave(&hwq->lock, flags);
-	if (msg->req->cmd_size >= HWQ_FREE_SLOTS(hwq)) {
-		dev_err(&pdev->dev, "RCFW: CMDQ is full!\n");
+	required_slots = bnxt_qplib_get_cmd_slots(msg->req);
+	free_slots = HWQ_FREE_SLOTS(hwq);
+	cookie = cmdq->seq_num & RCFW_MAX_COOKIE_VALUE;
+	cbit = cookie % rcfw->cmdq_depth;
+
+	if (required_slots >= free_slots ||
+	    test_bit(cbit, cmdq->cmdq_bitmap)) {
+		dev_info_ratelimited(&pdev->dev,
+				     "CMDQ is full req/free %d/%d!",
+				     required_slots, free_slots);
 		spin_unlock_irqrestore(&hwq->lock, flags);
 		return -EAGAIN;
 	}
-
-
-	cookie = cmdq->seq_num & RCFW_MAX_COOKIE_VALUE;
-	cbit = cookie % rcfw->cmdq_depth;
 	if (msg->block)
 		cookie |= RCFW_CMD_IS_BLOCKING;
-
 	set_bit(cbit, cmdq->cmdq_bitmap);
 	__set_cmdq_base_cookie(msg->req, msg->req_sz, cpu_to_le16(cookie));
 	crsqe = &rcfw->crsqe_tbl[cbit];
-	if (crsqe->resp) {
-		spin_unlock_irqrestore(&hwq->lock, flags);
-		return -EBUSY;
-	}
-
-	/* change the cmd_size to the number of 16byte cmdq unit.
-	 * req->cmd_size is modified here
-	 */
 	bsize = bnxt_qplib_set_cmd_slots(msg->req);
-
-	memset(msg->resp, 0, sizeof(*msg->resp));
+	crsqe->free_slots = free_slots;
 	crsqe->resp = (struct creq_qp_event *)msg->resp;
 	crsqe->resp->cookie = cpu_to_le16(cookie);
 	crsqe->req_size = __get_cmdq_base_cmd_size(msg->req, msg->req_sz);
 	if (__get_cmdq_base_resp_size(msg->req, msg->req_sz) && msg->sb) {
 		struct bnxt_qplib_rcfw_sbuf *sbuf = msg->sb;
-		__set_cmdq_base_resp_addr(msg->req, msg->req_sz, cpu_to_le64(sbuf->dma_addr));
+
+		__set_cmdq_base_resp_addr(msg->req, msg->req_sz,
+					  cpu_to_le64(sbuf->dma_addr));
 		__set_cmdq_base_resp_size(msg->req, msg->req_sz,
-					  ALIGN(sbuf->size, BNXT_QPLIB_CMDQE_UNITS));
+					  ALIGN(sbuf->size,
+						BNXT_QPLIB_CMDQE_UNITS));
 	}
 
 	preq = (u8 *)msg->req;
@@ -247,11 +232,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 		/* Locate the next cmdq slot */
 		sw_prod = HWQ_CMP(hwq->prod, hwq);
 		cmdqe = bnxt_qplib_get_qe(hwq, sw_prod, NULL);
-		if (!cmdqe) {
-			dev_err(&pdev->dev,
-				"RCFW request failed with no cmdqe!\n");
-			goto done;
-		}
 		/* Copy a segment of the req cmd to the cmdq */
 		memset(cmdqe, 0, sizeof(*cmdqe));
 		memcpy(cmdqe, preq, min_t(u32, bsize, sizeof(*cmdqe)));
@@ -275,12 +255,43 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	wmb();
 	writel(cmdq_prod, cmdq->cmdq_mbox.prod);
 	writel(RCFW_CMDQ_TRIG_VAL, cmdq->cmdq_mbox.db);
-done:
 	spin_unlock_irqrestore(&hwq->lock, flags);
 	/* Return the CREQ response pointer */
 	return 0;
 }
 
+static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
+				       struct bnxt_qplib_cmdqmsg *msg)
+{
+	struct bnxt_qplib_cmdq_ctx *cmdq;
+	u32 opcode;
+
+	cmdq = &rcfw->cmdq;
+	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
+
+	/* Prevent posting if f/w is not in a state to process */
+	if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
+		return -ENXIO;
+
+	if (test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
+	    opcode == CMDQ_BASE_OPCODE_INITIALIZE_FW) {
+		dev_err(&rcfw->pdev->dev, "QPLIB: RCFW already initialized!");
+		return -EINVAL;
+	}
+
+	if (!test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
+	    (opcode != CMDQ_BASE_OPCODE_QUERY_FUNC &&
+	     opcode != CMDQ_BASE_OPCODE_INITIALIZE_FW &&
+	     opcode != CMDQ_BASE_OPCODE_QUERY_VERSION)) {
+		dev_err(&rcfw->pdev->dev,
+			"QPLIB: RCFW not initialized, reject opcode 0x%x",
+			opcode);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 /**
  * __bnxt_qplib_rcfw_send_message   -	qplib interface to send
  * and complete rcfw command.
@@ -299,29 +310,21 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 {
 	struct creq_qp_event *evnt = (struct creq_qp_event *)msg->resp;
 	u16 cookie;
-	u8 opcode, retry_cnt = 0xFF;
 	int rc = 0;
+	u8 opcode;
 
-	/* Prevent posting if f/w is not in a state to process */
-	if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
-		return 0;
+	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
 
-	do {
-		opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
-		rc = __send_message(rcfw, msg);
-		cookie = le16_to_cpu(__get_cmdq_base_cookie(msg->req, msg->req_sz)) &
-				RCFW_MAX_COOKIE_VALUE;
-		if (!rc)
-			break;
-		if (!retry_cnt || (rc != -EAGAIN && rc != -EBUSY)) {
-			/* send failed */
-			dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x send failed\n",
-				cookie, opcode);
-			return rc;
-		}
-		msg->block ? mdelay(1) : usleep_range(500, 1000);
+	rc = __send_message_basic_sanity(rcfw, msg);
+	if (rc)
+		return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
+
+	rc = __send_message(rcfw, msg);
+	if (rc)
+		return rc;
 
-	} while (retry_cnt--);
+	cookie = le16_to_cpu(__get_cmdq_base_cookie(msg->req, msg->req_sz))
+				& RCFW_MAX_COOKIE_VALUE;
 
 	if (msg->block)
 		rc = __block_for_resp(rcfw, cookie, opcode);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 675c388348827..43dc11febf46a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -91,6 +91,26 @@ static inline u32 bnxt_qplib_cmdqe_page_size(u32 depth)
 	return (bnxt_qplib_cmdqe_npages(depth) * PAGE_SIZE);
 }
 
+/* Get the number of command units required for the req. The
+ * function returns correct value only if called before
+ * setting using bnxt_qplib_set_cmd_slots
+ */
+static inline u32 bnxt_qplib_get_cmd_slots(struct cmdq_base *req)
+{
+	u32 cmd_units = 0;
+
+	if (HAS_TLV_HEADER(req)) {
+		struct roce_tlv *tlv_req = (struct roce_tlv *)req;
+
+		cmd_units = tlv_req->total_size;
+	} else {
+		cmd_units = (req->cmd_size + BNXT_QPLIB_CMDQE_UNITS - 1) /
+			    BNXT_QPLIB_CMDQE_UNITS;
+	}
+
+	return cmd_units;
+}
+
 static inline u32 bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
 {
 	u32 cmd_byte = 0;
@@ -134,6 +154,8 @@ typedef int (*aeq_handler_t)(struct bnxt_qplib_rcfw *, void *, void *);
 struct bnxt_qplib_crsqe {
 	struct creq_qp_event	*resp;
 	u32			req_size;
+	/* Free slots at the time of submission */
+	u32			free_slots;
 };
 
 struct bnxt_qplib_rcfw_sbuf {
-- 
2.40.1



