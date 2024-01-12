Return-Path: <stable+bounces-10573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0816482C16F
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 15:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD48D286A5C
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385BE6D1D6;
	Fri, 12 Jan 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gjl+ZdY1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F564AAA
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705069019; x=1736605019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=odUGBQbtggg0xT8z6uHpOxeCdHV4tRD5sIqyVkmrs0w=;
  b=Gjl+ZdY1UdQbg7XlVtC9r7ACLDCtUTDKOjmZjCrms2iLooPG/pcwC6vG
   y0k3P9+D8JKk0IS7ESIDti+JuLctf6ZNo40NVfIYZnZpD3pJOK/c60Crl
   R+ZpGo2RTXrbd7h2uzG//h7V8ke5dnUnpzw3rVAcUATGDP+aBtxObUEpy
   Tlmg5J05GVNWcyzYBNqBnVU2xYRZbeaQlqCCAW4uQkSJLcXdFXiKPQLbp
   DqD4p22GxCVejSX+OX8BpDYuaqp7GvgbRHwWGE9rLVVAGMXD56y0Hv4i6
   QG4Em9o7yW8sEiWHAtRjwNuu31Nt70yGq+KCjKX8tlkIR5PI4RTuATrXz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="398864581"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="398864581"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="901985724"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="901985724"
Received: from bartoszp-dev.igk.intel.com ([10.91.3.51])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:16:56 -0800
From: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: joel.a.gibson@intel.com,
	emil.s.tantilov@intel.com,
	gaurav.s.emmanuel@intel.com,
	sridhar.samudrala@intel.com,
	lihong.yang@intel.com,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH 5.10 2/2] PCI: Disable ATS for specific Intel IPU E2000 devices
Date: Fri, 12 Jan 2024 14:15:45 +0000
Message-ID: <20240112141545.395067-3-bartosz.pawlowski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112141545.395067-1-bartosz.pawlowski@intel.com>
References: <20240112141545.395067-1-bartosz.pawlowski@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit a18615b1cfc04f00548c60eb9a77e0ce56e848fd ]

Due to a hardware issue in A and B steppings of Intel IPU E2000, it expects
wrong endianness in ATS invalidation message body. This problem can lead to
outdated translations being returned as valid and finally cause system
instability.

To prevent such issues, add quirk_intel_e2000_no_ats() to disable ATS for
vulnerable IPU E2000 devices.

Link: https://lore.kernel.org/r/20230908143606.685930-3-bartosz.pawlowski@intel.com
Signed-off-by: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/pci/quirks.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7a1d656d1d41..500905dad643 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5383,6 +5383,25 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
+
+/*
+ * Intel IPU E2000 revisions before C0 implement incorrect endianness
+ * in ATS Invalidate Request message body. Disable ATS for those devices.
+ */
+static void quirk_intel_e2000_no_ats(struct pci_dev *pdev)
+{
+	if (pdev->revision < 0x20)
+		quirk_no_ats(pdev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1451, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1452, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1453, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1454, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1455, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a, quirk_intel_e2000_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c, quirk_intel_e2000_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.43.0


