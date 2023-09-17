Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B777A39B8
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbjIQTxL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbjIQTxA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:53:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A519F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:52:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F68C433C8;
        Sun, 17 Sep 2023 19:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980374;
        bh=binRViP/6tiW7rIUWOSDRneWLIBVTLY4kKMY39/gPPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6tTkwF3WvSy+vciAZzSvGExXl++tSMr9FO7o9ggTh9Qg3QS0KcDwS8uoZVdqRlhS
         Lmtesyycdv9O0n/3kHWqqM+jKsNkxuEcRoSNI9sPx/TNv/eJ95y+h8XhMFRnPfR+gh
         bqOqaX38ik+8shR21PbFaG/JA2JSg3S/AfFaWbLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 174/285] sh: boards: Fix CEU buffer size passed to dma_declare_coherent_memory()
Date:   Sun, 17 Sep 2023 21:12:54 +0200
Message-ID: <20230917191057.659715587@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

[ Upstream commit fb60211f377b69acffead3147578f86d0092a7a5 ]

In all these cases, the last argument to dma_declare_coherent_memory() is
the buffer end address, but the expected value should be the size of the
reserved region.

Fixes: 39fb993038e1 ("media: arch: sh: ap325rxa: Use new renesas-ceu camera driver")
Fixes: c2f9b05fd5c1 ("media: arch: sh: ecovec: Use new renesas-ceu camera driver")
Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")
Fixes: 186c446f4b84 ("media: arch: sh: migor: Use new renesas-ceu camera driver")
Fixes: 1a3c230b4151 ("media: arch: sh: ms7724se: Use new renesas-ceu camera driver")
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20230724120742.2187-1-petrtesarik@huaweicloud.com
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/boards/mach-ap325rxa/setup.c | 2 +-
 arch/sh/boards/mach-ecovec24/setup.c | 6 ++----
 arch/sh/boards/mach-kfr2r09/setup.c  | 2 +-
 arch/sh/boards/mach-migor/setup.c    | 2 +-
 arch/sh/boards/mach-se/7724/setup.c  | 6 ++----
 5 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 151792162152c..645cccf3da88e 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -531,7 +531,7 @@ static int __init ap325rxa_devices_setup(void)
 	device_initialize(&ap325rxa_ceu_device.dev);
 	dma_declare_coherent_memory(&ap325rxa_ceu_device.dev,
 			ceu_dma_membase, ceu_dma_membase,
-			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
+			CEU_BUFFER_MEMORY_SIZE);
 
 	platform_device_add(&ap325rxa_ceu_device);
 
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 674da7ebd8b7f..7ec03d4a4edf0 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1454,15 +1454,13 @@ static int __init arch_setup(void)
 	device_initialize(&ecovec_ceu_devices[0]->dev);
 	dma_declare_coherent_memory(&ecovec_ceu_devices[0]->dev,
 				    ceu0_dma_membase, ceu0_dma_membase,
-				    ceu0_dma_membase +
-				    CEU_BUFFER_MEMORY_SIZE - 1);
+				    CEU_BUFFER_MEMORY_SIZE);
 	platform_device_add(ecovec_ceu_devices[0]);
 
 	device_initialize(&ecovec_ceu_devices[1]->dev);
 	dma_declare_coherent_memory(&ecovec_ceu_devices[1]->dev,
 				    ceu1_dma_membase, ceu1_dma_membase,
-				    ceu1_dma_membase +
-				    CEU_BUFFER_MEMORY_SIZE - 1);
+				    CEU_BUFFER_MEMORY_SIZE);
 	platform_device_add(ecovec_ceu_devices[1]);
 
 	gpiod_add_lookup_table(&cn12_power_gpiod_table);
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 20f4db778ed6a..c6d556dfbbbe6 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -603,7 +603,7 @@ static int __init kfr2r09_devices_setup(void)
 	device_initialize(&kfr2r09_ceu_device.dev);
 	dma_declare_coherent_memory(&kfr2r09_ceu_device.dev,
 			ceu_dma_membase, ceu_dma_membase,
-			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
+			CEU_BUFFER_MEMORY_SIZE);
 
 	platform_device_add(&kfr2r09_ceu_device);
 
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index f60061283c482..773ee767d0c4e 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -604,7 +604,7 @@ static int __init migor_devices_setup(void)
 	device_initialize(&migor_ceu_device.dev);
 	dma_declare_coherent_memory(&migor_ceu_device.dev,
 			ceu_dma_membase, ceu_dma_membase,
-			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
+			CEU_BUFFER_MEMORY_SIZE);
 
 	platform_device_add(&migor_ceu_device);
 
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index b60a2626e18b2..6495f93540654 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -940,15 +940,13 @@ static int __init devices_setup(void)
 	device_initialize(&ms7724se_ceu_devices[0]->dev);
 	dma_declare_coherent_memory(&ms7724se_ceu_devices[0]->dev,
 				    ceu0_dma_membase, ceu0_dma_membase,
-				    ceu0_dma_membase +
-				    CEU_BUFFER_MEMORY_SIZE - 1);
+				    CEU_BUFFER_MEMORY_SIZE);
 	platform_device_add(ms7724se_ceu_devices[0]);
 
 	device_initialize(&ms7724se_ceu_devices[1]->dev);
 	dma_declare_coherent_memory(&ms7724se_ceu_devices[1]->dev,
 				    ceu1_dma_membase, ceu1_dma_membase,
-				    ceu1_dma_membase +
-				    CEU_BUFFER_MEMORY_SIZE - 1);
+				    CEU_BUFFER_MEMORY_SIZE);
 	platform_device_add(ms7724se_ceu_devices[1]);
 
 	return platform_add_devices(ms7724se_devices,
-- 
2.40.1



