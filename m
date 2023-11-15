Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8894E7ECE4E
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjKOTmO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjKOTmO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:42:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252599E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:42:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EBAC433C9;
        Wed, 15 Nov 2023 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077330;
        bh=rP3F7yEZXFlNmvsZY8o6VanRigY46PCJC+jEpSpP/A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQnutZnIqJ1qaUPkyzFKbKG6UP0mSBqHPVqfY8ahOlLVfFvJyEStvBqsscfWUfC3A
         Fn3eTgOhmq8Fzv06LJyX0IZR3pVzXw/iSr8fHmi4DJQT5CAzkwJ+7aMhStSDKBZryK
         gquBHKjDmQGMKgRC6sVOLGL66eQBuyoQ0Ri7472Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 209/603] hwmon: (sch5627) Disallow write access if virtual registers are locked
Date:   Wed, 15 Nov 2023 14:12:34 -0500
Message-ID: <20231115191627.733538001@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 7da8a635436029957c5350da3acf51d78ed64071 ]

When the lock bit inside SCH5627_REG_CTRL is set, then the virtual
registers become read-only until the next power cycle.
Disallow write access to those registers in such a case.

Tested on a Fujitsu Esprimo P720.

Fixes: aa9f833dfc12 ("hwmon: (sch5627) Add pwmX_auto_channels_temp support")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20230907052639.16491-3-W_Armin@gmx.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/sch5627.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 0eefb8c0aef25..bf408e35e2c32 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -34,6 +34,7 @@
 #define SCH5627_REG_CTRL		0x40
 
 #define SCH5627_CTRL_START		BIT(0)
+#define SCH5627_CTRL_LOCK		BIT(1)
 #define SCH5627_CTRL_VBAT		BIT(4)
 
 #define SCH5627_NO_TEMPS		8
@@ -231,6 +232,14 @@ static int reg_to_rpm(u16 reg)
 static umode_t sch5627_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
 				  int channel)
 {
+	const struct sch5627_data *data = drvdata;
+
+	/* Once the lock bit is set, the virtual registers become read-only
+	 * until the next power cycle.
+	 */
+	if (data->control & SCH5627_CTRL_LOCK)
+		return 0444;
+
 	if (type == hwmon_pwm && attr == hwmon_pwm_auto_channels_temp)
 		return 0644;
 
-- 
2.42.0



