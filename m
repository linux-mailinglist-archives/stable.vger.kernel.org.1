Return-Path: <stable+bounces-180454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDC8B81FDF
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 23:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F2D4A5804
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 21:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFB830DD07;
	Wed, 17 Sep 2025 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fk8TaOm4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7760726CE3A
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145077; cv=none; b=pVbAXQjWP0cueitVQUKPFGU+Ihim9p0kgeDmwxjtkuU/VSHj7i+JlXTvJWfobscZYoYHlj6Kz5McpTz96vGh6H8NtVexY1hSAj77riJlI1A4XJWhsWRIBQweIdteEe6oV0dT8nIYA2Cp937O9rw2Ms0oBJzDHpBd0CP8bhvjm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145077; c=relaxed/simple;
	bh=/iMfp8vig0mHKZAxlSf/u9heZ6hDxMUA6/Hx0ZTiPiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPVehpOFNbjHnKfpI8kAGzzyMsfLOjPmcaSF3tEsspiUrCbg1pdzKS/tl656bKcoavfwzdDi+Huld6l0M96n7jxpShJGfg3119IPi2uPbgT0pPPZVB89OLVc5ONwLi4XVH72uUfVm0qJNnCkZ328LLbVCFPAI/IvRyZJZuTugco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fk8TaOm4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758145076; x=1789681076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/iMfp8vig0mHKZAxlSf/u9heZ6hDxMUA6/Hx0ZTiPiQ=;
  b=fk8TaOm4RVUcHacYO32rvB4Ek9fVObrvtEOS/4tXWi+GUVt2swMXfYGA
   0/pgSl2nEEKPaHPQz0xmkw/2fz7x2anC+GO+3mmAF9nk6fTdSrCbofMVP
   qIUZOSLKSAqMj0hVKY26uhRnkIohuOrXyB8jaYs/6ZBEpWwxuSGBbx/jk
   iUqB/9OQdoHqDtd8YpOTdBdUqHdtxeNUkFxJ2fqUp7F/2oJORUvvVy14x
   tUaQ0oxwcVLGvHLzf1xFPOz+h4ofd/ivG6DqyUMpMuAPUiC+9REHfmAaw
   21w9nyKWynZfbL5ho1N0UEn+lAgibeaQ8T9MKvfmnjhdFYP+I2Z1/owXP
   Q==;
X-CSE-ConnectionGUID: aYbaa7CvR36QbNeF16fC+A==
X-CSE-MsgGUID: 7MqWfOHKRmevSiufm/sw1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60522747"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60522747"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 14:37:52 -0700
X-CSE-ConnectionGUID: 9fkasHJuSRGIKizPq+iZIw==
X-CSE-MsgGUID: LdqgF4PBQ5SC9hf53RAd3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="179643054"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 14:37:52 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] PCI: Release BAR0 of an integrated bridge to allow GPU BAR resize
Date: Wed, 17 Sep 2025 14:37:30 -0700
Message-ID: <20250917-xe-pci-rebar-2-v1-1-005daa7c19be@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917-xe-pci-rebar-2-v1-0-005daa7c19be@intel.com>
References: <20250917-xe-pci-rebar-2-v1-0-005daa7c19be@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-b03c7
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Resizing BAR to a larger size has to release upstream bridge windows in
order make the bridge windows larger as well (and to potential relocate
them into a larger free block within iomem space). Some GPUs have an
integrated PCI switch that has BAR0. The resource allocation assigns
space for that BAR0 as it does for any resource.

An extra resource on a bridge will pin its upstream bridge window in
place which prevents BAR resize for anything beneath that bridge.

Nothing in the pcieport driver provided by PCI core, which typically is
the driver bound to these bridges, requires that BAR0. Because of that,
releasing the extra BAR does not seem to have notable downsides but
comes with a clear upside.

Therefore, release BAR0 of such switches using a quirk and clear its
flags to prevent any new invocation of the resource assignment
algorithm from assigning the resource again.

Due to other siblings within the PCI hierarchy of all the devices
integrated into the GPU, some other devices may still have to be
manually removed before the resize is free of any bridge window pins.
Such siblings can be released through sysfs to unpin windows while
leaving access to GPU's sysfs entries required for initiating the
resize operation, whereas removing the topmost bridge this quirk
targets would result in removing the GPU device as well so no manual
workaround for this problem exists.

Reported-by: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # 6.12+
Link: https://lore.kernel.org/linux-pci/fl6tx5ztvttg7txmz2ps7oyd745wg3lwcp3h7esmvnyg26n44y@owo2ojiu2mov/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/pci/quirks.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d97335a401930..98a4f0a1285be 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6338,3 +6338,23 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * PCI switches integrated into some GPUs have BAR0 that prevents resizing
+ * the BARs of the GPU device due to that bridge BAR0 pinning the bridge
+ * window it's under in place. Nothing in pcieport requires that BAR0.
+ *
+ * Release and disable BAR0 permanently by clearing its flags to prevent
+ * anything from assigning it again.
+ */
+static void pci_release_bar0(struct pci_dev *pdev)
+{
+	struct resource *res = pci_resource_n(pdev, 0);
+
+	if (!res->parent)
+		return;
+
+	pci_release_resource(pdev, 0);
+	res->flags = 0;
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL, 0xe2ff, pci_release_bar0);

-- 
2.50.1


