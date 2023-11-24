Return-Path: <stable+bounces-1322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1018A7F7F17
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE22A2824A7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC933CCA;
	Fri, 24 Nov 2023 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xMsUj5ge"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103473307D;
	Fri, 24 Nov 2023 18:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D52C433C8;
	Fri, 24 Nov 2023 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851110;
	bh=mCaTAVcAWXfAX0axfOu4UO+N7BV+dKN9YrqAOoblCrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xMsUj5ge3GmKwBVCsBisBy80BS8ZJTythAKVAH69akBzWAiRS8EO1bx1QllhAzvgv
	 MMOOZcW5A8+mVxSqtl4NPPxITL3Lqw/ZY52VKNQPbjCCmrCTWc27NO9VqVvK9qR2s8
	 drf3+3gLA4MBWuYJuwpBNdu3s087f/CZ0rxwBfCI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vignesh Viswanathan <quic_viswanat@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.5 317/491] arm64: dts: qcom: ipq8074: Fix hwlock index for SMEM
Date: Fri, 24 Nov 2023 17:49:13 +0000
Message-ID: <20231124172034.096289859@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh Viswanathan <quic_viswanat@quicinc.com>

commit 8a781d04e580705d36f7db07f5c80e748100b69d upstream.

SMEM uses lock index 3 of the TCSR Mutex hwlock for allocations
in SMEM region shared by the Host and FW.

Fix the SMEM hwlock index to 3 for IPQ8074.

Cc: stable@vger.kernel.org
Fixes: 42124b947e8e ("arm64: dts: qcom: ipq8074: add SMEM support")
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230904172516.479866-4-quic_viswanat@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -101,7 +101,7 @@
 			reg = <0x0 0x4ab00000 0x0 0x100000>;
 			no-map;
 
-			hwlocks = <&tcsr_mutex 0>;
+			hwlocks = <&tcsr_mutex 3>;
 		};
 
 		memory@4ac00000 {



