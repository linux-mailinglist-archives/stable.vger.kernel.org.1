Return-Path: <stable+bounces-136717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEF0A9CCAE
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 17:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD2C1664DC
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175A27CB27;
	Fri, 25 Apr 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="PR1frhJw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC41267B6B
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594329; cv=none; b=SITovYERQW2uRglF1t1wb3SrgI4aiGDekPOSMsZb5erJ0uP7mCRlSi9mtZbPIo1d3oGfnXWbe8+dPtxKrSpnjkTTt6A/3F2RyLnKpbKOPAUFEY/g10SRjoNtpIW4/XcmsHvLTKPOvEWpoYSkoK6t9kV1G6YB6iSWypwLGhu08rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594329; c=relaxed/simple;
	bh=oNHQdseGba9iDo9kIAZ1Ni9JcRGkmGb+Y7y0dTTMQw8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J6eRkRmz9ew48a7Ve8vWJhm1h4akZXF8yzrtU2UYHVQC/Muec0k+AQ5vaeBGSvcaE0maLg6roNE3OkQ13yjwwbWtc/mfVeNlD7UlJJR3Pwuzmxs/qZCES7WOrKc9JzApKIidsURtxRtKl8z586LluoJtbESGHso0yvZTIdwg5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=PR1frhJw; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so361469066b.3
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1745594325; x=1746199125; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ghCaB0hzHCWB/lFbG9vF6MwKWZS9AGmGkqVTq/KrfM=;
        b=PR1frhJw27AALlQ/efJfVbTpeGPFq1KnIDmhbIe2ehkALQq+crll5mo1a2Nhaj4KiC
         zgimTKLMt5Hfnl0c74V//6UWlq50ElZ0WWQJeoAaqxPuJj5uKGfGxFxirh/cFFZRAMy2
         mzMAi2iYGcA8uEdLksoaCwuqCi4Pbt7WVachXVUGWqHNeffQLHZn6QQlRdXeMSrQgiJT
         6yJLclQTs3jHQI9yDmUFIvtEC0RvLlS1r9q/byyXDL0eH+9TiXV+2iORuv6npib25mxt
         KZR9neugJ6qISukWkAbTHQeU19IMk+Thy2m1j2rP8W6qnf7yRw3fol9NBHRf2XXC79NH
         4hhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745594325; x=1746199125;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ghCaB0hzHCWB/lFbG9vF6MwKWZS9AGmGkqVTq/KrfM=;
        b=wiTn3obo+mdZnzzzJFxmt4aDAj990m4ol888fDvNcIBStbGyxC2Z0hkQQmz4QcyRxG
         qC1gZ+Ao7xG1jHO+WS9y5lAPuwKdubqdzsvxOfuVsTEcgcMRrMQ0ZnWCR7L1YBAouCjj
         eZN4s57AHeZcS5g22oQaLq5Zr/2SnwfDObCW9io64JX+fahtY91PDWHSPSUaRphWY4TF
         vG8P71Aqbs6TtWBxmzuWFIoHSd6cAIxGQhkrUH0RPezC8Bb1hsFaBR0ygBRRom8Ukvfe
         TPVLT7eZWzYa+oaaZH7yLjPxuCX8JS6DRcFhleZ4UEYb0jqwsOfFDg6U7kHgXeFel7Qt
         m4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxP7WJipDQ5Je+YcImU7QJLvkPb7KdBZfWZM7+8AueQZ0FVjlHNlP6+DafxFa8ZxkOwatl5TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrl+a9KZew/LJVPzEtOkY1LauXqJabhA5dfgPegob8I0bxekY0
	lOMJZcOsDZXzvCuf7poFrq2A/9strhSRvr27F4vaxm7hS5X2+1usINQLr0p0XvNsiy5lPjmFE7A
	iyZE=
X-Gm-Gg: ASbGncvHcywMFWuZmB+z9QfhyImuUCrX4DeV1lbYM7xnbqCr3tX1n3B4+RTWuIzOfGL
	QkHO73qGKfi/GFDfULd8M58jRYswsMTLixpVwnEBYFhxy4FdLpCgz1h1YK0hDno/FZ2ThAKIcXF
	02BZMJOIGNe0at6NT2kiqx9v3/9iPP5Qaz/BMx6hItRNEEjnyf07oUoPSXaH9ZWWISK7zc/xIXu
	evZ1jJ2g5Is8ZJk5Knl38lWY68bunUCKen7btLs0VnIkzm3lcHTV9YHsWO619WQZaBF/FWFVKFf
	W3AXFkccJ3sHcPKk9JzqmnksD4CRLAe9lNMfvB+cOZvmVpnk7IqyHkoJ/mEkqWC0TD1C
X-Google-Smtp-Source: AGHT+IHZJ81zFkmLlmOHjq8b1Drpt97ks2gb1lVoqv7+XTRItZNdJHhWhZeKg3aZUqr8AUurmOKZUQ==
X-Received: by 2002:a17:907:6d27:b0:ac6:edd3:e466 with SMTP id a640c23a62f3a-ace710b0b78mr299551666b.19.1745594325144;
        Fri, 25 Apr 2025 08:18:45 -0700 (PDT)
Received: from [127.0.1.1] ([185.164.142.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e59649fsm151099766b.85.2025.04.25.08.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 08:18:44 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v2 0/5] Fix onboard USB hub instability on RK3399 Puma SoM
Date: Fri, 25 Apr 2025 17:18:05 +0200
Message-Id: <20250425-onboard_usb_dev-v2-0-4a76a474a010@thaumatec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK6nC2gC/3WOzW7DIBAGX8XiXCrAQLBPfY8qipYfxyvVdgLYa
 hXl3bt2Dj31+CF2Zh6spIypsL55sJw2LLjMNNRbw8II8zVxjLSZEsqIVlm+zH6BHC9r8ZeYNg6
 nIGwLDow0jK5uOQ34fRA/z7RHLHXJP4dgk/vr/6xNcsFBewEmSt+q8FFHWCeoKbyHZWLn50uQ0
 32l0vqy/IVS947W0vBYucc54nzlROdEx5A4QW5Q0X+lwqVzw4lUTnrdb2pv91COPxPWvnGtBg3
 WdbbrRCdACxultcqLFoYBnJfGRNJR1fMXyU7UBEcBAAA=
X-Change-ID: 20250326-onboard_usb_dev-a7c063a8a515
To: Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, stable@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2

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

This series depends on the patch:
Link:  https://lore.kernel.org/linux-usb/20250418-dt-binding-usb-device-compatibles-v2-1-b3029f14e800@cherry.de/
("dt-bindings: usb: usb-device: relax compatible pattern to a contains")

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
Changes in v2:
- Removed additional entries from onboard_dev_match table and
  updated dt-bindings list, as suggested by Krzysztof and Conor.
  Fallback compatible entry in SoM's dtsi file is used instead.
- Added vdd-supply and vdd2-supply entries to onboard hub nodes
  to satisfy bindings checks.
- Changed the default cy3304-reset pin configuration to pcfg_output_high.
- Added dependency to: change-id: 20250415-dt-binding-usb-device-compatibles-188f7b0a81b4
- Link to v1: https://lore.kernel.org/r/20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com

---
Lukasz Czechowski (3):
      usb: misc: onboard_usb_dev: fix support for Cypress HX3 hubs
      dt-bindings: usb: cypress,hx3: Add support for all variants
      arm64: dts: rockchip: fix internal USB hub instability on RK3399 Puma

Quentin Schulz (2):
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou

 .../devicetree/bindings/usb/cypress,hx3.yaml       | 19 +++++++--
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  8 ----
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 48 +++++++++++-----------
 drivers/usb/misc/onboard_usb_dev.c                 | 10 ++++-
 4 files changed, 48 insertions(+), 37 deletions(-)
---
base-commit: 834a4a689699090a406d1662b03affa8b155d025
change-id: 20250326-onboard_usb_dev-a7c063a8a515
prerequisite-change-id: 20250415-dt-binding-usb-device-compatibles-188f7b0a81b4:v2
prerequisite-patch-id: f5b90f95302ac9065fbbe5244cc7845c2a772ab6

Best regards,
-- 
Lukasz Czechowski <lukasz.czechowski@thaumatec.com>


