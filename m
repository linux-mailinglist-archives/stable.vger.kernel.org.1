Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F7E775919
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjHIK5n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjHIK5j (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C142125
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D615C63130
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5456C433CC;
        Wed,  9 Aug 2023 10:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578658;
        bh=ISgyVIwo1woIo+bJkqD+B4/VqoUqTIDGO4io7bOBd/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=znQker/hW/tEhktyaNczL2f/0z1mOHZmZ5HaUGR+XJVU8fkVuryievq8s53LFwMEl
         zDTwQmk6WWXuvCsPYEHpnTwWr+h1sDcoiSOkbxhmMnkHwDKk7puCs5XQnh90kRsopG
         yylGcMGekr/ou5prsBJbJggeII/M39Cxxr7W9p1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bjorn Andersson <andersson@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 11/92] firmware: arm_scmi: Fix chan_free cleanup on SMC
Date:   Wed,  9 Aug 2023 12:40:47 +0200
Message-ID: <20230809103633.950016368@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cristian Marussi <cristian.marussi@arm.com>

[ Upstream commit d1ff11d7ad8704f8d615f6446041c221b2d2ec4d ]

SCMI transport based on SMC can optionally use an additional IRQ to
signal message completion. The associated interrupt handler is currently
allocated using devres but on shutdown the core SCMI stack will call
.chan_free() well before any managed cleanup is invoked by devres.
As a consequence, the arrival of a late reply to an in-flight pending
transaction could still trigger the interrupt handler well after the
SCMI core has cleaned up the channels, with unpleasant results.

Inhibit further message processing on the IRQ path by explicitly freeing
the IRQ inside .chan_free() callback itself.

Fixes: dd820ee21d5e ("firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt")
Reported-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20230719173533.2739319-1-cristian.marussi@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scmi/smc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 4effecc3bb463..f529004f1922e 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -21,6 +21,7 @@
 /**
  * struct scmi_smc - Structure representing a SCMI smc transport
  *
+ * @irq: An optional IRQ for completion
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
  * @shmem_lock: Lock to protect access to Tx/Rx shared memory area
@@ -30,6 +31,7 @@
  */
 
 struct scmi_smc {
+	int irq;
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
 	struct mutex shmem_lock;
@@ -66,7 +68,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	struct resource res;
 	struct device_node *np;
 	u32 func_id;
-	int ret, irq;
+	int ret;
 
 	if (!tx)
 		return -ENODEV;
@@ -102,11 +104,10 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	 * completion of a message is signaled by an interrupt rather than by
 	 * the return of the SMC call.
 	 */
-	irq = of_irq_get_byname(cdev->of_node, "a2p");
-	if (irq > 0) {
-		ret = devm_request_irq(dev, irq, smc_msg_done_isr,
-				       IRQF_NO_SUSPEND,
-				       dev_name(dev), scmi_info);
+	scmi_info->irq = of_irq_get_byname(cdev->of_node, "a2p");
+	if (scmi_info->irq > 0) {
+		ret = request_irq(scmi_info->irq, smc_msg_done_isr,
+				  IRQF_NO_SUSPEND, dev_name(dev), scmi_info);
 		if (ret) {
 			dev_err(dev, "failed to setup SCMI smc irq\n");
 			return ret;
@@ -128,6 +129,10 @@ static int smc_chan_free(int id, void *p, void *data)
 	struct scmi_chan_info *cinfo = p;
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 
+	/* Ignore any possible further reception on the IRQ path */
+	if (scmi_info->irq > 0)
+		free_irq(scmi_info->irq, scmi_info);
+
 	cinfo->transport_info = NULL;
 	scmi_info->cinfo = NULL;
 
-- 
2.40.1



