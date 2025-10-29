Return-Path: <stable+bounces-191647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF3C1C34B
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 17:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1431E642BF8
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D5834678A;
	Wed, 29 Oct 2025 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEXx2Iv7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584D343D6D
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752467; cv=none; b=h5qarICLF6p0c1SIgZcD7XtkvEp0nzIG51BqaVln7tHZIn/G2AjzwYVXzWbiwGg1QrQIiAsOVABX1Jiy2AAYqZXB/yeXWCdxGVvrD4gad7z53ULVce1MiP5DnRknMX3CnxsZ6ll1ehCmYrdfUphVpGHYSTTs8GLPmTej99288/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752467; c=relaxed/simple;
	bh=jcD/muh/yg3HFerxyFZxTqkuolBzxrZADlEk8jQbDjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7HEHQytapfTIgpNLY2lOjv3TA8Odh56x5CJx3uLUXKlu2c7KTwvUO4GazBX5zDOeOr2opIR4wDr6TiwEPxY2UaEfmrcHZUQLzjZMIULHXSKoLxHhpT3k3Yv8thdnpXo7ZlBKzFKePDapEnuQgMJ5dqIxdJnUQHQ7NqBC/HCiag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CEXx2Iv7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47103531eeeso3531245e9.1
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752464; x=1762357264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB4XYlUY2JZQ36hrOiaGPtBE9KxSOxOkBTNgx+iHCVg=;
        b=CEXx2Iv7dLxz/Adf0kZlWhXsl9klwAKaYYcCA2TXyTnO9SYTQupcnYVoe1I5bngy6t
         KI4KlzKshBUr4tGptunz0Bb3G7avRHiH6OINZ2WF+iS4jei8P16Kqke2OQhlqMa6H0Kn
         KS3VDc35pRA6QnYzH8OHmbGHphQsRSbq92sGNdhQdZO35m8MYO02RzzSUcVdNP6M+AEU
         h3x96OUrZzt9ftR7vhGmmfMBN9T4OzL5sWeingZG7ZFtfC9Z+VxBDoIEE7RDHWWCXiKQ
         xYBZNpA604RjM1JWJC5U5YJL3h3uNAq0/G8pDuXedk6q57ByLD73/u+Wp3J5VXudb2td
         w13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752464; x=1762357264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IB4XYlUY2JZQ36hrOiaGPtBE9KxSOxOkBTNgx+iHCVg=;
        b=JJA6rxeDJKHc+s31pNxrTPDjDqUbByS3O3GOXvjeqlY8ofqxkSHW2iEMFr3eR/6Mik
         DIVll7Of+xffSGsxqsuuQ6K0tN4joIeUV1VAnQ61v+j9hN2rba0JKkgZfwkTuolAhEhn
         FXnt51mQtur5FvVml4O/TTm+ml6Jwpa1R+rbXssQ8GJ8e/mxxPWSLxS7rtMoSgKRvHx3
         kdJ2Qp2qwhisZ6hChjiqjQqsaBjLfU56Qkc/5WX3+i0pOuc8CO2rNoeG9n+M3MeT5QRT
         kJEr35d6Anj7y6VPklF2gEgSPKtQ2mesbJpHWygiavn8V6W7ldg3pSOUOeHH0SW/wQ0m
         x0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWo5NY61u/+QRuWGV01xZYRU0vfKr3SYuSytHopCMAg9LcI7aNMEdvT897qrmw2c6eXUXljM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+5M4GtFdt/eII71EEoJfVWx3XSDPkXQNoJ1Egda+tiHlhn2gY
	ZE+HZV3FKzUWEaUPlHn0KQ9QzBd63SC1DMRe5UzJld9XSUCEbOKJvLcEhhAN7pV+HEk=
X-Gm-Gg: ASbGncu9j0nDl84AnXgJ0bSb4ruRbPunA+t4TAjUhcpRqajBuzqYPOTVf5RRhCJV/HJ
	hex8psIai/urDiG7vKbqXETlkBEdGGuHGTvmFy4Tea/80uWzZegyTFXTrRImu73VU2sWT+o6nMq
	fC9S4zYbYo17N++HuHxcFsGjrl4K7smnEpwQBp6WjD/KkY9yngRxAfD53w/6Bn1WQyp5lpm8ZtO
	7n5fB+DicwtdjQ/f5kRU2KQz0z4pcTSRHqQD+kRVl7mY1JWy9zlxx1XrsiEEva0f+nIohWvuFCR
	P08rGKMaD10tqVnMObvn9hy9t9SlDsiR78D++qe61BSm+A0u/Btbqq0R6rYV+kPNym21esUndSA
	QjzP+qLi0lo2Bfz7bjbjhA8dnpplFiPxpwbk9kFbZo52eYdy9UPOCWjrk1byaTHfb9dgljkRnn9
	0IPBF5t8tY00Tw60lr
X-Google-Smtp-Source: AGHT+IG9DjbF0EUlFUTGru5YaWEbzqZRQ5rKxmL+Dczniu/qZ8YVLMUMQrhXAGjSZsPLoQbulsBrFg==
X-Received: by 2002:a05:600c:4ecf:b0:471:152a:e574 with SMTP id 5b1f17b1804b1-4771e16e538mr17553815e9.2.1761752463973;
        Wed, 29 Oct 2025 08:41:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:41:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:42 +0100
Subject: [PATCH 5/9] dt-bindings: PCI: qcom,pcie-sm8250: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-5-da7ac2c477f4@linaro.org>
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
 bh=jcD/muh/yg3HFerxyFZxTqkuolBzxrZADlEk8jQbDjE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWCdRkgSj+crNTt0ZPf5p7k3sOTszyclpDbU
 1o3zeCn0G+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1ggAKCRDBN2bmhouD
 13d6D/9i2r5Li5azvJiuPvOaq5bhZqUycmZaxUdiWiryjuPm7d3LEylVeO0glrT3h1lLvjxc66v
 2W9bOdT5RWb69wU6RRyFm7l7/pOmNC79C/zTHVypzzUIKbV1R48cbGg0MdZGqvyjcwKNgIiwNJI
 jjUfhRCJIfG0snC5pDqO5KNYUhH0B6IpC116cuoMLto5wr9wq0ADXkkXp8nBq175ACmXY0/s7aI
 Ht4DbFEmBtNwNq59/bqWeYHw6V9R9jsmLOBXv9ted9vsuULuuIW6JvQ71EVHQR/K/SuDlElL2z4
 eahFimBL9xGOnkwhizjnYmxWTFcNz8ZUYikS64Z3IZjs/d2sq4yhOU2aVMs/IcqHNgKe2byTbiB
 kl+TUgFUH+X6Hu/CUrqf/5nx5Z4IBCo5OPTSd//JIey0eaUSyBkeZAM0eBdt0UVBKRkH4rzX5Qk
 w/u58DwGiKInGkZzIuQBIOaKLZrPyZRr8kw8zLGQ6cvgezmPyq9biYlM7s3I81qEsx3YKcjN3Tv
 FA1Q4eCrJHNR0aPL2j5P+XdbUDyNUQXh45ngocNiXvkreTV5t4vm8BNYGBGS/aGrMEpnl6lBLI4
 JgF+IsBygKmMunPMjGg2z0SfP+wQSdzePL4iQEQbvVa0DYqZh3aFLRouuDyYXMl4PNkrDz2m1pQ
 THb2JVzFbi89lEQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 4891b66185c1 ("dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 4891b66185c1 ("dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
index af4dae68d508..2ad538019998 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
@@ -83,6 +83,9 @@ properties:
     items:
       - const: pci
 
+required:
+  - power-domains
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


