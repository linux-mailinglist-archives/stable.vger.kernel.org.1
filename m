Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C367079F1A2
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjIMTEJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjIMTEJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:04:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80672170F
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:04:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6695DC433C7;
        Wed, 13 Sep 2023 19:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694631845;
        bh=GUP5XUeeBvx3/amjtixMByAc/klsOMAvJoGshY7LeSU=;
        h=Subject:To:Cc:From:Date:From;
        b=rSebhx27yBCiX49jVKKVslEQDk8HjNZdBe8vl4z1DhjQL6KIci9QVrYl1+ReLo2cC
         bZfFmuo2ILxaYBSN7wbamDbTTtdfM5HQkCW4eKzYgfEYcYqk+QeChGmJ720ciSVapd
         o/2/cZwfzkZF0kK68+ld9XgyTjX+6MAet4YTL1hI=
Subject: FAILED: patch "[PATCH] ARM: dts: qcom: msm8974pro-castor: correct inverted X of" failed to apply to 5.10-stable tree
To:     krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:03:54 +0200
Message-ID: <2023091354-those-sanctuary-1380@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 43db69268149049540b1d2bbe8a69e59d5cb43b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091354-those-sanctuary-1380@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

43db69268149 ("ARM: dts: qcom: msm8974pro-castor: correct inverted X of touchscreen")
724ba6751532 ("ARM: dts: Move .dts files to vendor sub-directories")
86684c2481b6 ("ARM: dts: Add .dts files missing from the build")
313c22bb3195 ("Merge tag 'arm-soc/for-6.5/devicetree' of https://github.com/Broadcom/stblinux into soc/dt")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 43db69268149049540b1d2bbe8a69e59d5cb43b6 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 20 Jul 2023 13:53:33 +0200
Subject: [PATCH] ARM: dts: qcom: msm8974pro-castor: correct inverted X of
 touchscreen

There is no syna,f11-flip-x property, so assume intention was to use
touchscreen-inverted-x.

Fixes: ab80661883de ("ARM: dts: qcom: msm8974: Add Sony Xperia Z2 Tablet")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230720115335.137354-4-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 154639d56f35..c41e25367bc9 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -132,8 +132,8 @@ rmi-f01@1 {
 
 		rmi-f11@11 {
 			reg = <0x11>;
-			syna,f11-flip-x = <1>;
 			syna,sensor-type = <1>;
+			touchscreen-inverted-x;
 		};
 	};
 };

