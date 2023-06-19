Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58B673526E
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjFSKfK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjFSKel (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:34:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C80E70
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40AB360B82
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A772C433C8;
        Mon, 19 Jun 2023 10:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170868;
        bh=3oHX6kZ+MMX2KYiMsfklMP9Awa185FLNHSRbAuPbN4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0hO2pSiUZGM/Ctymqn/KT54GBqXNI26ZKYf+5QKsuvZTjr8Z9q7QJab/Nd+13gQV
         SogtY4IZsZA9h83QYcuo5xgpDQqUpy4DjSs/71mRRq+IqbAT6frQjkh85nXjvMu8Vr
         9jI4jITFkdgSCKrcd6ml7ui9dkn9uuqFDRXMuGSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 038/187] ASoC: cs35l41: Fix default regmap values for some registers
Date:   Mon, 19 Jun 2023 12:27:36 +0200
Message-ID: <20230619102159.467661593@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit e2d035f5a7d597bbabc268e236ec6c0408c4af0e ]

Several values do not match the defaults of CS35L41, fix them.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20230414152552.574502-4-sbinding@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l41-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 04be71435491e..c2c56e5608094 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -46,7 +46,7 @@ static const struct reg_default cs35l41_reg[] = {
 	{ CS35L41_DSP1_RX5_SRC,			0x00000020 },
 	{ CS35L41_DSP1_RX6_SRC,			0x00000021 },
 	{ CS35L41_DSP1_RX7_SRC,			0x0000003A },
-	{ CS35L41_DSP1_RX8_SRC,			0x00000001 },
+	{ CS35L41_DSP1_RX8_SRC,			0x0000003B },
 	{ CS35L41_NGATE1_SRC,			0x00000008 },
 	{ CS35L41_NGATE2_SRC,			0x00000009 },
 	{ CS35L41_AMP_DIG_VOL_CTRL,		0x00008000 },
@@ -58,8 +58,8 @@ static const struct reg_default cs35l41_reg[] = {
 	{ CS35L41_IRQ1_MASK2,			0xFFFFFFFF },
 	{ CS35L41_IRQ1_MASK3,			0xFFFF87FF },
 	{ CS35L41_IRQ1_MASK4,			0xFEFFFFFF },
-	{ CS35L41_GPIO1_CTRL1,			0xE1000001 },
-	{ CS35L41_GPIO2_CTRL1,			0xE1000001 },
+	{ CS35L41_GPIO1_CTRL1,			0x81000001 },
+	{ CS35L41_GPIO2_CTRL1,			0x81000001 },
 	{ CS35L41_MIXER_NGATE_CFG,		0x00000000 },
 	{ CS35L41_MIXER_NGATE_CH1_CFG,		0x00000303 },
 	{ CS35L41_MIXER_NGATE_CH2_CFG,		0x00000303 },
-- 
2.39.2



