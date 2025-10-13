Return-Path: <stable+bounces-185027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FAFBD4985
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C474E40573B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F79307ADA;
	Mon, 13 Oct 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VbAJDdL2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F52B23F294;
	Mon, 13 Oct 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369124; cv=none; b=qmJ2eckCdz9s+nQn6NkF+uMea/bYFiB3HVN8iydZmBIwCCUhFVHIg3xf7yYNG+scukj1fF6J4J+sel6qSqEV68/UivJypSfbMbXIAkAJ7OFNpV3t9tv71+PA/RvyXKFyGb588+vLaVt22H90QkjM0q81Lda+2xVT1Pc4ncTch2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369124; c=relaxed/simple;
	bh=12kFANR8Te0d73exV7uCijNBQq7NvScHScrYhf537hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3lJNlEvi3BsYJ0jQ7A2RiETmbzyTovyKUcQVPLrYluyRJ9UUORDsMNRj9Nc+05sapYLmsvKYcWb9/g7/cz/TED0HDae2vHLVzUTR2j2VABwVXnmipnEomXpPG3VFfVe26jw7zUBquPqQL+ZXnyZuCGS6n4qiGX/9wh2lpmcIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VbAJDdL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7FCC4CEE7;
	Mon, 13 Oct 2025 15:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369124;
	bh=12kFANR8Te0d73exV7uCijNBQq7NvScHScrYhf537hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbAJDdL2P5fdfqYjEGz7xxwl67wuhKQMFNlcgKgX3YYIAw22jnGG7BtcUWDuHS0pu
	 A2sIQ/jcHpntm4/h9ceVnJiPk7BpHL+6K4routIZZHNKBnyq0etjBaMsts2qEqEw/E
	 yOZRVe45Fn3c8BJzP71Xicj0UH35RWefI4YrH4Bg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Beleswar Padhi <b-padhi@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 137/563] arm64: dts: ti: k3-j742s2-mcu-wakeup: Override firmware-name for MCU R5F cores
Date: Mon, 13 Oct 2025 16:39:58 +0200
Message-ID: <20251013144416.254465741@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Beleswar Padhi <b-padhi@ti.com>

[ Upstream commit 00c8fdc2809f05422d919809106f54c23de3cba3 ]

The J742S2 SoC reuses the common k3-j784s4-j742s2-mcu-wakeup-common.dtsi
for its MCU domain, but it does not override the firmware-name property
for its R5F cores. This causes the wrong firmware binaries to be
referenced.

Introduce a new k3-j742s2-mcu-wakeup.dtsi file to override the
firmware-name property with correct names for J742s2.

Fixes: 38fd90a3e1ac ("arm64: dts: ti: Introduce J742S2 SoC family")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Link: https://patch.msgid.link/20250823163111.2237199-1-b-padhi@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi           |  1 +
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi
new file mode 100644
index 0000000000000..61db2348d6a47
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for J742S2 SoC Family
+ *
+ * TRM: https://www.ti.com/lit/pdf/spruje3
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+&mcu_r5fss0_core0 {
+	firmware-name = "j742s2-mcu-r5f0_0-fw";
+};
+
+&mcu_r5fss0_core1 {
+	firmware-name = "j742s2-mcu-r5f0_1-fw";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j742s2.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
index 7a72f82f56d68..d265df1abade1 100644
--- a/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
@@ -96,3 +96,4 @@ cpu3: cpu@3 {
 };
 
 #include "k3-j742s2-main.dtsi"
+#include "k3-j742s2-mcu-wakeup.dtsi"
-- 
2.51.0




