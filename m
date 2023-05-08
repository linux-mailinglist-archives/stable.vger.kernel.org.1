Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B676FA93F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbjEHKti (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjEHKtQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:49:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677191713
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83C0D616E2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B476C433D2;
        Mon,  8 May 2023 10:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542915;
        bh=4vR5/tlJdEYQUBQJYaJA1qYWOrxXxZyIjX1fCtvUiwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dddHR592ED4mRdPpWAnoJ4yVfoctv9tdowCMUkYPU5r3a0XjOX2cHewUhqSzR6ejl
         e1+4oVR8U2v8RSdvJwAW1OTUwm8YTJTTEFmv5JTrOhxR9TJCnWc1Mre/GZOhAqAHKF
         r4GaHpFMlFBqlaDAfyM/1TeCPSMhXPK7iAOMmJRY=
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
Subject: [PATCH 6.2 588/663] pwm: mtk-disp: Configure double buffering before reading in .get_state()
Date:   Mon,  8 May 2023 11:46:54 +0200
Message-Id: <20230508094448.483335740@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

[ Upstream commit b16c310115f2084b8826a35b77ef42bab6786d9f ]

The DISP_PWM controller's default behavior is to always use register
double buffering: all reads/writes are then performed on shadow
registers instead of working registers and this becomes an issue
in case our chosen configuration in Linux is different from the
default (or from the one that was pre-applied by the bootloader).

An example of broken behavior is when the controller is configured
to use shadow registers, but this driver wants to configure it
otherwise: what happens is that the .get_state() callback is called
right after registering the pwmchip and checks whether the PWM is
enabled by reading the DISP_PWM_EN register;
At this point, if shadow registers are enabled but their content
was not committed before booting Linux, we are *not* reading the
current PWM enablement status, leading to the kernel knowing that
the hardware is actually enabled when, in reality, it's not.

The aforementioned issue emerged since this driver was fixed with
commit 0b5ef3429d8f ("pwm: mtk-disp: Fix the parameters calculated
by the enabled flag of disp_pwm") making it to read the enablement
status from the right register.

Configure the controller in the .get_state() callback to avoid
this desync issue and get the backlight properly working again.

Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-mtk-disp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 82b430d881a20..fe9593f968eeb 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -196,6 +196,16 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
 		return err;
 	}
 
+	/*
+	 * Apply DISP_PWM_DEBUG settings to choose whether to enable or disable
+	 * registers double buffer and manual commit to working register before
+	 * performing any read/write operation
+	 */
+	if (mdp->data->bls_debug)
+		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
+					 mdp->data->bls_debug_mask,
+					 mdp->data->bls_debug_mask);
+
 	rate = clk_get_rate(mdp->clk_main);
 	con0 = readl(mdp->base + mdp->data->con0);
 	con1 = readl(mdp->base + mdp->data->con1);
-- 
2.39.2



