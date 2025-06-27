Return-Path: <stable+bounces-158781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C9CAEB8AC
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 15:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4B917B984
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A362D3EF3;
	Fri, 27 Jun 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf/5xaLD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE92F1FDF;
	Fri, 27 Jun 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751030266; cv=none; b=Be6FgaCGorPRfjnz+4XxH09kSu+FVDUTs6np3pDgKNm/3VLjLAtO0kd4+2QzFFMyIemGKZrFiC0BHh3tHOGe+eYJWMgQZtHfw00nRZUX1kjSapsJ3KxPxbOy/4QA89YIhE8glHwZlKXziHeis+dKe5OvvDYKhe8QBEyw9bps4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751030266; c=relaxed/simple;
	bh=opTsP10y/AWCBBhzQwoL4YDgiNtc2a1QNoEd6hSSHec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Yz/NH8N+YK6e0IxMyjWV9q8DDZ/JOnLYk2y+XScEbvs0ivADIxYomTkSAoFMyE4yUdz2Zu4a8p8V1To8q/nUSqDy+xkXb0DqR90aTsVtJHctsoEacSRj2n1v4RW/ZRefPXO1JXd4/yW2pR4c6VO+mKPPQ7Lpbh97L1ealD6Elv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf/5xaLD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso4115438a12.0;
        Fri, 27 Jun 2025 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751030263; x=1751635063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgOdRzeLiUyb+th+vZ8OE4pKfRDS2CiYAzgM2DeadJs=;
        b=Qf/5xaLDuulecXENBQnSZXstheLjnHr2IfmPBjLgFAnsdnumbqWBcXMYCvR/rOYcLt
         RBGFkOMOnGONvwNlxGmSXQD+5FuQxydJRoU/J8Us5DySof1XN+3m3X2sCNG+ETqxUWpG
         JQ8TGOQ32rL6PXpGZZxihQeen2KGx4RhhQsMO0N1V9FM24foZ0FeACVdiRjhh+ETa5fS
         +9N/68ylngyHqufXXXmYExWV92hCRe2WnQgKBgHrk5chmqdSpKgV3CpXEn8X9dgKQWzm
         tNSN9Vk9urumXsYOvw+FYySt4LP38b7IY9+PZKmeUR+2lfIEnZGPbHq1d8p5zWaQ/uYU
         8zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751030263; x=1751635063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgOdRzeLiUyb+th+vZ8OE4pKfRDS2CiYAzgM2DeadJs=;
        b=RjaUxa7NDLZcAq8xQBECTbI/P56CRD2K3c5SL5yI1nlgNx5Pb2kbLCrtQZE7C7GfWG
         RiidXaBXSt3zCODzeAzm+Pw8Wn+wFDXXWpUSoESfp/oCV4k5bWYPjGuTEJXJvmW9fpn5
         CC7A5/X2DzaZdhb+lS0Xfz8GNijq+kGfP5ClIlzWfMsNVzyLEBqrf+1aomuslCxL0Buf
         50HXJifEiztR5nNm8kq4zEOMzUTanLQq1nCY//T5WNF/DOhKr/wFE4ld+YXwsn1M9R6m
         nOhKErMlvNkudUvdMfjIdCCJ24TZoo2YEwmNu5IeR3LxmiuAwudhN7y7xCT5inQ0BRT3
         aRSA==
X-Forwarded-Encrypted: i=1; AJvYcCWKsoPFElUlLTvBQEttl5RZexjQyTESHv5iv38LCt9HMkSSUWYbZtfk9E9J6WR88BUyMDQd12Cco3pt2i8O@vger.kernel.org, AJvYcCXdcmoUvZ6jQmxcPiunGHdEARMq7zVqTC2MkqSPWZpnjYAxbY2BpviFMPhSkNmFn0vtL7MzUXlpmGHC@vger.kernel.org
X-Gm-Message-State: AOJu0YzMeAuaX/EEtRAD+a73Vm0dLaxq/RsPA/BdlpKtjAMXY47/mouq
	44Bo0jIth0cNZJE2OQxkp40sUzu/hjH/XuIBzMgfoJG5SG9oJ1HwqWVa
X-Gm-Gg: ASbGncs5onrrW8ZLWsO3tYa0sVrh9St+WE2xhbf68ee4A+hWGqQdTJ9GwMyKX6VTQaU
	6bMG0obrfBa0MdW2p3sGeNzPh9xfJBCfi4Yc3q2qwhVoc+UU2UmeA1NVL5thS5/c9czlc7bAzH9
	DNXdlS1O66trvylRx+x8AjvYWCwt30Qhu+sCntdgs27yXGhQeY8s+Ewmr+/PAtPA2RUbt7HggjK
	x7899+5ALsMQJCCxCGiRczq0J7kcmeSPyUR+L2vV0GFv+7lUYCbpG1RE9KQPClY+8lhZLVa9226
	Ovb0q4xs4wdZgIxqQivdbEUk/qDk3nkQZqOWIPfRCTTU5Nh2AwQb3FVGK75Wu3LNVge+z5Wime5
	nzBCxQWb09MNAdcKSOZVZiknJdQZAGla5ZUBbI3jQ
X-Google-Smtp-Source: AGHT+IFeDwRVWmFdmXrateAqMmllYMK2zntwA1WZ2gBdjY3aP4MNxSK4Z7UA17+I+Adl/DbaSrC1jg==
X-Received: by 2002:a05:6402:84e:b0:60c:79de:1c59 with SMTP id 4fb4d7f45d1cf-60c88b3e392mr2714318a12.7.1751030263064;
        Fri, 27 Jun 2025 06:17:43 -0700 (PDT)
Received: from localhost.localdomain (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c83205eb0sm1471143a12.72.2025.06.27.06.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 06:17:42 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: stable@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: use cs-gpios for spi1 on ringneck
Date: Fri, 27 Jun 2025 15:17:12 +0200
Message-Id: <20250627131715.1074308-1-jakob.unterwurzacher@cherry.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

Hardware CS has a very slow rise time of about 6us,
causing transmission errors when CS does not reach
high between transaction.

It looks like it's not driven actively when transitioning
from low to high but switched to input, so only the CPU
pull-up pulls it high, slowly. Transitions from high to low
are fast. On the oscilloscope, CS looks like an irregular sawtooth
pattern like this:
                         _____
              ^         /     |
      ^      /|        /      |
     /|     / |       /       |
    / |    /  |      /        |
___/  |___/   |_____/         |___

With cs-gpios we have a CS rise time of about 20ns, as it should be,
and CS looks rectangular.

This fixes the data errors when running a flashcp loop against a
m25p40 spi flash.

With the Rockchip 6.1 kernel we see the same slow rise time, but
for some reason CS is always high for long enough to reach a solid
high.

The RK3399 and RK3588 SoCs use the same SPI driver, so we also
checked our "Puma" (RK3399) and "Tiger" (RK3588) boards.
They do not have this problem. Hardware CS rise time is good.

Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
Cc: stable@vger.kernel.org
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
v2:
* Rename spi1_csn0_gpio -> spi1_csn0_gpio_pin to make CHECK_DTBS=y happy
* Add pinctrl-names = "default";

v1: https://lore.kernel.org/all/20250620113549.2900285-1-jakob.unterwurzacher@cherry.de/

 .../boot/dts/rockchip/px30-ringneck.dtsi      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index ab232e5c7ad6..4203b335a263 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -379,6 +379,18 @@ pmic_int: pmic-int {
 				<0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	spi1 {
+		spi1_csn0_gpio_pin: spi1-csn0-gpio-pin {
+			rockchip,pins =
+				<3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
+		};
+
+		spi1_csn1_gpio_pin: spi1-csn1-gpio-pin {
+			rockchip,pins =
+				<3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
+		};
+	};
 };
 
 &pmu_io_domains {
@@ -396,6 +408,17 @@ &sdmmc {
 	vqmmc-supply = <&vccio_sd>;
 };
 
+&spi1 {
+	/*
+	 * Hardware CS has a very slow rise time of about 6us,
+	 * causing transmission errors.
+	 * With cs-gpios we have a rise time of about 20ns.
+	 */
+	cs-gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_LOW>, <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_clk &spi1_csn0_gpio_pin &spi1_csn1_gpio_pin &spi1_miso &spi1_mosi>;
+};
+
 &tsadc {
 	status = "okay";
 };
-- 
2.39.5


