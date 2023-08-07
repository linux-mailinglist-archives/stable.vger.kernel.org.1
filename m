Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2DC771B27
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 09:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjHGHIK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 03:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjHGHIH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 03:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26501703
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 00:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3126F6151E
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2FEC433C8;
        Mon,  7 Aug 2023 07:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691392085;
        bh=V1bcB3TGoK6pd3EJTnszQneAkqcY8Yu2PNTJvVA66yc=;
        h=Subject:To:Cc:From:Date:From;
        b=m7GwnUSUvpFqn2iq4hHMtMap7qar8WX6PI/eZQnX08WjeWvr8hsabp+rub0Gjlu76
         58mbOm055OveSWTNqUupMUCYXflHSvtXlZ+LJolaQyzdAJa8yPOYcEiVluZxe8qUlo
         K5zMN3xAATjmYQW4bZX4HQxs437T/Nc+QaYN35hw=
Subject: FAILED: patch "[PATCH] ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node" failed to apply to 5.4-stable tree
To:     xu.yang_2@nxp.com, shawnguo@kernel.org, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 09:07:54 +0200
Message-ID: <2023080754-earmuff-revivable-f950@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
git cherry-pick -x ee70b908f77a9d8f689dea986f09e6d7dc481934
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080754-earmuff-revivable-f950@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

ee70b908f77a ("ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee70b908f77a9d8f689dea986f09e6d7dc481934 Mon Sep 17 00:00:00 2001
From: Xu Yang <xu.yang_2@nxp.com>
Date: Mon, 17 Jul 2023 10:28:33 +0800
Subject: [PATCH] ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node

Property name "phy-3p0-supply" is used instead of "phy-reg_3p0-supply".

Fixes: 9f30b6b1a957 ("ARM: dts: imx: Add basic dtsi file for imx6sll")
cc: <stable@vger.kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi
index 2873369a57c0..3659fd5ecfa6 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi
@@ -552,7 +552,7 @@
 				reg = <0x020ca000 0x1000>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SLL_CLK_USBPHY2>;
-				phy-reg_3p0-supply = <&reg_3p0>;
+				phy-3p0-supply = <&reg_3p0>;
 				fsl,anatop = <&anatop>;
 			};
 

