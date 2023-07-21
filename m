Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD775D227
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGUS4e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGUS4c (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:56:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED74359C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 290E761D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388EEC433C7;
        Fri, 21 Jul 2023 18:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965788;
        bh=qofCu4sBxHKcnVofClaSHMk0+HGPq1629zAyXuLM5+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DwzuUYt39583aCDvl3+rBUsGZzUwEXR+BmATimRLmn5ZR7Xeb+XTtkEFTFFUOUzE0
         DGCKmPw6Db3Fhp9IIce/wFiW4b2O3Z433X+b18qG3yEk02BgAY1rin3lArYMPBh2wj
         07bSulUR5LV4+kQgYeV1I/XJsG4wOqBlpu3meABY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 115/532] bus: ti-sysc: Fix dispc quirk masking bool variables
Date:   Fri, 21 Jul 2023 18:00:19 +0200
Message-ID: <20230721160620.768092245@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit f620596fa347170852da499e778a5736d79a4b79 ]

Fix warning drivers/bus/ti-sysc.c:1806 sysc_quirk_dispc()
warn: masking a bool.

While at it let's add a comment for what were doing to make
the code a bit easier to follow.

Fixes: 7324a7a0d5e2 ("bus: ti-sysc: Implement display subsystem reset quirk")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-omap/a8ec8a68-9c2c-4076-bf47-09fccce7659f@kili.mountain/
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e93912e56f28c..7d508f9050038 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1759,7 +1759,7 @@ static u32 sysc_quirk_dispc(struct sysc *ddata, int dispc_offset,
 	if (!ddata->module_va)
 		return -EIO;
 
-	/* DISP_CONTROL */
+	/* DISP_CONTROL, shut down lcd and digit on disable if enabled */
 	val = sysc_read(ddata, dispc_offset + 0x40);
 	lcd_en = val & lcd_en_mask;
 	digit_en = val & digit_en_mask;
@@ -1771,7 +1771,7 @@ static u32 sysc_quirk_dispc(struct sysc *ddata, int dispc_offset,
 		else
 			irq_mask |= BIT(2) | BIT(3);	/* EVSYNC bits */
 	}
-	if (disable & (lcd_en | digit_en))
+	if (disable && (lcd_en || digit_en))
 		sysc_write(ddata, dispc_offset + 0x40,
 			   val & ~(lcd_en_mask | digit_en_mask));
 
-- 
2.39.2



