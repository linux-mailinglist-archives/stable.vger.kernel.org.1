Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C704279AE6E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbjIKVIf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239399AbjIKOTo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:19:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9560CDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:19:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD57DC433CA;
        Mon, 11 Sep 2023 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441980;
        bh=5WTbxLJzVrzQhBLG95XrpPJvIZ0moMypaLHPvQgyeR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8hFy4afmtmuz1Vj8va3CVtX/eGeC5JYwrfebQD1M1a7Xeyhaz8HvwAbXk+ptPl25
         7LLasKoS/8pk2y6XDu0HbZw/ZDUZ7W6ao6A96Ixro0F/+xBKrjXeGYAV1/VWQ76exV
         hS02jYoeOZZFpCJGgu5kp+kOssziD6ZvvZyELz7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 603/739] leds: pwm: Fix error code in led_pwm_create_fwnode()
Date:   Mon, 11 Sep 2023 15:46:42 +0200
Message-ID: <20230911134707.941190174@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit cadb2de2a7fd9e955381307de3eddfcc386c208e ]

Negative -EINVAL was intended, not positive EINVAL.  Fix it.

Fixes: 95138e01275e ("leds: pwm: Make error handling more robust")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/a33b981a-b2c4-4dc2-b00a-626a090d2f11@moroto.mountain
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 29194cc382afb..87c199242f3c8 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -146,7 +146,7 @@ static int led_pwm_create_fwnode(struct device *dev, struct led_pwm_priv *priv)
 			led.name = to_of_node(fwnode)->name;
 
 		if (!led.name) {
-			ret = EINVAL;
+			ret = -EINVAL;
 			goto err_child_out;
 		}
 
-- 
2.40.1



