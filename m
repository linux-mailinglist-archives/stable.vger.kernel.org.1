Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0C5703849
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244257AbjEORb0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244269AbjEORai (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B210513C18
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:27:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFD9062D10
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E55C433EF;
        Mon, 15 May 2023 17:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171622;
        bh=nS6aM9AY1Bgs3wx+KVgG80mV3Jl/9j6/u8OMDFdsE/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODdJLUUXq8Scwh93ANewIiM0rNA7R7wVMi0Xo8mGohsqrfUt+3fNPPy0QRyNs2RRP
         t0EhgnJI8R1lvEvTVX6O7E2YlZp67n+wpBuDdxaBVG0yyj1lRL5ckLfFOAIk9+rDhZ
         HNOnDJzbjoPOoI4IMAtWcJmSCHSy/2c6bvZ6xheQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 026/134] watchdog: dw_wdt: Fix the error handling path of dw_wdt_drv_probe()
Date:   Mon, 15 May 2023 18:28:23 +0200
Message-Id: <20230515161703.899312931@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 7f5390750645756bd5da2b24fac285f2654dd922 ]

The commit in Fixes has only updated the remove function and missed the
error handling path of the probe.

Add the missing reset_control_assert() call.

Fixes: 65a3b6935d92 ("watchdog: dw_wdt: get reset lines from dt")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/fbb650650bbb33a8fa2fd028c23157bedeed50e1.1682491863.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/dw_wdt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index cd578843277e5..498c1c403fc92 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -637,7 +637,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = dw_wdt_init_timeouts(dw_wdt, dev);
 	if (ret)
-		goto out_disable_clk;
+		goto out_assert_rst;
 
 	wdd = &dw_wdt->wdd;
 	wdd->ops = &dw_wdt_ops;
@@ -668,12 +668,15 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = watchdog_register_device(wdd);
 	if (ret)
-		goto out_disable_pclk;
+		goto out_assert_rst;
 
 	dw_wdt_dbgfs_init(dw_wdt);
 
 	return 0;
 
+out_assert_rst:
+	reset_control_assert(dw_wdt->rst);
+
 out_disable_pclk:
 	clk_disable_unprepare(dw_wdt->pclk);
 
-- 
2.39.2



