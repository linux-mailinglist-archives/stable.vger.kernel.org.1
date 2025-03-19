Return-Path: <stable+bounces-125574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CEAA6938D
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43433BA7A9
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AD11DE8AB;
	Wed, 19 Mar 2025 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yGa41IL3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138951D5CE7
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398238; cv=none; b=qBc+eLmrZWPQD5rDlp/ucP8v47TwOFt/I0aTwSEgW2jqW08GKnvIy7sfnX6oiHLdHlUJRtOtC2603X0KTraLIWnQGb8Ntz5B2YCJ/vT0qcMjRF6diyqkBz3aHI/0lnael0ONlxv3AMCTXCdjmyKvi6M2ySEComyVcKvKi0//ydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398238; c=relaxed/simple;
	bh=Jb70gmFrO795pq6l4lVz8akO7b7EaG1IPq1SXiJvoDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uL4U9iN4Sr5qhzFj2DeGtMlHkFUkan0Cj7Q0C28cCd0Lt4265PEgz64Lm7MvMGgc8VwBAa+UmyRKYHxrLHN+qTznuZIwHygwkjYPNZiRgmsIPdb2RBLuBaGgnMwS7mLyyGiZEBTiZw8nCpsgEQ6z02d9SdHzAAd+OLy12A8n88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yGa41IL3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so28326295e9.2
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742398233; x=1743003033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvO2MTCEp0zB1O4o3Tqb0ypgsyFb3UygQBlr47/GWsw=;
        b=yGa41IL3dgwVabl7wjk5518EIUb3wtjo/7fGb3XYBGidBM30QdEC0t/DCtPqDN3CUs
         e1IocQbb4RR2GgOrAioIQzukrREpCQwnU7NlJRmMJhxA+kNaPnH5kD5rN4LLhN+bcr5W
         5soKtWBj0v6y0YYJjQiVhubTC6AmeN8sPLPeBgCyqIAv4GXPT62A9ffhrkiqSqCjRqAs
         vj56JZblloOHmGb2QM/h1XMSh4CBEE3bqLC29aSep3ymVkfV0HI27hPh2Ij9m4gq9p3L
         f7DwnCjN7ntwI69FbUgayBATDfWcM4K+uUOoE25JMfvxCdaJ9BV2BOCFTuzEOTvpJagM
         zJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398233; x=1743003033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvO2MTCEp0zB1O4o3Tqb0ypgsyFb3UygQBlr47/GWsw=;
        b=YZwZZrg/FappBZ7NPSKBjTJ0Zm9ScjSV8XQhe30bG7I1za0kBnVf3G+YGiv++SPSZl
         4giaj3dV36jWKHRyxw9LvGWcmES+JXQhrSo2LqATVNbHbPeI1nVvlqmxwuKMAmwhfEm5
         x4bP3Y80yyYAegLKeHkA4q3KparGA1c1YujquxfrmqW9UE4a8Rvz+OYto0Wbo49FSmG7
         P961Rl1ii7qU89A8yui9fIoVqx1aKexnNShrTGNIyKA2mXMB2SMLCRm+XXd+S8CuafOh
         e/f1xRvFolyTOZ8NuLlvl6xpxXJJIyxYVMlTLqWWzXejWnXaQ72nney+xz99aAJI3Zu3
         G/UA==
X-Forwarded-Encrypted: i=1; AJvYcCUL/5Da+Tuoc54MwpcpsUr8QJBx9xcBUnbgexD2wyQx4ZUdZw4PXNrLW3P8uVgcpzQfVdlEl74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIu/KLmueY88FZH5l/ExwzxTsx4VNg3Gg28C7bAu+VZfWdHckn
	NizdZrR3FfYmF+XmTmHQtmjOw6X/qStmTFxYNNkdXRRD+6SrR529QOgkvqiA2uI=
X-Gm-Gg: ASbGncugoykA3cvhGeyevzgX2cCGyTi36EBegVV6w+FbGcdmklHDD3p2NKYp21u4l5b
	LACeED4J9vnmB5VqG2n6Lx8z58acfCCXmMKa1lUjQHrNXACUOeMj+q4BZkyYmGCp1vCuSWVmxPE
	aoUEga5Zrma47SNZ8idd6/Cp69m6onyNRfgpoyURBRd2RaM0khztplQYTy65qg3w0VGEZucJImk
	ArC3wrYA4wUmqxR00IjDb+4CR8GZN1PDUauRDhqdhf6qEoQVsmfEFrgo3ncnV9Fb+ZFyNsVOtpj
	a7+cixfzsCcOve6JymPEVVV/sTbHT/fGDu8y3e0hOT9nAUJnliA+OMYN3JikD09oFQhaB7x7LMx
	Q
X-Google-Smtp-Source: AGHT+IEck0zvlF4mA6c/4a1WmAWWk69t4E90tBTeEQDggA6Dvagy19sFXvzCIF2qVQD5IG+HaMrWDA==
X-Received: by 2002:a05:600c:4f86:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-43d4378b49bmr26833505e9.8.1742398233118;
        Wed, 19 Mar 2025 08:30:33 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([212.105.145.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdaca8sm22590635e9.28.2025.03.19.08.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:30:32 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 19 Mar 2025 15:30:20 +0000
Subject: [PATCH v2 3/7] scsi: ufs: exynos: disable iocc if dma-coherent
 property isn't set
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-exynos-ufs-stability-fixes-v2-3-96722cc2ba1b@linaro.org>
References: <20250319-exynos-ufs-stability-fixes-v2-0-96722cc2ba1b@linaro.org>
In-Reply-To: <20250319-exynos-ufs-stability-fixes-v2-0-96722cc2ba1b@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanho Park <chanho61.park@samsung.com>
Cc: linux-scsi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Eric Biggers <ebiggers@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
 willmcvicker@google.com, kernel-team@android.com, tudor.ambarus@linaro.org, 
 andre.draszik@linaro.org, Peter Griffin <peter.griffin@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2684;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=Jb70gmFrO795pq6l4lVz8akO7b7EaG1IPq1SXiJvoDo=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBn2uMQZjsaOtKjGo7lobraBsTsDeP+7mpJ30581
 SJ5trpIFZCJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ9rjEAAKCRDO6LjWAjRy
 ukYxEACIl1Ea5bUkcLZGzc6ZA0OO/h7+Se39yd6wIuAMUSpmswvUV3Qb0bAsYwxo3+GplmGD4NC
 GE0K+EJwXJuPeUC/bM5ws5vvl3Ju9VuaX1q4tdZQsTbxv+b6Zkh+Xecklhh0JbEe5a+M9cB0ck1
 kcSm4RaJv/yfB/lfK4pKQhEBXXnORI/uRSVOylkEJt5gQydTgTACqAfeAdtvjnkRortPSkWWouh
 16SPfnBNlmtgTfvG0oqjMupL1ahKe7xKGiCZiV1X3XMIiQpHO3/wAphY6NQXltTyPWK327QWomm
 /nlVikpDZgWmlV3R3bqfvMZYe4XLX1nYDy2gwi3Nt6mQUCLundOtLwLz6l1M+1T++1nZsaD7fD+
 5Vw7NKpj1PHyr5Yo4XT9B33Ee/qzk41FZYpKyAecvFYKOfL3/yXTk90uWYYSUJsL3E75OVNuhhf
 hneoGmsPvUdFJj5PULxpS41lQJoZX6Iy6vCHrD0dzYZ1LvJj/6MWlbpT9FMl4Gd1QdM6D+L/+VE
 xZgKHQ0B6p0p82l+KF4ix/ccLMRt9zCxMgSHLekM23BMkxVjNl6QBKV1J9+iZoZM8JyucNtpKNp
 wvMMpaHQI2jWkUPHCVJKfszB/96IMvpxk2DJk5m19jR8BRYl0hdfT4NtIC2kUY2/R1BTJmispT3
 F7l81PGxEltoqgw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

If dma-coherent property isn't set then descriptors are non-cacheable
and the iocc shareability bits should be disabled. Without this UFS
can end up in an incompatible configuration and suffer from random
cache related stability issues.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Fixes: cc52e15397cc ("scsi: ufs: ufs-exynos: Support ExynosAuto v9 UFS")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: stable@vger.kernel.org
---
 drivers/ufs/host/ufs-exynos.c | 17 +++++++++++++----
 drivers/ufs/host/ufs-exynos.h |  3 ++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index f393d42a659f821225e67e3e5d323478456ca3af..61b03e493cc1ddba17179a9f22e5b59ece02458b 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -214,8 +214,8 @@ static int exynos_ufs_shareability(struct exynos_ufs *ufs)
 	/* IO Coherency setting */
 	if (ufs->sysreg) {
 		return regmap_update_bits(ufs->sysreg,
-					  ufs->shareability_reg_offset,
-					  ufs->iocc_mask, ufs->iocc_mask);
+					  ufs->iocc_offset,
+					  ufs->iocc_mask, ufs->iocc_val);
 	}
 
 	return 0;
@@ -1173,13 +1173,22 @@ static int exynos_ufs_parse_dt(struct device *dev, struct exynos_ufs *ufs)
 		ufs->sysreg = NULL;
 	else {
 		if (of_property_read_u32_index(np, "samsung,sysreg", 1,
-					       &ufs->shareability_reg_offset)) {
+					       &ufs->iocc_offset)) {
 			dev_warn(dev, "can't get an offset from sysreg. Set to default value\n");
-			ufs->shareability_reg_offset = UFS_SHAREABILITY_OFFSET;
+			ufs->iocc_offset = UFS_SHAREABILITY_OFFSET;
 		}
 	}
 
 	ufs->iocc_mask = ufs->drv_data->iocc_mask;
+	/*
+	 * no 'dma-coherent' property means the descriptors are
+	 * non-cacheable so iocc shareability should be disabled.
+	 */
+	if (of_dma_is_coherent(dev->of_node))
+		ufs->iocc_val = ufs->iocc_mask;
+	else
+		ufs->iocc_val = 0;
+
 	ufs->pclk_avail_min = PCLK_AVAIL_MIN;
 	ufs->pclk_avail_max = PCLK_AVAIL_MAX;
 
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index 17696b3768debd641188b5089585b6d303de7451..a345809af79dc528ad518d3572fe8be034341ee0 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -231,8 +231,9 @@ struct exynos_ufs {
 	ktime_t entry_hibern8_t;
 	const struct exynos_ufs_drv_data *drv_data;
 	struct regmap *sysreg;
-	u32 shareability_reg_offset;
+	u32 iocc_offset;
 	u32 iocc_mask;
+	u32 iocc_val;
 
 	u32 opts;
 #define EXYNOS_UFS_OPT_HAS_APB_CLK_CTRL		BIT(0)

-- 
2.49.0.rc1.451.g8f38331e32-goog


