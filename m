Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC8713E11
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjE1Tbx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjE1Tbv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:31:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281A9F4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C240B61D77
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E020EC433D2;
        Sun, 28 May 2023 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302295;
        bh=6K1WKXiGtaaBAYlee+bD6Fz7w0DF+09GNVFlvmoHlww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2UY4iZ53WAYCeQduzL9R3wRkEE9eB0dT99sjtbx3elrUM3Yn275WpsPr6V8ir/vQJ
         ZLFwGL62XBi/3vMRG2uLUez3BuR53qTN3B1QwDHvcXGgqFcx6Q+ZdSmYi/HMF42hdt
         GItjda59kqdM5XiXNkFs636XvI4e+U5tEOw2sbYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kang Chen <void0red@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.3 078/127] power: supply: mt6360: add a check of devm_work_autocancel in mt6360_charger_probe
Date:   Sun, 28 May 2023 20:10:54 +0100
Message-Id: <20230528190838.908491912@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kang Chen <void0red@gmail.com>

commit 4cbb0d358883a27e432714b5256f0362946f5e25 upstream.

devm_work_autocancel may fail, add a check and return early.

Fixes: 0402e8ebb8b86 ("power: supply: mt6360_charger: add MT6360 charger support")
Signed-off-by: Kang Chen <void0red@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/mt6360_charger.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -796,7 +796,9 @@ static int mt6360_charger_probe(struct p
 	mci->vinovp = 6500000;
 	mutex_init(&mci->chgdet_lock);
 	platform_set_drvdata(pdev, mci);
-	devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
+	ret = devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
 
 	ret = device_property_read_u32(&pdev->dev, "richtek,vinovp-microvolt", &mci->vinovp);
 	if (ret)


