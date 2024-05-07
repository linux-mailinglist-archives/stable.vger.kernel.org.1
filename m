Return-Path: <stable+bounces-43312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BC78BF1A1
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCC8281BA1
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3DA1442FD;
	Tue,  7 May 2024 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDGSunz5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3E61442EA;
	Tue,  7 May 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123344; cv=none; b=T8KhOeokMEO3VoseBVgGd3qyD0ar+H+r/raGds/8lDsJDzd7QojVX4loOcMZSiK3SGkqYvMRX/8K1836r88vpiy/DXtn+PNTCijSSM/aHSZdqE0xG3me2LhEVvd7TxibjsWoQX1G9HCvjfyCnG7a3b+1O2lvh2mSsvxz6n59dME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123344; c=relaxed/simple;
	bh=n62GchpgHmjR40eE42PIoLqi1koZrXaqgEhx3LCtJdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnRzHeHEHODhA7AulipPBXKsOVuyzJgCTp7GIrZUMZvdRdh+XahUrQfLYsBuDW0LdlocgOyAc3wqX0rsL4gLXLQfkC2iE2aIMgO5utx3qPGgd59WpWfMwFg/hU0jXw8gjjORgoAqTKsTcTY4WcZKW47a+NjuVcKn7mBaNLkvAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDGSunz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1418CC4AF68;
	Tue,  7 May 2024 23:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123344;
	bh=n62GchpgHmjR40eE42PIoLqi1koZrXaqgEhx3LCtJdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDGSunz5CJ/ULz9l/TG14bd4PJ8vMdxO84/5NtOMXApKwfNfX1ocGdYMcEf4OQR1H
	 k1JE0R2by4v8dg0T7gjSunLlSlftQrtyZmv5SQYMBDIoArNEnaYBG4F5s8tKCUSsXA
	 f+l3KrS07w4aGzi7KzzSoPjt0MW5/xobPRSa9G5k6OuuM1KPEGzboTjcK7ye0Rmeeo
	 eQw/DzljwcnvF0ymCXZWeAqwzGfPPOwUKOG8qITMgLD0fqXipPvCfYaxDSWsZPQa/N
	 PNZyNpyDNxW+jfcbrWSWjaEeSwSHcBpuY7guyIMh1fIHXTsEtfEOKQd49Yom+DUp+E
	 JiOTnMAiW0gAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	amadeuszx.slawinski@linux.intel.com,
	markhas@chromium.org,
	bradynorander@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 33/52] ALSA: hda: intel-dsp-config: harden I2C/I2S codec detection
Date: Tue,  7 May 2024 19:06:59 -0400
Message-ID: <20240507230800.392128-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 79ac4c1443eaec0d09355307043a9149287f23c1 ]

The SOF driver is selected whenever specific I2C/I2S HIDs are reported
as 'present' in the ACPI DSDT. In some cases, an HID is reported but
the hardware does not actually rely on I2C/I2S.  This false positive
leads to an invalid selection of the SOF driver and as a result an
invalid topology is loaded.

This patch hardens the detection with a check that the NHLT table is
consistent with the report of an I2S-based codec in DSDT. This table
should expose at least one SSP endpoint configured for an I2S-codec
connection.

Tested on Huawei Matebook D14 (NBLB-WAX9N) using an HDaudio codec with
an invalid ES8336 ACPI HID reported:

[    7.858249] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
[    7.858312] snd_hda_intel 0000:00:1f.3: snd_intel_dsp_find_config: no valid SSP found for HID ESSX8336, skipped

Reported-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Tested-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Closes: https://github.com/thesofproject/linux/issues/4934
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Message-ID: <20240426152818.38443-1-pierre-louis.bossart@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 6a384b922e4fa..d1f6cdcf1866e 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -557,9 +557,32 @@ static const struct config_entry *snd_intel_dsp_find_config
 		if (table->codec_hid) {
 			int i;
 
-			for (i = 0; i < table->codec_hid->num_codecs; i++)
-				if (acpi_dev_present(table->codec_hid->codecs[i], NULL, -1))
+			for (i = 0; i < table->codec_hid->num_codecs; i++) {
+				struct nhlt_acpi_table *nhlt;
+				bool ssp_found = false;
+
+				if (!acpi_dev_present(table->codec_hid->codecs[i], NULL, -1))
+					continue;
+
+				nhlt = intel_nhlt_init(&pci->dev);
+				if (!nhlt) {
+					dev_warn(&pci->dev, "%s: NHLT table not found, skipped HID %s\n",
+						 __func__, table->codec_hid->codecs[i]);
+					continue;
+				}
+
+				if (intel_nhlt_has_endpoint_type(nhlt, NHLT_LINK_SSP) &&
+				    intel_nhlt_ssp_endpoint_mask(nhlt, NHLT_DEVICE_I2S))
+					ssp_found = true;
+
+				intel_nhlt_free(nhlt);
+
+				if (ssp_found)
 					break;
+
+				dev_warn(&pci->dev, "%s: no valid SSP found for HID %s, skipped\n",
+					 __func__, table->codec_hid->codecs[i]);
+			}
 			if (i == table->codec_hid->num_codecs)
 				continue;
 		}
-- 
2.43.0


