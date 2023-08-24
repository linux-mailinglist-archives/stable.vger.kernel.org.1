Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946A97872B4
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbjHXO4Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241973AbjHXO4B (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:56:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34A519AA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90CB966F73
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DC8C433C9;
        Thu, 24 Aug 2023 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888957;
        bh=ZzBiflekas4Bej4e+CaUZeBjaFExoIDPx3862YsN6xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0nWKXIX/mnAp6NPSRCTNZ+sumPfZ2GGjC8EuGAdtli6YNWvKfdqmdx6D7sad80p/
         5KPNU/C07+L6wQgNRmv5xdRu/8oVHhHSwHGQojCLz5y92ypBXxmAZP2n8TJUqJ/EJL
         0jIA1Ve8Bewhn9pgxJ3fseWC+VN/j0FpHWp8/gTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 102/139] arm64: dts: qcom: qrb5165-rb5: fix thermal zone conflict
Date:   Thu, 24 Aug 2023 16:50:25 +0200
Message-ID: <20230824145027.998749885@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 798f1df86e5709b7b6aedf493cc04c7fedbf544a ]

The commit 3a786086c6f8 ("arm64: dts: qcom: Add missing "-thermal"
suffix for thermal zones") renamed the thermal zone in the pm8150l.dtsi
file to comply with the schema. However this resulted in a clash with
the RB5 board file, which already contained the pm8150l-thermal zone for
the on-board sensor. This resulted in the board file definition
overriding the thermal zone defined in the PMIC include file (and thus
the on-die PMIC temp alarm was not probing at all).

Rename the thermal zone in qcom/qrb5165-rb5.dts to remove this override.

Fixes: 3a786086c6f8 ("arm64: dts: qcom: Add missing "-thermal" suffix for thermal zones")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230613131224.666668-1-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 0ce2d36ab257f..d3449cb52defe 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -113,7 +113,7 @@
 			};
 		};
 
-		pm8150l-thermal {
+		pm8150l-pcb-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&pm8150l_adc_tm 1>;
-- 
2.40.1



