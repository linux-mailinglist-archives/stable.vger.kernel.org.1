Return-Path: <stable+bounces-96299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227E39E1DA9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A089B3083B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301BA1E7674;
	Tue,  3 Dec 2024 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khGvRRRA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698541E5713
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228038; cv=none; b=htB0ysZhpDvjy4trklVAusPiH9AVKTLqLtmvlXpiFzNzmmF61D7FcA4MWTQ2WwB53meVTLUlkFqjm1Vrzc4/q97rv4ThNG199apHTuxsVJOAy0gm8BmjkScNAWMaoMl3KssA/sNPF93Rn6NINDSi7rRM5yrEEe04Jwzu9U6UJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228038; c=relaxed/simple;
	bh=iFlGn8SYSQnS21b00+qwUeC5W1YHrazBnqPMlae/vqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jMQDunGK36/CdlB/D+NcdolKvW0fSN+AC+P5HAlth6iEmJXYFcGMPpgX+K+s4AAp1GnhtGuJlzX7VsdbRLwstXUGmxzX2LlWZ5cTr6TF/MlT9pH7HytBsG8qeYbZPBl93ILKfnAaDjQzn8JLL5fDEtqu3UR2SINgNGGV0TCu3Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=khGvRRRA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so11280660a12.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 04:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733228034; x=1733832834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6M6cTvNs7V+xqyuwhG0n9JcP4Mq9Zi3RChVjlFoyS9c=;
        b=khGvRRRAuNhL0sFxFwZ1GIr6iN0J48Tf1EGXnGIpl2PvHS3hcKrs+Fz90LAuHhJwrY
         CgLfQd0nwXAUibnGIr/VXfwPGhxqadRmsnAcj7kWsDmIdllpaJRBPZGjjVtsIUMpAo1j
         y9/j4Lty94OzD1gyWyAcLgOFMcnmfM5lLLa9tFp/+Vk+GhrhjWren83wh2m9havX5KbR
         VUzP36rz8ngoAqsydUZncGi3qD9WJ4ibNtJIuN5qLUPzyTTrmJlnEINBij6UUILxVvw4
         2DhrELvbXpSTBcjGRx1viwnt0lWX6OcT0EeI3ka0MVXfHzCHDG1ZTGNI8rwfz/7tmfO+
         xo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733228034; x=1733832834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6M6cTvNs7V+xqyuwhG0n9JcP4Mq9Zi3RChVjlFoyS9c=;
        b=gjxkOjECcnjLTEJ6AZS5rs+gDSySS+HdAxdeSoqjy1WI9alSvN4eo5lnNns8BF+Y3q
         /exb9csaDtHA4pBz+6iWcR0xoX5Np2wdRdqrAF6vulTnCLqnVZLmDG1+dVPsh9JK6vZK
         yKBv4XgQrugwFIRgJYST3UZTjx4HPRFzwLef/6aSvDnYRd2y5RalW2jr/CYGF8HiieJZ
         owo+GZ2z6ZNsWp11Ig5yKXGwkmvk5jxyvAXMRjes0lms+lqOaQdkw726azckCGNmR+UU
         Z2Q1QV8j+WBrs7C1Y7saCR+3U6pDqfxHZUJrG7AF/SYAbOag92Wf5gNe5clIH9HlHY/G
         HUjg==
X-Forwarded-Encrypted: i=1; AJvYcCVZrRzyLLZx6Fu2kV8DxaHF/Z2hitr7rePpI+Ba8043VytaFMwpnRmnhBkJJ0kSguyazx5dSsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LZpUG5P/OFhXWNErsRXvcUYks7pIZyctHmlrbod5y11qupd1
	gAjlsAbm2TNCwAn/VjVu/Td4Qx1QdpfiS4lkO/bT1gZa4I0qlJL8gvlm/w+ecaQ=
X-Gm-Gg: ASbGnctIcXiIjOKgGLgfowZp+wqnrXg1qy3hAQPe1CJrgL4t3u7LyxcUxzPAMJeRsc+
	Fla7QKsAh7sNul9rEfdaRbx4CtethfiZ//uC+XTIbdhShAyjgv1Gnynm1ScGMoT2XiFPOw8eIkY
	tPqcC4z5UiDt06aTBA/cMLtBWqVN6K8KZEOHV33qx4MeXdhywFRWnBNMnYYcUJE6YGTQFVeogAZ
	q77SRrMwMOXI589ak6dXT8+yX/+MXBE+R03zBTeu9z/jwzyaQuEzOLHHQJVhCIFSC7ueOFgwlBX
	h5R/04+WSoRU56l776NgEbqIP+ycGaZ9AQ==
X-Google-Smtp-Source: AGHT+IFmVCN79AgO12dD2PdCbqVnKblHT8yfYp2CBGY/43ZxpcqEVT7DluzFyun9DnuIF1YW27jRrA==
X-Received: by 2002:a17:906:d54b:b0:aa5:3fe7:4475 with SMTP id a640c23a62f3a-aa59453454fmr3031209566b.11.1733228033761;
        Tue, 03 Dec 2024 04:13:53 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c245bsm607603766b.8.2024.12.03.04.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:13:53 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 03 Dec 2024 12:13:53 +0000
Subject: [PATCH v2 5/8] phy: exynos5-usbdrd: gs101: ensure power is gated
 to SS phy in phy_exit()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241203-gs101-phy-lanes-orientation-phy-v2-5-40dcf1b7670d@linaro.org>
References: <20241203-gs101-phy-lanes-orientation-phy-v2-0-40dcf1b7670d@linaro.org>
In-Reply-To: <20241203-gs101-phy-lanes-orientation-phy-v2-0-40dcf1b7670d@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0

We currently don't gate the power to the SS phy in phy_exit().

Shuffle the code slightly to ensure the power is gated to the SS phy as
well.

Fixes: 32267c29bc7d ("phy: exynos5-usbdrd: support Exynos USBDRD 3.1 combo phy (HS & SS)")
CC: stable@vger.kernel.org # 6.11+
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
* add cc-stable and fixes tags (Krzysztof)
* collect tags
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 2a724d362c2d..c1ce6fdeef31 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1296,14 +1296,17 @@ static int exynos5_usbdrd_gs101_phy_exit(struct phy *phy)
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 	int ret;
 
+	if (inst->phy_cfg->id == EXYNOS5_DRDPHY_UTMI) {
+		ret = exynos850_usbdrd_phy_exit(phy);
+		if (ret)
+			return ret;
+	}
+
+	exynos5_usbdrd_phy_isol(inst, true);
+
 	if (inst->phy_cfg->id != EXYNOS5_DRDPHY_UTMI)
 		return 0;
 
-	ret = exynos850_usbdrd_phy_exit(phy);
-	if (ret)
-		return ret;
-
-	exynos5_usbdrd_phy_isol(inst, true);
 	return regulator_bulk_disable(phy_drd->drv_data->n_regulators,
 				      phy_drd->regulators);
 }

-- 
2.47.0.338.g60cca15819-goog


