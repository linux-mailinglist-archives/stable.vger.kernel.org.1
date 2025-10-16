Return-Path: <stable+bounces-186130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AEBBE3A42
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A43DC5010D0
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7211D7995;
	Thu, 16 Oct 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjXTPgAa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADAB1D63E6;
	Thu, 16 Oct 2025 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620672; cv=none; b=CyKu8fklyvokFyWA5fSduVgyptoTaS/HkiE8tjgrdvBgnS5+rZ8l65/7DF8mYHEcFiLKWxmK/mXDPzr9w0LqA2SqPXl/mAJxb/i5l0AYzijgquuq5O9DDKHTuLItknKqejD+kZjGpFZnfcBgiUxx1Ll8SJtejkOeuPVAop4hNLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620672; c=relaxed/simple;
	bh=wSZgigGVWIWXmsilk3REynnteX2zpEVtIf+T+288B4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5M6U75og6i3gk4/FTeBV8c5zF1uNVHCfewW4gSW3gNlh3NuIBV2LSIM98PKKhiv87uF4pNFADZjO+sAGrl1EzLmo+Wbm4IkC7cyR8PCQKSK1CidimYXGlfubXIbsTwLxrjMrig1aOmFcH9nN5VeoShZtlXQELiNizva3jJGtP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjXTPgAa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760620670; x=1792156670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wSZgigGVWIWXmsilk3REynnteX2zpEVtIf+T+288B4Q=;
  b=YjXTPgAaiwW/MukkDxg/mpOV9qgeWSyGDKKMFWqQEBlIRQbTl/eZ3Crg
   YbSZcPFKUbDXrTB1h09jNwEvsyEAtM+2m0pkB5XVwHM/qvaWIS9uwrCel
   PnLKf2TsFYrIpyYq0ZXTW+XsJWQDyzNfOxpgZPN/lmqjO+LLX4jiE4FtK
   lxFsvdCAIkGX6fNcugzjU5c3uL0605Pjj1E/xraKRa0XdtGAqMn6JAk1I
   /QMLXesSOQogTUZOYTwWNgcByd3p0cHX7U3lu3d+dYonv7vj6S4ywzXfg
   F8POMswetxTr+BRK65kxfVBxAuBdChEE84pCWXgKFaNZSP27Hu8zke03L
   Q==;
X-CSE-ConnectionGUID: ofWC3S6fRgeqdQosIPh9Hg==
X-CSE-MsgGUID: fCuHOoX0R62ZQ5GRqR1bIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73923798"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73923798"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 06:17:50 -0700
X-CSE-ConnectionGUID: IEXOvtPxTjuhI4gjMb8vgw==
X-CSE-MsgGUID: q7c1O4ZDT3aZCyGvKiYhMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="206159232"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 06:17:47 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tomas Winkler <tomasw@gmail.com>
Subject: [char-misc] mei: me: add wildcat lake P DID
Date: Thu, 16 Oct 2025 15:59:12 +0300
Message-ID: <20251016125912.2146136-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Wildcat Lake P device id.

Cc: stable@vger.kernel.org
Co-developed-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 2 ++
 drivers/misc/mei/pci-me.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index bc40b940ae21..a4f75dc36929 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -120,6 +120,8 @@
 #define MEI_DEV_ID_PTL_H      0xE370  /* Panther Lake H */
 #define MEI_DEV_ID_PTL_P      0xE470  /* Panther Lake P */
 
+#define MEI_DEV_ID_WCL_P      0x4D70  /* Wildcat Lake P */
+
 /*
  * MEI HW Section
  */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index b108a7c22388..b017ff29dbd1 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -127,6 +127,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_H, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_P, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_WCL_P, MEI_ME_PCH15_CFG)},
+
 	/* required last entry */
 	{0, }
 };
-- 
2.43.0


