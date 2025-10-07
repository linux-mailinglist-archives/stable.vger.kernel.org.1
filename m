Return-Path: <stable+bounces-183528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE2BBC107C
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 12:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88B603480CD
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2512D47F6;
	Tue,  7 Oct 2025 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r121afuA"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094CA1FDE09;
	Tue,  7 Oct 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759833463; cv=none; b=W/VOO/OhjiNXSb8ZqiW9qfSlRtkMM6CEvy4yOXT/GpKtCrARHGQ46C4kwD8Fi9Ll1ruRSWfcsuJD/XkBCgCIza0BcIWuzloRbL1byFz4RApIA4Pa2hN6xjHrAF3Xa2V2CrWX81BLlt4fcZIPqkYFHqlW+ElukZrF5qCSIOvlKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759833463; c=relaxed/simple;
	bh=u3eolbqcm4MkoqUBG2SpCGS2vZqvsP4WebIFtx3BtnM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uA0UitHKpgQ2km8xUg4/P8GbonpnOaBzeKvhAclP5k5Dji2eMxi4j0/32xUIBVfFB4p+YPq70D0clk65TJTRJe/KyGe0dInaWi0zkORhV9IMSbJXeJibyzSdQbN/oKmY5KPcD6Cek2a5TMqBt8ulgv2F36NsQaFHJQaRX40PtAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r121afuA; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 597AbJhs3742447;
	Tue, 7 Oct 2025 05:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759833439;
	bh=4prdR7fIfal0vXWJwnCCGs7E2BiZ4igEPj5IHb6qEvc=;
	h=From:To:CC:Subject:Date;
	b=r121afuA0VJYaYkJhSVrTki9ZVCDitgnBKDu+jrni+zQGuygjA27nIMMUwOpfVfdY
	 YKxqUQzIm4dlBgaJ5rnIuuJ/8Q7yH2HxVO4cS+7tUxll4V01PhSKkmi6o22T3+jJcL
	 rLZb40FQaw66lkFYRY5qYAzZy5G+JDsvGuefI/1U=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 597AbIuA4008863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 7 Oct 2025 05:37:18 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 7
 Oct 2025 05:37:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 05:37:18 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.163.61])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 597AbEuX754182;
	Tue, 7 Oct 2025 05:37:14 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <stable@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <baojun.xu@ti.com>,
        <Baojun.Xu@fpt.com>, <13564923607@139.com>, <13916275206@139.com>,
        Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Enable init_profile_id for device initialization
Date: Tue, 7 Oct 2025 18:37:08 +0800
Message-ID: <20251007103708.1663-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Optimize the time consumption of profile switching, init_profile saves
the common settings of different profiles, such as the dsp coefficients,
etc, which can greatly reduce the profile switching time comsumption and
remove the repetitive settings.

Fixes: e83dcd139e77 ("ASoC: tas2781: Add keyword "init" in profile section")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 4dea442d8c30..a126f04c3ed7 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -474,6 +474,12 @@ static void tasdevice_dspfw_init(void *context)
 	if (tas_priv->fmw->nr_configurations > 0)
 		tas_priv->cur_conf = 0;
 
+	/* Init common setting for different audio profiles */
+	if (tas_priv->rcabin.init_profile_id >= 0)
+		tasdevice_select_cfg_blk(tas_priv,
+			tas_priv->rcabin.init_profile_id,
+			TASDEVICE_BIN_BLK_PRE_POWER_UP);
+
 	/* If calibrated data occurs error, dsp will still works with default
 	 * calibrated data inside algo.
 	 */
@@ -770,6 +776,12 @@ static int tas2781_system_resume(struct device *dev)
 	tasdevice_reset(tas_hda->priv);
 	tasdevice_prmg_load(tas_hda->priv, tas_hda->priv->cur_prog);
 
+	/* Init common setting for different audio profiles */
+	if (tas_hda->priv->rcabin.init_profile_id >= 0)
+		tasdevice_select_cfg_blk(tas_hda->priv,
+			tas_hda->priv->rcabin.init_profile_id,
+			TASDEVICE_BIN_BLK_PRE_POWER_UP);
+
 	if (tas_hda->priv->playback_started)
 		tasdevice_tuning_switch(tas_hda->priv, 0);
 
-- 
2.43.0


