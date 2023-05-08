Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293316FAAE4
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjEHLHs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjEHLHF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C6C29FDF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B30562ABC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFD5C4339B;
        Mon,  8 May 2023 11:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543986;
        bh=nCUAa3ziECeLudj1NwD9cNLBzJacjIIwNbBljvDRqI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bn97hO0VUVt2QH/XqoQPpnnHzkbWTxOLaMaFbMzhoQW8Jbv9vrpw/1MaUIZ2vD91x
         HcaVmX5ET8qxOwz7ooyirhjOpm6Ro4CYxxfIhq81j1wyTxN+he3HxwTPJ1S40EK9Gt
         svdnaQzrFp9S6YtZxZRYQ/YTko1vT4/nbCdlpPTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 265/694] thermal/drivers/mediatek/lvts_thermal: Fix sensor 1 interrupt status bitmask
Date:   Mon,  8 May 2023 11:41:40 +0200
Message-Id: <20230508094440.871368484@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit 13f03bcd02e4b0498c8ccb066b4eddf61dee6681 ]

The binary representation for sensor 1 interrupt status was incorrectly
assembled, when compared to the full table given in the same comment
section. The conversion into hex was also incorrect, leading to
incorrect interrupt status bitmask for sensor 1. This would cause the
driver to incorrectly identify changes for sensor 1, when in fact it
was sensor 0, or a sensor access time out.

Fix the binary and hex representations in the comments, and the actual
bitmask macro.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230328031017.1360976-1-wenst@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 84ba65a27acf7..acce1321a1a23 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -66,7 +66,7 @@
 #define LVTS_MONINT_CONF			0x9FBF7BDE
 
 #define LVTS_INT_SENSOR0			0x0009001F
-#define LVTS_INT_SENSOR1			0X000881F0
+#define LVTS_INT_SENSOR1			0x001203E0
 #define LVTS_INT_SENSOR2			0x00247C00
 #define LVTS_INT_SENSOR3			0x1FC00000
 
@@ -393,8 +393,8 @@ static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
 	 *                  => 0x1FC00000
 	 * sensor 2 interrupt: 0000 0000 0010 0100 0111 1100 0000 0000
 	 *                  => 0x00247C00
-	 * sensor 1 interrupt: 0000 0000 0001 0001 0000 0011 1110 0000
-	 *                  => 0X000881F0
+	 * sensor 1 interrupt: 0000 0000 0001 0010 0000 0011 1110 0000
+	 *                  => 0X001203E0
 	 * sensor 0 interrupt: 0000 0000 0000 1001 0000 0000 0001 1111
 	 *                  => 0x0009001F
 	 */
-- 
2.39.2



