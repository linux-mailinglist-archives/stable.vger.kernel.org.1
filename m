Return-Path: <stable+bounces-10575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F34B82C17B
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 15:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6075EB2128B
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F61A6DCEB;
	Fri, 12 Jan 2024 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpJurPph"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171546DCE8
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705069291; x=1736605291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qMii7LqnHUt2EQWjCfLS5licgwrZHEYubSesPKNL3xs=;
  b=GpJurPphDOOpowpNtTzLPH3nG5moV6twKGTDueH6nP7Z6M7OHfwECVPg
   JSmeEyWw7eCkUmRrTxJQYmTALCLZApb1WMR2jknViyXhw0g1w/oJ7E7ic
   OrKOMmg8oX53VxxylectWevvrtlKsQVEbSfpTIu2+8MVkZyvMUHNLEBQj
   muQteXBDErazlKSKpFrfsHXRr2ENCOvZehUyhUcgOUtiOPNF1gptiOLQu
   LqAWw4KHXZlLylQbxYxJWwOMAFb0ykHrPcd9a5Vfn1ZTI3ESEiqAiYM4M
   Un72aB/IqcE+LvJlwqZGAKDmcxM8QlNIDyYW3ejV7XYaJrf+10TYwPWYU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="430357799"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="430357799"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:21:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="1114235362"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="1114235362"
Received: from bartoszp-dev.igk.intel.com ([10.91.3.51])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:21:21 -0800
From: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: joel.a.gibson@intel.com,
	emil.s.tantilov@intel.com,
	gaurav.s.emmanuel@intel.com,
	sridhar.samudrala@intel.com,
	lihong.yang@intel.com,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.19 1/2] PCI: Extract ATS disabling to a helper function
Date: Fri, 12 Jan 2024 14:20:55 +0000
Message-ID: <20240112142056.395197-2-bartosz.pawlowski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112142056.395197-1-bartosz.pawlowski@intel.com>
References: <20240112142056.395197-1-bartosz.pawlowski@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit f18b1137d38c091cc8c16365219f0a1d4a30b3d1 ]

Introduce quirk_no_ats() helper function to provide a standard way to
disable ATS capability in PCI quirks.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230908143606.685930-2-bartosz.pawlowski@intel.com
Signed-off-by: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/quirks.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3a165710fbb8..20180894f82d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5182,6 +5182,12 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 
 #ifdef CONFIG_PCI_ATS
+static void quirk_no_ats(struct pci_dev *pdev)
+{
+	pci_info(pdev, "disabling ATS\n");
+	pdev->ats_cap = 0;
+}
+
 /*
  * Some devices require additional driver setup to enable ATS.  Don't use
  * ATS for those devices as ATS will be enabled before the driver has had a
@@ -5194,8 +5200,7 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 	    (pdev->device == 0x7341 && pdev->revision != 0x00))
 		return;
 
-	pci_info(pdev, "disabling ATS\n");
-	pdev->ats_cap = 0;
+	quirk_no_ats(pdev);
 }
 
 /* AMD Stoney platform GPU */
-- 
2.43.0


