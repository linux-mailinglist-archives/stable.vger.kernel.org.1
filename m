Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFCA79B4AC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244228AbjIKVIM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240891AbjIKO4j (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:56:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6705CE4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:56:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69284C433C8;
        Mon, 11 Sep 2023 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444194;
        bh=oDURCKqlTcUMyenF6chXdWdNO9hWEm0ZzKjEwOqp6Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVZEFbrJQe8sFKZXWggi0dFeIEAMeoL4R4NcVc7ECJAfYuBQePxEV9wryL5pxNnQb
         huZCxfPJi8wXVOEY+/r5VwRUh0wO3jgKkhYdKDWS5TpjM/W6RQe/nlTqNaLyT/bTbq
         zAQNUv36gnTcI1716er3QzSut//hrJUmkFFIpLns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" 
        <nfraprado@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 615/737] thermal/drivers/mediatek/lvts_thermal: Dont leave threshold zeroed
Date:   Mon, 11 Sep 2023 15:47:54 +0200
Message-ID: <20230911134707.712019297@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit 77354eaef8218bc40d6b37e783b0b8dcca22a7d9 ]

The thermal framework might leave the low threshold unset if there
aren't any lower trip points. This leaves the register zeroed, which
translates to a very high temperature for the low threshold. The
interrupt for this threshold is then immediately triggered, and the
state machine gets stuck, preventing any other temperature monitoring
interrupts to ever trigger.

(The same happens by not setting the Cold or Hot to Normal thresholds
when using those)

Set the unused threshold to a valid low value. This value was chosen so
that for any valid golden temperature read from the efuse, when the
value is converted to raw and back again to milliCelsius, the result
doesn't underflow.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230706153823.201943-6-nfraprado@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0fa90ac6ed41f..a6bdcdfffa333 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -81,6 +81,8 @@
 
 #define LVTS_HW_SHUTDOWN_MT8195		105000
 
+#define LVTS_MINIMUM_THRESHOLD		20000
+
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
 static int coeff_b = LVTS_COEFF_B;
 
@@ -292,7 +294,7 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
 	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
 	void __iomem *base = lvts_sensor->base;
-	u32 raw_low = lvts_temp_to_raw(low);
+	u32 raw_low = lvts_temp_to_raw(low != -INT_MAX ? low : LVTS_MINIMUM_THRESHOLD);
 	u32 raw_high = lvts_temp_to_raw(high);
 
 	/*
@@ -304,11 +306,9 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	 *
 	 * 14-0 : Raw temperature for threshold
 	 */
-	if (low != -INT_MAX) {
-		pr_debug("%s: Setting low limit temperature interrupt: %d\n",
-			 thermal_zone_device_type(tz), low);
-		writel(raw_low, LVTS_OFFSETL(base));
-	}
+	pr_debug("%s: Setting low limit temperature interrupt: %d\n",
+		 thermal_zone_device_type(tz), low);
+	writel(raw_low, LVTS_OFFSETL(base));
 
 	/*
 	 * High offset temperature threshold
-- 
2.40.1



