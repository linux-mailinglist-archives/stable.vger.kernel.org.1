Return-Path: <stable+bounces-128313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B00CA7BDDD
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 15:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0257A7602
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC8E1F12E8;
	Fri,  4 Apr 2025 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRw0/5lr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA371EF0B4;
	Fri,  4 Apr 2025 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773486; cv=none; b=Png4Dxewpegi6fxm2P6E2recPWYMWmxNTLyKI5g2vY/gwdfBmpMrjQNzId9W2ENa8l3iORDMP/8C80Gsk3NV04dsZC3BRwDKC06EkZeQyW3Ah3UtV6v0dcMc2z/fRfkABzKWJZ080Ooj/8cEqeEw6gCrBPMlchOlm6gcZ51oWr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773486; c=relaxed/simple;
	bh=XXQZ09bPH3uX50yBfzvfiKn0d77qpTduFA7PDJNahUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hp9sgSwquHNN9K5NiC3NFl0i0LrvSEYfrQBwynu7shkh0shx0fRTxMp4Sr4Fw6MWqth5DFUvcWNszMT4J2cVYorWB1u4WrJMcoJfKP02oWOV7OKDEgWbtvEaB0HWStq8EIKek2YSK7gehGvGaeYYivi9/vuFnxMHQFXcO4hCYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRw0/5lr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743773484; x=1775309484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XXQZ09bPH3uX50yBfzvfiKn0d77qpTduFA7PDJNahUc=;
  b=fRw0/5lrimOORqZOJ2Ecu/hc1uFzbW5YNbgltdrhD/Ua48Ui48659s/D
   EwhBOhTjZs0gdVFqweczg1nxo3HKX2/cGl+gl3DlfJqfA1dFi3WeDMdJd
   kzqZqItcXKeVU4dzEe6Xcu3iNMpJ59lOPQXPp0sB3oT5XyZ2s0Wvituki
   MnirP/XU/wOUQM9j6xqReRvCmZIV5rMgqkO8UCQiNLL7tKgfq7q1o+RGr
   yvR/vHhoWlYrptLOmtxKq+BLciP6AaxCsWfZwTCEsRPUiZHCz6pblbqYv
   4QUsYb1/uaxomydCSAR1/0wJqJ4e079ZXafZ51+ZjmLXgXZ0EYCuJGRV+
   w==;
X-CSE-ConnectionGUID: woo/S7n+SkO1nELk/o0cSA==
X-CSE-MsgGUID: 2YLuP7FKRQuFQ3QhD2aflw==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="67685232"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="67685232"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 06:31:24 -0700
X-CSE-ConnectionGUID: rMnguxCbTMORS/p4egsM8Q==
X-CSE-MsgGUID: J681zUOZRambgbHyvuOVGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="164522584"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.248.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 06:31:20 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	stable@vger.kernel.org,
	simont@opensource.cirrus.com
Subject: [PATCH for v6.15] ASoC: Intel: sof_sdw: Add quirk for Asus Zenbook S16
Date: Fri,  4 Apr 2025 16:32:13 +0300
Message-ID: <20250404133213.4658-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Asus laptops with sound PCI subsystem ID 1043:1f43 have the DMICs
connected to the host instead of the CS42L43 so need the
SOC_SDW_CODEC_MIC quirk.

Link: https://github.com/thesofproject/sof/issues/9930
Fixes: 084344970808 ("ASoC: Intel: sof_sdw: Add quirk for Asus Zenbook S14")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Simon Trimmer <simont@opensource.cirrus.com>
Cc: stable@vger.kernel.org
---
Hi,

The S16 variant of the Zenbook has 4 PCH connected DMICs and the new
topology needed for it is released alongside with the -2ch variant for
the S14.

Add a Fixes tag so this is backported to 6.14 since we have at least one
user with this laptop without audio support.

Regards,
Peter

 sound/soc/intel/boards/sof_sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 90dafa810b2e..095d08b3fc82 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -764,6 +764,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 
 static const struct snd_pci_quirk sof_sdw_ssid_quirk_table[] = {
 	SND_PCI_QUIRK(0x1043, 0x1e13, "ASUS Zenbook S14", SOC_SDW_CODEC_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1f43, "ASUS Zenbook S16", SOC_SDW_CODEC_MIC),
 	{}
 };
 
-- 
2.49.0


