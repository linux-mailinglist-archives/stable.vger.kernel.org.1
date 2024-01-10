Return-Path: <stable+bounces-10242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A88273F2
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A40B22E19
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C7537F4;
	Mon,  8 Jan 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HE4uwNjK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1E537EA;
	Mon,  8 Jan 2024 15:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666F0C433C8;
	Mon,  8 Jan 2024 15:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728436;
	bh=e0ZXjmp5mVsMqi7WNFfh+N8s4G9HMZ+/EKg35JjVKoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HE4uwNjKBlIIfvNrchVKRw5vmhf/g8+DyJhG7rJF58scrLCmu3yzTd12CpVN7x3/y
	 iwq7qZEAYD4cLCD9vdbyDcRput4ySXdv1gUbNo+Q/SUdCgDl3OBpegPUwWpY1M+nzN
	 1d6FA8YcSHY73eitP/TOieznz89JJKLaL7qcOSC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 075/150] arm64: dts: qcom: sdm845: align RPMh regulator nodes with bindings
Date: Mon,  8 Jan 2024 16:35:26 +0100
Message-ID: <20240108153514.668148004@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 86dd19bbdea2b7d3feb69c0c39f141de30a18ec9 ]

Device node names should be generic and bindings expect certain pattern
for RPMh regulator nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230127114347.235963-6-krzysztof.kozlowski@linaro.org
Stable-dep-of: a5f01673d394 ("arm64: dts: qcom: sdm845: Fix PSCI power domain names")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi            | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts            | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi        | 6 +++---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts               | 6 +++---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi   | 6 +++---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts     | 6 +++---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 6 +++---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts  | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts    | 6 +++---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts  | 2 +-
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts      | 2 +-
 11 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index a5c0c788969fb..985824032c522 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -351,7 +351,7 @@ flash@0 {
 
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -633,7 +633,7 @@ src_pp1800_lvs2: lvs2 {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index c9efcb894a52f..8c9ccf5b4ea41 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -271,7 +271,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 		vdd-s1-supply = <&vph_pwr>;
@@ -396,7 +396,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 20f275f8694dc..e2921640880a1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -166,7 +166,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -419,7 +419,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -433,7 +433,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 64958dee17d8b..b47e333aa3510 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -117,7 +117,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -382,7 +382,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -396,7 +396,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 392461c29e76e..0713b774a97be 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -144,7 +144,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -280,7 +280,7 @@ vreg_l28a_3p0: ldo28 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -294,7 +294,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 83261c9bb4f23..b65c35865dab9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -110,7 +110,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -375,7 +375,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -389,7 +389,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index d6918e6d19799..249a715d5aae1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -78,7 +78,7 @@ ramoops@ffc00000 {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -308,7 +308,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -319,7 +319,7 @@ src_vreg_bob: bob {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 0f470cf1ed1c1..6d6b3dd699475 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -125,7 +125,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 093b04359ec39..ffbe45a99b74a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -143,7 +143,7 @@ vreg_s4a_1p8: vreg-s4a-1p8 {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -343,7 +343,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -355,7 +355,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 74f43da51fa50..48a41ace8fc58 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -99,7 +99,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index d028a7eb364a6..c169d2870bdf4 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -129,7 +129,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
-- 
2.43.0




