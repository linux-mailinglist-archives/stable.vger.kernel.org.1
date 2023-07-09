Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E9774C2E0
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjGILZr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjGILZq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:25:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0027A186
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 942B160B7F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D52C433C8;
        Sun,  9 Jul 2023 11:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901945;
        bh=74VlH1B40Q1w5ZhVOtyD0QKdgQFX+JMyzwC5Cc0/xGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtJfnpDyAkavBss6XzARRPDCEw4amJlK/eT+hDdXHTwK24swICPrFZ+fdYJXOnUUx
         HUsNHkg8DZGAmv6YMhKcQSQ9HDO+YK6NiTpxddRuSXAnfPJQ3K/FHWtb993lNzpNLK
         0qF+TcCIVhPwfR0e1G3pnrcdoBnhciXDx7rMvKA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 200/431] hwmon: (f71882fg) prevent possible division by zero
Date:   Sun,  9 Jul 2023 13:12:28 +0200
Message-ID: <20230709111455.860027240@linuxfoundation.org>
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

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 0babf89c9cca7e074d6e59893e462e4886f481cc ]

In the unlikely event that something goes wrong with the device and
its registers, the fan_from_reg() function may return 0. This value
will cause a division-by-zero error in the show_pwm() function.

To prevent this, test the value of
fan_from_reg(data->fan_full_speed[nr]) against 0 before performing
the division. If the division-by-zero error is avoided, assign 0 to
the val variable.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: df9ec2dae094 ("hwmon: (f71882fg) Reorder symbols to get rid of a few forward declarations")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Link: https://lore.kernel.org/r/20230510143537.145060-1-n.zhandarovich@fintech.ru
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/f71882fg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 70121482a6173..27207ec6f7feb 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -1096,8 +1096,11 @@ static ssize_t show_pwm(struct device *dev,
 		val = data->pwm[nr];
 	else {
 		/* RPM mode */
-		val = 255 * fan_from_reg(data->fan_target[nr])
-			/ fan_from_reg(data->fan_full_speed[nr]);
+		if (fan_from_reg(data->fan_full_speed[nr]))
+			val = 255 * fan_from_reg(data->fan_target[nr])
+				/ fan_from_reg(data->fan_full_speed[nr]);
+		else
+			val = 0;
 	}
 	mutex_unlock(&data->update_lock);
 	return sprintf(buf, "%d\n", val);
-- 
2.39.2



