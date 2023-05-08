Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBCF6FA4B4
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjEHKCp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjEHKCl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:02:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662A919916
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:02:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42DC7622D8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AA3C433EF;
        Mon,  8 May 2023 10:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540139;
        bh=E985gS0XTiQghzO+1q2fkBOFLD3foyHgpbS3V42cqYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhO0t/o60Ts2bQk36PkX8ts/K7XTQcNgBJ/2hWVu4OEADiP5ID0Qps78iBHoa1Lto
         N77ILz7EhHrpJ5WUMbkTagfNzzHWQ/xYlN7+DNlAegQ9n9HjQ8nBBB5T0b/NQs/bxY
         gZ6PXwko34YOLSpda1mra0D1h7VvMH3Xo2LDkaA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, YAN SHI <m202071378@hust.edu.cn>,
        kernel test robot <lkp@intel.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 252/611] regulator: stm32-pwr: fix of_iomap leak
Date:   Mon,  8 May 2023 11:41:34 +0200
Message-Id: <20230508094430.608335974@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: YAN SHI <m202071378@hust.edu.cn>

[ Upstream commit c4a413e56d16a2ae84e6d8992f215c4dcc7fac20 ]

Smatch reports:
drivers/regulator/stm32-pwr.c:166 stm32_pwr_regulator_probe() warn:
'base' from of_iomap() not released on lines: 151,166.

In stm32_pwr_regulator_probe(), base is not released
when devm_kzalloc() fails to allocate memory or
devm_regulator_register() fails to register a new regulator device,
which may cause a leak.

To fix this issue, replace of_iomap() with
devm_platform_ioremap_resource(). devm_platform_ioremap_resource()
is a specialized function for platform devices.
It allows 'base' to be automatically released whether the probe
function succeeds or fails.

Besides, use IS_ERR(base) instead of !base
as the return value of devm_platform_ioremap_resource()
can either be a pointer to the remapped memory or
an ERR_PTR() encoded error code if the operation fails.

Fixes: dc62f951a6a8 ("regulator: stm32-pwr: Fix return value check in stm32_pwr_regulator_probe()")
Signed-off-by: YAN SHI <m202071378@hust.edu.cn>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304111750.o2643eJN-lkp@intel.com/
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Link: https://lore.kernel.org/r/20230412033529.18890-1-m202071378@hust.edu.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/stm32-pwr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 2a42acb7c24e9..e5dd4db6403b2 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -129,17 +129,16 @@ static const struct regulator_desc stm32_pwr_desc[] = {
 
 static int stm32_pwr_regulator_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct stm32_pwr_reg *priv;
 	void __iomem *base;
 	struct regulator_dev *rdev;
 	struct regulator_config config = { };
 	int i, ret = 0;
 
-	base = of_iomap(np, 0);
-	if (!base) {
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base)) {
 		dev_err(&pdev->dev, "Unable to map IO memory\n");
-		return -ENOMEM;
+		return PTR_ERR(base);
 	}
 
 	config.dev = &pdev->dev;
-- 
2.39.2



