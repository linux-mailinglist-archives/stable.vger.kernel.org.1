Return-Path: <stable+bounces-220413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIx8LBA4o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67E1C63D5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0012434403A7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7053AFCBF;
	Sat, 28 Feb 2026 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9Xv2qZg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2523AFCB7;
	Sat, 28 Feb 2026 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300304; cv=none; b=k+F77sIO1zEhwQXsnlDX4N9AlARY6jtfGfbkqUag4/nCMaE9mzMTAnQ/ARE9/zNWlBrM4vF8DCQNFQI/aEzKN8DBv6e4z4Puwwg7scsxnhyNZrpv1w/D2RxvupuinO5QlLn+Kz8tekOVIFAKL9Vzy5iY7d1bHeoOsb/bvzP+7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300304; c=relaxed/simple;
	bh=GdWWcZDRSvnIM3rqIhAKkzmXIVXNAl+m2KMx6notem4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/83F1CEgejDUdWHIqSbIfextPVeWAGX4YqHJpFWXtamcotbCCOFLpoxbUapOR3iaSpkcxE4kCMgCmi9lbwCpM3OYzsrwx3g+Y1b2gidKaS50iJKiGIxS455qu1+LfrZtGWgpmziMQL4TtIoEow9zUV101e/mZbcXlKi/TwmyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9Xv2qZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC69BC19425;
	Sat, 28 Feb 2026 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300304;
	bh=GdWWcZDRSvnIM3rqIhAKkzmXIVXNAl+m2KMx6notem4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9Xv2qZgpWFLuM7Ev4yFseYSTlrz9D9Ro01ZKzPHRdKc251KQG/LH2HfW/Mrx65Tf
	 5CRGTyI5RQq1pfAF3G51djBXoHqWgmt8a0+a/eIxVEHztbwlfVWW0cPrzYgr6bo8Mf
	 89DGuNnATA75BQrrlN3+rTexcfXrRhse7+zLkJBTDTZkFiwVHVLjsuJMSXdxe3S7Q4
	 bxlgj55se0UuCCzWIfAoGS7ZwPH1ZViO/gQEU2XyshRLfEUluQS+rx4arlfrMFNDPW
	 BzCxAIQ0EhRdBSkSp6ipGsiifBoG29P+Nq1rJXMbXu+39ZT0H7H+er91lA1zqyV5Sf
	 w7DJf5BUx64TA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 334/844] PCI: Enable ACS after configuring IOMMU for OF platforms
Date: Sat, 28 Feb 2026 12:24:07 -0500
Message-ID: <20260228173244.1509663-335-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220413-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0E67E1C63D5
X-Rspamd-Action: no action

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit c41e2fb67e26b04d919257875fa954aa5f6e392e ]

Platform, ACPI, or IOMMU drivers call pci_request_acs(), which sets
'pci_acs_enable' to request that ACS be enabled for any devices enumerated
in the future.

OF platforms called pci_enable_acs() for the first device before
of_iommu_configure() called pci_request_acs(), so ACS was never enabled for
that device (typically a Root Port).

Call pci_enable_acs() later, from pci_dma_configure(), after
of_dma_configure() has had a chance to call pci_request_acs().

Here's the call path, showing the move of pci_enable_acs() from
pci_acs_init() to pci_dma_configure(), where it always happens after
pci_request_acs():

    pci_device_add
      pci_init_capabilities
        pci_acs_init
 -        pci_enable_acs
 -          if (pci_acs_enable)                <-- previous test
 -            ...
      device_add
        bus_notify(BUS_NOTIFY_ADD_DEVICE)
          iommu_bus_notifier
            iommu_probe_device
              iommu_init_device
                dev->bus->dma_configure
                  pci_dma_configure            # pci_bus_type.dma_configure
                    of_dma_configure
                      of_iommu_configure
                        pci_request_acs
                          pci_acs_enable = 1   <-- set
 +                  pci_enable_acs
 +                    if (pci_acs_enable)      <-- new test
 +                      ...
        bus_probe_device
          device_initial_probe
            ...
              really_probe
                dev->bus->dma_configure
                  pci_dma_configure            # pci_bus_type.dma_configure
                    ...
                      pci_enable_acs

Note that we will now call pci_enable_acs() twice for every device, first
from the iommu_probe_device() path and again from the really_probe() path.
Presumably that's not an issue since we also call dev->bus->dma_configure()
twice.

For the ACPI platforms, pci_request_acs() is called during ACPI
initialization time itself, independent of the IOMMU framework.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://patch.msgid.link/20260102-pci_acs-v3-1-72280b94d288@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-driver.c |  8 ++++++++
 drivers/pci/pci.c        | 10 +---------
 drivers/pci/pci.h        |  1 +
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 7c2d9d5962586..301a9418e38e0 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1650,6 +1650,14 @@ static int pci_dma_configure(struct device *dev)
 		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
 	}
 
+	/*
+	 * Attempt to enable ACS regardless of capability because some Root
+	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
+	 * the standard ACS capability but still support ACS via those
+	 * quirks.
+	 */
+	pci_enable_acs(to_pci_dev(dev));
+
 	pci_put_host_bridge_device(bridge);
 
 	/* @drv may not be valid when we're called from the IOMMU layer */
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 41596bc72f1dc..f21f6933c9b63 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1015,7 +1015,7 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-static void pci_enable_acs(struct pci_dev *dev)
+void pci_enable_acs(struct pci_dev *dev)
 {
 	struct pci_acs caps;
 	bool enable_acs = false;
@@ -3651,14 +3651,6 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 void pci_acs_init(struct pci_dev *dev)
 {
 	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
-
-	/*
-	 * Attempt to enable ACS regardless of capability because some Root
-	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
-	 * the standard ACS capability but still support ACS via those
-	 * quirks.
-	 */
-	pci_enable_acs(dev);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 36f32b8af6ab3..ecc67fbb159c4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -957,6 +957,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_acs_init(struct pci_dev *dev);
+void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
-- 
2.51.0


