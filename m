Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC079B6FF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbjIKWKO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbjIKOSK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:18:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CD7DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:18:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEB9C433C8;
        Mon, 11 Sep 2023 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441885;
        bh=91sQcF9Ly1eNrxGBSAlnQDD3ZzoQNu92ubCYxyDX7oY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ptm/2OZmk488OLlyEa1CZzs3RT/KmLF9J8ouxS7+PZSg+Xp0RgXmi7MTbao6QpjaQ
         aXV5/cn3SgRPdHAthC4AxYPqu7Ol+YkfAvXotoOCvnvB18M9nCilPSre1BzXT+5fNs
         inxua1Ga1tReQ2TmjEwX3j0VJ9zRKZbpAWlUUSEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 570/739] dt-bindings: usb: samsung,exynos-dwc3: fix order of clocks on Exynos5433
Date:   Mon, 11 Sep 2023 15:46:09 +0200
Message-ID: <20230911134706.995200583@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 8d4ff1351801bd646c9fed7aedb9705250f2c87b ]

The Exynos5433 DTSI had always different order of DWC USB3 controller
clocks than the binding.  The order in the binding was introduced in the
commit 949ea75b7ba4 ("dt-bindings: usb: samsung,exynos-dwc3: convert to
dtschema") converting to DT schema.  The Linux driver does not care
about order and was always getting clocks by name.  Therefore assume the
DTS is the preferred order and correct the binding.

Fixes: 949ea75b7ba4 ("dt-bindings: usb: samsung,exynos-dwc3: convert to dtschema")
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Link: https://lore.kernel.org/r/20230818102911.18388-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
index 42ceaf13cd5da..e61badb61b35a 100644
--- a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
@@ -82,8 +82,8 @@ allOf:
           items:
             - const: aclk
             - const: susp_clk
-            - const: pipe_pclk
             - const: phyclk
+            - const: pipe_pclk
 
   - if:
       properties:
-- 
2.40.1



