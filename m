Return-Path: <stable+bounces-127227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB3CA76A5B
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296183AEA35
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3875E221D8D;
	Mon, 31 Mar 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOtL2uG0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E783B242912;
	Mon, 31 Mar 2025 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432988; cv=none; b=Q2Ax9nvdED6feDRXb072HH4xz/fk9NLgDiH+Li5YksCwevkZazMnhj2J9ov+7Ja5UMrr0sGrz7qaUDAsvBngQ9PKezqrpcoHCRXLP2uu1Xc4IP8DSjTw6iffF92R50XOEpdgCH1pFcgYLoiPZTLrnrs0JC6j73km2pforoFeYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432988; c=relaxed/simple;
	bh=vBMG7mYgt+FbsK5xJI25HEdVnIp9blVA+6XSvOav+ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCYlOqlqa5ByG6KHgRhU5/e6cig30Of1wAFMmsf8rLX2Kp/rv9imgB8A04UsrnGBGqniRdd7hNPJ7XJ6dwC8BQxidJTH9lgNVj7+T3dJq3lAPvCU3VHi8l13mfJzLzb4pGd0SaW6LYx4Go0+xCwSNhDAwFKDReeSqKjw84OEOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOtL2uG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C1CC4CEE3;
	Mon, 31 Mar 2025 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432987;
	bh=vBMG7mYgt+FbsK5xJI25HEdVnIp9blVA+6XSvOav+ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOtL2uG0TGQpifArg7gIm93Eg/LkRivZK13678/ZHiog+5NiKW2yY+Zw4KWlfKUbg
	 1puKDetiIweqwKni42fl6UmDM/7QMU8UO17g75mxCwOdjITzU+TqG+GUkyveTtxfje
	 Oz64PqKq6MjstsTAHPWwPN6ssUCn29GgpJNKgUU60cEm/j3LrvCnNar3ukpf/W8Djn
	 mafiSa55R20uJn2lUTdHu8THeyP42qL9r4jsNBijQaSi8mJ7uW0WzvXAnHsPzTYPJr
	 DSuj1DbSUvLv6fuVmSerpPezMBQ3X1B0Ri1HjNxxTRUk36+bqiIVkD3J753A+Ctnm4
	 zcp2ymxsLYImw==
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
Subject: [PATCH AUTOSEL 6.6 12/19] ALSA: hda: intel: Fix Optimus when GPU has no sound
Date: Mon, 31 Mar 2025 10:55:53 -0400
Message-Id: <20250331145601.1705784-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145601.1705784-1-sashal@kernel.org>
References: <20250331145601.1705784-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index d90151910bee9..da9b9dc0c96d4 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1363,8 +1363,21 @@ static void azx_free(struct azx *chip)
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


