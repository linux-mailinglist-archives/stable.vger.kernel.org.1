Return-Path: <stable+bounces-67623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9794095187D
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 12:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6111F23789
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96B91AD9C6;
	Wed, 14 Aug 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYPRlP3b"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0561A4F10
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630735; cv=none; b=bzWcOUrB//cHO2FcGkj0lTtrjJLlsR6AER61dAag+XNqYneOkuIdLSedS1Z6Zu4rCQGn6hkVPWVjqUTF3ta52BNrlXXDVvrtrZY0l+jrSHpOYqUeG8ZXL2luAQK+N2xGDT7vyfB4BxwsV9VVvNd80U2xYM2rq7BYPUlPN6Elhxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630735; c=relaxed/simple;
	bh=VoIUTKlyGldU32MZSlDYD6KmvPIa8tx53ppKsKBdjS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOjqMRmIQxq54b68dkFQyjh+SEj7bMWVZ8Bn+v3S+J8F9+FsHxESo2mn4lyLqtJhu4hNu+Wovm9VWWJCA5zPg2ESrldgsxqmHE2FXCTXbsIHo9E6DLFNuPlhBj9SyuMsb4/ZymZ4WppYfrPZHmlswlLSrDJDX7xwfrgptxMZZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYPRlP3b; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-368313809a4so408299f8f.0
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723630732; x=1724235532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VniZOaq6gdFHYm/HVi9M3gxl2wi+7Y1v4x6YyCs0zik=;
        b=RYPRlP3bIeCcooS0wEtOREffAgAk5yDUxoREPDTFFnL9XcB9yBsDAnX9Nb9k9oU1/6
         CkVFNRB0F+kfs7/kSRp9BzjiqeMj+G4EkqtagAoBFr07WPOHdRq9HNUiN9q1JvmY7ogM
         cWV9l4ibd2n2SE/vF1KH28ia4MOzlL6O7Etyd3lK7pLJpQt6yZioDB+Lfur/6+mVtc2t
         mft3iNx48/fIX8FkMY/eO6cVP7Vbtc1UD/ELQdU0iiLSOKbWA59PFKacxfZTUq1i6xwt
         DPP3NWh1xzon3b0cS0FlVirT1TJ5X2m8fiLV+gtwNfdZl5PONhKacDDb1xtStCuV9+Wg
         E4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723630732; x=1724235532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VniZOaq6gdFHYm/HVi9M3gxl2wi+7Y1v4x6YyCs0zik=;
        b=DkJmFVV5AzOzb8Dxu9Kr9mHgin8u1eirICD5eezOtkTuYJZQ3Q9VqI8n9vrVHrTU3U
         WUfuB4E5HNWrowtGLt+1upigEHjkkD9AnkVR6Dk2FuZ6away21Y53eX8pa/fPscHNBoo
         sizozzDC9WwiiUril+KAHHxzPkEH4FyWwMVID1wQPgnHwyLRgZeWgKkWW2qqxxxMgfb0
         aZg2ocAvk5Xry+vsHQpJeXOPklPyIiR9FGOHYvZINmh+qDZYKsDwyjYFHYPms+LB/LqL
         hRfkAs43fB2TrT9bSVcU/CIRYvGenJs8Q2s6SPHDuFjgb1fvq+npNr1lfmdkaengEhrE
         qajQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBOUOZulpDopUSU7TbjV0wz+fQdAYeNdLzPwV0G517u+elzFbJT4UJ49eZBYsmwqzlEtJBp+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZ8Vbsco3LXag3UAx+k5n6wDqIOforR2ftSrj+/Xi2GEeNjmT
	krHk2GMOM6l6a67T0n2SJzktK5cjyLtPrNsL2gNsh6rfPT4y+FBJD9SNPn0so94=
X-Google-Smtp-Source: AGHT+IFtDsJPyLphAshdk30vTR0Sl8aU6sagYCDNH5sXB4NQUBZ21n39kniHa9yrRYMarUHR64R6JA==
X-Received: by 2002:adf:fc86:0:b0:367:8418:fde4 with SMTP id ffacd0b85a97d-3717960863fmr1393954f8f.7.1723630732067;
        Wed, 14 Aug 2024 03:18:52 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ebcdsm12487737f8f.78.2024.08.14.03.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:18:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vignesh R <vigneshr@ti.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Piyush Mehta <piyush.mehta@amd.com>,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] usb: dwc3: omap: add missing depopulate in probe error path
Date: Wed, 14 Aug 2024 12:18:47 +0200
Message-ID: <20240814101848.67501-1-krzysztof.kozlowski@linaro.org>
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


