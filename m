Return-Path: <stable+bounces-126757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0920CA71BC0
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155261896406
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A471F8671;
	Wed, 26 Mar 2025 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="aaQ1J2Xv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3F1F4C9F
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006234; cv=none; b=qi54/2qLkB7DaSVxY9NmB+nCdDUYrTjVekFnh73fYYn6TNkrkDstuag6Wv+n05OHk/OSdT+ozVo/o2oBoozOTvYIkbLR/dF4holxAN0ILHfsyv+8hTXOUPkKAaAvERbyj+b4Qr6Uvrh1lBLNduYw5jOL8b6LhmcF/TsNZ97zhpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006234; c=relaxed/simple;
	bh=O/r8gbGACCdKsQpd9YaJGrSlEj//D5Z8hvnF0c8Mbxo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hKf6XbuV42H1Pfce7BfeREyfQR/KxsX0lKhCG9g/lt0jigGHe8zwRwze2U59uGHoRZ4pujX1RnYAVEMDKZQMVlysMxoAkd+T21w5IZR42DoWIlsah6W/MNmKikF9pnm44VXH14L2NWs/whnA4vUJUBWg2+WGqXk9yLnnYddfsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=aaQ1J2Xv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abbb12bea54so1813466b.0
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1743006229; x=1743611029; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKYanQIfYCncszgpyLAY2Jfcp3L50T71jyYK0/4Yps0=;
        b=aaQ1J2Xv/kKn9m8lRKyeMZvTwyLiN0Fc61PmVzA9H4mufDlqqtGz5IwOxqRILCrI9+
         amfw4dS3kGaMPBJwKnr20qI1rdaeULirbqG7KU01UMTGINRYhRf9RZ5Nzm8YXEkhHK06
         I6UTvp5sxlmkPPcpz2JYfaH5at0NxcsxMiFyo6VuqymDPonhj8uKYh7aHQfpGXIdImjs
         O27PwlMjAoZEj7cBBM5NHnWk6f9hgO8pFsqtBkdy0MuIq9iWRpZLhwCRkn3Ep8S2EzGU
         +51K7FZRqoVdAjWYxZbQBCOkGtNMGk/1rgsF1tCSZ+Qo1L9FWEn8btuPYhq8oiqs4ZGa
         YKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743006229; x=1743611029;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKYanQIfYCncszgpyLAY2Jfcp3L50T71jyYK0/4Yps0=;
        b=gtOZNNbhxJ/akUinqpkG43lltqcszgYXdCeYTPzgNXAHJrzPG+qXfEz5m33dGiImCR
         wPRDPjxwAKgPkd70woKgfRde12oAwDCjD3XrJo9SkfKyD8oO302+59+32GtI1KKX4KFn
         4oc4ljvlPxQCHSPOrNpbXBTwKHK56XBA9zwsLrXrpTUZ8KjAlTUSOKL1HDFoO1i0CAkb
         Y/zFrvCDqHF8ooYNSQh8g7490ZjZtfK1czYFZ0EJV2HRkZDb7HE5gziWc+I/hskRwUX2
         xMiWn2tNslyhF3OV9VOLGCiARY6BOGy3wXQwjkyN4DpdO3UgeXXm4F1fJjwIGDh8BFm8
         qbtA==
X-Forwarded-Encrypted: i=1; AJvYcCU2GNwjBILev51KMAemw97uShm+2n3eDLSZ7WouH/k4uuVpBStffJj0RbakxPqPDqIgfIe2qNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9VRV1W4k8tDNDFJZsYdC2MvZ0Uzu3VI2ALzZ2fPTHEzH1p0u
	V2U0eBP2UZLtBGO5VKZtEMEKt4QixXKi4ZJvwKR4bH4+egvyDbc1HkomYUBkaUA=
X-Gm-Gg: ASbGncsEjCpIFAgbKyUCS1OufrKXvRdCz06YItf0wkza57o8XxSgArWFNv+jSwMWrq5
	c1JxWoha09vTbD12HB9ObwjIlhbDEIkBAD/bwymZjaWBjnxnMlvyvMpXhMme2wo2tKfS4m6RyqT
	66soYpVCBLIzzD4IoJ+f8Ds9AVNnFQNmqVJNFO/b14MakgFKu5svlyn/I1ORT7CqY4Y7NuOGdrH
	/Eo5cEtUkTS1oBYNfKF1psamP0SwT75qqMe0hzGTFaXNmeYjDhABmmayLWpb3Erxd3NrkYnyNXT
	/WbHrKnyJxVVxemRirdSP0E9OjEaJYS6oyL4VK5h+RhEjDsEJGdgumk33w==
X-Google-Smtp-Source: AGHT+IHTxPRGm5mNkyz/LXIEUO2w8nqKfRSkk2yHl8zPEU3IqZLbPjnGdEzUK5cPc1Bb6wHgkTIrlA==
X-Received: by 2002:a17:906:7949:b0:abf:3cb2:1c04 with SMTP id a640c23a62f3a-ac6fae428c5mr5377966b.9.1743006229345;
        Wed, 26 Mar 2025 09:23:49 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6f0f498ecsm76678866b.135.2025.03.26.09.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:23:49 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH 0/5] Fix onboard USB hub instability on RK3399 Puma SoM
Date: Wed, 26 Mar 2025 17:22:55 +0100
Message-Id: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8p5GcC/x3MQQqAIBBA0avIrBPUsKKrRMSUU81GY6QIorsnL
 d/i/wcyCVOGXj0gdHHmFAtspWDZMW6kORSDM86b2jU6xTmhhOnM8xTo0tgupqmxQ289lOoQWvn
 +j8P4vh/3hyZEYQAAAA==
To: Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 quentin.schulz@cherry.de, stable@vger.kernel.org
X-Mailer: b4 0.13.0

The RK3399 Puma SoM contains the internal Cypress CYUSB3304 USB
hub, that shows instability due to improper reset pin configuration.
Currently reset pin is modeled as a vcc5v0_host regulator, that
might result in too short reset pulse duration.
Starting with the v6.6, the Onboard USB hub driver (later renamed
to Onboard USB dev) contains support for Cypress HX3 hub family.
It can be now used to correctly model the RK3399 Puma SoM hardware.

The first commits in this series fix the onboard USB dev driver to
support all HX3 hub variants, including the CYUSB3304 found in
the RK3399 Puma SoM. 
This allows to introduce fix for internal USB hub instability on
RK3399 Puma, by replacing the vcc5v0_host regulator with
cy3304_reset, used inside the hub node.
Please be aware that the patch that fixes USB hub instability in
arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi can me merged only
after updating the Onboard USB dev driver, otherwise the hub
will not work. 

Two last commits in the series disable unrouted USB controllers
and PHYs on RK3399 Puma SOM and Haikou carrier board, with no
intended functional changes.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
Lukasz Czechowski (3):
      usb: misc: onboard_usb_dev: fix support for Cypress HX3 hubs
      dt-bindings: usb: cypress,hx3: Add support for all variants
      arm64: dts: rockchip: fix internal USB hub instability on RK3399 Puma

Quentin Schulz (2):
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou

 .../devicetree/bindings/usb/cypress,hx3.yaml       |  6 +++
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  8 ----
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 43 ++++++++++------------
 drivers/usb/misc/onboard_usb_dev.c                 | 10 ++++-
 drivers/usb/misc/onboard_usb_dev.h                 |  6 +++
 5 files changed, 39 insertions(+), 34 deletions(-)
---
base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f
change-id: 20250326-onboard_usb_dev-a7c063a8a515

Best regards,
-- 
Lukasz Czechowski <lukasz.czechowski@thaumatec.com>


