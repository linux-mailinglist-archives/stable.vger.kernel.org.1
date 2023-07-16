Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7CC75514E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjGPTy7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGPTy6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097F9E4C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9258760EB3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E208C433C7;
        Sun, 16 Jul 2023 19:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537295;
        bh=y82BXBa3gUHLtgZibOoUflmazoHlF/tfiVIIOVK3dHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bII/55ZR7LUoKF9gyMQUPCnsxIuEY6Sr3SczoU7Zo4E3lYzbWzWaY+aIynYs6TYYz
         B0s4eFZTVg0wbqwLXTT4xwtAhmC/qRsP1UHYzRQKRZZw9Kx1ES2b1vDJN5uAyAXgIM
         vLPakvFjwT1kbpVqao0DTcT2H/QprW2oU6w6zfFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 044/800] irqchip/stm32-exti: Fix warning on initialized field overwritten
Date:   Sun, 16 Jul 2023 21:38:17 +0200
Message-ID: <20230716194950.116367397@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Antonio Borneo <antonio.borneo@foss.st.com>

[ Upstream commit 48f31e496488a25f443c0df52464da446fb1d10c ]

While compiling with W=1, both gcc and clang complain about a
tricky way to initialize an array by filling it with a non-zero
value and then overrride some of the array elements.
In this case the override is intentional, so just disable the
specific warning for only this part of the code.

Note: the flag "-Woverride-init" is recognized by both compilers,
but the warning msg from clang reports "-Winitializer-overrides".
The doc of clang clarifies that the two flags are synonyms, so use
here only the flag name common on both compilers.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Fixes: c297493336b7 ("irqchip/stm32-exti: Simplify irq description table")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230601155614.34490-1-antonio.borneo@foss.st.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-stm32-exti.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 6a3f7498ea8ea..8bbb2b114636c 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -173,6 +173,16 @@ static struct irq_chip stm32_exti_h_chip_direct;
 #define EXTI_INVALID_IRQ       U8_MAX
 #define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_BANK)
 
+/*
+ * Use some intentionally tricky logic here to initialize the whole array to
+ * EXTI_INVALID_IRQ, but then override certain fields, requiring us to indicate
+ * that we "know" that there are overrides in this structure, and we'll need to
+ * disable that warning from W=1 builds.
+ */
+__diag_push();
+__diag_ignore_all("-Woverride-init",
+		  "logic to initialize all and then override some is OK");
+
 static const u8 stm32mp1_desc_irq[] = {
 	/* default value */
 	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
@@ -266,6 +276,8 @@ static const u8 stm32mp13_desc_irq[] = {
 	[70] = 98,
 };
 
+__diag_pop();
+
 static const struct stm32_exti_drv_data stm32mp1_drv_data = {
 	.exti_banks = stm32mp1_exti_banks,
 	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
-- 
2.39.2



