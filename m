Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3794279F197
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjIMTC6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjIMTC5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:02:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EE1170F
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:02:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F647C433C7;
        Wed, 13 Sep 2023 19:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694631772;
        bh=s92MG/8syYClJ4E1nPhXwpUHFMB8lqYPYgPihO/6W0M=;
        h=Subject:To:Cc:From:Date:From;
        b=yzt0Wh1+JMrCE1bjFx1j4LsXEE1lZsYxeuURExyERZCXFe+2RTG00k25qeYKCWOdI
         H2ZXHwkuuy7UzfmBUXJliWEtVFAbVXdxAoc6DRYlO8Lv5VYyJuQ8kHdu8lGpaeNHDF
         c8AdulxR/aIyVww9rZhiSh5xEH/mLAlu8z9iHyFQ=
Subject: FAILED: patch "[PATCH] ARM: dts: samsung: exynos4210-i9100: Fix LCD screen's" failed to apply to 6.1-stable tree
To:     paul@crapouillou.net, krzysztof.kozlowski@linaro.org,
        sam@ravnborg.org, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:02:49 +0200
Message-ID: <2023091348-luxury-uninsured-9ed9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b3f3fc32e5ff1e848555af8616318cc667457f90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091348-luxury-uninsured-9ed9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

b3f3fc32e5ff ("ARM: dts: samsung: exynos4210-i9100: Fix LCD screen's physical size")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b3f3fc32e5ff1e848555af8616318cc667457f90 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 14 Jul 2023 17:37:20 +0200
Subject: [PATCH] ARM: dts: samsung: exynos4210-i9100: Fix LCD screen's
 physical size

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

diff --git a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
index 37cd4dde53e4..a9ec1f6c1dea 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
@@ -207,8 +207,8 @@ lcd@0 {
 			power-on-delay = <10>;
 			reset-delay = <10>;
 
-			panel-width-mm = <90>;
-			panel-height-mm = <154>;
+			panel-width-mm = <56>;
+			panel-height-mm = <93>;
 
 			display-timings {
 				timing {

