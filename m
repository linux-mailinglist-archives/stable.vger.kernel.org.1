Return-Path: <stable+bounces-239923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIN7LJZY5mmbvAEAu9opvQ
	(envelope-from <stable+bounces-239923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:47:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D6430031
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 893BE32E9CAC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAFC34402B;
	Mon, 20 Apr 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pbuTjkAp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B033B945;
	Mon, 20 Apr 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701560; cv=none; b=qB7ldMUfAIAjEhnC0bt4BVL/PbGouQ7/9mUyQ+Q75prMyZSRPYEEqXEi+/njV87RI+iVXlEWhSKDp3vQOKnuvPOw90XVXu+W6DQHAuxzQkps9IiYg8+aCbG27YaB8HF1vY//DD1KiM5SThQvqH3Bd99tYaX/YzoKikLVtt61FtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701560; c=relaxed/simple;
	bh=Uvli9HKZnwOv8j4Vdv4MBP7q584tu8l/CNrqa1a1qJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sf7Ouo0WKNgqNzdvh5K8IjwXt1Po4vHdXbbfkhJC7N4C8Kygf9pQ5n/lWMa2/lgyUAu5DElvak28VIsG/qzhO5fD7OS9m6Ye2AMCgiLXI64TVqv4F8IB2Wl/uQ2RjdXIAdF7HNP4fcMOs5vfcKZ5mPe6dxbjYuTtRJNNeRRBm24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pbuTjkAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3E2C19425;
	Mon, 20 Apr 2026 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701560;
	bh=Uvli9HKZnwOv8j4Vdv4MBP7q584tu8l/CNrqa1a1qJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbuTjkApZWcx1uAnSSAjWAvEcL9JqmvyBEv+V2kbEp6XXnKHH8ulzAGwLSF3tskq3
	 /eU/eiB56J1gkvaCV1lohcrmQup+0mT9/Ir4nvFEmfEcYqx7VTJOfoxPMWM5Ui8IeU
	 u9SXZFDjHhNFW+KUlb/RtmVurAY5IorFF9qepZJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"bhelgaas@google.com, manivannan.sadhasivam@oss.qualcomm.com, joro@8bytes.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev, John Hancock" <john@kernel.doghat.io>,
	John Hancock <john@kernel.doghat.io>
Subject: [PATCH 6.12 162/162] PCI: Revert "Enable ACS after configuring IOMMU for OF platforms"
Date: Mon, 20 Apr 2026 17:43:14 +0200
Message-ID: <20260420153932.926386532@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239923-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[doghat.io:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 6C1D6430031
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Hancock <john@kernel.doghat.io>

This reverts 7a126c1b6cfa2c4b5a7013164451ecddd210110d which is
commit c41e2fb67e26b04d919257875fa954aa5f6e392e upstream.

Commit 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF
platforms") introduced a regression affecting AMD IOMMU group isolation
on x86 systems, making PCIe passthrough non-functional.

While the commit addresses a legitimate ordering issue on OF/Device Tree
platforms, the fix modifies pci_dma_configure(), which executes on all
platforms regardless of firmware interface. On AMD systems with IOMMU,
moving pci_enable_acs() from pci_acs_init() to pci_dma_configure() alters
the point at which ACS is evaluated relative to IOMMU group assignment.
The result is that devices which previously occupied individual, exclusive
IOMMU groups are merged into a single group containing both passthrough
and non-passthrough members, violating IOMMU isolation requirements.

The commit author notes that pci_enable_acs() is now called twice per
device and that this is "presumably not an issue." On AMD IOMMU hardware
this assumption does not hold -- the change in call ordering has
observable and breaking consequences for group topology.

It is worth noting that this is a stable/LTS series (6.12.y), where
changes to fundamental PCI initialization ordering carry significant
risk for production and specialized workloads that depend on stable
IOMMU behavior across kernel updates. A regression of this nature --
silently breaking PCIe passthrough without any configuration change on
the part of the user -- is particularly disruptive in a series that
users reasonably expect to be conservative.

This revert restores pci_enable_acs() to pci_acs_init() and marks it
static again, fully restoring correct IOMMU group topology on affected
hardware.

Regression introduced in: 6.12.75
Tested on: 6.12.77 with this revert applied

Hardware:
  CPU:   AMD Ryzen Threadripper 2990WX (family 23h, Zen+)
  IOMMU: AMD-Vi

Bisect:
  6.12.74: GOOD -- IOMMU groups correct, passthrough functional
  6.12.75: BAD  -- IOMMU groups collapsed, passthrough broken
  6.12.76: BAD  -- still broken
  6.12.77: BAD  -- still broken

Fixes: 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF platforms")
Signed-off-by: John Hancock <john@kernel.doghat.io>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-driver.c |    8 --------
 drivers/pci/pci.c        |   10 +++++++++-
 drivers/pci/pci.h        |    1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1656,14 +1656,6 @@ static int pci_dma_configure(struct devi
 		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
 	}
 
-	/*
-	 * Attempt to enable ACS regardless of capability because some Root
-	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
-	 * the standard ACS capability but still support ACS via those
-	 * quirks.
-	 */
-	pci_enable_acs(to_pci_dev(dev));
-
 	pci_put_host_bridge_device(bridge);
 
 	if (!ret && !driver->driver_managed_dma) {
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1072,7 +1072,7 @@ static void pci_std_enable_acs(struct pc
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+static void pci_enable_acs(struct pci_dev *dev)
 {
 	struct pci_acs caps;
 	bool enable_acs = false;
@@ -3718,6 +3718,14 @@ bool pci_acs_path_enabled(struct pci_dev
 void pci_acs_init(struct pci_dev *dev)
 {
 	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+
+	/*
+	 * Attempt to enable ACS regardless of capability because some Root
+	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
+	 * the standard ACS capability but still support ACS via those
+	 * quirks.
+	 */
+	pci_enable_acs(dev);
 }
 
 /**
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -653,7 +653,6 @@ static inline resource_size_t pci_resour
 }
 
 void pci_acs_init(struct pci_dev *dev);
-void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);



