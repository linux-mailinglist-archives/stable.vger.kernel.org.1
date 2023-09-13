Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04EE79F1AD
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 21:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjIMTEy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjIMTEy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 15:04:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAFD170F
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 12:04:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1F3C433C7;
        Wed, 13 Sep 2023 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694631889;
        bh=upKOHKZOCBtRlt7vbesXeUFxdtyWzXJWjiELDzyL9r0=;
        h=Subject:To:Cc:From:Date:From;
        b=FD49K58gAAImYZ1TAdn2fcpq60JF+SoFZ9k/D0l5GjB9EovQX54twPiwpL/gIkcyp
         s71O79huJ40xg9nru6Z8EFR/bZeZMXrvMvi1/Bi/4veTMmSB3SEjfNWFV75UXeqNa5
         QuSHo60MOtyzvUSEKDzmdd8V+eOzg2J91u4MjPiQ=
Subject: FAILED: patch "[PATCH] ARM: dts: qcom: msm8974pro-castor: correct touchscreen" failed to apply to 5.4-stable tree
To:     krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 13 Sep 2023 21:04:31 +0200
Message-ID: <2023091331-garnet-parabola-1d4a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7c74379afdfee7b13f1cd8ff1ad6e0f986aec96c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091331-garnet-parabola-1d4a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

7c74379afdfe ("ARM: dts: qcom: msm8974pro-castor: correct touchscreen syna,nosleep-mode")
724ba6751532 ("ARM: dts: Move .dts files to vendor sub-directories")
86684c2481b6 ("ARM: dts: Add .dts files missing from the build")
313c22bb3195 ("Merge tag 'arm-soc/for-6.5/devicetree' of https://github.com/Broadcom/stblinux into soc/dt")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7c74379afdfee7b13f1cd8ff1ad6e0f986aec96c Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 20 Jul 2023 13:53:35 +0200
Subject: [PATCH] ARM: dts: qcom: msm8974pro-castor: correct touchscreen
 syna,nosleep-mode

There is no syna,nosleep property in Synaptics RMI4 touchscreen:

  qcom-msm8974pro-sony-xperia-shinano-castor.dtb: synaptics@2c: rmi4-f01@1: 'syna,nosleep' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: ab80661883de ("ARM: dts: qcom: msm8974: Add Sony Xperia Z2 Tablet")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230720115335.137354-6-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 726ed67415e1..11468d1409f7 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -127,7 +127,7 @@ synaptics@2c {
 
 		rmi4-f01@1 {
 			reg = <0x1>;
-			syna,nosleep = <1>;
+			syna,nosleep-mode = <1>;
 		};
 
 		rmi4-f11@11 {

