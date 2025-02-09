Return-Path: <stable+bounces-114431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B11A2DD0D
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 12:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45811881F31
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93847185B62;
	Sun,  9 Feb 2025 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBaGWZ4C"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B714A85;
	Sun,  9 Feb 2025 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099858; cv=none; b=lzPnbV11piuFYmRvDYm3c11NcNMf3mD9uHiyJeP7HlQXlW2OOgGwYfygAR7cBcybOppJ07YDXM5MM/vQKMxovfl9ETBHhWosWxEj8xGUgRFNoevuSSYwEf6wsVsDIAbuVVrSt6KC/wXKEBd3rbwvMfnifVL3yJD86c1r3Z/faiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099858; c=relaxed/simple;
	bh=O2WKd3rTh2V+0WHq8QQS2/nSjwKsV6b5+kPTtAXbKyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3CINb1SFpYDqdtNzGY5vH/y1zf+zBuGXmIF3lwnksdvNO0GA3eG2f/7ikSK+7fJqkedGoQ6WqTmvFNO5cDfh6prrCBU16bk+zjxH88Nf/aL5CVJVOYbNVI2k2S2zni6kkwxU0bXSapAP8J7v0JzK1GMApooyd2H+CXS6qyfiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBaGWZ4C; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739099857; x=1770635857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O2WKd3rTh2V+0WHq8QQS2/nSjwKsV6b5+kPTtAXbKyc=;
  b=gBaGWZ4Ctsw2ccfWKCDUmt1RRNvI3DQJqJU4Mki2T09ltd8oSO3D+gje
   910kd/i07cRrAJ10llKuyLOC4z7ZplStKcMka/nxClxxqb8TYwRrUggXR
   AroHQYOxptRBSq1U91waITwNLixhQkhxcconUi1j1vm8rt546+8dr33ca
   r/a88xTpBkZbnUxgrb9igLO0ucv5j20tKOEU8XHE8VYsfvaINvf4AVotA
   PS66ZzoeuFmhVNSAiCljNdJ8ELkzqpRPKY7PT/jFjR/C8Sy/HSNy5150z
   TbOa75ajLhCJNDMtKPAfBIElYdnVtuXFbB5HzkDb8dhK6rhOcsnG3lJ2L
   A==;
X-CSE-ConnectionGUID: mU/zJsDXQX+qbYQ//d/bOQ==
X-CSE-MsgGUID: pcxkHw00Sl2CBhO2I73sMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="57109410"
X-IronPort-AV: E=Sophos;i="6.13,272,1732608000"; 
   d="scan'208";a="57109410"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 03:17:36 -0800
X-CSE-ConnectionGUID: szZfvvQIRM6yM8k5mmU0gA==
X-CSE-MsgGUID: AlSPyEq3QfWzD8hD9KVhYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116013779"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 03:17:33 -0800
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Oren Weil <oren.jer.weil@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tomas Winkler <tomasw@gmail.com>
Subject: [char-misc] mei: me: add panther lake P DID
Date: Sun,  9 Feb 2025 13:05:50 +0200
Message-ID: <20250209110550.1582982-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Panther Lake P device id.

Cc: <stable@vger.kernel.org>
Co-developed-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 2 ++
 drivers/misc/mei/pci-me.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index c3a6657dcd4a..a5f88ec97df7 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -117,6 +117,8 @@
 
 #define MEI_DEV_ID_LNL_M      0xA870  /* Lunar Lake Point M */
 
+#define MEI_DEV_ID_PTL_P      0xE470  /* Panther Lake P */
+
 /*
  * MEI HW Section
  */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 6589635f8ba3..d6ff9d82ae94 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -124,6 +124,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_LNL_M, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_P, MEI_ME_PCH15_CFG)},
+
 	/* required last entry */
 	{0, }
 };
-- 
2.43.0


