Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7963E74C344
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjGILaP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjGILaO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C37513D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B49860BC4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36928C433C7;
        Sun,  9 Jul 2023 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902212;
        bh=kmfN2NK2k9P96OYqg2X3mcu0Scs8PbR1pyNQq+LQBM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouF6G4UbnkvC21UW0/XGOtGDR/HhERvqwEeuseUpshYZXctvcY3Zpi1eV8vJgx8yb
         +qDy1V/jTtIRGr2kX0lsMQX28tx1fm/7kN1IIc4q4i2CF6uTI4NoaKIJ646Z+9XCP+
         g5QS2MzJav2lO82ywfX6M5t2d0ncXoys8fPCSmTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 295/431] arm64: dts: qcom: sdm845: Flush RSC sleep & wake votes
Date:   Sun,  9 Jul 2023 13:14:03 +0200
Message-ID: <20230709111458.059163208@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 91e83140b5dd5598fbcfada3ee1f8b2b410c3731 ]

The rpmh driver will cache sleep and wake votes until the cluster
power-domain is about to enter idle, to avoid unnecessary writes. So
associate the apps_rsc with the cluster pd, so that it can be notified
about this event.

Without this, only AMC votes are being commited.

Fixes: c83545d95376 ("arm64: dts: sdm845: Add rpmh-rsc node")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230531-topic-rsc-v1-6-b4a985f57b8b@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index bc89a2b4bc258..a818a81408dfb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5058,6 +5058,7 @@ apps_rsc: rsc@179c0000 {
 					  <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
+			power-domains = <&CLUSTER_PD>;
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
-- 
2.39.2



