Return-Path: <stable+bounces-192179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5435C2B110
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 11:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B52704EFA56
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 10:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3482FDC4B;
	Mon,  3 Nov 2025 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIRx212w"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA82FBDFD
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165804; cv=none; b=scIj7fCkckk3ct7MWjMZoPma22TEedPyrNKQyNZ88Z7DkaauSFgpMr3TM9VoVY9P2LLdlXnZpU0TMEERP4QW255iQhAXbguSKvnGpDOS6rN6QOTpVK/l9lj0oUzJ9Kb758+rAMrALGkwmAdxXPPn3zDGdGqM6nkR5kRXQvvCQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165804; c=relaxed/simple;
	bh=k9/nI+h5bOtp7UwnkH+5NqaeML64f2gcGu3Wmd92Oi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7+yl8Ey2MQ9W8RjQCzroGMi39emehDsvRzr63//BgeX47A7Mcx1UGmBgCErYZlOzquFILLv/eHpgpwciUScqkXuS0Z0cxxiwXaQbv8F+BAD8bPbPo/3PrGj4AXVuFYP3Cr9v2BkmJDyopxBdfJqO81QUm0mgr1NPTtBljYQ4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIRx212w; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d3effe106so645971166b.2
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 02:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762165801; x=1762770601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uol8SK9zB104eiF162tGqib2QMloTOnkfiMZtp2mug=;
        b=dIRx212wX8G9uDTFtJ8QqC/z5IaT3YlQsMmHA1l8TxuLrtBaU8lsMr0GRV7esYTxrd
         1W73IJ9FiYOzPVPDVSm7dzI2LXHCCCfoYKV7pbKltUet/P/ScG34YkBgPyIhsXvxKmZN
         r4FTAWmcGFiSX4jmqbDGxdSkffEgK+ALCZ5pxK9kPzDjC+A25SZ1ywUk5Xoz02SAENdi
         fcakJaouU9j2h8+3oWE35HumyxMejkg6x/yNqe5UNpc/K4lMUUQ2UxvZKVI+Yb4MlXOt
         NPGOxuKtneOWEO5b8RN8VkY/6Tv30Ht1d4RJggnXFiNSLb5/XKEDmOuwYrQAi/aW8CZu
         Ygnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165801; x=1762770601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uol8SK9zB104eiF162tGqib2QMloTOnkfiMZtp2mug=;
        b=POPgx+/ifbq49iOMetW6jxWdkj4TFjj+nunhkRJ5EkAa3M8vanYSVWjj6yM0wmWzed
         V3tuU6F13a/kyUzdgcH139S+Ha7VLFv7D50TJqY2oLtEu2Y+YUuqhC6uoTjnkz5Umx3E
         CNoWvck9XLlLDKZi4nJJefFR0oiDzGnhXwT1GfwDU0KSj3PoXpElPoIrSgW4YmLUnZWX
         YxKriNmHnzU7ZyjVs6QhwaUplyM5DY3ETiNEfV+HARp+SGDjWyB/laLF7gPdlVeVS9C/
         jg8PjWcaIUfqNK86ZlxAxJlkWGtW8SMTP5QfKas5tRYUixFJ1opxYLq15uw4kbfeh6nQ
         HG9g==
X-Gm-Message-State: AOJu0Yx0IoHKr3voZN/BXHvBKDWIqWunsrWZ7eFBFmRkQ7Sb2G+nzo7P
	jOiMu/FFshsYhvmm1kYcC4jlu38bBypsN4LjkBIoCcVGNxszD2VBe14K
X-Gm-Gg: ASbGncuxEiYrkr8wWQhpLKmo32P/6KlQTRjQyJ6V5bRrbXsEhfog+Mj2WxUqTnV2IlI
	ItUVTxsGiIqFrSjWdkHss6XQ4NDir1sHoijTD8VDcVZeURs7r3731Ex1ZgVLjwbqPYzIA+nLRW1
	EXL2yZHUK6JfihVHJ0FHno/0xa/VnPVULiHpkC5XnDf5OeV3hif87SoXOlfQGJyQmKXchIiiGt5
	KM2yG88yHzo+Y0+nDB8V+ikrmveAXBwVTRdAVlCmCUnAjsz3IpvCPW+F29FGkSNJ+Zxrdztaj98
	ZvEEd+wkZa3HBx7p8MAs0pD42z5OmoZd9DgjNmT9ps7xySCi/Q90cKCamTqZ/zYTPFFkQ9iV9Y4
	dOZlIYVBgyrS6U/Qb+yoFplY8eHS9JhD9dBX8zDWkHXKKi7fOdczwRyElBhCzgYxiGbt3ewjhLW
	ixwVdYkzt/MJEt8wE/Riqu2Chc5h989xNP
X-Google-Smtp-Source: AGHT+IFzeqw0ZeFTmoI7Ikvy2aB+JcBqMNqP5GohkKyfHRJfwjd2EG3S5q7dA3xFkhtZeKZ3AHM9dA==
X-Received: by 2002:a17:907:7252:b0:b6d:2682:8306 with SMTP id a640c23a62f3a-b7070198c2dmr1296081666b.23.1762165800923;
        Mon, 03 Nov 2025 02:30:00 -0800 (PST)
Received: from EPUAKYIW02F7.. (pool185-5-253-81.as6723.net. [185.5.253.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975d77sm1005193966b.9.2025.11.03.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:30:00 -0800 (PST)
From: Mykola Kvach <xakep.amatop@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Johan Jonker <jbx6244@gmail.com>,
	Michael Riesch <michael.riesch@collabora.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Muhammed Efe Cetin <efectn@6tel.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3] arm64: dts: rockchip: orangepi-5: fix PCIe 3.3V regulator voltage
Date: Mon,  3 Nov 2025 12:27:40 +0200
Message-ID: <cf6e08dfdfbf1c540685d12388baab1326f95d2c.1762165324.git.xakep.amatop@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9232ae8cc8e7eb4f986734c8820f44b7989b9dae.1762161839.git.xakep.amatop@gmail.com>
References: <9232ae8cc8e7eb4f986734c8820f44b7989b9dae.1762161839.git.xakep.amatop@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vcc3v3_pcie20 fixed regulator powers the PCIe device-side 3.3V rail
for pcie2x1l2 via vpcie3v3-supply. The DTS mistakenly set its
regulator-min/max-microvolt to 1800000 (1.8 V). Correct both to 3300000
(3.3 V) to match the rail name, the PCIe/M.2 power requirement, and the
actual hardware wiring on Orange Pi 5.

Fixes: b6bc755d806e ("arm64: dts: rockchip: Add Orange Pi 5")
Cc: stable@vger.kernel.org
Signed-off-by: Mykola Kvach <xakep.amatop@gmail.com>
Reviewed-by: Michael Riesch <michael.riesch@collabora.com>
---
Changes in v3:
- add "Cc: stable@vger.kernel.org" to commit message.

Changes in v2:
- add Fixes tag and Cc stable list as requested during review.
---
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
index ad6d04793b0a..83b9b6645a1e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
@@ -14,8 +14,8 @@ vcc3v3_pcie20: regulator-vcc3v3-pcie20 {
 		gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
 		regulator-name = "vcc3v3_pcie20";
 		regulator-boot-on;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <50000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
--
2.43.0


