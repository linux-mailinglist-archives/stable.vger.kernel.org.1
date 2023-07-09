Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A49374C342
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjGILaK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjGILaI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A84C0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 900F360BC9
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04C5C433C7;
        Sun,  9 Jul 2023 11:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902207;
        bh=9yj/H9YeZH/x9APVFO4gsHLKIrHbSsuef9sI4cr4Kyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPxCQLojL0zAKTVk89hCt0/D7V2UDCejhMrqco3r6kLLNV7C4SMiQS+U6RGBKXoyx
         QNe5vYakjDKcx6sKIn3tOsOm33DMsdOYN80cSnBcAy3lvE5TIY2Qd8lQb+Dm7VoI7+
         zkkU8V870AiYL5xL/6ewgXn5elNqS8c8WsZghEa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 293/431] arm64: dts: qcom: qdu1000: Flush RSC sleep & wake votes
Date:   Sun,  9 Jul 2023 13:14:01 +0200
Message-ID: <20230709111458.013378909@linuxfoundation.org>
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

[ Upstream commit ab033e7846f91953244d0626b28ce66412b813b3 ]

The rpmh driver will cache sleep and wake votes until the cluster
power-domain is about to enter idle, to avoid unnecessary writes. So
associate the apps_rsc with the cluster pd, so that it can be notified
about this event.

Without this, only AMC votes are being commited.

Fixes: 6bd20c54b589 ("arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230531-topic-rsc-v1-3-b4a985f57b8b@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index c72a51c32a300..eeb4e51b31cfc 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -1238,6 +1238,7 @@ apps_rsc: rsc@17a00000 {
 			qcom,tcs-config = <ACTIVE_TCS    2>, <SLEEP_TCS     3>,
 					  <WAKE_TCS      3>, <CONTROL_TCS   0>;
 			label = "apps_rsc";
+			power-domains = <&CLUSTER_PD>;
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
-- 
2.39.2



