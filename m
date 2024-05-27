Return-Path: <stable+bounces-46314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 246A28D0165
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D468828A11F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609B15ECFE;
	Mon, 27 May 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQAYcjta"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD915E5CC;
	Mon, 27 May 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816366; cv=none; b=tTMd682wjXv6/7aOJygnB5CdtO8ISnzKCfqZP9S+isEjXXRoHXtqo3Wm6OG/mSSIf2U1/6HSTWW9cx3LwYHlnSW51jRLF3u+3zl4dZKKIx7mgIhEmaJdJwU3zHiqLRHzAFuRNnvacDlxVIzcxg+I3PkHxUCiKDxoKv7YOTlNvkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816366; c=relaxed/simple;
	bh=A7OKadLaoCRz5R/qj8fiyIi+G0M1yoSql7UbDHY+5UY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Wg7K5xD0WewiZ1W5I5xXLi45hbgV0HMxk2YX6txcoMCIztpFAOpit9Ty021RQ0iiLjbik4RkKzyzQ8HCesy2AQmCXdUBh66aT4/2lfsZSCDBVWIaIpbphrp81B0UrH7HIeev1L3pfiaVRY5kksOsvB+nLVrCJYWk/krwwjxPmYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQAYcjta; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816364; x=1748352364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A7OKadLaoCRz5R/qj8fiyIi+G0M1yoSql7UbDHY+5UY=;
  b=FQAYcjtaMzByrHv6M3SYsoiHQ3N9++azZPl2xrZiiLAmghvFynWDDre0
   IO8CHV70lvgVNIQsCCwpqnKCQB1oVlM7dvZo8ogb2UFDhUvcW0Q8vq95J
   k4JhN4XzFttiNg+WIgZms+mvd6U9ZxKi7kM1i7HFNFbQIHrQ26iUgJhGF
   HX187Pl79JrIvZu1etKnxaabrn92RpGehAy6Tc/B8VX/2QiCi85v/I7Ij
   zuKNdp7E+YuWPpGE9poqTJRvhUnWXWyIkGT0OfS2pmMKfUOn0h42dkXA7
   bBcyvGLZ9sCN8Jbhxw2VDEX/VZGXhV+Bx9bJzoecVSon4MA2cxLIHdtgy
   Q==;
X-CSE-ConnectionGUID: GkD4pJqjT9qHxbbAIKKvOg==
X-CSE-MsgGUID: RhlEt2DLQX+WiAsCh9tFBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="38520281"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="38520281"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:26:03 -0700
X-CSE-ConnectionGUID: 8oR2m5pISKebTliMcOv3GQ==
X-CSE-MsgGUID: /4BWKaQbQue2aftMKpOPhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39206633"
Received: from unknown (HELO localhost) ([10.245.247.140])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:25:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] Bluetooth: hci_bcm4377: Convert PCIBIOS_* return codes to errnos
Date: Mon, 27 May 2024 16:25:51 +0300
Message-Id: <20240527132552.14119-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bcm4377_init_cfg() uses pci_{read,write}_config_dword() that return
PCIBIOS_* codes. The return codes are returned into the calling
bcm4377_probe() which directly returns the error which is of incorrect
type (a probe should return normal errnos).

Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
errno before returning it from bcm4377_init_cfg. This conversion is the
easiest by adding a label next to return and doing the conversion there
once rather than adding pcibios_err_to_errno() into every single return
statement.

Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/bluetooth/hci_bcm4377.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 0c2f15235b4c..b00240109dc3 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -2134,44 +2134,46 @@ static int bcm4377_init_cfg(struct bcm4377_data *bcm4377)
 				     BCM4377_PCIECFG_BAR0_WINDOW1,
 				     bcm4377->hw->bar0_window1);
 	if (ret)
-		return ret;
+		goto fail;
 
 	ret = pci_write_config_dword(bcm4377->pdev,
 				     BCM4377_PCIECFG_BAR0_WINDOW2,
 				     bcm4377->hw->bar0_window2);
 	if (ret)
-		return ret;
+		goto fail;
 
 	ret = pci_write_config_dword(
 		bcm4377->pdev, BCM4377_PCIECFG_BAR0_CORE2_WINDOW1,
 		BCM4377_PCIECFG_BAR0_CORE2_WINDOW1_DEFAULT);
 	if (ret)
-		return ret;
+		goto fail;
 
 	if (bcm4377->hw->has_bar0_core2_window2) {
 		ret = pci_write_config_dword(bcm4377->pdev,
 					     BCM4377_PCIECFG_BAR0_CORE2_WINDOW2,
 					     bcm4377->hw->bar0_core2_window2);
 		if (ret)
-			return ret;
+			goto fail;
 	}
 
 	ret = pci_write_config_dword(bcm4377->pdev, BCM4377_PCIECFG_BAR2_WINDOW,
 				     BCM4377_PCIECFG_BAR2_WINDOW_DEFAULT);
 	if (ret)
-		return ret;
+		goto fail;
 
 	ret = pci_read_config_dword(bcm4377->pdev,
 				    BCM4377_PCIECFG_SUBSYSTEM_CTRL, &ctrl);
 	if (ret)
-		return ret;
+		goto fail;
 
 	if (bcm4377->hw->clear_pciecfg_subsystem_ctrl_bit19)
 		ctrl &= ~BIT(19);
 	ctrl |= BIT(16);
 
-	return pci_write_config_dword(bcm4377->pdev,
-				      BCM4377_PCIECFG_SUBSYSTEM_CTRL, ctrl);
+	ret = pci_write_config_dword(bcm4377->pdev,
+				     BCM4377_PCIECFG_SUBSYSTEM_CTRL, ctrl);
+fail:
+	return pcibios_err_to_errno(ret);
 }
 
 static int bcm4377_probe_dmi(struct bcm4377_data *bcm4377)
-- 
2.39.2


