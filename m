Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A527E22E1
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjKFNGb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjKFNG0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:06:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5A091
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:06:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B115DC433C7;
        Mon,  6 Nov 2023 13:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699275984;
        bh=izPoIJ3Mq56Y++sRIDw1f3aVIXYyFJC+6jg0M+GEG5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTTeNeitw3uH8JWuBcmq7lCxNtdnxFXjXZ9E1wSiMwVz8FaUFSh/TK/lGq2PN1u+R
         o2q82H9HajMZV/dEJv6600LC69CPMluA+T+B4+pd0wLbOhGCFbIUGUJNgQ4YUAXLXv
         LVPsjsg77g7hjOEutLt3HHXR6L16ZOH3BvZ0TMJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 30/48] irqchip/stm32-exti: add missing DT IRQ flag translation
Date:   Mon,  6 Nov 2023 14:03:21 +0100
Message-ID: <20231106130258.892251894@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
References: <20231106130257.862199836@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 45363ff8d06f0..1b55199ea1b4a 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -127,6 +127,7 @@ struct irq_domain_ops irq_exti_domain_ops = {
 	.xlate	= irq_domain_xlate_onetwocell,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static int __init stm32_exti_init(struct device_node *node,
-- 
2.42.0



