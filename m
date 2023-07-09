Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C719974C310
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjGIL15 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjGIL1w (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF161A5
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4517E60BC9
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CCEC433C8;
        Sun,  9 Jul 2023 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902069;
        bh=j39QYzgOA1f/CsMaT9Gj0xPRV3dyg97ZRajnSOtPo4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkS6cY4aNgn3ei+NqG8Cx3Q4i4tkauOgFe3riDMh4looJk/dp6CYA8TFV9oqvyhDs
         NJJ9rN0sm8/qqLTXaPdwTHroLZnT77oVuXrMpq4rYBRpW9Fm+MUBThAIOciZDcgsg0
         htctIFuXkVy2r6gGBir9STUAdlf9pm10kd9/5Rxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 216/431] ARM: omap1: Drop header on AMS Delta
Date:   Sun,  9 Jul 2023 13:12:44 +0200
Message-ID: <20230709111456.226821979@linuxfoundation.org>
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

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit fa1ae0cd897b089b5cc05ab471518ad13db2d567 ]

The AMS Delta board uses GPIO descriptors exclusively and
does not have any dependencies on the legacy <linux/gpio.h>
header, so just drop it.

Acked-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap1/board-ams-delta.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 0f67ac4c6fd25..d9d2fef1b74a7 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -11,7 +11,6 @@
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/consumer.h>
-#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/input.h>
-- 
2.39.2



