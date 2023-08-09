Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BF9775C0C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjHILXZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjHILXZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742EDED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ABD763228
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADC1C433C7;
        Wed,  9 Aug 2023 11:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580203;
        bh=cZxK5e943p6fBdYK/TgG5EldoVeRR0x66YyqhtYeyNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PuYAN9sJZE4pMkDStd2Xg6JiAelp/VNkqUqNU27Fs6p6pbUOxbBqswIAYcLarKzjF
         JDO4jaTEcEZSS7AXcJjTCs1oTTuS3QIKUrwR7cbhiT8UFP8nE3uQ0Sl1h/Dtc0nY97
         YyIOvyqatXMIsItpKW4zbgTDLQC5oXZ2jZnDbpZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jakub Vanek <linuxtardis@gmail.com>
Subject: [PATCH 4.19 263/323] Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"
Date:   Wed,  9 Aug 2023 12:41:41 +0200
Message-ID: <20230809103710.100974422@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Vanek <linuxtardis@gmail.com>

commit 734ae15ab95a18d3d425fc9cb38b7a627d786f08 upstream.

This reverts commit b138e23d3dff90c0494925b4c1874227b81bddf7.

AutoRetry has been found to sometimes cause controller freezes when
communicating with buggy USB devices.

This controller feature allows the controller in host mode to send
non-terminating/burst retry ACKs instead of terminating retry ACKs
to devices when a transaction error (CRC error or overflow) occurs.

Unfortunately, if the USB device continues to respond with a CRC error,
the controller will not complete endpoint-related commands while it
keeps trying to auto-retry. [3] The xHCI driver will notice this once
it tries to abort the transfer using a Stop Endpoint command and
does not receive a completion in time. [1]
This situation is reported to dmesg:

[sda] tag#29 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN
[sda] tag#29 CDB: opcode=0x28 28 00 00 69 42 80 00 00 48 00
xhci-hcd: xHCI host not responding to stop endpoint command
xhci-hcd: xHCI host controller not responding, assume dead
xhci-hcd: HC died; cleaning up

Some users observed this problem on an Odroid HC2 with the JMS578
USB3-to-SATA bridge. The issue can be triggered by starting
a read-heavy workload on an attached SSD. After a while, the host
controller would die and the SSD would disappear from the system. [1]

Further analysis by Synopsys determined that controller revisions
other than the one in Odroid HC2 are also affected by this.
The recommended solution was to disable AutoRetry altogether.
This change does not have a noticeable performance impact. [2]

Revert the enablement commit. This will keep the AutoRetry bit in
the default state configured during SoC design [2].

Fixes: b138e23d3dff ("usb: dwc3: core: Enable AutoRetry feature in the controller")
Link: https://lore.kernel.org/r/a21f34c04632d250cd0a78c7c6f4a1c9c7a43142.camel@gmail.com/ [1]
Link: https://lore.kernel.org/r/20230711214834.kyr6ulync32d4ktk@synopsys.com/ [2]
Link: https://lore.kernel.org/r/20230712225518.2smu7wse6djc7l5o@synopsys.com/ [3]
Cc: stable@vger.kernel.org
Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Jakub Vanek <linuxtardis@gmail.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20230714122419.27741-1-linuxtardis@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |   16 ----------------
 drivers/usb/dwc3/core.h |    3 ---
 2 files changed, 19 deletions(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -993,22 +993,6 @@ static int dwc3_core_init(struct dwc3 *d
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
-	if (dwc->dr_mode == USB_DR_MODE_HOST ||
-	    dwc->dr_mode == USB_DR_MODE_OTG) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
-
-		/*
-		 * Enable Auto retry Feature to make the controller operating in
-		 * Host mode on seeing transaction errors(CRC errors or internal
-		 * overrun scenerios) on IN transfers to reply to the device
-		 * with a non-terminating retry ACK (i.e, an ACK transcation
-		 * packet with Retry=1 & Nump != 0)
-		 */
-		reg |= DWC3_GUCTL_HSTINAUTORETRY;
-
-		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-	}
-
 	/*
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -238,9 +238,6 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
-/* Global User Control Register */
-#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
-
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS	BIT(17)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)


