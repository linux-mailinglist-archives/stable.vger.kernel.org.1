Return-Path: <stable+bounces-111252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E10EA228A0
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 06:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D4927A2247
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 05:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E91684A4;
	Thu, 30 Jan 2025 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxyzyAhy"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469A4431;
	Thu, 30 Jan 2025 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738215552; cv=none; b=VwFca3OCy8StLWRDVQ4QzIkekIYYFHLe287H5UL722jEWXbHr6A2sOCQiUVRY6eUJ7kMRH123gLVIx9DJBqGo/fPa+LQC2eAH029RvMKhoOUPC+THN/HT/evPOyfCIHhJmzvrIo8uCv18iBI0ofky0fpACHLcGzklRmBxRWgQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738215552; c=relaxed/simple;
	bh=Ow4ZN8i+zu93sqR8A7PlGp0fPg0RHjSsiqW8t0XWd5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mMOpVzH1hVnTwdcldWAnYls/19qd6JEdY0TpbBnRTRcvHSh6pd65zraZa6RjSfi/0nBHvw2YAAlHz68AMXun1a2EpxcEemWvJu9e9nz7a/AKR8T1hT3EcGI3XUNwvP2lfefsdUV1xRzAMQQRMLjjcLEMS6G0yyi20ZoOtB5QZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxyzyAhy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54287a3ba3cso1428640e87.0;
        Wed, 29 Jan 2025 21:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738215548; x=1738820348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yg6BBDLYoGyifIg9RVhTYdC6MChPe9nDARLhmJSgMKY=;
        b=LxyzyAhyq0wBpSURrHOAHcOZNE9uT73rnBLcEZOctmqZdzvo/J7gb0RvB3ebeydLQX
         2lBzA/Ciky+2utfpE3mNQjUOWysNIMfU32/TSy+7UWdmbFc7su+hsYE9Byouc/ciMaOk
         JAMJ3K9/ENBeWO7R2MB80C9LE37xG5XA/24GAKA9DUprJAWkUCeMGbB6vDZ0iCXGZ9vs
         qudi9zNKp9e0HEN6buw7a7489TtSWSMZGm3Dk7OfF1/on1u1AX6fOhJUqNg/hUsmo9bD
         2ozI9VJlXO7otp48SkjcqwLdIznFbqc7FDHFAFB1CcDA5LKsKUoixjQmxi6ovH1IdzHd
         Lkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738215548; x=1738820348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yg6BBDLYoGyifIg9RVhTYdC6MChPe9nDARLhmJSgMKY=;
        b=M8CBrUIzPF9HyroPiuCk7YkpPl0shTM0THWHNYnF62B42zk6BrWhP126IQS1tef3hq
         vvZMa3hALRoVx11ibmP4ZHSiigO4vaLsoo++2IvgyG7zs7PS1cgSQ/Eg36jQjcthbMeF
         D+52YrmyFWv0rAaQkNCmbjul0nMyVEiXa10nf1UpCajPI7TT9EC1n5wBEcIdhUA/VkgR
         EqXgP/deDYwJxMPceepnNHPYh49Vohq3ZhDizmqiUEZxtqnelaxgxyk/x0H4YSFqOq7N
         JQBcMqdzsKL4W4lhPVNNTU0odOcDhftYB35we2ncbcUNsuUMsrgqKVenYaxpTXvIQ+WU
         gw/A==
X-Forwarded-Encrypted: i=1; AJvYcCUuZsoKCopBwu0ejoRLkLlfrqO9C5cVE9M5R1af8wA34qAS7uwF3XDJLPoSRe4qhSE6ndMTS1E9zqiLCWdb@vger.kernel.org, AJvYcCW409cwMo8YhF1jqs1ZRAAccxlXibvaFT5BGzh7WlkbaabP61E7iwuAsxYKR7jlqZjk0eFUoKsPumFA@vger.kernel.org, AJvYcCX/o2fibWxwBCNAswMMLosrxnir2XxLjTm0pH++gjsVhSSMmSAGxT1QjjKi+UZnroh3ITY23kw0@vger.kernel.org
X-Gm-Message-State: AOJu0YwRigEfr2bgiEYabLq/DZ8O2AgSOtMiJG6P851lcxgClht0dpt5
	wrIJ5eBBTZ3NUwKU2DYbxaaAcRV+6HShpUUe3c0VTE3yMLHVcxTN
X-Gm-Gg: ASbGncuGWkreXpDnv5IrgkbRslaHhjF49LJFtidNyTz2Jedrw48Z3nJ1QIoSg7xwhsw
	P5CoOX61DmVoHdXd2EhNkYbe0KIKHg4IozZnuRg5kKwNXa+AiKq4nLRRzuQFnnBjqhtPBQ2CfDU
	+T4pEa775w07BNp92JDrQvoRAhJqZyGoIFI5RS/06D3GfX6ElAWkMtxm8795YOVSaARLVkJp58m
	qeET8N7tiCYEjHCDEgyQgMp8IdXN+yaZHVrOPtVW+0MJFm8lxLX56WHDWLTWxrv1IJjTTT6rfrY
	TmvODdOJ2ms5bjFYsfLwNLJU7ec+QZ631E1MEQ==
X-Google-Smtp-Source: AGHT+IHwPat51mTNEQD4tasyr+KPQCLz762K4muhG5MfppKqRTRitE6CB6EPNTp9yP7cvuJ670ntDA==
X-Received: by 2002:a19:7007:0:b0:53e:3852:999c with SMTP id 2adb3069b0e04-543ea3d218dmr552015e87.12.1738215548145;
        Wed, 29 Jan 2025 21:39:08 -0800 (PST)
Received: from localhost.localdomain ([188.243.23.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb77e4sm66749e87.163.2025.01.29.21.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 21:39:06 -0800 (PST)
From: Alexander Shiyan <eagle.alexander923@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Alexey Charkov <alchark@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Fix broken tsadc pinctrl names for rk3588
Date: Thu, 30 Jan 2025 08:38:49 +0300
Message-Id: <20250130053849.4902-1-eagle.alexander923@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tsadc driver does not handle pinctrl "gpio" and "otpout".
Let's use the correct pinctrl names "default" and "sleep".
Additionally, Alexey Charkov's testing [1] has established that
it is necessary for pinctrl state to reference the &tsadc_shut_org
configuration rather than &tsadc_shut for the driver to function correctly.

[1] https://lkml.org/lkml/2025/1/24/966

Fixes: 32641b8ab1a5 ("arm64: dts: rockchip: add rk3588 thermal sensor")
Cc: stable@vger.kernel.org
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 8cfa30837ce7..978de506d434 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -2668,9 +2668,9 @@ tsadc: tsadc@fec00000 {
 		rockchip,hw-tshut-temp = <120000>;
 		rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
 		rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
-		pinctrl-0 = <&tsadc_gpio_func>;
-		pinctrl-1 = <&tsadc_shut>;
-		pinctrl-names = "gpio", "otpout";
+		pinctrl-0 = <&tsadc_shut_org>;
+		pinctrl-1 = <&tsadc_gpio_func>;
+		pinctrl-names = "default", "sleep";
 		#thermal-sensor-cells = <1>;
 		status = "disabled";
 	};
-- 
2.39.1


