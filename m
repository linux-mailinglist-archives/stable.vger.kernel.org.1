Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76FD75568E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjGPUvs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjGPUvo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:51:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8774E41
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 766E960DFD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B581C433C7;
        Sun, 16 Jul 2023 20:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540702;
        bh=54TWsf7ieUkrppoEHozSbcGDsSD9WwlMYmXFDhUOQI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yZPQrk+bJLGKqeUFIMnQxR88uRMZdtQ7q1g8T+rgx5MZ+WRYwQQqAoyZx17FbGhNO
         JXnKLEE1toY6/zWFpHuXYnX11pO8+3VPpeOkWnpw24toEI3XhJHf3V26Pi2qy3nxHb
         U8UqqJcsqjbaj0QXSjE6jj6btpNWNZ0buS8+g+kY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fancy Fang <chen.fang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 457/591] pwm: imx-tpm: force real_period to be zero in suspend
Date:   Sun, 16 Jul 2023 21:49:56 +0200
Message-ID: <20230716194935.728951427@linuxfoundation.org>
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

From: Fancy Fang <chen.fang@nxp.com>

[ Upstream commit 661dfb7f46298e53f6c3deaa772fa527aae86193 ]

During suspend, all the tpm registers will lose values.
So the 'real_period' value of struct 'imx_tpm_pwm_chip'
should be forced to be zero to force the period update
code can be executed after system resume back.

Signed-off-by: Fancy Fang <chen.fang@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Fixes: 738a1cfec2ed ("pwm: Add i.MX TPM PWM driver support")
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-imx-tpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index ed1aad96fff04..318dc0be974b4 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -399,6 +399,13 @@ static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
 	if (tpm->enable_count > 0)
 		return -EBUSY;
 
+	/*
+	 * Force 'real_period' to be zero to force period update code
+	 * can be executed after system resume back, since suspend causes
+	 * the period related registers to become their reset values.
+	 */
+	tpm->real_period = 0;
+
 	clk_disable_unprepare(tpm->clk);
 
 	return 0;
-- 
2.39.2



