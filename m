Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97928703B9E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbjEOSEh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244973AbjEOSER (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:04:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E7F1BB81
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 555B363058
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46830C4339C;
        Mon, 15 May 2023 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173723;
        bh=PuJhJ386qkY3xe3BLwUd8Qs6572r5SKV0MWy8mHBvuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJ0UeOv2+n3EXx3wVsmbHfGNMR0J9z9IwV6NFYRDznJcdSycSRFTZK83wn6cV5hMQ
         FRuPnkvJWAEo/xu9iYpjIBIwLaQxsTKyErTOPTwlse+8jYDSdRGjjrWQ6T/LayYZB6
         Pswghp2X6XFk+y0ZlqkABIpDHXHW+kepcWFH/dAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" 
        <nfraprado@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 186/282] pwm: mtk-disp: Disable shadow registers before setting backlight values
Date:   Mon, 15 May 2023 18:29:24 +0200
Message-Id: <20230515161727.847183572@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 36dd7f530ae7d9ce9e853ffb8aa337de65c6600b ]

If shadow registers usage is not desired, disable that before performing
any write to CON0/1 registers in the .apply() callback, otherwise we may
lose clkdiv or period/width updates.

Fixes: cd4b45ac449a ("pwm: Add MediaTek MT2701 display PWM driver support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-mtk-disp.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index a594a0fdddd7b..327c780d433da 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -114,6 +114,19 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	high_width = div64_u64(rate * duty_ns, div);
 	value = period | (high_width << PWM_HIGH_WIDTH_SHIFT);
 
+	if (mdp->data->bls_debug && !mdp->data->has_commit) {
+		/*
+		 * For MT2701, disable double buffer before writing register
+		 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
+		 */
+		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
+					 mdp->data->bls_debug_mask,
+					 mdp->data->bls_debug_mask);
+		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
+					 mdp->data->con0_sel,
+					 mdp->data->con0_sel);
+	}
+
 	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
 				 PWM_CLKDIV_MASK,
 				 clk_div << PWM_CLKDIV_SHIFT);
@@ -128,17 +141,6 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		mtk_disp_pwm_update_bits(mdp, mdp->data->commit,
 					 mdp->data->commit_mask,
 					 0x0);
-	} else {
-		/*
-		 * For MT2701, disable double buffer before writing register
-		 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
-		 */
-		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
-					 mdp->data->bls_debug_mask,
-					 mdp->data->bls_debug_mask);
-		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
-					 mdp->data->con0_sel,
-					 mdp->data->con0_sel);
 	}
 
 	clk_disable_unprepare(mdp->clk_mm);
-- 
2.39.2



