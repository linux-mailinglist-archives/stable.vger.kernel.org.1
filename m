Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB397553D0
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjGPUXQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGPUXP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:23:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A69F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9434660EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCF2C433C7;
        Sun, 16 Jul 2023 20:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538994;
        bh=yQ7AZJ+Z8icOdPlhcOSKZ3kRxEo3o9pTocU+Wvm6l+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYmPRTAFNUx4sFbIJHb6kFvKShERCZrEdt8cAVhHplrvq40E8wR4lllzcOuIV4IZa
         06Gibk0vaHINPcbWLp/FtdNw+igbClht6ypbDOYjihbngzO8fZDEvtQ0/6HwBWOAaV
         47S1Xo672ZZkuN64UnW3ecdhfFZavBEdtLT4oMIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shuijing Li <shuijing.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fei Shao <fshao@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 649/800] pwm: mtk_disp: Fix the disable flow of disp_pwm
Date:   Sun, 16 Jul 2023 21:48:22 +0200
Message-ID: <20230716195004.188728473@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shuijing Li <shuijing.li@mediatek.com>

[ Upstream commit bc13d60e4e1e945b34769a4a4c2b172e8552abe5 ]

There is a flow error in the original mtk_disp_pwm_apply() function.
If this function is called when the clock is disabled, there will be a
chance to operate the disp_pwm register, resulting in disp_pwm exception.
Fix this accordingly.

Fixes: 888a623db5d0 ("pwm: mtk-disp: Implement atomic API .apply()")
Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Tested-by: Fei Shao <fshao@chromium.org>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-mtk-disp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 79e321e96f56a..2401b67332417 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -79,14 +79,11 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
-	if (!state->enabled) {
-		mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
-					 0x0);
-
-		if (mdp->enabled) {
-			clk_disable_unprepare(mdp->clk_mm);
-			clk_disable_unprepare(mdp->clk_main);
-		}
+	if (!state->enabled && mdp->enabled) {
+		mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN,
+					 mdp->data->enable_mask, 0x0);
+		clk_disable_unprepare(mdp->clk_mm);
+		clk_disable_unprepare(mdp->clk_main);
 
 		mdp->enabled = false;
 		return 0;
-- 
2.39.2



