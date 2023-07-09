Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C9374C243
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjGILSt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjGILSp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:18:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23EFE61
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6667160BD3
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744C0C433C8;
        Sun,  9 Jul 2023 11:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901515;
        bh=gXS/otu2fAk1SNZY4u1qcgRrfRCsiL7og+jvmMAsZyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4+01yyER4gXcDGncbg5T4HIMKUWmSPPyoisOcU5fejjvbQAj1Qg5uYAartPs1KW7
         69ppjSy4EjoVHw5nIeN1d3aP00Eb/hTtEm0QqR8zyVKFoiR2tpwDxs2EKsb8eGWDRL
         bLNCBaFjwbfrAsiPDYR0JSFpd2z27u3B9kEoYChg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 048/431] powercap: RAPL: Fix CONFIG_IOSF_MBI dependency
Date:   Sun,  9 Jul 2023 13:09:56 +0200
Message-ID: <20230709111452.238148941@linuxfoundation.org>
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
index 90d33cd1b670a..b063f75117738 100644
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
index 7be7561f5ad64..9ea4797d70b44 100644
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



