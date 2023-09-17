Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A527A3901
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbjIQTna (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbjIQTnR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:43:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BCEE7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:43:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFD5C433C7;
        Sun, 17 Sep 2023 19:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979791;
        bh=6j97H9MsDa6BUbr39pYGsOLvczMcdqFrmlnEJkbMTuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avxmlMtow4Sd935BrDNqARJIJU8N8aMXRE5nuRD2XdD4CHJj0uJ4/uM/9BLoIJ2nQ
         p2HvF+kPCGyqaCNKw1dE4jxpoYLsyAFYNeYvFeSdZYfqPuBqR0rzzDhlTEyIM0Gmml
         Kg1Dmq0B0z8wJFPb3ansgDZYYac1b0nUwQ86d4/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 387/406] ARM: dts: samsung: exynos4210-i9100: Fix LCD screens physical size
Date:   Sun, 17 Sep 2023 21:14:01 +0200
Message-ID: <20230917191111.481096129@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit b3f3fc32e5ff1e848555af8616318cc667457f90 ]

The previous values were completely bogus, and resulted in the computed
DPI ratio being much lower than reality, causing applications and UIs to
misbehave.

The new values were measured by myself with a ruler.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Fixes: 8620cc2f99b7 ("ARM: dts: exynos: Add devicetree file for the Galaxy S2")
Cc: <stable@vger.kernel.org> # v5.8+
Link: https://lore.kernel.org/r/20230714153720.336990-1-paul@crapouillou.net
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index ecc9d4dc707e4..d186b93144e38 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -170,8 +170,8 @@
 			power-on-delay = <10>;
 			reset-delay = <10>;
 
-			panel-width-mm = <90>;
-			panel-height-mm = <154>;
+			panel-width-mm = <56>;
+			panel-height-mm = <93>;
 
 			display-timings {
 				timing {
-- 
2.40.1



