Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3F37553DB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjGPUXo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjGPUXn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:23:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74ACBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7574260EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8125EC433C9;
        Sun, 16 Jul 2023 20:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539021;
        bh=UDFHIa//qAXE0YJ441616BDGSkFA+R0YV+9DQ3865zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvqO/luV3/KvyWPZm/wCm1SZOZLVRMk9YcKpp881EzZDhiNQOMRCQpz7PUbCt5axm
         1NhTpAYf0GVAR6Xad4HANaISe9FtA5oQtPwU0PNnIQ9jfife1c83450DRfqIimLLCg
         3cZNgR75PDHHjDpbNWaCG5CnFBnfUrc5Mem7MVNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yi Yingao <m202271736@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 629/800] nvmem: sunplus-ocotp: release otp->clk before return
Date:   Sun, 16 Jul 2023 21:48:02 +0200
Message-ID: <20230716195003.721735561@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Yi Yingao <m202271736@hust.edu.cn>

[ Upstream commit 095bb8ba45f28ed15296eb5b7662e03e57d5e34e ]

Smatch reports:
drivers/nvmem/sunplus-ocotp.c:205 sp_ocotp_probe()
warn: 'otp->clk' from clk_prepare() not released on lines: 196.

In the function sp_ocotp_probe(struct platform_device *pdev), otp->clk may
not be released before return.

To fix this issue, using function clk_unprepare() to release otp->clk.

Fixes: 8747ec2e9762 ("nvmem: Add driver for OCOTP in Sunplus SP7021")
Signed-off-by: Yi Yingao <m202271736@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Message-ID: <20230509085237.5917-1-m202271736@hust.edu.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/sunplus-ocotp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index 52b928a7a6d58..f85350b17d672 100644
--- a/drivers/nvmem/sunplus-ocotp.c
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -192,9 +192,11 @@ static int sp_ocotp_probe(struct platform_device *pdev)
 	sp_ocotp_nvmem_config.dev = dev;
 
 	nvmem = devm_nvmem_register(dev, &sp_ocotp_nvmem_config);
-	if (IS_ERR(nvmem))
-		return dev_err_probe(&pdev->dev, PTR_ERR(nvmem),
+	if (IS_ERR(nvmem)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(nvmem),
 						"register nvmem device fail\n");
+		goto err;
+	}
 
 	platform_set_drvdata(pdev, nvmem);
 
@@ -203,6 +205,9 @@ static int sp_ocotp_probe(struct platform_device *pdev)
 		(int)OTP_WORD_SIZE, (int)QAC628_OTP_SIZE);
 
 	return 0;
+err:
+	clk_unprepare(otp->clk);
+	return ret;
 }
 
 static const struct of_device_id sp_ocotp_dt_ids[] = {
-- 
2.39.2



