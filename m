Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7C575569C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjGPUwO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjGPUwN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:52:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5963FDD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:52:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D27F460EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8C2C433C8;
        Sun, 16 Jul 2023 20:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540731;
        bh=KRZvRXrvHBfo78bOjEbwQmk5/eKVhSdKY+xNo+YuY+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBLmQ8kjfsxbIy2IdiiG74R9+zNPfMQiblzneImKrEWO/42Bwbz4BnUvDwYWOamwO
         yNp7xYaQvUNqoX2KOkDmWAcpAGM4l4OeRvuojb5BNQzWk/B5WE+II/H7uu3hf3Lju3
         yb+3QNot8IuLQzRWnzHkLPMo9d0RMm1vpl0+l77w=
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
Subject: [PATCH 6.1 460/591] pwm: mtk_disp: Fix the disable flow of disp_pwm
Date:   Sun, 16 Jul 2023 21:49:59 +0200
Message-ID: <20230716194935.803322333@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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
index 3811578fcff05..db286284f3ee0 100644
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



