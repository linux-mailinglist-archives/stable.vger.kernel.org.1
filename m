Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDD4734BC6
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 08:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjFSGe0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 02:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSGeZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 02:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E720123
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 23:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2240E614C3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 06:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD616C433C0;
        Mon, 19 Jun 2023 06:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687156463;
        bh=1BMukmmxsvnCjI+O92dU7fimzR2UgTpYcJ3whYoclG0=;
        h=Subject:To:Cc:From:Date:From;
        b=kw052En+ROR1h60nhbs/2g8mFrXumDUtRNRcNaEpvuFVeVuesQySYLShP75XgHfKy
         MgD3hCMQrTddfS1iuFGXFNGrPlOvwbu59bUa8zJY1Vwc+V4cKBY8r2X73LWFqktMbL
         Kv4araxuUJQ6I052NN/KGKqzOio2j+iwuI7KAFqU=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sm8550: Use the correct LLCC register" failed to apply to 6.1-stable tree
To:     konrad.dybcio@linaro.org, andersson@kernel.org, mani@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 19 Jun 2023 08:34:19 +0200
Message-ID: <2023061918-disabled-spoiler-d23d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
git cherry-pick -x 661a4f089317c877aecd598fb70cd46510cc8d29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061918-disabled-spoiler-d23d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 661a4f089317c877aecd598fb70cd46510cc8d29 Mon Sep 17 00:00:00 2001
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 17 May 2023 04:18:50 +0200
Subject: [PATCH] arm64: dts: qcom: sm8550: Use the correct LLCC register
 scheme

During the ABI-breaking (for good reasons) conversion of the LLCC
register description, SM8550 was not taken into account, resulting
in LLCC being broken on any kernel containing the patch referenced
in the fixes tag.

Fix it by describing the regions properly.

Fixes: ee13b5008707 ("qcom: llcc/edac: Fix the base address used for accessing LLCC banks")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230517-topic-kailua-llcc-v1-2-d57bd860c43e@linaro.org

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 4c6b2c582b27..558cbc430708 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3771,9 +3771,16 @@ gem_noc: interconnect@24100000 {
 
 		system-cache-controller@25000000 {
 			compatible = "qcom,sm8550-llcc";
-			reg = <0 0x25000000 0 0x800000>,
+			reg = <0 0x25000000 0 0x200000>,
+			      <0 0x25200000 0 0x200000>,
+			      <0 0x25400000 0 0x200000>,
+			      <0 0x25600000 0 0x200000>,
 			      <0 0x25800000 0 0x200000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg-names = "llcc0_base",
+				    "llcc1_base",
+				    "llcc2_base",
+				    "llcc3_base",
+				    "llcc_broadcast_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 

