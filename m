Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742EA7D333A
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjJWL2J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjJWL2I (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:28:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54566E4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:28:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965A3C433C8;
        Mon, 23 Oct 2023 11:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060485;
        bh=g9Alb47zBr1JvNFFiXXlzeOHwEDZlYS03mMHfBrNMvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baPAIeClgB9QSxDbBk2jPACMeU/mD9Ze7GZIpag2nq990l0HGxrC5fbDZJ2P8oKt6
         WmrCptNvT8QgyhmbJKk2E/GQfPRXHRAXFZ8cYqcH9sLySE36sq3cxKxUgAiUrknVx/
         6hoHDMQkKp2vnrfkMcr3N8Vxi23wlJnqRc3mGMuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 187/196] gpio: vf610: mask the gpio irq in system suspend and support wakeup
Date:   Mon, 23 Oct 2023 12:57:32 +0200
Message-ID: <20231023104833.664598890@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haibo Chen <haibo.chen@nxp.com>

[ Upstream commit 430232619791e7de95191f2cd8ebaa4c380d17d0 ]

Add flag IRQCHIP_MASK_ON_SUSPEND to make sure gpio irq is masked on
suspend, if lack this flag, current irq arctitecture will not mask
the irq, and these unmasked gpio irq will wrongly wakeup the system
even they are not config as wakeup source.

Also add flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND to make sure the gpio
irq which is configed as wakeup source can work as expect.

Fixes: 7f2691a19627 ("gpio: vf610: add gpiolib/IRQ chip driver for Vybrid")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-vf610.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index e8e34d648eb2a..314dfaa633857 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -247,7 +247,8 @@ static const struct irq_chip vf610_irqchip = {
 	.irq_unmask = vf610_gpio_irq_unmask,
 	.irq_set_type = vf610_gpio_irq_set_type,
 	.irq_set_wake = vf610_gpio_irq_set_wake,
-	.flags = IRQCHIP_IMMUTABLE,
+	.flags = IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
+			| IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
-- 
2.42.0



