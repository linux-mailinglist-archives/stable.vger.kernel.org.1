Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8921079AE5F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242145AbjIKU5k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbjIKOER (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:04:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851F1CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:04:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD299C433C8;
        Mon, 11 Sep 2023 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441052;
        bh=7LRfqi/nKAQHm1j9G6/YmUBr3ugXtpoUR3rS+72uvDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkUQq5O+t2hxEtU8Stchvg/3w7miTTrdrVrngRZZ/1APckT1qz+u71PDM9srdqgKr
         Vq+JLkvjHxYiiZluH/gwRQjbdn+KENsRTgnwfJQ5ZL7Fvi7ll2eE44SFltMhw+2RCO
         McHr+oOGmxmCnWdFhXlEDTl/2uPgUFS4pCA9BXE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 278/739] dt-bindings: arm: msm: kpss-acc: Make the optional reg truly optional
Date:   Mon, 11 Sep 2023 15:41:17 +0200
Message-ID: <20230911134658.888649703@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 7dc3ea5ea8e8df2a82a1e78bef2382fb2c982ed3 ]

The description of reg[1] says that register is optional. Adjust
minItems to make it truly optional.

Fixes: 4260ddfb6496 ("dt-bindings: arm: msm: Convert and split kpss-acc driver Documentation to yaml")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230627-topic-more_bindings-v1-9-6b4b6cd081e5@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
index 202a5d51ee88c..facaafefb4414 100644
--- a/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
@@ -21,6 +21,7 @@ properties:
     const: qcom,kpss-acc-v2
 
   reg:
+    minItems: 1
     items:
       - description: Base address and size of the register region
       - description: Optional base address and size of the alias register region
-- 
2.40.1



