Return-Path: <stable+bounces-196874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 745A7C83F93
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 09:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD5804E7BC4
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE72DA765;
	Tue, 25 Nov 2025 08:26:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1782D9EE8;
	Tue, 25 Nov 2025 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059208; cv=none; b=DPo8Lri8QZZOcZoNskj5Zc+i+VAmC/xpiblY+A4kMiQCYKydff3sMrChqlPwRFocEhtcbxmaXX7EcN+HVPqjt5/v440Skp0rOji+MVk15clIwfmsBkOsKgMkUX/CFhNOJL5Cj+/kATkQ88zNM9d+vR8xNsij/1xsZrmSbZHxSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059208; c=relaxed/simple;
	bh=ecxCHmGwiiY5VMszSlYW87sm5MGKGQPMIPd/roYBEkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DT73qm3sVkkuNNsOgW/Xoy641AHZyFJPHJmSw2XITqgpOfwxNxOtHm5mezFVg6vWpDrUpaQU8fJ6F8FuhtiVGq2gLxAzJ+il2h006bPiON9kUvAf3TaB45ANibEYr9DeMkOui86hsEYbGf78pfRIUatMAOveaAT1d9T1FrCTX0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D368FC4CEF1;
	Tue, 25 Nov 2025 08:26:44 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Tianrui Zhao <zhaotianrui@loongson.cn>
Subject: [PATCH] LoongArch: Add new PCI ID for pci_fixup_vgadev()
Date: Tue, 25 Nov 2025 16:26:21 +0800
Message-ID: <20251125082621.488633-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Loongson-2K3000 has a new PCI ID (0x7a46) for its display controller,
Add it for pci_fixup_vgadev() since we prefer a discrete graphics card
as default boot device if present.

Cc: stable@vger.kernel.org
Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
index d9fc5d520b37..d923295ab8c6 100644
--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -14,6 +14,7 @@
 #define PCI_DEVICE_ID_LOONGSON_HOST     0x7a00
 #define PCI_DEVICE_ID_LOONGSON_DC1      0x7a06
 #define PCI_DEVICE_ID_LOONGSON_DC2      0x7a36
+#define PCI_DEVICE_ID_LOONGSON_DC3      0x7a46
 
 int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
 						int reg, int len, u32 *val)
@@ -97,3 +98,4 @@ static void pci_fixup_vgadev(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC1, pci_fixup_vgadev);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC2, pci_fixup_vgadev);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC3, pci_fixup_vgadev);
-- 
2.47.3


