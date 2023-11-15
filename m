Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027127ECF54
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjKOTrv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbjKOTru (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:47:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD7EAB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:47:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0329DC433C8;
        Wed, 15 Nov 2023 19:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077667;
        bh=xUtKlEOIjn/nR/T27xoo0w0R2gLVz1JkhGn0BEco8a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouXT4X53YlpZkZlCQ1jPKECey+dxdFwXhyo13rU9tQqutj6dRYLA2mYa6IADrFhXY
         AlKSLwqBSLU5JpWCIsvLdPDGeg18Dhd6niKclRFvgpV7HeU3GIeHZIG1lcseV6BzV+
         GC56vGzhITf2BrQmFWLC6+b5nqFKTYLMhOGow83A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Raag Jadav <raag.jadav@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 421/603] pinctrl: baytrail: fix debounce disable case
Date:   Wed, 15 Nov 2023 14:16:06 -0500
Message-ID: <20231115191641.956339773@linuxfoundation.org>
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

From: Raag Jadav <raag.jadav@intel.com>

[ Upstream commit 2d325e54d9e2e4ae247c9fd03f810208ce958c51 ]

We don't need to update debounce pulse value in case debounce is to be
disabled. Break such a case where arg value is zero.

Fixes: 4cfff5b7af8b ("pinctrl: baytrail: consolidate common mask operation")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-gpio/d164d471-5432-4c3c-afdb-33dc8f53d043@moroto.mountain/
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index faa8b7ff5bcf3..ec76e43527c5c 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -983,11 +983,18 @@ static int byt_pin_config_set(struct pinctrl_dev *pctl_dev,
 
 			break;
 		case PIN_CONFIG_INPUT_DEBOUNCE:
-			if (arg)
+			if (arg) {
 				conf |= BYT_DEBOUNCE_EN;
-			else
+			} else {
 				conf &= ~BYT_DEBOUNCE_EN;
 
+				/*
+				 * No need to update the pulse value.
+				 * Debounce is going to be disabled.
+				 */
+				break;
+			}
+
 			switch (arg) {
 			case 375:
 				db_pulse = BYT_DEBOUNCE_PULSE_375US;
-- 
2.42.0



