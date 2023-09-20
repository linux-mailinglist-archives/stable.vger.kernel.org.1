Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD537A7D32
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjITMHd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjITMHY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:07:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD8E118
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:07:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805CCC433C9;
        Wed, 20 Sep 2023 12:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211633;
        bh=3fFGPrWjlysK+1jbGr2bKT1gdNEIe4hGbW+xl8BGUSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpKOaEHcoOdOjqsjuVs4J0W4cjZAzgBHrx7yiXbDvJJELcWuhmY6mglzbSS8AaUhw
         IMfTaO2K2vbqi1/4LHfbOciLLc2VHubvCN8SgW4otAGxQtYf9XJVaSDi3P/Jik6dcs
         USJn3Gy0WpaDad62bxDbPdMKbTwIrjyM0njJ5740=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Raag Jadav <raag.jadav@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 129/186] watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load
Date:   Wed, 20 Sep 2023 13:30:32 +0200
Message-ID: <20230920112841.681210399@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raag Jadav <raag.jadav@intel.com>

[ Upstream commit cf38e7691c85f1b09973b22a0b89bf1e1228d2f9 ]

When built with CONFIG_INTEL_MID_WATCHDOG=m, currently the driver
needs to be loaded manually, for the lack of module alias.
This causes unintended resets in cases where watchdog timer is
set-up by bootloader and the driver is not explicitly loaded.
Add MODULE_ALIAS() to load the driver automatically at boot and
avoid this issue.

Fixes: 87a1ef8058d9 ("watchdog: add Intel MID watchdog driver support")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230811120220.31578-1-raag.jadav@intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/intel-mid_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 72c108a12c19d..0dec3fba02b99 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -186,3 +186,4 @@ module_platform_driver(mid_wdt_driver);
 MODULE_AUTHOR("David Cohen <david.a.cohen@linux.intel.com>");
 MODULE_DESCRIPTION("Watchdog Driver for Intel MID platform");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:intel_mid_wdt");
-- 
2.40.1



