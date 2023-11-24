Return-Path: <stable+bounces-2283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108857F8386
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04162884EC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625EF364C4;
	Fri, 24 Nov 2023 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z4D1kUyu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C033CC2;
	Fri, 24 Nov 2023 19:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E8FC433A9;
	Fri, 24 Nov 2023 19:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853506;
	bh=suSpkl/0CfXHTvfr0+7faU4ntognt2c4lvmSIWj4naw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4D1kUyufQdR7F2QzYKJsWXArChKsQiBtlZpXZryqr0flfbRCj/1vnIfHRE3mZASI
	 uEEw7rofKefTYtueCY86822I9tT5cQJ4VuPN2c4Oza1IfOcyMPXNsuaV+/MsmEG0bK
	 zFm/7/BL3DEAvx2/6VXoskDbkh9ywmFNVWVZIi1A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vignesh Viswanathan <quic_viswanat@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 5.15 190/297] arm64: dts: qcom: ipq6018: Fix hwlock index for SMEM
Date: Fri, 24 Nov 2023 17:53:52 +0000
Message-ID: <20231124172006.871206121@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh Viswanathan <quic_viswanat@quicinc.com>

commit 95d97b111e1e184b0c8656137033ed64f2cf21e4 upstream.

SMEM uses lock index 3 of the TCSR Mutex hwlock for allocations
in SMEM region shared by the Host and FW.

Fix the SMEM hwlock index to 3 for IPQ6018.

Cc: stable@vger.kernel.org
Fixes: 5bf635621245 ("arm64: dts: ipq6018: Add a few device nodes")
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230904172516.479866-3-quic_viswanat@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -175,7 +175,7 @@
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_region>;
-		hwlocks = <&tcsr_mutex 0>;
+		hwlocks = <&tcsr_mutex 3>;
 	};
 
 	soc: soc {



