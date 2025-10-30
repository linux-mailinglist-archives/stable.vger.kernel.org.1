Return-Path: <stable+bounces-191703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB2DC1F26B
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 09:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F074718990A0
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 08:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389D3339B58;
	Thu, 30 Oct 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8MAx9Sg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E633CE95
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814272; cv=none; b=Vsjp2tQuX19Aa0ExeSdAgo950TErwB9V3Wo7AG2Ij9VML9gRhupG+8goQFYjioKVoqoACHxe3iC29/Mlhar+AvtpAcx5smhYg3+m0hYVqDumYrLgvos1vLhIrSQsjZXNd1t45RiQXYXuiV93yB9rM+w1R2L494HOQ6nvTCrPZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814272; c=relaxed/simple;
	bh=UnjXcV99SvWkoomQOs3r0Y0I0AunpUUaV5PFC6B7+o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifuoE11Vciblz+sO2RASq9EM8Osr2VgS/jvUhoXC3S45ooOZTff8NG6tJUWkadi8ruyCQYXpb78ktYHU4DpLfxpxEiTH/nSspJ4gHpH8c6J7uEzkgZSuGHtQPvLZGFMFrtrqRG2wkSJLEZo2AitID1eodFpCf/OC6MvN3h7VhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h8MAx9Sg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3df81b1486so14163166b.2
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814268; x=1762419068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/swht44pfZHk2nX88R5C4csGgGV80gpv8aGt6ox/pU=;
        b=h8MAx9SgtWI90FcqVZj6WiFivagLNTbeIcW4BN/6C/scYBLnXIGAXiEXryUTIfRrrJ
         eMOF6bGvv3tdFPhVzu3IS3ZDAB/GCmdiAu+z1khevGWPKjphnvaDpsNZWksyBXT9c/La
         txvokatlaphrOYZDEJx2cLFadQj41Qv3WVL73FFntZl9KrJPh/YaTjQ1sUSfKvOxImtv
         39zkjC0Vkp/Q/GX/ZeLFBbJIXKbadCKPQECh6Qw0cgRXIEkonkrLJGo78YDcfg3NEVKC
         jS6kZqB5E5BNpKruLpdPGBizV1jUXWkXAmSzlq/FqULtj6DS+ZswdEMGQSbBKUHSrZNP
         jWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814268; x=1762419068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/swht44pfZHk2nX88R5C4csGgGV80gpv8aGt6ox/pU=;
        b=mZ/x307t9x27y4dLmb8jb0tt2v76gALe/ncOICvjyxhQWZmhc9lyPq7az0JgLafUSX
         L/x319Mpt7qVLRuO11q6rlfyCB1P2woC+IvYzVMzyj0Y70bOLhIC7xjpnqFbAXDUQb1e
         ck9X2Yp2eysNxsn863RWHiOSjJ1CCwm7P90RISXtBx7u0u5RHdw65Icvq+9SBblCNHT0
         euYEoePZB91cWh6jH8rVqO5+ysA8SOyQZQ+xZZ6myHqd3/WIest04L89dUiwBMrCdy4R
         1jR31CIl+UJ2njBUruh5xDo/bms6HucDX55epQvlN1EKul/OqYuEP1Q1zsBm8F/DHqYF
         pEww==
X-Forwarded-Encrypted: i=1; AJvYcCX9AiFUrGvZ4hrJXCJTm6534rVG/fRlPuQNgLTgth91n4e3bdRlxGKtQHhn9PcgPjDYkOSd+qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzglTWutMPP3wZUdpHw6SQA/NyK6CDeyBLagfErNMoxp8oEKNyH
	J/iMmMcotGo0yNIMyPwxRuIMk2tWnp2ZMTCszlzaOPFLK8/d7CpBgIiUyCS5rCQQFSIQDX//tHa
	hsrY5
X-Gm-Gg: ASbGnctr6gXpW63/LPLVbsJrIJOIpay1e/UL8nNBpYs0wXh8LcoyB0rn9W4kSmEE+e/
	dHmGssb6ykmmS2yFqiD+v/9F4SaQ3Srn4yIBR0oMv6sUSY5524nMpSl0A9JLR2kj1kRrxW/2FMa
	WL9smfo5BLc3Yc0HuWgxAhJY7S+rvQ88QYi0IBTG56Lj1N9f6alK6pKHsXbr5P9KGHSfDpyjtII
	5Wqx3JikacWMIe//z3giR34SlvPTyUMU7h11/uZOttl1mPj4R+dvVn/sW+mdpkp54lemGgzzv7d
	zyh9NUV57uVeUG0L+02TeiqWaUIJyy1TFjAUtG8jQENhRTHiWsMEv/y6/QyRbQvPz9Fh81p42oO
	9Insb/vUvSdxdDMuCYohL+gSXJKYlywDA29iKipOm/9eu3b9rI2wsczprhEyUhVRjMyifF8TAa0
	s1kcHBj2MCu1XrDUog09rFaNtCtys=
X-Google-Smtp-Source: AGHT+IH4Xpg+Im3DojMugmh1k4WQg6GSGitSimjc0UjEvJ67YG1OYfvfJB1hyyAWNNTXg3FuP1igOw==
X-Received: by 2002:a17:907:1c1a:b0:b29:8743:81ef with SMTP id a640c23a62f3a-b703d062d24mr328347066b.0.1761814267999;
        Thu, 30 Oct 2025 01:51:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 30 Oct 2025 09:50:46 +0100
Subject: [PATCH v2 3/9] dt-bindings: PCI: qcom,pcie-sc8280xp: Add missing
 required power-domains and resets
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-3-28c1f11599fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=UnjXcV99SvWkoomQOs3r0Y0I0AunpUUaV5PFC6B7+o0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAybwOMIy5w7bVl5laC1F4cjGoJzeCUfsuy9MV
 e27p5XJXNqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm8AAKCRDBN2bmhouD
 14njEACEAza30Q1dP29Vs6Eqa9pYTbA+URJVy6miVBTSavZAWXhlnPMMd9kpAP8wWwFsAnOShld
 on3rTD4/3IsP9vcg8vTYTS4TPbhNOLAOhdiBNx9Cw9Xu/keTxYG0wD3SIFr59ge40KF3bCmy9Kq
 iHQ9Parl8OKVn75at+yzA81l3tj3KQmE/jwi9W86vvdh5LuSuPBFVcAuOQQxAzq57vPCV6xAgbD
 8mCQ2ev9GdlvoqHpW9fN0IPYZAGYnqN9ODdkBvHvTgJ+OQKMDhEj3lRK6R45lTMT2XUKRheS0Y1
 0ylazyYeY2z3U+bu20ecS1zRB8cu6VpGnsGFAKn2TCcr5GVYEgorUItdfVeGh6umBpTEsLszu7g
 FAtBsYXk0u/Wc751GoXJMQFXsleMwDVoO4Sieodja+ktfIw38a6sxP5Ri8j4rdykDu2ca3OojEZ
 6mK68gvYsI6nhAa9siz25yReo7wAc5kCPPPeGxy8qGmHV2qfzHfEYsNJFndnoarD/B5+t4YWzbV
 beiULSkopGYdfofLXTdtZa7h+l5g3n+cO/P6EunojWpqKP1rTsWPstWXJslxIinRZM2msroFKS+
 jhojr/TNW/F29S0G0j7MAIEhIrOcGo9mvZlMw/dFgomgf7DVNLyzdEjRp3bE/BE6rw9PYeNRtiC
 RkP5/pc6FWZLBYA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit c007a5505504 ("dt-bindings: PCI: qcom,pcie-sc8280xp: Move
SC8280XP to dedicated schema") move the device schema to separate file,
but it missed a "if:not:...then:" clause in the original binding which
was requiring power-domains and resets for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: c007a5505504 ("dt-bindings: PCI: qcom,pcie-sc8280xp: Move SC8280XP to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
index 15ba2385eb73..b6fb0e37cec5 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
@@ -61,6 +61,9 @@ properties:
 required:
   - interconnects
   - interconnect-names
+  - power-domains
+  - resets
+  - reset-names
 
 allOf:
   - $ref: qcom,pcie-common.yaml#

-- 
2.48.1


