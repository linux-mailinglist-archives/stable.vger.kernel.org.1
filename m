Return-Path: <stable+bounces-144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927A87F733E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 13:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC12280F0F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A35200BF;
	Fri, 24 Nov 2023 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h7/hEXkz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBA200A5
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 12:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DCEC433C7;
	Fri, 24 Nov 2023 12:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700827217;
	bh=zUHKnxiGLyBSzpQJdz+zNiVRo8GYLBS9uglqCKTODOk=;
	h=Subject:To:Cc:From:Date:From;
	b=h7/hEXkzGsir6wvKP2Boqs12578rKv/cY3kYpLFXVeRSYSjj1XHAjMQ6EHubnaHaC
	 oMwRdkbSr0fStnOP51yJGq3UI7oMJXVOu5tFmDJ589rbDRCjz2gL5LQ6Z3fqPhQSL1
	 mYnCTosyWb84m1BRgL9+Ay0bqq9tNDPmTAn/5x6M=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Add quirks for ASUS 2024 Zenbooks" failed to apply to 6.6-stable tree
To: sbinding@opensource.cirrus.com,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 12:00:14 +0000
Message-ID: <2023112414-nemesis-subgroup-1ab8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 61cbc08fdb04fd445458b0f4cba7e6929afdfaef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112414-nemesis-subgroup-1ab8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

61cbc08fdb04 ("ALSA: hda/realtek: Add quirks for ASUS 2024 Zenbooks")
6ae90e906aed ("ALSA: hda: ASUS UM5302LA: Added quirks for cs35L41/10431A83 on i2c bus")
f0d9da19d7de ("ALSA: hda/realtek: Add support dual speaker for Dell")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61cbc08fdb04fd445458b0f4cba7e6929afdfaef Mon Sep 17 00:00:00 2001
From: Stefan Binding <sbinding@opensource.cirrus.com>
Date: Wed, 15 Nov 2023 16:21:15 +0000
Subject: [PATCH] ALSA: hda/realtek: Add quirks for ASUS 2024 Zenbooks

These ASUS Zenbook laptops use Realtek HDA codec combined with
2xCS35L41 Amplifiers using SPI or I2C with External Boost or
Internal Boost.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20231115162116.494968-2-sbinding@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3c85b8247c11..a1e124370283 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9947,13 +9947,17 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1a63, "ASUS UX3405MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1a83, "ASUS UM5302LA", ALC294_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1b11, "ASUS UX431DA", ALC294_FIXUP_ASUS_COEF_1B),
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1b93, "ASUS G614JVR/JIR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x1c03, "ASUS UM3406HA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x1043, 0x1c33, "ASUS UX5304MA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1c43, "ASUS UX8406MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1c9f, "ASUS G614JI", ALC285_FIXUP_ASUS_HEADSET_MIC),


