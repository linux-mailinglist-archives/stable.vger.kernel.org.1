Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D467A7D7B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbjITMJd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjITMJ3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:09:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA42DC
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:09:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEF5C433C8;
        Wed, 20 Sep 2023 12:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211761;
        bh=65WiDRCUCEhxZxjCtaVM+MXykYCf9YFZm0c3tNVi7Qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCOJ18/H7oZl8sNuq11wRYuF7dfMyp4WrVEZDe5Od2AdL1UAuLpl8FxNPKTkIydfd
         ickYtGHVFB1oVcEk64/Xpns2PynsZYoJ2SWfgJKgASC9VV1hvO5Z6xy5HIhvmvfyEx
         jn7IRht0GQkEGaAc14kf6llQrsIRyMA92gxLFTU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guiting Shen <aarongt.shen@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/273] ASoC: atmel: Fix the 8K sample parameter in I2SC master
Date:   Wed, 20 Sep 2023 13:27:45 +0200
Message-ID: <20230920112847.205823373@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guiting Shen <aarongt.shen@gmail.com>

[ Upstream commit f85739c0b2b0d98a32f5ca4fcc5501d2b76df4f6 ]

The 8K sample parameter of 12.288Mhz main system bus clock doesn't work
because the I2SC_MR.IMCKDIV must not be 0 according to the sama5d2
series datasheet(I2SC Mode Register of Register Summary).

So use the 6.144Mhz instead of 12.288Mhz to support 8K sample.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
Link: https://lore.kernel.org/r/20230715030620.62328-1-aarongt.shen@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/atmel/atmel-i2s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index 99cc731505769..ab7f761174742 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -174,11 +174,14 @@ struct atmel_i2s_gck_param {
 
 #define I2S_MCK_12M288		12288000UL
 #define I2S_MCK_11M2896		11289600UL
+#define I2S_MCK_6M144		6144000UL
 
 /* mck = (32 * (imckfs+1) / (imckdiv+1)) * fs */
 static const struct atmel_i2s_gck_param gck_params[] = {
+	/* mck = 6.144Mhz */
+	{  8000, I2S_MCK_6M144,  1, 47},	/* mck =  768 fs */
+
 	/* mck = 12.288MHz */
-	{  8000, I2S_MCK_12M288, 0, 47},	/* mck = 1536 fs */
 	{ 16000, I2S_MCK_12M288, 1, 47},	/* mck =  768 fs */
 	{ 24000, I2S_MCK_12M288, 3, 63},	/* mck =  512 fs */
 	{ 32000, I2S_MCK_12M288, 3, 47},	/* mck =  384 fs */
-- 
2.40.1



