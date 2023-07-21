Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E6E75D2C9
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjGUTDj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjGUTDi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7382130DB
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C3CD61D84
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F57AC433C7;
        Fri, 21 Jul 2023 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966216;
        bh=gbepNwzUiPT8KkoIjbwymTet91H+gx3Nw+PekQtK9vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cS3RUcz729jK4nZENHbXqxz3JOlYDwiRpbJBMwVo2TZlOHImfTva2o8TH0CMALV3c
         98YrQA8EDBWB5rkpdLDRg3HwQ4w6yC/6+yPVwLoEaIiFimYQMi/9+UdOerPbfsL6ID
         xStO180EYS3NMwbGBS/aHZZBl8sRAG7H37zJRB2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 266/532] sh: j2: Use ioremap() to translate device tree address into kernel memory
Date:   Fri, 21 Jul 2023 18:02:50 +0200
Message-ID: <20230721160628.777233565@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

[ Upstream commit bc9d1f0cecd2407cfb2364a7d4be2f52d1d46a9d ]

Addresses the following warning when building j2_defconfig:

arch/sh/kernel/cpu/sh2/probe.c: In function 'scan_cache':
arch/sh/kernel/cpu/sh2/probe.c:24:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   24 |  j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
      |

Fixes: 5a846abad07f ("sh: add support for J-Core J2 processor")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Rob Landley <rob@landley.net>
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/r/20230503125746.331835-1-glaubitz@physik.fu-berlin.de
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/kernel/cpu/sh2/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.c
index d342ea08843f6..70a07f4f2142f 100644
--- a/arch/sh/kernel/cpu/sh2/probe.c
+++ b/arch/sh/kernel/cpu/sh2/probe.c
@@ -21,7 +21,7 @@ static int __init scan_cache(unsigned long node, const char *uname,
 	if (!of_flat_dt_is_compatible(node, "jcore,cache"))
 		return 0;
 
-	j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
+	j2_ccr_base = ioremap(of_flat_dt_translate_address(node), 4);
 
 	return 1;
 }
-- 
2.39.2



