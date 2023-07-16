Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB9C75524C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjGPUGM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjGPUGL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:06:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADC09D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A7F160EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C2FC433C7;
        Sun, 16 Jul 2023 20:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537969;
        bh=z8kwRQZ7sdjt/ZWQbOtlmoM3zCtX0VgOEGU94+qZ6z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axytC+6ePpL0kHbK2Hnw/K4goHlnNNZrqB0qA8y2xiJXnou06mgstDAlLdAqNXMrH
         /w8U8RCtYZjqqpKy0yK6mXT4H47vznrbmG/pM5osLsqJw4YfgsKe8bOwzreGQ1KrGq
         cgLy1Mhec9g5BiHyli1ar4OS9xJCCUtCsyVki1eM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 286/800] ARM: omap1: Drop header on AMS Delta
Date:   Sun, 16 Jul 2023 21:42:19 +0200
Message-ID: <20230716194955.730230551@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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
index 9108c871d129a..ac47ab9fe0964 100644
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



