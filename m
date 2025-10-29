Return-Path: <stable+bounces-191645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D87DC1BE74
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 17:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B18628136
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571FE341653;
	Wed, 29 Oct 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDlcXMK3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01B33DEDF
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752464; cv=none; b=YJSaiv/qeRz8vIXV+WOUxRgKO8Vadu8di7Cs/GsSJCZDKEJnIgw/OjFhW2/LZ0KSULyQK6iMatbtnjNPiY5q6oLkvyAO5UUUFtRUDMoqLrDMUi6ZZTcZNOAL/3NtZOS96Gje0t2dykReeWEP4KpzzVaaCXDnONHLq+TE6GVibiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752464; c=relaxed/simple;
	bh=gg3q0o/WXEClcVN1pmj4q5ZbEehzsr+ZhzU5VwT5XO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Smj3AydVAqF9WRK3JWlh3yJb9GrR2P+YLiRg3kO/egUTw0oYzQGY/edR0NIAZzSllxdAz+QMpXV8HR3ZS6Ry1hJH1QCrOQylAeoQVvE9NwAV17pL5XdKjZkOEjz5NjRRfaNL7v5DTfQ9Tdou+0DxT7MPMpqf3rTw+BoZI5Sr5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pDlcXMK3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-40d0c517f90so630143f8f.0
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752461; x=1762357261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Unvd6ZqORwHj8xRj6KdIfyizf9nQeBi6nqOhdj47oms=;
        b=pDlcXMK37c48JVAOfM+Tzy9bfqQqCst38M1EaLqefEfiYgTJaD/HvMLpKv9AR+tbpK
         fpHNLiauJc5f9tOmfnRRUn8hIQGbR+lgzBqAdBUcmOgRdpF1IjHbjhXHM5RgPrUKAroK
         QtoRPWram/VBR/X1hExuYqSAhSkwkp/YPdxsjpE9jS95vcvNwllWWF2myzLtROslsR4N
         VLFKmUiRmMm0rpRFxjX5O9dh2TJrULISWOr6Zm9zlyWDwARhzgRyPj3xA2k6jgg6Z0PR
         kwn9FBQBtaEohdAmiczK3+RKOHxoxYvPnz4xeJsAXrRpzYYTDZkQ1u9FP7ZiFIskff6E
         wqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752461; x=1762357261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Unvd6ZqORwHj8xRj6KdIfyizf9nQeBi6nqOhdj47oms=;
        b=p0ocR6uwE2EMaowinFoSHfZBxYKeCX07TLWDbZR/qT+SR2SYoKXPz3VESarTdyyii3
         3Yb6fnlPxBoQfkibRpAGyZ6FzxlLhZ29yVlvsAiTAc0HATVm77+bvm9nMDwEPN55/KtW
         eZvZrukHyB6/5oCDk/Z3fv/kraJt5ajraBNy8z+0jxcZwRiJ8KzhzSInjekDSER603VX
         /emaMBJzxsVTlC/EgZxnerprc+rScIldK/GPYayV3aPznQ+qje6Xq1QrLS1FX27vg4z+
         byPta00En3N7js41/xIrMnYcEGFoL5v2VrHgtw0Wm5qSx44291ku6tVYFqZEXXpizH9D
         yIYg==
X-Forwarded-Encrypted: i=1; AJvYcCW4O0Rbm9ZnzfidbDQ9GPxQ8oJRFGZiMbsPYfD4QEer6hf+pPzhpWBSGgxSsvd+OpbZcKvpr1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrp9lAsGPaqqaWX3ShlZWwv4nXZVnJ+AcEpeXOF5yM15t4RUmf
	NyXpo7UN0GmKTqK/2U8w3HMAVPlC85ldXmoO8kogQv4Tr9pYIZqyFq9wzW9gmqHSTD4=
X-Gm-Gg: ASbGnctxvK2/tI0imFXPc3BwJfsU2Q9zcvvFTaqBl3Noov+c5vAT5/lk8uILJTHToqE
	DmQo/kWtOoqi4JAcqTku13L5Ezo/IvTalhp79HTkk3ewgM+41ysE2pPTyjgZMHHn1rXmLtSKcGz
	s/vcdwh5O2DLVfNEd5kgv7LEBXAfNmrtCLFAhGD+o9ne6ZUl/zZuS+NFayYpzLCQVlk/8LA1zcq
	E6iwMIWa+A/08SqDgkzDZfy1m/CtCEMlfAMH/NysN8YeJ36yRbBUoZ0rwI+Sm5Tiy5dPmLzCP+H
	cyONIpg0xsRvTt54Ea6FjycYbcHpUmm0xiLnAQcWWAQCROnszvlPN6Gh1c0A++S753S/HTS1f+b
	Fqot3oOkw6b2uiT0KZaDk6naHnFEDCNUe5Ian+eiMFKZzXvUGu9+ECWYjRAmOS/fe5ZHlLszJ8L
	cg6jEIFAKcX9hqSJDX
X-Google-Smtp-Source: AGHT+IHPRSkNKh8UTSCquSYHU+ryiQh0IUQEPrOt3eFcqubId9xEJVdpihA/qY7Z6iymfz+tTp29oA==
X-Received: by 2002:a05:6000:1446:b0:427:529:5e48 with SMTP id ffacd0b85a97d-429aefb1366mr1638664f8f.5.1761752461185;
        Wed, 29 Oct 2025 08:41:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:41:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:40 +0100
Subject: [PATCH 3/9] dt-bindings: PCI: qcom,pcie-sc8280xp: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-3-da7ac2c477f4@linaro.org>
References: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
In-Reply-To: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gg3q0o/WXEClcVN1pmj4q5ZbEehzsr+ZhzU5VwT5XO4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWBhNMxrFdUkWBpBDmSXSET5t7bmT9rgM7Ts
 10CG58cmXGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1gQAKCRDBN2bmhouD
 1+klEACLorNk91cdSBxZPpSrA/EF4/gQZHhVVXpMDUJLwmgru6/G7eg6x8LC7Ajc+mx/1ABkjgU
 TarRKOx4xLz9IgQDmCHJvggAFdRVptXxSHq8/zPBxM6Me9pxH15t275G+mjC926LIcOZf8/VyaO
 ofDVmH5cnoKQXOZRHKq+vhsdwaio5VybcWpX5VFLzwfNiCRyNgz1ED8u94+TeUB6MOPA0188Svr
 ClFLcPDrzeE6NCSTRj+H4TS35EHu2Xlx24USqFTvue62ZyJkwr2yvyn4eFBSJF7ugIZB8tmGQOq
 s0t+MLEhlHxVjk9qBg69/ZEVRDkSWYdL+iL+4l1jKyqKeUswC2lWHaS24aGs/VyLGbalGnWjejE
 J4aI4pcxAuAp7pmBkeifowiW/uRiunV/bewx4pRWHTzPzjrKEgnzFRZiEqCEWkINS3dOL7oZTB3
 7yHq+TpXYt/3uzH1n8M7+TIgyk9ZRqWaBMEPclG0Zz/3Sm0HDVlcV6iEo9Y1PKlxqSNZl6oPTJx
 rkKMFdvedfFurc1GLukgGcg50otNYQ25JQK+hdhcKOw6OGulYOj8sya+wLVoDlJeCRrQ2xzwDSf
 e4hx6xfFCjwzBqwb/bVchqG+XnEE+bN2nhrd44bo/L3Pi/1GvhGXuW4ibJE1ycMoNpBRZbjv+wq
 Gv5Ct7DlRLw8KFw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit c007a5505504 ("dt-bindings: PCI: qcom,pcie-sc8280xp: Move
SC8280XP to dedicated schema") move the device schema to separate file,
but it missed a "if:not:...then:" clause in the original binding which
was requiring power-domains for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: c007a5505504 ("dt-bindings: PCI: qcom,pcie-sc8280xp: Move SC8280XP to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
index 15ba2385eb73..29f9a412c5ea 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
@@ -61,6 +61,7 @@ properties:
 required:
   - interconnects
   - interconnect-names
+  - power-domains
 
 allOf:
   - $ref: qcom,pcie-common.yaml#

-- 
2.48.1


