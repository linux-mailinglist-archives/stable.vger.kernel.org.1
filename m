Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936227734E6
	for <lists+stable@lfdr.de>; Tue,  8 Aug 2023 01:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjHGXV5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjHGXV4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 19:21:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B6311A
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 16:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7936B622EA
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 23:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BA7C433C8;
        Mon,  7 Aug 2023 23:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691450514;
        bh=meud1PdM2MVio9PqugtQ2Ga0CHmwCwegchvSo8eHasI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swnyt1ysyt1x8XmFRXOil/nL7jd8RVDkFz28TIO6H+S5PfjiRwpN1igHCol8EPR0f
         IBRzWOnfDsnhTXQP14o3W+WalR4pMm/y3B51vwi/1IDfU2ZlPYCeoy6V8Qfmybhah/
         WjnzJMSOvtbqLVlWS4Xvv4kwsjw3ZROoLS2c3XZkirP8O6KOM+f8GsAEpvuY7i2nSR
         U+uqLUVL9Lrv0TJmBu7rgn80IfBpwR7CRGKJ1GRdV+il+kvBQ7rnLr5pDRaRrzjOIk
         mF3aEGxE+5WY/UrEwNL9eFIOLt0l9GtB4DqQhvqnYMKAh4BvpFsnDMlam3Q4Cu1U/4
         YKzN/dJs4dJkw==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     stable@vger.kernel.org
Cc:     Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.19.y] arm64: dts: stratix10: fix incorrect I2C property for SCL signal
Date:   Mon,  7 Aug 2023 18:21:50 -0500
Message-Id: <20230807232150.703902-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023080709-atrium-collage-9ccc@gregkh>
References: <2023080709-atrium-collage-9ccc@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The correct dts property for the SCL falling time is
"i2c-scl-falling-time-ns".

Fixes: c8da1d15b8a4 ("arm64: dts: stratix10: i2c clock running out of spec")
Cc: stable@vger.kernel.org
(cherry picked from commit db66795f61354c373ecdadbdae1ed253a96c47cb)
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 636bab51de38..40a54b55abab 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -125,7 +125,7 @@
 	status = "okay";
 	clock-frequency = <100000>;
 	i2c-sda-falling-time-ns = <890>;  /* hcnt */
-	i2c-sdl-falling-time-ns = <890>;  /* lcnt */
+	i2c-scl-falling-time-ns = <890>;  /* lcnt */
 
 	adc@14 {
 		compatible = "lltc,ltc2497";
-- 
2.25.1

