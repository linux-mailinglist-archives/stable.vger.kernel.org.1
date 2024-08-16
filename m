Return-Path: <stable+bounces-69293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E7D95437D
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 09:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068A31C21A1E
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 07:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AD86BFB0;
	Fri, 16 Aug 2024 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XS8p9N88"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298277101
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794857; cv=none; b=nfLmM9SXRsob1i+m+c6EZG9ki+O6+vBmX0KD3pNIi+Zgw1OU2gALXwseqpXu6c3iBlgDxEq6CNUzKTOHWtNSmlRJc6kvlfH0/Nj7pMW+IO7EcAKn0E4yywgfJTk2riKBuWyHz1Sumscv9P3G1VxFZxd3znxiJg6lZq/OvqhJQUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794857; c=relaxed/simple;
	bh=29i/Me7OBdCQHNsyp4wD7LL65eIiAwGoh7GQQszBp8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=edT3t2NXYChnqNw7KIKznefC+J98quLjmP/0+rvgtnw4tfZjOEmb909q0faY57LMX25CcY++TTo4p3P6AchXxYt2bMvZH4rxjGLjiF+JoBDlqQREHguXYNIaVKg71sy1GzXYPen46W66AdxV333md9cUt984c/IDkKvepxEj+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XS8p9N88; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368440b073bso900819f8f.0
        for <stable@vger.kernel.org>; Fri, 16 Aug 2024 00:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723794854; x=1724399654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tU3SngOTRZWMK6BN/xX+yu9LBZ/E3yGuMgZAtpkguzo=;
        b=XS8p9N88nYpSpafKR5VNkJ0KlCs6bRKE/hBOKuOLVyQjFvNJlgzaWjmswgblf6g9Mn
         JEiVtG9E3Z2qDEHodkiikVQEsp95q91FY5mynueEeiGKnJPlJrOsUL2Vo8x8mf+KCD5+
         2rpQ/i+kw9f/67tynsFEt9KCP2GVBpRWsFxFO6yh1HfwZXq+FtR+72VPIrTKrO7sKx05
         b2wDBnDgKyuLPy/Ry2C9WesGAQD/JLjjOzXVi7iwq4bOITnm6joGDv+iZp2BdQrQ/u1V
         QsjZPD48A7zz5RPYkPMYmbgbxKS+dgz7HogGOmDQH+IoiMGC132iacY15t5to+VMBK9S
         0DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723794854; x=1724399654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tU3SngOTRZWMK6BN/xX+yu9LBZ/E3yGuMgZAtpkguzo=;
        b=Gpf8xYLFPImMIQMjCdl7D2ZTg+54uitLgTeiiXuma8mxa5Odu9f8xEME6biikd6iom
         25jm8aRlDud4hM+eAvEc38uTbP6ubAz7rTYBCPrKATDPAEx+buCVBWoJnRcjktgSTi5N
         az50lYgxjFhkzTqmWbNusV9Ak/jdqXKNXpGzlxxAmfTiavVgWKSJ8QRN9IdJX8ip302f
         kyalhl4R0EIOsOdT86dkYCnb/7C7PAI8851eIEvJj6mvBFDPYSSN79czz6p1fX4lbvEU
         hG9II9C5UppNbBkOjFT6rcGbyXZ+GIvIKfc3nV48rwDVlo8rTs0cjg65NDGFgvWNb1ra
         dicg==
X-Forwarded-Encrypted: i=1; AJvYcCXgLfYNiTGW5XIkGowaObt48cw5WLb3c3/aEh5YjJaB5s/CwkpPGtNqh8cGt0NgRB1MtJlj4HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2RKN/8CDaLCbvr2TmTpIyh1bL0Gsud2f1g/DsVFbfow16m6j
	e87apRc+iMJTyc0SIsIZ9qeBnPaK85R+Thq5wNFt/1YPvdRZyB+O8l+M/gdnN4U=
X-Google-Smtp-Source: AGHT+IEqEG4Bzu7IHX7pi9rFGKS2JnZDvCN4JyxP3fZbBWB8dkTAP9Pd/d8ezaB2qKeYO7fLJBnoqg==
X-Received: by 2002:adf:f9ce:0:b0:371:939e:9855 with SMTP id ffacd0b85a97d-37194bf6970mr1133066f8f.21.1723794853685;
        Fri, 16 Aug 2024 00:54:13 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189863109sm3049587f8f.65.2024.08.16.00.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:54:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Vignesh R <vigneshr@ti.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Piyush Mehta <piyush.mehta@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] usb: dwc3: omap: add missing depopulate in probe error path
Date: Fri, 16 Aug 2024 09:54:08 +0200
Message-ID: <20240816075409.23080-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depopulate device in probe error paths to fix leak of children
resources.

Fixes: ee249b455494 ("usb: dwc3: omap: remove IRQ_NOAUTOEN used with shared irq")
Cc: stable@vger.kernel.org
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add Ack
---
 drivers/usb/dwc3/dwc3-omap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index d5c77db4daa9..2a11fc0ee84f 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -522,11 +522,13 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n",
 			omap->irq, ret);
-		goto err1;
+		goto err2;
 	}
 	dwc3_omap_enable_irqs(omap);
 	return 0;
 
+err2:
+	of_platform_depopulate(dev);
 err1:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-- 
2.43.0


