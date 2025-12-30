Return-Path: <stable+bounces-204187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D6CE8C7A
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 07:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 887023011F81
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 06:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2993E2EFD95;
	Tue, 30 Dec 2025 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zbtc3eTP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B94B2DC344;
	Tue, 30 Dec 2025 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767075988; cv=none; b=SlkWsLpDGAXCVoTU0zqToxHLumGpntIxPhf6qwVIb86ubDHHdiWNth1RweT4RpJ/biHbaGBZm5MXTacygx8yd0XHq2kJnEDKXly0IWJ1GIcdMHP8kpbRxJUzZUkw9JZ/gQ31JGzqWp3E31r2hMcsXilnmsHecglAy/C6PF7f3IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767075988; c=relaxed/simple;
	bh=+7mGgXD/nF3OJA5dH5enZDQvxKrTD9mqa/CWC/up6Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VagULEUo1a6cK7aKdHPNNY8Lvnm2m8fe9IbU2DcG0APAQ/OhquOeL6adTePwydjQTUaHl4Y0nY5UR7fCG/xtaRols7Wmh1KfkttGk9I85Hv027eIwOgCTlr753rQ1MAL6hybzs3sRmxFKvP6Z4OWveeHJ/er5xay5ERyagT0I8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zbtc3eTP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767075987; x=1798611987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+7mGgXD/nF3OJA5dH5enZDQvxKrTD9mqa/CWC/up6Sc=;
  b=Zbtc3eTPVkqMQiG6FQi2scBhDDHiO55aP0NPhEbM6Fedz4NIbL8qTC8G
   THIjW+xhjIEKDvKboF6Y/NJV6YlOMhSsLtlpWHTjBUHxnmrmRADqvQ1tC
   1b6JfdycR4asFnak6SV9/mdXpPL4EdnDg6bAz70Yh8ycFaqqZ1pEcSO20
   qqIqCEx88l/p2uxYBbExZtMumyTBbHpj3Nk/2OjhHmxeNqoFJGrQJRmym
   oTQnV7OqfeVgDAgg1OzHwHn2nBDrhdth43x1K8LLJW9wQihvzKknkqbYq
   sq5NgaM1a/OyrgwWKZzcl6Z1KObGB0GlKumvVZ1tOXBizwApCXF5urR6e
   Q==;
X-CSE-ConnectionGUID: HUFHzcGMSXCpnmo1owE7og==
X-CSE-MsgGUID: IH+rh9bjQuGWlgwwlEbvyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="72519727"
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="72519727"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 22:26:27 -0800
X-CSE-ConnectionGUID: OE93nIYlRZS61Fp+RYauOQ==
X-CSE-MsgGUID: +p+c+9YJSYyQh1VhYotpdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="200288882"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa006.jf.intel.com with ESMTP; 29 Dec 2025 22:26:25 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: bhelgaas@google.com,
	yinghai@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] eisa/pci_eisa: Fix PCI device refcount leak on early init error
Date: Tue, 30 Dec 2025 11:53:46 +0530
Message-Id: <20251230062346.209782-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The for_each_pci_dev() loop takes a reference on each PCI device
during iteration. When returning early on pci_eisa_init() failure,
the reference on 'dev' is not released, causing a resource leak.

Add pci_dev_put(dev) before the error return to properly balance
the reference count taken by for_each_pci_dev().

Fixes: c5fb301ae83b ("EISA/PCI: Init EISA early, before PNP")
Cc: stable@vger.kernel.org
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/eisa/pci_eisa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/eisa/pci_eisa.c b/drivers/eisa/pci_eisa.c
index 8173e60bb808..8242e9e16ce2 100644
--- a/drivers/eisa/pci_eisa.c
+++ b/drivers/eisa/pci_eisa.c
@@ -80,8 +80,10 @@ static int __init pci_eisa_init_early(void)
 	for_each_pci_dev(dev)
 		if ((dev->class >> 8) == PCI_CLASS_BRIDGE_EISA) {
 			ret = pci_eisa_init(dev);
-			if (ret)
+			if (ret) {
+				pci_dev_put(dev);
 				return ret;
+			}
 		}
 
 	return 0;
-- 
2.34.1


