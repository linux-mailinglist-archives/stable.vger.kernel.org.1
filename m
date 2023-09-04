Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA8791D2D
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbjIDSf6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346213AbjIDSf6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:35:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5043CD7
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 089E3CE0F9C
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58AAC433C9;
        Mon,  4 Sep 2023 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852550;
        bh=clDGOKIbw9jIbe1jrNYIgDig+t09hU/V35mBuUJWH4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqw3F5oDNfeiXCWmKLjKrcuX4YD3EfS1O+CLSFfvjbdqz7j2baWROxVqtsfLcD3ad
         4K5XpErNnetp6qkfgV5MX/UADRmvK0g/739fNIe2ce7AK6SmHICyxj+56qi2pDGaYO
         uASZ4v09S8wjO6eLnOG3+k06XdPyBdquTZcSSIGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 6.1 27/31] dt-bindings: sc16is7xx: Add property to change GPIO function
Date:   Mon,  4 Sep 2023 19:30:35 +0100
Message-ID: <20230904182948.302658549@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
References: <20230904182946.999390199@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

commit 4cf478dc5d707e56aefa258c049872eff054a353 upstream.

Some variants in this series of UART controllers have GPIO pins that
are shared between GPIO and modem control lines.

The pin mux mode (GPIO or modem control lines) can be set for each
ports (channels) supported by the variant.

This adds a property to the device tree to set the GPIO pin mux to
modem control lines on selected ports if needed.

Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230807214556.540627-4-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../bindings/serial/nxp,sc16is7xx.txt         | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
index 0fa8e3e43bf8..1a7e4bff0456 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
@@ -23,6 +23,9 @@ Optional properties:
     1 = active low.
 - irda-mode-ports: An array that lists the indices of the port that
 		   should operate in IrDA mode.
+- nxp,modem-control-line-ports: An array that lists the indices of the port that
+				should have shared GPIO lines configured as
+				modem control lines.
 
 Example:
         sc16is750: sc16is750@51 {
@@ -35,6 +38,26 @@ Example:
                 #gpio-cells = <2>;
         };
 
+	sc16is752: sc16is752@53 {
+		compatible = "nxp,sc16is752";
+		reg = <0x53>;
+		clocks = <&clk20m>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		nxp,modem-control-line-ports = <1>; /* Port 1 as modem control lines */
+		gpio-controller; /* Port 0 as GPIOs */
+		#gpio-cells = <2>;
+	};
+
+	sc16is752: sc16is752@54 {
+		compatible = "nxp,sc16is752";
+		reg = <0x54>;
+		clocks = <&clk20m>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
+	};
+
 * spi as bus
 
 Required properties:
@@ -59,6 +82,9 @@ Optional properties:
     1 = active low.
 - irda-mode-ports: An array that lists the indices of the port that
 		   should operate in IrDA mode.
+- nxp,modem-control-line-ports: An array that lists the indices of the port that
+				should have shared GPIO lines configured as
+				modem control lines.
 
 Example:
 	sc16is750: sc16is750@0 {
@@ -70,3 +96,23 @@ Example:
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	sc16is752: sc16is752@1 {
+		compatible = "nxp,sc16is752";
+		reg = <1>;
+		clocks = <&clk20m>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		nxp,modem-control-line-ports = <1>; /* Port 1 as modem control lines */
+		gpio-controller; /* Port 0 as GPIOs */
+		#gpio-cells = <2>;
+	};
+
+	sc16is752: sc16is752@2 {
+		compatible = "nxp,sc16is752";
+		reg = <2>;
+		clocks = <&clk20m>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
+	};
-- 
2.42.0



