Return-Path: <stable+bounces-235807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMNuKghy22lmCAkAu9opvQ
	(envelope-from <stable+bounces-235807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 12:20:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AF03E369B
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A8AD3011C6F
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA88375ADF;
	Sun, 12 Apr 2026 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="bj31Cg2g"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A761DE2AD;
	Sun, 12 Apr 2026 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775989131; cv=none; b=H7FF6pwilMayQ/GjPrze9AWhrKa0vo6os09v7cNWs051k8agSP6twqBWrf+SSjh6Y/M/Z9+XiY0Jm5tNOzoItzWGKbXDxqHG0XUviNxuKBZUgqxnqBJd68EA7oC1cN/FQ4xFbnStlWWvGJ/wwiSaP9divVtId2/of/B0TL3jg8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775989131; c=relaxed/simple;
	bh=+4mMOOJxRW72GzvKAHUQQThFwjr2r/cMI9CO9sZLikM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1vbGPcWgOG8GcDvyi25EIr9hbEOHbnkPvydrqKQs1XxuTQbywPVpV5cZjsIoSincwdQT/1rJRM4yRFwdrJvopPWNsyljAo5yb/pZDIEATfv0ZUWD1JNHxXRrG3Qn8L2e8yYUJoukxN8wUO1UmEfWmFmKE1xHW/CchumgyZ8tQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=bj31Cg2g; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1775989121;
	bh=UKrZ9HfNpKHGaF0K78euP7i/QvJB8oaJWnntzN6o0dc=;
	h=From:To:Cc:Subject:Date:From;
	b=bj31Cg2g4HzWT9eEcs4ZjnA9xR4guhJJb5O5u1QasEgeFwYBqKuFWm7b4KkJcSZhz
	 hvbrDQ4hYz9oUUcyLaSC2oonuuPtOcPZO6gu0alkyIjBRrDrvGrinuPL7YLjI3J34b
	 hP2+X6hi0QoM4KPWF0ZYadFhf0UmYOTNTc50f07A=
Received: from stargazer (unknown [IPv6:2409:8a4c:e10:5280:f007:4005:95fb:69ef])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 76D2365992;
	Sun, 12 Apr 2026 06:18:33 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ziyao Li <liziyao@uniontech.com>
Cc: niecheng1@uniontech.com,
	zhanjun@uniontech.com,
	guanwentao@uniontech.com,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	kernel@uniontech.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lain Fearyncess Yang <fsf@live.com>,
	Ayden Meng <aydenmeng@yeah.net>,
	Mingcong Bai <jeffbai@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v8] PCI: loongson: Override PCIe bridge supported speeds for Loongson-3C6000 series
Date: Sun, 12 Apr 2026 18:17:31 +0800
Message-ID: <20260412101731.107059-1-xry111@xry111.site>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[uniontech.com,aosc.io,vger.kernel.org,lists.linux.dev,linux.intel.com,live.com,yeah.net,xry111.site,kernel.org,loongson.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235807-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xry111.site:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[live.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:email,yeah.net:email,xry111.site:dkim,xry111.site:email,xry111.site:mid]
X-Rspamd-Queue-Id: 55AF03E369B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ziyao Li <liziyao@uniontech.com>

Older steppings of the Loongson-3C6000 series incorrectly report the
supported link speeds on their PCIe bridges (device IDs 0x3c19, 0x3c29)
as only 2.5 GT/s, despite the upstream bus supporting speeds from
2.5 GT/s up to 16 GT/s.

As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if more
than one speed is supported"), bwctrl will be disabled if there's only
one 2.5 GT/s value in vector `supported_speeds`.

Also, the amdgpu driver reads the value by pcie_get_speed_cap() in
amdgpu_device_partner_bandwidth(), for its dynamic adjustment of PCIe
clocks and lanes in power management. We hope this patch can prevent
similar problems in future driver changes (similar checks may be
implemented in other GPU, storage controller, NIC, etc. drivers).

Manually override the `supported_speeds` field for affected PCIe bridges
with those found on the upstream bus to correctly reflect the supported
link speeds.

This patch was originally found from AOSC OS[1].

Link: https://github.com/AOSC-Tracking/linux/pull/2 #1
Tested-by: Lain Fearyncess Yang <fsf@live.com>
Tested-by: Ayden Meng <aydenmeng@yeah.net>
Signed-off-by: Ayden Meng <aydenmeng@yeah.net>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
Link: https://github.com/AOSC-Tracking/linux/commit/4392f441363abdf6fa0a0433d73175a17f493454
[Ziyao Li: move from drivers/pci/quirks.c to drivers/pci/controller/pci-loongson.c]
Signed-off-by: Ziyao Li <liziyao@uniontech.com>
Tested-by: Mingcong Bai <jeffbai@aosc.io>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
[Xi Ruoyao: Fix falling through logic and add kernel log output;
 add Fixes tag and rebase to 7.0-rc7]
Cc: stable@vger.kernel.org
Fixes: cd89edda4002 ("PCI: loongson: Add ACPI init support")
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---

Changes in v8:
- Add the Fixes tag.
- Link to v7: https://lore.kernel.org/all/20260121-loongson-pci1-v7-1-fc79c85a574d@uniontech.com/

Ziyao Li's original commentary message follows below:

The reason of not just copying pdev->bus->self->supported_speeds is
that we're concerned that this approach assumes the upstream port
reports the same capabilities as bridge, which may not always be the
case in future silicon revisions.

Our current conservative approach ensures we only enable speeds that
are physically supported by checking the actual max_bus_speed. For
example, if there's a future Loongson-3C9999 where the virtual bridge
reports Gen4 support but the physical bridge only supports Gen3.

In this scenario, directly copying the upstream port's supported_speeds
would incorrectly report Gen4 support for the downstream bridge. The
current patch ensures we only set speed bits up to what the hardware
actually supports, based on the measured max_bus_speed. This seems
safer for future silicon.

Changes in v7:
- adjust commit message
- Link to v6: https://lore.kernel.org/r/20260114-loongson-pci1-v6-1-ee8a18f5d242@uniontech.com

Changes in v6:
- adjust commit message
- Link to v5: https://lore.kernel.org/r/20260113-loongson-pci1-v5-1-264c9b4a90ab@uniontech.com

Changes in v5:
- style adjust
- Link to v4: https://lore.kernel.org/r/20260113-loongson-pci1-v4-1-1921d6479fe4@uniontech.com

Changes in v4:
- rename subject
- use 0x3c19/0x3c29 instead of 3c19/3c29
- Link to v3: https://lore.kernel.org/r/20260109-loongson-pci1-v3-1-5ddc5ae3ba93@uniontech.com

Changes in v3:
- Adjust commit message
- Make the program flow more intuitive
- Link to v2: https://lore.kernel.org/r/20260104-loongson-pci1-v2-1-d151e57b6ef8@uniontech.com

Changes in v2:
- Link to v1: https://lore.kernel.org/r/20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com
- Move from arch/loongarch/pci/pci.c to drivers/pci/controller/pci-loongson.c
- Fix falling through logic and add kernel log output by Xi Ruoyao

 drivers/pci/controller/pci-loongson.c | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index bc630ab8a283..a4250d7af1bf 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -176,6 +176,42 @@ static void loongson_pci_msi_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
 
+/*
+ * Older steppings of the Loongson-3C6000 series incorrectly report the
+ * supported link speeds on their PCIe bridges (device IDs 0x3c19,
+ * 0x3c29) as only 2.5 GT/s, despite the upstream bus supporting speeds
+ * from 2.5 GT/s up to 16 GT/s.
+ */
+static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
+{
+	u8 old_supported_speeds = pdev->supported_speeds;
+
+	switch (pdev->bus->max_bus_speed) {
+	case PCIE_SPEED_16_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_16_0GB;
+		fallthrough;
+	case PCIE_SPEED_8_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_8_0GB;
+		fallthrough;
+	case PCIE_SPEED_5_0GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
+		fallthrough;
+	case PCIE_SPEED_2_5GT:
+		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_2_5GB;
+		break;
+	default:
+		pci_warn(pdev, "unexpected max bus speed");
+
+		return;
+	}
+
+	if (pdev->supported_speeds != old_supported_speeds)
+		pci_info(pdev, "fixing up supported link speeds: 0x%x => 0x%x",
+			 old_supported_speeds, pdev->supported_speeds);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pci_bridge_speed_quirk);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pci_bridge_speed_quirk);
+
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;
-- 
2.53.0


