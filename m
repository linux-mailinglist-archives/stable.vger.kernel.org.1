Return-Path: <stable+bounces-48087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7FA8FCC35
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169D8292746
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E245B197518;
	Wed,  5 Jun 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwmabxFP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FAE1B3732;
	Wed,  5 Jun 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588474; cv=none; b=qdBqIZN9guWmJ4r93J/w9yJEtcPStMFp8QlLGB9JTbV6T3ZMsKX56KLX2Oofl7KI6Xoaq9KRamPhEERPPftLLfonjTpI3WOavVM6q7qDfJvuH+TU5JrKrYA3kZ/XbAPsqzgt6VpGrjE4NsPLOiLzkjQUAlRZ3PxlhOQ0FllPnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588474; c=relaxed/simple;
	bh=hPekeq1yzvbyCB5hZKxJKY6/XubkRzeKQ1eUS/E0MTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK/7KpUgE33n+Blw5c2GFhPhG9mAgcHQZK6N1K5oPvKabvLh6v06ERKV2n0Lm2AdnhlkiB9mXewx0rKIScWUpwALZtBVr1bspN5jWCeiGnBv9fR6pDwVP4ozro+UeYghKoGXbcmvxFngSKsgZjIFqtJ+BiUjSmTquQiltdXEs3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwmabxFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDD7C3277B;
	Wed,  5 Jun 2024 11:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588474;
	bh=hPekeq1yzvbyCB5hZKxJKY6/XubkRzeKQ1eUS/E0MTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwmabxFP2sbjy5BE+a0gcH/2+y6IZvRhsgMP8oFMfZTpFFwdK0xOyMnvJDx0/cpez
	 oHaUcvjfwRDy9siZ9soh2znVpCzmUdEkEq3wY71PaqYAKW6sHTCTlspzOuXAs/84RU
	 ZUxkekuJ3RqFpkPWnnq1Q+9XZFAj48a1nnOqr8l+TJnfmjaa2lEof7ZI9jVRwe377G
	 junuP436Q1AC/sb15ZbFoVpmRkJ7hbLrBabyOcF8NvYAbxodtKsCj/5KIDno2n/i3T
	 KadYlwjUG/hVbeRKD92D0oILU93YkpCt0q7djjDZd/W7wYepEMp1uQBNZSN47H3Rfx
	 /kkZ7PITjCvig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jirislaby@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	matthew.howell@sealevel.com,
	linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 8/9] serial: exar: adding missing CTI and Exar PCI ids
Date: Wed,  5 Jun 2024 07:54:06 -0400
Message-ID: <20240605115415.2964165-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115415.2964165-1-sashal@kernel.org>
References: <20240605115415.2964165-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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
index 48769e059772a..a38820a1c5cd2 100644
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


