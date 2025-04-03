Return-Path: <stable+bounces-127860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB6A7AC7B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C97189D11C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61EE27BF9E;
	Thu,  3 Apr 2025 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbm0AJP3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D227BF8B;
	Thu,  3 Apr 2025 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707256; cv=none; b=O9m92Uio4L8a+ULXVqAgP/shNOmYphr775osBZfRTc8xuv4UtTIok8Wns7meHWBqy2ycHeidiGP5f/wrs3flKY1l6uIDJB/5M0SXNl5uT562+gKPWfSvXY73FJxGvCPVEbgPRxu/0/Ol8Q/pcyZklQ8W13ZDCrsiFX7tOP/2q90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707256; c=relaxed/simple;
	bh=QU5I1MrPAOwaDEuby5OorXeQKDacA3xDMuF6YRB00J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXtH51FimtLW9mn1DdvKlcGfhwC6cJd4kgBS/6LnOUqNkSCOvmAznDzPewfyRBC4Semw7hi9W1CNyuDZpLdWzQz96ZGuxEfTJBA0G0t67cbGLsNutEVoKRntqXbHlS72Xu0Knq/O8sfluioB6brRCEEs0Ve4Xs3pwt7OyiqxzBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbm0AJP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D58C4CEE9;
	Thu,  3 Apr 2025 19:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707254;
	bh=QU5I1MrPAOwaDEuby5OorXeQKDacA3xDMuF6YRB00J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbm0AJP3NXxRiozrOGTZ/voMZ8pl2Q0nwWgyW3Ew4t6QHlfIceGXcspPbRJZAv7uw
	 I+Ic5HsY2pWzzT+f/bCB2HWhm0trSK1KEgqBLynTwKrfvqWGqLMhz9NqUAuCAozizx
	 LuybHhocyhYWlYUWkJwGqTzvB4RKWZgfehqyFCNaIeJA4OvoYKigA4mGPP4XA3iyrU
	 YmQXqnrYKcxRsxT08DRXac8IIm4R9++TYXMyv2XiUsDmRFhHqwmASx182nZKy/5hwa
	 1mWeTxaPYgA0eKRRY1NA5+GA6sqtH/pDTbJjK7AFdgTXl3slTjgXiA5ewvhom3OMyy
	 8l62AONiQPN2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kiran K <kiran.k@intel.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 41/47] Bluetooth: btintel_pcie: Add device id of Whale Peak
Date: Thu,  3 Apr 2025 15:05:49 -0400
Message-Id: <20250403190555.2677001-41-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Kiran K <kiran.k@intel.com>

[ Upstream commit 6b8c05e52d66e4fe4ab1df4c6e15f339ecd9aa51 ]

Add device of Whale Peak.

Output of sudo lspci -v  -s 00:14.7:

00:14.7 Bluetooth: Intel Corporation Device e476
        Subsystem: Intel Corporation Device 0011
        Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 11
        Memory at 11011c30000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [80] MSI-X: Enable+ Count=32 Masked-
        Capabilities: [100] Latency Tolerance Reporting
        Kernel driver in use: btintel_pcie
        Kernel modules: btintel_pcie

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel_pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 53f6b4f76bccd..ab465e13c1f60 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -36,6 +36,7 @@
 /* Intel Bluetooth PCIe device id table */
 static const struct pci_device_id btintel_pcie_table[] = {
 	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
+	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
-- 
2.39.5


