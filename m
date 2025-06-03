Return-Path: <stable+bounces-150724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD90AACCA64
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9161692E0
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C5C23C509;
	Tue,  3 Jun 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdnhC7g6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6AF140E34
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965405; cv=none; b=tiaO5rygIkLYWgqriziw8JaqYatSotNFU/B7T1PyHg9hcptpRN/gGs0b5vdmrWBCRkwznGb4yWiw2QcV6VWSpFdJzSDpn9j2lYKOPpjU52cnlrhDhNHy1SceoLEbqoywnTf2KpLYx2fG2y+s80o4nTaSpSTlhq3et591izilne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965405; c=relaxed/simple;
	bh=mkMTj06O7I1L9PURSG3BNAMbohNB+Tx9IJ0AE7abtkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lF/juRzity5d81YB+lH1kyUAoOeSVfAUIQA0Kx81fjwrlKHaXi0ROBCKomgZ2M1nd3U/KvMWLMeCbh7dU92LiTGBAgsn/pDI7syIKP1G9ou9KVtgAu7zLuDnwMtB/nxsR7fPGm+zZfu1g9plHSp2MvJEWVmf3qP1NB9R2DsLaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CdnhC7g6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad89ee255easo1053866966b.3
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748965402; x=1749570202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhF2cjF5zAzV18nEabakJ1UzQ/GrNdWmpvarqiPCL7M=;
        b=CdnhC7g6HTA5vVqW4+Yh06/p4CQ5jKKnTPKcn/kxHayDitdoWpXM47JMCdIgYFH/Zr
         mOfMKs2FynPZIfpUOp0rwx6XXN98vDdX2loNp9EicwzKYGpRr1f8LOmxFQ7f1HH+6Xqv
         DL3aFB1/wck8kjaaWzV95l+kKSkj3b83g9fKBwSwEK63PeBISj4WJ9PN8yvmGxbPt/oP
         5E3EduLzvIv2z27fR8WsWw+sE1S8Xh40Fdx4zqH2B1JHebzeoYBzzd2Mkaeqx6Md5dsg
         kGdov6Hlvcgf4Ml4KHh3Uk7cD2Ui8jXJADfhePZVtGPSKIrzqLrJkGFW+vAtksARWeVH
         z7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748965402; x=1749570202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhF2cjF5zAzV18nEabakJ1UzQ/GrNdWmpvarqiPCL7M=;
        b=jZPoFw5vUwXG6apLMvwHGt8HH/ZoMfvMYinhj+oOx1535IDE7gmdclorulWFjge6vL
         CP7BC/qi09lBJPCb/maitwnwNVXVAV9dO5hUc7Z4zETT2d+KyPc6tYJfNOHeB7crt3ys
         /ujk2daSVr1O/gbmIBLRHgdDHNVWtTieHvB7BhHstuLgf0eXxs6MxWTdrR1za5SGgp7Y
         BaxwFvhG42+vkOW0KzZEOQODGz78s9oTV/gvU6oGqHtqtoNpDrfWnzjOIUm8TwX2SC1q
         Xo58E2NeH66+/a51dAL1xZh52qdJFGw0mAUkY3Oii/0hasToD8c/Exl5dnpHdQ9MsxFs
         Pwkg==
X-Forwarded-Encrypted: i=1; AJvYcCXRUv3hlCcuMA6eTNy4l78TPiBd2zH7txKeZvKxfWb1Jfzfe1R0BILvC0R4QC56baGuc0cXWp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+LtY7g8Y0zvuEl6QE4kygJ7qZZgLiTn4GHz3I0WXg0cI+Lq9j
	8s/DZ51p2xlYDfChUTUiBJQ2FSjZQ3MHO2Mu5P2+1LAAj85ulXFCzJ1xQgrmaoiLG8/13JQPb7D
	V1NnhISI=
X-Gm-Gg: ASbGncskxNDyPrgKiAkdpx4JKS90lRAegkumVJdI5sOWrxKKhXVDN1DPtmkJWtT5cC3
	dNpxKE4eM5+02qNv/B9dHDJXA74+nGGi88pE/JjkBjGxoAbuwzQJFrLFFh/y/HHPDBuznwyPoQ5
	VFtIo6wImSW/dAkI964oQLsLPWZkk+aIXRYNPJjBpxe6lLV+VKYBjf0RTctJa/A4uAY8J3bZt/9
	JEKV9sdcHAgbkZekNAp76mxzMo/qgcH+UaSzlFY+SmkEmSBkO7FEBAjq9Y1TLognSNjDlcNCMs8
	+/5PLMacMhWvNMLS/HmCuFQzpeqRapSCju7VgznTgH0vmkn1ksACK2gXBNNkHSWpOQO6pDxU6/i
	lUVwWjiF2zETLdGl404xI7lCHu//G3dtWuTk=
X-Google-Smtp-Source: AGHT+IHdbH5nQxzalWh/NsDVZb6FCYdDH3rQaVkOJ6uhuni+aK7sz1J/yFbrtIh3WrzPAg01pUI1GQ==
X-Received: by 2002:a17:907:971c:b0:adb:2ef9:db38 with SMTP id a640c23a62f3a-adb36be2060mr1662069466b.36.1748965401532;
        Tue, 03 Jun 2025 08:43:21 -0700 (PDT)
Received: from puffmais.c.googlers.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82de9bsm959277166b.47.2025.06.03.08.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 08:43:21 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 03 Jun 2025 16:43:19 +0100
Subject: [PATCH 1/3] clk: samsung: gs101: fix CLK_DOUT_CMU_G3D_BUSD
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250603-samsung-clk-fixes-v1-1-49daf1ff4592@linaro.org>
References: <20250603-samsung-clk-fixes-v1-0-49daf1ff4592@linaro.org>
In-Reply-To: <20250603-samsung-clk-fixes-v1-0-49daf1ff4592@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Use the correct Linux clock ID when instantiating the G3D_BUSD
div_clock.

Fixes: 2c597bb7d66a ("clk: samsung: clk-gs101: Add cmu_top, cmu_misc and cmu_apm support")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index f9c3d68d449c356019aee569fbe289259624da70..12ee416375ef31deed5f45ea6aaec05fde260dc5 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -1154,7 +1154,7 @@ static const struct samsung_div_clock cmu_top_div_clks[] __initconst = {
 	    CLK_CON_DIV_CLKCMU_G2D_MSCL, 0, 4),
 	DIV(CLK_DOUT_CMU_G3AA_G3AA, "dout_cmu_g3aa_g3aa", "gout_cmu_g3aa_g3aa",
 	    CLK_CON_DIV_CLKCMU_G3AA_G3AA, 0, 4),
-	DIV(CLK_DOUT_CMU_G3D_SWITCH, "dout_cmu_g3d_busd", "gout_cmu_g3d_busd",
+	DIV(CLK_DOUT_CMU_G3D_BUSD, "dout_cmu_g3d_busd", "gout_cmu_g3d_busd",
 	    CLK_CON_DIV_CLKCMU_G3D_BUSD, 0, 4),
 	DIV(CLK_DOUT_CMU_G3D_GLB, "dout_cmu_g3d_glb", "gout_cmu_g3d_glb",
 	    CLK_CON_DIV_CLKCMU_G3D_GLB, 0, 4),

-- 
2.49.0.1204.g71687c7c1d-goog


