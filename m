Return-Path: <stable+bounces-191707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E387EC1F230
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 09:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992A742716B
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 08:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCADE340D81;
	Thu, 30 Oct 2025 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIIur5fC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B013734167F
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814279; cv=none; b=Esdfbeaaje9ytsFtFi+J4F28+d6Gd59WF161CtIGjrR+r8etNOl87Mcd6JyZzyr1a6Y2W+aFEOLCyWqdY4c2Nuak0S66NTFEaw004mhsS0B59027fVK7ZPXJV9gYnoldGN/BS9+y/oO8chg/cGDWEkH93xPOD6u1UqC+QhzEAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814279; c=relaxed/simple;
	bh=WMwLMFL+tUnZKu1QAiyxhOnnxjDnDcEhqj/2d3sqLgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJLPasTvcQJeJRjaHfmZoAHfcYt2nM1AaNKIOsdj/a0kK8uCaD3VNbTjnXg5n6xDi7sQrZS40C1/8DZ/nW5StGh79vdzyaPiTQd1xhEKz+emrnlQHZg0pfb6Xx4eZasfotgc5Yjfw3pdJ7hiJxbFyvrVdnWiBinYSRd+bWQo4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hIIur5fC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b404a8be3f1so14275566b.1
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814274; x=1762419074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyzuTmzeShZIW3iLAvgfvykrZphKRqiisNPS8AifF5Y=;
        b=hIIur5fC+p7B/Vs0PRAS8gKi4GM6hb3+La88ggynAp3FRIl3mFH85uwDmWi+TNI530
         FT9kr/tNIeLIsSbW4SVXJH5/HacnPIRFRJQNiV8aXP6csElB7EhuzSt2EUcH9epQ4Pzc
         EvtF15wORHrFog1/9qR+DX3SNh6XfjRIUoxYpmeUtfE3qzMUJ4JIdyVWL7DPg371csG4
         PvFPEX7t++hCMd+sd2cso4WgtBkp2T8T/vt4dxbnZVIQ/oDwFtQzR6MGwuc/CoiPRKKI
         advrGxn9MV5Y29rqfsnvnbhXhyur94OrQpee9dxbkRVX1eLEiwidqjiNJgF+Oho0pN22
         WmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814274; x=1762419074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyzuTmzeShZIW3iLAvgfvykrZphKRqiisNPS8AifF5Y=;
        b=RWp/Z0Q8d91KkqmYqfGwvKrNSnHDqgJkRxqqCKlx7pzLNqhvt2YPNjV8Z8gJfzHAwA
         QybViNEhH7KUg4jB3Mke2bhItmm/Y+EruNuTJ08CZTIIqvq17V/qYV2Qx6C27wN/dNhf
         HGU20Zw/YNwiubye+MY8srHPIXdmIx6+XqqXRpi1JV/HcHKYzLmHnmR7ney9j2cNN2zN
         5e2kU5TXYVuKOBDN/Hi4QXke9HSh8hknuI6pu349as6Ss6TiTKYPIqECCHCRAAGSAJTu
         hID89G3R6KcNHWCLTA+OhDqS3lmX0Ni7jQ/9kEEZh6HXswjPpvP9MVbmRZ0mKfb0aZPF
         kM4w==
X-Forwarded-Encrypted: i=1; AJvYcCVC8GifbmclJ41U7fVGoOnh29JlU6rESS9YR4qTBwiMntxIct4iP/3lcnCuIlMDMes7ujt/zK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwskzJ6GQWCkSGkh2oMbN7qbldWKXzMRlFfOEZEmdUOJAKI/l3F
	TyNZdknxZHx6wTeZslwjxqZcaUZVs8gbbEGH1YGARjp2eY+Jtasc/niSgpKbwYTy7Zk/XN+PSY0
	dN9e6
X-Gm-Gg: ASbGncs1ThXv2nzh6ppU+9AhL1I6zjJO7wDtuAU5RDNZcZIH0Jv6R1By73/s372vvWW
	+06vuk51B8Uru6Tm1tCTmrLzPHYYjDMA2G7p6KW83YYivuZLZwf5XJQrvUpzAT1OYkHTssOzGm5
	s6xqY67S9qH5gHS8nK0/SDVP0rmGMhpazbRICxZWHAGUUnZV4hObou9gB40ovQDTa/c5TOHzYH1
	Esgjl904+TJeJT3yDZKQMg+MRjvLLDFgxorjPBctt4HH2ChQQqXx3eYW8Tn6RlJzbtMMT/xi0eO
	X16YpAyfI/a7reb+KwE0Z5VlpVvrByDKmMc1uJrT8uKF/28hKOlV1MKAgCpksrJ/T8iJCS+8Cum
	4aYTl2h0YeA3TSeS1vfuZRlKHcjq7Sdow8AjpXxKLvEyVmZRJmb1Rr12seS+8HW8C8doSqlP90w
	Fyvv2Zh2xKaf7h8c83gD9J/WICaS4=
X-Google-Smtp-Source: AGHT+IHRAcmg+TMBIoejKF5XHwKZ503c2WXt1P+DVsIuGDH+mslSyjoJwpIsUPNBODWdIstgkLqBtQ==
X-Received: by 2002:a17:907:a088:b0:b6d:8da0:9a2a with SMTP id a640c23a62f3a-b703d2da9cdmr327320866b.1.1761814273740;
        Thu, 30 Oct 2025 01:51:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:50 +0100
Subject: [PATCH v2 7/9] dt-bindings: PCI: qcom,pcie-sm8450: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-7-28c1f11599fe@linaro.org>
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
 bh=WMwLMFL+tUnZKu1QAiyxhOnnxjDnDcEhqj/2d3sqLgg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAybzSvYFRSdwqk0IIn4vv8F/n6XPvxoeWhM/2
 vnKmJgZYwOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm8wAKCRDBN2bmhouD
 15rIEACIxNWH/qRsalqSQkGDGDsAP/edKqPEDXrAVX4obLXBeZkNLpjT6mrBSOIE/pPQ1gcDRjb
 JgTtuyKDjfnMmw0gQhKMB0mK+jDyfB+m2AsyBXj5JixkYUJFasi/p8t5HUaLKt1GcAuI8A5S3Xa
 fJm0OLv/WBlyneAv7qAc2jGs6p63AMamPNvj6EekxAgMX6u/gpcrZV9P8nePc9SxYnlsq8NJtbl
 TbX4GaRfYz36oyVW9TjB2HPnMrNQzNbRcrgN90if3OGg79bDhxg7UGIChAc2KzIKJGPWrl0ajcA
 rn4cxIcitai4wbJXUOC3FknEm7IyRiJ43eB7kz77dbwJnLu5c4gphVpTiusoBvpftpxKFzNJ3h9
 MwhId//GLg/f+wjNM9yxha6onlfdif6S7yNtQ6iWIaW6r47ug5VmY8Sl33GepYhXvRSaMLZmJl7
 C211jDLfEtXZrz4vTv3b7v6iDBpE8/wFm1NJcn8sinMISdPaK7JhQOHQQCQ8I/UEJRJdL34dFBa
 CiKWpbZqd83mU8effDVDIs08SWJBSVjI0MsO4jfc58A38aBRHEXTBNX2VTJOEzzbxZc1s89WxlE
 Ve439tuXkHE3jhugZh/aBkgzaUgX3pL1PpjUr0y67RfAA+KpdWn3QBCSWc6rMeR0Z+LjL06hnRC
 m86CFhbxLHrq/Eg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 88c9b3af4e31 ("dt-bindings: PCI: qcom,pcie-sm8450: Move SM8450 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 88c9b3af4e31 ("dt-bindings: PCI: qcom,pcie-sm8450: Move SM8450 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
index 6e0a6d8f0ed0..6a17d753122c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
@@ -77,6 +77,11 @@ properties:
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


