Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7386F74C259
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGILTh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjGILTg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:19:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CAC130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCA0E60BEC
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA17CC433C8;
        Sun,  9 Jul 2023 11:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901574;
        bh=+SoqVG6RoguNPN15+w6YkeW507traoDvh9eGkjN/N3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWy5BO6EK4ypX0FHqu7YgI83n+O94H8O2mZ/5bSa6rzg9pXKFGSKBHc1HIeQFp1zi
         utEyQKEGJ1RtV6id5VxBzbruF3qxgYofCSf7CAyZ8C4rnGVfYZxolkt8Xvm3wiqEVl
         rxpqs3kJrqBFwdJ1ja9i1GypVzObj4CG5TAZbohY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rob Landley <rob@landley.net>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 030/431] irqchip/jcore-aic: Fix missing allocation of IRQ descriptors
Date:   Sun,  9 Jul 2023 13:09:38 +0200
Message-ID: <20230709111451.804813460@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

[ Upstream commit 4848229494a323eeaab62eee5574ef9f7de80374 ]

The initialization function for the J-Core AIC aic_irq_of_init() is
currently missing the call to irq_alloc_descs() which allocates and
initializes all the IRQ descriptors. Add missing function call and
return the error code from irq_alloc_descs() in case the allocation
fails.

Fixes: 981b58f66cfc ("irqchip/jcore-aic: Add J-Core AIC driver")
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Tested-by: Rob Landley <rob@landley.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230510163343.43090-1-glaubitz@physik.fu-berlin.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-jcore-aic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 5f47d8ee4ae39..b9dcc8e78c750 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
 	unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
 	unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
 	struct irq_domain *domain;
+	int ret;
 
 	pr_info("Initializing J-Core AIC\n");
 
@@ -100,6 +101,12 @@ static int __init aic_irq_of_init(struct device_node *node,
 	jcore_aic.irq_unmask = noop;
 	jcore_aic.name = "AIC";
 
+	ret = irq_alloc_descs(-1, min_irq, dom_sz - min_irq,
+			      of_node_to_nid(node));
+
+	if (ret < 0)
+		return ret;
+
 	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
 				       &jcore_aic_irqdomain_ops,
 				       &jcore_aic);
-- 
2.39.2



