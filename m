Return-Path: <stable+bounces-27509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DAD879B63
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4014284AB5
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B171813C9F0;
	Tue, 12 Mar 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPAA4xcN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A467213C9D7
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268276; cv=none; b=poZeWUPAP7DltRc08zUa7wG3OKrysOSqjjQbfAzJ8bqL98KAV5WJ+qJOjbWmWaLxFjtixSFXEgCF5cy3wls85DNXgzMGiT5N3R9zg529ku7sCo7AgiNh4q+OIKRbhZ1XSAStj7lAfrSPNXm66DqL7YcI367850O6SKN5Vaku4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268276; c=relaxed/simple;
	bh=I2tByFWUeg7RQlgkdroHYDhGFt+JCqH+8PvUwgpQncA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BjtcCLTmALA+mIy5yEOLy6Zfyvgqh0F6dHMwx47RRUTGOMOnHYoJc/AdVdXDwfxFFWZMooCbJLXengfaOZUQ5fezeyAgCRYwEvLw0zBFDvj4rF+Yu1hpPg5Y985drQEv3DXpY65yq1a9LuwNjw2TLJLxWObHtdWz0/oa0EerggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jPAA4xcN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513298d6859so5757510e87.3
        for <stable@vger.kernel.org>; Tue, 12 Mar 2024 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710268273; x=1710873073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57HI59HbFBJPfK/MjyMJoBtwKg+MFqS1roR+Am2NqOE=;
        b=jPAA4xcNB7k6e5xdpfGZs0iCnkoweSG3QLl7X/QAqp0rye/dTuUMn2PTTgetURZs7Q
         uhU8l5jztLSzvxcu91BOZwc5db5KmMWxO0/Irl3rsHKfZuVjISchRMVagim7nCi5bWG2
         +O0vK/iWuWKZPML/iRmpQmuKXPBKG+2isEHa1HBWbcklswCVtyebs0vXeCZD2oUgeS+Q
         AWaBxK9PptOV1uyF6NZDtbWZyxPkTwx5psxgy+oqobucXI+z0lTkNflvoJixtr+CEku2
         CBhS96YkEHyBhYOACDjzXX6667twVsj2+YKg9w+8xg5e3Godr+lXbF4vGphE+lq07P9b
         vvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710268273; x=1710873073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57HI59HbFBJPfK/MjyMJoBtwKg+MFqS1roR+Am2NqOE=;
        b=UdOahpChEIwCP8Cj92xL3LU+JPpEoIvvR4OoHoKSRYIi9tPaQe5XRLFgDp0dkDq6oj
         MgId7MJ+AQoh7vcUeQwdtMqpWVtm+8oCQTOeKWf1/OcdRVM7uHbkiWGUhAyDs5s4BADY
         5eU1b/WRLXhKzHOpfXbORtKwlWoupd3+KwXDuvzyFNYSdhSQO+/5LfVeKhNuDFrjKrWs
         N0eXoV70GmuM+c9gor+0mATUZuhKH1qMkC3aqximK0dHJRCpG1+UtThY54L6IgN+FOIM
         qrQnVJ7pVUt0ft/bMrFueSUB2e2zA3kMrr0I0Ltp+lA+M6wyOS8nUpNe0zh/N3jYQP0C
         SwKw==
X-Forwarded-Encrypted: i=1; AJvYcCWvjBeR6K8VdWaJbdkTvOEO+7PzBdAQ1zC+U5DvpQS2JNS0jgRs1fx7BvUR48q6CMtLCa1faNqNwj2kZOpwRvfty5mr/XGq
X-Gm-Message-State: AOJu0Yy6Iolqurg5aaCTV9PYjBeVoPC6THri/++4yIF5ImVKKWu4CslA
	Pkdymugh5e0xF3QRUSq38FY6uV9/tThoK5j5NyGDxgyGQ34NxYXS5TFjs6F61kk=
X-Google-Smtp-Source: AGHT+IFxVzjk1QdG/sc3AARsfYa8wm+w+jXz2u6S7MgQ3eF6IyCVFsQ9MzW3dlkUDUrgneMPx+Cj+w==
X-Received: by 2002:a05:6512:3da0:b0:513:6261:4d4b with SMTP id k32-20020a0565123da000b0051362614d4bmr2346425lfv.43.1710268272763;
        Tue, 12 Mar 2024 11:31:12 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512060400b0051329001f53sm1661012lfe.54.2024.03.12.11.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 11:31:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Thomas Abraham <thomas.abraham@linaro.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: samsung: exynos4412-origen: fix keypad no-autorepeat
Date: Tue, 12 Mar 2024 19:31:03 +0100
Message-Id: <20240312183105.715735-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312183105.715735-1-krzysztof.kozlowski@linaro.org>
References: <20240312183105.715735-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although the Samsung SoC keypad binding defined
linux,keypad-no-autorepeat property, Linux driver never implemented it
and always used linux,input-no-autorepeat.  Correct the DTS to use
property actually implemented.

This also fixes dtbs_check errors like:

  exynos4412-origen.dtb: keypad@100a0000: 'linux,keypad-no-autorepeat' does not match any of the regexes: '^key-[0-9a-z]+$', 'pinctrl-[0-9]+'

Cc: <stable@vger.kernel.org>
Fixes: bd08f6277e44 ("ARM: dts: Add keypad entries to Exynos4412 based Origen")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos4412-origen.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-origen.dts b/arch/arm/boot/dts/samsung/exynos4412-origen.dts
index 23b151645d66..10ab7bc90f50 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/samsung/exynos4412-origen.dts
@@ -453,7 +453,7 @@ buck9_reg: BUCK9 {
 &keypad {
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <2>;
-	linux,keypad-no-autorepeat;
+	linux,input-no-autorepeat;
 	wakeup-source;
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	pinctrl-names = "default";
-- 
2.34.1


