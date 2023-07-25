Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8CE7615FC
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjGYLfU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjGYLfT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:35:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFB310E7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BB7E61683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEB2C433C8;
        Tue, 25 Jul 2023 11:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284913;
        bh=vyQf+3mZIAmgjmDHAkm5GOb2K8UQZzMp9IVJpSJqyGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PczWDNs7EJMlJMwLiM6qdC0mQdSW5E8rj7Lb6FWm3gHTKS6rQy62vGb8cCG/ILJ2h
         5PfgUfm8mtPg8GvCt/6vSkC4VkGrLW3dCDrr3hBzuyj9mMQ9BZrNHGjNoo1s5mKvL9
         47ZjiaQq9C/VvCBzmHPab4OPg4ZdG2wbfKnq0OK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 017/313] irqchip/jcore-aic: Kill use of irq_create_strict_mappings()
Date:   Tue, 25 Jul 2023 12:42:50 +0200
Message-ID: <20230725104521.893941079@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 5f8b938bd790cff6542c7fe3c1495c71f89fef1b ]

irq_create_strict_mappings() is a poor way to allow the use of
a linear IRQ domain as a legacy one. Let's be upfront about it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210406093557.1073423-4-maz@kernel.org
Stable-dep-of: 4848229494a3 ("irqchip/jcore-aic: Fix missing allocation of IRQ descriptors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-jcore-aic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 033bccb41455c..5f47d8ee4ae39 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -100,11 +100,11 @@ static int __init aic_irq_of_init(struct device_node *node,
 	jcore_aic.irq_unmask = noop;
 	jcore_aic.name = "AIC";
 
-	domain = irq_domain_add_linear(node, dom_sz, &jcore_aic_irqdomain_ops,
+	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
+				       &jcore_aic_irqdomain_ops,
 				       &jcore_aic);
 	if (!domain)
 		return -ENOMEM;
-	irq_create_strict_mappings(domain, min_irq, min_irq, dom_sz - min_irq);
 
 	return 0;
 }
-- 
2.39.2



