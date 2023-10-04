Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EDB7B884A
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbjJDSOr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243754AbjJDSOp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:14:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D75A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:14:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA1FC433C9;
        Wed,  4 Oct 2023 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443281;
        bh=MiSeYcgXiAv0EVdWX0HvTi972lu1t1lnKWJS2kqPIH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vMCyBYIvAyUzOEnBp/wkcS5TKiOx3eZRA4SpnhilNOxCLiIQBRUyTsZDam4TVWnkp
         ow53ME04qVePQvzgZl6Wxal5UhxZVOBJPncX9eCZi0iiOV4gYubEF/LUHVhwNCNa0+
         0KZqNqPk0m+2/b3mq321w8Mv6WC+un43fEixVmL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 093/259] ARM: dts: samsung: exynos4210-i9100: Fix LCD screens physical size
Date:   Wed,  4 Oct 2023 19:54:26 +0200
Message-ID: <20231004175221.621417693@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index bba85011ecc93..53e023fc1cacf 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -201,8 +201,8 @@
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



