Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBB57A3AB9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbjIQUIC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbjIQUHi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:07:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B497
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:07:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB78FC433C7;
        Sun, 17 Sep 2023 20:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981253;
        bh=dBmAr/oe1ma695bYv/g0wHo75GQNxjBwUskKHgUMtxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ji+mYE/+LznkSoodYPECx0oXBBFmlpn6y0FaTFAKLNRzwPhrfOQ3AP8dtXBZuHWRU
         pI5w97ku7WW2P4vAMhgSks9VADyc32A8baBCS7ctoIuhH7Zbc2ypZ8o7mRPUG9CYM/
         LpVUIJkPJ2BGrePZloirP3qx23vtiF8j5z9xs+Ms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Edgar <ljijcj@163.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 020/511] ASoc: codecs: ES8316: Fix DMIC config
Date:   Sun, 17 Sep 2023 21:07:27 +0200
Message-ID: <20230917191114.318182138@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edgar <ljijcj@163.com>

[ Upstream commit d20d35d1ad62c6cca36368c1e8f29335a068659e ]

According to the datasheet, the DMIC config should
be changed to { 0, 2 ,3 }

Signed-off-by: Edgar <ljijcj@163.com>
Link: https://lore.kernel.org/r/20230719054722.401954-1-ljijcj@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index b36ccfc54cd69..93549f8ee130c 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -153,7 +153,7 @@ static const char * const es8316_dmic_txt[] = {
 		"dmic data at high level",
 		"dmic data at low level",
 };
-static const unsigned int es8316_dmic_values[] = { 0, 1, 2 };
+static const unsigned int es8316_dmic_values[] = { 0, 2, 3 };
 static const struct soc_enum es8316_dmic_src_enum =
 	SOC_VALUE_ENUM_SINGLE(ES8316_ADC_DMIC, 0, 3,
 			      ARRAY_SIZE(es8316_dmic_txt),
-- 
2.40.1



