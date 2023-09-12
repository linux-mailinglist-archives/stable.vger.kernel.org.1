Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D779B224
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354159AbjIKVwj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbjIKOUm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:20:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354D5DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:20:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C71C433C8;
        Mon, 11 Sep 2023 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442036;
        bh=p/yrFdpZMwmvbg8yHlHxcp6YldmacgrlppBFHJiSmig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjO7ZB4kp9pjeOGq3Oa6jlEHY9dfmPO5T5yW31HrFS7h7Zogn1WbYmBdd9Erl8qFY
         95gQxEVhGd0ct1wqmjRL1tLAciQhFWFIH0S3sRij7PToIllFovy1P7iRTK9Yl13b5o
         P1h9i+l+lajKlgR/cJBPtxBKTTieakAFY8FIc1Is=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 624/739] remoteproc: stm32: fix incorrect optional pointers
Date:   Mon, 11 Sep 2023 15:47:03 +0200
Message-ID: <20230911134708.527662343@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit fb2bdd32b231b70e6a3f1054528692f604db25d8 ]

Compile-testing without CONFIG_OF shows that the of_match_ptr() macro
was used incorrectly here:

drivers/remoteproc/stm32_rproc.c:662:34: warning: unused variable 'stm32_rproc_match' [-Wunused-const-variable]

As in almost every driver, the solution is simply to remove the
use of this macro. The same thing happened with the deprecated
SIMPLE_DEV_PM_OPS(), but the corresponding warning was already shut
up with __maybe_unused annotations, so fix those as well by using the
correct DEFINE_SIMPLE_DEV_PM_OPS() macros and removing the extraneous
__maybe_unused modifiers. For completeness, also add a pm_ptr() to let
the PM ops be eliminated completely when CONFIG_PM is turned off.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307242300.ia82qBTp-lkp@intel.com
Fixes: 03bd158e1535 ("remoteproc: stm32: use correct format strings on 64-bit")
Fixes: 410119ee29b6 ("remoteproc: stm32: wakeup the system by wdg irq")
Fixes: 13140de09cc2 ("remoteproc: stm32: add an ST stm32_rproc driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Link: https://lore.kernel.org/r/20230724195704.2432382-1-arnd@kernel.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/stm32_rproc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index cf073bac79f73..48dca3503fa45 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -921,7 +921,7 @@ static void stm32_rproc_remove(struct platform_device *pdev)
 	rproc_free(rproc);
 }
 
-static int __maybe_unused stm32_rproc_suspend(struct device *dev)
+static int stm32_rproc_suspend(struct device *dev)
 {
 	struct rproc *rproc = dev_get_drvdata(dev);
 	struct stm32_rproc *ddata = rproc->priv;
@@ -932,7 +932,7 @@ static int __maybe_unused stm32_rproc_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused stm32_rproc_resume(struct device *dev)
+static int stm32_rproc_resume(struct device *dev)
 {
 	struct rproc *rproc = dev_get_drvdata(dev);
 	struct stm32_rproc *ddata = rproc->priv;
@@ -943,16 +943,16 @@ static int __maybe_unused stm32_rproc_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stm32_rproc_pm_ops,
-			 stm32_rproc_suspend, stm32_rproc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_rproc_pm_ops,
+				stm32_rproc_suspend, stm32_rproc_resume);
 
 static struct platform_driver stm32_rproc_driver = {
 	.probe = stm32_rproc_probe,
 	.remove_new = stm32_rproc_remove,
 	.driver = {
 		.name = "stm32-rproc",
-		.pm = &stm32_rproc_pm_ops,
-		.of_match_table = of_match_ptr(stm32_rproc_match),
+		.pm = pm_ptr(&stm32_rproc_pm_ops),
+		.of_match_table = stm32_rproc_match,
 	},
 };
 module_platform_driver(stm32_rproc_driver);
-- 
2.40.1



