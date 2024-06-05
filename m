Return-Path: <stable+bounces-48057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD58FCBD8
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68CD28A243
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D65195B1C;
	Wed,  5 Jun 2024 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYbRrCu8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE6C195B06;
	Wed,  5 Jun 2024 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588374; cv=none; b=PtgwKAPifMk/ctJuPU6zK6n7MktlhBnj/ngaF61fUoPP+ZVZwCn8LFK5wuMPZny8DcoR3dZumN8wihaeWRACaPCwRtmLi5/h1WB9Afq0BUHeqne4QRwXVccNVcyQmfq6JiJ+Alilv7FrUholz70cNm0m5gqDJcqbGNtsc+prmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588374; c=relaxed/simple;
	bh=m65CYxwYt+2ap+VpBFgdfHNIksVU8rUUboWMj4F1YoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2bHYVZqhRr1yLBsHxBy2OheM1TRm2S+ZDFAvb89odiaNflJUs0Ro/xDY3hgHGVTIx7wMJ1vATxN4t0pIBICgj4pTpZmurYz+NMEwev/91lFu8Dqb3Epk8yTGkSDAL6/8GXtjimTXmD02gs2UojwxcyLHYOzBTOzidTwD0msNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYbRrCu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9560BC32781;
	Wed,  5 Jun 2024 11:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588373;
	bh=m65CYxwYt+2ap+VpBFgdfHNIksVU8rUUboWMj4F1YoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HYbRrCu8GAu3S8NM5wgqajrEzNlmLxTvDATQ49aCj7Ybr5ljX9BiNFRXNCgR9Xzds
	 a8N956wmGZoS0qABMIGMa8CL/+Ux2IBN3IuokdyDwGL77/dtT/lAwdqZyeNQ33T2FT
	 bm68u/UqtyTXvsw8i+Tzm0L7uVSjuNmiAzJE2qWSBe0fggG+zT29WhAjDH08+wEcfv
	 jRkYyR8KYW+eOgjoxnkvmA07jicZjsu8BhbyOCkeZMLKYExjtfaxdMKdjqeP+6ilJG
	 mkQyYbnMWMDGBN0dY1/LmDsfZ+5YCwWK4ncERVuSG58p5Oadwsbu7K50s5dB4gwN9y
	 y1ErHGxEyoIfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jirislaby@kernel.org,
	andriy.shevchenko@linux.intel.com,
	matthew.howell@sealevel.com,
	ilpo.jarvinen@linux.intel.com,
	linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 12/20] serial: exar: adding missing CTI and Exar PCI ids
Date: Wed,  5 Jun 2024 07:51:55 -0400
Message-ID: <20240605115225.2963242-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115225.2963242-1-sashal@kernel.org>
References: <20240605115225.2963242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Parker Newman <pnewman@connecttech.com>

[ Upstream commit b86ae40ffcf5a16b9569b1016da4a08c4f352ca2 ]

- Added Connect Tech and Exar IDs not already in pci_ids.h

Signed-off-by: Parker Newman <pnewman@connecttech.com>
Link: https://lore.kernel.org/r/7c3d8e795a864dd9b0a00353b722060dc27c4e09.1713270624.git.pnewman@connecttech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_exar.c | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 4d20f3aa280cd..27430fdd9e761 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -41,8 +41,50 @@
 #define PCI_DEVICE_ID_COMMTECH_4228PCIE		0x0021
 #define PCI_DEVICE_ID_COMMTECH_4222PCIE		0x0022
 
+#define PCI_VENDOR_ID_CONNECT_TECH				0x12c4
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_SP_OPTO        0x0340
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_A      0x0341
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_B      0x0342
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS           0x0350
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A         0x0351
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B         0x0352
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS           0x0353
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A        0x0354
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B        0x0355
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO      0x0360
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A    0x0361
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B    0x0362
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP             0x0370
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232         0x0371
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485         0x0372
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP           0x0373
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP           0x0374
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP           0x0375
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS      0x0376
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT   0x0380
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT  0x0381
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO        0x0382
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO    0x0392
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP        0x03A0
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232    0x03A1
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485    0x03A2
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS 0x03A3
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XEG001               0x0602
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_BASE           0x1000
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_2              0x1002
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_4              0x1004
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_8              0x1008
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_12             0x100C
+#define PCI_SUBDEVICE_ID_CONNECT_TECH_PCIE_XR35X_16             0x1010
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X          0x110c
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X          0x110d
+#define PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16                 0x1110
+
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
+#define PCI_DEVICE_ID_EXAR_XR17V252		0x0252
+#define PCI_DEVICE_ID_EXAR_XR17V254		0x0254
+#define PCI_DEVICE_ID_EXAR_XR17V258		0x0258
 
 #define PCI_SUBDEVICE_ID_USR_2980		0x0128
 #define PCI_SUBDEVICE_ID_USR_2981		0x0129
-- 
2.43.0


