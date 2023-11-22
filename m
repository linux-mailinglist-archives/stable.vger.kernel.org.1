Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97087F5216
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 22:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjKVVLr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 16:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVVLq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 16:11:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F49C101
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 13:11:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06FDC433C8;
        Wed, 22 Nov 2023 21:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700687503;
        bh=phSJxtNQawst6k6FGa3t2JqCUnxREdEKuIP0h4YDeP0=;
        h=Subject:To:Cc:From:Date:From;
        b=hwa2T7k2XOkpTiWIYHwBH49Uif5VVEBAuOZTWN9Di3YwjDm2Y4idgNtSooJLzJWoR
         rDPkvTa2rrSrDVvnoCeE+OO2cT6qiNiG/FZI8NQBdPZ1Lr+To6U+NvrpQK52hwqs5R
         EtMlaVemhjpgqupcdiQ+ocyfcb56jE14XmuQnlLw=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size" failed to apply to 5.10-stable tree
To:     quic_viswanat@quicinc.com, andersson@kernel.org,
        konrad.dybcio@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 21:11:32 +0000
Message-ID: <2023112232-tinker-opponent-62c7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
git cherry-pick -x 72fc3d58b87b0d622039c6299b89024fbb7b420f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112232-tinker-opponent-62c7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

72fc3d58b87b ("arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size")
f5e303aefc06 ("arm64: dts: qcom: ipq6018: switch TCSR mutex to MMIO")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72fc3d58b87b0d622039c6299b89024fbb7b420f Mon Sep 17 00:00:00 2001
From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
Date: Tue, 5 Sep 2023 15:25:34 +0530
Subject: [PATCH] arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size

IPQ6018's TCSR Mutex HW lock register has 32 locks of size 4KB each.
Total size of the TCSR Mutex registers is 128KB.

Fix size of the tcsr_mutex hwlock register to 0x20000.

Changes in v2:
 - Drop change to remove qcom,ipq6018-tcsr-mutex compatible string
 - Added Fixes and stable tags

Cc: stable@vger.kernel.org
Fixes: 5bf635621245 ("arm64: dts: ipq6018: Add a few device nodes")
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230905095535.1263113-2-quic_viswanat@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 72e6457ddf9f..e59b9df96c7e 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -385,7 +385,7 @@ gcc: gcc@1800000 {
 
 		tcsr_mutex: hwlock@1905000 {
 			compatible = "qcom,ipq6018-tcsr-mutex", "qcom,tcsr-mutex";
-			reg = <0x0 0x01905000 0x0 0x1000>;
+			reg = <0x0 0x01905000 0x0 0x20000>;
 			#hwlock-cells = <1>;
 		};
 

