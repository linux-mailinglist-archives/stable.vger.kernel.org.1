Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B047CAC1F
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjJPOtr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjJPOtq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:49:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C102E1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:49:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46461C433C8;
        Mon, 16 Oct 2023 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467784;
        bh=5TyEPIcUQ+iItZmLLsDe8SokU01PoIrFbr0UOQosYM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmb4u4tTk+h2Ps36tjWyOLk61ZgLB86wIu6Y2ykYC9k2kiSuSQJ5FrH0oL9zmvcWu
         5BiQjKqvMcmnKlZlM7THVUmkK2qyZ4tYkAK0hMz5HYsxEygEngNkWLuvzpzv3HV8EQ
         EjcKq973omNAwXwjwvdo8CYye9x2qxt+PEULTFB4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ralph Siemsen <ralph.siemsen@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 085/191] pinctrl: renesas: rzn1: Enable missing PINMUX
Date:   Mon, 16 Oct 2023 10:41:10 +0200
Message-ID: <20231016084017.383499735@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ralph Siemsen <ralph.siemsen@linaro.org>

[ Upstream commit f055ff23c331f28aa4ace4b72dc56f63b9a726c8 ]

Enable pin muxing (eg. programmable function), so that the RZ/N1 GPIO
pins will be configured as specified by the pinmux in the DTS.

This used to be enabled implicitly via CONFIG_GENERIC_PINMUX_FUNCTIONS,
however that was removed, since the RZ/N1 driver does not call any of
the generic pinmux functions.

Fixes: 1308fb4e4eae14e6 ("pinctrl: rzn1: Do not select GENERIC_PIN{CTRL_GROUPS,MUX_FUNCTIONS}")
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231004200008.1306798-1-ralph.siemsen@linaro.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 77730dc548ed3..c8d519ca53eb7 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -235,6 +235,7 @@ config PINCTRL_RZN1
 	depends on OF
 	depends on ARCH_RZN1 || COMPILE_TEST
 	select GENERIC_PINCONF
+	select PINMUX
 	help
 	  This selects pinctrl driver for Renesas RZ/N1 devices.
 
-- 
2.40.1



