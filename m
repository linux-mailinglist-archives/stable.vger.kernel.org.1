Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCA774C2DB
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjGILZe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjGILZd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:25:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540DC90
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3F9F60BD8
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026FCC433C8;
        Sun,  9 Jul 2023 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901931;
        bh=EcYGhDevQjKgeXXYI+oCjvqmyYtv6+E3OHgxKw5CwyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOOrzHqYZkPfgQneZxVDxhiDkWM9eysDFWUsa7CaK9dVl+LwOIoaEY+9go0Z+EsGh
         y3oxu7jhspZVh9ArlQi5sETO6/ChseX2ociuR3BlmxYMqjr6E0CtE9m6+ykQxw+JTs
         y3LHTlR3XHwAcg3ePOEETE1X0cuWXyA2X/1qrwKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 196/431] bus: ti-sysc: Fix dispc quirk masking bool variables
Date:   Sun,  9 Jul 2023 13:12:24 +0200
Message-ID: <20230709111455.769217376@linuxfoundation.org>
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
index 6afae98978434..b5ceec2b2d84f 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1814,7 +1814,7 @@ static u32 sysc_quirk_dispc(struct sysc *ddata, int dispc_offset,
 	if (!ddata->module_va)
 		return -EIO;
 
-	/* DISP_CONTROL */
+	/* DISP_CONTROL, shut down lcd and digit on disable if enabled */
 	val = sysc_read(ddata, dispc_offset + 0x40);
 	lcd_en = val & lcd_en_mask;
 	digit_en = val & digit_en_mask;
@@ -1826,7 +1826,7 @@ static u32 sysc_quirk_dispc(struct sysc *ddata, int dispc_offset,
 		else
 			irq_mask |= BIT(2) | BIT(3);	/* EVSYNC bits */
 	}
-	if (disable & (lcd_en | digit_en))
+	if (disable && (lcd_en || digit_en))
 		sysc_write(ddata, dispc_offset + 0x40,
 			   val & ~(lcd_en_mask | digit_en_mask));
 
-- 
2.39.2



