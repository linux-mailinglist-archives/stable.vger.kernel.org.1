Return-Path: <stable+bounces-47919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBCF8FAFAD
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 12:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169451F22C05
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 10:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA3145325;
	Tue,  4 Jun 2024 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ilVR7qqq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B273144D03
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496104; cv=none; b=BkFFsc12JAdPEkALdhjNLQA5D+HrvieaojBSf+oHA27zUjqvfE5ES6LJpUKUcob18DYKIHPVc0X9sefF2JFJYxioRdS7+13YzXC5ArITW+fOzZkhAd7kRmaRkAWlVG4o6PPSByn8G45JDKELJkoyWotKz9UuIt8hXwx4GS11RXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496104; c=relaxed/simple;
	bh=scD+dGiDyNpJ4sWuTvdh5EOAvP3KNqTJknwA15cdGWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AapTZWB1OR0ebjJZPKXCVNIlNdbOH69/Pb1jmRZHZM9PTo9Ec3zOpdRVCLxDJXfBk11ow5o8OgGiDX/JYVT5xuYpXBv7fUS/NzMsAGs2LSjxuSZpivB6wTx0UEgGdgSymgaH0wnZ027Zl+ttaY506Hsm2N6ouDn9+PZ1Bcu2w1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ilVR7qqq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaac465915so8815781fa.1
        for <stable@vger.kernel.org>; Tue, 04 Jun 2024 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717496101; x=1718100901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWRYHNIz7cDrSKmhye0o4WWteyziY/kqhGbKNfRqkTA=;
        b=ilVR7qqqw4oyy9MUe30PeZ29+Kn/FxBL3zgY+aKuC0AArGcKTJnySDgvw7szZ2BXY7
         JxayRp70unYY9Z9d+P1oJjtQvYJMISKubWXZNFu6YaxtKjeq+KhCzlpiuEjMuvweOk0f
         iuHr0UCV9gwxmdrXyROtUMXe6LSxjkTMinyq8vWF2/Sg/w4eX6hDvhjcH4ZaBVh3fy4X
         tVRuVvBWGcAjLFmtFmXVzEAFpaTlroLOln1dw/++u2qFbduCCDsfCFCZWMkUKfa7Nf1P
         dTE1kPi6s5bQuFu7F8PlMcbZ5I7gpgoIG2EgP+B4UIrxYUyiD4Xi8T8tiil3p6C5P3AI
         7Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717496101; x=1718100901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWRYHNIz7cDrSKmhye0o4WWteyziY/kqhGbKNfRqkTA=;
        b=QgUtaHEe9Mxck+W8yl/2uF2rwBY2gQmHO2X+kden8VqWbeaIdOMNOv57Ud746FCs/C
         EkcxRaTCWEHr78YuW7yjEdlPzEVnV/yEsPSkqn53y+hAa97cbYOAqPjOKyv67yWjjRE5
         nQrtly8qWpyv9T6hfvGWZCRS4M41P5k1pB3pv3fWj+cLIe6Ig2heF5RvHX+W3XW9922h
         N/r4FN7IpHxPvMr/QQLvVppdsNf2c1VHoprmI0sLPlT2OKS5Hu0mK4VyOIhQQfalj3tV
         xL+Eo0AWVokuUOSXZtATMILXK74rN/lOyH5MUWkhqOrdxv3xwg1/KTEGf5YmEWASNfWI
         mNAA==
X-Forwarded-Encrypted: i=1; AJvYcCVTqVLPt2b2kPbZAdqFlSIPiaaIRcJSKMK2uzGmqCDLUcys4setRZ4a9KXAhqi9G0r29oq+rtv3EfUMvjR+jZOise3O7Njk
X-Gm-Message-State: AOJu0Yw7rCtMPMEr+WUhukWG+2xMwNUe7ilMtXIHmojYcOFJpNo1NhBj
	hEcNssH7NUmfz5n4W7LMQiYDdtjeP4H0ul8nhFp1ocb7+2JbEQrEtxB0WJc+xEk=
X-Google-Smtp-Source: AGHT+IE0o5wFNFSh1APZI0tIkFTcrMwYK5v6W2l0UTCrKg+lzbv00TlNdZxY/ks2vmMyJxVzGpEvow==
X-Received: by 2002:a2e:a787:0:b0:2ea:7e51:5166 with SMTP id 38308e7fff4ca-2ea951e7dedmr90130041fa.41.1717496100610;
        Tue, 04 Jun 2024 03:15:00 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cf0bcdsm14715451fa.120.2024.06.04.03.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 03:15:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 04 Jun 2024 13:14:58 +0300
Subject: [PATCH 1/2] arm64: dts: qcom: qrb2210-rb1: switch I2C2 to i2c-gpio
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-rb12-i2c2g-pio-v1-1-f323907179d9@linaro.org>
References: <20240604-rb12-i2c2g-pio-v1-0-f323907179d9@linaro.org>
In-Reply-To: <20240604-rb12-i2c2g-pio-v1-0-f323907179d9@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=scD+dGiDyNpJ4sWuTvdh5EOAvP3KNqTJknwA15cdGWM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmXukiQWa1h2pORFoJ+ElWi699MmLRddJoQMnJ3
 TFOBZnsSZyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZl7pIgAKCRCLPIo+Aiko
 1QrjB/wNap8dDews1vQfjsdlimM1Npij8lenSbLzMrIE7o68iK+ajP1vz+qPiuuE3kk/LSqNA8F
 JB0gRaZbRRultq8kt1td3/0KqkuibuMpWfaPjc1n7Fxaqk/FMnWgasjiZddauS7O9ec87LxNIAT
 qIFHoPfJsLhXfh/zhxdDf4f0WztadbBMQXqcMOUYx5qEFMcCpm1VZbIyp2SOhwlYxZLcvpYVXyF
 1B0HdyZSwm4zCbM+IPAwemQuKP2LbepkprMcfnAhV/TIqA5xAF0pW357PFrqnWtDFVGhVKceEYK
 eXSz1BDR2Al/RRs36lcNTm26HDPrSsDgS9R4M9FU5IauiyB8
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the Qualcomm RB1 platform the I2C bus connected to the LT9611UXC
bridge under some circumstances can go into a state when all transfers
timeout. This causes both issues with fetching of EDID and with
updating of the bridge's firmware. While we are debugging the issue,
switch corresponding I2C bus to use i2c-gpio driver. While using
i2c-gpio no communication issues are observed.

This patch is asusmed to be a temporary fix, so it is implemented in a
non-intrusive manner to simply reverting it later.

Fixes: 616eda24edd4 ("arm64: dts: qcom: qrb2210-rb1: Set up HDMI")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index bb5191422660..7ab55337cdfd 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -59,6 +59,17 @@ hdmi_con: endpoint {
 		};
 	};
 
+	i2c2_gpio: i2c2-gpio {
+		compatible = "i2c-gpio";
+
+		sda-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+		scl-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		status = "disabled";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -199,7 +210,7 @@ &gpi_dma0 {
 	status = "okay";
 };
 
-&i2c2 {
+&i2c2_gpio {
 	clock-frequency = <400000>;
 	status = "okay";
 

-- 
2.39.2


