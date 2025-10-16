Return-Path: <stable+bounces-186202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3D5BE5406
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A46B4E9F0D
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 19:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021AB233D9C;
	Thu, 16 Oct 2025 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUx0KbQM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0714F112
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643483; cv=none; b=Bn4hGef4najJCeDi0akbRrHplgxQZ0TpSNHwnxBGN9ii1LYpgvNfDe1QnzGujbP3AqbDaWPsbYg7/jAN9+LRLgjETF/CBjeOuE3IR32Q09qnxkpB/ITSuCJsaSJYd/+qSF5g+5MPfPN4ymEQ5v1QjcFoMMa49bGvfOUW3fMa8Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643483; c=relaxed/simple;
	bh=pe6XYsfihJDNsRORbh/3K3e6n1Zq2v0j/c/Au9jyvOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O40SPLfcRRwfotlQ8jOCD7Oxyujo9wRQSAnxphIuTnQXzf0LZh73oc5SP3eFInlCA6plX8jWI1DdOJLeNYtF1ZBSi+QXwUI08eK7ht1JWGs/JhN4HMA9mQvs5Wsc8DPyAbRAqTh3T5CXL9jL6Lk1FAR+CypgKz8HP5Z2pnE69LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUx0KbQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB09C4CEF1;
	Thu, 16 Oct 2025 19:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760643483;
	bh=pe6XYsfihJDNsRORbh/3K3e6n1Zq2v0j/c/Au9jyvOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUx0KbQMfSJmqMWhQDpyA736vZ+AxkcK8Ht6AFtbryVPks4yyTUmCEG8iviu2UoIL
	 0xQv3DPLii6mpeqZvyAQQLDfHxn7pU2/+w/fOYy4/Sa2X+dnTXla44NkJFqo7Jg7Lj
	 ieKMms59HDswItZJ+OtUPYXvplpbxG1P6+iG6SnExiqx+MhjZzgw/2pnr0kj9Dg3+u
	 gqZ3E4ZnTx1ONYkctGUApKYxxSDbksm0RmD53SGBvB6BNo+Ed0/Om0IhsG9X6gjttw
	 LzuukJY++esukyrIdizJE29hCq6EsJTyFmJDf+VtDFukWg02pPEPVNTjp6ANgVCKiA
	 YjwKR/kUzX3qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y] arm64: dts: qcom: qcs615: add missing dt property in QUP SEs
Date: Thu, 16 Oct 2025 15:38:01 -0400
Message-ID: <20251016193801.3389185-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101637-delegate-oversold-c71e@gregkh>
References: <2025101637-delegate-oversold-c71e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

[ Upstream commit 6a5e9b9738a32229e2673d4eccfcbfe2ef3a1ab4 ]

Add the missing required-opps and operating-points-v2 properties to
several I2C, SPI, and UART nodes in the QUP SEs.

Fixes: f6746dc9e379 ("arm64: dts: qcom: qcs615: Add QUPv3 configuration")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250630064338.2487409-1-viken.dadhaniya@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs615.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
index bfbb210354922..e033b53f0f0f4 100644
--- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
@@ -631,6 +631,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 				interconnect-names = "qup-core",
 						     "qup-config";
 				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -654,6 +655,7 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -681,6 +683,7 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -703,6 +706,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 				interconnect-names = "qup-core",
 						     "qup-config";
 				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -728,6 +732,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 				interconnect-names = "qup-core",
 						     "qup-config";
 				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table>;
 				status = "disabled";
 			};
 
@@ -751,6 +756,7 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx",
-- 
2.51.0


