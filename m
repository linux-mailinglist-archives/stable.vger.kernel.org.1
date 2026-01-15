Return-Path: <stable+bounces-208444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD2D24FA4
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 15:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63B7030057CF
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B523A35B4;
	Thu, 15 Jan 2026 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/Hw4O/K"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F973271F2
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487699; cv=none; b=BobdfYe3av2HJj/4UQy6kMODJ3eOzfBkPuJN9tTjhU4sZVfyCh6SlXSw4Xxt0FFd82zseRXhFRScDIth/8J9iwrRMjFZ7MRuxkL8gPGCm3XGUna6y9t3BtJpFaqaTc4bNgOBxUPa7FByr7JPJX6JaglKTaI3CYsZEUAuA/lpA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487699; c=relaxed/simple;
	bh=pCpr72s0piDZZaQtfAtugNkjepV1eY9OrHp1zWNx8VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxy3QDdfFoqnrEmsduGIOEE2P6J49hlnDr4xrZWeDC3kqKydd3E6JGLF/DDz3kFMzs4O+MR40OsHgpmh2Dbew/gBaxYTCJk7ne3jAOLLRg99m8fDRy2BlrHrnUwYmywOyKVYcMCgwZqL6gk9Q7Sowl8dwGMIXO6fWoNl+HQlO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/Hw4O/K; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so775937f8f.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 06:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768487695; x=1769092495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39uSH1zSkowDoJAVIUrasi1FVBStSL6sFcC0lrMPa1Y=;
        b=e/Hw4O/Kjv6BkZz35cAalXi+gkyp+9gJbjyn7YBLT+UOtdlW+gmZburYsF4oqd9rtn
         2bsz/TEh7FGhmeLFNYpEXA4o20T3DbudSesbHplbelpRh3x8cXATPatcEbzYrVVSG35y
         So8eEjZpQj1bFxVVFpP3L1xD6Wbxg5aOjdd2Gk4V2CPDerLw5sC4+WqlGzsjlnO21Brn
         SZzvWPkHaoZ+N01bfH7Pf6YBs1nf2fplMFtkkR9cd2LP7HfRPrxi3QkybMUby4kg1F4m
         B427Sefuwl0NtrWGhm17ATNFIFX7IlhEymLNtRYNeqUb4Yjg2fpSeguH001Z+xcfmkcN
         0/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487695; x=1769092495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=39uSH1zSkowDoJAVIUrasi1FVBStSL6sFcC0lrMPa1Y=;
        b=wATetgwkH9s34XfvyUK6DB6QcdMkZ4eQBREP5tpBspEx2atjHR7EX1EIKIBxK7Aj45
         ypzYpRzLdb54ps5d1K7jej8E+lcS+XESRockjhNxeOlEoaOtbwXfD/aUkJXsupjG24Lk
         CbYggJqLfEEYLvvFedsjLHkZ1pFxpvX9B/mR3RAzn06OT2ueNTMEzdBxY0OFVkWIWKFm
         A5LIaQ+1cqaOcQiMq86bfoukXSL2nmTSFoPhOJRZFRoVa+KFALOOCOShdmCosszSLxq/
         eK4kPjPSw2vGrCtyH7dZFQNxuWNii9Ui4YdzdbaXVamDLoD3TvyIDHyVQygEJXPZoYiX
         T2Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWpOmomE4ueK7cnwsDvVE+weCtWPc+7yL77HcEyvCR44l3jgBVak83VrLs3xecbGWLnfweWMJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/eJ/1yF/YxT+FzUSqhy9Fspye2398GItBdZRP7xlj68kQzxr
	iLs1YgZoCy87pX4wRgN+PXn3BH+FOkj4/QlgGZjzJ1tS4MKNMv4vdbN8sKE+EnBI
X-Gm-Gg: AY/fxX5mkPKIT3QlJVHY0mXmxa684ydeZJSC1AJqiKCP5VZ02AsAe1ktxGvgvpuLcLP
	1bgcf2T1Q5WPqRpzAXRipEKoTzWgX6yslQl9KX/g9EFxC9WjprQ/W3IUTA/tVmT+D/oLebcUQpa
	U8PE1ZQ92YdnwlAS/TWInZx1gFEgof82c5C26xqSzWLDAgjFxk1a2BXk3PyDItPwOY6EZa0lDMq
	S3Oof+DsBTZUsEuBSjTWiz/F8RgahlRt+CKa6xInhaaQfjb51M/Rn7DHSYkaPm6CkiMwaaFqFSz
	u4LIMnXFTRYPeimNKXWJIOfdpLQB272r0pD3JG/KDO+CUWTW2s8q+CDTwBKYPaa1f3eRzKCkiaj
	OSbjlKl2GaziyVm0k5avRu/Wqh5UxEvvGM4lK1le78fpV0O3+NqRE4Gm9ulTmQd6yKmpf569fdX
	1iigbR06zGlV3ij04xWQ==
X-Received: by 2002:a5d:64c5:0:b0:431:808:2d3d with SMTP id ffacd0b85a97d-4342c54873dmr8198009f8f.32.1768487694847;
        Thu, 15 Jan 2026 06:34:54 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-434af64a666sm6209442f8f.6.2026.01.15.06.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 06:34:54 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: bradynorander@gmail.com,
	cezary.rojewski@intel.com,
	kai.vehmanen@linux.intel.com,
	patches@lists.linux.dev,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	rf@opensource.cirrus.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	tiwai@suse.de
Subject: [PATCH 6.12.y] ALSA: hda: intel-dsp-config: Prefer legacy driver as fallback
Date: Thu, 15 Jan 2026 17:34:51 +0300
Message-ID: <20260115143451.628160-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026011237-stage-cognitive-53c0@gregkh>
References: <2026011237-stage-cognitive-53c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 161a0c617ab172bbcda7ce61803addeb2124dbff ]

When config table entries don't match with the device to be probed,
currently we fall back to SND_INTEL_DSP_DRIVER_ANY, which means to
allow any drivers to bind with it.

This was set so with the assumption (or hope) that all controller
drivers should cover the devices generally, but in practice, this
caused a problem as reported recently.  Namely, when a specific
kconfig for SOF isn't set for the modern Intel chips like Alderlake,
a wrong driver (AVS) got probed and failed.  This is because we have
entries like:

 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ALDERLAKE)
 /* Alder Lake / Raptor Lake */
        {
                .flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
                .device = PCI_DEVICE_ID_INTEL_HDA_ADL_S,
        },
 ....
 #endif

so this entry is effective only when CONFIG_SND_SOC_SOF_ALDERLAKE is
set.  If not set, there is no matching entry, hence it returns
SND_INTEL_DSP_DRIVER_ANY as fallback.  OTOH, if the kconfig is set, it
explicitly falls back to SND_INTEL_DSP_DRIVER_LEGACY when no DMIC or
SoundWire is found -- that was the working scenario.  That being said,
the current setup may be broken for modern Intel chips that are
supposed to work with either SOF or legacy driver when the
corresponding kconfig were missing.

For addressing the problem above, this patch changes the fallback
driver to the legacy driver, i.e. return SND_INTEL_DSP_DRIVER_LEGACY
type as much as possible.  When CONFIG_SND_HDA_INTEL is also disabled,
the fallback is set to SND_INTEL_DSP_DRIVER_ANY type, just to be sure.

Reported-by: Askar Safin <safinaskar@gmail.com>
Closes: https://lore.kernel.org/all/20251014034156.4480-1-safinaskar@gmail.com/
Tested-by: Askar Safin <safinaskar@gmail.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20251210131553.184404-1-tiwai@suse.de
Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 sound/hda/intel-dsp-config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 34825b2f3b10..3246705ddb19 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -676,7 +676,8 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
 	/* find the configuration for the specific device */
 	cfg = snd_intel_dsp_find_config(pci, config_table, ARRAY_SIZE(config_table));
 	if (!cfg)
-		return SND_INTEL_DSP_DRIVER_ANY;
+		return IS_ENABLED(CONFIG_SND_HDA_INTEL) ?
+			SND_INTEL_DSP_DRIVER_LEGACY : SND_INTEL_DSP_DRIVER_ANY;
 
 	if (cfg->flags & FLAG_SOF) {
 		if (cfg->flags & FLAG_SOF_ONLY_IF_SOUNDWIRE &&

base-commit: 39cb076c7dc7e44e3cab5c82ffda16a550ed8436
-- 
2.47.3


