Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55487755535
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjGPUij (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjGPUii (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B6EAB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55E2160EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E71C433C7;
        Sun, 16 Jul 2023 20:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539916;
        bh=74VlH1B40Q1w5ZhVOtyD0QKdgQFX+JMyzwC5Cc0/xGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WiuKuoViSQ96cxbM5nhH73d83fi04d05w4LSgJ7CaY7hqo0fPqMqBpeOvxF0MX5Eo
         spJAPg7puMKB8RfYpp5uhCJRezwZXtIYiaTDXQcUD2JgIdK7BWf+M8il3L1e/uQlhp
         VQCUD6ahayssdrvAhSt1LW/lY0v5SfhlU6bs6HOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 178/591] hwmon: (f71882fg) prevent possible division by zero
Date:   Sun, 16 Jul 2023 21:45:17 +0200
Message-ID: <20230716194928.470249526@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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



