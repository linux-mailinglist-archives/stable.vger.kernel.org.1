Return-Path: <stable+bounces-191704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF0DC1F1DF
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 09:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 416D14E9FD6
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F25931E0F7;
	Thu, 30 Oct 2025 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LskEaLen"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522AD33F387
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814275; cv=none; b=qJkSwOzoMQ15VGCDYlI6vmt0+9irUhdtRdn2xb0cYTI1y0EcFqqwMMwH5eB5fZ57iL7+SMzzrvXchk8LleNjBCMYnkLBpIUvCezCcxd9qN4p6TZobDBVF9SM8AoWVwV63KKES6Y5xGVEprjkjrAMK6wSYc2vU2ZYBvdTM/9CnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814275; c=relaxed/simple;
	bh=7Dm1cKJIxCD/PBcbNfHJdeVdCA4kz8qIU6RUWVYBUeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHriKaNvBa/wJHZpvtjOt4ex7hDwJtzJ4NFwNhcdavw6rE0Au1/ootIhHuMc//28Nb13rLmTmWgmkc3CSW62W3RdSFuUXcl6717c24ecbzPXpZD928AFGmyGqM3um59xjndCU28VVnWIAGvMNbiyTjbo0g8YtNJc+b2QeycAK5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LskEaLen; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b6d5f323fbcso16784566b.1
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814270; x=1762419070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGHA5HRjs4Btsu0mCkOEE3FkhLAuwhnBzyAkRkBijfk=;
        b=LskEaLenQUr71oE/pAxyg2eIBeJIJXICRFgrv5+zdoJoxVpBDFKY9djm5hZAcxEcpD
         6P2sPrrkIVo8KqgB8ISPixNXtN3zU7icqK/r6YxkaOwgurFSFvHl49LxDKb60nB6jgpm
         5DaHtbI5UtdPos10t1uhECy6dhIVa4mMvzCVdtHC6qeTASBUeDFI0c+tMB51UCYgmxNX
         SJxMtb7ZkCYLjGypoVnbaE5VcERM7xi8hjsqFtPA707ukRA8An8xN+9TADONiTZywImp
         XcpN1QutqsuWeVkWcKgPuoSTWCKQezp5KMSfra94Fj/azD4pcrQdD1LFmzT4R288I75Y
         k9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814270; x=1762419070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGHA5HRjs4Btsu0mCkOEE3FkhLAuwhnBzyAkRkBijfk=;
        b=Whl0Vtu69R6tyzqbwkqOvLfa8WJ6H+A2ssI+C8RUIxNaXuH3D3Fu8Co7/kZKnFobuB
         CP/mJF1a1MTrurxfEfMMAs9EuX9r24wK9DThugdPDmmOBBtHjFUKpThVaDdTywdndqCy
         GU7pIMUg3zspJJT8Nys545RFyC1rupoq7ccKpbx9RTe2HY946YW2m1C2G3vMOjhdrsF+
         WfLji2nc7ZeYJuZIuL5jfHxHLz4s/dwAlYpsi3sByzbNH8HJ2W1XoXVYDBT/NAQTZWYY
         2tyVkj3KcuMcEFg1ngpf8LGH5J0gPXT64tJJ1YxQeDdeKeHN6WchmTSqbWiC7ZPQtPq4
         dPUg==
X-Forwarded-Encrypted: i=1; AJvYcCUp/KQIXIE7l5NH+NshVdiUg7xbbi8mhO79LDxfwrE7INjSrNROxIFWIN+kPirjBIPUVr7/h0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSPYMWp604tl4JS0BGthdI5x5DbVvbaD/qR8VkzFkpiYNfikj
	iCVxxJHCXcpJ7NPXWYZT6EYJNyjvx2MtzbLQt3U2mC+5DLm8zP55A7kvHt1iV/PmuY/uP8YtIeq
	I/93V
X-Gm-Gg: ASbGncvDUEv2G0j6ZMi3qJkmc8C4RObky4Spq+VePjo9CKiSiM+FwPzvV9HcJUptuSe
	1TB+Env2SPGm7Vil6Z8pHkpOUOlsbU6cEdB06aLe5G2gunFF1vbK3Hlq9zaQyusaibRGiO4tDiT
	BOLF0dtkSHXJxEtMnWv127dnVQNKqItiIk77mp7oFOtmLnW48286S/NajD4/zYn+scA5KfI7NNC
	fFxXzRVE578X6ilgY2j6SNPZXNQmQ7fqFMjiqaxMhtiU7nNYQd76zG4GbEPMRXszz79/gmyy2pE
	14Sw7SOTRsxT6JUZk7XwaxQW6JTnpXml4akiCc+k13N2XYsms0EyHvyvvfoi9lPa7vBxnnshQGr
	cH6NkSjZPvu/E2JjziDGlI36mVZR42gEptLN08+z+35IPdICPyo14+UpZ2orj8WmiF3o6viCdpM
	XSjz6lAiyyvCbpy7R2vNjTmR1ZQmA=
X-Google-Smtp-Source: AGHT+IH/mWz4gaa43V4G0cLGkKq4gXdzHfDKioNJx2ktWDSidm7FFl89ySot8I+Qn9jHh97wmOXpzw==
X-Received: by 2002:a17:906:7947:b0:b6d:6d44:d255 with SMTP id a640c23a62f3a-b703d2c6e4bmr378066566b.1.1761814269434;
        Thu, 30 Oct 2025 01:51:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:47 +0100
Subject: [PATCH v2 4/9] dt-bindings: PCI: qcom,pcie-sm8150: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-4-28c1f11599fe@linaro.org>
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
 bh=7Dm1cKJIxCD/PBcbNfHJdeVdCA4kz8qIU6RUWVYBUeE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAybwIxU4aL729+DPoEzPQca7M7DtoSMVu4Fqa
 NrAKeo5OfOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm8AAKCRDBN2bmhouD
 15H3D/9drszJ1UWA+Vdu3l7QRe1xSGR4muez4M4jyPfT0Yv27pT9BfhQWdOAZYN/6QhgUq25rAu
 WbrTsdgq9yks8ef6W4h21oC8S/ul4nEecWjtCBAEllIyK8Jxih2P25XXi+1tvAGo++fczy7HjEb
 +sDTzjfj6V6RoU32ZAhPUVBq+depD5CJ7nZIY+mg1ZzkwOHcWmVZgcS6d8zDZD7oKW1hGSLtiyZ
 AioejUePVauqySfOpepPEqTe8XovBws4kyD29Zq0/Tw7qDmN2H4JD6tMDWe80SQx0tJG7K/sXpp
 mf6RRpwqh1/xFv3sdFjBKaUWttYVrcSmE0ewcGJMXDKaLfZynomh9wk2oeGhkPaAwvm4wbTsq6Y
 dZ7RLYTTqWYY1Dtb3jfw4HkM9ZoOn1vvGHIVRWlB3db2I5ZoI8t2IFJXpTYfeZ0vz0BKuxo4Ux0
 a+crlci/mQ3sLxlX0bO9R8B8HEm8tQdACckHMrtRcBhraM7yCZu3zVsfwQbtYldEdmySUkOAqfc
 3m+3ibYng8lbui9ZN+o9zdhwwv5CgoirBpf95FkDW+EDNhreXnKl7+zTzc5DX4skdYB7vveU7b2
 D61rRP7tRFNJDrUHeBoEhhO9zeF/y0CDigralwqkcx9poY25ndzPWmZMgNtPXwr5Ipt2+WuvhA2
 W89Q4QIsbhmODPg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 51bc04d5b49d ("dt-bindings: PCI: qcom,pcie-sm8150: Move SM8150 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 51bc04d5b49d ("dt-bindings: PCI: qcom,pcie-sm8150: Move SM8150 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
index 26b247a41785..17c0d58af37c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
@@ -74,6 +74,11 @@ properties:
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


