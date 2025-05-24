Return-Path: <stable+bounces-146251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15732AC3034
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95614189D626
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916E199E84;
	Sat, 24 May 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NrOWq8RC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811D64D
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748101669; cv=none; b=cu6/rko0RLLyOqtbPrREOEUfxXi5IreFwWy8oLAM71aDJyM1AgSgNbH4CUHS57YZZch0V9FrlNMAV0b0+Zr6A+mmDbyaMvB6b8vzLhHFJKEY2JnBqYNY7AvcDputFsbf6IH/k8mWuhe5eC51OndGK1ESAiLp6yFpQG/i5LUTLTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748101669; c=relaxed/simple;
	bh=LuWneTm9ElMesCzkY4vOUmm+GMPOrRdlSHg/O1SyI2E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NnCmBTWhaMFGK8JQEoLfaIZ3fRHTTxIKuEBCorhSlC2ZfkMLOUQJnV012MvMtceMFCxAa8YIX3a8aVIF/E0SePfZsL2TQv0btEYj0XD7hBynfolMw1Dec4Ha1hriSDQUd76jeRmJNtiPon+4MM76msmE6xAAqDUWwYwH6M95N9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NrOWq8RC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C8BC4CEE4;
	Sat, 24 May 2025 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748101669;
	bh=LuWneTm9ElMesCzkY4vOUmm+GMPOrRdlSHg/O1SyI2E=;
	h=Subject:To:Cc:From:Date:From;
	b=NrOWq8RChitV1eE4FNWOmGf0AcpYTAkERNwSZ+Urglu64wNtiuUPwiplazPNHyqCA
	 nYUy6mn8f0vlHe0ZWrFMTmQP0rGxOKQTXaVj5yBcO8x2BFcUQZWfZ2ji8QMIvDgC/h
	 7Dcyv1s+ch5JbNwl6b6jfSUlvXW2cDnyqMKdkMWk=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Add support for HP Agusta using CS35L41" failed to apply to 6.6-stable tree
To: sbinding@opensource.cirrus.com,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:47:30 +0200
Message-ID: <2025052430-aching-oval-a807@gregkh>
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
git cherry-pick -x 7150d57c370f9e61b7d0e82c58002f1c5a205ac4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052430-aching-oval-a807@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


