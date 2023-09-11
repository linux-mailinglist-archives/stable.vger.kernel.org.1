Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE4479B267
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349046AbjIKVcS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbjIKOBO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:01:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA293CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:01:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE48DC433C8;
        Mon, 11 Sep 2023 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440870;
        bh=Ra5u6NcpkBJnnbQaJ4oLMSQVXAIrdGIe6Fg+vWSU9Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxmt3aFTBFc+4Tw4TaeRowuoutJBYL2yZNVYfpU9Ky4B8zgii2P/M3TsMrhZ9Sxxx
         YLFtOO99RhOSkSQ9t2N3r0fOkk52TzUFcxyLimmIwGu6WFhP0X9nsaMKGViMcZYVzY
         K/0FQB0qQlbEFkEejIiiTh0QMlEWYX3npKbHXS80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 214/739] arm64: dts: qcom: sm6350: Fix ZAP region
Date:   Mon, 11 Sep 2023 15:40:13 +0200
Message-ID: <20230911134657.168443842@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@somainline.org>

[ Upstream commit 44bcded2be4fe9b9d0b6e48075c9947b75c0af63 ]

The previous ZAP region definition was wrong. Fix it.
Note this is not a device-specific fixup, but a fixup to the generic
PIL load address.

Fixes: 5f82b9cda61e ("arm64: dts: qcom: Add SM6350 device tree")
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230315-topic-lagoon_gpu-v2-6-afcdfb18bb13@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 30e77010aed57..7cafb32fbb941 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -633,11 +633,6 @@ pil_ipa_gsi_mem: memory@8b710000 {
 			no-map;
 		};
 
-		pil_gpu_mem: memory@8b715400 {
-			reg = <0 0x8b715400 0 0x2000>;
-			no-map;
-		};
-
 		pil_modem_mem: memory@8b800000 {
 			reg = <0 0x8b800000 0 0xf800000>;
 			no-map;
@@ -658,6 +653,11 @@ removed_region: memory@c0000000 {
 			no-map;
 		};
 
+		pil_gpu_mem: memory@f0d00000 {
+			reg = <0 0xf0d00000 0 0x1000>;
+			no-map;
+		};
+
 		debug_region: memory@ffb00000 {
 			reg = <0 0xffb00000 0 0xc0000>;
 			no-map;
-- 
2.40.1



