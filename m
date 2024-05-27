Return-Path: <stable+bounces-46303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737838D0080
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147311F23D9A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 12:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B7015E5D6;
	Mon, 27 May 2024 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2C+pWB0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5715575E;
	Mon, 27 May 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814553; cv=none; b=tAl1UOnLNCTGI7pgLDtoA3SdnOfZu+4FgRbT+dU7pFQdJJ1AKSycF4vBnu+LuWwtZEyqEKWthIzgt60lCaHSbqvwh3jdbpcVde/LI2wGEoVv3aT46y4eNkMsRqfxaKKS6q/z60r8V+hF2sz3UBKtBw2RCWNGUdCufcaXiShJU1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814553; c=relaxed/simple;
	bh=WIhj8ZlUhbORZnFlYZJT6FSSNy0cIwYmfFiWuKbPLNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SjqiGWFVNFtLHTOR1j9BB0Q7+OkNYddZ2qoHH8MuHJrDE72NUQkAy7bdiNQU0HBsVc0CLcAiZ5yQZaSp+34UR4BodnU4htOBxdcNj7toFE7Icf8aBUQXUkJccHkn6B0p92IqzBduNa5IaDKkK6SBbWtcsFZoqdD8l/q+T27iiEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2C+pWB0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716814551; x=1748350551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WIhj8ZlUhbORZnFlYZJT6FSSNy0cIwYmfFiWuKbPLNY=;
  b=H2C+pWB0/cI4Dqxs89BLPRHwJXe1GeaO4PBRPongDb0iwizHrJYvrThE
   ILoesjRzdB9lbLClc+8kpbNW64lCXY6vrSdnJNXzd9A5z10oa5iaRhfLO
   rlV6sksAEYsKIANVYWB6dApDTovq4RDNNXPnZ47bHKF/Ss9Z58NIsBdNd
   LVB4U5eCAjenG8i1mhEFd4RdI7UUutsDZOgO2VqeMnRy4mckv5WX3X9Ji
   zFmyHMSTfE4/gUELu7RPZPjnSkojDKyUL7J+lRKbqwuHzi9GKvQyhQZVe
   rli6+G3njKjUu9Mk9+TMYJBEXtWe0UXc0DDio0B+FHK5HRm3quiYWKqRp
   A==;
X-CSE-ConnectionGUID: +xfapkzxSqeU+KDI49rPjA==
X-CSE-MsgGUID: +UXYoRdpQoeY9YnRwTV4jQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="23734068"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="23734068"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 05:55:50 -0700
X-CSE-ConnectionGUID: XMTbiM2bSSq6qNv4xtHhAg==
X-CSE-MsgGUID: 1doX+hmwQf6IrRS9QSMc1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34643614"
Received: from unknown (HELO localhost) ([10.245.247.139])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 05:55:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] x86/of: Return consistent error type from x86_of_pci_irq_enable()
Date: Mon, 27 May 2024 15:55:35 +0300
Message-Id: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

x86_of_pci_irq_enable() returns PCIBIOS_* code received from
pci_read_config_byte() directly and also -EINVAL which are not
compatible error types. x86_of_pci_irq_enable() is used as
(*pcibios_enable_irq) function which should not return PCIBIOS_* codes.

Convert the PCIBIOS_* return code from pci_read_config_byte() into
normal errno using pcibios_err_to_errno().

Fixes: 96e0a0797eba ("x86: dtb: Add support for PCI devices backed by dtb nodes")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/devicetree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 8e3c53b4d070..64280879c68c 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -83,7 +83,7 @@ static int x86_of_pci_irq_enable(struct pci_dev *dev)
 
 	ret = pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 	if (!pin)
 		return 0;
 
-- 
2.39.2


