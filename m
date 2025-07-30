Return-Path: <stable+bounces-165503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C566B15F19
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 13:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FF3162C89
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149F1E32DB;
	Wed, 30 Jul 2025 11:11:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80118C928
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873877; cv=none; b=gWMNBecNdcld0TusKczGKjoGP7nOC3rTt+bvCOzTP+Fv7Uz4OeMPGaNy/0wpvvuvn5eWX1A92Lz51szHtK67AOzlUZcteJi+HvQ0KaYUbeVXBEDn5jvizguNu2190DqnkqPCdI0BL3WCQXXAJT7dKR/29zdROOESGGHc3w/daQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873877; c=relaxed/simple;
	bh=/3Q+xjsxdcuJ/QBIitJb0wEd2BwfmEVX0eUDol4kiBI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kISicx9YTw2dgnbbrgh5MZ1sFxLdF1Z2AVRXgZwZN2sm5+cxaPnE1SpQDuAwJUQjhj9zn297DnLSLMYZ43lFdUwuKCoMwOfFVUkC2e2bZhYf2pAcrdQRWsm5iLp7CoIJw0AGz3G8lpHBHBkssKDMglawOPPLWs4B7zp0lzkQ0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bsTzb2Vd0zY4w;
	Wed, 30 Jul 2025 13:11:07 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bsTzZ0x18zxZk;
	Wed, 30 Jul 2025 13:11:06 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/6] rockchip: puma-rk3399: anticipate breakage with v6.16
 DT
Date: Wed, 30 Jul 2025 13:10:16 +0200
Message-Id: <20250730-puma-usb-cypress-v1-0-b1c203c733f9@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJj9iWgC/02OQW7DIBBFr2LNukgwQAy+ShVZA4xrFrYTiKNUU
 e4eknTR5fvSf3p3qFwyVxi6OxS+5pq3tYH66iDOtP6wyKkxoEQrey3FaV9I7DWI+HsqXKvAhN7
 2Eo1BA+3W1inf3srv44cLn/dmvnxGCFRZxG1Z8mXoLLmUkGV0xiltg43+QBN6ReQP3HuK0aPmC
 P+Lhu7dY9C+UsZtDRuVNM57GP+yxvmmBTqtvNOT4sTD1cDx8XgCOI7dfPEAAAA=
X-Change-ID: 20250730-puma-usb-cypress-2d2957024424
To: Klaus Goger <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Rob Herring (Arm)" <robh@kernel.org>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, stable@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

Due to updates to the Device Tree (migrating to onboard USB hub nodes
instead of (badly) hacking things with a gpio regulator that doesn't
actually work properly), we now need to enable the onboard USB hub
driver in U-Boot.

This anticipates upcoming breakage when 6.16 DT will be merged into
U-Boot's dts/upstream.

The series can be applied as is before v6.16 DT is merged or only the
defconfig changes after 6.16 DT has been merged.

The last two patches are simply to avoid probing devices that aren't
actually routed on RK3399 Puma, which is nice to have but doesn't fix
anything.

Note that this depends on the following series:
https://lore.kernel.org/u-boot/20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Lukasz Czechowski (2):
      dt-bindings: usb: cypress,hx3: Add support for all variants
      arm64: dts: rockchip: fix internal USB hub instability on RK3399 Puma

Quentin Schulz (4):
      configs: puma-rk3399: enable onboard USB hub support
      dt-bindings: usb: usb-device: relax compatible pattern to a contains
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou

 configs/puma-rk3399_defconfig                      |  1 +
 dts/upstream/Bindings/usb/cypress,hx3.yaml         | 19 +++++++--
 dts/upstream/Bindings/usb/usb-device.yaml          |  3 +-
 .../src/arm64/rockchip/rk3399-puma-haikou.dts      |  8 ----
 dts/upstream/src/arm64/rockchip/rk3399-puma.dtsi   | 48 +++++++++++-----------
 5 files changed, 43 insertions(+), 36 deletions(-)
---
base-commit: 5a8dd2e0c848135b5c96af291aa96e79acc923ec
change-id: 20250730-puma-usb-cypress-2d2957024424
prerequisite-change-id: 20250425-usb_onboard_hub_cypress_hx3-2831983f1ede:v4
prerequisite-patch-id: 515a13b22600d40716e9c36d16b084086ce7d474
prerequisite-patch-id: 9f8a11bd6c66e976c51dc0f0bc3292183f9403f3
prerequisite-patch-id: 45ef5b9422333db5fcd23d95b6570b320635c49b
prerequisite-patch-id: 19092f1c3db746292401b8513807439c87ea9589
prerequisite-patch-id: fced7578d40069c5fe83d97aa42476015cf9cbda

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


