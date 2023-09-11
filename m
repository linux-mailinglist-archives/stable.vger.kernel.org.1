Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F173F79B03D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244386AbjIKVIO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239794AbjIKO2z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:28:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C381F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:28:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62501C433C8;
        Mon, 11 Sep 2023 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442530;
        bh=sGJz9kwHEOTPPnt5sj64k99d2Ycuy77Yr4nKzK8UJkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8fLqdifND+nyoAFwL6YUpInKWAwWxSHP1Z9btgfnPOatM/1/f2rn5RQgb3OxKG9S
         PiYSClUgr5lbL8D2l/XbGUjVkWnM63qYeO+L93RKNIyhmxxFw8CxhmFQVIL78toqLq
         L1cOKLcAcHt2IpPZyPWqaOmIFasnOaNVP2k8U8sg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Gray <bgray@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 056/737] powerpc/powermac: Use early_* IO variants in via_calibrate_decr()
Date:   Mon, 11 Sep 2023 15:38:35 +0200
Message-ID: <20230911134652.051314768@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Gray <bgray@linux.ibm.com>

[ Upstream commit 86582e6189dd8f9f52c25d46c70fe5d111da6345 ]

On a powermac platform, via the call path:

  start_kernel()
    time_init()
      ppc_md.calibrate_decr() (pmac_calibrate_decr)
        via_calibrate_decr()

ioremap() and iounmap() are called. The unmap can enable interrupts
unexpectedly (cond_resched() in vunmap_pmd_range()), which causes a
warning later in the boot sequence in start_kernel().

Use the early_* variants of these IO functions to prevent this.

The issue is pre-existing, but is surfaced by commit 721255b9826b
("genirq: Use a maple tree for interrupt descriptor management").

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230706010816.72682-1-bgray@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powermac/time.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 4c5790aff1b54..8633891b7aa58 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -26,8 +26,8 @@
 #include <linux/rtc.h>
 #include <linux/of_address.h>
 
+#include <asm/early_ioremap.h>
 #include <asm/sections.h>
-#include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/time.h>
 #include <asm/nvram.h>
@@ -182,7 +182,7 @@ static int __init via_calibrate_decr(void)
 		return 0;
 	}
 	of_node_put(vias);
-	via = ioremap(rsrc.start, resource_size(&rsrc));
+	via = early_ioremap(rsrc.start, resource_size(&rsrc));
 	if (via == NULL) {
 		printk(KERN_ERR "Failed to map VIA for timer calibration !\n");
 		return 0;
@@ -207,7 +207,7 @@ static int __init via_calibrate_decr(void)
 
 	ppc_tb_freq = (dstart - dend) * 100 / 6;
 
-	iounmap(via);
+	early_iounmap((void *)via, resource_size(&rsrc));
 
 	return 1;
 }
-- 
2.40.1



