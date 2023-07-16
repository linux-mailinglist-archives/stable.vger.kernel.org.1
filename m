Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449F375523A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGPUFV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjGPUFV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6569D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E673160EA2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0402CC433C7;
        Sun, 16 Jul 2023 20:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537919;
        bh=74VlH1B40Q1w5ZhVOtyD0QKdgQFX+JMyzwC5Cc0/xGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hly0MAWPxyqCJVIfS4zbSIC7mIqBQ/AcS9dYTkrlEHO3hPPcr33a+p/pn1+NtI/R8
         omiB1zO0h5BM+scXeW3yF876dyc6nab+5DYchodOeymEmlX5bswGH45tSeTjtMSIJU
         oU4e7AnaxCqTYyy5WlcXBrsr+DUSqUvWeOBHkzWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 267/800] hwmon: (f71882fg) prevent possible division by zero
Date:   Sun, 16 Jul 2023 21:42:00 +0200
Message-ID: <20230716194955.297637203@linuxfoundation.org>
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



