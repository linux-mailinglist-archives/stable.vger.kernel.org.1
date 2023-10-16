Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091967CABEF
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJPOrj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjJPOri (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:47:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC8B4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:47:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4ADAC433C8;
        Mon, 16 Oct 2023 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467653;
        bh=T8Sy1q2Hn5oflVpeoU2O3cdEHc9m83o5IApEFjLOx/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wsBjR9Otf0HjViuUcuoo5hkHpAz/q4OablWQBshdSRCpAuHCJPeEFekeZntoL/AV0
         ed0smj8Ly2PC1Fh+pPAGZV1CePbzh2xyZnwquE23KPFEgOqkUOERaYhoSyPFs7PdyO
         rUnw1qAaazUkK49tYwpN6KbAOJWgG30r4zFB0o0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.5 024/191] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update description for #interrupt-cells property
Date:   Mon, 16 Oct 2023 10:40:09 +0200
Message-ID: <20231016084015.966084383@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit cfa1f9db6d6088118ef311c0927c66072665b47e upstream.

Update description for '#interrupt-cells' property to utilize the
RZG2L_{NMI,IRQX} for the first cell defined in the
include/dt-bindings/interrupt-controller/irqc-rzg2l.h file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 96fed779d3d4cb3c ("dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Controller")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220722151155.21100-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -31,8 +31,9 @@ properties:
       - const: renesas,rzg2l-irqc
 
   '#interrupt-cells':
-    description: The first cell should contain external interrupt number (IRQ0-7) and the
-                 second cell is used to specify the flag.
+    description: The first cell should contain a macro RZG2L_{NMI,IRQX} included in the
+                 include/dt-bindings/interrupt-controller/irqc-rzg2l.h and the second
+                 cell is used to specify the flag.
     const: 2
 
   '#address-cells':


