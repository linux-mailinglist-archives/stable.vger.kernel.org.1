Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F3172C128
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbjFLK4w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbjFLK4g (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:56:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B260AD5DD
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:44:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F7EE612E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64924C433EF;
        Mon, 12 Jun 2023 10:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566655;
        bh=p8/J1IWMB823FHy2ftLNQjQSDlMewV8lA0iChZXFhhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnlsnwWNVfd0LU2M5KQ9wd5zm7QKZWK9T5GkygLXM7wNFiua/uWq+KbmtPVRCoxZ3
         xdbjrpkHu5iQ5n+cR7ZDqRFzcxFD/WI0Nm0XSC/BOPEvDCP7v0a4NSA8yMX8l94O87
         FxvBlMvVopAu2SeFl9glSaDCOkDte5bHfe/iiVVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 107/132] arm64: dts: imx8qm-mek: correct GPIOs for USDHC2 CD and WP signals
Date:   Mon, 12 Jun 2023 12:27:21 +0200
Message-ID: <20230612101715.173824288@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Shenwei Wang <shenwei.wang@nxp.com>

[ Upstream commit 2b28fc688cdff225c41cdd22857500e187453ed7 ]

The USDHC2 CD and WP sginal should be on LSIO_GPIO5.

Fixes: 307fd14d4b14 ("arm64: dts: imx: add imx8qm mek support")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index ce9d3f0b98fc0..607cd6b4e9721 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -82,8 +82,8 @@ &usdhc2 {
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	bus-width = <4>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
-	cd-gpios = <&lsio_gpio4 22 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&lsio_gpio4 21 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&lsio_gpio5 22 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&lsio_gpio5 21 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
-- 
2.39.2



