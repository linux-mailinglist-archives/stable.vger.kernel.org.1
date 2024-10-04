Return-Path: <stable+bounces-80815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A88990B60
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD97281E84
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B01D89F2;
	Fri,  4 Oct 2024 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/TLp6vw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813D81D89EA;
	Fri,  4 Oct 2024 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065969; cv=none; b=qoE+Yz3UpkhdOSdi33srmns6mGWAUZZMtFWFC+fujcqQbrtXXHMjxQRxzb93eSbiTroz4YUbnRa+u71z/a0ZoB5RlpVeAYaj0WFoEfJpYOaYCqFI635oReAzpYaq2iQfUk+5Gv4MC5KusiFYX0jwJn1zFAjsYKbnX9sK6074a4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065969; c=relaxed/simple;
	bh=aEvR1aT8heiTk9lsFiu0j/HVte/GDSy0gXB4MQhV0Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBhfUikFQ00KA+CO6cLV6yLvK5GnbK8kX2/3K/L0kj0d4PiKfa31vLeTCcpHDcDUaFNhCSSCTSze7SnbU8cy77oeyFVTC4kQVLwxG5UeSSDBz2abnSduiCx35ERI8HBSFeMPH+ZZWRknFWaVjuJzOSibCaEoyRyr93gkl9V0cEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/TLp6vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65356C4CEC6;
	Fri,  4 Oct 2024 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065969;
	bh=aEvR1aT8heiTk9lsFiu0j/HVte/GDSy0gXB4MQhV0Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/TLp6vwZlIBawtl0cfoTD5Sv1LCDjQKXO4ccVvDcEsFk3PoN4XVT0Sl0kABjJ+RQ
	 JoTa6JTyWmbFIBuYYgd19Bb53AcvzxaCSwAeTG3VMtYnHf2vPqL/3hNf5s/Ez16Khj
	 QcaARkyRak77SJT45ulrNVUNQODf1IotWpWL6CS/vM3X+ketMeeQsXDR/oZgsfVBGQ
	 YvSvNRkYc4Df24rK9pphbn5xqZ03HtwJjeMZpNdKiQB/rkijbygg6pTEHIseoa8xxp
	 unV4nlrc7ka1Qx094Y2syJx7G+EiIXd6nMvvyHdlkKt/BtEw7BwUsxOD3DrYRHCWpl
	 wYM8cJcWO0B1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.11 35/76] mfd: intel-lpss: Add Intel Arrow Lake-H LPSS PCI IDs
Date: Fri,  4 Oct 2024 14:16:52 -0400
Message-ID: <20241004181828.3669209-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 6112597f5ba84b70870fade5069ccc9c8b534a33 ]

Add Intel Arrow Lake-H PCI IDs.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240829095719.1557-2-ilpo.jarvinen@linux.intel.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 1362b3f64ade6..0eb6a98ed0fc0 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -424,6 +424,19 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x5ac4), (kernel_ulong_t)&bxt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x5ac6), (kernel_ulong_t)&bxt_spi_info },
 	{ PCI_VDEVICE(INTEL, 0x5aee), (kernel_ulong_t)&bxt_uart_info },
+	/* ARL-H */
+	{ PCI_VDEVICE(INTEL, 0x7725), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7726), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7727), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7730), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7746), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x7750), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7751), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7752), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7778), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7779), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x777a), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x777b), (kernel_ulong_t)&bxt_i2c_info },
 	/* RPL-S */
 	{ PCI_VDEVICE(INTEL, 0x7a28), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x7a29), (kernel_ulong_t)&bxt_uart_info },
-- 
2.43.0


