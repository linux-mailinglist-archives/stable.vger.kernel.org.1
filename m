Return-Path: <stable+bounces-27510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBF5879B66
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A111F2350D
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D9613D2F6;
	Tue, 12 Mar 2024 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gSkoGLxp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60013C9F6
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268278; cv=none; b=mfzmxFnQHXzDCz9MZCoqWaHQAYgpILMGTZrc27bGrgOtjbu+ujvVGo4CUKyxf2+F9I0h3OCK86EjvxUHe9cpeM3QAxXZ/auXNzzQwHOVB0DL9ZTKgCyRHAgNicJ7c4Q7zvdQVkHucyC6PhSY1O0OVWflZOgg9x8bQr2LMX7UiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268278; c=relaxed/simple;
	bh=IG1/QuuCyZab6uaf343Xx63BOPiPFaEpFINhDj+OsmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A6U/+MzYPE9y9AB3pehf07eAzfa6CBzJBHJkTNQYXEhEx0ny9iuf4eIZSwsgruCoJW8lOFLuWmQLDeRvnnlG/PNBIvwgLJvsQJaWotgP2yzRSHEuG5kBTXkBZVYCRKO0smfu/kI6NM68M2JXpbhVwSbcupvYf/Gmuu5RwkKALEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gSkoGLxp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5131316693cso263107e87.0
        for <stable@vger.kernel.org>; Tue, 12 Mar 2024 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710268275; x=1710873075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw2xDPlNe7SKmtRrwGLhAFX/roF84DFnyDd6BhT5KcM=;
        b=gSkoGLxpAEGz3fGmbuFi1gVehTVsdjtoD9QGICelXFUkn8urodH1qeT9LtOSih0z1X
         bJfA60wTOFMDKydmJbUCLtui2Y/vtCFh1qLRnXaJo4uNcOfv9prqFiYIAacIwUu6yZ7B
         R080hBkwvRFxCgU7m7rA5kKoWkpVMmCRX8cS5tXUQWy3B5l9VmBVV+LjXGvavZx+aAqL
         y5svQmhhXWGY4csJ6v0OdOcmKKMz5xDq3QavR/ll7PZMxXPWI+JRPMzOT4WBx2MjtdA4
         3cXTWDpZy9Hx/0BgOp146t2D3WhYT2juTe4VttldA0v1GKB3c0SRw8iYl8+uKVWNrw3t
         vDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710268275; x=1710873075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw2xDPlNe7SKmtRrwGLhAFX/roF84DFnyDd6BhT5KcM=;
        b=msq6/bMahuX5Ag6/DrDXWP4q9Ea6iQBMpuiWiU5rraykOY6UiAiv0HtHKF9+lGa52e
         HXKmkg1Q6sciOrq5nKNJNfmILnW4JTuYlgec9vzdaJo0LcGpU+h+W40EIfZLUcGqswh/
         U3cqB4G4sLgHe1P8Hm4z4HP4ZxdrhPkr7+hwGBb7lXAywViViccncf1lFlWP10YiI22K
         fFyQ8K/oqFYRY8la6GsxqyDOUK/bkH9a5b6yTeKlDBhTN29nnjqiVSnygRgNW7OLIPUS
         zpo1okRLHEnNnKcZHE7+lHMQn1HW464izXcEMn8HqUleLzrYJU78mf+ec/0rWkD9OhBT
         CVoA==
X-Forwarded-Encrypted: i=1; AJvYcCVweoKTGlBKVff8T90x6fLARcSd0qb6DMJ066wG2Bxl9e2GucWClj/5Xn9AuHF2qPHjW0quacUDNWyEK83Z+k+8zGRg8MAb
X-Gm-Message-State: AOJu0YwDm4ksAmvoPNq0YC7ORqcyzzR9JcHhcT2aJWcin7FHN9ummP0k
	LsKJXCCa5ltMkgbTcWEorOIxUVAykJAO+uQ7qBk44xpE2rNooIn8ALoYX8yNVPU=
X-Google-Smtp-Source: AGHT+IFZ0YIuOzhmA2zL+kySltHSERfmg5xOrosGsca8rbD/pqygXA44AhOEldxt0FddF7G/aQDwew==
X-Received: by 2002:a05:6512:46e:b0:513:c5b7:9ee3 with SMTP id x14-20020a056512046e00b00513c5b79ee3mr747592lfd.6.1710268275053;
        Tue, 12 Mar 2024 11:31:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512060400b0051329001f53sm1661012lfe.54.2024.03.12.11.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 11:31:14 -0700 (PDT)
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
Subject: [PATCH 3/4] ARM: dts: samsung: smdk4412: fix keypad no-autorepeat
Date: Tue, 12 Mar 2024 19:31:04 +0100
Message-Id: <20240312183105.715735-3-krzysztof.kozlowski@linaro.org>
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

  exynos4412-smdk4412.dtb: keypad@100a0000: 'key-A', 'key-B', 'key-C', 'key-D', 'key-E', 'linux,keypad-no-autorepeat' do not match any of the regexes: '^key-[0-9a-z]+$', 'pinctrl-[0-9]+'

Cc: <stable@vger.kernel.org>
Fixes: c9b92dd70107 ("ARM: dts: Add keypad entries to SMDK4412")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts b/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
index 715dfcba1417..e16df9e75fcb 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/samsung/exynos4412-smdk4412.dts
@@ -69,7 +69,7 @@ cooling_map1: map1 {
 &keypad {
 	samsung,keypad-num-rows = <3>;
 	samsung,keypad-num-columns = <8>;
-	linux,keypad-no-autorepeat;
+	linux,input-no-autorepeat;
 	wakeup-source;
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
 	pinctrl-names = "default";
-- 
2.34.1


