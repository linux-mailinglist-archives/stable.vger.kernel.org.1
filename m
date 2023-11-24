Return-Path: <stable+bounces-1744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDE47F812B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF929B21116
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AB43418B;
	Fri, 24 Nov 2023 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CjAMh6dC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8363A1;
	Fri, 24 Nov 2023 18:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E08C433C7;
	Fri, 24 Nov 2023 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852168;
	bh=ThFpiaTtcyHsjM0oi/swVButWuixhvgXZh5LME2ATWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjAMh6dCihyYsESdX67tju3VIzoPhDcu8/rQUJLRJ/3na59FXhoe4EF8oN0h6svdA
	 vkk0yUT4aCxgOWSQ5SPUmY27dnnnRxOq8f+CJEZ7D2Elmd/XxCnVqM0SDo9njwxZtI
	 KCsTtMM6ZbF45ZHpMWXyoSN+INS/UlT2jwzW3xGk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vignesh Viswanathan <quic_viswanat@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.1 222/372] arm64: dts: qcom: ipq6018: Fix hwlock index for SMEM
Date: Fri, 24 Nov 2023 17:50:09 +0000
Message-ID: <20231124172017.886872672@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -169,7 +169,7 @@
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_region>;
-		hwlocks = <&tcsr_mutex 0>;
+		hwlocks = <&tcsr_mutex 3>;
 	};
 
 	soc: soc {



