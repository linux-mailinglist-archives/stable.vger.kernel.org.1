Return-Path: <stable+bounces-80816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86AB990B63
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693592813AF
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCBE1D8A0B;
	Fri,  4 Oct 2024 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy5fzF9V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905D1D8A01;
	Fri,  4 Oct 2024 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065970; cv=none; b=FR7oC3ObODJ9D5PKzTA3Nv3vVXO+Vrrc7j/rwk4W57AZ+qSumucycUJDPMH/U2v9+xPxRGTBNeWvbNT1sS4PF5UGw8qae9ERFFNr+gpnWAGbp3vp4fN9ie/aq94ItC/z5vjQQF+pF9NZ0rnzA6mEPW60ItDljFA6NzHC65UhXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065970; c=relaxed/simple;
	bh=+2IUzjSiBXKqfq0gzMBC4c/MR+jLj3sTvGy/aapbJXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiqsjakeIRepvmq8bkyAanTo+7mzuQ3De6IEFYeS80F3oeiGNoGONlDOsBOxrHZa7W4x0/TPVW5EacdoQJPShC8XZWRhtviNw0frqyWHdvNtpXnjWLkcAGi3y9lh3OiK+29QTodbqhlh0/pN+BHKJjQXfO9pvOrzMLSI0yvDGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy5fzF9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F45BC4CED0;
	Fri,  4 Oct 2024 18:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065970;
	bh=+2IUzjSiBXKqfq0gzMBC4c/MR+jLj3sTvGy/aapbJXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oy5fzF9V9VPFIkQ0tWZLs6VIuCWv1t5o8RQfF9mIuwTt+XX074QUdE3sv8ASgsHr4
	 saLqvL9uyVmkIVn3m1nl+Yn738cgqxBhJ2SqvqsSU/lKdjo5zwc+lx6hr2yfqEjYtB
	 yV5rtB9+h6r7ucda9oNblAe6Gn54udW6+jviSjRyo513r6P0r/PMeuHPibqRs+D8Jd
	 /opMyJJANtPZT4gL1yZvubhBh5+IvGJ/6bacWnnB+pu+SPWjnfTIkWFg98IMCesEkz
	 5rXRRf2niG60K4XcNVzTGZurcv+bM5Gsd7Vc4ssvJg8o47i9I8Xe7XY9byV49MR5nS
	 QzFYJGjGE2O7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.11 36/76] mfd: intel-lpss: Add Intel Panther Lake LPSS PCI IDs
Date: Fri,  4 Oct 2024 14:16:53 -0400
Message-ID: <20241004181828.3669209-36-sashal@kernel.org>
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

[ Upstream commit db6a186505c8156e55681a3b93ada431863b85c1 ]

Add Intel Panther Lake-H/P PCI IDs.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240829095719.1557-3-ilpo.jarvinen@linux.intel.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 0eb6a98ed0fc0..1d8cdc4d5819b 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -607,6 +607,32 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa879), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa87a), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa87b), (kernel_ulong_t)&ehl_i2c_info },
+	/* PTL-H */
+	{ PCI_VDEVICE(INTEL, 0xe325), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xe326), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xe327), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xe330), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xe346), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xe350), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe351), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe352), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xe378), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe379), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe37a), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe37b), (kernel_ulong_t)&ehl_i2c_info },
+	/* PTL-P */
+	{ PCI_VDEVICE(INTEL, 0xe425), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xe426), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xe427), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xe430), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xe446), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0xe450), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe451), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe452), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xe478), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe479), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe47a), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xe47b), (kernel_ulong_t)&ehl_i2c_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_lpss_pci_ids);
-- 
2.43.0


