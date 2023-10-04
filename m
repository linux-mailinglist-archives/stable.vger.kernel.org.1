Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66CE7B8789
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243811AbjJDSGd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243839AbjJDSGb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:06:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A21C1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:06:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EE2C433C7;
        Wed,  4 Oct 2023 18:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442787;
        bh=igaaQIJfYdEboBjF3P308XaQYv5I00MEduSxtrV3X0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJ4b8K2tQHoyIhDsUeVDMeR1lTCsgWsQW2TGzPldWtTvljq2v5p7Cm17iWLGPvxQX
         kIM3jxYv8VsehmyvELeHamq108DpF6rGFxxAzdFWYb06Y7BketBxCOjepTSfWSRyz2
         ibu9DoJNN/FP2ThDb9lQsvF1/KWMRyrFIq8T1hIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 091/183] MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled
Date:   Wed,  4 Oct 2023 19:55:22 +0200
Message-ID: <20231004175207.701696797@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit ef8f8f04a0b25e8f294b24350e8463a8d6a9ba0b ]

While commit d4a5c59a955b ("mmc: au1xmmc: force non-modular build and
remove symbol_get usage") to be built in, it can still build a kernel
without MMC support and thuse no mmc_detect_change symbol at all.

Add ifdefs to build the mmc support code in the alchemy arch code
conditional on mmc support.

Fixes: d4a5c59a955b ("mmc: au1xmmc: force non-modular build and remove symbol_get usage")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/alchemy/devboards/db1000.c | 4 ++++
 arch/mips/alchemy/devboards/db1200.c | 6 ++++++
 arch/mips/alchemy/devboards/db1300.c | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 50de86eb8784c..3183df60ad337 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -164,6 +164,7 @@ static struct platform_device db1x00_audio_dev = {
 
 /******************************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
 {
 	mmc_detect_change(ptr, msecs_to_jiffies(500));
@@ -369,6 +370,7 @@ static struct platform_device db1100_mmc1_dev = {
 	.num_resources	= ARRAY_SIZE(au1100_mmc1_res),
 	.resource	= au1100_mmc1_res,
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /******************************************************************************/
 
@@ -432,8 +434,10 @@ static struct platform_device *db1x00_devs[] = {
 
 static struct platform_device *db1100_devs[] = {
 	&au1100_lcd_device,
+#ifdef CONFIG_MMC_AU1X
 	&db1100_mmc0_dev,
 	&db1100_mmc1_dev,
+#endif
 };
 
 int __init db1000_dev_setup(void)
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 76080c71a2a7b..f521874ebb07b 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -326,6 +326,7 @@ static struct platform_device db1200_ide_dev = {
 
 /**********************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 /* SD carddetects:  they're supposed to be edge-triggered, but ack
  * doesn't seem to work (CPLD Rev 2).  Instead, the screaming one
  * is disabled and its counterpart enabled.  The 200ms timeout is
@@ -584,6 +585,7 @@ static struct platform_device pb1200_mmc1_dev = {
 	.num_resources	= ARRAY_SIZE(au1200_mmc1_res),
 	.resource	= au1200_mmc1_res,
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /**********************************************************************/
 
@@ -751,7 +753,9 @@ static struct platform_device db1200_audiodma_dev = {
 static struct platform_device *db1200_devs[] __initdata = {
 	NULL,		/* PSC0, selected by S6.8 */
 	&db1200_ide_dev,
+#ifdef CONFIG_MMC_AU1X
 	&db1200_mmc0_dev,
+#endif
 	&au1200_lcd_dev,
 	&db1200_eth_dev,
 	&db1200_nand_dev,
@@ -762,7 +766,9 @@ static struct platform_device *db1200_devs[] __initdata = {
 };
 
 static struct platform_device *pb1200_devs[] __initdata = {
+#ifdef CONFIG_MMC_AU1X
 	&pb1200_mmc1_dev,
+#endif
 };
 
 /* Some peripheral base addresses differ on the PB1200 */
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index ca71e5ed51abd..c965d00074818 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -450,6 +450,7 @@ static struct platform_device db1300_ide_dev = {
 
 /**********************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
 {
 	disable_irq_nosync(irq);
@@ -632,6 +633,7 @@ static struct platform_device db1300_sd0_dev = {
 	.resource	= au1300_sd0_res,
 	.num_resources	= ARRAY_SIZE(au1300_sd0_res),
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /**********************************************************************/
 
@@ -776,8 +778,10 @@ static struct platform_device *db1300_dev[] __initdata = {
 	&db1300_5waysw_dev,
 	&db1300_nand_dev,
 	&db1300_ide_dev,
+#ifdef CONFIG_MMC_AU1X
 	&db1300_sd0_dev,
 	&db1300_sd1_dev,
+#endif
 	&db1300_lcd_dev,
 	&db1300_ac97_dev,
 	&db1300_i2s_dev,
-- 
2.40.1



