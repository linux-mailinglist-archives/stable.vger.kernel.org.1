Return-Path: <stable+bounces-167786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D845B231EB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16A3189A1C5
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FFB2D97BF;
	Tue, 12 Aug 2025 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E1O3Iph2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2475E305E08;
	Tue, 12 Aug 2025 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021986; cv=none; b=mWwPqfYIMyB8he1UQFG4klkzU9V98jmkg3wlY4ub+pdzS0VUw8kJGqTR6uYVrJ79D2xamlRgirys1huu/ghp/dkA402i89iB8HupwP70v0LFn6fuVFzNaglixPv1p+oMdFwo7PDKmshLTt+MYVQNsM01SCDNMrQSQ62PsP1+f7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021986; c=relaxed/simple;
	bh=gIcg9RThTzq9udbnl6acELroyBe3nSEJgz4qoMihbI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8E74UUYPGE/Z+bQ8qWt6KFVv+i+sLmBaozekpRScU0+wO5U9X6X08vmh16rMjCCMeNmH9N5V5sRLU5JYqryK/QLxhhNlbb8ihFKZQx0KVyPS2+cNSTuBSD1JJIVKJcF+DWp2ptGfdCPN+egPFrPMkOBLsxoiE2ANGpC4ps3unA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E1O3Iph2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E79BC4CEF0;
	Tue, 12 Aug 2025 18:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021986;
	bh=gIcg9RThTzq9udbnl6acELroyBe3nSEJgz4qoMihbI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E1O3Iph2oIPK+F10Ik122d98r89/uvDF6r213MqMl8XjJkSWB6CDAOAO6u3zxa+oY
	 aePlfU9qrChbRQ3QQnRNEZ3sI0ON31z5WjYY1OiM2Tmktei5J9ptAGUhzOMIWhuIhf
	 yBFYT74U2o8s5a4R73gEQdLIrIFrGEp2342hNAlE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Peng Fan <peng.fan@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 021/369] arm64: dts: freescale: imx93-tqma9352: Limit BUCK2 to 600mV
Date: Tue, 12 Aug 2025 19:25:18 +0200
Message-ID: <20250812173015.539656307@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 696a4c325fad8af95da6a9d797766d1613831622 ]

TQMa9352 is only using LPDDR4X, so the BUCK2 regulator should be fixed
at 600MV.

Fixes: d2858e6bd36c ("arm64: dts: freescale: imx93-tqma9352: Add PMIC node")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
index 2cabdae24227..09385b058664 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
 /*
- * Copyright (c) 2022 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * Copyright (c) 2022-2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
  * D-82229 Seefeld, Germany.
  * Author: Markus Niebel
  */
@@ -110,11 +110,11 @@ buck1: BUCK1 {
 				regulator-ramp-delay = <3125>;
 			};
 
-			/* V_DDRQ - 1.1 LPDDR4 or 0.6 LPDDR4X */
+			/* V_DDRQ - 0.6 V for LPDDR4X */
 			buck2: BUCK2 {
 				regulator-name = "BUCK2";
 				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <1100000>;
+				regulator-max-microvolt = <600000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
-- 
2.39.5




