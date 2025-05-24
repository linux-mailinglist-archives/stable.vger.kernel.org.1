Return-Path: <stable+bounces-146255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B48BAC3038
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F5C7AE072
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787C81DF24E;
	Sat, 24 May 2025 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fPPHH8nm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870F64D
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748101686; cv=none; b=tQPoWl8rGisD7L04Rr35Vb32eIi5WwBtzsTvDsSXUpBF8W0fs9G9xXX+gB7cwNgK8fNHS+rC+M1xf756GooW35T/p37eT6PX7mzpB3urBWufmpuD6REr+hLbUD1B4gGYUmF9s+XM/FSYX28SpuKgJaUvdJA2894xJiHXD5i4ISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748101686; c=relaxed/simple;
	bh=sBAabQw2h1cYtRs4B5CcMVudrosq7JLWR2ABgMs98cY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LsjPkH1ZrO8ZSOQZJR1bmd3yOM2g79HiPtW0LffSJ7Sj3WjJjrd9tZijAQHP3OEn+nzMFHuP/LElBdynBhn3r6wp6ZBYkj/SzuH4SyQ4UxUaG2qpo52YYfo3BGEuvLQ1wsO4ftygMZu6EEe7ZXJw1QVSRIb8NdBaIjJ/0w8VEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fPPHH8nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D239C4CEE4;
	Sat, 24 May 2025 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748101686;
	bh=sBAabQw2h1cYtRs4B5CcMVudrosq7JLWR2ABgMs98cY=;
	h=Subject:To:Cc:From:Date:From;
	b=fPPHH8nmgdpwYlH3LHJJVb/CFKVIyPwykwJtyEptUbFjAB81yRQi8sm0rqkeif4/k
	 kOsSXPTjSum016v3Fe81Ji0XPKbamlOnlVgx4+xj5wQ085PXBOzt6iI9baqDZzSKqc
	 zqYRlVJYYam7zzgd4uGex9PQ2KJgzEB35H3Fn3vY=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Add support for HP Agusta using CS35L41" failed to apply to 5.10-stable tree
To: sbinding@opensource.cirrus.com,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:47:31 +0200
Message-ID: <2025052431-scorer-rebuild-b36a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7150d57c370f9e61b7d0e82c58002f1c5a205ac4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052431-scorer-rebuild-b36a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7150d57c370f9e61b7d0e82c58002f1c5a205ac4 Mon Sep 17 00:00:00 2001
From: Stefan Binding <sbinding@opensource.cirrus.com>
Date: Tue, 20 May 2025 13:47:43 +0100
Subject: [PATCH] ALSA: hda/realtek: Add support for HP Agusta using CS35L41
 HDA

Add support for HP Agusta.

Laptops use 2 CS35L41 Amps with HDA, using Internal boost, with I2C

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250520124757.12597-1-sbinding@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a426d9882702..69788dd9a1ec 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10888,6 +10888,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e2c, "HP EliteBook 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e36, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e37, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e3a, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e3b, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e60, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e61, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e62, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),


