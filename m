Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9776AF49
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjHAJqn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjHAJqV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447BC3ABF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D6C6151D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7B5C433C8;
        Tue,  1 Aug 2023 09:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883093;
        bh=sMRj6gYhlRz0CR6fY7CG8S9UZkKoww4VQMdZp06Br1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5FbAsKKgGTIo77ns6bC0xfKsySYEyvGqqPAJ45jT257q1N5BKQvc6WC7Rsx49/S7
         9z1syTfcSatC/jmIBBQjBFRN/wbrERcqs5c3AJjbzNFgp+PvD6rqGH4P6RUfcfsyMp
         XArbB914leNtQ9V9AqYD+ih6D8h9hrU4n/V09MiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 112/239] RDMA/bnxt_re: Avoid the command wait if firmware is inactive
Date:   Tue,  1 Aug 2023 11:19:36 +0200
Message-ID: <20230801091929.770356732@linuxfoundation.org>
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

[ Upstream commit 3022cc15119733cebaef05feddb5d87b9e401c0e ]

Add a check to avoid waiting if driver already detects a
FW timeout. Return success for resource destroy in case
the device is detached. Add helper function to map timeout
error code to success.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/1686308514-11996-7-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 29900bf351e1 ("RDMA/bnxt_re: Fix hang during driver unload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 52 ++++++++++++++++++++--
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 918e588588885..bfa0f29c7abf4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -53,10 +53,47 @@
 
 static void bnxt_qplib_service_creq(struct tasklet_struct *t);
 
+/**
+ * bnxt_qplib_map_rc  -  map return type based on opcode
+ * @opcode    -  roce slow path opcode
+ *
+ * In some cases like firmware halt is detected, the driver is supposed to
+ * remap the error code of the timed out command.
+ *
+ * It is not safe to assume hardware is really inactive so certain opcodes
+ * like destroy qp etc are not safe to be returned success, but this function
+ * will be called when FW already reports a timeout. This would be possible
+ * only when FW crashes and resets. This will clear all the HW resources.
+ *
+ * Returns:
+ * 0 to communicate success to caller.
+ * Non zero error code to communicate failure to caller.
+ */
+static int bnxt_qplib_map_rc(u8 opcode)
+{
+	switch (opcode) {
+	case CMDQ_BASE_OPCODE_DESTROY_QP:
+	case CMDQ_BASE_OPCODE_DESTROY_SRQ:
+	case CMDQ_BASE_OPCODE_DESTROY_CQ:
+	case CMDQ_BASE_OPCODE_DEALLOCATE_KEY:
+	case CMDQ_BASE_OPCODE_DEREGISTER_MR:
+	case CMDQ_BASE_OPCODE_DELETE_GID:
+	case CMDQ_BASE_OPCODE_DESTROY_QP1:
+	case CMDQ_BASE_OPCODE_DESTROY_AH:
+	case CMDQ_BASE_OPCODE_DEINITIALIZE_FW:
+	case CMDQ_BASE_OPCODE_MODIFY_ROCE_CC:
+	case CMDQ_BASE_OPCODE_SET_LINK_AGGR_MODE:
+		return 0;
+	default:
+		return -ETIMEDOUT;
+	}
+}
+
 /**
  * __wait_for_resp   -	Don't hold the cpu context and wait for response
  * @rcfw      -   rcfw channel instance of rdev
  * @cookie    -   cookie to track the command
+ * @opcode    -   rcfw submitted for given opcode
  *
  * Wait for command completion in sleepable context.
  *
@@ -64,7 +101,7 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t);
  * 0 if command is completed by firmware.
  * Non zero error code for rest of the case.
  */
-static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
+static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq;
 	u16 cbit;
@@ -74,6 +111,9 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 	cbit = cookie % rcfw->cmdq_depth;
 
 	do {
+		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
+			return bnxt_qplib_map_rc(opcode);
+
 		/* Non zero means command completed */
 		ret = wait_event_timeout(cmdq->waitq,
 					 !test_bit(cbit, cmdq->cmdq_bitmap),
@@ -94,6 +134,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
  * __block_for_resp   -	hold the cpu context and wait for response
  * @rcfw      -   rcfw channel instance of rdev
  * @cookie    -   cookie to track the command
+ * @opcode    -   rcfw submitted for given opcode
  *
  * This function will hold the cpu (non-sleepable context) and
  * wait for command completion. Maximum holding interval is 8 second.
@@ -102,7 +143,7 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
  * -ETIMEOUT if command is not completed in specific time interval.
  * 0 if command is completed by firmware.
  */
-static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
+static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
 	unsigned long issue_time = 0;
@@ -112,6 +153,9 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 	issue_time = jiffies;
 
 	do {
+		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
+			return bnxt_qplib_map_rc(opcode);
+
 		udelay(1);
 
 		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
@@ -267,9 +311,9 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 	} while (retry_cnt--);
 
 	if (msg->block)
-		rc = __block_for_resp(rcfw, cookie);
+		rc = __block_for_resp(rcfw, cookie, opcode);
 	else
-		rc = __wait_for_resp(rcfw, cookie);
+		rc = __wait_for_resp(rcfw, cookie, opcode);
 	if (rc) {
 		/* timed out */
 		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x timedout (%d)msec\n",
-- 
2.40.1



