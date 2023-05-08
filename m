Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BF16FAC9D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjEHL02 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbjEHL0X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183E73A5E6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 974FC62DAD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8767BC433D2;
        Mon,  8 May 2023 11:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545155;
        bh=2xggPDpSEwX8FW7vsw5yQyvymV8ddtNgOii211PaBoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xncq0VeIitdi/tHOcixX9B4mPohkWqlK6NszKAIXGUdeb8I76pPx8feyKJs5GUSv4
         OKBwLtk1vT3UNrDSVi1rrWUVuKO5OxApFU9O2ZHel0BU2YDvl+O1PzJLQHtTzKKY1o
         vgEC683zxXyNpSJRipB5q+CVZhHMtyl/B005WmtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 641/694] pinctrl: ralink: reintroduce ralink,rt2880-pinmux compatible string
Date:   Mon,  8 May 2023 11:47:56 +0200
Message-Id: <20230508094456.582309241@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

[ Upstream commit 7c19147d9cfc0f9328049d2e278279150d7de9ca ]

There have been stable releases with the ralink,rt2880-pinmux compatible
string included. Having it removed breaks the ABI. Reintroduce it.

Fixes: e5981cd46183 ("pinctrl: ralink: add new compatible strings for each pinctrl subdriver")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Link: https://lore.kernel.org/r/20230317213011.13656-2-arinc.unal@arinc9.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/ralink/pinctrl-mt7620.c | 1 +
 drivers/pinctrl/ralink/pinctrl-mt7621.c | 1 +
 drivers/pinctrl/ralink/pinctrl-rt2880.c | 1 +
 drivers/pinctrl/ralink/pinctrl-rt305x.c | 1 +
 drivers/pinctrl/ralink/pinctrl-rt3883.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/pinctrl/ralink/pinctrl-mt7620.c b/drivers/pinctrl/ralink/pinctrl-mt7620.c
index 4e8d26bb34302..06b86c7268392 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7620.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7620.c
@@ -372,6 +372,7 @@ static int mt7620_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id mt7620_pinctrl_match[] = {
 	{ .compatible = "ralink,mt7620-pinctrl" },
+	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mt7620_pinctrl_match);
diff --git a/drivers/pinctrl/ralink/pinctrl-mt7621.c b/drivers/pinctrl/ralink/pinctrl-mt7621.c
index eddc0ba6d468c..fb5824922e788 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7621.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7621.c
@@ -97,6 +97,7 @@ static int mt7621_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id mt7621_pinctrl_match[] = {
 	{ .compatible = "ralink,mt7621-pinctrl" },
+	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mt7621_pinctrl_match);
diff --git a/drivers/pinctrl/ralink/pinctrl-rt2880.c b/drivers/pinctrl/ralink/pinctrl-rt2880.c
index 3e2f1aaaf0957..d7a65fcc7755a 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt2880.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt2880.c
@@ -41,6 +41,7 @@ static int rt2880_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id rt2880_pinctrl_match[] = {
 	{ .compatible = "ralink,rt2880-pinctrl" },
+	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rt2880_pinctrl_match);
diff --git a/drivers/pinctrl/ralink/pinctrl-rt305x.c b/drivers/pinctrl/ralink/pinctrl-rt305x.c
index bdaee5ce1ee08..f6092c64383e5 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt305x.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt305x.c
@@ -118,6 +118,7 @@ static int rt305x_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id rt305x_pinctrl_match[] = {
 	{ .compatible = "ralink,rt305x-pinctrl" },
+	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rt305x_pinctrl_match);
diff --git a/drivers/pinctrl/ralink/pinctrl-rt3883.c b/drivers/pinctrl/ralink/pinctrl-rt3883.c
index 392208662355d..5f766d76bafa6 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt3883.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt3883.c
@@ -88,6 +88,7 @@ static int rt3883_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id rt3883_pinctrl_match[] = {
 	{ .compatible = "ralink,rt3883-pinctrl" },
+	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rt3883_pinctrl_match);
-- 
2.39.2



