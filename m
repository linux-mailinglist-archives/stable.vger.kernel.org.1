Return-Path: <stable+bounces-118831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D8A41CB6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79151897B68
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54255266F16;
	Mon, 24 Feb 2025 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6KtyKrG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57025D522;
	Mon, 24 Feb 2025 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395927; cv=none; b=WBjOgD0Jb5m+ZvHJYYdniOnkivrqf+SIeKr4p8KXvsjKYcPFbHZlQdSOvJvMtRp2P7yb0pjKVbPt3p8A0A/u+wlrnohwlCp+Od2P7CGMLC0BVQG7KbuIlNr8WNOnn9ujcRFGL2C/7FCRcMdrregEp32MsSHCbw2AZAKGA2VQ5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395927; c=relaxed/simple;
	bh=C1C9f/Wo4SGSOFdsxeg8gPzfICwdDWBilGAh9LINT8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uB3jct5Ij3lyYdbjTnPpGxsMCpCw3+CBgk2sYSF9Yao+8u2sPl+Nu+DPn+2LJuFV30SUSnswV0lmyneUxC1Uc7ji3JrcA8sGagh4Hkcl5JoQ+Hi939n0WebcMyt8Rq6jLpdDa6x7rx1x0VPsVPxJYjj66tZGC1VSyNaRc3NLi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6KtyKrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D58BC4CEE6;
	Mon, 24 Feb 2025 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395926;
	bh=C1C9f/Wo4SGSOFdsxeg8gPzfICwdDWBilGAh9LINT8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6KtyKrG7BUWNxz6/qMniqKbIBegpB9q/dNTMUw9Nt0qEof2vo3biyQac4y65vTKm
	 HpZK7qCnlSceUCQzdeteXMxwjYFNWiIDSRHDoCHteWnP025p6+5fd/wJajyBct2MqI
	 dmJeer7Y8uB1KGWB+gPQB7Havcio1aSJvxxJh0BZEzFvH3UIs7E4ccRbAZkyMPr5MV
	 zOF8LohuAEaWkJ8mJFUBcBDebdRbZMZjsbHm1sk+l56ilbS1AXxexRocBcm1KSHsSt
	 //wBf2DazR/119pdC06j+8Xwbe59bdGfknn5+XeMIvl4gppUkkDEZqsNGA1jZWm4jN
	 55XscQayYFX0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	peterz@infradead.org,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 15/28] ASoC: SOF: Intel: pci-ptl: Add support for PTL-H
Date: Mon, 24 Feb 2025 06:17:46 -0500
Message-Id: <20250224111759.2213772-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 4e9c87cfcd0584f2a2e2f352a43ff003d688f3a4 ]

PTL-H uses the same configuration as PTL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250210081730.22916-4-peter.ujfalusi@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/pci-ptl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/pci-ptl.c b/sound/soc/sof/intel/pci-ptl.c
index 69195b5e7b1a9..f54d098d616f6 100644
--- a/sound/soc/sof/intel/pci-ptl.c
+++ b/sound/soc/sof/intel/pci-ptl.c
@@ -50,6 +50,7 @@ static const struct sof_dev_desc ptl_desc = {
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL, &ptl_desc) }, /* PTL */
+	{ PCI_DEVICE_DATA(INTEL, HDA_PTL_H, &ptl_desc) }, /* PTL-H */
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
-- 
2.39.5


