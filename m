Return-Path: <stable+bounces-127184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FDDA769AF
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6921892699
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B7722FE15;
	Mon, 31 Mar 2025 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGwzB83w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F36822FE0C;
	Mon, 31 Mar 2025 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432894; cv=none; b=hEuZZBSlPoLlNBmmBS8quspvDqKPpcAl6Do2QvV8Iq06W7zG+2vBoAFQyxvtJl+bjBtQ52JD0pQTCKz4GdbZGDPR74n4l4a3CToxD2wBefLR6KTLhs/XRyRd1eqE5uivoriv50SoYRYSRmMeS5UxCaRVB1NuhqDVOtd00PSDaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432894; c=relaxed/simple;
	bh=4wDyi5BWKf2udm+YBUejtsH0tg2dOSYunxOb5IyN7ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UI+JwNyJSxvVbMfhebKBRJ2jwcUlb1sovKkEeWQagAQzOJcTd2BVQa7nHZIWTwS2QAHKxBTUkS8hcF3w5AhB4/u0HnJFePkEbhj2r27SoXwdjKTimjQclIq1A14CvguB0zE9xU5QV+XJ3oWW9gVuzRyBf7P306usHg8LHbhehfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGwzB83w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC46AC4CEE3;
	Mon, 31 Mar 2025 14:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432894;
	bh=4wDyi5BWKf2udm+YBUejtsH0tg2dOSYunxOb5IyN7ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGwzB83wKAQKKoAd6EqQFS+gKakInlmz7vermTCjQ6F4/uyawNAlLtdZluoByjfus
	 kF9PCkpUNHPXgGUXdmNtCQhxSEpMZLw4B4LvhSv9KJUilTJ04fCO4Gc8B/nnGWLuIw
	 E/7YLn5NaWdzPJ8TShAfxuf0j7LYcrJ3u8YimElBB6IMm7vzlFlGIJ6aAIxw7XDz/5
	 0RkXLo7qTaDJ9AB2uoJKn0I9xPW2bZ6qmo773F+JQyy5UWqZqcp4S+jWxuP/PTDsto
	 6t7QbzIPimyhkY5MkcEU/hU3hHlUkmE9B9Nb7rK6kYN9aZuEHYmKMgbOJx+zM+h6Nw
	 8eNjg0WFTFS3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maxim Mikityanskiy <maxtram95@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	hkallweit1@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 16/24] ALSA: hda: intel: Add Lenovo IdeaPad Z570 to probe denylist
Date: Mon, 31 Mar 2025 10:53:56 -0400
Message-Id: <20250331145404.1705141-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145404.1705141-1-sashal@kernel.org>
References: <20250331145404.1705141-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxtram95@gmail.com>

[ Upstream commit becc794c5e46f4dfca59f2385f78d83fc9e84700 ]

Lenovo IdeaPad Z570 with NVIDIA GeForce Ge 540M doesn't have sound on
the discrete GPU. The HDA controller in DGPU is disabled by BIOS, but
then reenabled by quirk_nvidia_hda(). The probe fails and ends up with
the "GPU sound probed, but not operational" error.

Add this laptop to DMI-based denylist to prevent probe early. DMI is
used, because the audio device has zero subsystem IDs, and this entry
would be too much, blocking all 540M chips:
    PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000)
Also, this laptop comes in a variety of modifications with different
NVIDIA GPUs, so the DMI check will cover them all.

Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Link: https://patch.msgid.link/20250208214602.39607-3-maxtram95@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c547a86ba659c..230be67b70286 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -37,6 +37,7 @@
 #include <linux/completion.h>
 #include <linux/acpi.h>
 #include <linux/pgtable.h>
+#include <linux/dmi.h>
 
 #ifdef CONFIG_X86
 /* for snoop control */
@@ -2074,6 +2075,27 @@ static const struct pci_device_id driver_denylist[] = {
 	{}
 };
 
+static struct pci_device_id driver_denylist_ideapad_z570[] = {
+	{ PCI_DEVICE_SUB(0x10de, 0x0bea, 0x0000, 0x0000) }, /* NVIDIA GF108 HDA */
+	{}
+};
+
+/* DMI-based denylist, to be used when:
+ *  - PCI subsystem IDs are zero, impossible to distinguish from valid sound cards.
+ *  - Different modifications of the same laptop use different GPU models.
+ */
+static const struct dmi_system_id driver_denylist_dmi[] = {
+	{
+		/* No HDA in NVIDIA DGPU. BIOS disables it, but quirk_nvidia_hda() reenables. */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Ideapad Z570"),
+		},
+		.driver_data = &driver_denylist_ideapad_z570,
+	},
+	{}
+};
+
 static const struct hda_controller_ops pci_hda_ops = {
 	.disable_msi_reset_irq = disable_msi_reset_irq,
 	.position_check = azx_position_check,
@@ -2084,6 +2106,7 @@ static DECLARE_BITMAP(probed_devs, SNDRV_CARDS);
 static int azx_probe(struct pci_dev *pci,
 		     const struct pci_device_id *pci_id)
 {
+	const struct dmi_system_id *dmi;
 	struct snd_card *card;
 	struct hda_intel *hda;
 	struct azx *chip;
@@ -2096,6 +2119,12 @@ static int azx_probe(struct pci_dev *pci,
 		return -ENODEV;
 	}
 
+	dmi = dmi_first_match(driver_denylist_dmi);
+	if (dmi && pci_match_id(dmi->driver_data, pci)) {
+		dev_info(&pci->dev, "Skipping the device on the DMI denylist\n");
+		return -ENODEV;
+	}
+
 	dev = find_first_zero_bit(probed_devs, SNDRV_CARDS);
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
-- 
2.39.5


