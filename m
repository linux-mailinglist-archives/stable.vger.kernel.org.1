Return-Path: <stable+bounces-232499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMUnA9QBzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-232499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:18:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7856C36E730
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E711A30EB8B2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29303101B4;
	Tue, 31 Mar 2026 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KN2kBGvb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D530E83A;
	Tue, 31 Mar 2026 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976906; cv=none; b=IiFe3eBrG4k6xRObDY+/8e6fHf6SBvLzx4UiPMdu3qwGm1/AZlA6y5RR9CBXUNYR0cKfG8Vez047ZnPQpI60gR8QOqCegCFyfXDolARgVg4XfOZKo55zpO47b2GJadvcprA62CzjzQfGKIso3KNtbeq+OXTW4H6ezXL6E3Jp0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976906; c=relaxed/simple;
	bh=stiYrqwaVHUQZoJlqORtL9iuX/Ypzd6pUtg5dGcNlbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOPN03Tto70RuL09V9MBawLKLKdP7lQhUex44iogA2QklAbrafQcvgs/TxCu4gBygS7iEIkUGh2Yz4N4em3yRPz20qnpQ4P5uTFIf0MS9eHYuFblrSChrh0srAOdIzShDKsziuxJqRsBeWJq0bd9cgZv8Gg1b+pTR2tLv4PMVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KN2kBGvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662F4C19423;
	Tue, 31 Mar 2026 17:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976905;
	bh=stiYrqwaVHUQZoJlqORtL9iuX/Ypzd6pUtg5dGcNlbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KN2kBGvbs9jv2jl3Ri7i8sUXK8Hb1jiER8njgs5G5desTE2BmBqiLKbIIvelZGFl1
	 VJckC145zkfpOr1cFtiHJzFauxdXOq5vmLae8y2st7Px0O2FxOF4L0bG9ZEsMk7iWw
	 zWo4cwmx1UdvpwguxuUIDklPkgc/JZFTL1MK7rNo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qianhai Wu <wuqianhai@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.18 240/309] LoongArch: Workaround LS2K/LS7A GPU DMA hang bug
Date: Tue, 31 Mar 2026 18:22:23 +0200
Message-ID: <20260331161802.409677609@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232499-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 7856C36E730
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit 95db0c9f526d583634cddb2e5914718570fbac87 upstream.

1. Hardware limitation: GPU, DC and VPU are typically PCI device 06.0,
06.1 and 06.2. They share some hardware resources, so when configure the
PCI 06.0 device BAR1, DMA memory access cannot be performed through this
BAR, otherwise it will cause hardware abnormalities.

2. In typical scenarios of reboot or S3/S4, DC access to memory through
BAR is not prohibited, resulting in GPU DMA hangs.

3. Workaround method: When configuring the 06.0 device BAR1, turn off
the memory access of DC, GPU and VPU (via DC's CRTC registers).

Cc: stable@vger.kernel.org
Signed-off-by: Qianhai Wu <wuqianhai@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/pci/pci.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -5,9 +5,11 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/vgaarb.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/cacheflush.h>
 #include <asm/loongson.h>
 
@@ -15,6 +17,9 @@
 #define PCI_DEVICE_ID_LOONGSON_DC1      0x7a06
 #define PCI_DEVICE_ID_LOONGSON_DC2      0x7a36
 #define PCI_DEVICE_ID_LOONGSON_DC3      0x7a46
+#define PCI_DEVICE_ID_LOONGSON_GPU1     0x7a15
+#define PCI_DEVICE_ID_LOONGSON_GPU2     0x7a25
+#define PCI_DEVICE_ID_LOONGSON_GPU3     0x7a35
 
 int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
 						int reg, int len, u32 *val)
@@ -99,3 +104,78 @@ static void pci_fixup_vgadev(struct pci_
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC1, pci_fixup_vgadev);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC2, pci_fixup_vgadev);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC3, pci_fixup_vgadev);
+
+#define CRTC_NUM_MAX		2
+#define CRTC_OUTPUT_ENABLE	0x100
+
+static void loongson_gpu_fixup_dma_hang(struct pci_dev *pdev, bool on)
+{
+	u32 i, val, count, crtc_offset, device;
+	void __iomem *crtc_reg, *base, *regbase;
+	static u32 crtc_status[CRTC_NUM_MAX] = { 0 };
+
+	base = pdev->bus->ops->map_bus(pdev->bus, pdev->devfn + 1, 0);
+	device = readw(base + PCI_DEVICE_ID);
+
+	regbase = ioremap(readq(base + PCI_BASE_ADDRESS_0) & ~0xffull, SZ_64K);
+	if (!regbase) {
+		pci_err(pdev, "Failed to ioremap()\n");
+		return;
+	}
+
+	switch (device) {
+	case PCI_DEVICE_ID_LOONGSON_DC2:
+		crtc_reg = regbase + 0x1240;
+		crtc_offset = 0x10;
+		break;
+	case PCI_DEVICE_ID_LOONGSON_DC3:
+		crtc_reg = regbase;
+		crtc_offset = 0x400;
+		break;
+	}
+
+	for (i = 0; i < CRTC_NUM_MAX; i++, crtc_reg += crtc_offset) {
+		val = readl(crtc_reg);
+
+		if (!on)
+			crtc_status[i] = val;
+
+		/* No need to fixup if the status is off at startup. */
+		if (!(crtc_status[i] & CRTC_OUTPUT_ENABLE))
+			continue;
+
+		if (on)
+			val |= CRTC_OUTPUT_ENABLE;
+		else
+			val &= ~CRTC_OUTPUT_ENABLE;
+
+		mb();
+		writel(val, crtc_reg);
+
+		for (count = 0; count < 40; count++) {
+			val = readl(crtc_reg) & CRTC_OUTPUT_ENABLE;
+			if ((on && val) || (!on && !val))
+				break;
+			udelay(1000);
+		}
+
+		pci_info(pdev, "DMA hang fixup at reg[0x%lx]: 0x%x\n",
+				(unsigned long)crtc_reg & 0xffff, readl(crtc_reg));
+	}
+
+	iounmap(regbase);
+}
+
+static void pci_fixup_dma_hang_early(struct pci_dev *pdev)
+{
+	loongson_gpu_fixup_dma_hang(pdev, false);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_GPU2, pci_fixup_dma_hang_early);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_GPU3, pci_fixup_dma_hang_early);
+
+static void pci_fixup_dma_hang_final(struct pci_dev *pdev)
+{
+	loongson_gpu_fixup_dma_hang(pdev, true);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_GPU2, pci_fixup_dma_hang_final);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_GPU3, pci_fixup_dma_hang_final);



