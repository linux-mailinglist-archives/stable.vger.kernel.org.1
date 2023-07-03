Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F59746501
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 23:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjGCVnc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 17:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGCVnb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 17:43:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F446E47
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 14:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B481261063
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 21:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7351EC433C7;
        Mon,  3 Jul 2023 21:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688420607;
        bh=8y+SNWLYMoVyVwgZLAuF57aq+7opUlqb5b7Z/N4orm4=;
        h=From:Date:Subject:To:Cc:From;
        b=mv4YJlvgm1SlSpznYjAjbgujdIS68To7CwD54A+VEkghowgSxY5pIfHtnnb+/v+Qr
         k0wSiXwS14wHksnqd4+QeesoNWWrPg26NasnP2ue8J3dZpMbVlDLn7Fjzd3PCaXOGn
         dRNZ+p01IFUD6ObE38eaPcPaUj3Mo321P2bJPffqsjdxkEfMSxn1iRtF6DN3AvnA1n
         xaAvRiRn7I34dPlO6uIXf2VZQLtgjq8LK+lL9ygURwe2+ctYYPn1AZfG22B2216+As
         YiNQbUhax30rKh6Hnc41R5H0bA0aqu+GY/xOuiXnie7RjrCNVMwhkjib6Vq23EEUf0
         wnE06F84lQblA==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Mon, 03 Jul 2023 14:43:15 -0700
Subject: [PATCH] ASoC: cs35l45: Select REGMAP_IRQ
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230703-cs35l45-select-regmap_irq-v1-1-37d7e838b614@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPJAo2QC/x3MTQqDQAxA4atI1g2MxlH0KqUUmYk2YP1JShFk7
 u7g8lu8d4KxChv0xQnKfzFZl4zyUUD4DMvEKDEbKleRax1hMPJz7dF45vBD5ek7bG/RHd0Yu9h
 Q2TYUIPeb8ijH/X6+UroAUgS0gGsAAAA=
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, vkarpovi@opensource.cirrus.com,
        rf@opensource.cirrus.com, ckeepax@opensource.cirrus.com,
        alsa-devel@alsa-project.org, patches@lists.linux.dev,
        stable@vger.kernel.org, Marcus Seyfarth <m.seyfarth@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=nathan@kernel.org;
 h=from:subject:message-id; bh=8y+SNWLYMoVyVwgZLAuF57aq+7opUlqb5b7Z/N4orm4=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDCmLHf7xP/pwQPDv7kvHVpdEXpn22+3jXY95geWR1mmmK
 mK7rt9f2lHKwiDGwSArpshS/Vj1uKHhnLOMN05NgpnDygQyhIGLUwAmEq/B8FeKt3XClNzZi6dk
 tF/+zbnK5ruU+Tctk8tHToizTUz1mWXKyPCD9/ubhO18J1r6RC/cUTr1zfdo0vnZzstda74s15F
 bHcwEAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

After commit 6085f9e6dc19 ("ASoC: cs35l45: IRQ support"), without any
other configuration that selects CONFIG_REGMAP_IRQ, modpost errors out
with:

  ERROR: modpost: "regmap_irq_get_virq" [sound/soc/codecs/snd-soc-cs35l45.ko] undefined!
  ERROR: modpost: "devm_regmap_add_irq_chip" [sound/soc/codecs/snd-soc-cs35l45.ko] undefined!

Add the Kconfig selection to ensure these functions get built and
included, which resolves the build failure.

Cc: stable@vger.kernel.org
Fixes: 6085f9e6dc19 ("ASoC: cs35l45: IRQ support")
Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Closes: https://github.com/ClangBuiltLinux/linux/issues/1882
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0cd107fa112f..76ddd3ffc496 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -715,6 +715,7 @@ config SND_SOC_CS35L41_I2C
 
 config SND_SOC_CS35L45
 	tristate
+	select REGMAP_IRQ
 
 config SND_SOC_CS35L45_SPI
 	tristate "Cirrus Logic CS35L45 CODEC (SPI)"

---
base-commit: 6f49256897083848ce9a59651f6b53fc80462397
change-id: 20230703-cs35l45-select-regmap_irq-0fd9d631763c

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

