Return-Path: <stable+bounces-36515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0182289C02E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967411F2498B
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443EE7BB1F;
	Mon,  8 Apr 2024 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PNGg5Fnj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B0D7442A;
	Mon,  8 Apr 2024 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581551; cv=none; b=mQEKaNt8DpqVi9Vyrw8IhFhQ0Up+ypHESFBqS2f2gCLwRBN0bBqSOV2niBo3tYGGUPnVvDFhMyDQLs1Jlv0Z5PJWUzOuExc6V8CHvpVY+YV4SbmbhR2W0BocAVoWhkoKyWCbvrMZICRFyMo0xk9zOFWKgdoxNvG8PrkIsjDnuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581551; c=relaxed/simple;
	bh=ovB4S/qhn8vpeMNYure+rrGyv2fUYABbleFKzV/8FQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXJtGetLsjx8Yjc37MnD7zMFmAPydV+O3O+UkU5LUwAA7EtLDQ87hADCNuuJkdhOUXhSAF7dIwGfdmGv7ufCoObpH8IRVv1pHRoXAHHBPl0FCNIZxQlCSYQBsVXlrY78Qm+jhFOdeWsamEYBf4o9p+8Urki8w1rtMVDB0Ts0C4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PNGg5Fnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B3FC433C7;
	Mon,  8 Apr 2024 13:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581550;
	bh=ovB4S/qhn8vpeMNYure+rrGyv2fUYABbleFKzV/8FQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PNGg5FnjoLYLz0nSDxUHkdAyn2JeIR8MRavhRJFJyUt0tlljo27A+9ygoZ7d+EFY4
	 /j3aNcrF9ftb0AhWBHpsWAnMf0svbQUPePMo0ADur8pPmTUjTQ955UTILN9nufO6Hg
	 ewWj4Lu2R7xsoOqJk6Y796+zEQF411bhKdr1QOBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Walle <michael@walle.cc>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 062/690] PCI: Work around Intel I210 ROM BAR overlap defect
Date: Mon,  8 Apr 2024 14:48:48 +0200
Message-ID: <20240408125401.766228687@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 500b55b05d0a21c4adddf4c3b29ee6f32b502046 ]

Per PCIe r5, sec 7.5.1.2.4, a device must not claim accesses to its
Expansion ROM unless both the Memory Space Enable and the Expansion ROM
Enable bit are set.  But apparently some Intel I210 NICs don't work
correctly if the ROM BAR overlaps another BAR, even if the Expansion ROM is
disabled.

Michael reported that on a Kontron SMARC-sAL28 ARM64 system with U-Boot
v2021.01-rc3, the ROM BAR overlaps BAR 3, and networking doesn't work at
all:

  BAR 0: 0x40000000 (32-bit, non-prefetchable) [size=1M]
  BAR 3: 0x40200000 (32-bit, non-prefetchable) [size=16K]
  ROM:   0x40200000 (disabled) [size=1M]

  NETDEV WATCHDOG: enP2p1s0 (igb): transmit queue 0 timed out
  Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier (DT)
  igb 0002:01:00.0 enP2p1s0: Reset adapter

Previously, pci_std_update_resource() wrote the assigned ROM address to the
BAR only when the ROM was enabled.  This meant that the I210 ROM BAR could
be left with an address assigned by firmware, which might overlap with
other BARs.

Quirk these I210 devices so pci_std_update_resource() always writes the
assigned address to the ROM BAR, whether or not the ROM is enabled.

Link: https://lore.kernel.org/r/20211223163754.GA1267351@bhelgaas
Link: https://lore.kernel.org/r/20201230185317.30915-1-michael@walle.cc
Link: https://bugzilla.kernel.org/show_bug.cgi?id=211105
Reported-by: Michael Walle <michael@walle.cc>
Tested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Stable-dep-of: 627c6db20703 ("PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c    | 10 ++++++++++
 drivers/pci/setup-res.c |  8 ++++++--
 include/linux/pci.h     |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1b6484c906094..50501c10809d2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5893,3 +5893,13 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
+
+static void rom_bar_overlap_defect(struct pci_dev *dev)
+{
+	pci_info(dev, "working around ROM BAR overlap defect\n");
+	dev->rom_bar_overlap = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1533, rom_bar_overlap_defect);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 875d50c16f19d..b492e67c3d871 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -75,12 +75,16 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 		 * as zero when disabled, so don't update ROM BARs unless
 		 * they're enabled.  See
 		 * https://lore.kernel.org/r/43147B3D.1030309@vc.cvut.cz/
+		 * But we must update ROM BAR for buggy devices where even a
+		 * disabled ROM can conflict with other BARs.
 		 */
-		if (!(res->flags & IORESOURCE_ROM_ENABLE))
+		if (!(res->flags & IORESOURCE_ROM_ENABLE) &&
+		    !dev->rom_bar_overlap)
 			return;
 
 		reg = dev->rom_base_reg;
-		new |= PCI_ROM_ADDRESS_ENABLE;
+		if (res->flags & IORESOURCE_ROM_ENABLE)
+			new |= PCI_ROM_ADDRESS_ENABLE;
 	} else
 		return;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 08d26b58f95ca..25e2e7756b1d8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -455,6 +455,7 @@ struct pci_dev {
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
+	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
2.43.0




