Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5297ECFA4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjKOTtu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbjKOTtt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:49:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7414819E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:49:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73C4C433C7;
        Wed, 15 Nov 2023 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077784;
        bh=IIKQbNe04lj52xUD57A5eNTBowc6YQlPJZvFaGpZjEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRz2r4GdO+fedmOkytaUA8ZLulLnbSG3vNthNCoNJCTpJNZGdcWGYSHHm6Tvpzbpg
         lOAO29ekjw7SPa14KkwGnxvKapjYZReCYR5cqhjnIs4HKpGg943nu5TdnCBP2bNH9n
         iCcyjGDszN+clzyZujEVbr7wDl33hOGGQ8PJr5ow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 496/603] rtc: pcf85363: fix wrong mask/val parameters in regmap_update_bits call
Date:   Wed, 15 Nov 2023 14:17:21 -0500
Message-ID: <20231115191646.590303797@linuxfoundation.org>
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

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

[ Upstream commit 2be36c09b6b07306be33519e1aa70d2e2a2161bb ]

The current implementation passes PIN_IO_INTA_OUT (2) as a mask and
PIN_IO_INTAPM (GENMASK(1, 0)) as a value.
Swap the variables to assign mask and value the right way.

This error was first introduced with the alarm support. For better or
worse it worked as expected because 0x02 was applied as a mask to 0x03,
resulting 0x02 anyway. This will of course not work for any other value.

Fixes: e5aac267a10a ("rtc: pcf85363: add alarm support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://lore.kernel.org/r/20231013-topic-pcf85363_regmap_update_bits-v1-1-c454f016f71f@gmail.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-pcf85363.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 06194674d71c5..540042b9eec8f 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -438,7 +438,7 @@ static int pcf85363_probe(struct i2c_client *client)
 	if (client->irq > 0 || wakeup_source) {
 		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
 		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
-				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
+				   PIN_IO_INTAPM, PIN_IO_INTA_OUT);
 	}
 
 	if (client->irq > 0) {
-- 
2.42.0



