Return-Path: <stable+bounces-118595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE56A3F6FD
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BCC19C0F98
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A5C20E71E;
	Fri, 21 Feb 2025 14:15:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6021C1AAA;
	Fri, 21 Feb 2025 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147314; cv=none; b=SBsTgLzzzo0fkXqhvJB4DoXzcd+d2+axjAB/emu/TYKxXzXwzq1t0kZpTmZ1HKLjZWqhnBJRnwvBG1fNrUo+1nnrJEl6tIrjJENfYkKQZBydicU0DrlRh7iFZ9lDgWPjKE5pbPYz0xAqAuzbQHqOx1DTjDkxY5JP2QxgvTgj7DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147314; c=relaxed/simple;
	bh=KWJsaOGT1S2BOpWR5uwWI86Z7VASm2XxQy/u07uzcZw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LkYJP+85o+BpSB8EXeQb1mf9V8pAOqjXrdp31Re7xCCy9TTK37pGS1EN7YVyvbwPDl4s87ZKgzSg2cJcmEiY+eE2my7m44bOuR8KuSXqq5nLP6bAmLWgIfg7/wCTonLLt01eOBRyApLRhoypBzRS1axO+KCuQBLe9liBCWXbYgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YzsMb73YXzCBl;
	Fri, 21 Feb 2025 15:04:59 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YzsMb1kxCzQ1x;
	Fri, 21 Feb 2025 15:04:59 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH v2 0/5] arm64: dts: rockchip: pinmux fixes and support for
 2 adapters for Theobroma boards
Date: Fri, 21 Feb 2025 15:04:32 +0100
Message-Id: <20250221-ringneck-dtbos-v2-0-310c0b9a3909@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPCHuGcC/12Py26EMAxFfwVlXVfBIQGz6n9UswiJGaJqYOpQN
 KMR/14ei0pdHks+996XyiyJs2qLlxJeUk7TuAG+FSoMfrwypLixQo1Wl9iApPE6cviCOHdTBmq
 0qxpDxlpW29NduE+PQ/h5OVn4+2fzzufxT7ul7FIsCe7BU+0eIJx5hihpYYFA3pNtHFXo2gV3e
 +czQ5hutzS3hWPWHfloiCyz7T0iaWODI12aro5RR+NM1am9x5DyPMnz2LmUR5EzHfX/SUsJGtA
 Gqns0jWX3EQYWeb5HVpd1XX8BWRURDTQBAAA=
X-Change-ID: 20250128-ringneck-dtbos-98064839355e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

This is based on top of
https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/log/?h=v6.15-armsoc/dts64
6ee0b9ad3995 ("arm64: dts: rockchip: Add rng node to RK3588") as it
depends on the (merged) series from
https://lore.kernel.org/all/20250211-pre-ict-jaguar-v6-0-4484b0f88cfc@cherry.de/

Patches for Haikou Video Demo adapter for PX30 Ringneck and RK3399 Puma
(patches 4 and 5) also depend on the following patch series:
https://lore.kernel.org/linux-devicetree/20250220-pca976x-reset-driver-v1-0-6abbf043050e@cherry.de/

This fixes incorrect pinmux on UART0 and UART5 for PX30 Ringneck on
Haikou.

This adds support for the HAIKOU-LVDS-9904379 adapter for PX30 Ringneck
fitted on a Haikou carrierboard.

Additionally, this adds support for Haikou Video Demo adapter on PX30
Ringneck and RK3399 Puma fitted on a Haikou carrierboard. Notably
missing from the overlay is the OV5675 camera module which expects
19.2MHz which we cannot exactly feed right now. Modifications to the
OV5675 drivers will be made so it's more flexible and then support for
the camera module will be added. This adapter has a 720x1280 DSI display
with a GT911 touchscreen, a GPIO-controllable LED and an I2C GPIO
expander. Support for this adapter on RK3588 Tiger is being added in a
separate patch series[1].

Note that the DSI panel currently is glitchy on both PX30 Ringneck and
RK3399 Puma but this is being tackled in another series[2]. Since this
will not be fixed through DT properties for the panel, adding the DT
nodes for the DSI panel even if not perfect right now seems acceptable
to me.

[1] https://lore.kernel.org/linux-rockchip/20241127143719.660658-1-heiko@sntech.de/
[2] https://lore.kernel.org/r/20240626084722.832763-1-heiko@sntech.de

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- rename uart5_rts_gpio to uart5_rts_pin to stop triggering a false
  positive of the dtschema checker,
- remove PU from uart5_rts_pin,
- Link to v1: https://lore.kernel.org/r/20250220-ringneck-dtbos-v1-0-25c97f2385e6@cherry.de

---
Quentin Schulz (5):
      arm64: dts: rockchip: fix pinmux of UART0 for PX30 Ringneck on Haikou
      arm64: dts: rockchip: fix pinmux of UART5 for PX30 Ringneck on Haikou
      arm64: dts: rockchip: add support for HAIKOU-LVDS-9904379 adapter for PX30 Ringneck
      arm64: dts: rockchip: add overlay for PX30 Ringneck Haikou Video Demo adapter
      arm64: dts: rockchip: add overlay for RK3399 Puma Haikou Video Demo adapter

 arch/arm64/boot/dts/rockchip/Makefile              |  15 ++
 .../px30-ringneck-haikou-lvds-9904379.dtso         | 130 ++++++++++++++
 .../rockchip/px30-ringneck-haikou-video-demo.dtso  | 190 +++++++++++++++++++++
 .../boot/dts/rockchip/px30-ringneck-haikou.dts     |  10 +-
 .../rockchip/rk3399-puma-haikou-video-demo.dtso    | 166 ++++++++++++++++++
 5 files changed, 510 insertions(+), 1 deletion(-)
---
base-commit: 6ee0b9ad3995ee5fa229035c69013b7dd0d3634b
change-id: 20250128-ringneck-dtbos-98064839355e
prerequisite-change-id: 20250219-pca976x-reset-driver-c9aa95869426:v2
prerequisite-patch-id: 25c49bae002eb11bc6fec479f49f5e3b28b8f403
prerequisite-patch-id: 58e9acffbbd052710bfe672c99ef05f59b1978a6

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


