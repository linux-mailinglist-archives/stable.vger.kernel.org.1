Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7E6713FBA
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjE1Ts1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjE1Ts1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFA1F5
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B426061FFF
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51FAC433D2;
        Sun, 28 May 2023 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303302;
        bh=onVee4eMTMpknMLasanBWH/l4id018oP2tS9f3G4SyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p66YFLceG64/3681Na4lCFStxFpng6i4boBsSAFXrFd4wv/nASDU6uz3vIufVLZYu
         XiCpfW75lqVberjleSN55d7ZRVJt5nbk4VJIjojtqdyE1ExoVjjmd/e8eRAMSEY/sg
         cMCkfni0uA3mJjbvWVtdsNWOGEmaTCG6fGxWclgE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH 5.15 06/69] ARM: dts: stm32: fix AV96 board SAI2 pin muxing on stm32mp15
Date:   Sun, 28 May 2023 20:11:26 +0100
Message-Id: <20230528190828.573175980@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Olivier Moysan <olivier.moysan@foss.st.com>

commit ee2aacb6f3a901a95b1dd68964b69c92cdbbf213 upstream.

Replace sai2a-2 node name by sai2a-sleep-2, to avoid name
duplication.

Fixes: 1a9a9d226f0f ("ARM: dts: stm32: fix AV96 board SAI2 pin muxing on stm32mp15")

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1190,7 +1190,7 @@
 		};
 	};
 
-	sai2a_sleep_pins_c: sai2a-2 {
+	sai2a_sleep_pins_c: sai2a-sleep-2 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 13, ANALOG)>, /* SAI2_SCK_A */
 				 <STM32_PINMUX('D', 11, ANALOG)>, /* SAI2_SD_A */


