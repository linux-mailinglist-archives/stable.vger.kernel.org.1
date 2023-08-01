Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977ED76AF48
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjHAJqi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjHAJqS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:46:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6A43589
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ACC8614F3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B135C433C7;
        Tue,  1 Aug 2023 09:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883090;
        bh=PKHy9Qn5111xIxhC2pJTv5bxdgxZ9tk3qMk6GLllQ6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yh4Gj18YnyBag7rU9hlawW7JJ/ejjSi3bZ4mR9BaueY/yNwGe7ijPf7eYFJdJzW0+
         AB8uNWT/U+8D0ltTuNI+5VImDBbh6KQZjNW3qjebyJEeDojt6h1Zmy55zQQlGdN40W
         p6pgxCKB6teYoLIPe08VuIVBDlYS6OxjwUhcbrbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 111/239] RDMA/bnxt_re: Enhance the existing functions that wait for FW responses
Date:   Tue,  1 Aug 2023 11:19:35 +0200
Message-ID: <20230801091929.739558081@linuxfoundation.org>
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

[ Upstream commit 8cf1d12ad56beb73d2439ccf334b7148e71de58e ]

Use jiffies based timewait instead of counting iteration for
commands that block for FW response.

Also add a poll routine for control path commands. This is for
polling completion if the waiting commands timeout. This avoids cases
where the driver misses completion interrupts.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/1686308514-11996-6-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 29900bf351e1 ("RDMA/bnxt_re: Fix hang during driver unload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 65 +++++++++++++++++-----
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index c11b8e708844c..918e588588885 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -53,37 +53,74 @@
 
 static void bnxt_qplib_service_creq(struct tasklet_struct *t);
 
-/* Hardware communication channel */
+/**
+ * __wait_for_resp   -	Don't hold the cpu context and wait for response
+ * @rcfw      -   rcfw channel instance of rdev
+ * @cookie    -   cookie to track the command
+ *
+ * Wait for command completion in sleepable context.
+ *
+ * Returns:
+ * 0 if command is completed by firmware.
+ * Non zero error code for rest of the case.
+ */
 static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq;
 	u16 cbit;
-	int rc;
+	int ret;
 
 	cmdq = &rcfw->cmdq;
 	cbit = cookie % rcfw->cmdq_depth;
-	rc = wait_event_timeout(cmdq->waitq,
-				!test_bit(cbit, cmdq->cmdq_bitmap),
-				msecs_to_jiffies(RCFW_CMD_WAIT_TIME_MS));
-	return rc ? 0 : -ETIMEDOUT;
+
+	do {
+		/* Non zero means command completed */
+		ret = wait_event_timeout(cmdq->waitq,
+					 !test_bit(cbit, cmdq->cmdq_bitmap),
+					 msecs_to_jiffies(10000));
+
+		if (!test_bit(cbit, cmdq->cmdq_bitmap))
+			return 0;
+
+		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
+
+		if (!test_bit(cbit, cmdq->cmdq_bitmap))
+			return 0;
+
+	} while (true);
 };
 
+/**
+ * __block_for_resp   -	hold the cpu context and wait for response
+ * @rcfw      -   rcfw channel instance of rdev
+ * @cookie    -   cookie to track the command
+ *
+ * This function will hold the cpu (non-sleepable context) and
+ * wait for command completion. Maximum holding interval is 8 second.
+ *
+ * Returns:
+ * -ETIMEOUT if command is not completed in specific time interval.
+ * 0 if command is completed by firmware.
+ */
 static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 {
-	u32 count = RCFW_BLOCKED_CMD_WAIT_COUNT;
-	struct bnxt_qplib_cmdq_ctx *cmdq;
+	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
+	unsigned long issue_time = 0;
 	u16 cbit;
 
-	cmdq = &rcfw->cmdq;
 	cbit = cookie % rcfw->cmdq_depth;
-	if (!test_bit(cbit, cmdq->cmdq_bitmap))
-		goto done;
+	issue_time = jiffies;
+
 	do {
 		udelay(1);
+
 		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
-	} while (test_bit(cbit, cmdq->cmdq_bitmap) && --count);
-done:
-	return count ? 0 : -ETIMEDOUT;
+		if (!test_bit(cbit, cmdq->cmdq_bitmap))
+			return 0;
+
+	} while (time_before(jiffies, issue_time + (8 * HZ)));
+
+	return -ETIMEDOUT;
 };
 
 static int __send_message(struct bnxt_qplib_rcfw *rcfw,
-- 
2.40.1



