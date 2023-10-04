Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2157B8877
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbjJDSQ4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244111AbjJDSQc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:16:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663ACBF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:16:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D78C433C7;
        Wed,  4 Oct 2023 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443387;
        bh=Nh5LvujZEFBJG7eO0d0Kc+BB2FAsDelbOSkQvDGyVkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2C0kji8eFNocHx+JAAvmQ+9VG+wcg6SrWmoCbqMN9C69paQYNQ4VSvw+wLPLut+xr
         cRGM0fCvsNr60QP5V0eI0ZANFAAGJh4afej2oZWYkMh9SerYgLkOJIPVsult1onqxD
         6ZMX1taMkUOog23ecCXeNNU9DmN3Q5qyK7ko+EqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 139/259] gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip
Date:   Wed,  4 Oct 2023 19:55:12 +0200
Message-ID: <20231004175223.698950197@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenhua Lin <Wenhua.Lin@unisoc.com>

[ Upstream commit 26d9e5640d2130ee16df7b1fb6a908f460ab004c ]

The drivers uses a mutex and I2C bus access in its PMIC EIC chip
get implementation. This means these functions can sleep and the PMIC EIC
chip should set the can_sleep property to true.

This will ensure that a warning is printed when trying to get the
value from a context that potentially can't sleep.

Fixes: 348f3cde84ab ("gpio: Add Spreadtrum PMIC EIC driver support")
Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-pmic-eic-sprd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index e518490c4b681..ebbbcb54270d1 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -337,6 +337,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	pmic_eic->chip.set_config = sprd_pmic_eic_set_config;
 	pmic_eic->chip.set = sprd_pmic_eic_set;
 	pmic_eic->chip.get = sprd_pmic_eic_get;
+	pmic_eic->chip.can_sleep = true;
 
 	pmic_eic->intc.name = dev_name(&pdev->dev);
 	pmic_eic->intc.irq_mask = sprd_pmic_eic_irq_mask;
-- 
2.40.1



