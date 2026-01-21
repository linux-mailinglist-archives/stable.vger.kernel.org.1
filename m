Return-Path: <stable+bounces-210714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJg8JO6NcGkaYgAAu9opvQ
	(envelope-from <stable+bounces-210714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 09:27:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7483F538F2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 09:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8171F561539
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 08:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82182428468;
	Wed, 21 Jan 2026 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhM2UxNo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C0283FE6;
	Wed, 21 Jan 2026 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983762; cv=none; b=Yh9ateMEYMYkQiBc/aqqmBnhtYh48wwo5m6r0AZvIP/ULSzUIXtAt3WJapaF3OtnHftrJbs2KMfMpOfX78eUSH19R1YUURXtZYGflUevl/GQwkHPE6xCcKi+dymLg69mkzAgnOa4HFUpZ3OX354HnimSM8hXz3D/KPLr5Dl3tkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983762; c=relaxed/simple;
	bh=K9cQvsuV/BqqBzFb/VSGQFSyp4UuDjE7rEbhN036PhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RpzFgXubfas+ZGdHpSBqkwwb2BbQv0CJnSIN4KGN3oWGJVzM5Hac4vgPKhQ4XAktk1Q0gb4IfZrb9c+cFuxE3Mhj4DUA041HOk0Odtrlk9NseRW/px4r8LucZOaazApmMDSgCrZqymf1VZbJL1adMOqN2GbWqZwxAfa8/hhlB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhM2UxNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2D12C116D0;
	Wed, 21 Jan 2026 08:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768983761;
	bh=K9cQvsuV/BqqBzFb/VSGQFSyp4UuDjE7rEbhN036PhE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=JhM2UxNoOfTNSiTYs45gN7acuXVFDBsTU2ZmbPgBDBBtFv52riQVZmUK5is3MwdLk
	 Pez34iK/IyNaO6Vp/WO5tFzufmOFyeFK32kqtsyOALlRPcHkCYLz3olF/Io1RCw09F
	 5/A/bJnFqlrFP0gxTyZesSROhnpn7G90cH7ZPluKHKhDCie+IlFfO7XPfGqB8HePaD
	 J3fBNHgCWGDg0in/OQIj5tQ82otk59kQuYjX379X3fgdnKX+PV0Rvih9U/9wbGTmsc
	 L0fxLMNU82yF+k/WRWWYwC0YCV1G7jSRrr8ClZ7MvKjwPuzDvv80bzA8y5eYjrV6EF
	 7Ah8GLEcy7blQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91413D262B5;
	Wed, 21 Jan 2026 08:22:41 +0000 (UTC)
From: Ziyao Li via B4 Relay <devnull+liziyao.uniontech.com@kernel.org>
Date: Wed, 21 Jan 2026 16:22:40 +0800
Subject: [PATCH v7] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-loongson-pci1-v7-1-fc79c85a574d@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAM+McGkC/33QzWrDMAzA8VcpPs/D8lfinfYeowfbkhvDFpe4C
 x0l7z63MAhZtuNfoB9CN1ZpylTZy+HGJppzzWVs0T0dWBz8eCKesTWTQhrRS8nfSxlPtYz8HDN
 wjYQCuz5BCKztnCdK+frw3o6th1wvZfp68DPcp39JM3DgynkfAgKkgK+fY7vlQnF4juWD3bVZ/
 ghWgNBbQTYBwQCZLlhK/Z6g1oLbCqoJBjEaTyp4p/YEvRJAbQXdBHAS0OrOJdJ7gvlXME2QVkc
 XtHfChz3BroVff7BNIOo99Mmg1HIrLMvyDYKlmYL4AQAA
X-Change-ID: 20250822-loongson-pci1-4ded0d78f1bb
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: niecheng1@uniontech.com, zhanjun@uniontech.com, 
 guanwentao@uniontech.com, Kexy Biscuit <kexybiscuit@aosc.io>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, kernel@uniontech.com, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lain Fearyncess Yang <fsf@live.com>, Ayden Meng <aydenmeng@yeah.net>, 
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
 Ziyao Li <liziyao@uniontech.com>, stable@vger.kernel.org, 
 Huacai Chen <chenhuacai@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768983760; l=5639;
 i=liziyao@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=aekmZZMcdoWR0EYWpMKLj8I7yyrt0QhHP+Dn7NQHYNM=;
 b=JQZuweOAQ3mziPLwrSbTe3gPrlNAUICC9SjBSdZBJqhmnYBnsd9V4xXSQ//DY6Y11ZCUK9tys
 Rv+D2bSfUWLDMz+pN2kl8caFUxIofS1328fr4YFRxdlS9AYzKtJZfFf
X-Developer-Key: i=liziyao@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for liziyao@uniontech.com/20250730 with
 auth_id=471
X-Original-From: Ziyao Li <liziyao@uniontech.com>
Reply-To: liziyao@uniontech.com
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210714-lists,stable=lfdr.de,liziyao.uniontech.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[uniontech.com,aosc.io,vger.kernel.org,lists.linux.dev,linux.intel.com,live.com,yeah.net,xry111.site,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[liziyao@uniontech.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yeah.net:email,xry111.site:email,aosc.io:email,live.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7483F538F2
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
[Xi Ruoyao: Fix falling through logic and add kernel log output.]
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Link: https://github.com/AOSC-Tracking/linux/commit/4392f441363abdf6fa0a0433d73175a17f493454
[Ziyao Li: move from drivers/pci/quirks.c to drivers/pci/controller/pci-loongson.c]
Signed-off-by: Ziyao Li <liziyao@uniontech.com>
Tested-by: Mingcong Bai <jeffbai@aosc.io>
Cc: stable@vger.kernel.org
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
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
---
 drivers/pci/controller/pci-loongson.c | 36 +++++++++++++++++++++++++++++++++++
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

---
base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
change-id: 20250822-loongson-pci1-4ded0d78f1bb

Best regards,
-- 
Ziyao Li <liziyao@uniontech.com>



