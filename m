Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420F573CAD4
	for <lists+stable@lfdr.de>; Sat, 24 Jun 2023 14:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjFXMWg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 24 Jun 2023 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjFXMWf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Jun 2023 08:22:35 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB52738
        for <stable@vger.kernel.org>; Sat, 24 Jun 2023 05:22:04 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b47742de92so25678921fa.0
        for <stable@vger.kernel.org>; Sat, 24 Jun 2023 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687609305; x=1690201305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VBAeuEKi4TumGQZarWYAofM/kt/WlzX0ayFAaSfgRg0=;
        b=isELkhleoirfZfTIzL1phvML2a4utiN1s+Zc5tXECihFYMuaobFx17Zh3KJZH+1tUT
         iF075/7CBZtw87MNe+CyogWJhShfq+7mq95W4BOMxqWsbxMWu5FwihAkFItzEbikpV6m
         Rl4TU1w3u1EQsWGjQbdYah3K0EGR1Avl6qY4gGvgV8q5HqxcsocO9R08fXcEuvE91Vfw
         Fm1eJwKoD2Vp3T0P7jffYkWOf0l6xIeseCKkXkggEjSFLmZYIlNqFrvY8UykzOt6S0B1
         SH0rHqp314/6f7N2ZStlSSd4pQctAUFAvI29HgL3B/cBMoKen4KMPeA25Q5gIlRGZgXq
         0aTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609305; x=1690201305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBAeuEKi4TumGQZarWYAofM/kt/WlzX0ayFAaSfgRg0=;
        b=kCo+J9EocHCqF1E/y0htZA0FxpjONOxECg82jQjF8tkLL2IU1K4bYbquDHcDJrdKI4
         XO9TYuRAx8PjTldsKtxifmykYFEjU0xX6O53T5EAo8acoM2emquV/QXODI/mLpgbRnkW
         /V8xdiPtdXaWW02P4zEXPagpwCFHw5URcIqdJwTY5cyzX5hZgQMXRw91TKB8moS+ztQF
         fq+WJ0ax3NiJBGz4yfV/+z1tqJC5wLUtfxohVwoTLY26Gd4SR16sU5moLcN4BdkaeiK6
         bZno09Tp4Rdt8Tqoobd86Ag66SGf/X/Ph7EUnx3WYuC6vGEOL09QRh3rr8Ed+0SRTZeE
         JFfg==
X-Gm-Message-State: AC+VfDz1OZkVvuILE7NUBWNshyFQJDWQHRhwwrN/SKlYG8onAwSbWqoj
        XiOeHmJ4kfYDpso7AKLo+ZZC/Y6hFK6pp9pLeuQ=
X-Google-Smtp-Source: ACHHUZ46nD0x2dHG5p6zlGBmn2pjrt4AVodkjdoyLQ+u979hnQlVdrR/RZGt7MpW7gDA9SaM2xnx0g==
X-Received: by 2002:a2e:7e11:0:b0:2b5:95a8:412b with SMTP id z17-20020a2e7e11000000b002b595a8412bmr3617667ljc.52.1687609304977;
        Sat, 24 Jun 2023 05:21:44 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e740f000000b002b4d766bda5sm256819ljc.124.2023.06.24.05.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 05:21:44 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Jonas Gorski <jonas.gorski@gmail.com>, stable@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] bus: ixp4xx: fix IXP4XX_EXP_T1_MASK
Date:   Sat, 24 Jun 2023 14:21:39 +0200
Message-Id: <20230624122139.3229642-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jonas Gorski <jonas.gorski@gmail.com>

The IXP4XX_EXP_T1_MASK was shifted one bit to the right, overlapping
IXP4XX_EXP_T2_MASK and leaving bit 29 unused. The offset being wrong is
also confirmed at least by the datasheet of IXP45X/46X [1].

Fix this by aligning it to IXP4XX_EXP_T1_SHIFT.

[1] https://www.intel.com/content/dam/www/public/us/en/documents/manuals/ixp45x-ixp46x-developers-manual.pdf

Cc: stable@vger.kernel.org
Fixes: 1c953bda90ca ("bus: ixp4xx: Add a driver for IXP4xx expansion bus")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Link: https://lore.kernel.org/r/20230624112958.27727-1-jonas.gorski@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
SoC maintainers: please apply this for fixes.
---
 drivers/bus/intel-ixp4xx-eb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/intel-ixp4xx-eb.c b/drivers/bus/intel-ixp4xx-eb.c
index f5ba6bee6fd8..320cf307db05 100644
--- a/drivers/bus/intel-ixp4xx-eb.c
+++ b/drivers/bus/intel-ixp4xx-eb.c
@@ -33,7 +33,7 @@
 #define IXP4XX_EXP_TIMING_STRIDE	0x04
 #define IXP4XX_EXP_CS_EN		BIT(31)
 #define IXP456_EXP_PAR_EN		BIT(30) /* Only on IXP45x and IXP46x */
-#define IXP4XX_EXP_T1_MASK		GENMASK(28, 27)
+#define IXP4XX_EXP_T1_MASK		GENMASK(29, 28)
 #define IXP4XX_EXP_T1_SHIFT		28
 #define IXP4XX_EXP_T2_MASK		GENMASK(27, 26)
 #define IXP4XX_EXP_T2_SHIFT		26
-- 
2.40.1

