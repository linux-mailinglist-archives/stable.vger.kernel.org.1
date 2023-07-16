Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E40B7554D7
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGPUet (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGPUdt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:33:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B95BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54F8460DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668C1C433CB;
        Sun, 16 Jul 2023 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539627;
        bh=awaN+eUt8VBn8UW12/r6g0Imd9YTTN2BmBDDs9KghAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7R7IlNyjFwbz5MW8TI/32UOwY7DVI27bXJWkDJ5P2qqovRF57+994Uw0y3J8xtH3
         DomUqUMTSKhq4Dw1KDAVwp1//RgYoMkNYc0YxID8D/z6uxLv+JxmCCpbUD8GjwRZpi
         m27uzS5Kt2XZ3DS1QDVUfib6EWAxKvjprP8P/a0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 047/591] powercap: RAPL: Fix CONFIG_IOSF_MBI dependency
Date:   Sun, 16 Jul 2023 21:43:06 +0200
Message-ID: <20230716194925.099914069@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit 4658fe81b3f8afe8adf37734ec5fe595d90415c6 ]

After commit 3382388d7148 ("intel_rapl: abstract RAPL common code"),
accessing to IOSF_MBI interface is done in the RAPL common code.

Thus it is the CONFIG_INTEL_RAPL_CORE that has dependency of
CONFIG_IOSF_MBI, while CONFIG_INTEL_RAPL_MSR does not.

This problem was not exposed previously because all the previous RAPL
common code users, aka, the RAPL MSR and MMIO I/F drivers, have
CONFIG_IOSF_MBI selected.

Fix the CONFIG_IOSF_MBI dependency in RAPL code. This also fixes a build
time failure when the RAPL TPMI I/F driver is introduced without
selecting CONFIG_IOSF_MBI.

x86_64-linux-ld: vmlinux.o: in function `set_floor_freq_atom':
intel_rapl_common.c:(.text+0x2dac9b8): undefined reference to `iosf_mbi_write'
x86_64-linux-ld: intel_rapl_common.c:(.text+0x2daca66): undefined reference to `iosf_mbi_read'

Reference to iosf_mbi.h is also removed from the RAPL MSR I/F driver.

Fixes: 3382388d7148 ("intel_rapl: abstract RAPL common code")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/all/20230601213246.3271412-1-arnd@kernel.org
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/Kconfig          | 4 +++-
 drivers/powercap/intel_rapl_msr.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 515e3ceb3393a..863e240b37e01 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -18,10 +18,12 @@ if POWERCAP
 # Client driver configurations go here.
 config INTEL_RAPL_CORE
 	tristate
+	depends on PCI
+	select IOSF_MBI
 
 config INTEL_RAPL
 	tristate "Intel RAPL Support via MSR Interface"
-	depends on X86 && IOSF_MBI
+	depends on X86 && PCI
 	select INTEL_RAPL_CORE
 	help
 	  This enables support for the Intel Running Average Power Limit (RAPL)
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index bc6adda588835..65adb4cbaaf8e 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -22,7 +22,6 @@
 #include <linux/processor.h>
 #include <linux/platform_device.h>
 
-#include <asm/iosf_mbi.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
-- 
2.39.2



