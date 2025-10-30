Return-Path: <stable+bounces-191706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB5C1F283
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 09:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB03D19C2D3F
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26FB33FE0A;
	Thu, 30 Oct 2025 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwqvokk6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59A34028E
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814277; cv=none; b=sXzvRd9Y6r5rqd+e8qT8yWkUX7axtwBzfZLvnL3PrXz/NWUzVc9R7pnFytVHOh7BaWh2dkk1EJ/5v3JsO65t64DJ6YPE01lSHitwKgn0WcxAu01h21seO5+/4rcBXeLmpZXtUeQUk/iVJsFPvBt7fBTIl4gSqitAbrjn98mcw9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814277; c=relaxed/simple;
	bh=CNLlhBwuYpBvzzRU0Iy0xfaJ7C6izC/UNkN1Iz1WyaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJHOlyE0vNn8GnNorFQc9LjK7H37w/xtxbD84QiZf9R6N/hxwW4ClqiKUd5Fc+HpGVIpmu/MzXm25aoCdrgT/ceJdh90s5ievIqH+BJRZ1kZhEdWps48EAu60Niez48CNCLjhY1QibAyxEvoErGYSCys6mLMB11bK+RBTNVpgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pwqvokk6; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d4eb89facso13490966b.0
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814272; x=1762419072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D28EfOOxWYrdaefT1gXIR0iUkSzZ7BDb5koGblp5Wl4=;
        b=pwqvokk6pQOd1rSYrof2E7/+qAq+t9W8CMH2+oxx3yL2FSgpejn6d4qDt060vx4f6w
         3lyZks/8P41I4hvJC8mv2C32ZLlJqNJK63SDB30Sbz0r+xsKZoFvD2nNJssvdASA8V4n
         m2oQg7tQFwJ8xxBlqmHO3nTKEKPEHV/OY/KA9CGQYPRlS2t0LrFBMJED4067c6i8lbAM
         Cy+tS+78kpnz8tkfMJFiCc/neeYTr/MVl/U0eO+/Z0SNVEsHtftMypgGOnoWI6HhY6bL
         cFhq0GOFdRdXFmxtZjzPj7fXPDcLi+NV+LiXalYr8+BBZYGv4K0ewXgbdSoTsHCS/vw9
         y0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814272; x=1762419072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D28EfOOxWYrdaefT1gXIR0iUkSzZ7BDb5koGblp5Wl4=;
        b=fq42Qz8+3ZG6jvqq+o9QDF86UDLbkhmXcJSwGNxb1kVi+KsjoidE5C987R8FmyL2sx
         18NVAER9pwT7loCpHkEYJU8YB/pZF59eg/qGPJ8uJk+aqSCHbsb14ipKSia/W4l/ESAx
         ZdHsL35HULty8Km68lOKmigh2dejBe7KV1PYCo4FOS0Dq4lSctk/nS8b0LiIm4e/D83q
         ofg3rdTWbgTfF85lfWeMybUKlXd1TzHZnuu+d0yA4UYu6d8btOCDFzrYJ7fBnk59E5Eg
         9ekVscY8Ld5sojvjESEL7dKiyT/U6HWPP2JP2aaWr8n2evdM6PBKlYsvJwa/P4lKs3YU
         ZIXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1AkMmgZo8Q8TlOt/0WE+KLhVRsGtW8ZTHj6YW2WOTn/qTuyFgq0GBoNVDPhkRRRTEOw4hQ6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx2dezTheCDpJSZQEvFiQBKzty8H+Mc+89Uf/tHbTvk4bHFGA8
	nePTOMiKyyinM08iygIVtS738SEQwWEKNI+EwaYiBes+dLn4OWC503hABIZ4DzxTimOfF5tPNke
	J7XxG
X-Gm-Gg: ASbGnctM51f07IbomTOOpQh9R0GwcmftKXqjlzU97pxvXipGnq+fUUM/+firqG9LMOe
	X9GRzp5hx+f8VqC8MlXuO6e3H+Uv4X/7wpsKFaNTHyWAmRU1IdwbXte/CEBiKLLw5wViEBcgQBl
	Rvwc+PJ9nRvOmJZRpreJllbMYrb+TvHvES2MQ/St0FHg5Q6KCH8xyVduTzp1VTpLuMT9p6hLjH6
	e3MlCgXSe0L3Cnv3o78/2k4Q519tub/44FccnfCvMnaSagpjnKHP42s42RJngkNoRAv9OdX8cc+
	ycNKUzJHO2wm3vAqeiaxjpGglRZ4ZBaEljNAgEgRejosv0jy65SovuPEMEyJ7nfWFKliQOdje/W
	i6Oea0/+kkIFf713VMEMSovrfsKovdnQpo/FUxHqhuTyndkFf+nEf0stJXWkuVY1Zl3nA7vjYou
	58t5NEL+RuR2xXaUe/
X-Google-Smtp-Source: AGHT+IFx4TelI+GrNXm/w2tTDA32IzJmyD7uC/kjRQlzUbLtCTfWDCgAcAVXbD7GZ4re56J7E8ocOw==
X-Received: by 2002:a17:907:3f87:b0:b41:873d:e215 with SMTP id a640c23a62f3a-b703d2b2ce8mr290352266b.1.1761814272428;
        Thu, 30 Oct 2025 01:51:12 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:49 +0100
Subject: [PATCH v2 6/9] dt-bindings: PCI: qcom,pcie-sm8350: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-6-28c1f11599fe@linaro.org>
References: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>
In-Reply-To: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=CNLlhBwuYpBvzzRU0Iy0xfaJ7C6izC/UNkN1Iz1WyaI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAyby8/J5iVMIuTmuZt6le060uzimF01oYn8Wv
 LGUVH2MNZyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm8gAKCRDBN2bmhouD
 1+/DD/48Kef+j6tupHzMNU34kgv6dutDHj8uLyepSBKdQgQcOPmwAr7eZDv388C9Oc3L4Nh50TI
 sErtby7muwDfjDnNWmYunVt6adxYTIpM0TmfVchHjz61k7ZTzeJRzw0X/4tmICke3G+zKx9FUhG
 ciQbffG8afv+t8rSDlm6asoWxuR9n2aL69tFVNsnrcXaufEQLvq+PUmUIfxYxIeuVE7X7tBEdi9
 NLumO3kPl3/Z2VvOKCTLKhLLBjuAdmsVYwbqhXuR4BsJRNxTSuqGO5pcDyV8YpDHB56zE3YB688
 RvPMnx5bwWu6ZOnkPviI/rBIrO7vNPZ/f6FRQqGOhR2dft7doy/DDFwL5/hOnvOevql7RQaXr98
 2/nanaG3loYui7huQJhD8EXYmjqRTlIicAVVfnFyCUSTP1u4kDwRpm2pRhoEa8FpWwhsaUds05k
 T/qjLVs8MhL5EwQR5/woPhfjkryaCO2IU6L8UoMpSYbpkrqyW2XqLtTzkiTMbHlALEAmwDcHGi2
 43VghVruiEVzticWXJpM6QEsMrISdhAGzzxQEog6pZt1PuedCvuxxh8ZnyTTFK23NHK8yaW3tCh
 XVGDF9swwdXAsuqr9CUlYLZae5aa+02k08DpgmSptaw4jayiiEOCklDl9NUOmxFqR3wL3K81Bj5
 IIzetD/Iv8wb2Sw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 2278b8b54773 ("dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 2278b8b54773 ("dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
index dde3079adbb3..299473af51d1 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
@@ -73,6 +73,11 @@ properties:
     items:
       - const: pci
 
+required:
+  - power-domains
+  - resets
+  - reset-names
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


