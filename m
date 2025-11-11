Return-Path: <stable+bounces-193397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F92C4A373
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9456C3B09F1
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E5266EFC;
	Tue, 11 Nov 2025 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UxU4gUvR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D126561E;
	Tue, 11 Nov 2025 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823085; cv=none; b=rXFn6BOu/SZ2wckeJg6X1fLt+yhRCYyT+u64Z3eDLPVev5P440V3K+DrVHTkzYJ2h1IwFpQuL0jtOpSFnkXK+MAqL/yCg5AGyTVmLWSwhytAL4Tqhz/9Zq8G2UFmf6gALB9zU3Sv2a3OWoC9FbqcAHj3pmKZ+9BGNNvtHpx76kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823085; c=relaxed/simple;
	bh=6m6ij2CubO7b72HeuruNIUWC/msJc6qSu/YT3bbYeOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPD88gM/ergpvB2E0xS3y8FJ69B7ui0kd0uyvHKYPIQwcsAtTECR6AkJAuReg/V07gS37m7vJdtRq6iW+nBbh317UX5p/xnsvHJIOljAIa8b1tPifx+qzWOlBVKlXWgpOjIbYCGIyltdUPw/uDBniMQS7B/TNqiJkH/dGCN/lBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UxU4gUvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B760C116B1;
	Tue, 11 Nov 2025 01:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823084;
	bh=6m6ij2CubO7b72HeuruNIUWC/msJc6qSu/YT3bbYeOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxU4gUvRma+eiO4zCXptPWMWwOV3uuw+bBERrZi67DNAvcO1zK8dUXx8aWQkMEHyb
	 vnaXAgxO8k+NwHHaYAN7IPqGXjysJS7C8+JIyNTDIYSZXbQ2Z7Q/Y7R4KA9wk3teLc
	 62X6gw7Zg2+OxBRGP4iQQT0uJd883Kd9PgETDwrw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 228/849] mfd: intel-lpss: Add Intel Wildcat Lake LPSS PCI IDs
Date: Tue, 11 Nov 2025 09:36:38 +0900
Message-ID: <20251111004541.952698650@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit c91a0e4e549d0457c61f2199fcd84d699400bee1 ]

Add Intel Wildcat Lake PCI IDs.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20250915112936.10696-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 1a5b8b13f8d0b..8d92c895d3aef 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -367,6 +367,19 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x4b79), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4b7a), (kernel_ulong_t)&ehl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x4b7b), (kernel_ulong_t)&ehl_i2c_info },
+	/* WCL */
+	{ PCI_VDEVICE(INTEL, 0x4d25), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x4d26), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x4d27), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x4d30), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x4d46), (kernel_ulong_t)&tgl_spi_info },
+	{ PCI_VDEVICE(INTEL, 0x4d50), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4d51), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4d52), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x4d78), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4d79), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4d7a), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x4d7b), (kernel_ulong_t)&ehl_i2c_info },
 	/* JSL */
 	{ PCI_VDEVICE(INTEL, 0x4da8), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x4da9), (kernel_ulong_t)&spt_uart_info },
-- 
2.51.0




