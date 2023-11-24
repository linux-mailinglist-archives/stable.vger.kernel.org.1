Return-Path: <stable+bounces-588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB937F7BB6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F64F1C21069
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC83139FC3;
	Fri, 24 Nov 2023 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1cUCqe7x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9139FDD;
	Fri, 24 Nov 2023 18:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D6BC433C8;
	Fri, 24 Nov 2023 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849274;
	bh=n2F5lzTNzWvF/0uTUTFeUHPrZLdUGQInPruD9MRlGDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1cUCqe7xGZev83oFb2rKq9bpTJECAv5GAvzpnTfKPvSLm5MjLlSp5cXV6jA1Yqig/
	 cifu+Y74oe+0U8ymB+gPcKpC0MdAIkbjjzd16W3G4q7NjE8GFXeZXGtNh6l27v7OVm
	 tbQuBqBexXyBPBdYuSfQnIzB0TgmxscTWqcqASf0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 117/530] mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs
Date: Fri, 24 Nov 2023 17:44:43 +0000
Message-ID: <20231124172031.673471851@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit e53b22b10c6e0de0cf2a03a92b18fdad70f266c7 ]

Add Intel Lunar Lake-M SoC PCI IDs.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20231002083344.75611-1-jarkko.nikula@linux.intel.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 699f44ffff0e4..ae5759200622c 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -561,6 +561,19 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa3e2), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa3e3), (kernel_ulong_t)&spt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0xa3e6), (kernel_ulong_t)&spt_uart_info },
+	/* LNL-M */
+	{ PCI_VDEVICE(INTEL, 0xa825), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa826), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa827), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0xa830), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0xa846), (kernel_ulong_t)&tgl_info },
+	{ PCI_VDEVICE(INTEL, 0xa850), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa851), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa852), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa878), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa879), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa87a), (kernel_ulong_t)&ehl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa87b), (kernel_ulong_t)&ehl_i2c_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_lpss_pci_ids);
-- 
2.42.0




