Return-Path: <stable+bounces-127206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA7BA769C5
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACCE47A6074
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE7323956D;
	Mon, 31 Mar 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShNOzT/Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADFF239561;
	Mon, 31 Mar 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432942; cv=none; b=DkVqOAMuATkTzwOMNYDYDmMEH+9Jg6XdNm1sktgcaoeEON684hwLnK1M+9vWWshi47YstOW6GjIYiSfV7HYZhWur8OqIS+pWyAmrHUoWKdVrUI/yZzCz+2XEXnjTvhzbVkoXS2sWUpCfseF04VV+J+cFRxl7zEqyAOV/ioJyftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432942; c=relaxed/simple;
	bh=gH9PfiN4hgwcDC2k/eQqaePDJvu4OFVRtlec79es2/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HlcI5vneJLnMBqRUujb3T5CRtbvCKmQDJ0aQuSY5p7ynSExxKt9K1WIrAumvpGAZOrA20SUa4UcTllxR0hwARLwxi5Cri9lhfHECL4bghg9VTalKiKdG14Jfh0D4zT49AmeEQmfE5yIzqyjht/a/1uQdgq5BunarD38Rr11jfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShNOzT/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CD0C4CEE9;
	Mon, 31 Mar 2025 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432942;
	bh=gH9PfiN4hgwcDC2k/eQqaePDJvu4OFVRtlec79es2/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShNOzT/YSRPJw5Ko09uh/t2QWI5svIy/wh84zkMptl4CRJ41o1Dbxi+NqcIW5A4RX
	 rs+fcRwHziM/x7XTGbh5ntSKRJy6b9qq68Dsc3T1F90Vv0X4Ke9oucyxXHLM7h71VT
	 Vq9XddSLt30mTL/C7fI1uI9blsc7RgRF0X+CJlXqDHCWUkayAQDg6Octu1ykpj6o0Q
	 YTcQn2MrsBAKtMKfx/HFclsFlg9YdxPE69AlQ0IngxeI/GnfjspDW4vLE+msEl2zHV
	 C+1DhdfzaeSzoTGu8c/JQPiabSmJRPLn1kWWYbIp8pn6ePjj9wQOqpyr+RWX97n20w
	 Vmspk1N4vqiGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxim Mikityanskiy <maxtram95@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	yung-chuan.liao@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	hkallweit1@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 14/23] ALSA: hda: intel: Fix Optimus when GPU has no sound
Date: Mon, 31 Mar 2025 10:55:00 -0400
Message-Id: <20250331145510.1705478-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145510.1705478-1-sashal@kernel.org>
References: <20250331145510.1705478-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxtram95@gmail.com>

[ Upstream commit 2b360ba9a4936486380bc30d1eabceb40a714d98 ]

quirk_nvidia_hda() forcefully enables HDA controller on all NVIDIA GPUs,
because some buggy BIOSes leave it disabled. However, some dual-GPU
laptops do not have a functional HDA controller in DGPU, and BIOS
disables it on purpose. After quirk_nvidia_hda() reenables this dummy
HDA controller, attempting to probe it fails at azx_first_init(), which
is too late to cancel the probe, as it happens in azx_probe_continue().

The sna_hda_intel driver calls azx_free() and stops the chip, however,
it stays probed, and from the runtime PM point of view, the device
remains active (it was set as active by the PCI subsystem on probe). It
prevents vga_switcheroo from turning off the DGPU, because
pci_create_device_link() syncs power management for video and audio
devices.

Affected devices should be added to driver_denylist to prevent them from
probing early. This patch helps identify such devices by printing a
warning, and also forces the device to the suspended state to allow
vga_switcheroo turn off DGPU.

Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Link: https://patch.msgid.link/20250208214602.39607-2-maxtram95@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cb9925948175f..b511563bbb6ba 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1360,8 +1360,21 @@ static void azx_free(struct azx *chip)
 	if (use_vga_switcheroo(hda)) {
 		if (chip->disabled && hda->probe_continued)
 			snd_hda_unlock_devices(&chip->bus);
-		if (hda->vga_switcheroo_registered)
+		if (hda->vga_switcheroo_registered) {
 			vga_switcheroo_unregister_client(chip->pci);
+
+			/* Some GPUs don't have sound, and azx_first_init fails,
+			 * leaving the device probed but non-functional. As long
+			 * as it's probed, the PCI subsystem keeps its runtime
+			 * PM status as active. Force it to suspended (as we
+			 * actually stop the chip) to allow GPU to suspend via
+			 * vga_switcheroo, and print a warning.
+			 */
+			dev_warn(&pci->dev, "GPU sound probed, but not operational: please add a quirk to driver_denylist\n");
+			pm_runtime_disable(&pci->dev);
+			pm_runtime_set_suspended(&pci->dev);
+			pm_runtime_enable(&pci->dev);
+		}
 	}
 
 	if (bus->chip_init) {
-- 
2.39.5


