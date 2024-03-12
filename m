Return-Path: <stable+bounces-27508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC879879B5D
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6710A1F23556
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2B13BAEE;
	Tue, 12 Mar 2024 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBvabJbO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E270213C9C0
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268273; cv=none; b=ugPOR32vHoKdBBjeiDVU9lwYSteWCXqgtpP5tDiJlobbioPXX3GUqa2j4QO08sd/rGN3INweQjBNg5eRlbBhJxjPV0UpoVk4+NkofjozqOww8C2lK7wJ9V2XsNWMsn0S2qI7cpjfUabULVzFgmDOdiXla1nx6K45xW8mkkk8gHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268273; c=relaxed/simple;
	bh=GGfohuvUdCR1mIme2gaPlbrTnQyrLD6PmEDa+LPTZEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QevS5/d35MkvLOEiXgSjLO6QU6L8t+vlPHm6M630rUR+dTpZo1n0idDllsYBEG2K42tn5argdYqcSP/wTXukXahDdPkSJh+dL4Q4ilnMHjEBXktVVtBqHLI0ekd5caxoGfDs5Vubc3QBwmJg8p+8TDXb481pGjpO+SeDwm1yE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EBvabJbO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513a6416058so3484121e87.1
        for <stable@vger.kernel.org>; Tue, 12 Mar 2024 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710268270; x=1710873070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qkPzWlNIYGy9ZZ9Z9dAov2lpIc23rvtotSMeeMgpt0o=;
        b=EBvabJbOvVJLU+eePjTudKSZwUhB/eEEA1O9xhLQYCgFs1idELPT6xflHyFO548VbA
         oiCxf/sDcvAmu/kiUE3TC+ZEsv38jsOJ5M1RNunRR9/48nfyvw1Fl24i/Ym3HJfhaI0Y
         69Wf9dbXmX/O11/q0Y7N8Tnu8Mzwisq7vil2beD5VgVixwV7WtarUF+CjeDPMEFs9GN7
         P3fYOkpYlpDlJX1i+BRTxExvR7o3sG81hu/FjyYHuvADg45xOkvEg6x4zxaQxS/WcBOo
         aVaV+61JhfzCGyga4bVJRk5T5+9a3DoubNRb8/IZeGdJvZp4MmO6MyRVtT+/+gwoivwv
         KSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710268270; x=1710873070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkPzWlNIYGy9ZZ9Z9dAov2lpIc23rvtotSMeeMgpt0o=;
        b=m8EpRXyec1HAdoa6/f0QMaITpd85cRj+9QfnMFNLEAZxNVEdoTeb/ELgW5be7KHF08
         9soqPMBJTQV6b5TLxhNyUXW/+GFqC0b7bT15oFiQhskguu7EMi1sbhiOYlOMKZq5KLIj
         V+QvV3dS74kAiVtbyq3SE863ayDmLqpYIzlLEeNynk8jDRPegXqHvN9k+WUufnJA1k6N
         I+W3R6fm7xrdJPlq9niqA0IXQz/G8nFky7gfKi2T5IAEBFkCvSF4LDqpvS0usaO5IAms
         Usri01L9ZgZW8XqXf0ZGG4b2NQSvEw3sfokRS19DEkGhfcxGBCN6zcnFcKk7vuxy8T9L
         0zEw==
X-Forwarded-Encrypted: i=1; AJvYcCVZR8l8sabqJRsvxyGIHZ3ukPWl1NlvgsRHKMQdyTjpTcRlYVP0J/pf+rn/6lNQJu9FjXrcmSZRTAn3GStF7/Ag3AEuBgbb
X-Gm-Message-State: AOJu0YzVvWo0wCC0SVkX2kV04VX5w5K04CP9JaB+1CC8kZVQiGHsmw7g
	5Wg1sFtML9D8WYRnaaaNW3KkzDRIFUcT4lwBXH90Mkj8nDHs5HEZyDHrX0K6lcU=
X-Google-Smtp-Source: AGHT+IESZy9/6wwGJzCCuXlWCFt+8swHC3N0HCtMssrwELRNtrUB6XEi2FAAOG+h5wyUNtIPAzDErQ==
X-Received: by 2002:a19:2d0b:0:b0:513:b2bc:793e with SMTP id k11-20020a192d0b000000b00513b2bc793emr3219193lfj.41.1710268270059;
        Tue, 12 Mar 2024 11:31:10 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512060400b0051329001f53sm1661012lfe.54.2024.03.12.11.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 11:31:09 -0700 (PDT)
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
Subject: [PATCH 1/4] ARM: dts: samsung: smdkv310: fix keypad no-autorepeat
Date: Tue, 12 Mar 2024 19:31:02 +0100
Message-Id: <20240312183105.715735-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

  exynos4210-smdkv310.dtb: keypad@100a0000: 'linux,keypad-no-autorepeat' does not match any of the regexes: '^key-[0-9a-z]+$', 'pinctrl-[0-9]+'

Cc: <stable@vger.kernel.org>
Fixes: 0561ceabd0f1 ("ARM: dts: Add intial dts file for EXYNOS4210 SoC, SMDKV310 and ORIGEN")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts b/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts
index b566f878ed84..18f4f494093b 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-smdkv310.dts
@@ -88,7 +88,7 @@ eeprom@52 {
 &keypad {
 	samsung,keypad-num-rows = <2>;
 	samsung,keypad-num-columns = <8>;
-	linux,keypad-no-autorepeat;
+	linux,input-no-autorepeat;
 	wakeup-source;
 	pinctrl-names = "default";
 	pinctrl-0 = <&keypad_rows &keypad_cols>;
-- 
2.34.1


