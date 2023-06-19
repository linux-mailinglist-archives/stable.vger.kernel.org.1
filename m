Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E045673531B
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjFSKlk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjFSKla (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:41:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDF810C7
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C034460B83
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE837C433C8;
        Mon, 19 Jun 2023 10:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171284;
        bh=ZSnVp4a4e+iHgVyv368Tui9Sw5ExoFu7ZROVjxxXJS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmZFmRYZ+dxfOEUonQ3rTcxtLDYheQ78y89zTGeYAsWaXqb+uGXPgqC3CKcaPk74z
         OX7t0BY+fB3pex8xVSDXmtukPPIjIHgAwygZksr/Q8szP9eDwoAn2bDgHFkwNEd3yN
         sUnf1Cz6FOaKn0PfOOUZwUKMT5hrTkq5q1ZBL03Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 06/49] irqchip/meson-gpio: Mark OF related data as maybe unused
Date:   Mon, 19 Jun 2023 12:29:44 +0200
Message-ID: <20230619102130.190081433@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
References: <20230619102129.856988902@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 14130211be5366a91ec07c3284c183b75d8fba17 ]

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/irqchip/irq-meson-gpio.c:153:34: error: ‘meson_irq_gpio_matches’ defined but not used [-Werror=unused-const-variable=]

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230512164506.212267-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-meson-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 7599b10ecf09d..dcb22f2539eff 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -67,7 +67,7 @@ static const struct meson_gpio_irq_params axg_params = {
 	.nr_hwirq = 100,
 };
 
-static const struct of_device_id meson_irq_gpio_matches[] = {
+static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
 	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params },
-- 
2.39.2



