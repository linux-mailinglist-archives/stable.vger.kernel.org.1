Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D6713853
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjE1H2O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjE1H2N (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31404E3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 00:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C171560F63
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9406C433D2;
        Sun, 28 May 2023 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685258889;
        bh=s0NAa3UxssZB7yaiEzzCiFQIy1RpGzzoearWiwCXeFs=;
        h=Subject:To:Cc:From:Date:From;
        b=zQu5IIhVujj7el41P2O+ix/aOcC3Zg7tm0NdzEafUYtiiabRAsMQeEAjFcOO3Lyyn
         6iNUQNj24kxvyDltxhTd9tyyZiG2HWEnxX4sFOeibaTPxfZvbRcC+IU87mcA6sRpC8
         TTeWJ/HJMC/T0EDMESsP/el4od7wCJUuhyYRMkPE=
Subject: FAILED: patch "[PATCH] arm64: dts: imx8: fix USB 3.0 Gadget Failure in QM & QXPB0 at" failed to apply to 6.3-stable tree
To:     Frank.Li@nxp.com, shawnguo@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 08:28:06 +0100
Message-ID: <2023052806-unlawful-nearest-9622@gregkh>
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


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 0f554e37dad416f445cd3ec5935f5aec1b0e7ba5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052806-unlawful-nearest-9622@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

0f554e37dad4 ("arm64: dts: imx8: fix USB 3.0 Gadget Failure in QM & QXPB0 at super speed")
a8bd7f155126 ("arm64: dts: imx8qxp: add cadence usb3 support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f554e37dad416f445cd3ec5935f5aec1b0e7ba5 Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 May 2023 12:20:53 -0400
Subject: [PATCH] arm64: dts: imx8: fix USB 3.0 Gadget Failure in QM & QXPB0 at
 super speed

Resolve USB 3.0 gadget failure for QM and QXPB0 in super speed mode with
single IN and OUT endpoints, like mass storage devices, due to incorrect
ACTUAL_MEM_SIZE in ep_cap2 (32k instead of actual 18k). Implement dt
property cdns,on-chip-buff-size to override ep_cap2 and set it to 18k for
imx8QM and imx8QXP chips. No adverse effects for 8QXP C0.

Cc: stable@vger.kernel.org
Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 2209c1ac6e9b..e62a43591361 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -171,6 +171,7 @@ usbotg3_cdns3: usb@5b120000 {
 			interrupt-names = "host", "peripheral", "otg", "wakeup";
 			phys = <&usb3_phy>;
 			phy-names = "cdns3,usb3-phy";
+			cdns,on-chip-buff-size = /bits/ 16 <18>;
 			status = "disabled";
 		};
 	};

