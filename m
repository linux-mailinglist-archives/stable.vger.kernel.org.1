Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC427BDF97
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377077AbjJINbl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377085AbjJINbk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:31:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F119699
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:31:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E472C433C8;
        Mon,  9 Oct 2023 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858299;
        bh=BB2Da4QZqzBngBayVykfByLmOb4d7Y/ScwqYhOkqZzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBjUJKMzUhMfZiUrHjY402qT9O8rAcPsMxb+qDsZ9CO238bWxd0Uz/9Lo2TJsQXAS
         5vshd2T6+d2OQjLArHBbkK8uDNbm2mb+3dZtO7Pim6IXm45sX2VKqppZ3h4sU8xMzv
         HWMdR229nDWHbU/3lOffPBOSwKMQ7ut8x5yO322k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 051/131] gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip
Date:   Mon,  9 Oct 2023 15:01:31 +0200
Message-ID: <20231009130117.864212811@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 05000cace9b24..abe01518bf19f 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -338,6 +338,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	pmic_eic->chip.set_config = sprd_pmic_eic_set_config;
 	pmic_eic->chip.set = sprd_pmic_eic_set;
 	pmic_eic->chip.get = sprd_pmic_eic_get;
+	pmic_eic->chip.can_sleep = true;
 
 	pmic_eic->intc.name = dev_name(&pdev->dev);
 	pmic_eic->intc.irq_mask = sprd_pmic_eic_irq_mask;
-- 
2.40.1



