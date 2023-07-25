Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3141761463
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjGYLSx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjGYLSt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:18:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB27A6
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E311F61683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BD0C433C7;
        Tue, 25 Jul 2023 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283927;
        bh=5kFLuImLs3V/DSTa9m/+9g0572ncRwCU2znS9UTPEYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ZEE54muALQTjFEnBV0ynD/S1SOd1r2gqNJY/tYWRoRhTv8UXZNs5qkfWt1SV7S1X
         cILipOjwn9uXkhgQBM2ibwZFqEIJOZCbckO2CWLZIaIAoNBRtUG7QfFhHd2mgEy6py
         /D/w9dJ6L7Sri1uKaJDIlVN89lF/NEQ2D6QAONyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexey Romanov <avromanov@sberdevices.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 172/509] drivers: meson: secure-pwrc: always enable DMA domain
Date:   Tue, 25 Jul 2023 12:41:51 +0200
Message-ID: <20230725104601.608374133@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexey Romanov <avromanov@sberdevices.ru>

[ Upstream commit 0bb4644d583789c97e74d3e3047189f0c59c4742 ]

Starting from commit e45f243409db ("firmware: meson_sm:
populate platform devices from sm device tree data") pwrc
is probed successfully and disables unused pwr domains.
By A1 SoC family design, any TEE requires DMA pwr domain
always enabled.

Fixes: b3dde5013e13 ("soc: amlogic: Add support for Secure power domains controller")
Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20230610090414.90529-1-avromanov@sberdevices.ru
[narmstrong: added fixes tag]
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/amlogic/meson-secure-pwrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
index fff92e2f39744..090a326664756 100644
--- a/drivers/soc/amlogic/meson-secure-pwrc.c
+++ b/drivers/soc/amlogic/meson-secure-pwrc.c
@@ -103,7 +103,7 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
 	SEC_PD(ACODEC,	0),
 	SEC_PD(AUDIO,	0),
 	SEC_PD(OTP,	0),
-	SEC_PD(DMA,	0),
+	SEC_PD(DMA,	GENPD_FLAG_ALWAYS_ON | GENPD_FLAG_IRQ_SAFE),
 	SEC_PD(SD_EMMC,	0),
 	SEC_PD(RAMA,	0),
 	/* SRAMB is used as ATF runtime memory, and should be always on */
-- 
2.39.2



