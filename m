Return-Path: <stable+bounces-120121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4CCA4C7BD
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0BD3ACE28
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659B24A04F;
	Mon,  3 Mar 2025 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYHMsfGA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B21248887;
	Mon,  3 Mar 2025 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019446; cv=none; b=PSR4WQWYzLJ00adnA6UuGznzBQ23usHKHLQDeX+UH/pAZEIV3oticxnshNoi7GU+vSRQFNMXL4ljWOt9rfz5K4EA+SD1RkSdJRAf7IEDOotUoaQmhqKH8nIdh8I3xkqPpg3FhJBm1WeCA3HyQPQAbUJgyENSfrGU63MZeijujbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019446; c=relaxed/simple;
	bh=DXHhBZFGrI8qS3v2N4sk8Q5iUu0EKKm29mVvD5NINA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjzEVwuEiK3tHxDoVAIjZOHeTzFAVkDWRxjjGrXCbAc5QkkPh3VGCMU1RgwQT4ThS/BfkVa22noOG9SsGMzcY2DlrC+Jb+S0OFHvRtMsIbQmkzt8LlVLKIpAjx7M8g4LflOKw0xK2EkBsuLK8khGaouc6dW9VSPYEFKS70DWqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYHMsfGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1A7C4CEE9;
	Mon,  3 Mar 2025 16:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019446;
	bh=DXHhBZFGrI8qS3v2N4sk8Q5iUu0EKKm29mVvD5NINA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYHMsfGAOhbc+4aAZZbApBw7nP+oVQps+TXxIR/1nUHTjQ/CwlUDJIaFbRx3pLKnf
	 vfzsn6KY2UwLXdrqJPAGceQXp+H3D6dVBxErcTjs7qMWoHO/vh5sK73GNDoKKnqzzk
	 3jlGDePGLJW0aZThDhxiDapcTEUJoUHme+4WYrNoceADvFAo9h91aLxgXJOZIANNsR
	 aRNAJhk7tPiBlwNoqIjbtYAwy12eKswy3DLE5a3MQ0QyzWIyYXzKW36p/rjSyYL+w5
	 OoH72+XKCGq9ZPxQPKIdp6GMvMhhDotG//PM+j1gNVUPh4ZRm4utbCHlQtr/mVfq1S
	 n8at5qShkj1KQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	brent.lu@intel.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 07/17] ASoC: SOF: Intel: don't check number of sdw links when set dmic_fixup
Date: Mon,  3 Mar 2025 11:30:19 -0500
Message-Id: <20250303163031.3763651-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163031.3763651-1-sashal@kernel.org>
References: <20250303163031.3763651-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.17
Content-Transfer-Encoding: 8bit

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 56a677293509b2a0d39ac8d02b583c1ab1fe4d94 ]

Currently, we assume that the PCH DMIC pins are pin-muxed with SoundWire
links. However, we do see a HW design that use PCH DMIC along with 3
SoundWire links. Remove the check now.
With this change the PCM DMIC will be presented if it is reported by the
BIOS irrespective of whether there are SDW links present or not.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20250225093716.67240-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index f10ed4d102501..c924a998d6f90 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1305,22 +1305,8 @@ struct snd_soc_acpi_mach *hda_machine_select(struct snd_sof_dev *sdev)
 		/* report to machine driver if any DMICs are found */
 		mach->mach_params.dmic_num = check_dmic_num(sdev);
 
-		if (sdw_mach_found) {
-			/*
-			 * DMICs use up to 4 pins and are typically pin-muxed with SoundWire
-			 * link 2 and 3, or link 1 and 2, thus we only try to enable dmics
-			 * if all conditions are true:
-			 * a) 2 or fewer links are used by SoundWire
-			 * b) the NHLT table reports the presence of microphones
-			 */
-			if (hweight_long(mach->link_mask) <= 2)
-				dmic_fixup = true;
-			else
-				mach->mach_params.dmic_num = 0;
-		} else {
-			if (mach->tplg_quirk_mask & SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER)
-				dmic_fixup = true;
-		}
+		if (sdw_mach_found || mach->tplg_quirk_mask & SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER)
+			dmic_fixup = true;
 
 		if (tplg_fixup &&
 		    dmic_fixup &&
-- 
2.39.5


