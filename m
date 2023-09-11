Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC0F79B9B4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbjIKVMk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238697AbjIKODG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:03:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56B2CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:03:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B1FC433C8;
        Mon, 11 Sep 2023 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440981;
        bh=zb+VrpDF1TmKgHDL3SzxZEPEqDEffpdNHYewHbtuEbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=puMKuqPdJzopfZzhSgCP7UNU7cswIJP9Uzck6Li4DsNwRauxi8nb3B4PnDlIVnOPH
         G8aknqjo16j/yKuehghz5N7vfbaCQvjd6o87lbBCcWDCE+2yANbuaPGuAI2nY/mWWv
         Zsw0eNVoY7ec801Ev8tNQYZcw88PSvpkZc3QElUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 227/739] arm64: dts: qcom: sdm845-tama: Set serial indices and stdout-path
Date:   Mon, 11 Sep 2023 15:40:26 +0200
Message-ID: <20230911134657.516485919@linuxfoundation.org>
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

[ Upstream commit 9acc60c3e2d449243e4c2126e3b56f1c4f7fd3bc ]

UART6 is used for debug (routed via uSD pins) and UART9 is connected
to the bluetooth chip.

Set indexed aliases to make the GENI UART driver happy and route serial
traffic through the debug uart by default.

Fixes: 30a7f99befc6 ("arm64: dts: qcom: Add support for SONY Xperia XZ2 / XZ2C / XZ3 (Tama platform)")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Link: https://lore.kernel.org/r/20230627-topic-tama_uart-v1-1-0fa790248db8@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 3bc187a066aeb..7ee61b20452e2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -15,6 +15,15 @@ / {
 	qcom,msm-id = <321 0x20001>; /* SDM845 v2.1 */
 	qcom,board-id = <8 0>;
 
+	aliases {
+		serial0 = &uart6;
+		serial1 = &uart9;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
-- 
2.40.1



