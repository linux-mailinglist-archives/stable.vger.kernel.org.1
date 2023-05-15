Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039BD703A0F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244746AbjEORsJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244620AbjEORro (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:47:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F9919F0D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2094A62EDA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12825C433D2;
        Mon, 15 May 2023 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172780;
        bh=Tsm850rU7/rC7EYIcmSHAI2raHqCOV1CYD7LlqRaxOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tydi/kUCcM8tNTibs6TeQ7r+EJyrypvpzDzVpKawymd/1eGTn/pBNYGI9b04bvPpF
         H6EA2yaIXO+hIII5I412yzJba5nRUKp3D+EOQxutiuLWmGQrBf51oDLYaLtjHPIYMe
         rZE0vwXvZWEQsmZ++WKYOiy9on2DnWujB1q5ePkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 265/381] pwm: mtk-disp: Dont check the return code of pwmchip_remove()
Date:   Mon, 15 May 2023 18:28:36 +0200
Message-Id: <20230515161748.721724641@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 9b7b5736ffd5da6f8f6329ebe5f1829cbcf8afae ]

pwmchip_remove() returns always 0. Don't use the value to make it
possible to eventually change the function to return void. Also the
driver core ignores the return value of mtk_disp_pwm_remove().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Stable-dep-of: 36dd7f530ae7 ("pwm: mtk-disp: Disable shadow registers before setting backlight values")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-mtk-disp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 83b8be0209b74..af63aaab8e153 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -240,13 +240,12 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 static int mtk_disp_pwm_remove(struct platform_device *pdev)
 {
 	struct mtk_disp_pwm *mdp = platform_get_drvdata(pdev);
-	int ret;
 
-	ret = pwmchip_remove(&mdp->chip);
+	pwmchip_remove(&mdp->chip);
 	clk_unprepare(mdp->clk_mm);
 	clk_unprepare(mdp->clk_main);
 
-	return ret;
+	return 0;
 }
 
 static const struct mtk_pwm_data mt2701_pwm_data = {
-- 
2.39.2



