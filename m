Return-Path: <stable+bounces-118832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38786A41CC8
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194BC1799EB
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9542A267392;
	Mon, 24 Feb 2025 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCS7t20O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79225D522;
	Mon, 24 Feb 2025 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395930; cv=none; b=E/cWGUBKhyIqieDvsrXTEhRWuuNPImA6cWvj6pYRMjutb8cXacEMNBLCVjAxrzUtT0w0YTtukdqYMQCKlOI5MFNME7woqPTpy5pZ/+xiFjbFCvIWJ1tn3NY2AzuUWUDQfcXY62gPIQ+4HsWIjWTIILRuJTqLUfvhJmg8vgQOzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395930; c=relaxed/simple;
	bh=Y4rZNFYSylkmGfHLUVXlMlbGM1GfzpFoqc4b3EN5IAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YFTZl8NmXaVn3tdoP8+Gbu0Hq8BsYo6Ar9rQA0W31Eg/DBG/ZfZpU/V+6qCxoBBlrlhK+svIEU0RfumAfWPXAY4z36ggVhfcUdqzhC5Osl/ByEqCn9DyHMcvbi1J5NYLodMrHaxvtneKCdWpXGk0GSYHnWRv6edzhSInG8NyoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCS7t20O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D4BC4CEEC;
	Mon, 24 Feb 2025 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395929;
	bh=Y4rZNFYSylkmGfHLUVXlMlbGM1GfzpFoqc4b3EN5IAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CCS7t20Olw9j1nqX94Brdpvi8z0l5XrfHUUeFKY+ctNOriGjYyxlryT4w5VgVL30h
	 ZQWlFR3WzXOESn64IPmX0xwNh8IjlVz5Z34Jfby+mPmKEdecv5JXeH7K8Ggf3prMmA
	 6Np+Sy4GmTes3DD4YETFFg32CCXf+TPlKuZsuvFOvKzbiIoOdUBVJmZMYS1OIG/ByQ
	 8nAPiCfWQI7HLoJbaUR/G+E+y+zH6ysIQJl856REKjyHU3rKZwwhsnprF6NuolIlXs
	 KC73kXJbfXjuddKcFgL9pZGkwmTlRkzo/tf6UQO11EyIE3+bb3bNh3p7pzneEYSzxI
	 Df+YQT+Z4i2ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	hkallweit1@gmail.com,
	chaitanya.kumar.borah@intel.com,
	wangyuli@uniontech.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 16/28] ALSA: hda: hda-intel: add Panther Lake-H support
Date: Mon, 24 Feb 2025 06:17:47 -0500
Message-Id: <20250224111759.2213772-16-sashal@kernel.org>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit d7e2447a4d51de5c3c03e3b7892898e98ddd9769 ]

Add Intel PTL-H audio Device ID.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250210081730.22916-5-peter.ujfalusi@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b4540c5cd2a6f..76cd9076fed7d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2506,6 +2506,8 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_ARL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
 	/* Panther Lake */
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
+	/* Panther Lake-H */
+	{ PCI_DEVICE_DATA(INTEL, HDA_PTL_H, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
 	/* Gemini-Lake */
-- 
2.39.5


