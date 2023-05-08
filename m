Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444B36FAA1D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjEHK7d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjEHK64 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:58:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8132348B6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 638EB629D1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D86C433EF;
        Mon,  8 May 2023 10:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543467;
        bh=zH+986TQhf6rjVEN1rV3vbR6bwnD2FxNktuceiani/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8N3RIm7W7vZQ9Feo5Y3s5zJFgWPu5KJl3JdmwArr4lvHOaiLbXMkSXJ9c1S0YQX2
         47T0RfaXBQlU4uOfUz5mJ9jubb8jnSYgOaA+YMEtVYoLueNdgTihCyCbOXFsLdjPBo
         Y++cT6vLkJ8+4V4I+WbaLDEqfPjOjx0nbtFtH7gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.3 099/694] ASoC: dt-bindings: qcom,lpass-rx-macro: correct minItems for clocks
Date:   Mon,  8 May 2023 11:38:54 +0200
Message-Id: <20230508094435.715790170@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 59257015ac8813d2430988aa01c2f4609a60e8e7 upstream.

The RX macro codec comes on some platforms in two variants - ADSP
and ADSP bypassed - thus the clock-names varies from 3 to 5.  The clocks
must vary as well:

  sc7280-idp.dtb: codec@3200000: clocks: [[202, 8], [202, 7], [203]] is too short

Fixes: 852fda58d99a ("ASoC: qcom: dt-bindings: Update bindings for clocks in lpass digital codes")
Cc: <stable@vger.kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230330071333.24308-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml |    1 +
 1 file changed, 1 insertion(+)

--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -30,6 +30,7 @@ properties:
     const: 0
 
   clocks:
+    minItems: 3
     maxItems: 5
 
   clock-names:


