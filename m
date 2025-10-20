Return-Path: <stable+bounces-188224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99183BF2DFE
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A52B4E8687
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340F92638BF;
	Mon, 20 Oct 2025 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk9dn6aQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41BB11CBA
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983832; cv=none; b=lyyGU2nAF8zeBqk6jJ6mS6kC2/kFNSv6RBT/F7izZoRz7TIEKiYE9lbvTfXJlpaXah5UN3tV77/an2mSlE513SyO9j10hpmYlxB6+7imyZu+xtzWGWaFvgMY2KuSBkRjo9e970FG/WQMe48mWc5PikbraLBJoi4xLGZldoq5rUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983832; c=relaxed/simple;
	bh=a38Rl7hXxszQxmwuQrXj5c4168klNiUUDegfa/0COVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CP4FZQbcFUEnoJnD5sWgALiXTgAkrEtx23wLKt7VKoF79Z/R1ukWJWVJyPCioyny3HTRfFdXFwp0ifcRhESqpZWDBtFQOh18WjvnkItqDtZrkDo8FG4PdOfOUjWYRZTUmZRR9gAL49xTSy1l1OqNyqu+CiJZqBZYZnqcieQiQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk9dn6aQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B4EC4CEF9;
	Mon, 20 Oct 2025 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760983831;
	bh=a38Rl7hXxszQxmwuQrXj5c4168klNiUUDegfa/0COVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hk9dn6aQdxfsKMl7uArVI86NNA/o1HkehchQK2tRbsXGgSeChAYZbJDY1J1pGYbEQ
	 Ah1TEbsIkwa2rg9j0wtEPNzxbqOYOB8GF/FMC0000TGYdlw64nYQ5G+WrDiLsdzsqI
	 7OH4lqw5sI8avWJIAnR18p8fa5EywmOLDlqlm6iuMex76zbXPXGxpDQV7o11PCTodi
	 JBCP4aZNn7upm5t9VV6LAJzkAeokGmwYg71A2PCexYa6g6mRtiqbD1LGH0O/rcR2Pr
	 G0/lvut3dsx0AaR/CnrJ4oN2oqY2sO9zCznoNrLeVIrpMZCVEIIE5OpC5HJrH05aGa
	 Yu57n/ENiSnOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] PCI: Add PCI_VDEVICE_SUB helper macro
Date: Mon, 20 Oct 2025 14:10:25 -0400
Message-ID: <20251020181028.1864198-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102051-bonded-proofread-bd52@gregkh>
References: <2025102051-bonded-proofread-bd52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

[ Upstream commit 208fff3f567e2a3c3e7e4788845e90245c3891b4 ]

PCI_VDEVICE_SUB generates the pci_device_id struct layout for
the specific PCI device/subdevice. Private data may follow the
output.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: a7075f501bd3 ("ixgbevf: fix mailbox API compatibility by negotiating supported features")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0511f6f9a4e6a..e4338237a0545 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1034,6 +1034,20 @@ static inline struct pci_driver *to_pci_driver(struct device_driver *drv)
 	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0
 
+/**
+ * PCI_VDEVICE_SUB - describe a specific PCI device/subdevice in a short form
+ * @vend: the vendor name
+ * @dev: the 16 bit PCI Device ID
+ * @subvend: the 16 bit PCI Subvendor ID
+ * @subdev: the 16 bit PCI Subdevice ID
+ *
+ * Generate the pci_device_id struct layout for the specific PCI
+ * device/subdevice. Private data may follow the output.
+ */
+#define PCI_VDEVICE_SUB(vend, dev, subvend, subdev) \
+	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
+	.subvendor = (subvend), .subdevice = (subdev), 0, 0
+
 /**
  * PCI_DEVICE_DATA - macro used to describe a specific PCI device in very short form
  * @vend: the vendor name (without PCI_VENDOR_ID_ prefix)
-- 
2.51.0


