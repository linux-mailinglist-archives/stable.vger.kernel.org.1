Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C4D74C313
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjGIL2D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjGIL2C (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34BC18C
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 631F960BC9
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73135C433C7;
        Sun,  9 Jul 2023 11:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902080;
        bh=fTlSuJUtvmfv/YzgOXQtYcuPDh6hHD5XPsQ4CXL5UAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HvWVR/fiMqfc8OfJW+Yf/RS8MagAzp3yaQ8HsPr69BFpV3xCKkK9Q5npiQoqzI457
         AU3XABJuvnAjv1mhl6RKVmqIYe+AC3Rw/L5gKtfchKawq9S8xmpPXh5k/1AWNKFELR
         oil1cYeJxwEudELtnK6Qomd79/Ip8fCq22GhN9iA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 220/431] ARM: omap1: Exorcise the legacy GPIO header
Date:   Sun,  9 Jul 2023 13:12:48 +0200
Message-ID: <20230709111456.319948924@linuxfoundation.org>
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

[ Upstream commit c729baa8604226a8f878296bd145ab4046c80b12 ]

After fixing all the offending users referencing the global GPIO
numberspace in OMAP1, a few sites still remain including the
legacy <linus/gpio.h> header for no reason.

Delete the last remaining users, and OMAP1 is free from legacy
GPIO dependencies.

Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap1/devices.c  | 1 -
 arch/arm/mach-omap1/gpio15xx.c | 1 -
 arch/arm/mach-omap1/gpio16xx.c | 1 -
 arch/arm/mach-omap1/irq.c      | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 5304699c7a97e..8b2c5f911e973 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/dma-mapping.h>
-#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 61fa26efd8653..6724af4925f24 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -8,7 +8,6 @@
  *	Charulatha V <charu@ti.com>
  */
 
-#include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/soc/ti/omap1-soc.h>
 #include <asm/irq.h>
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index cf052714b3f8a..55acec22fef4e 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -8,7 +8,6 @@
  *	Charulatha V <charu@ti.com>
  */
 
-#include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/soc/ti/omap1-io.h>
 
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index 9ccc784fd6140..c780fa56bc638 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -35,7 +35,6 @@
  * with this program; if not, write  to the Free Software Foundation, Inc.,
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/sched.h>
-- 
2.39.2



