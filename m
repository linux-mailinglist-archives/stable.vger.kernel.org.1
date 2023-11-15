Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676437ECFC1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjKOTug (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjKOTuf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:50:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2938CB8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:50:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1766C433C7;
        Wed, 15 Nov 2023 19:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077831;
        bh=T65deNt+a3YpCeac5Dk69u0igzVuqECLBdgkiFLxnRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eEQAzEk6HrgIWMqzpdZan5iHVcMKGI+RfExmGhpuS3YJMsh0q5NcU6WI+81SxVk+C
         n9rqMVWY3quCLKGlmlZ1duFUPrAq3xuGTE5fyH8P+hx3frKSmkmYSd+3fK01Zp3pKb
         NcX0hwgyRHPc66QBoMTIsULaJyfbNjzKvCleOiEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 539/603] watchdog: marvell_gti_wdt: Fix error code in probe()
Date:   Wed, 15 Nov 2023 14:18:04 -0500
Message-ID: <20231115191649.124204854@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 4b2b39f9395bc66c616d8d5a83642950fc3719b1 ]

This error path accidentally returns success.  Return -EINVAL instead.

Fixes: ef9e7fe2c890 ("Watchdog: Add marvell GTI watchdog driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Bharat Bhushan <bbhushan2@marvell.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/af326fd7-ac71-43a1-b7de-81779b61d242@moroto.mountain
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/marvell_gti_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
index d7eb8286e11ec..1ec1e014ba831 100644
--- a/drivers/watchdog/marvell_gti_wdt.c
+++ b/drivers/watchdog/marvell_gti_wdt.c
@@ -271,7 +271,7 @@ static int gti_wdt_probe(struct platform_device *pdev)
 				   &wdt_idx);
 	if (!err) {
 		if (wdt_idx >= priv->data->gti_num_timers)
-			return dev_err_probe(&pdev->dev, err,
+			return dev_err_probe(&pdev->dev, -EINVAL,
 				"GTI wdog timer index not valid");
 
 		priv->wdt_timer_idx = wdt_idx;
-- 
2.42.0



