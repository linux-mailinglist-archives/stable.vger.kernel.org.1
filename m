Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1477D72C226
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbjFLLDK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbjFLLCj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:02:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD3AF
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ADF3624B7
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EE7C433EF;
        Mon, 12 Jun 2023 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567019;
        bh=YMsX/jbft63DgDRxBm9uxcfYUlL7VMyidwIcURGMCDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2J5ddVJ3ufrr7Nt9vcZ7H7vWS7zeZF9lDhO4l+1JNnFpUiCLOwhrxZ4kfa7zS1NuN
         9213VL8cXFTBQ7XKsvkqRlOj6PbZYRa4285STQaNFiFtYBQ5CV6V1hA1TIh0Q05dFM
         ozwOu1k+oKBv0lNU6Z8BHi6lcX2vfN8KHCPrOYWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 120/160] arm64: dts: qcom: sm6375-pdx225: Fix remoteproc firmware paths
Date:   Mon, 12 Jun 2023 12:27:32 +0200
Message-ID: <20230612101720.547799093@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit a14da6144d16ef27e3022835fa282a3740b8ad7b ]

They were previously missing the SoC name. Fix it.

Fixes: a2ad207c412b ("arm64: dts: qcom: sm6375-pdx225: Enable ADSP & CDSP")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230517-topic-murray-fwname-v1-1-923e87312249@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index b691c3834b6b6..71970dd3fc1ad 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -151,12 +151,12 @@ &qupv3_id_1 {
 };
 
 &remoteproc_adsp {
-	firmware-name = "qcom/Sony/murray/adsp.mbn";
+	firmware-name = "qcom/sm6375/Sony/murray/adsp.mbn";
 	status = "okay";
 };
 
 &remoteproc_cdsp {
-	firmware-name = "qcom/Sony/murray/cdsp.mbn";
+	firmware-name = "qcom/sm6375/Sony/murray/cdsp.mbn";
 	status = "okay";
 };
 
-- 
2.39.2



