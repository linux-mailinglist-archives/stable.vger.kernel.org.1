Return-Path: <stable+bounces-163463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F032BB0B627
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 14:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C5E3BA028
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B791F03D7;
	Sun, 20 Jul 2025 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xO8AZ21c"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755221129D
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753014618; cv=none; b=QPi0GngEA9VhoYXFQYkU2hN6cLRNfPtEcv/7PpP4BMgYEfHWwCrVnQcpvdUBd0Zk/LEyebxLarVmEF4cE8PpWOtq05nrMDVWLYMxXaJIA4DKoIUBvHgG0dHPORnXmvVbHkyl3gYTp41R+sTeBced5VnRSSOULizNvWBTNj+hp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753014618; c=relaxed/simple;
	bh=G1IxtxoyT5Pp2Nmr9QySSQastbYC6kRKqvAvFtsOPwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTIGLapWlMGENoylkIO6+hpypLwkta6KYA9tYSq0ElmvUlpz6ZoghIuQh+XSIiwgblqdUb2CEpJnIFRKRoDniF7D9mpppo+oR/FDDtDUuU75rezGPUYapGST2d4klQIGV5ccr24O8UsmH08hunTxMF7sFEQCrUOb1U6A940C0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xO8AZ21c; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-455f151fe61so1528065e9.0
        for <stable@vger.kernel.org>; Sun, 20 Jul 2025 05:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753014615; x=1753619415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITov4qIdAvf8lWzJF6TY9XuWoo2+Tb/hkSGxqIkLH/M=;
        b=xO8AZ21cdrqWa+EWTDVUWUzIx5qF5mAktDQl7mPRoXEkbeM2UqHg3iycTQdD26ep0w
         gIBoWv3VfemGDAtPS1KyJhngXJ5SePUAt8nGx8rLxW9kKfHaZAeH1Up+v+3johC2P+3f
         yU1Q0XQfCog/gM/czp1qStnpJ40yvakjXlHVCPquVYyh7Z4kyKgf5467WCHex5ssWpAF
         yPP2Ig/v/mHPfMAqUj/Tl/vHppbbxW6wjEHMwGX5Vyd4ZE8LiHyEw/zhh9WTnQWfHCuu
         V658K6Cs8rSVrZXcjC22vraiqmmgbiqaT6zLsY+mZPt7ribj/t0jzVsdvhv+nN/9EesD
         k+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753014615; x=1753619415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITov4qIdAvf8lWzJF6TY9XuWoo2+Tb/hkSGxqIkLH/M=;
        b=CniU8oaP05KT8hoFBrKnUyeGGb5UMx2wGGxGrElqZbMAiJ7Rm7PHFpXyLDEXB7wNk3
         PRZdNCAPPkbLOwFylTQSyEUUtXRFbrG9PP9z5F8S5nqDTKttyILoMgg56RE+jsY56/bl
         riFrgp/tyEkNezMWTC2V3+b3H0dah3ERSE4Yjxj0IDAVFAC2atCKMemSfKyLNP+Z9BOR
         iiDuwBxzUoFlHRBI27roh8nSIbL+lzUeMfuLwCFyCNpZBmzFNE0h0xJd0no+l6vmL0s0
         L4iQiQCGYTZ4WTlWIseXUyi46if9zYQo2Jzaz9Sw51E20SXhH3j8iUBvEoLgbvbJANEb
         UAhA==
X-Forwarded-Encrypted: i=1; AJvYcCU+3hkJ4B111+9ZdwrMGsaZKuFv1+N0ZPW3SUfnopowlRbSl4QrLAy5rnzVggwdZurXBLl/80U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4hLmj/b8TlnNilbIrdJJNV/3WA+wsTzklAv16y0HrAuqUbW/
	W/3PcOnyJhdiY/qy2E17EVGXeC/6bhvfWbERf/hbw0bEZAcAYZ8M42HmuKnY6n17ZlA=
X-Gm-Gg: ASbGncs5zcFFEtW/MEvuEDBB2DVkBJVKStomY8hQF4Y2+bbNCMDMjkaPDlpsk8G6VWj
	xnJtOxyUAjnTTw9hu8Om4n+jP1Sg8HsBJxiip6f9fgg7hNcGCNJalM2fpBEqr4qenBKbScO1pKT
	XGrXywqRy7vErc4QsjSyXnWL7rwk8A7DTr+k/DYhdetZSyaxZbhUuRbiWXMnDMRvoRYK5GF2ekd
	nOTRj4wnRBYDw/d+s3yoarimDO8RDYcN03WL9kxZhrg+j2R3FAmMd4ExkbdlbP20gNBgn0O0wjF
	ZDgzkOmZ7g8KDa8NsmFgXeKneKehOp3lAvx2jS1h//KQ8OdQtF8+pM91MVW/ly9YWp81DqXOkts
	EFqFvtJK0Mxg9UUrbGEQsMDoYv5jIz19JBtxnWzHZptE=
X-Google-Smtp-Source: AGHT+IHKkzedqggU7tdQbGO2iQYDtYMa+xUa0R1VwsfNMRAHllbqEZIvc4xTQ7uGNJ6WE6I0HZ9CVQ==
X-Received: by 2002:a05:6000:43c9:b0:3a4:dc42:a0c2 with SMTP id ffacd0b85a97d-3b60dd4da51mr3774512f8f.1.1753014614324;
        Sun, 20 Jul 2025 05:30:14 -0700 (PDT)
Received: from kuoka.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8ab7a1sm131396955e9.34.2025.07.20.05.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:30:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Kevin Tang <kevin.tang@unisoc.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: display: sprd,sharkl3-dsi-host: Fix missing clocks constraints
Date: Sun, 20 Jul 2025 14:30:05 +0200
Message-ID: <20250720123003.37662-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250720123003.37662-3-krzysztof.kozlowski@linaro.org>
References: <20250720123003.37662-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=G1IxtxoyT5Pp2Nmr9QySSQastbYC6kRKqvAvFtsOPwA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBofOFOrp9KG+sYVMZTHEpNsEz6647Gqk1eQOCOY
 ru2NyZsdxCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHzhTgAKCRDBN2bmhouD
 1+oDD/9x6NcU/ygrIopuaBmA+VaBGDwbNiJBqAOLX5nXA1w0DpyJREWb1dGfeogt/ECQ69xfO4D
 CyUlefhjTxuwFMCTkd7VX7DhahEHDg8QjYTOShZIlkix8tR7J+lQi/HwFebJSePtQjvNwRrCpme
 xrHlAYxnCBeTra687UsdeqPH6yqu94nzGjZJW466ZJ+j8UhTjaCgbld0aNDiLAyj1pEA0UySh6h
 fahN4a3l3YIgYvmN3FoMLd+XfJisBRO99VINHGY7o2bGhZLTylkxrABmm73bbwdEAz6Sq9cWSs3
 cZcJwL479QRukFMGKtrUFhSeAfsH8iKjG7hHAeCEMdUoILwOX/dZXOJQWCVhS4rjVQxI66wRKiz
 MtvqFB+e7oa8GwdhUQ1DPSYs5LHcIQc3+YbOB4uMJouh36GVsPsynwBFXAFz/KFuWZKdbQKTFuk
 EXZLMDmta0nnVfXLOre/j9C9hzOFGHY/HR1nmClDBE179eAOYWoN828XaoIEpxyFKw5g1s0/tIc
 7mXfxN9sbc+EGKeOJt+sFhT8x+EPtweVLf5GNoxWRMUCJwzxEsfLaZOSrkg2WeiVV48MIgjbbQq
 m7tedzr8GMYBHcUeV1L0CZo3TeijVnXKs92wEz4kavhGQpl2wTHGutKF9s8/ljEeTPjiGdvNZOy rhY2fibHhIehjCQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

'minItems' alone does not impose upper bound, unlike 'maxItems' which
implies lower bound.  Add missing clock constraint so the list will have
exact number of items (clocks).

Fixes: 2295bbd35edb ("dt-bindings: display: add Unisoc's mipi dsi controller bindings")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
index bc5594d18643..300bf2252c3e 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -20,7 +20,7 @@ properties:
     maxItems: 2
 
   clocks:
-    minItems: 1
+    maxItems: 1
 
   clock-names:
     items:
-- 
2.48.1


