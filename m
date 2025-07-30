Return-Path: <stable+bounces-165508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8119CB15FA6
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B250B547AA9
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A14D296153;
	Wed, 30 Jul 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rx6wKglh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E3B2874F1
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876031; cv=none; b=ji4DyvXOc5A5yZFMr8bywMjoF2RsFWzR5vCdzbSbapPqKSZADRSuKYd1vY+jaDkaBzVcZLp7xzHP2tsCZNiHBwk7rYdvyae77F9ZMt46PjdpeG4GeAth9Mc4L7d0zI+Dq6+VICn3SwBe/p2CFNdw8l6JVRjptdRnHN5U67OAI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876031; c=relaxed/simple;
	bh=2NokYDIrwQ5BnU+V5V62SNjLrSQQSy6xfJVad8Rvaj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a49FQ+R82jRJZepxO6gI2xYUqtGwaxfSw1bne8zFwg3ma8XGWNMPmthxzS42eTnwf+PRStDHf3SdQe/KCAcStTS0tx2hxPADUeyOV2bwK1/srePq/tqjOqH3MjVa8eKNvkm1YflELm1ePv8AOfKVZ3vRcbFGcf1HLB1WWDMUWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rx6wKglh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so71449755e9.1
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753876028; x=1754480828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jn5v3OPTVsl3N7aQ9eg+u74JOJMjyRDux5JHlURDcnw=;
        b=Rx6wKglhY0g7JZ3BS5+wWxTzB8Bk/R/KCMDBRivmOwxYtM479gKnkOQ0QIJTqNnhpQ
         A1r+b3nIPkHCLxFlnfGH7mqv8GH7l78BwXcT6oKmTlkeZdC2UY7sh/LNrYJ2VkJJXTwW
         RgYdNd+VTtbWvO0l/Z5nzuSA38hAQ5CuiEAJAOyx+vCbUv2wtJfupbrKzsDFt9R1guF5
         9MhzdHEnT1anZDC3KGB/of9xkoXgdWOt35ApBpinQ6RY/w30acXeEHSE2q+kZ4bAxQJP
         FvZ4oR6sx8fXhdz/+aqTAmmzPMmoMqDMJpdslRdotNFBKzs2gEKzZhaXy34Y0/yjXG2/
         hwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753876028; x=1754480828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jn5v3OPTVsl3N7aQ9eg+u74JOJMjyRDux5JHlURDcnw=;
        b=KDwvDCWQadPOdS1i7JATVdd532vm39uhrt1hbfAj+ItobDzx4LgIERLve0JT+gqTvO
         3w7AcowTR6f37x87acdTkTl+06PLZxgbD3im6FoJ/xAuHyTTA+fH1IbREuGqk31haRcN
         YETtsi3GpGQG7dzSQjG2SH+K3A5lklyZOoW0hn0FaRPPXhsbYjS6yLwHeVUd/HLm/2ri
         FmUx2yzPlHzSmDzCWH6+Wry+JwULjDUXz+DFe5x+9aoUf5IUAeizWJTToAg5y4rPG9TQ
         RR9JoQ1ayrPDJ5OhqueRb94WDbvUUzeoYOWOLO6ujTUS+RUbhk9M0isHm/e0HPKiilx8
         onww==
X-Forwarded-Encrypted: i=1; AJvYcCWlqs1hhsovQVK/3SvtFNMi1Id7+aW5RwOu9L2yaeHw44ZmDp61C7AsiWilAxcLtHu8pxIwBPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV5hYB338xcxdpCjjqpqb2JNZJOKUTSDb0//v4LeMg76MqU1gg
	CsTP7a2KS7xD0IguUnDQVdYbY36hfIky4yOSUKWWk2HxbvKVS3H7YQh9/udLl68bPoE=
X-Gm-Gg: ASbGncvL0LWsK7CUQ12wY54w2lxC0ujXbjNP2KmgEoZcL+jvyO0jwDRQA1C6oruIIJD
	3kkzkcIKNtOjCm7mCZCSvWvyHe12FUCrEeWFNtLXnAnrG3ooNXFVvzYEfU7I7r0uW/elwwgC1z/
	X7JLKrD5yxt0h2tVfnPfjNHTWveea7+rj2CqD43bzjfw5D3kW7kqCD5uO6/KEAMQT4Eh4i00ztC
	7DjRGRtLe0qXDjySpOktiJW9/nhG+BcnyJ1hK9eRbs8+veEeiB4PJD778tSk9GcRG4FiKzMOYnM
	gJwgCQYEC+HM7DJELaUaOzq8BitOcLg9mECV9/UdxBRIN8wvE5bJSu0Qr7UC4KrIzAMkLCyHhJs
	C+yWJwPp3zOAzYNLtMamZ
X-Google-Smtp-Source: AGHT+IHK1v3ExXZ8hWrOGdu58iya/EE9SeoaSHxiXtWaABPsvH5/R+dj3WzTNqJo0SfmAMp/DjO+gA==
X-Received: by 2002:a05:600c:3505:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-45892bc5961mr25413485e9.19.1753876027754;
        Wed, 30 Jul 2025 04:47:07 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaeeesm24503235e9.25.2025.07.30.04.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 04:47:06 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 30 Jul 2025 14:46:48 +0300
Subject: [PATCH 1/3] dt-bindings: phy: qcom-edp: Add missing clock for X
 Elite
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-phy-qcom-edp-add-missing-refclk-v1-1-6f78afeadbcf@linaro.org>
References: <20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org>
In-Reply-To: <20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=2NokYDIrwQ5BnU+V5V62SNjLrSQQSy6xfJVad8Rvaj0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBoigY0lwy32GQTK506+eiLem1WiCxhU9cw0z2R/
 O1v90rpfTiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaIoGNAAKCRAbX0TJAJUV
 VgLJD/4nCTf4Nvpw/joo2iZQElvFfsXIVP4LzsDsJAibgsIq0v9gQCxx3POJXlwnigGIIiWQqX5
 kQ2InqPl0myG95jVVX+Gam33PNJdVimTDcICVYJ4n+GtuZ1sR9B9OQiVJycGGOPceauVOC4Hcvb
 o8lkqZ93Kt4pi55sS5cN5+Kg8DVe+EYNMBhFAaDXSmM1umx76Ioio/C06nbPS9p2NYTjYNfnfJ0
 /DSDFJhn10xSWqFvIiLIVBNTM5vtTOv1OZr5z9NeLVU1OH1wrIJKFgDnYt3pDIx8p1KLWvVyy3F
 1z6kGb8oyqZbtmYJwpT081fCHildm/+mC9qvMwgmbBAiZripsa51PSKbWsqxUd8CO5kY96i1kgg
 XFGhnPdQX3808qyZLG2Nnz9QKrhegQ9KKFRxyNuuunPONl14cAvo1ukfDusI4YpF7fdLU+21r/0
 YNVblR2ufZCqKxz2WlRljArMSYOCngPkTja/FTBWBmw66F9Sgmp+pVem3FvAk8FdLelFe/P63H4
 nBUnUC7c1NJJ9hIPEqXqwF8b8wd33n3pgpG79uYm5qhqH3PtvksJb3+yT7pe2kmDotIlhfzxxVT
 Zy++0Xj2cNCg44N/ngm2OH2bIUKh27tDs9K1lsxwP9mblEgkFXP7WsZfC7FQJhtKw1kPwX0tYnq
 fhH+l+0rNbpNxfA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On X Elite platform, the eDP PHY uses one more clock called
refclk. Add it to the schema.

Cc: stable@vger.kernel.org # v6.10
Fixes: 5d5607861350 ("dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
index 293fb6a9b1c330438bceba15226c91e392c840fb..2e594b2ea81d385118684bf58da3440c88ca32b9 100644
--- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
@@ -32,12 +32,14 @@ properties:
       - description: PLL register block
 
   clocks:
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
 
   clock-names:
     items:
       - const: aux
       - const: cfg_ahb
+      - const: refclk
 
   "#clock-cells":
     const: 1
@@ -59,6 +61,25 @@ required:
   - "#clock-cells"
   - "#phy-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,x1e80100-dp-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          maxItems: 3
+    else:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+
 additionalProperties: false
 
 examples:

-- 
2.34.1


