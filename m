Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB379BC9A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358478AbjIKW0D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbjIKOXm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:23:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFB0DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:23:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FDDC433C8;
        Mon, 11 Sep 2023 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442218;
        bh=9hz0CaZikkbbsW/0wu3mY8Em1ep1bvqKxNB/GE7CqgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvWW5R8tHCLHPPZTG4hS0zeRgB2AXh2V1ImMPH91OuhZbBuSaGw0WgcJRttk81p9I
         KhpgKdt7VrQbc8DglkzCblxCzPnKaWHMQwX8SbXP3cGvPrbCPkLEwCAopvmAkNnjVp
         R1eTjxkRgUGOwKWZsO4y3QXc3w1e5bk/Ak/lFbrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 6.5 687/739] dt-bindings: PCI: qcom: Fix SDX65 compatible
Date:   Mon, 11 Sep 2023 15:48:06 +0200
Message-ID: <20230911134710.289014005@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 15d63a897f79f465d71fb55cc11c6b7e20c19391 upstream.

Commit c0aba9f32801 ("dt-bindings: PCI: qcom: Add SDX65 SoC") adding
SDX65 was never tested and is clearly bogus.  The qcom,sdx65-pcie-ep
compatible is followed by a fallback in DTS, and there is no driver
matched by this compatible.  Driver matches by its fallback
qcom,sdx55-pcie-ep.  This also fixes dtbs_check warnings like:

  qcom-sdx65-mtp.dtb: pcie-ep@1c00000: compatible: ['qcom,sdx65-pcie-ep', 'qcom,sdx55-pcie-ep'] is too long

[kwilczynski: commit log]
Fixes: c0aba9f32801 ("dt-bindings: PCI: qcom: Add SDX65 SoC")
Link: https://lore.kernel.org/linux-pci/20230827085351.21932-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml        | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 811112255d7d..c94b49498f69 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -11,10 +11,13 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,sdx55-pcie-ep
-      - qcom,sdx65-pcie-ep
-      - qcom,sm8450-pcie-ep
+    oneOf:
+      - enum:
+          - qcom,sdx55-pcie-ep
+          - qcom,sm8450-pcie-ep
+      - items:
+          - const: qcom,sdx65-pcie-ep
+          - const: qcom,sdx55-pcie-ep
 
   reg:
     items:
@@ -110,7 +113,6 @@ allOf:
           contains:
             enum:
               - qcom,sdx55-pcie-ep
-              - qcom,sdx65-pcie-ep
     then:
       properties:
         clocks:
-- 
2.42.0



