Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68B379BC23
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379520AbjIKWoj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbjIKOCb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:02:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59BACD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:02:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082EAC433C7;
        Mon, 11 Sep 2023 14:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440947;
        bh=i5Piw8eGOouA2dydSQ9Oj1HiBwOGeYB4UsKn9LXLIGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHvw6v0hKjE2urS867Yg/s3yYhqhVJ1MS2Y48GmF7LSHUQTP2dxDW/PW5J/hIE0oJ
         FwmOGyXiff+K1PfRjWcp0FIWIcmhCKpJmqXboqQByGtwU1bPmXrCbMdlXFIwq/rJQs
         tA0zpAnVsayn4Aycv5BHGaz+vkdVXyiJSuKUX9k0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 242/739] ARM: dts: stm32: Add missing detach mailbox for DHCOM SoM
Date:   Mon, 11 Sep 2023 15:40:41 +0200
Message-ID: <20230911134657.923186400@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit deb7edbc27a6ec4d8f5edfd8519b7ed13cbd2a52 ]

Add missing "detach" mailbox to this board to permit the CPU to inform
the remote processor on a detach. This signal allows the remote processor
firmware to stop IPC communication and to reinitialize the resources for
a re-attach.

Without this mailbox, detach is not possible and kernel log contains the
following warning to, so make sure all the STM32MP15xx platform DTs are
in sync regarding the mailboxes to fix the detach issue and the warning:
"
stm32-rproc 10000000.m4: mbox_request_channel_byname() could not locate channel named "detach"
"

Fixes: 6257dfc1c412 ("ARM: dts: stm32: Add coprocessor detach mbox on stm32mp15x-dkx boards")
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
index e61df23d361a7..74a11ccc5333f 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi
@@ -416,8 +416,8 @@ &iwdg2 {
 &m4_rproc {
 	memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
 			<&vdev0vring1>, <&vdev0buffer>;
-	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
-	mbox-names = "vq0", "vq1", "shutdown";
+	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>, <&ipcc 3>;
+	mbox-names = "vq0", "vq1", "shutdown", "detach";
 	interrupt-parent = <&exti>;
 	interrupts = <68 1>;
 	status = "okay";
-- 
2.40.1



