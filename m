Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3227613AD
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbjGYLMw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbjGYLMg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E0E137
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9635E6166F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36C8C433C8;
        Tue, 25 Jul 2023 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283506;
        bh=+SoqVG6RoguNPN15+w6YkeW507traoDvh9eGkjN/N3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EuZ7pmLnQNLlTMhIFYrdf5dXIcpxpcIz3KexcUU7pQLLPS6Ll4P4qwqSps6wWxqCV
         8KII8qxmIlms9zHbWscdE+a8G/GgdRhxnLEcRh44+7mtUjCIl4dQQQmkkTCQjlhF3j
         KpEJYPjiXY2TRKSV3qivU5DBFkvz/4CtcdeaGTk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rob Landley <rob@landley.net>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 021/509] irqchip/jcore-aic: Fix missing allocation of IRQ descriptors
Date:   Tue, 25 Jul 2023 12:39:20 +0200
Message-ID: <20230725104554.614437273@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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



