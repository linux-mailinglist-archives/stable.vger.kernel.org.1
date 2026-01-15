Return-Path: <stable+bounces-208749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C652D261BA
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4567E3018EA4
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263743BF2F6;
	Thu, 15 Jan 2026 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oNP6Oz2m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8833BF2E0;
	Thu, 15 Jan 2026 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496736; cv=none; b=lix5LNy69BHSSKOCq90yJ0W6t6Vc22pMd83FyvPYJM/cpSeij0rv1T2uBpp4UMsvZRK5xo9o/9Fg7kPB3trBxVBu0RD2vc5QTRRiFaBwsoZFAU9k4cwG+zAE9l3G2Be24lyhAlVIsrZ/KnEDexA+E59grah8ECjjVdbsdWYeFAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496736; c=relaxed/simple;
	bh=SskQZYTvZE1oJ0TrUx0wUwOyRNhQTBn7Q6EJSy7kD+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRpXtBa3S8LcUMNEtrIUhlxNArvF1f7zQO25GE/cpZGHla5DWVmSHfbsAO1NoVcutEDS8z47HiwTCBtzugyG5mW6uS73qHAQf0xZemQER9LsmGKnDdyuxdvGqmQkdwXUoDO0jr3PYLuJhO09EfGBBjtx1neVuj5Tfq3SHgYGTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oNP6Oz2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568E0C116D0;
	Thu, 15 Jan 2026 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768496736;
	bh=SskQZYTvZE1oJ0TrUx0wUwOyRNhQTBn7Q6EJSy7kD+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNP6Oz2mGVkia3G1nkWQnf7v0xExdlXMh6t61DGKsGRinY6CTjdrpcl9JGIrfstWt
	 BxhI3q8TgrMqPSPvmnc+4RA2TDPC4WrHH6PKFrVjMWSzwwSthztT4d/3O/+aHGb/+f
	 +iGfM3qKSgOruPAM/RDzq9uMBY6hj4MC/l2oWiu0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Askar Safin <safinaskar@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 118/119] ALSA: hda: intel-dsp-config: Prefer legacy driver as fallback
Date: Thu, 15 Jan 2026 17:48:53 +0100
Message-ID: <20260115164156.220905007@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164151.948839306@linuxfoundation.org>
References: <20260115164151.948839306@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 161a0c617ab172bbcda7ce61803addeb2124dbff upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/hda/intel-dsp-config.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -676,7 +676,8 @@ int snd_intel_dsp_driver_probe(struct pc
 	/* find the configuration for the specific device */
 	cfg = snd_intel_dsp_find_config(pci, config_table, ARRAY_SIZE(config_table));
 	if (!cfg)
-		return SND_INTEL_DSP_DRIVER_ANY;
+		return IS_ENABLED(CONFIG_SND_HDA_INTEL) ?
+			SND_INTEL_DSP_DRIVER_LEGACY : SND_INTEL_DSP_DRIVER_ANY;
 
 	if (cfg->flags & FLAG_SOF) {
 		if (cfg->flags & FLAG_SOF_ONLY_IF_SOUNDWIRE &&



