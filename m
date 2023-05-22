Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9752070C658
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjEVTRL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjEVTRF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:17:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5DF10D
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1AC3627A9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90DCC4339C;
        Mon, 22 May 2023 19:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783022;
        bh=zhfU2Wwg/Wh1UpyipmueqSx0bDiCcXIdkr0oZqcUUZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpEju2XoTMIZidJNlvzlWZmKckN+s5y5OpDC9Bl+163Feuq4Ax9Rga8LWzDnRMGLA
         e2u+f18NzAiZHC5+SjqvIUnyoCm0J6zDfsChMM0asp7+ruE/hemQ23W08Lnz5UsZwC
         3XIcQwEtUzg9/vOfDEgZwtWijXVtin3mFJjO0Als=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 113/203] dt-bindings: display/msm: dsi-controller-main: Document qcom, master-dsi and qcom, sync-dual-dsi
Date:   Mon, 22 May 2023 20:08:57 +0100
Message-Id: <20230522190358.109394099@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jianhua Lu <lujianhua000@gmail.com>

[ Upstream commit ca29699a57ecee6084a4056f5bfd6f11dd359a71 ]

This fixes warning:
  sm8250-xiaomi-elish-csot.dtb: dsi@ae94000: Unevaluated properties are not allowed ('qcom,master-dsi', 'qcom,sync-dual-dsi' were unexpected)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/534306/
Link: https://lore.kernel.org/r/20230427122132.24840-1-lujianhua000@gmail.com
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../bindings/display/msm/dsi-controller-main.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 283a12cd3e144..4b2cd556483c0 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -64,6 +64,18 @@ properties:
       Indicates if the DSI controller is driving a panel which needs
       2 DSI links.
 
+  qcom,master-dsi:
+    type: boolean
+    description: |
+      Indicates if the DSI controller is the master DSI controller when
+      qcom,dual-dsi-mode enabled.
+
+  qcom,sync-dual-dsi:
+    type: boolean
+    description: |
+      Indicates if the DSI controller needs to sync the other DSI controller
+      with MIPI DCS commands when qcom,dual-dsi-mode enabled.
+
   assigned-clocks:
     minItems: 2
     maxItems: 2
-- 
2.39.2



