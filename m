Return-Path: <stable+bounces-10580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BBC82C1AB
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 15:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75067B2446A
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DA86DCEF;
	Fri, 12 Jan 2024 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QT0nOFGV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB46DCF7
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705069503; x=1736605503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=shvThxHd6UUCuIS6FpdXuY5ibA2t+UIX6WKl89vn63o=;
  b=QT0nOFGVb+onWHdotXrK5Ta1s2aNmSPqHvUkyJgISVtMpG/WVxJ+a38k
   EfL5oWyqIWReRcDgsi18syG+XIVaQTE6UN2iQGMVsH74X+z0+P4u+Qhr4
   RnDZTB+f0IkZgQ/EIiKasUQD9dgjPalkL3yorDyogCZhWEZXsmh9GP1nm
   SAIbyWlqikMX4zAhXN5YdbNQJahCrUouQ9fmCNY00BEh/fsVIxWN5jxuM
   yWnKTWSHKw2T9NaFOvOJe8sO2GNabHxMxo3chKbHbc8bj3a6sTk5oHdTc
   fX8Tq5pOUdrzJOYmjrIiZuVgtl+7adfpOFFqcQ90OU14t6pSBakSarcLJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="5948505"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="5948505"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:25:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="776015265"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="776015265"
Received: from bartoszp-dev.igk.intel.com ([10.91.3.51])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:24:58 -0800
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
Subject: [PATCH 5.4 1/2] PCI: Extract ATS disabling to a helper function
Date: Fri, 12 Jan 2024 14:24:38 +0000
Message-ID: <20240112142439.395502-2-bartosz.pawlowski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112142439.395502-1-bartosz.pawlowski@intel.com>
References: <20240112142439.395502-1-bartosz.pawlowski@intel.com>
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
index 780223694c00..77741c256591 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5389,6 +5389,12 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0420, quirk_no_ext_tags);
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
@@ -5401,8 +5407,7 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 	    (pdev->device == 0x7341 && pdev->revision != 0x00))
 		return;
 
-	pci_info(pdev, "disabling ATS\n");
-	pdev->ats_cap = 0;
+	quirk_no_ats(pdev);
 }
 
 /* AMD Stoney platform GPU */
-- 
2.43.0


