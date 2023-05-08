Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BE76FA765
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjEHK37 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjEHK35 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A8925276
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F95B62699
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4D3C433D2;
        Mon,  8 May 2023 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541794;
        bh=/udD4aTSZTEpOkzkEGL8WCi98hBZUSpxZmWWW8RqDec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgZ9Cqtlmzg+4tQ26I6VOZkMVYv9wN2kOpilEQ3xByoUT4MMdYxLN17pLLjl7nyw2
         NJJROEZzpTHop3C6eKIVTIjsDIDUSHoKXUBrcxsAwMzv10gfrTAJ98ei5LVTyxk2Zp
         x7JCEbmfPXoitzoI3v0cUgbB25pjpqfdDnjoHaNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Vorel <pvorel@suse.cz>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 228/663] arm64: dts: qcom: msm8994-angler: removed clash with smem_region
Date:   Mon,  8 May 2023 11:40:54 +0200
Message-Id: <20230508094435.703208562@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Petr Vorel <pvorel@suse.cz>

[ Upstream commit c85c8a992794dfcd7cea7a41871710c27c5592a6 ]

This fixes memory overlap error:
[    0.000000] reserved@6300000 (0x0000000006300000--0x0000000007000000) overlaps with smem_region@6a00000 (0x0000000006a00000--0x0000000006c00000)

smem_region is the same as in downstream (qcom,smem) [1], therefore
split reserved memory into two sections on either side of smem_region.

Not adding labels as it's not expected to be used.

[1] https://android.googlesource.com/kernel/msm/+/refs/heads/android-msm-angler-3.10-marshmallow-mr1/arch/arm/boot/dts/qcom/msm8994.dtsi#948

Fixes: 380cd3a34b7f ("arm64: dts: msm8994-angler: fix the memory map")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230131200414.24373-3-pvorel@suse.cz
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi          | 5 -----
 arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dts | 4 ++--
 arch/arm64/boot/dts/qcom/msm8994.dtsi                      | 5 +++++
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
index cd77dcb558722..b8f2a01bcb96c 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
@@ -60,11 +60,6 @@
 			reg = <0x0 0x05000000 0x0 0x1a00000>;
 			no-map;
 		};
-
-		reserved@6c00000 {
-			reg = <0x0 0x06c00000 0x0 0x400000>;
-			no-map;
-		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dts
index 59b9ed78cf0cb..29e79ae0849d8 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dts
+++ b/arch/arm64/boot/dts/qcom/msm8994-huawei-angler-rev-101.dts
@@ -41,8 +41,8 @@
 			no-map;
 		};
 
-		removed_region: reserved@6300000 {
-			reg = <0 0x06300000 0 0xD00000>;
+		reserved@6300000 {
+			reg = <0 0x06300000 0 0x700000>;
 			no-map;
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 9ff9d35496d21..24c3fced8df71 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -228,6 +228,11 @@
 			reg = <0 0xc9400000 0 0x3f00000>;
 			no-map;
 		};
+
+		reserved@6c00000 {
+			reg = <0 0x06c00000 0 0x400000>;
+			no-map;
+		};
 	};
 
 	smd {
-- 
2.39.2



