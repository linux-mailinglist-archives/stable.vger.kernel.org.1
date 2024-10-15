Return-Path: <stable+bounces-85097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C2F99DEF1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 09:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0904F282FBA
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 07:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD31D0B91;
	Tue, 15 Oct 2024 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCFsuZzK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2718BB8F
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975537; cv=none; b=JURf+N+wZLabzGQ1Lp5jBChGNiJ15XdbbLtauQKfCWfp0gSGhqVlxYVmHtTS164xQllmidKl9AnN865LORUh2F7t79E7NDAnE4LuIFgC+uG/D7+j1D9R2kxQ0jTKVwVGxvf/DDvCF58bJpEvGCi2V/XmfEElZ4L1ispxIu3x9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975537; c=relaxed/simple;
	bh=HHRjomsRYsJDwBzUt/stxykgtORGhKkWesiG8s2sUzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GMAykxlP905SitGMxaSdB8qcBQyhvlB2CGPj7NxboOtZW7TSnGu0/UrQvADqNuF3O0pROamWrmK9/9Ptv4g9Xy0/E7SmHjWbDB2IekPspm0HLOwxXHmo9Jta4KHLprgvjcsGfOUU0G0DLOTj4lpvQXvO9uSnyOjJFPOMUzjt4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PCFsuZzK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431198c63cfso5305355e9.1
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728975534; x=1729580334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Rg9CafE1YGkVl9KvHL3hkpJVC1sI0hUFkBUJZbx7bE=;
        b=PCFsuZzKQAR9kOL6ni8Kn0H9p+6MTkmTF4D+Fp053Ojk/c0Du5nfr2xqGqiYwee+kB
         YOcC8WBKZQSMVX3hgMZL8vriWYVmNTdRp9piSGURLmPXoiZJB3E9HgQazfgc0g9AkYyz
         uPBDLHOtBgeWZFKvjP/tQ0+vTT987www5QA5+vPUq8BmE1O/uQwKOya/G9v7wQ5hmsfH
         7DYnA4kvWqz33GL9wvZi9wNEZH8i30eD4weWbViSxizGIPrKorkf+sywal49bRhzm5Gu
         crES1KWqZAqLsIUQFAQ1r/s0pJg2zcLNiBi+XqO3y4aG8vJMfIysFr0BXiU62JaFCPbv
         DkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728975534; x=1729580334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Rg9CafE1YGkVl9KvHL3hkpJVC1sI0hUFkBUJZbx7bE=;
        b=khBzngsR8ic+E6BYZwv97ECFMFSbLNUfqk+LXOH9xSpYgNgFGHxkY7qCqkwM/T3arx
         0/uHn76cihA00/xT6sB6pzsv/1WmdP6ggi6LolaKGLRGIJBdHyzg33lB2y/mJFFqTkm0
         f7uFSmguS+rMhyl3+oqlq94eM8O/dWBLUA6nPr5EjC46+MkryB5poBgofoD3RjLh2XEe
         xrhDxqwqB9DRjNdU5aZwVgmnSAPuav76gaqsBxxOgvE8Xwiv6/k5SkKESo0d33TyIh45
         78WBMkm7kwPWoTLv5goqim2oOhIzCCH+lR7yz1+/OCy/DirLf8oVupKlDkPXi1VHPkGV
         Y/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCV5JGls1pbBQPWGzq4bePezDu6dZ2HANLevf4Vu4FdE2p4+r6RzXCPpxQlQNgngMtCSd4I22NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6CGEVFT3kiwzZ6mUbARlzlYy2YaXDBngkqdKNQHpUE8TWLuOK
	lTMH4WCfJUyVGhp4ODItM9tWcEAr8+Ld33se9m7+2X0J6twlnKBt5PAfklnxJrE=
X-Google-Smtp-Source: AGHT+IGbPMxgc3DOJjQs7sGqlYcjADDsKE8cdCECGo3sJ7ddzUzXMkKiJhT5InhJZ4au28jZv0tx4A==
X-Received: by 2002:a05:600c:5122:b0:42c:b63d:df3 with SMTP id 5b1f17b1804b1-4311ddff73dmr55330175e9.0.1728975534141;
        Mon, 14 Oct 2024 23:58:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c5d22sm8461645e9.40.2024.10.14.23.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 23:58:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Jaewon Kim <jaewon02.kim@samsung.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org,
	Igor Belwon <igor.belwon@mentallysanemainliners.org>
Subject: [PATCH 1/2] dt-bindings: pinctrl: samsung: Fix interrupt constraint for variants with fallbacks
Date: Tue, 15 Oct 2024 08:58:47 +0200
Message-ID: <20241015065848.29429-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 904140fa4553 ("dt-bindings: pinctrl: samsung: use Exynos7
fallbacks for newer wake-up controllers") added
samsung,exynos7-wakeup-eint fallback to some compatibles, so the
intention in the if:then: conditions was to handle the cases:

1. Single Exynos7 compatible or Exynos5433+Exynos7 or
   Exynos7885+Exynos7: only one interrupt

2. Exynos850+Exynos7: no interrupts

This was not implemented properly however and if:then: block matches
only single Exynos5433 or Exynos7885 compatibles, which do not exist in
DTS anymore, so basically is a no-op and no enforcement on number of
interrupts is made by the binding.

Fix the if:then: condition so interrupts in the Exynos5433 and
Exynos7885 wake-up pin controller will be properly constrained.

Fixes: 904140fa4553 ("dt-bindings: pinctrl: samsung: use Exynos7 fallbacks for newer wake-up controllers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 .../samsung,pinctrl-wakeup-interrupt.yaml     | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
index 91516fedc872..49cb2b1a3d28 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
@@ -92,14 +92,17 @@ allOf:
   - if:
       properties:
         compatible:
-          # Match without "contains", to skip newer variants which are still
-          # compatible with samsung,exynos7-wakeup-eint
-          enum:
-            - samsung,s5pv210-wakeup-eint
-            - samsung,exynos4210-wakeup-eint
-            - samsung,exynos5433-wakeup-eint
-            - samsung,exynos7-wakeup-eint
-            - samsung,exynos7885-wakeup-eint
+          oneOf:
+            # Match without "contains", to skip newer variants which are still
+            # compatible with samsung,exynos7-wakeup-eint
+            - enum:
+                - samsung,exynos4210-wakeup-eint
+                - samsung,exynos7-wakeup-eint
+                - samsung,s5pv210-wakeup-eint
+            - contains:
+                enum:
+                  - samsung,exynos5433-wakeup-eint
+                  - samsung,exynos7885-wakeup-eint
     then:
       properties:
         interrupts:
-- 
2.43.0


