Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32576FA8D2
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjEHKpj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjEHKpU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9E326E95
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1204D62870
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D4AC4339B;
        Mon,  8 May 2023 10:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542659;
        bh=xdAFWYR/RXqH8ok1Y1aPIX+9ysIpKlGcch10JaOzDf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3yIXvBhKE9ibSPRSm/dcpNi5DO7A/ySw13oNpjNiCCS5MUKWkBrWaOiZde0plgx6
         BfY2rkTi6mp/tfhUleOB0MoNDZpSi29R5/LKIrGJ+OvWtRwE+lZ4jrkOvQ90Wzk6T+
         ogIFjSfug/JiZ2cYiAaUV5CdSW00mIGmZeR4V8xY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 506/663] powerpc/wii: fix resource printk format warnings
Date:   Mon,  8 May 2023 11:45:32 +0200
Message-Id: <20230508094445.051351478@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 7b69600d4da0049244e9be2f5ef5a2f8e04fcd9a ]

Use "%pa" format specifier for resource_size_t to avoid compiler
printk format warnings.

../arch/powerpc/platforms/embedded6xx/flipper-pic.c: In function 'flipper_pic_init':
../include/linux/kern_levels.h:5:25: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
../arch/powerpc/platforms/embedded6xx/flipper-pic.c:148:9: note: in expansion of macro 'pr_info'
  148 |         pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
      |         ^~~~~~~

../arch/powerpc/platforms/embedded6xx/hlwd-pic.c: In function 'hlwd_pic_init':
../include/linux/kern_levels.h:5:25: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
../arch/powerpc/platforms/embedded6xx/hlwd-pic.c:174:9: note: in expansion of macro 'pr_info'
  174 |         pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
      |         ^~~~~~~

../arch/powerpc/platforms/embedded6xx/wii.c: In function 'wii_ioremap_hw_regs':
../include/linux/kern_levels.h:5:25: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
../arch/powerpc/platforms/embedded6xx/wii.c:77:17: note: in expansion of macro 'pr_info'
   77 |                 pr_info("%s at 0x%08x mapped to 0x%p\n", name,
      |                 ^~~~~~~

Fixes: 028ee972f032 ("powerpc: gamecube/wii: flipper interrupt controller support")
Fixes: 9c21025c7845 ("powerpc: wii: hollywood interrupt controller support")
Fixes: 5a7ee3198dfa ("powerpc: wii: platform support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230223070116.660-3-rdunlap@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    | 2 +-
 arch/powerpc/platforms/embedded6xx/wii.c         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 609bda2ad5dd2..4d9200bdba78c 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -145,7 +145,7 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 	}
 	io_base = ioremap(res.start, resource_size(&res));
 
-	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
 
 	__flipper_quiesce(io_base);
 
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 380b4285cce47..4d2d92de30afd 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -171,7 +171,7 @@ static struct irq_domain *__init hlwd_pic_init(struct device_node *np)
 		return NULL;
 	}
 
-	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
 
 	__hlwd_quiesce(io_base);
 
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index f4e654a9d4ff6..219659f2ede06 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -74,8 +74,8 @@ static void __iomem *__init wii_ioremap_hw_regs(char *name, char *compatible)
 
 	hw_regs = ioremap(res.start, resource_size(&res));
 	if (hw_regs) {
-		pr_info("%s at 0x%08x mapped to 0x%p\n", name,
-			res.start, hw_regs);
+		pr_info("%s at 0x%pa mapped to 0x%p\n", name,
+			&res.start, hw_regs);
 	}
 
 out_put:
-- 
2.39.2



