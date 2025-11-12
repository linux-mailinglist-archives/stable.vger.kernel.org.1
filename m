Return-Path: <stable+bounces-194584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7169EC51719
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E63418892C7
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9190D2FDC3C;
	Wed, 12 Nov 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lF6rbkkr"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9962DC76C
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940735; cv=none; b=YA404F51kpjJmv/nIP/TxF7jJwx7eRZL75KAwtosLOw12rgmnxObliEK85X0A1JLcFXJCWNW6zJKp3XkVFpVQJjF0NIbRwUnilA9lNm1DbwwgniM+TdROp9bl8VG5zNtAlvo0Bqc0rxWSzebs0Cc3oSrvbH22IWzBpEeLKhpaA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940735; c=relaxed/simple;
	bh=i5bxHK+Y1Pvu4sadSofQXj8FeFSzboJZN11a1NbehdY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rvO3hKA8oPXaHq0HyqAUcePVoi4+zmpEheyfu6uoCI/vPUmIlPDLFemjhl5obaIYKYbtqJt33TwxoJQkv0GhXTr+6d1AkgtpWgnrIpsuPFkSiIz9fBmylzr7A3mGPqICQoI37rdw+olS3BEPpVUD2w8FodyNF1aLgZqu6vMiP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lF6rbkkr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2BB25C0F55A;
	Wed, 12 Nov 2025 09:45:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B61A56070B;
	Wed, 12 Nov 2025 09:45:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 503B510371994;
	Wed, 12 Nov 2025 10:45:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762940730; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=qiBNehCn/nTWZVvPu+1aXSnGzEQDBTrJCYkHVMIegP4=;
	b=lF6rbkkrna3Lu+3GZu7KxKnGVu7Uh50UsHu0Bp8Cs6ZZgEQcXLgRhjfP21XwcDwv3SzRjs
	QFnsGwS+9XkpRMrA9Vixt2eH+dPlGxCjIbSE3bs6atn1ky7D+APwCsKjVMP5qJiat2fjOA
	5pkTS+ZO7qedyqx4gLelVAWiFBID0OJDCST6azP8skJkWbiVwrg7/IR2IER2hkcd0rY7fW
	UKpK0k2lsOeSuce1eBYlfwWJYRRgdsz7ChpwIuqGV9WZORzw7XMwvmbr52IeWlQLnb1Uwa
	+uDTcuG41q3QzBzLrpvWIHAHUa9Y+CEfJ+a2kzRyyhvulSHUcIFtAW9tAXXF2A==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Subject: [PATCH v3 0/2] Enable 1GHz OPP am335x-bonegreen-eco
Date: Wed, 12 Nov 2025 10:45:23 +0100
Message-Id: <20251112-fix_tps65219-v3-0-e49bab4c01ce@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADNXFGkC/3WMyw7CIBBFf6WZtRiYtlRd+R+mMZWHnUShAUJsG
 v5d7N7luTfnbBBNIBPh0mwQTKZI3lVoDw2oeXJPw0hXBuTYC8Els/S5pyXKHsWZaS1RdEIjKgt
 VWYKp/567jZVnismHda9n/K1/QhkZZ9OgJT+pDge014f36UXuqPwbxlLKF47w/4eqAAAA
X-Change-ID: 20251106-fix_tps65219-dd62141d22cf
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Lee Jones <lee@kernel.org>, Shree Ramamoorthy <s-ramamoorthy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Bajjuri Praneeth <praneeth@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The vdd_mpu regulator maximum voltage was previously limited to 1.2985V,
which prevented the CPU from reaching the 1GHz operating point. This
limitation was put in place because voltage changes were not working
correctly, causing the board to stall when attempting higher frequencies.
Increase the maximum voltage to 1.3515V to allow the full 1GHz OPP to be
used.

Add a TPS65219 PMIC driver fixes that properly implement the LOCK register
handling, to make voltage transitions work reliably.

Changes in v3:
- Remove an unused variable
- Link to v2: https://lore.kernel.org/r/20251106-fix_tps65219-v2-0-a7d608c4272f@bootlin.com

Changes in v2:
- Setup a custom regmap_bus only for the TPS65214 instead of checking
  the chip_id every time reg_write is called.
- Add the am335x-bonegreen-eco devicetree change in the same patch
  series.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
Kory Maincent (TI.com) (2):
      mfd: tps65219: Implement LOCK register handling for TPS65214
      ARM: dts: am335x-bonegreen-eco: Enable 1GHz OPP by increasing vdd_mpu voltage

 arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dts |  2 +-
 drivers/mfd/tps65219.c                             | 49 +++++++++++++++++++++-
 include/linux/mfd/tps65219.h                       |  2 +
 3 files changed, 51 insertions(+), 2 deletions(-)
---
base-commit: 1c353dc8d962de652bc7ad2ba2e63f553331391c
change-id: 20251106-fix_tps65219-dd62141d22cf

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


