Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6B57354A1
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjFSK6F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjFSK5e (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E0D3AAA
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:55:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D7EB60A4D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843A8C433C0;
        Mon, 19 Jun 2023 10:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172133;
        bh=vAdsM+hjIZKz2nXd7bnVFlV9WvNPWJyMAkawniZXSjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEw//rpi5qb4G9kSDpzEdJIzZwef1kL9DdbU3OY21MK5I+mhwFItvxGDXpDX8DOJB
         Wv4hfy4BQDjBZsWpjS9eyFPfmDFp4xgWlqehj84RQszrqRyM6z2wkG/LYitvWAM0M0
         vOInz+8k8sewNPrPFlOD0YT9ZzAgxfzSyCS2cA4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Janne Grunau <j@jannau.net>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 5.10 31/89] nios2: dts: Fix tse_mac "max-frame-size" property
Date:   Mon, 19 Jun 2023 12:30:19 +0200
Message-ID: <20230619102139.704603479@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Janne Grunau <j@jannau.net>

commit 85041e12418fd0c08ff972b7729f7971afb361f8 upstream.

The given value of 1518 seems to refer to the layer 2 ethernet frame
size without 802.1Q tag. Actual use of the "max-frame-size" including in
the consumer of the "altr,tse-1.0" compatible is the MTU.

Fixes: 95acd4c7b69c ("nios2: Device tree support")
Fixes: 61c610ec61bb ("nios2: Add Max10 device tree")
Cc: <stable@vger.kernel.org>
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/nios2/boot/dts/10m50_devboard.dts |    2 +-
 arch/nios2/boot/dts/3c120_devboard.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/nios2/boot/dts/10m50_devboard.dts
+++ b/arch/nios2/boot/dts/10m50_devboard.dts
@@ -97,7 +97,7 @@
 			rx-fifo-depth = <8192>;
 			tx-fifo-depth = <8192>;
 			address-bits = <48>;
-			max-frame-size = <1518>;
+			max-frame-size = <1500>;
 			local-mac-address = [00 00 00 00 00 00];
 			altr,has-supplementary-unicast;
 			altr,enable-sup-addr = <1>;
--- a/arch/nios2/boot/dts/3c120_devboard.dts
+++ b/arch/nios2/boot/dts/3c120_devboard.dts
@@ -106,7 +106,7 @@
 				interrupt-names = "rx_irq", "tx_irq";
 				rx-fifo-depth = <8192>;
 				tx-fifo-depth = <8192>;
-				max-frame-size = <1518>;
+				max-frame-size = <1500>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
 				phy-mode = "rgmii-id";
 				phy-handle = <&phy0>;


