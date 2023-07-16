Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C487553A5
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjGPUVV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjGPUVU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7CD1B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24B7460EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F20AC433C7;
        Sun, 16 Jul 2023 20:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538878;
        bh=YPSLXDDIW9nto25eZk4+ItWKBwJgXTtjPf7rJgjGntA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cww2zLLhsgQzhsFu7CPlh0fEt5Xt0ZAe/Me2aW/eOXGRGSGd23JE2pP3gCm5Nwxvv
         qiWoTsN94bqxknL0xJ9Yz5NeQE11Isdc766oehIlpKEp9YVmWkMJ1mmkdOJoLteGbz
         yJnpcif+++ISXCgKeDYNv6ucSl149zVy8jY62GaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 609/800] media: atomisp: ov2680: Stop using half pixelclock for binned modes
Date:   Sun, 16 Jul 2023 21:47:42 +0200
Message-ID: <20230716195003.252921744@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 7d45a432251a30ed0252655177e708229b163291 ]

Stop using half pixelclock for binned modes this fixes:
1. The exposure being twice as high for binned mods (due to the half clk)
2. The framerate being 15 fps instead of 30 fps

The original code with fixed per mode register lists did use half pixel
clk, but this should be combined with using half for the VTS value too.

Using half VTS fixes the framerate issue, but this has the undesired
side-effect of change the exposure ctrl range (half the range, double
the amount of exposure per step).

Link: https://lore.kernel.org/r/20230604161406.69369-3-hdegoede@redhat.com

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c | 8 +-------
 drivers/staging/media/atomisp/i2c/ov2680.h         | 1 +
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
index c079368019e87..3a6bc3e56b10e 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
@@ -239,27 +239,21 @@ static void ov2680_calc_mode(struct ov2680_device *sensor, int width, int height
 static int ov2680_set_mode(struct ov2680_device *sensor)
 {
 	struct i2c_client *client = sensor->client;
-	u8 pll_div, unknown, inc, fmt1, fmt2;
+	u8 unknown, inc, fmt1, fmt2;
 	int ret;
 
 	if (sensor->mode.binning) {
-		pll_div = 1;
 		unknown = 0x23;
 		inc = 0x31;
 		fmt1 = 0xc2;
 		fmt2 = 0x01;
 	} else {
-		pll_div = 0;
 		unknown = 0x21;
 		inc = 0x11;
 		fmt1 = 0xc0;
 		fmt2 = 0x00;
 	}
 
-	ret = ov_write_reg8(client, 0x3086, pll_div);
-	if (ret)
-		return ret;
-
 	ret = ov_write_reg8(client, 0x370a, unknown);
 	if (ret)
 		return ret;
diff --git a/drivers/staging/media/atomisp/i2c/ov2680.h b/drivers/staging/media/atomisp/i2c/ov2680.h
index baf49eb0659e3..eed18d6943370 100644
--- a/drivers/staging/media/atomisp/i2c/ov2680.h
+++ b/drivers/staging/media/atomisp/i2c/ov2680.h
@@ -172,6 +172,7 @@ static struct ov2680_reg const ov2680_global_setting[] = {
 	{0x3082, 0x45},
 	{0x3084, 0x09},
 	{0x3085, 0x04},
+	{0x3086, 0x00},
 	{0x3503, 0x03},
 	{0x350b, 0x36},
 	{0x3600, 0xb4},
-- 
2.39.2



