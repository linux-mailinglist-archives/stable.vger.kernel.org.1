Return-Path: <stable+bounces-191637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4339C1B86E
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 16:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9042434B833
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318972DFA48;
	Wed, 29 Oct 2025 15:02:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5E2EB876
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750148; cv=none; b=g2fA4b6X8lM9hmmpnYTEESk5vndwd4pYnFRSSHLAhFtyFePKsLtolETrTNoY6iCTQlCm8zQREAuGxOP3nTEwdqLMiuxE9FJgWn7F0DjpYtnf1s+eFvpz7Qp30d34W4acFax9jIBz4f8yyzwIJjA23hcaV+MT0aTRlDiwuimdEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750148; c=relaxed/simple;
	bh=a53+V3uaK6I4AEhPDfDelsj7DwEolLCX0yrz9pu12RM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Iedgr5SHI8MDK0cMXyBYfuwEb/PMUaXIP40Mxo5MfSAy3kTbElzAN2cxtKgQp0KxTCSXLwM/jUb9eGTcihGmnbICEMZRC+0nKEFlwW1Ia9tSDwrizQoEwmyjfrZtyeJO5rCR9aktzuF946PLdww/Iv1K2xFywo01I2N73u6O4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cxTDL1QMfz9X7;
	Wed, 29 Oct 2025 14:51:14 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cxTDK1V4Rz5F0;
	Wed, 29 Oct 2025 14:51:13 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Wed, 29 Oct 2025 14:50:59 +0100
Subject: [PATCH] arm64: dts: rockchip: include rk3399-base instead of
 rk3399 in rk3399-op1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-rk3399-op1-include-v1-1-2472ee60e7f8@cherry.de>
X-B4-Tracking: v=1; b=H4sIAMIbAmkC/x3MSwqAMAwA0atI1gaaVoV4FXHhJ2pQqrQognh3i
 8u3mHkgSlCJUGcPBLk06u4TKM9gWDo/C+qYDNbYkoxlDKtzzLgfhOqH7RwFe0fUF0IVG4YUHkE
 mvf9p077vB4K2Eq9kAAAA
X-Change-ID: 20251029-rk3399-op1-include-b311b4e16909
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Dragan Simic <dsimic@manjaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

In commit 296602b8e5f7 ("arm64: dts: rockchip: Move RK3399 OPPs to dtsi
files for SoC variants"), everything shared between variants of RK3399
was put into rk3399-base.dtsi and the rest in variant-specific DTSI,
such as rk3399-t, rk3399-op1, rk3399, etc.
Therefore, the variant-specific DTSI should include rk3399-base.dtsi and
not another variant's DTSI.

rk3399-op1 wrongly includes rk3399 (a variant) DTSI instead of
rk3399-base DTSI, let's fix this oversight by including the intended
DTSI.

Fortunately, this had no impact on the resulting DTB since all nodes
were named the same and all node properties were overridden in
rk3399-op1.dtsi. This was checked by doing a checksum of rk3399-op1 DTBs
before and after this commit.

No intended change in behavior.

Fixes: 296602b8e5f7 ("arm64: dts: rockchip: Move RK3399 OPPs to dtsi files for SoC variants")
Cc: stable@vger.kernel.org
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
index c4f4f1ff6117b..9da6fd82e46b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
  */
 
-#include "rk3399.dtsi"
+#include "rk3399-base.dtsi"
 
 / {
 	cluster0_opp: opp-table-0 {

---
base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
change-id: 20251029-rk3399-op1-include-b311b4e16909

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


