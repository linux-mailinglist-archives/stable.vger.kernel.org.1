Return-Path: <stable+bounces-110739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D28A1CC19
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45EE3A4EEF
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271A61F76A5;
	Sun, 26 Jan 2025 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4v3ozZg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18491F75A6;
	Sun, 26 Jan 2025 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904057; cv=none; b=FCm6crqP5a5Guq8y/WhyADNkC56brcecOMpv2J6i/rvzQibDZfJWCAhyZAcVsyMTh1vJCmeVN8ykpaaUPgu/pR/n7x39Eg7DFtpiHD+vF9fvrUrFoPh4EyBUwmAkJmaep6hnZ/SO+RneJH1B/F0eMIgIz7WlIrWib7tb21Mxf0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904057; c=relaxed/simple;
	bh=amy6pjva8cbdJyJwcWzfTqebEX2hrXbCKcp/njPpcJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R7EJ86zUPZmPYuRW5mGC1L0zwpT12ZfBR8aDx/6Kaf/sfgDIpbsMfYwWBf+6GlfWiwzcI/HzARbzLhcvgCPuncaWCe2LjBReRYjFNSw/ikiblBl7CWLJRzzfr2+lBtPb22QfT27NkC2Byqr8Tm4FjTJMIkWdgMIYHupEtFkntqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4v3ozZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7927C4CED3;
	Sun, 26 Jan 2025 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904057;
	bh=amy6pjva8cbdJyJwcWzfTqebEX2hrXbCKcp/njPpcJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4v3ozZg08V+Y6CjdpMxFUOkWdz7vbGuigYORCy8IQLC2AYJimhHwPVSLpzw7HMzF
	 jgwnyYqlWgsv2qfoTUZggrR5HeYIRC9NXHY2cA/ALbo1XnbsCap7aYu6+GdOh+wHAE
	 FDI5Q1DN/OJreAlb9fz4pC+iDOcyVcN95gjT1qp80D+Z6rcG0UJtVL/2DAupFrjBBQ
	 /VWiFNiGQ+zpppy401XGCEAjARr3ymlpp2G+megEHCwiVNfZPctVyj26lzhcc1uMcn
	 jBXUf96/09Wga9zoramBkiZXu7xjQs3SITy4tYO12G+3nwMiku+MkMI9MYo9mZxtCK
	 fhE++Q0OIzgNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	ckeepax@opensource.cirrus.com,
	Vijendar.Mukunda@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 04/16] ASoC: Intel: sof_sdw: Correct quirk for Lenovo Yoga Slim 7
Date: Sun, 26 Jan 2025 10:07:06 -0500
Message-Id: <20250126150720.961959-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150720.961959-1-sashal@kernel.org>
References: <20250126150720.961959-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit 7662f0e5d55728a009229112ec820e963ed0e21c ]

In addition to changing the DMI match to examine the product name rather
than the SKU, this adds the quirk to inform the machine driver to not
bind in the cs42l43 microphone DAI link.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20241206075903.195730-5-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index c9f9c9b0de9b6..d2bbbda60f78a 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -624,9 +624,10 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "380E")
+			DMI_MATCH(DMI_PRODUCT_NAME, "83HM")
 		},
-		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS),
+		.driver_data = (void *)(SOC_SDW_SIDECAR_AMPS |
+					SOC_SDW_CODEC_MIC),
 	},
 	{
 		.callback = sof_sdw_quirk_cb,
-- 
2.39.5


