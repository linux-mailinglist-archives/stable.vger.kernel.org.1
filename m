Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CEB7553CA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjGPUXC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjGPUW7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:22:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDFB1B7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B338160E9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE242C433C9;
        Sun, 16 Jul 2023 20:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538977;
        bh=Mo+2sOUsK6i1DbjflI+Z0dR4bMqHsBmYSc3qnPFE3GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xY4hZIoPTzudmS13LkwspWS0Oarp7+F2C2KvidJOa92csioZi73YtdIsnE0Xz8Np4
         XfOX0hPZ2IYI0no9zA+mKegrPneKlR40UVwuVIcdc4URPAWL4IeC9bT7qlxefuA+Z1
         XUAOBW8CSdCyUbQaVDp02zbL5zDZCrCG7fhHSGqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 643/800] mfd: stmpe: Only disable the regulators if they are enabled
Date:   Sun, 16 Jul 2023 21:48:16 +0200
Message-ID: <20230716195004.049119640@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 104d32bd81f620bb9f67fbf7d1159c414e89f05f ]

In stmpe_probe(), if some regulator_enable() calls fail, probing continues
and there is only a dev_warn().

So, if stmpe_probe() is called the regulator may not be enabled. It is
cleaner to test it before calling regulator_disable() in the remove
function.

Fixes: 9c9e321455fb ("mfd: stmpe: add optional regulators")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/8de3aaf297931d655b9ad6aed548f4de8b85425a.1686998575.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmpe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index a92301dfc7126..9c3cf58457a7d 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1485,9 +1485,9 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 
 void stmpe_remove(struct stmpe *stmpe)
 {
-	if (!IS_ERR(stmpe->vio))
+	if (!IS_ERR(stmpe->vio) && regulator_is_enabled(stmpe->vio))
 		regulator_disable(stmpe->vio);
-	if (!IS_ERR(stmpe->vcc))
+	if (!IS_ERR(stmpe->vcc) && regulator_is_enabled(stmpe->vcc))
 		regulator_disable(stmpe->vcc);
 
 	__stmpe_disable(stmpe, STMPE_BLOCK_ADC);
-- 
2.39.2



