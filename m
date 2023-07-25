Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A584761449
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGYLRn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjGYLRj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:17:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1361A137
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D44661683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBF5C433C8;
        Tue, 25 Jul 2023 11:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283858;
        bh=3bWOXFNycvTg51YlQThkRNr4GZ4tVRJM3V2cIC31SGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEYinG3tbcGd+jb73Sa6wO7dN7ZdcfGn8I76XD/QQVELZbRGbZmAKTpCx4l6fHDzK
         Q/IZcBfWSyPTvzwCLdKdEJpi43/bjdcqkdEoG4u6k0Y9wqwR+GKeSA/veG2FqJB4Ij
         d2vJxqLvbFiObfgAqOonoMFh3PxOVB4J21hGeHG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tim Harvey <tharvey@gateworks.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 147/509] hwmon: (gsc-hwmon) fix fan pwm temperature scaling
Date:   Tue, 25 Jul 2023 12:41:26 +0200
Message-ID: <20230725104600.462426301@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Tim Harvey <tharvey@gateworks.com>

[ Upstream commit a6d80df47ee2c69db99e4f2f8871aa4db154620b ]

The GSC fan pwm temperature register is in centidegrees celcius but the
Linux hwmon convention is to use milidegrees celcius. Fix the scaling.

Fixes: 3bce5377ef66 ("hwmon: Add Gateworks System Controller support")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Link: https://lore.kernel.org/r/20230606153004.1448086-1-tharvey@gateworks.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/gsc-hwmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index f29ce49294daf..89d036bf88df7 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -82,8 +82,8 @@ static ssize_t pwm_auto_point_temp_store(struct device *dev,
 	if (kstrtol(buf, 10, &temp))
 		return -EINVAL;
 
-	temp = clamp_val(temp, 0, 10000);
-	temp = DIV_ROUND_CLOSEST(temp, 10);
+	temp = clamp_val(temp, 0, 100000);
+	temp = DIV_ROUND_CLOSEST(temp, 100);
 
 	regs[0] = temp & 0xff;
 	regs[1] = (temp >> 8) & 0xff;
@@ -100,7 +100,7 @@ static ssize_t pwm_auto_point_pwm_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 
-	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)) / 100);
+	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)));
 }
 
 static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point1_pwm, pwm_auto_point_pwm, 0);
-- 
2.39.2



