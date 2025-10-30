Return-Path: <stable+bounces-191708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747B7C1F28C
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 09:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE7319C6FDA
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 08:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B015339B47;
	Thu, 30 Oct 2025 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugu+Torb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF9933F8B4
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814279; cv=none; b=NGADjBWEKoxJC3rjTlQtChpKdTQFj28QeUruAq8KChFojuUjXbALrVD9+cuqdTQmQQ8P/qaOc2fd1iNK2X69RZMa3jRBugf28A0DhfAPX9MGemuscZyT+bJLBKWn4vXExuJgsH1aGjiVkGBf1/eXac+KbM0g5ZbBNy/JPKWCm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814279; c=relaxed/simple;
	bh=1ZQHY6JpkRKcQKK9PJI2DS8+9+Ft5mGT/4HkAsIsEZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gFV8io5CmopJ6ifsD+8SyGnoFGVH12gWJKbcYNjhyfhaGHG9oXvw+gHyYx7kqyxT0wsAOYrGaR8OPSJOLGzEeyzujiARV6PHWIl06NSk9kOMFvAQ0G6odC1dOLRE5dkv6YDmgS3TUePIlN4OOnReIHWz7KkhEd9QhakfpRijCXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ugu+Torb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6dc4bba386so14038266b.3
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814275; x=1762419075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvmpSsd6jI6Q+bHe8qcAmRmuD83LAnf77r0YzUltAZc=;
        b=ugu+TorbS56RxB3B0ENr8Yi50yXFiOYbfNF4/k4qVdIXf/TZNxXu6mLSCyqUo1TL5/
         YpPDktSoMgvE68pFuYt3ObzRnaIbjMhFSsRbzHiBnHz5q3QYudtnPdvGLU7zMoZgp4wR
         HqzQNaGOvam6i08lIidqZnwr8cuyYMJeptrVMyeI7sC7vHQBw8Cdjp0vBaBwroIaPTt+
         KMbUHH+NHjrMj6qVYIubqmaVe9SJUxGlo5ZhU4DLb1umCpxyitcTMDg73vSA21ByFpkc
         ZHhdqSzd0TQmllT63ocAOL3LN8+ee9JDCfRLUoQpZw8SLDwwPaszD3lXynwNJuitw41I
         83/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814275; x=1762419075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvmpSsd6jI6Q+bHe8qcAmRmuD83LAnf77r0YzUltAZc=;
        b=VXcmD0Xq7wZXMUmZgTmTp+kAu0Ti3rcVYDRBdPw4OwzoKlGCZ8CxEHAPbQqq5xv+o/
         CebaTvAz/XUrQVBwUo3NqOKFXt5cvYl4D71EbeiIlHjjZcGTEkkq2XCvE28boZDuz5Rw
         EOG/k1yet37jDv4ls9lwFkHl1b2Jh5B8meL9X+i3DStARgebkPj2Zw34MiwCwf7kVxZI
         FmdtGDo2oBPnXlfhyKdb3gzqssZAdkgncLRdhuUZcr0uOXmHD6nxkKdcfXBrhbnY9K1n
         YPkg4BLah9ypiqwXefuR4KF+4nlMyPgqgishferxktnad8UM778KSaKLLFdXbIPBF+JF
         7Vjg==
X-Forwarded-Encrypted: i=1; AJvYcCXJDav9n0hc8sjrX648zVSkuya1Qqo3lm9KYSDtBpEpNXb2jdaDDajhtqzLWgwB3gBRlW0akvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRYwyjnucZ95gf5wJfzVWShQd63Ro+JkxtbU+osklOZeF4Od/
	1F+AK4fKY9ClMUDpeqQoT1umPyXN1gxvIw42C42NWpHpdDVTlEz/ON3c4+31lzJ2UGfarwEXbYp
	ZeeJ2
X-Gm-Gg: ASbGnct5AZE1pRCi7h59qbAW1mppXorjGubNfwhU6wUmhecitPpN5xh8Fz7ZOdmkixD
	EUNAS5CJnr3kNm2H7TZUoCrnBnMkWwhs3hd65mWvkJ4zNYP++MsAxtD2uKFovS5O2PPSf6PYyDV
	q0uWJpHGxVGJJyKski8Po/y2O1WEtjyBB/rcYIGhPubKFCz4D95HHJhDfh84f7vEAO9to4E5GQ+
	c4EhEV5wJrDlu9zJwHdw5XaadQdV5nMd/C899y7pPc3u8vVD8oWp0tvLYERR7Hq2G1HF+lInxJ7
	OUtV/4Qam4IEjKWpHaQILRDCKfq2NOXBkJfdv2MOEYSZ81v1VBuX6jWOUuo/oqgYq0949ofpa7W
	FjVqg2zFbDtzUbI0PpHt84yL5IODN2uhnSyLZu18KSIVa/n2mBz/2Wwk7rExekwDYATeTWyDw+X
	klrMTfYHGZkWq2krwI
X-Google-Smtp-Source: AGHT+IGEKHNzO+EkKJcRDPovudmV4d9G5gAvaY8VFzPoSod8ImQSADChmJzaBRdrRU7uDVh9y4i49Q==
X-Received: by 2002:a17:906:f58f:b0:b50:4c37:c460 with SMTP id a640c23a62f3a-b703d2c77e6mr363225866b.2.1761814275132;
        Thu, 30 Oct 2025 01:51:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:51 +0100
Subject: [PATCH v2 8/9] dt-bindings: PCI: qcom,pcie-sm8550: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-8-28c1f11599fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=1ZQHY6JpkRKcQKK9PJI2DS8+9+Ft5mGT/4HkAsIsEZM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAyb0lVcfJDTfj3ub4IRYrqA7Lt4NeMpgHPOtc
 iUTjmgU4nmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm9AAKCRDBN2bmhouD
 1xtvEACU29T2agLTiM7s4VjWS1ofBT4LPVa8T1udrbLmdGwi/F/zDI7D5TIzZuqbfeZw0l5mPP/
 1l6VgRIexo+6EXi9F2EGNCuV2bpGahqYtBqNxJR1/Y2fX3FO0kc07CZDTqcg1LgLNh/VApyFiJk
 G7Pk5PXHFfeQnUmcOOJgc2AERqq4+Xmr3T74kvFmBKFMuxg/bS3JRvtVkPiAtKQm5ra3H/6iXJd
 8V8vI6lhQRitYnOREEb3kBL4HDvdQO4aMIPwFLV9kvTyzEZWLTvCCngOjD/q+Np87gAhiZ/MuQv
 9g+y6GQnMFq+kMoT+7Kg+8liKhZaTLDVG8va9v9tsG3/jpOeEUZktFeFHIhBQTQMLiLJFyGD1ev
 L2EQNYaW8evRHHUu3OojG/m/gDHQVOViNJwBAoitGjyAPMlFhhHY9TDXbwNUSgx//QsWallsO46
 IBMRjpWchqPZWdJzP3HRalQ4LMbxZSw9MfOIdhxQfmdLoyJO/JvbtvApPDJPxSKHaA1qx+3qPHj
 Z658rPfcK7Isc9z6ztzP52R1lZRGnjVmuzUToIw3XKOu7I2PizDr05bMiY/mIRpyTwm+uWgqjYC
 RM3FLG+ICLlVDprQI78B35RYpfFlO4ZkY05JMSA6o2Hiy+94j4fx8I9bpXHM4AxI0jw8Mq51qUj
 UKt1a+eJX+q7IcQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit b8d3404058a6 ("dt-bindings: PCI: qcom,pcie-sm8550: Move SM8550 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: b8d3404058a6 ("dt-bindings: PCI: qcom,pcie-sm8550: Move SM8550 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
index 8f02a2fa6d6e..4853bc0eaea0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -84,6 +84,11 @@ properties:
       - const: pci # PCIe core reset
       - const: link_down # PCIe link down reset
 
+required:
+  - power-domains
+  - resets
+  - reset-names
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


