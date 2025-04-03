Return-Path: <stable+bounces-127810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B8A7ABD3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356FC1881603
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5376E267B72;
	Thu,  3 Apr 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzfz92Mt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07350267B6B;
	Thu,  3 Apr 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707143; cv=none; b=b/Z4Hob10T/KxtxRTtVXHiK4wm6DYpY4VK4gCphHKywQAiJ1UuR4H4VcSlFAEW5WGuwm3/Qqbg4McSzvbJZTqqYPkE+iUYGFryPR/BhfAFM41mnaNQRbkgM4tLyGtUvLIis8y7tf4Gkl+lPVx9Fag7HGVpw4G4ST87Xxv8DdKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707143; c=relaxed/simple;
	bh=End1NAdSCSyOu41pzCZOf9EQRzOV129eLfdzAXqYER0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LI9z/PtpYzyAlw5Zqu4Y8Zv8p0pz5wKIyVunmPerEPiRq4Fe5sesXCiEVDhbKtgR8jLtgAu8mTQgkkdKTHOhHLHVR9e9T6FERe3s45b8iuQQh304g2d8O5ht7PZmriS00IxZicenuEWFor0kl+vttpdgBmZ+ubZqXuUh5djxbTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzfz92Mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034B5C4CEEA;
	Thu,  3 Apr 2025 19:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707142;
	bh=End1NAdSCSyOu41pzCZOf9EQRzOV129eLfdzAXqYER0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gzfz92MtEBc98JU7wZlbUK3aYmIUIr5PVMpP1vn71SAkK4piHuR6g5H9hehdKwL3O
	 OFBJSRgORIYCZdTApg6lEwAzzwXqM81pAmSSv/Pw6yZo3uJHPqk5WRSBzeKyTDiW4T
	 uw58yDoAQim4ysoIWkCIlj6MKVHsixzXgcsYRdkoUlElk9FS7Bsk+Lc1IPC5UkN1pj
	 1e5vR/RRiFh6D7ZzUefGxPE9NyhV8OWHebledgS3rauzh+0nGLkPHIM77xQ+upAuPN
	 NhF4FfAHKfvd32fCCs1GU/C9jvsxEs1Sqq9H1LMdWN9EQSIpDbBdsnCnQrKZE6XyR+
	 ohkOBctYYXpnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kiran K <kiran.k@intel.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 42/49] Bluetooth: btintel_pcie: Add device id of Whale Peak
Date: Thu,  3 Apr 2025 15:04:01 -0400
Message-Id: <20250403190408.2676344-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 091ffe3e14954..6130854b6658a 100644
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


