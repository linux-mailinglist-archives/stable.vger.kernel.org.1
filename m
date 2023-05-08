Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FB76FAC49
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjEHLXD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjEHLXC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:23:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B33701A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F5D462CAA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE18C433D2;
        Mon,  8 May 2023 11:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544965;
        bh=vUx02TOStQc4xnXRJqoMKJTGwsr1mViVOJ9jgvvmFyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJcHZENgBTsqjnPpXKCbWSiAZC5/+VER+enhuiVtzL0abgk2d6V16POrBskpkQK+j
         2He4E+bxG60eOimWRbakpaqNF13Pby52gfiPRrKren+Mae14fDpjBOr086HauwWuzh
         +K+2EP+lkCPFGvQbuhnjhWBN14DN4rEMegmx6JAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dhruva Gole <d-gole@ti.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 550/694] spi: cadence-quadspi: use macro DEFINE_SIMPLE_DEV_PM_OPS
Date:   Mon,  8 May 2023 11:46:25 +0200
Message-Id: <20230508094452.409260163@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Dhruva Gole <d-gole@ti.com>

[ Upstream commit be3206e8906e7a93df673ab2e96d69304a008edc ]

Using this macro makes the code more readable.
It also inits the members of dev_pm_ops in the following manner
without us explicitly needing to:

.suspend = cqspi_suspend, \
.resume = cqspi_resume, \
.freeze = cqspi_suspend, \
.thaw = cqspi_resume, \
.poweroff = cqspi_suspend, \
.restore = cqspi_resume

Also get rid of conditional compilation based on CONFIG_PM_SLEEP because
it introduces build issues with certain configs when CQSPI_DEV_PM_OPS is
just NULL.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304191900.2fARFQW9-lkp@intel.com/
Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
Link: https://lore.kernel.org/r/20230420054257.925092-1-d-gole@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1802,7 +1802,6 @@ static int cqspi_remove(struct platform_
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int cqspi_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
@@ -1832,15 +1831,7 @@ static int cqspi_resume(struct device *d
 	return spi_master_resume(master);
 }
 
-static const struct dev_pm_ops cqspi__dev_pm_ops = {
-	.suspend = cqspi_suspend,
-	.resume = cqspi_resume,
-};
-
-#define CQSPI_DEV_PM_OPS	(&cqspi__dev_pm_ops)
-#else
-#define CQSPI_DEV_PM_OPS	NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend, cqspi_resume);
 
 static const struct cqspi_driver_platdata cdns_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
@@ -1907,7 +1898,7 @@ static struct platform_driver cqspi_plat
 	.remove = cqspi_remove,
 	.driver = {
 		.name = CQSPI_NAME,
-		.pm = CQSPI_DEV_PM_OPS,
+		.pm = &cqspi_dev_pm_ops,
 		.of_match_table = cqspi_dt_ids,
 	},
 };


