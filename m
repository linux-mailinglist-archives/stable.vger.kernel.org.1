Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BC97E2389
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjKFNMh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjKFNMg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:12:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A29691
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:12:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD0CC433C7;
        Mon,  6 Nov 2023 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276353;
        bh=eJ0T2/nIZKrNVRfuTb++GVgLRNKFRYCIexibKYKeUEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8BwAq2IOYth/LaeIrlYHwo/HdiSR9NpfQg0x0Csm0WpbcN7xZ4IIEYIhWTyek2wB
         hsIpSHxCUSpAr8ZhyG/tUgVgETWNXHGNKiXuU/4s0iH5ZfJunTESQog2PfzxiaUttI
         bCc1WN0FdUBrhPgDtYJCPZ74/Jh3Hplj/XD7KW58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 06/62] irqchip/stm32-exti: add missing DT IRQ flag translation
Date:   Mon,  6 Nov 2023 14:03:12 +0100
Message-ID: <20231106130302.043915670@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Wolsieffer <ben.wolsieffer@hefring.com>

[ Upstream commit 8554cba1d6dbd3c74e0549e28ddbaccbb1d6b30a ]

The STM32F4/7 EXTI driver was missing the xlate callback, so IRQ trigger
flags specified in the device tree were being ignored. This was
preventing the RTC alarm interrupt from working, because it must be set
to trigger on the rising edge to function correctly.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20231003162003.1649967-1-ben.wolsieffer@hefring.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-stm32-exti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 8bbb2b114636c..dc6f67decb022 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -458,6 +458,7 @@ static const struct irq_domain_ops irq_exti_domain_ops = {
 	.map	= irq_map_generic_chip,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static void stm32_irq_ack(struct irq_data *d)
-- 
2.42.0



