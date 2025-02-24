Return-Path: <stable+bounces-118833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D3A41CB9
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57F61899FBA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B4C2673AA;
	Mon, 24 Feb 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1GtfhqF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282E25A2CF;
	Mon, 24 Feb 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395935; cv=none; b=MEGDgY9+LuK6D9cqYgJuIIzjqNaEl6qgaNFVIBsLyjBiSUIUVmhTbBpWvNtC6it05vyo/B2i8R12LxnW6S4wwy2qtHIvMhFkbxdVg0Z1eZ4CFT6mRgFd2nSXo4TqDoqDOOVY0Sw5grWUFl3DtQRmxVzdWAYSikQa/aa2BlJVN5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395935; c=relaxed/simple;
	bh=ALr6nZNi7z2pnivAkGwYQQ8q2vYP8Jd03qZXwmIzK94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ukXYZ7+8pRkEFbyFxy4dhUL3sbohunfbDV/g7CzMnaQxLPtqVrRYoPDvUGHq4APMAZX/cVlcjKYVZcZc7WO+SNvXANefDuG/kC2sUf67jjPZZBxrMyRsCo5yhNknahboiiG3q3HoTqUV10PmvgJlteNvjQH68enqOhSHMT7tJno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1GtfhqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93B9C4CEE6;
	Mon, 24 Feb 2025 11:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395934;
	bh=ALr6nZNi7z2pnivAkGwYQQ8q2vYP8Jd03qZXwmIzK94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1GtfhqFK9hOxeyVCAdbC0NB2yT7QR8p3xk6ipd8kA/kp0vJfn9oGlC5Mmpn5DPuz
	 ULGS+TYDmKr+RgxNsefN13xcdkdEoVGlSiEYDvNSUMTG2J3RCEvQ1wNVKMmC28FO0w
	 j8MmRbSs+X7ld9vYLIrs8gi5yINRqzXUEJlYpaP+iFwo0SmhRl6h58T4Mt6TRlphUn
	 sQxS7j6FGDrIhCmVHwQtpIQbIEKzP6VBYr0YP4Z3iNwggiW0mEKrGOVlpTgXVZT5cC
	 ufMWzMpEPyfsFTukBava3Vm2/WVBYtUyxzFP+aoZYV7U+LVl5SP1i+Bkfr0DpAC/eH
	 QJnI7M7EfljsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	Vijendar.Mukunda@amd.com,
	pierre-louis.bossart@linux.dev,
	venkataprasad.potturu@amd.com,
	peterz@infradead.org,
	krzk@kernel.org,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 17/28] ASoC: SOF: amd: Add post_fw_run_delay ACP quirk
Date: Mon, 24 Feb 2025 06:17:48 -0500
Message-Id: <20250224111759.2213772-17-sashal@kernel.org>
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

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 91b98d5a6e8067c5226207487681a48f0d651e46 ]

Stress testing resume from suspend on Valve Steam Deck OLED (Galileo)
revealed that the DSP firmware could enter an unrecoverable faulty
state, where the kernel ring buffer is flooded with IPC related error
messages:

[  +0.017002] snd_sof_amd_vangogh 0000:04:00.5: acp_sof_ipc_send_msg: Failed to acquire HW lock
[  +0.000054] snd_sof_amd_vangogh 0000:04:00.5: ipc3_tx_msg_unlocked: ipc message send for 0x30100000 failed: -22
[  +0.000005] snd_sof_amd_vangogh 0000:04:00.5: Failed to setup widget PIPELINE.6.ACPHS1.IN
[  +0.000004] snd_sof_amd_vangogh 0000:04:00.5: Failed to restore pipeline after resume -22
[  +0.000003] snd_sof_amd_vangogh 0000:04:00.5: PM: dpm_run_callback(): pci_pm_resume returns -22
[  +0.000009] snd_sof_amd_vangogh 0000:04:00.5: PM: failed to resume async: error -22
[...]
[  +0.002582] PM: suspend exit
[  +0.065085] snd_sof_amd_vangogh 0000:04:00.5: ipc tx error for 0x30130000 (msg/reply size: 12/0): -22
[  +0.000499] snd_sof_amd_vangogh 0000:04:00.5: error: failed widget list set up for pcm 1 dir 0
[  +0.000011] snd_sof_amd_vangogh 0000:04:00.5: error: set pcm hw_params after resume
[  +0.000006] snd_sof_amd_vangogh 0000:04:00.5: ASoC: error at snd_soc_pcm_component_prepare on 0000:04:00.5: -22
[...]

A system reboot would be necessary to restore the speakers
functionality.

However, by delaying a bit any host to DSP transmission right after
the firmware boot completed, the issue could not be reproduced anymore
and sound continued to work flawlessly even after performing thousands
of suspend/resume cycles.

Introduce the post_fw_run_delay ACP quirk to allow providing the
aforementioned delay via the snd_sof_dsp_ops->post_fw_run() callback for
the affected devices.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://patch.msgid.link/20250207-sof-vangogh-fixes-v1-1-67824c1e4c9a@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp.c     |  1 +
 sound/soc/sof/amd/acp.h     |  1 +
 sound/soc/sof/amd/vangogh.c | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 95d4762c9d939..35eb23d2a056d 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -27,6 +27,7 @@ MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
 static struct acp_quirk_entry quirk_valve_galileo = {
 	.signed_fw_image = true,
 	.skip_iram_dram_size_mod = true,
+	.post_fw_run_delay = true,
 };
 
 const struct dmi_system_id acp_sof_quirk_table[] = {
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 800594440f739..2a19d82d62002 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -220,6 +220,7 @@ struct sof_amd_acp_desc {
 struct acp_quirk_entry {
 	bool signed_fw_image;
 	bool skip_iram_dram_size_mod;
+	bool post_fw_run_delay;
 };
 
 /* Common device data struct for ACP devices */
diff --git a/sound/soc/sof/amd/vangogh.c b/sound/soc/sof/amd/vangogh.c
index 61372958c09dc..436f58be3a9f9 100644
--- a/sound/soc/sof/amd/vangogh.c
+++ b/sound/soc/sof/amd/vangogh.c
@@ -11,6 +11,7 @@
  * Hardware interface for Audio DSP on Vangogh platform
  */
 
+#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
 
@@ -136,6 +137,20 @@ static struct snd_soc_dai_driver vangogh_sof_dai[] = {
 	},
 };
 
+static int sof_vangogh_post_fw_run_delay(struct snd_sof_dev *sdev)
+{
+	/*
+	 * Resuming from suspend in some cases my cause the DSP firmware
+	 * to enter an unrecoverable faulty state.  Delaying a bit any host
+	 * to DSP transmission right after firmware boot completion seems
+	 * to resolve the issue.
+	 */
+	if (!sdev->first_boot)
+		usleep_range(100, 150);
+
+	return 0;
+}
+
 /* Vangogh ops */
 struct snd_sof_dsp_ops sof_vangogh_ops;
 EXPORT_SYMBOL_NS(sof_vangogh_ops, SND_SOC_SOF_AMD_COMMON);
@@ -157,6 +172,9 @@ int sof_vangogh_ops_init(struct snd_sof_dev *sdev)
 
 		if (quirks->signed_fw_image)
 			sof_vangogh_ops.load_firmware = acp_sof_load_signed_firmware;
+
+		if (quirks->post_fw_run_delay)
+			sof_vangogh_ops.post_fw_run = sof_vangogh_post_fw_run_delay;
 	}
 
 	return 0;
-- 
2.39.5


