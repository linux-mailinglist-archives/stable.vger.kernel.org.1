Return-Path: <stable+bounces-191702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9773C1F257
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 09:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19A3189329D
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF29233DEC8;
	Thu, 30 Oct 2025 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8TodJvF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0D33375C
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814270; cv=none; b=Gp7s/myi7MXLcqr4S+h9TOsvlsZ+0roFQix/vnMg/5oCZlaX5KZO4LqFjc3NiD4Vw1rBcC2BdOTIqS63AE435hZ1F3myfszNmHSuSgnW9dME4bur/TA53AzqEDOhYJMnbwOS2cI4nYpOiS+2YiKv9x4AI7KdCMeTvcqBC4SYo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814270; c=relaxed/simple;
	bh=rpjdsC8YDAR4ce9DkX3G6WOQjqex1hTpcjV1pmb+6FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BySr4IMdwE5CS2sj2RPHxZ2OeK5M8QFXEKhqEUn/BgcvYo34wX7g+560zmpmU0GF6vgbGAaIF0fJLSUA1C4eCr3OULePr7t6Wbs3XW4quFQIBqtAvtiAUGxjsqO8zFA4Sp5jecjzN4I1Gm3MTNkc0k5wkiYZ7ot35PMP6by3inM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F8TodJvF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b6d535e3610so15991366b.0
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814266; x=1762419066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeZHkr4YD9H0TDPFAU8SBi/+IlGQLxtOdn7QyZP9pFg=;
        b=F8TodJvFhk5YF+XDak5Z1PaBE1hpNigfrG0zKBzTSD8Y7FYgbq+2d8FeGe2C/tzgPK
         Q45mXFBWWWXq3RmAqgZJNQVI6W9OgQmyiGvd1HlQ/XykIdOsspPK5gJmDEnNvaMirS2E
         yGLptMPadfz+2c3BJWS+VVJFmtpLEBJoLfwuj7dZZBeQ7FCgq4A/o9cmbzI9veRgKfJ8
         zqSMoWE5gH3NXe9tflwlqBgEDyQTrba5+XBRxOOPsDTILFw7bqUZPLlW0Gn38pJ1Wr+l
         n2L8t0wopGGqkbh/oFbJZoaXYdJ/xI2fBd+yP6unpgPMM9aNyKVXxN5CPW2Xbc0hfC8T
         kEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814266; x=1762419066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeZHkr4YD9H0TDPFAU8SBi/+IlGQLxtOdn7QyZP9pFg=;
        b=M7bNsvKSFCOlfrmrM1YnS1QxLJAbZWbippBha9DQtYNrFMLTTJ5pYSUj83sM0osRoY
         0sbfe3xAKPEfRkSKdSEBVUt3AdXJujoV759eL2oYX3hFPGW7T52WYbZI2S91J/OiB8NR
         TTlZ+jIeuGgWTYKfFsiyAEdVR4QYv3i/9Ps410HJEGD3olyVBCafDcAsFoX9p282lB0p
         V8o5xBbXyX1WoN62AFNOG2ms7lXrJX66CatfRpVdT9RgfE2M48DzYaAZWOqI9cvGhwSu
         GZTlCL+UqIJF8KkUivTkhN5CA6xDTJ9QKNjw4I2d6N25XL2e58S98RH/AvFFtsNPshYJ
         xuNg==
X-Forwarded-Encrypted: i=1; AJvYcCVUyDRxToLfL4iLYG38LEX5ZfeFq0rwC0dNmURZ0xSt/9K99rXcz/lnO5DRSAbCrgrERLoMXXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnT9Hm69KyUij+yVSHu4IAvTtu/Skt8TAlCpjqC+Fn5wzUJud
	+pJ95jND/nU7Ui/sg40OGUaBK+noHD4Vya0ipGukilnvo0SHE2h4+kpeJHGSOlDTRiaNDwuPfK8
	Nho6q
X-Gm-Gg: ASbGncvV3OdW4WGPZV+GPxHUgim9xacxilRn46iKUuuATxlAWDjZcxHzrFSTJ0jfplt
	dtg6eGo32Kj8KDRm3kPvWS7L1KXazoRdKCBQKf761XdAcycJz4a4UFOXzwpowLrvrbEwuyYE9o4
	7f7i30GRHwaGYOzMVMjFgVFZS3bxpTSIh0coqRP/VKDMZ369LcAR8DAE6OdqeUpasdqIOx/CZob
	wPKXqwksjha9EMCGUxFgLZnv6jzpLr/s2POwPQZp2Xh7jRwiKfeIJde6OhYtH7xDOZWd1WZwiMl
	ttk0Er72Y9Jmp72NucoJ9hBVwCxEJCfDxMeWtLsOvCz7gh+28FHPxAarfaXTpdep7b6rZEzbFeE
	vU42hEJSvjZu/kxmOKuohnyhr16jvri28B4g4VDzgSbIz1jTi+xacKU8TvYzCMrz8S3440TTF0J
	QPAr2QAVdZ+NZtBCpM
X-Google-Smtp-Source: AGHT+IGa2ZrCMJ941md/YaGSeVQ3cz4WZFg2TaBoGEFTfFX7GrykK6ynC7BBGxsj4Kqgr42s5r1Irg==
X-Received: by 2002:a17:907:7255:b0:b46:b8a9:ea6 with SMTP id a640c23a62f3a-b703d568818mr370592666b.9.1761814266546;
        Thu, 30 Oct 2025 01:51:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:45 +0100
Subject: [PATCH v2 2/9] dt-bindings: PCI: qcom,pcie-sc7280: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-2-28c1f11599fe@linaro.org>
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
 bh=rpjdsC8YDAR4ce9DkX3G6WOQjqex1hTpcjV1pmb+6FQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAybvXntta9FsaICcpfmprRUQ8u2uaIde10GCc
 2STDIF0KwmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm7wAKCRDBN2bmhouD
 1xNYD/46QXqnYkaIGSMZZXc3CCIa5r8QA8x6uVCG8deex5AnM0Cv6cpu8/OLgT6PqgPjYdUpLIx
 j8LQodj1MeEEMOjmqZrIfAVq9/onEuPEfSGZMni7Ltf8uw82Wt4rqF11IHXiBg7hScSAop2VXIp
 8Tp8+8vacfoDLLdJ1iXu2dgZo/tjQW1IECcIBUSMd0lNsuH9TEnqrazOk/ZikVV5tOtnbVMdIwJ
 AM4rxtHheqEnH4Z1cXc8f5aivkuMOQ8JKwHvAMTOkh/QBoTiAV89LbkHyhZcPOvpwgAc08tA6L3
 MZxYoI2SEfhrJcX9ZfrElJxXpGeAavzw64nZji8uKYJAZm+4gZ7SpFjC1FsNhR+Hm2l1zausrYd
 MZmkPsRYjm7DfDGKa0/7rHhgcf9yemb5G0aQNd6ILASUDyeKWye/Te1/dGdVpJS0qx3gNuog5Er
 rtpsjVLum+hMgKJEL/rJTDsYLQWXjSwEtNlDbvVTSK/OOAkK5BP933vqZ34xFOz+xgcD5MNy+88
 wcnRGFsM1cT8lcFeDAbUPBG9FLGqKeg8nSo0vMMlD5jD+XTdiSISPeDcLUpCv8mVA6jhYyFuQOT
 9s38CAF9I04uf0KUzEUttomHR/5dJmu0X5GZN4iSZVTPfOYIjakMCgzsjJzsF395tQ50w9IMUmD
 u0VKS/Tz9oi7ViA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
index 4d0a91556603..f760807b5feb 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
@@ -76,6 +76,11 @@ properties:
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


