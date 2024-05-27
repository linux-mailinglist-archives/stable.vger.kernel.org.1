Return-Path: <stable+bounces-46312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ECD8D015B
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E812853C8
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847815EFA4;
	Mon, 27 May 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N53DSNHT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6D743AC1;
	Mon, 27 May 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816297; cv=none; b=IyM8a12fmb77XuWMBzJ/5SIhTWSqjLR40/W/dMw4IYJyrSx461S2iYs/GjdCF+ePNWU+d8qd3FPdKSN/duYgw2faN6YpdRoIFeFZWD8JHyWggEFijnGMSZIRJB0YOfEPVjSftYdZtKwPL7prDU5o8XqcvU+4plz0Xpe0j3DUAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816297; c=relaxed/simple;
	bh=f4fM4T0TMF6cOrFSdyxC7ZQRG1qooTij00PqLggleCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SyM2m8f6GWfMpdOXGF8l/87uAxO94cZ5AuQIxKcSr2VtfUO4WLGe9cWLuznxa6B1iLozEkIeKZWcvkalVqqgYu6ei/YnzCFl8tgUhaTsB4nJzceOxFEpvk9DEWLWZpZI72WjfeWQ3VCm/ZK5aXdgCkpeDdVr+R57cmZD7GdW3b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N53DSNHT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816296; x=1748352296;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f4fM4T0TMF6cOrFSdyxC7ZQRG1qooTij00PqLggleCU=;
  b=N53DSNHTW8iifcNnvTDSSvDmuqqQiKqXtGdJQBG0lJMdNyBrTps3ITWT
   lw1CFrVwWGPiwKYB28RifwdqyFD4Xp6z6bEJdA+K4kU3ew8GJCe/x56k9
   fLpBO60EK4gAIRyGNuMpS55Uhrh3YibtIVR6lDaJKnlsZtiPzQYcYPy8S
   tTg13TB5RGQI6gPuPBs5WCalcrMWA0yDXKQkEL0YMIIIQpUisrN33VjKU
   L5I6cPSfDrak7Uq1UXI/j+Xkb7B97tymrsSXfP2SJiMWS2pZy1335DYcm
   zHyGFp8UJS8nHbaG5lYKIdRrLntcVqNc1wSj3Ayyyt0iXryCwgsqi0GGZ
   Q==;
X-CSE-ConnectionGUID: tM/vpn2rQYmDru4cRgnhaw==
X-CSE-MsgGUID: R+ksqsj7TbWaSKdI2oMGrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13325750"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13325750"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:24:55 -0700
X-CSE-ConnectionGUID: gxmgFYY+Ti2gmtwIf+Yhdw==
X-CSE-MsgGUID: 9PZXqOcCSlyWLBpfjurhRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34841336"
Received: from unknown (HELO localhost) ([10.245.247.140])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:24:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Pierre Ossman <drzeus@drzeus.cx>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdhci-pci: Convert PCIBIOS_* return codes to errnos
Date: Mon, 27 May 2024 16:24:41 +0300
Message-Id: <20240527132443.14038-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

jmicron_pmos() and sdhci_pci_probe() use pci_{read,write}_config_byte()
that return PCIBIOS_* codes. The return code is then returned as is by
jmicron_probe() and sdhci_pci_probe(). Similarly, the return code is
also returned as is from jmicron_resume(). Both probe and resume
functions should return normal errnos.

Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
errno before returning them the fix these issues.

Fixes: 7582041ff3d4 ("mmc: sdhci-pci: fix simple_return.cocci warnings")
Fixes: 45211e215984 ("sdhci: toggle JMicron PMOS setting")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index ef89ec382bfe..23e6ba70144c 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1326,7 +1326,7 @@ static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 
 	ret = pci_read_config_byte(chip->pdev, 0xAE, &scratch);
 	if (ret)
-		return ret;
+		goto fail;
 
 	/*
 	 * Turn PMOS on [bit 0], set over current detection to 2.4 V
@@ -1337,7 +1337,10 @@ static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 	else
 		scratch &= ~0x47;
 
-	return pci_write_config_byte(chip->pdev, 0xAE, scratch);
+	ret = pci_write_config_byte(chip->pdev, 0xAE, scratch);
+
+fail:
+	return pcibios_err_to_errno(ret);
 }
 
 static int jmicron_probe(struct sdhci_pci_chip *chip)
@@ -2202,7 +2205,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 
 	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &slots);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 
 	slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
 	dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
@@ -2211,7 +2214,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 
 	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &first_bar);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 
 	first_bar &= PCI_SLOT_INFO_FIRST_BAR_MASK;
 
-- 
2.39.2


