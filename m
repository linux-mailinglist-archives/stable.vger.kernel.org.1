Return-Path: <stable+bounces-127247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB58A76A9C
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A503ACC25
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDA724EF61;
	Mon, 31 Mar 2025 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgi2OKj4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1850C24EAB9;
	Mon, 31 Mar 2025 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433033; cv=none; b=aXVIgu2rS7pB3Ca/1X/C+XabCzmXigtOE3UuD80HEnr2B0QQA3Tq1D5G7xBIpH7uE7E5j3BKeWTaZdxNsvK7kij3Ekliu+V87FhytBivymk+ipdwj0+O0MXBr+xVZfK7DqBQSeLUvps/6H2RQCptII4vKzfMBkRUPPTVAKnbCEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433033; c=relaxed/simple;
	bh=PNzN78rYK00rCyHrp5G+uU/XIeEA8hHizQU1xPBIPlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gf8n2SIpsWGimIzuxZCylTyUd65f8uOoFETgRUDelf4EzJCbJa6EXgz4aucIzLxZUNCZitrm+fnIaB/4dOKVB8sQ4o8/G5vHf9OeK5akGDVGBSSLBIGAyo2tAaU1KjPznq6q748tk2gNK1rHw6QnQHy4/zMr+VqNjGKoD4wHCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgi2OKj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5348C4CEE3;
	Mon, 31 Mar 2025 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743433033;
	bh=PNzN78rYK00rCyHrp5G+uU/XIeEA8hHizQU1xPBIPlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgi2OKj43ofu3usHG+EkYaWaG0kuFkSpHzFM59RPcLvMBS6OOGlA41ZDjpetjnrwJ
	 3QMo3ILlh5gNNYrnpPi8rWveYWH/5l6L7/QMAExYU6jZvh7G60xNESj3XHcbFEaK+w
	 CGWJHXR2CNl4sBMLVqMiP3TwT+7Jc1Ls/1wKHz7/fOES1ke/OyWUmBiUGwMA+7sMrU
	 3sbOTHw7IijFVJBSeuPXM3EA6i+scY7m1MY7jb+JNBaHqaHAHAR403HKGlTU2nYYAO
	 hPcGCNLrjE6vjWcQQNxiGjGLmAAcNF3SiRFUCVXLv76+LlsNsP33T5IxiUWf8XrIys
	 UGMmC/jfmSukg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxim Mikityanskiy <maxtram95@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	peter.ujfalusi@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	yung-chuan.liao@linux.intel.com,
	hkallweit1@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/6] ALSA: hda: intel: Fix Optimus when GPU has no sound
Date: Mon, 31 Mar 2025 10:57:01 -0400
Message-Id: <20250331145703.1706165-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145703.1706165-1-sashal@kernel.org>
References: <20250331145703.1706165-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index 16c7fbb84276a..5f0e7765b8bd6 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1365,8 +1365,21 @@ static void azx_free(struct azx *chip)
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


