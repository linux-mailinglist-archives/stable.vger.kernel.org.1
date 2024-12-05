Return-Path: <stable+bounces-98739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B669E4E9A
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91472168CF4
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D10C1B87C7;
	Thu,  5 Dec 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DehWK7TL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1B1B87C0
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384001; cv=none; b=ZuMfVPBb+GHS2+cIDKsEk0prluhuPU+npz+c+kJklIm91q9n3jWoQas6hvfmxNcFCYDgBHUuc0qHD+FnqW/c6moS4XnD4sdXK0QC2hlsTBJ/B2h9Ifuy8JG6L7tbZUr6RMSD3YzvSMIaATa7B0Nvb5aUKjPj1ryTiluQtsq2dRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384001; c=relaxed/simple;
	bh=iFlGn8SYSQnS21b00+qwUeC5W1YHrazBnqPMlae/vqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZ6lh8JxCy6/NhpRfLcXvneCpKuQWWpnNsCq6QJaaamFeNUk7DwZGF/mpB+x+XmjeEpptUfZAAY11ZvJCHF0KPYiff8coErDoQXy3wCW7J+85mmNEWWW58L967BLHwQiTi/E2n+5AS6BPtZiuyKzuSOYahgf5jnOAeMWs9DJGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DehWK7TL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9e8522445dso103680466b.1
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 23:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733383996; x=1733988796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6M6cTvNs7V+xqyuwhG0n9JcP4Mq9Zi3RChVjlFoyS9c=;
        b=DehWK7TLgdKUA5BElK0cDk1YkZUIHRRYi5bh8ZHNgc7HQHLpsXLrg50jphWxAmtmr8
         S0vJU0+Q+OFyRYH55utOZglhTZNFiIpRnAi8yCUQg7bbRmzLG7Ez0cawLpK/HmV6YIsL
         OICEcgGbostjgLDZqJ4JUBX3MZZzcnvOLgBuTrBXXtb3vtwPydJ7uQjxOOuS1Ovkt5FF
         O6rm8cwBEIKOLrVbjNwu7qPexJqmcz7CiqWep0SKPcrKHkNU947Sz/gkIOq1vIpE7S7b
         +Cp24nrpVe5RAb5oDmfnWpN54Qr8P/WyVUMJIHPKaXFAiFaEOfbZFQ8TgGboeBDStofT
         p/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383996; x=1733988796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6M6cTvNs7V+xqyuwhG0n9JcP4Mq9Zi3RChVjlFoyS9c=;
        b=seYbNOcFxQVdpcsUrJjLz4RHCakVSlUZYlTLhXgYslf/kV4+mhbX8icXeHGBOkubNV
         w+lVwt8qleTtZ8rVu9VwhZ6ClOJQexnDnBys4+BqR72sEioSQlblAMsfuD4sMxuJ3eZn
         DlPeHb1P7DYTOaA+ZKOepu4MkmAGKi/1nFZ5TIrSUR7s4A0u5ZYOrc0fuedCarIcYANP
         bfwMIExRtDtT5nxXVi43M7fIz5XRWl8/i9h88XaaYTr8tQB5M4V+RlAg/UWPd993x6MR
         GsJ8Vlf4AookmdQShMrktPP/kb8RMnGue5SrEwvpLr17edVDFamMoUSJVie+4fkXTiH3
         Eu3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXytIfl5j96P2U4ty7r+P0hFSGHFhrV08qormHNI/jjHwBNS2YxsblETd2tQgdqeNIvB8VMSWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aq0ZqVAB62PnPmUCyRDvFsd9dla7Qyk+jrJbe3ZfFwn7mdMm
	w6V1nTZa0AYmeLwPxrW3cZ+L89nwLT0p39S/67S6FOUyr620Djc68las+rB6Kvg=
X-Gm-Gg: ASbGncsonDTIUw2ZjcEMZw/BCW1n5+o09cE5JeQ39lTY/QPMkv/iXzeiAlbiLtXBJKT
	md9RP/K2AlhP9tDA5osdhLT0zbfOjqjeoDF38nw3330RY1cAgopEjyvL5ZCheFDiibQBsRil9tY
	vww5o0DHHKuJzwNT3qKIg2QDHroU6s0m1yAKzLhhrUB3eBrmuBK5DJr0eTwpacQW1BwR9YxsSvm
	Q46sMtZ0MKOntYPv1fKvjbaK4r5dwQcFpRPfz/bL3BYlTmXaEMIEwh/8vnfhx7V6BKC5B2lhLVv
	bSVnI/V9yH9m1P/2pIQdDNbHe0xJH+ykrw==
X-Google-Smtp-Source: AGHT+IHuNjq0k6FYk7xK6t2GUtZ0TeRU7XN1ZF4Q/PTjjLe6Nsx4lZ862dPWiqXiDX4zZtdZApQooQ==
X-Received: by 2002:a17:906:2921:b0:aa5:aa3:8c45 with SMTP id a640c23a62f3a-aa5f7ecd65emr765500366b.48.1733383995984;
        Wed, 04 Dec 2024 23:33:15 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260888casm53371766b.133.2024.12.04.23.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:33:15 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Dec 2024 07:33:16 +0000
Subject: [PATCH v3 5/8] phy: exynos5-usbdrd: gs101: ensure power is gated
 to SS phy in phy_exit()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-gs101-phy-lanes-orientation-phy-v3-5-32f721bed219@linaro.org>
References: <20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
In-Reply-To: <20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
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


