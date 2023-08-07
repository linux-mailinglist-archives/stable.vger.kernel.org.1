Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D123771AFE
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 09:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjHGHCg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 03:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjHGHCX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 03:02:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EB71721
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 00:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45C9F6112C
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F48BC433C8;
        Mon,  7 Aug 2023 07:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691391740;
        bh=wBponFLYpYmQOiP8sdqzkH3lEkPqrdtWm143xArn9RE=;
        h=Subject:To:Cc:From:Date:From;
        b=GMeipxHIz6OF8EpJ1/MIJRG9yG9hxNdrs+FIIakDmPe/7vyszzjnO2eWopWlhmeWR
         U8A8F69rkiR+sGDarZPiMJiobhMpgR7PmtWuwD7dD7Gp7oWOnPbtxMOjG/dV7HzLJd
         VbcgQ/C+R2Q6WsQwrT06Dnhk3TXKPHweKgijEvX0=
Subject: FAILED: patch "[PATCH] arm64: dts: stratix10: fix incorrect I2C property for SCL" failed to apply to 4.19-stable tree
To:     dinguyen@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 09:02:09 +0200
Message-ID: <2023080709-atrium-collage-9ccc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x db66795f61354c373ecdadbdae1ed253a96c47cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080709-atrium-collage-9ccc@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

db66795f6135 ("arm64: dts: stratix10: fix incorrect I2C property for SCL signal")
3c0f3b8545e7 ("arm64: dts: add NAND board files for Stratix10 and Agilex")
ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig")
9cc342f6c4a0 ("treewide: prefix header search paths with $(srctree)/")
dc413a90edbe ("Merge tag 'armsoc-drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db66795f61354c373ecdadbdae1ed253a96c47cb Mon Sep 17 00:00:00 2001
From: Dinh Nguyen <dinguyen@kernel.org>
Date: Tue, 11 Jul 2023 15:44:30 -0500
Subject: [PATCH] arm64: dts: stratix10: fix incorrect I2C property for SCL
 signal

The correct dts property for the SCL falling time is
"i2c-scl-falling-time-ns".

Fixes: c8da1d15b8a4 ("arm64: dts: stratix10: i2c clock running out of spec")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 38ae674f2f02..3037f58057c9 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -145,7 +145,7 @@ &i2c1 {
 	status = "okay";
 	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <890>;  /* hcnt */
-	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
+	i2c-scl-falling-time-ns = <890>;  /* lcnt */
 
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&i2c1_pmx_func>;
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index ede99dcc0558..f4cf30bac557 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -141,7 +141,7 @@ &i2c2 {
 	status = "okay";
 	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <890>;  /* hcnt */
-	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
+	i2c-scl-falling-time-ns = <890>;  /* lcnt */
 
 	adc@14 {
 		compatible = "lltc,ltc2497";

