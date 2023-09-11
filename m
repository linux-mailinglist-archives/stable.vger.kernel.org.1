Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D41779B0B4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378593AbjIKWfr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241057AbjIKPAt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:00:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C3B1B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:00:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1933C433C8;
        Mon, 11 Sep 2023 15:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444445;
        bh=6a7SXEkHJGLbkWvi0Pyt9N/mIeGy15QEFPBeirtYcw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a97tVyaKYL9igeiPSp40g/Nfx8rEpNKbEnxC/P6B5Qjb12k06H/BNDIpwqb322mVJ
         d0FHRcglIBFJVv7aYr2MM2wk5qPJ8JZqQWWMUThGC9MtcTgpmQz3CF4R/ApvwPa4W3
         Fk7UkAEDxgcpXJaGsGMMxOREEwxYnNxjjuaHlNDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.4 705/737] regulator: dt-bindings: qcom,rpm: fix pattern for children
Date:   Mon, 11 Sep 2023 15:49:24 +0200
Message-ID: <20230911134710.213735518@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 75d9bf03e2fa38242b35e941ce7c7cdabe479961 upstream.

The "or" (|) in regular expression must be within parentheses,
otherwise it is not really an "or" and it matches supplies:

  qcom-apq8060-dragonboard.dtb: regulators-1: vdd_ncp-supply: [[34]] is not of type 'object'

Fixes: fde0e25b71a9 ("dt-bindings: regulators: convert non-smd RPM Regulators bindings to dt-schema")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230725164047.368892-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../devicetree/bindings/regulator/qcom,rpm-regulator.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
index 8a08698e3484..b4eb4001eb3d 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
@@ -49,7 +49,7 @@ patternProperties:
   ".*-supply$":
     description: Input supply phandle(s) for this node
 
-  "^((s|l|lvs)[0-9]*)|(s[1-2][a-b])|(ncp)|(mvs)|(usb-switch)|(hdmi-switch)$":
+  "^((s|l|lvs)[0-9]*|s[1-2][a-b]|ncp|mvs|usb-switch|hdmi-switch)$":
     description: List of regulators and its properties
     $ref: regulator.yaml#
     unevaluatedProperties: false
-- 
2.42.0



