Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1A7CA301
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjJPI7y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPI7x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:59:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5984E5
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:59:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C98C433CA;
        Mon, 16 Oct 2023 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446792;
        bh=bDYN3m7yb+FXHIvErx+VlK6Ia6QyUhP8fnfNQC9RywM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mibNLEqTen0yNkaYuTA6bCBWt98H4xpAT5bPdG0WZlj6lq0PRI1D+KrUXSGOG1p9K
         ofDrkwVJZ7yzSFsNeMK6IrnnReFR4/5Rox2PqdsNQpmGdcdIGtK8K/nC2gWmXYgqV2
         O+p6hXRazpKpl2PW9nZeSuqDu0hSHjQK9THsl+OI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ralph Siemsen <ralph.siemsen@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 064/131] pinctrl: renesas: rzn1: Enable missing PINMUX
Date:   Mon, 16 Oct 2023 10:40:47 +0200
Message-ID: <20231016084001.657054349@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 0903a0a418319..1ef8759802618 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -240,6 +240,7 @@ config PINCTRL_RZN1
 	depends on OF
 	depends on ARCH_RZN1 || COMPILE_TEST
 	select GENERIC_PINCONF
+	select PINMUX
 	help
 	  This selects pinctrl driver for Renesas RZ/N1 devices.
 
-- 
2.40.1



