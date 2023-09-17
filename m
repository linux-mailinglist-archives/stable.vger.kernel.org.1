Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A64E7A3A01
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbjIQT5W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240305AbjIQT5E (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:57:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C342FF3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:56:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0500BC433C8;
        Sun, 17 Sep 2023 19:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980618;
        bh=c0XpvEZyVkD1UMLnB4D088iBpGM6Lv7hcNfm1QUQ3WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6+LWLMbkxJrO18hBTtGAYP1fJnbxGIC1tZT1hxcRFNifeM6pZM1A1c6ILH7YWJs9
         AkDSjS4BxpNQnUEQ3tTRGg4t9b8vXCRyBSkSrsr/8cWKCGsETpcfPcHWKajyUQT+Bj
         O7l8lILe4hm0igzpcAphMXhU8+Z2+6Qu3nOwNjCc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 245/285] parisc: sba_iommu: Fix build warning if procfs if disabled
Date:   Sun, 17 Sep 2023 21:14:05 +0200
Message-ID: <20230917191059.825159734@linuxfoundation.org>
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

From: Helge Deller <deller@gmx.de>

[ Upstream commit 6428bc7bd3f35e43c8cb7359cb89d83248d339d2 ]

Clean up the code, e.g. make proc_mckinley_root static, drop the now
empty mckinley header file and remove some unneeded ifdefs around procfs
functions.

Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308300800.Jod4sHzM-lkp@intel.com/
Fixes: 77e0ddf097d6 ("parisc: ccio-dma: Create private runway procfs root entry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/include/asm/mckinley.h |  8 --------
 drivers/parisc/sba_iommu.c         | 10 ++--------
 2 files changed, 2 insertions(+), 16 deletions(-)
 delete mode 100644 arch/parisc/include/asm/mckinley.h

diff --git a/arch/parisc/include/asm/mckinley.h b/arch/parisc/include/asm/mckinley.h
deleted file mode 100644
index 1314390b9034b..0000000000000
--- a/arch/parisc/include/asm/mckinley.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ASM_PARISC_MCKINLEY_H
-#define ASM_PARISC_MCKINLEY_H
-
-/* declared in arch/parisc/kernel/setup.c */
-extern struct proc_dir_entry * proc_mckinley_root;
-
-#endif /*ASM_PARISC_MCKINLEY_H*/
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index 8f28f8696bf32..b8e91cbb60567 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -46,8 +46,6 @@
 #include <linux/module.h>
 
 #include <asm/ropes.h>
-#include <asm/mckinley.h>	/* for proc_mckinley_root */
-#include <asm/runway.h>		/* for proc_runway_root */
 #include <asm/page.h>		/* for PAGE0 */
 #include <asm/pdc.h>		/* for PDC_MODEL_* */
 #include <asm/pdcpat.h>		/* for is_pdc_pat() */
@@ -122,7 +120,7 @@ MODULE_PARM_DESC(sba_reserve_agpgart, "Reserve half of IO pdir as AGPGART");
 #endif
 
 static struct proc_dir_entry *proc_runway_root __ro_after_init;
-struct proc_dir_entry *proc_mckinley_root __ro_after_init;
+static struct proc_dir_entry *proc_mckinley_root __ro_after_init;
 
 /************************************
 ** SBA register read and write support
@@ -1899,9 +1897,7 @@ static int __init sba_driver_callback(struct parisc_device *dev)
 	int i;
 	char *version;
 	void __iomem *sba_addr = ioremap(dev->hpa.start, SBA_FUNC_SIZE);
-#ifdef CONFIG_PROC_FS
-	struct proc_dir_entry *root;
-#endif
+	struct proc_dir_entry *root __maybe_unused;
 
 	sba_dump_ranges(sba_addr);
 
@@ -1967,7 +1963,6 @@ static int __init sba_driver_callback(struct parisc_device *dev)
 
 	hppa_dma_ops = &sba_ops;
 
-#ifdef CONFIG_PROC_FS
 	switch (dev->id.hversion) {
 	case PLUTO_MCKINLEY_PORT:
 		if (!proc_mckinley_root)
@@ -1985,7 +1980,6 @@ static int __init sba_driver_callback(struct parisc_device *dev)
 
 	proc_create_single("sba_iommu", 0, root, sba_proc_info);
 	proc_create_single("sba_iommu-bitmap", 0, root, sba_proc_bitmap_info);
-#endif
 	return 0;
 }
 
-- 
2.40.1



