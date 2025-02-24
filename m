Return-Path: <stable+bounces-118802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EA8A41C70
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45251898ABB
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896AD261383;
	Mon, 24 Feb 2025 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXYre0MY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155626137E;
	Mon, 24 Feb 2025 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395852; cv=none; b=qaLenxmqbY1chvkwH6zmi0NFEaI44gz8eAOc+9XacsN5/aqnOoVUkTGKnU1rP0mjKfgtUy+dqL3tFyH1gQIOvdZ7jxddwSV7yDikTCZmUkfHHJfp5aMwfL7aA77H7qYUREDWj+ytLZDG6cuRmuuomQ0s9RI5xwfe87G+KfAA7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395852; c=relaxed/simple;
	bh=X+QF8ddZMu/AyFdBmvSx3TibLBwtPGrLl1vQ4P/CnT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7Std4BB51PBYeGdOPLgTG4BaXJ5i/5QiRNC0M4t43hpWfb5C3bya+xwsG4XorCNzxGF0tHLyHwm82+TWz/ZB5Oy2SHyI5IROJknCuC9DtWvzq+mS5qSNIRf/cDHWXewM9vkl79vPZd4lQtnbTXJ8ybqbciMYElE70ADVSOukSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXYre0MY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ABAC4CED6;
	Mon, 24 Feb 2025 11:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395851;
	bh=X+QF8ddZMu/AyFdBmvSx3TibLBwtPGrLl1vQ4P/CnT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SXYre0MYMAtDMFHYrN7ksCjbUYCmv1coHWeJxHKPCZKEI0Z63/tQpmXlQUpqO4awH
	 SfvR4mxXwid2nav+ci4luBSe/G/EL9cQ9cTpSKoPWUYwskvwo9nOko9ZmrXb3BM1Hl
	 3P4TNhB+7tdwkbMfA+CQKUEeYX2m6Ewxviab2tCyFW6gWdeangHGv8USrp7HMNeHfJ
	 G6pYiPfOMgE6rS9++833XgOdPSwOaNRz2percHHHLPdeV2x0Kmo4CwXA5AXyOtm9xZ
	 jkkLGIPOViMHlnXTNdfmxHeEBGRMvOgUqBM01DTUs0t1yL6y8AZNPa2T3L6UQ2jOtr
	 CP77tJOoQmE+g==
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
	zhaoqunqin@loongson.cn,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 18/32] ALSA: hda: hda-intel: add Panther Lake-H support
Date: Mon, 24 Feb 2025 06:16:24 -0500
Message-Id: <20250224111638.2212832-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
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
index 4a62440adfafd..79417e68cc2b6 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2496,6 +2496,8 @@ static const struct pci_device_id azx_ids[] = {
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


