Return-Path: <stable+bounces-191741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64266C2098F
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADFAF4EC68F
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ECD26F45A;
	Thu, 30 Oct 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQaYTQsc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401F26CE25
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834530; cv=none; b=Ou76SZsac1BGP3peKUeeJI4lwn+/bRJgmlhJrv+iYcSR9Qelx0jXq5woSfQVVGX7n2zJR52etCfT0BXscWHFIVN/59zlJlu84yNCpuj2dXP+dbn/V3pahFA1oID5IWggoVtRLDIflL2RF1CdbZJSJy7Z0kfpboiNRZlbqIn3T6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834530; c=relaxed/simple;
	bh=0oWG+qHo3Plj4txj6PI+E6VDdRLJWhl0rAGek1Lre2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ulpF6aKq+BC6UoimY4MkZyidbHGyDc5W7rnbS2RGNCv+01w8meVs15deHpqF1qrCey1LitZ8Fg5Kar9zzktF4q6DxHqDXP+nPJfvCchhDGsfrYP+V7PWgEmwq0gygZHZmxvBSpdGa05J+9iQMiHAuKIGmYXkYf3QNzTUt9/NdxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQaYTQsc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47721743fd0so6294495e9.2
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761834526; x=1762439326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzUB6K3HqPfS+X1e/axWNEiK+lQt69uG0iUUfrktjgc=;
        b=gQaYTQscwRPLatoH+nTHVPfNZD0s+d/BvUSWJootVDkW+2qk1lp74InCqQPo5/Kkl/
         z76owJfymZgQ0TSE2t/oaD0sEOGV7TxHraMbMMsmMqwmRpD/auyXuurOV+umnBQwFKx3
         HJmvZ2OEEdFPcNlLtFcina7EgRopGxMaiEq3fPH6Jk9inUC7cs7AIEj0YmN99/FsEe6s
         UZvBqAeHryjL38kY75olCV3ElVVpnQ8KD29qMb7IkQH4ZOZLbpQEVVf9mlarXjfgLL7P
         MflaDr5+t+HrAY+gcHtesL6YEQm/kbf4M2yw/UNLazBafYqBJLQXKCqi8J4StQuoj0/c
         KpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761834526; x=1762439326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzUB6K3HqPfS+X1e/axWNEiK+lQt69uG0iUUfrktjgc=;
        b=WDzuADaAOoxjkyG7fsU8iThVOlxDYY5Q7gZ5DDzFh4YnumvdXnmJsutxW+PBiEonO3
         9kUdeoefzq/BpKZ/iD7zhJmzd5ifqIHed5qBa7vwkprOBr6g+mcMKeV8t7k2wAeQUSPV
         Dzy8WDNckNom8H8Jx4B3mqY2y73+uqU3NeRuaQ8pbgTtcMa+TNTmB4Jdqq7p1W0pSAxy
         LGjurWwvvhTXebwBu1U0Uuu7uMLy2U41bKc429ZwS4dNk6MwQ9WefkgKZR6j2mk8B2aw
         kfYIjwkCWYT0fYNYLX+xlRFJT2pDkR9fr8Au+v2MpiDavXoJElnCzkKWm25iyxHw6DIm
         CHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4JJeY4c2u+/hn+TpUyE1Z7bGhG9QIV3NMMu/bk70IamXA5EpOnlB2COvXafVAolB3zubzKis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ELbGprWl29eUlL66RMQIoLBQiklApwlk3pdJka34tvLhPL31
	7uR6LjlHd35RODSrcmw+5MhlczhEcNMAZQ51MECKBOAhuBcSXpqW+a3j9Dtv39pdEuhlLNkq02Z
	v6dDy
X-Gm-Gg: ASbGnctckcsfsY+29GJzI/dJFhk72S7hVKzUjpw+RQo50qnzVWYVf8ggGJ1UzouhNx6
	41EBFd8f+J3UIdEjkkSuiAT2vU8FFe40N2ucKWNmpX93ZjfAgfBuvnASo1msEFcjIEkp1JXtTX8
	Hj2M8zPFsZpMa25tar3r08jkly3U4TLnTmRVreP6T0cpXd2/QreXsk68tYs5SrBmBPvSm1OvO38
	Ha+hhWYD5bbgbh72xxG3h0ocQmQR2HvsgpjNS1t+XOS710R8W9B/k5BCpe7qtMHevbpLFtt0Lnz
	Rd+3TPmtdTXN/TS8b5ion9W5d7FkWBSWgzpmk29johWUnyVx+IH6dYTDcs+2FlcnjOJOhdxq3Y+
	s9rZzoh1xr8VHRCrmsX6lknCXRbzespRmkd9YcEAYqOMVzG7gMGJX+15EVtGBAiAkLaGipNH5Se
	k0AVCHgFZ1/TKaycjvEgw=
X-Google-Smtp-Source: AGHT+IHDIcWOpb/AjtbKQqjQoELiWmkK+7m1rYGDSnOQyBbB8kU134OQtPTMF17uxocc9Ht6I/lvOQ==
X-Received: by 2002:a05:600c:5253:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-4772688c82dmr24022685e9.26.1761834525405;
        Thu, 30 Oct 2025 07:28:45 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fdfbsm42230475e9.4.2025.10.30.07.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:28:44 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 30 Oct 2025 16:28:29 +0200
Subject: [PATCH v5 1/3] dt-bindings: phy: qcom-edp: Add missing clock for X
 Elite
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-phy-qcom-edp-add-missing-refclk-v5-1-fce8c76f855a@linaro.org>
References: <20251030-phy-qcom-edp-add-missing-refclk-v5-0-fce8c76f855a@linaro.org>
In-Reply-To: <20251030-phy-qcom-edp-add-missing-refclk-v5-0-fce8c76f855a@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2124; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=0oWG+qHo3Plj4txj6PI+E6VDdRLJWhl0rAGek1Lre2Y=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpA3YVeRKmDq1ijkLKvUtCPBWbe/WxzMISYU7+9
 Jr4urXn8hiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaQN2FQAKCRAbX0TJAJUV
 VrhYD/0ZHrUVpqqF7n05SDc4Uef6n6GNsYcIufBiLMZswz4FOs5rKfxc657UNdjMsyWNmPT78xV
 gH6f+t0EtSawar+qmS9MK/GuZsimyo7HHp2s21Qh/ERV3haD9q9hGSvwiVn/g62pUxExo0r+L+/
 QvagvukCv9kZyZe6P1USOEl+KM6u2S1X9q8v8at37G0sV2CQgD6GgfkuGV/EIQLNRgSgVed11OO
 IwZuTCWWghOpFPzwXERLGcScI4w4kGiqO/OYc3O7Bkuc8phNTm1BhLZ9KdesJuaoDRrMRnU+LWF
 E4iq3K05r4sM4uAa+eUINQ3nzZLgWMYIuZ2nwd5BII6zIokewiMa+hlIJfccYyA+YLWGAf4tj5I
 MWXaiwOIUT4SPnA7DhHKG23XLoY1P7KiCbsdBEfxNT/bb/oakzPk3K/RT9tVUEO8DYnwbS0Cuqh
 aPoZXyP2MW5pocy8DdpZItboh1Y/Nh5afV0rMQSIpOdJnhw5IDOK1bt3Aj3YZEiMQ+HM3r34TgC
 2Hu0Za/Epzum+wYyx1jsFuVwWPWAvUOkXyiVD8dUT1eFEFZBL1NrDZ4wTsbaoMjHUmQa5MH5CvZ
 kVq9n3+xSjP45yxH5TtKr4xPwNfxfuU1ALtPNMZfW7Iv/pn3YDSOBiez0Zv7/LoE476NUllHcz1
 hpp//4UHxmmctvA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On X Elite platform, the eDP PHY uses one more clock called ref.

The current X Elite devices supported upstream work fine without this
clock, because the boot firmware leaves this clock enabled. But we should
not rely on that. Also, even though this change breaks the ABI, it is
needed in order to make the driver disables this clock along with the
other ones, for a proper bring-down of the entire PHY.

So attach the this ref clock to the PHY.

Cc: stable@vger.kernel.org # v6.10
Fixes: 5d5607861350 ("dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
index eb97181cbb9579893b4ee26a39c3559ad87b2fba..bfc4d75f50ff9e31981fe602478f28320545e52b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
@@ -37,12 +37,15 @@ properties:
       - description: PLL register block
 
   clocks:
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
 
   clock-names:
+    minItems: 2
     items:
       - const: aux
       - const: cfg_ahb
+      - const: ref
 
   "#clock-cells":
     const: 1
@@ -64,6 +67,29 @@ required:
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
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          minItems: 3
+          maxItems: 3
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          minItems: 2
+          maxItems: 2
+
 additionalProperties: false
 
 examples:

-- 
2.48.1


