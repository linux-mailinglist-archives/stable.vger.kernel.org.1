Return-Path: <stable+bounces-110353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E655BA1AFDE
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 06:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3773AE765
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 05:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB2C1D88AD;
	Fri, 24 Jan 2025 05:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkcPTj2R"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B11D799D;
	Fri, 24 Jan 2025 05:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737696398; cv=none; b=DbWh6d5W/KiHHlfjglPrPR3vps7Y+fy9U6VHZISZNss2ILxZvKqwhld/9cRN5xhDbWKxUK4y3Beax45k7Y+wmMz7d10mAM+kVSVl3Fp91vJzNUa7xm3QjPXStEamTuQ4MKFp+wam3I/ECjo7uhnthOHzfSHXwJ9rW5RsQEvR1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737696398; c=relaxed/simple;
	bh=r4a+eE9LCojwQ6hwvqRjbiT+5JFgFAGWcR7fILK8wmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qSzqf2u3H6Vrz+2RrOjbXvOF0vCuiLnPNw2MdHrr8zAaPxQStSAVAw39iLFZUov+Ce0aZa53z8wWnrJljHBld8BfvbwDYoDnaTHIAANxPj+UFwgSP8CgLlp3wvg7tmcpWr99wMJM9DwyZcwJZFeAU53ifVT+e1pF2Nwj3yuQwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkcPTj2R; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30036310158so14212611fa.0;
        Thu, 23 Jan 2025 21:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737696395; x=1738301195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p07sjty6xKqv6rCV4Fqi1eiP0EADaUe999Gk077M4nk=;
        b=nkcPTj2RE1erPvAWlbhWgJmeoStKYSBx0rUc3Pkb7nn0GSxEVxcuVGTatpKpyEgwwl
         0OAjs4GTvw5yeiWMnzVcwSic6h2i+xYobO54Th69rDCPMosEr+SCArFIN5FjB84wUTl+
         4LSYqFPKHOLYgPam/0y8Uee7dBZGTNuVExqfsKvsTGtmVDIbiL7BI4DGdMu+jaBw+npg
         EjW1G3llqgC/rQogsOmV7dFKQBrgrc0vUGl+oiS51L5gEDZkWZIzStjyyrlvbOkVch9M
         ZWem+iaR9J6bPe/8qrzmKK222BBaRYBYWfPmjWOkYziiT7R14iotUkSp1WOV6V2IH+yN
         sOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737696395; x=1738301195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p07sjty6xKqv6rCV4Fqi1eiP0EADaUe999Gk077M4nk=;
        b=nlkCRoyM5p+Cp/qpR8DoxEAZ9wWJFAT3i2lzKjEuJLG0t832GsNFrq38F9pxZpMhff
         b5UcqWRXKB4QUr7Y+KAH9d/94G4FUqIQTN8+gNsOtxb/0mSz5aF6PqZeV1AtmXuqX4AD
         +0cJHKsMJDGvAijU/oz5+RpF60F5p3S4Jqx03wfQ0Ct8fSAUxACillGUwTpuQKb54vIg
         nZH+0+JHOOVIPoxSz7gWg9D4dx/rs9/imvupUPZr1oRXGFMKTgldr8xF7oAQwiTd86sq
         YA7BC564lmaGjD5OJYxOVHW0DPM0nGY3vLPywmYfNU42JUa0DAv58dxBH6TqrwohYznm
         j8hw==
X-Forwarded-Encrypted: i=1; AJvYcCWwjGsVh4D++C0y/d1VlQSFI91JhXXZb2BXsltT9n/Vg4Cd7pantxKJ57qUtkXIgrulOQK2pYKMxfcRNWsJ@vger.kernel.org, AJvYcCWzexgiXA9tAoogxglk251Wvl+tzs/TNcVgnFf2yXR1LrclgVBGd15aM87AQsMMyiUQuVsHvFugzdUA@vger.kernel.org, AJvYcCXzoaqFonE+C4LvHtbBzhd1TdNL4J5thf2erRi09XOOOv277xogVRW3gguMoNunNQG/3E2FoAtP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jVYaIkrhNxBHOy/vSB1DOySL7iciT0XTwYpFkg9P663wEZML
	z4d6WlVE6IE/+Ebrqt8M8TovioVlEGz8ruGx+Wr0IlSCfBhA0HEj
X-Gm-Gg: ASbGncv6IuYnh4nchAGFlJAsLfeKXFKSpKIzwvLOdlp8VEtIsp0vdXTZKfGG18vhpJh
	ttozgoR792UyYq1ECqchEo8sYCnERezALZVnhiQkos2aXqTIzC7zjIKxjbhvQR2QGyd3edp6EDj
	mqpJ9UEQanOLNmOlxLJuPVLn8cwJx3Td+rE/kFT9Oi8yuMo8QwGnxc1ehu4jvr9nf5bBiFUSSVp
	IW8BFjvvKlCHvyOnyxEteu61ge9Sh3+qnjJlaDQMrxNExnL/u5Y1xsnOmFVXlk8EtSvLFz4e+4U
	A1Pxwr93AjmEeU4+/cDow5h8ZQG7
X-Google-Smtp-Source: AGHT+IFlqUx90XIioMXK3K5xnP0U9POjUttzeJEvX3ss+rSU2HenO99mLcexlPY8+ML+vDDZJVxQcA==
X-Received: by 2002:a2e:a263:0:b0:302:3abc:d9e2 with SMTP id 38308e7fff4ca-3072cb21f67mr76745751fa.29.1737696394396;
        Thu, 23 Jan 2025 21:26:34 -0800 (PST)
Received: from localhost.localdomain ([188.243.23.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076bc49f46sm2389441fa.105.2025.01.23.21.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 21:26:32 -0800 (PST)
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
Subject: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl binding for rk3588
Date: Fri, 24 Jan 2025 08:26:11 +0300
Message-Id: <20250124052611.3705-1-eagle.alexander923@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no pinctrl "gpio" and "otpout" (probably designed as "output")
handling in the tsadc driver.
Let's use proper binding "default" and "sleep".

Fixes: 32641b8ab1a5 ("arm64: dts: rockchip: add rk3588 thermal sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index a337f3fb8377..f141065eb69d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -2667,9 +2667,9 @@ tsadc: tsadc@fec00000 {
 		rockchip,hw-tshut-temp = <120000>;
 		rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
 		rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
-		pinctrl-0 = <&tsadc_gpio_func>;
-		pinctrl-1 = <&tsadc_shut>;
-		pinctrl-names = "gpio", "otpout";
+		pinctrl-0 = <&tsadc_shut>;
+		pinctrl-1 = <&tsadc_gpio_func>;
+		pinctrl-names = "default", "sleep";
 		#thermal-sensor-cells = <1>;
 		status = "disabled";
 	};
-- 
2.39.1


