Return-Path: <stable+bounces-109378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E5CA15196
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743133A3950
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DF3158858;
	Fri, 17 Jan 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lm4m3tOZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6811142624
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123550; cv=none; b=E7RnhNG+5kYpejdGeRbyzT8YpD6Rhavt5a8GqG+v/VFiMCh0T87kdD214yVQzLqGVozxp1PxwDnUY+b4/V9l1+G7jhu32hKRsp0rtQecRexeghKgk72X011e2T05XRQokpqoRMAEDHXLmwd3sxjuld3Vy5WUmhGHnXlpFLuein8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123550; c=relaxed/simple;
	bh=oCdvQb+2nS9fJzhI+yPgqLPClQAHie77kio2g2kgZyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s2a+Zdc6/CbBA2gKTYIeg5bcwvEyTy2h8wbobN3HbD3Sd7KXvXXydzywrkJO81NDfdWZZdMWTLDOAI0b/mI/5PTZOlZCVralzcG5QFjQ0Yxle4ZWJxevBuV6o8LANQnFnhnpmaZdwpGZ5pAotBYC/8sH63dmT+QovocsD2HfPd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lm4m3tOZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43635796b48so13816625e9.0
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 06:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737123545; x=1737728345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uj4Spml5sM1tLHD2FfSBP66Bq5uP7mY7z+kcAwA1e+w=;
        b=Lm4m3tOZgGLYku8A4Duk7FaAf91ECH+x91nGUZlOLZQK9ySCH+/GNaUwibHPg/xWCP
         uckObVu4HbsGiZ5woqkGSowlAjQJnXiaNys1y5E6kmy+8ADRYTbq6k/QoENr6TU+ysXi
         tDCfEwYnAJ56DSExAwIdvUR+B9k04bCow9iYH53HLpSCPIdDvCxfxaztGoW7wUnQL8Xc
         5XVF64hudXCPCzbzRSBaphDQWBOeWcxKGT5ZsG3+0A8/LBawIRBSp6DGWbfH0pL7kTR5
         JrcvcnNq9d1oxQ7sBDFycTmr3CvbN3e4Xj7Lj0AHT/rQHxou/r34wLybKvGalw/utGjX
         ZI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737123545; x=1737728345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uj4Spml5sM1tLHD2FfSBP66Bq5uP7mY7z+kcAwA1e+w=;
        b=dsVf//gvSmGlfh0By21RUXSaJSuxiFb1r0g41oBy+aKHklRE6b5RQIIZMN2DvlvSpi
         /wkzN9oZlUvFqf8oGbGwZ3wTgs4uGx3pbH6S56zuG8gojfff6KjmLXsgTS7imgvnDctI
         RUEsP93LTXDkjHwFnC7UV4w+L9z8+Se9QTsT44dZZPZG8npJQ+zJ/Glhrz6eYzHJJGT/
         4iQN7dpCrUEQbNo+jdth3P3eUEha9p7FAA32T/P3coOK1sNWxSBUjsiQvaS7LHFcDb6O
         CS1OdfH7gXY1a7+qa7j8p5PF33jDvYvBdQNjdZj6XHwIkrYpu8jTiXfFbr1ykBVyK6AY
         6mfw==
X-Forwarded-Encrypted: i=1; AJvYcCWMmTEgqoDJIyH5atsrvQf5gi2PbTyZyCaQORGOT5cWxun6m4AjF973jRwRO6eQv8UERQDv8kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdjvQhpESaqHOMrgnD6jpxGSex16or+lGWBTT2qafCoLD6pmgs
	kGa++tcPQKPsNso4rQmqgOxcU5eVoaLwJDbqWpZDbUOImCrFEiOrKIHnJT/syNU=
X-Gm-Gg: ASbGncsvy0bbnhra7fNswFEi6KgQn+B+d5Ni7ZGWWq+6v0pc1yWKJKqTk5kHXxOMUGc
	G6OVN0ZhM3caj10VRUQzNRff/PgmH2RDY6jb5G7bd4sngbhrbL3mT9+UcOIfmvzeHJ23sbe81Ur
	R6s1QlLxhqGRyrHU35I26GFwnUpV2/4741lv9oIj5raZIsNjlOyUH45E4jAkDk5MFB3pdbO3ZR8
	w9oJyXJ8ekbose8WG4x2kFiC1slFv6kfaZiKgKMq9vHIQs3d/RSwSRJ01pvPnUlKISWMHOwKFjr
	MC+CQNWZ7b9BHqO2jYN9ERSzGcy1uxyIM3De
X-Google-Smtp-Source: AGHT+IHtJFuj1A/6iNliKs9eQH9rrj4V+OnOFmOpiyVc7p4nqfhLVN5vCbRzSx6Je0dj2NPJh1Qeww==
X-Received: by 2002:a05:600c:698c:b0:434:f9ad:7222 with SMTP id 5b1f17b1804b1-438918d3bdcmr26936585e9.7.1737123544993;
        Fri, 17 Jan 2025 06:19:04 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74995f6sm96764195e9.1.2025.01.17.06.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:19:04 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 17 Jan 2025 14:18:52 +0000
Subject: [PATCH v2 3/4] scsi: ufs: qcom: fix dev reference leaked through
 of_qcom_ice_get
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-qcom-ice-fix-dev-leak-v2-3-1ffa5b6884cb@linaro.org>
References: <20250117-qcom-ice-fix-dev-leak-v2-0-1ffa5b6884cb@linaro.org>
In-Reply-To: <20250117-qcom-ice-fix-dev-leak-v2-0-1ffa5b6884cb@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 andre.draszik@linaro.org, peter.griffin@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737123541; l=948;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=oCdvQb+2nS9fJzhI+yPgqLPClQAHie77kio2g2kgZyQ=;
 b=163Vcmfi+CsUVQeVZqwtnnkJb23luP5Bc+ZhUo0gynzhVHSf6qNM8NDwwDFi+n47kS2Sd6yOD
 wnJaevqnGsfBUfI2PFwXCIqHHI8DVN8amrNysqTsb/QFG8nJx2n07F5
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The driver leaks the device reference taken with
of_find_device_by_node(). Fix the leak by using devm_of_qcom_ice_get().

Fixes: 56541c7c4468 ("scsi: ufs: ufs-qcom: Switch to the new ICE API")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 23b9f6efa047..a455a95f65fc 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -125,7 +125,7 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 	int err;
 	int i;
 
-	ice = of_qcom_ice_get(dev);
+	ice = devm_of_qcom_ice_get(dev);
 	if (ice == ERR_PTR(-EOPNOTSUPP)) {
 		dev_warn(dev, "Disabling inline encryption support\n");
 		ice = NULL;

-- 
2.48.0.rc2.279.g1de40edade-goog


