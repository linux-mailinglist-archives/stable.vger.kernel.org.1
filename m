Return-Path: <stable+bounces-191646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5F0C1C156
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DEA7568255
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C6634405F;
	Wed, 29 Oct 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JN/kU2zm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B92F33F39D
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752466; cv=none; b=Iqhz2V5mmeuiu0ysxnavDp0VGgtLQVE1vAz19KU+4mk+5W4PRY4WmhLVhDEaKObXTXPSENeTwLfVLfEnflPMZLICQoO7j29pmvFgBS8lPmdzy7lye/eXsodaoivWVQWnOQLLAtydp09oHZ5chn3iWfXEfHFpVfwoZAhytisIIhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752466; c=relaxed/simple;
	bh=jmZDND6HgYX8EZDdUAJP/IquD3beTYD9OCZKg3gtY5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K64DupNEjvbgbikOIgMjmunpvo4dE58X9lVUCTDW7q8vvimrarpaAoekm6iWN17ZU0etBCYqKP3G+44TLnpKtPzuoshtV1BARURGTWGdW04rSUYgMIGERuPlV+plpvN8xGW3zpwI8sheaIXfGmmKRYxXwYO6ZuNl6ZcvPcyoO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JN/kU2zm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42708097bbdso597618f8f.3
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752463; x=1762357263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxI90H/RvA6j+47WbvbjLy4lY2bQBr0L5l614wF2bwQ=;
        b=JN/kU2zmngyAwNaC869rf++Lgu1/44xjRvJXi6Io2e8ga60N5qyCmd7XCAX+xfiemc
         K8ZQA0gqk8IyplFUAGqo6nICjbTFPYov7MWLrA9n/LVVkxwHYDJ46xFttNcjbKPsDGmO
         /SjmRfOuq54Ew5hgfqoTbO0jMsmq0A1qSh+8HOT9YykykH55y9RvMl4VwqiCVCBNimGU
         XmRT7LFPEUhR0ZpN1sj4i1ojIh5NblZLKR76n2T8LuBtKrLBrC+XgKCFgrUOqoYbFafA
         IGlToGeZ9ur+uA9Otqtr62TTO2OANLh8pHAkFIOPSgx6ZATzCL9gDoMn6fGrr35Ua6Dy
         j8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752463; x=1762357263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxI90H/RvA6j+47WbvbjLy4lY2bQBr0L5l614wF2bwQ=;
        b=ILXf1yg26BUoX3HcG/WS6W959kDxYOFoL+TC2bYjPoaDX7m/TX8DeZi07z4VZCDkU9
         ztAkNGDThGHByaF+ceFpGeTrD0MM14zbAIWt1246gjQGBOMauxDOY0jbEP8nOiTfGFn/
         JJRZUR6/4LTxVkrb9SoenPI03r2Alkve8Jc2p3OgebEXnPyHwgLaXLt1xQWe8on6XfNq
         Y+ifEYiStqyiW+uvuZ/p/XYvrsmlBW2i00M+l5j3QczcQMaJceeiEZKsDNQwi+/Lp6RI
         StlaWfZRfs5ENeVa8tFO8PNRYgvoO+4ZkJxLaVpfcOzxZaGdGWye5MOak0Nsa5yONY/E
         gYYA==
X-Forwarded-Encrypted: i=1; AJvYcCWu6f7pph7n1vVGWT/430YWURT2SxcxnHVSLI/++yitErCcRALZzqw6SI3MtY2XZE/zgnWdOKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWl60hVbcO4WknwZJhVOWp8+v5U+J5YmY8BQ8/2N8bn2kCakH7
	X8RhQhvPAYBWQF4WKRRW7Iz2ZjhJtudhP+lWMyfs+QhD7kZw3J7Ri3l9FuE52Uojeso=
X-Gm-Gg: ASbGncvhTupSozCijJ0eXVlehsNFZJiNUU42QlBsZQWkDeat2EFBLXz+v6TISREuewj
	tPz5C9xx/1RXOrMHb8LeRWQCh/m1sVFcX/Q2WfTBy9xj/I2H3tw6GxE5JXc8TWP5wFxfHRJ6y/i
	fOz13kntH0kT/7M6wLFGVOXaNlg+hi61CzZ7p7Hx+oEVuEOaB12QTv1D+SvDLWXDiOH1qFOG9Ou
	u/a2gFQUgLIzZGld2tSd00mMk/CSvWPc+0PNFRbmyb4wf1mdBaemr2E0ay5cXcnJu127KGILL4g
	P8U0n2rT+NdkUuxmYkRfkMhNQzyzhGh0FQO6eivG5DhE0niuO5z5FyZlZyZC5SxH2QMBLG4FJHl
	wAyuOlqm7dTUMMd/C6kqNzvXvGykkAD9Rb7TNkloY+7vWXmebbykS8d/L7FhgxwJzOLbWoYZfof
	zROtO7Sn13elyMDgDF
X-Google-Smtp-Source: AGHT+IH0MTxj4KideKlmnNCTWGRH1FJc2DdwXawsfzS+YbdnXfbjerZ4hGirRpqlsBnBP95NVvOT1w==
X-Received: by 2002:a05:6000:2088:b0:3ee:1125:fb68 with SMTP id ffacd0b85a97d-429aef70b89mr1611585f8f.2.1761752462598;
        Wed, 29 Oct 2025 08:41:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:41:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:41 +0100
Subject: [PATCH 4/9] dt-bindings: PCI: qcom,pcie-sm8150: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-4-da7ac2c477f4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jmZDND6HgYX8EZDdUAJP/IquD3beTYD9OCZKg3gtY5U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWBmcy4XgYDlp4xPS0l52FU7QL68VmVi3wFH
 JptIegewAGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1gQAKCRDBN2bmhouD
 198pD/9wZok/UWTRqJu0zO4NrX3NW/CSMcltjXyHSXz9f1CNq4CDhov3GAq2fPqNYAwFbGZg4eg
 RmW4EAElTFoutWfp5ht3GhccOCMM5nsiQE44AhZaDeLujUn8kcnNS48fpVjnkFgnYumkvmcBeQN
 51PHrVGSPgTW26Sex0ZDJTwPt//BZ9o74QJ3Ief+fJQtN6ACsJTEIM7sewm4dJw3Y5dsNeijb92
 yjYNeQNfFD6NIb7PZFUgi1yVT0r3IBWtKYFp755iK3Agjfm/XrrHwqI3DidgoHYEs4HsHk13Xxp
 rIvGsG3SMJ5LYSavdm37X5/ENlkLpj5NjC+dmBArbBkLbjQjs7/1C9kqM6fCG/5Tc24aqb5hILX
 Av6B9bUNOaeUuR8YdSfhVtWQZy4i1venuSxvdFskZavcp//gfwW9TzODZOSu76kC7ZYRgcwaxHQ
 cnNu1+HoLlP8JvKl4i/o/U108JORS4vsPO4uXxasvgGhumQaA2c22t3KltmJ//0Sod88rwonAe/
 wd3soqsovOfNnLqFv4oTgT9TBdr2NTbuVxybhlnHRAh89YuK18KHuv4kP/UJNDOMyxvF/ZerH63
 QZpA98YSVZSkCk9mrQvkpKlXcEYhTxEaB7RhJW5TbUB5mj2Gc0zHAgO1nzBk+xy7haa7Tg0TkaT
 WXCe62oV/PbTsTg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 51bc04d5b49d ("dt-bindings: PCI: qcom,pcie-sm8150: Move SM8150 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 51bc04d5b49d ("dt-bindings: PCI: qcom,pcie-sm8150: Move SM8150 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
index 26b247a41785..ceec5baedcd8 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
@@ -74,6 +74,9 @@ properties:
     items:
       - const: pci
 
+required:
+  - power-domains
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


