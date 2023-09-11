Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E4079BD7B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357980AbjIKWHH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbjIKOCf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:02:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74080CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:02:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBE2C433C8;
        Mon, 11 Sep 2023 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440950;
        bh=JLCvWy+VGpvn/geBsMqKmyO5Qt8E7LNK7NmiEB3Rgto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3ROGY1goc0OOvbVuS7B8WcSnLq7wWpQoCXhG+dyPxlGxhlfeWqDsPJP09Kn9J34U
         bJ5qn9HXINCljlhAYqG2MB8o8Bm8D7YoJ4H0TX0Xjbr3f1+sEb46PYbs3xV010fkkS
         MGr/KgqPZb0mR8LkMEvjTnXW07qHdl/aKalIIM9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 225/739] arm64: dts: qcom: msm8939: Add missing cache-unified to L2
Date:   Mon, 11 Sep 2023 15:40:24 +0200
Message-ID: <20230911134657.463800675@linuxfoundation.org>
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

[ Upstream commit 68a59251f1c590ad567ff7fd799f6634fbab6e16 ]

Add the missing property to fix the dt checker warning:

qcom/apq8039-t2.dtb: l2-cache: 'cache-unified' is a required property

Fixes: 61550c6c156c ("arm64: dts: qcom: Add msm8939 SoC")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Link: https://lore.kernel.org/r/20230627-topic-more_bindings-v1-3-6b4b6cd081e5@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 8a856bd8e8e92..3d9270b5482b4 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -55,6 +55,7 @@ CPU0: cpu@100 {
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
@@ -111,6 +112,7 @@ CPU4: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
-- 
2.40.1



