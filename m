Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E4F703611
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243607AbjEORGC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243608AbjEORFl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:05:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8C96A52
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3614E62A8B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339B0C433EF;
        Mon, 15 May 2023 17:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170248;
        bh=k+H5OkRSfoOMeCwAw7iGPs2b0KLH/JBLoO2rkJw9hYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvs+oC4cEhlZ2uMufhQgaHl6YwkXJSbLWXS9Iu1zt6cev49YXIJvXeLjSCpyg+gRb
         qlqgsWJbipfVHlqFhbZe4DkafO8IqAOXysXxOr7IypPv1L1p8l/OvztbMO8lI9ioRj
         dX9XdZf0D8D35g7CJdPqlvHu51bat7LEB3IG3m9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 053/239] watchdog: dw_wdt: Fix the error handling path of dw_wdt_drv_probe()
Date:   Mon, 15 May 2023 18:25:16 +0200
Message-Id: <20230515161723.298144314@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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
index 52962e8d11a6f..61af5d1332ac6 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -635,7 +635,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = dw_wdt_init_timeouts(dw_wdt, dev);
 	if (ret)
-		goto out_disable_clk;
+		goto out_assert_rst;
 
 	wdd = &dw_wdt->wdd;
 	wdd->ops = &dw_wdt_ops;
@@ -666,12 +666,15 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
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



