Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AE779B9E3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377862AbjIKW26 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbjIKO4f (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:56:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88305DC
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:56:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1A4C433C7;
        Mon, 11 Sep 2023 14:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444189;
        bh=O4nPICxaS8ZYv2aCT9jCuMXy+5IWhe/C7MI2aDf7bu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iv0t16aVAyGYXGfsugcMX0AFcLiL5A0v8zZDbMpZ7aaChDxzbRQB84xykPpX6aXUq
         U0sLcD6zb+jxW5hAhdFIxlDg2dqgmnAcW2I/R54E92/efoZpTcz/pPz5NylLbqdrFA
         ahc+Z0oDBJ6n6fs+8zhczIctCWhcJbisKC3K54eY=
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
Subject: [PATCH 6.4 613/737] thermal/drivers/mediatek/lvts_thermal: Use offset threshold for IRQ
Date:   Mon, 11 Sep 2023 15:47:52 +0200
Message-ID: <20230911134707.654912306@linuxfoundation.org>
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

[ Upstream commit f79e996c7ed27bb196facbcd1c69ee33631d7051 ]

There are two kinds of temperature monitoring interrupts available:
* High Offset, Low Offset
* Hot, Hot to normal, Cold

The code currently uses the hot/h2n/cold interrupts, however in a way
that doesn't work: the cold threshold is left uninitialized, which
prevents the other thresholds from ever triggering, and the h2n
interrupt is used as the lower threshold, which prevents the hot
interrupt from triggering again after the thresholds are updated by the
thermal framework, since a hot interrupt can only trigger again after
the hot to normal interrupt has been triggered.

But better yet than addressing those issues, is to use the high/low
offset interrupts instead. This way only two thresholds need to be
managed, which have a simpler state machine, making them a better match
to the thermal framework's high and low thresholds.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230706153823.201943-4-nfraprado@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 64748153d181e..80abd10596d85 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -296,9 +296,9 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	u32 raw_high = lvts_temp_to_raw(high);
 
 	/*
-	 * Hot to normal temperature threshold
+	 * Low offset temperature threshold
 	 *
-	 * LVTS_H2NTHRE
+	 * LVTS_OFFSETL
 	 *
 	 * Bits:
 	 *
@@ -307,13 +307,13 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	if (low != -INT_MAX) {
 		pr_debug("%s: Setting low limit temperature interrupt: %d\n",
 			 thermal_zone_device_type(tz), low);
-		writel(raw_low, LVTS_H2NTHRE(base));
+		writel(raw_low, LVTS_OFFSETL(base));
 	}
 
 	/*
-	 * Hot temperature threshold
+	 * High offset temperature threshold
 	 *
-	 * LVTS_HTHRE
+	 * LVTS_OFFSETH
 	 *
 	 * Bits:
 	 *
@@ -321,7 +321,7 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	 */
 	pr_debug("%s: Setting high limit temperature interrupt: %d\n",
 		 thermal_zone_device_type(tz), high);
-	writel(raw_high, LVTS_HTHRE(base));
+	writel(raw_high, LVTS_OFFSETH(base));
 
 	return 0;
 }
-- 
2.40.1



