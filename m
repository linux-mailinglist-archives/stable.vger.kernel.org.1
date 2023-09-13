Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EF479F1A5
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjIMTEW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjIMTEW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:04:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E499170F
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:04:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D732C433C8;
        Wed, 13 Sep 2023 19:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694631857;
        bh=TuTGNS1rfKa2vLgSeIam48vRwaqD9HGFRGrnsgM36JU=;
        h=Subject:To:Cc:From:Date:From;
        b=Mz9Jkc9v3LbN/NGNVkdsjhXPi5EYxxk3C7F3kGYr2UOOB5Ca2Zfxz4JHUI8R+tCqH
         KYswQTM8KGiKKDkE1HaGkUebr877/jyuCUYCYwOigbx3y3UC0Q2Hy40eQSvACbr3Ti
         ucMlcI7XtF2AYu4o/ADmdrkLKzIBBeJgmOQaDYuk=
Subject: FAILED: patch "[PATCH] ARM: dts: qcom: msm8974pro-castor: correct touchscreen" failed to apply to 6.1-stable tree
To:     krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:04:14 +0200
Message-ID: <2023091313-delusion-urologist-35ec@gregkh>
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
git cherry-pick -x 31fba16c19c45b2b3a7c23b0bfef80aed1b29050
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091313-delusion-urologist-35ec@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

31fba16c19c4 ("ARM: dts: qcom: msm8974pro-castor: correct touchscreen function names")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 31fba16c19c45b2b3a7c23b0bfef80aed1b29050 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 20 Jul 2023 13:53:34 +0200
Subject: [PATCH] ARM: dts: qcom: msm8974pro-castor: correct touchscreen
 function names

The node names for functions of Synaptics RMI4 touchscreen must be as
"rmi4-fXX", as required by bindings and Linux driver.

  qcom-msm8974pro-sony-xperia-shinano-castor.dtb: synaptics@2c: Unevaluated properties are not allowed ('rmi-f01@1', 'rmi-f11@11' were unexpected)

Fixes: ab80661883de ("ARM: dts: qcom: msm8974: Add Sony Xperia Z2 Tablet")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230720115335.137354-5-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index c41e25367bc9..726ed67415e1 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -125,12 +125,12 @@ synaptics@2c {
 
 		syna,startup-delay-ms = <100>;
 
-		rmi-f01@1 {
+		rmi4-f01@1 {
 			reg = <0x1>;
 			syna,nosleep = <1>;
 		};
 
-		rmi-f11@11 {
+		rmi4-f11@11 {
 			reg = <0x11>;
 			syna,sensor-type = <1>;
 			touchscreen-inverted-x;

