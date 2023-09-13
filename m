Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FAD79F1A7
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjIMTEb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjIMTEa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:04:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06071986
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:04:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B211CC433C7;
        Wed, 13 Sep 2023 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694631866;
        bh=dB19Q0LfSlfYCIi+QFgCtzsKBWycd7VQqznxvnI+vDM=;
        h=Subject:To:Cc:From:Date:From;
        b=2aIBM21yA7MHqjir5a1CqMO4+XojgNzU8dmfcui7gJY6XqwM7EtDarJW8B7WZmlHE
         XKEaPx9oGRssJ2YQtRZhR2nfOoRC3Rps9BDmDbNpaqOW0EILUeYB32LER00SWpr9C/
         eaFOxhc9CO7T9dSsDsCK/dHhD/Awjlt5p90v7v1Y=
Subject: FAILED: patch "[PATCH] ARM: dts: qcom: msm8974pro-castor: correct touchscreen" failed to apply to 5.10-stable tree
To:     krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:04:16 +0200
Message-ID: <2023091316-croak-supermom-888e@gregkh>
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
git cherry-pick -x 31fba16c19c45b2b3a7c23b0bfef80aed1b29050
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091316-croak-supermom-888e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

31fba16c19c4 ("ARM: dts: qcom: msm8974pro-castor: correct touchscreen function names")
724ba6751532 ("ARM: dts: Move .dts files to vendor sub-directories")
86684c2481b6 ("ARM: dts: Add .dts files missing from the build")
313c22bb3195 ("Merge tag 'arm-soc/for-6.5/devicetree' of https://github.com/Broadcom/stblinux into soc/dt")

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

