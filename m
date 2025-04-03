Return-Path: <stable+bounces-127761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C68A7AA86
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00A1188FE99
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4A925D8F3;
	Thu,  3 Apr 2025 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtH7P9tB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF7254B08;
	Thu,  3 Apr 2025 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707034; cv=none; b=FQ7oA5j6bCk9xnb8Xw3s1SNfsaCcRKKuas8HBZR+Q6VmUGE3eyVDVr+oYFP/yaacBuoHyGa11YTd7hlzTPfyFasxkstnSVKMw5SovZFR6sRQnZYaAfaLEid1EDtw0agXGeg8cDbuQLAGhh3DBtD5idhD52eYSwqf0Lka/rRgmVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707034; c=relaxed/simple;
	bh=End1NAdSCSyOu41pzCZOf9EQRzOV129eLfdzAXqYER0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=brFq2XHEgON5VrkFsteIl3+7tfjOJx6rN6lrW6RquzbJ/PMTOJBHVVRXEYQwI0e4ADrmCOILbgxh50g1WGxdaGr6B5dABgymLso2j3eaPvE9e3Y/Vdm2Z1PYscJxW4AeIZVhZSxb6CaBLqi8X2gkkDcZq22USUA9BKG2lg0b2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtH7P9tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DC5C4CEE8;
	Thu,  3 Apr 2025 19:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707034;
	bh=End1NAdSCSyOu41pzCZOf9EQRzOV129eLfdzAXqYER0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LtH7P9tBdJoArK+bIckWNxJssdB+wyNAGZ6NEtTkOFed766mDRNz9C13D9+9P4v06
	 gssXgqcd4MwvYiqSa6TEeW3DCki5d54j9o9QwySRm7GEikaZ07H6vsYqUZpevByJ8q
	 9hIN45ZDkTN8FeoQLXXUvoiP1GtfnwZIcTSYjmxyM1bitZ9mIYwIaEq7ci6ycCha2H
	 iFk1ODUY/9KNVQJZLiJ+jcbgvx2/zj8wDZyzupRPAlumiiRgvKV905zvCbfP+yD6+b
	 LLGjcZRlbrjIaGi3uSKF80o0hQUhbjLrB+9MocgFvGriPpxFCr+i+pSUXtb8/ASgTc
	 2OYCN5YCQ0XuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kiran K <kiran.k@intel.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 46/54] Bluetooth: btintel_pcie: Add device id of Whale Peak
Date: Thu,  3 Apr 2025 15:02:01 -0400
Message-Id: <20250403190209.2675485-46-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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


