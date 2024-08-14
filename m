Return-Path: <stable+bounces-67615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56329517E1
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2381CB25AED
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 09:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56B816BE09;
	Wed, 14 Aug 2024 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojVUnHrf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E94166F0E
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628406; cv=none; b=EFmmUqGdGqE1OfW9doeK8Yj4ASgiJ6PhmF6xUZ7vDf1tv59tUyTy55bGXgS5ggviXQN7L7n1BC4Yr06kUzts0G5mb0ZAAL4yK3lrapJLzW8X6HfUZq6F/mPzpkivO/4WkrfSrv9QCgKh761MPZavw6msxjK7BoGkLIHbxWMtk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628406; c=relaxed/simple;
	bh=6Hu1M4Pivk4SN1qDKdBZUfJZLXx91ytTpMSmo2rqxTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBwcWb63oWK9RDAvhav2lL7mEp6biFLfYFMAA7O6BEJpIAxRu3/PwlQrimGdpYCi0GH5RfIw3jvCF9AYTBYuTPBbvUUUceZp2g0kR7t5FtI5HBPnw5JKo8oCPctFR7udZUMiwcoTA7qMR0lbr5XYiXbmcMtPhH6DGUBIhBJPCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ojVUnHrf; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso70413231fa.2
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723628403; x=1724233203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGrgEwiDQnCrsN02sqw6lNl+tSbCrY1oNE/v488RmdI=;
        b=ojVUnHrfmF4XdE15A5Un/GZflOgRBS5yfflbArLX0XThGkVXbb/F8Ed5tGE4a3kPzQ
         XJFSVvR5xxzgWO1jI8AqNC6S4Dq18gc2Io0mDNVS1YPhd8AgziOILYOTu/fBgm03Apzn
         S3P5NrrmmQUDgAEBWuAgLj+p2TWcYNYMUjXGqZOLICF3TC1K39C1D248B9f5PsZHmMFi
         4Shs8L8YmnzehATM8jnACeEZ2ilKdnWIBnXYHZjX0q6/Py+XgBEDrdK3yKDW86VbLFe8
         RdW3Dovr9dwHUECoeyhrxJW5XzG+4wcRwzCjBkv8COJEO6ZeyFJzCyJRQApYJdBspFHa
         G/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723628403; x=1724233203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGrgEwiDQnCrsN02sqw6lNl+tSbCrY1oNE/v488RmdI=;
        b=FzZ8FH+519DqbCfEpA/g3OI8wTSzO1qYFElGcHHBck1b2xi7BJ5N+XfUCKZ5GE6KVV
         fh+i3M0s+2/1+m6g4ry+HMHQli4kwn90WodKY+kPk7LHyoxlfTI2ai93v04yOCeSmp14
         QaV6k9ZswChQ4qAxYCLmKKTr2GkA4Sjam+sltOJ+bpS5Yo8q/tKsZNSXdWh9dHSSyZ0z
         N/Rf5OXMxlBBzW7Io6K06Tl4Iv7ujkMnp34UzsbwVww7ilKwY9u3UIxRTK50AKtBI0Cj
         AFtzIATpzaTNM3Qv0P7eKTWPGbpbt9LxQoHkS5XrYqP9SZ8Evikz3FF3T10DZi+jQ9+M
         l4bw==
X-Forwarded-Encrypted: i=1; AJvYcCVr5sagrd0R68/TV6oI4aW3k6CPjOL694UksrqjuWX/1KVpVENygkh5JJ41d7zxDqTOZqumojs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQ2hE2KPQ1DSMfdkXoAzwtcw5WOKSYbMsIWKc6sPTpUK0/GeC
	OJSR/FIH7RvamHB2cXL7umfSOoamXifcI2vHtRgOeqjUCDIiEkwS4KSL6nXnGTY=
X-Google-Smtp-Source: AGHT+IHrsSXMDzPW+YC1yMSEObvTKIKA03QKkD9vhWlsmxjtI4DSdraFVWhJ0pwmrnCg1VCCTAW2Bw==
X-Received: by 2002:a2e:e0a:0:b0:2f0:1c7d:1ee2 with SMTP id 38308e7fff4ca-2f3aa1f99e7mr10852261fa.41.1723628402703;
        Wed, 14 Aug 2024 02:40:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded28cdasm14195615e9.16.2024.08.14.02.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:40:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <balbi@ti.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] usb: dwc3: st: add missing depopulate in probe error path
Date: Wed, 14 Aug 2024 11:39:57 +0200
Message-ID: <20240814093957.37940-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814093957.37940-1-krzysztof.kozlowski@linaro.org>
References: <20240814093957.37940-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depopulate device in probe error paths to fix leak of children
resources.

Fixes: f83fca0707c6 ("usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Context of my other cleanup patches (separate series to be sent soon)
will depend on this.
---
 drivers/usb/dwc3/dwc3-st.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index a9cb04043f08..c8c7cd0c1796 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -266,7 +266,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	if (!child_pdev) {
 		dev_err(dev, "failed to find dwc3 core device\n");
 		ret = -ENODEV;
-		goto err_node_put;
+		goto depopulate;
 	}
 
 	dwc3_data->dr_mode = usb_get_dr_mode(&child_pdev->dev);
@@ -282,6 +282,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	ret = st_dwc3_drd_init(dwc3_data);
 	if (ret) {
 		dev_err(dev, "drd initialisation failed\n");
+		of_platform_depopulate(dev);
 		goto undo_softreset;
 	}
 
@@ -291,6 +292,8 @@ static int st_dwc3_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dwc3_data);
 	return 0;
 
+depopulate:
+	of_platform_depopulate(dev);
 err_node_put:
 	of_node_put(child);
 undo_softreset:
-- 
2.43.0


