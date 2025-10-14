Return-Path: <stable+bounces-185613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E28BD88B9
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E883D4FC346
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5259A2FE577;
	Tue, 14 Oct 2025 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PhSEh40R"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55BF2ECE8A
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435193; cv=none; b=WP1Lw9MPmpVOs6Hyv7IOGTEYZN+SvDbVd3UA6eQy04A3tNEDba288+nrWBWoIPCdAH9fKNxGaiwf5hypiiylMIf+8q3waNnnQgffiSqUQE08h/qHffv9D5mmE9ilsRCMh98WC/UUM5dN6GI9zNlVh3cTbKjA8kevd36ZfrLyWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435193; c=relaxed/simple;
	bh=OaVD3kgCGNuvepXOAnIi/Jmw2IJiuqOadOslMs/qPqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pKbjWlQfMuNqUX7f820jCA931huUYa3U7V5nkClgjqjBY3844Gqa4DTx9ApefnlOjebyOyA8pZKwzKSHJc+OPmu2hOZkJ23+0u6qWg4416/FgQQQLGEF6jgPU2buXT1EmBVVkxo5tGMyib5D/6lkqvCi9bXW5BEqTAwJ/tmtvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PhSEh40R; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-41174604d88so2306403f8f.2
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760435188; x=1761039988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnhRFLfQaO8pIowD5rNcrWOdNtst07qFW/F+KRDikEA=;
        b=PhSEh40RHS42/Or92+1Lixn5jmDoWeojAQi8HznP9zXzsZGPilB0jJhhDqSiVvWWj2
         wB0kxmIzCCQaiBFMuwVI0FvX/vmfeL3WEgrYxs5cp8BOtdFBN9LNjButaAhJNo1NfQz5
         NmvPBCm+V0mZX2pViE8FHWKzmPEekMnrCVYCvYSKMagSRTkmMy5Q2DljtyDj+7Qe72iW
         MmmSwthpZ8ccKnBuL0qbFlVLHqPgz5qoXxsxq15uQxXqhzkc399z3wOzQCeRdDgA9OxL
         bQ1WC1ZzZLWnaRl8AvHul/byWFfh1c6eDtQ7zCyItKYeRSSaMHQwMcvCE21GBA5Ufy7O
         LFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435188; x=1761039988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnhRFLfQaO8pIowD5rNcrWOdNtst07qFW/F+KRDikEA=;
        b=dhnIuUTCQEB4s1GmvMXJ45oIKmr4zJHyOdNI4UksRmVH2GCgB8ZpH5apCvr9BkEqMc
         v11VFxRZTri91tj57r11IToPQg6FTW3gfdyqaWB2TJsoR/VUx17Km3aOIyMRCD3WNJlM
         b5PPOl7A7WnKIDxPcwx1nv8BP+T1niQFrqyyLTSRaLw2w4yLwvNiCrGqTf+CoCFgf+EM
         Qqe74+W0VT1CH6POlwD6kN/wVVTVYk3Tzftpyol5FwtSFnbmqJrni8ED1Gt8gBRNWkit
         EZQwJ9gQudBXD1t9phlP/Qdcd4nPU7Zh/UDsCCYYv8+BBwAsmpUdzaHhn+CqDh4bg08y
         odSg==
X-Forwarded-Encrypted: i=1; AJvYcCVqGamGkXu+X3Eqj8YeV0T6DnsMK09EK9+y+eLNXEMqrJpOA0i76uojOAWFTRoSBLo0tcig86Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WCBDek3xfMdkVnDTr4+OGN91sEBz6NggPtT7vZoopeW2r55c
	0waO1QqkTkYd/Tf2anfQHdGjM/A9J5FYIuucsb156i1craoVYXJlQfeGjJP3I2txgE8=
X-Gm-Gg: ASbGncv/A7u+BZy5K6UFXE7wrfQorc9mWMpFj8h7LCRP7zUN51gDpa6CPJv2bM2XshU
	SmwYnApWyaqPj37Wqyjwl4m5pNAN4LTH1SzQlmPbjLKlLfnGjL+e55Ln46OiP6HFhlDdQ5CnSU3
	QUPftVCs9C4qxDiwpfZU407poLsGg0Dwf8CatCDCrMHyXxc5NJC4y36Vp9D93y0Nh9ZxbVVnUT7
	wfbvQdwZxY5+n5GKGZ7I+GLnh2RAANKyuVsHZKAn02vWZSGiwPiecp4APqKWniZb0AJE9we0REH
	MeVb4Qzd1ihUfptRWCwLGcB2gLVK6iZCC4ogmzbmShJsMAxKzFdqQ7NY+n49KI2mtf6FIKqrQ/U
	a+WhDfalqkFuPvVPZROnbDYxztiM/+Th7zFDy+oXpVUo=
X-Google-Smtp-Source: AGHT+IFXhmtv8zqtFThQ4wP4GXOnS4SW/hYu7K5sk0wtbU92NOb2q+yfXz84YaQJJ4YvyUnKm5VinA==
X-Received: by 2002:a05:6000:40da:b0:3ee:15c6:9a55 with SMTP id ffacd0b85a97d-4266e7e00b8mr13699381f8f.34.1760435188415;
        Tue, 14 Oct 2025 02:46:28 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8b31sm22866442f8f.54.2025.10.14.02.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:46:25 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 14 Oct 2025 12:46:03 +0300
Subject: [PATCH RESEND v3 1/3] dt-bindings: phy: qcom-edp: Add missing
 clock for X Elite
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-phy-qcom-edp-add-missing-refclk-v3-1-078be041d06f@linaro.org>
References: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
In-Reply-To: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2071; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=OaVD3kgCGNuvepXOAnIi/Jmw2IJiuqOadOslMs/qPqM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7hvjUncltiOMHWO3SuDDxpda2OpYU2rLNm6C7
 uQpVNVVCjKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO4b4wAKCRAbX0TJAJUV
 Vk96D/4w36skQobp628M9KrofHekiWoDIJ3lHS3GsMM2ZGVAg0RbtIH4G+JPIFjFQSL5mfBssp2
 I/DDwKegs3A8WsG2e1cTvD+2I7KDzoVFdeI6t0C0VpXkWzfXjqjdC7CFyAb5TeWgIFAJSyR6JY0
 hRXgOFWOHetXfZlKd8raA21/+EGY1nd2D2KMI7rmTahpy5cTzoVPJUSf4hk67w+0orv6WEv0PBH
 RlKfyQiQ3CBKvGYqqe9DB5VrK7RxDDKn6/GxL2U1pR0SLCXhJJt4/Bcj123zYRt2jWTSPFiPsPh
 TlTVBnPBfQ4DUmidUafFXLDsg/ykx/txAxTef0OFwzGAkhksy0icxt1E9nX++LvTJuwo+BW9AF/
 0qckAxKWfFl+UnMBqs22oCpEWXQbRvuRuQ6mweO/1p1N7X592GMY1ybd7kvcatW467+LNnXaQym
 gnxxlJc0JNKNq0RpcEwpccV16S4MCC2XPtnnk48qXU38JaYl2ArAL0pNscuiV00SQEUtJO9OTAl
 1reMU7ez1xyomjSLc476wrlXd7f1MnxpZ4zrg4ykRWgVHM05jQ9il+B7Oy5inWz66Xo1bjmUF81
 5+TJb+lPkgmnLbtfulUc1GOY5mdni5JIPpIssrBWxB2BaIMP2XwToyWBrs9OWQWnKubzbQ/kIky
 mMFV+QUqAhamXQw==
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


