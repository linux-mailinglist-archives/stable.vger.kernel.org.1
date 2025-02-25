Return-Path: <stable+bounces-119491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAC2A43E5D
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9850D1891B1A
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CB1268689;
	Tue, 25 Feb 2025 11:53:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D3267B68;
	Tue, 25 Feb 2025 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484437; cv=none; b=ZgOpkOgvjM/IVIuW1Dw+3/qUL3hkHAK3JSNIUb8eisOXyQQlFqXBhE4Fk9VOVqdGdyd1vdsYl4h6R46ihxfATMASlLM9Rmia4Xf6/OsDWVa/e9+6/QDEnbPC+jRpybKLlMWLNLl6IXBzNHZSx9ZWHHQJBGxCzZ/sNlnlK9GMKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484437; c=relaxed/simple;
	bh=dx0paW1XXGEswbA7ADG98ypf6WUd+7n/4OD+oZNYXC0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eYfNVQJTmzZznYbXWLSS/6hngrUS5Eaa0bu9Zl+ulw3Acw6LGAPJzbdW7/oE8jcqdnIQDIYtgeZk0wKJYM7gGngpWT/WHOQb2ES1vVjqpyo9iiVzbV5wrlsjAi8uAgLMN3Mf83iQ2z7llOjH5EPCcu+Ytys093JxU8/qhhlmXDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z2GGM4jjDzRm0;
	Tue, 25 Feb 2025 12:53:47 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z2GGM06hSzC3b;
	Tue, 25 Feb 2025 12:53:46 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH v3 0/2] arm64: dts: rockchip: pinmux fixes for PX30
 Ringneck
Date: Tue, 25 Feb 2025 12:53:28 +0100
Message-Id: <20250225-ringneck-dtbos-v3-0-853a9a6dd597@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADivvWcC/2WNwQ6CMBAFf8X0bE27tdh68j+MBygLNCagW2wkh
 H+3wEGix3nJzBtZQPIY2Hk3MsLog+/aBGq/Y67J2xq5LxMzEKCFBMPJt3WL7s7LvugCt0ZkR6O
 s0hpZkh6ElX8vwettZcLnK3X779j40Hc0LKdRzuvaBxC//Si54KCdPVWgjMbs4hokGg4lsjkVY
 avLPx2SrqRworC5ssJu9WmaPp8lAkcAAQAA
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

This fixes incorrect pinmux on UART0 and UART5 for PX30 Ringneck on
Haikou.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- removed already merged patches (Device Tree overlays),
- rebased on top of master to avoid conflicts,
- added comment above pinctrl-0 in uart5 to explain we are only adding a
  pinmux and not modifying anything else,
- Link to v2: https://lore.kernel.org/r/20250221-ringneck-dtbos-v2-0-310c0b9a3909@cherry.de

Changes in v2:
- rename uart5_rts_gpio to uart5_rts_pin to stop triggering a false
  positive of the dtschema checker,
- remove PU from uart5_rts_pin,
- Link to v1: https://lore.kernel.org/r/20250220-ringneck-dtbos-v1-0-25c97f2385e6@cherry.de

---
Quentin Schulz (2):
      arm64: dts: rockchip: fix pinmux of UART0 for PX30 Ringneck on Haikou
      arm64: dts: rockchip: fix pinmux of UART5 for PX30 Ringneck on Haikou

 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)
---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250128-ringneck-dtbos-98064839355e

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


