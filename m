Return-Path: <stable+bounces-146253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C0AC3036
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDEEE17CDAA
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08041DF24E;
	Sat, 24 May 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gbczHIg3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807BE64D
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748101679; cv=none; b=DODPqIPqb0VADzk2dGzBK6nIFuWdmK6ji8XJD0DP6dZxWkXcc/CinKqkzCH3gicv2PiftdqLbzGm6UrZ/Tf1Fc+xssnTHI1klQTPWeQ4QeAi5sqVRZq2Uhk9gCk2CUwGgHSIbOAGuAurT0F9ahISM/2hYuVs885mnlJz3XKqRXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748101679; c=relaxed/simple;
	bh=1DXnGPKWaUpegTF7ugPZGNrLtD82O1TSHMT61sGfcEA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qINwh9QSbMEHec2aFJAgGHuvMfwU5xAOiIM6TWwQetfqe/Hpd+OaZhhYpL/OCaAwWugbJMUvHKnXk7ZJ6An/MjBmHv1s4JmAyK8eBEf5HREJWAzXTNphnKnCK6Nn8FYPcNEj5V4ZRWGJODkBrwUdI1kITfbAq8XoOO2QeZEJ7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gbczHIg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85F8C4CEE4;
	Sat, 24 May 2025 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748101679;
	bh=1DXnGPKWaUpegTF7ugPZGNrLtD82O1TSHMT61sGfcEA=;
	h=Subject:To:Cc:From:Date:From;
	b=gbczHIg3q0x2lquJrtbx8yWJxBci6vtNkftMqWanDOKMunY1No48cfwKgFkIVUhc6
	 TTxyjAkCSGegbDOODYJ1+/NrAV0GbleRSUeoz64EKLN2DnUqwBY3cjyxRRP3mUnqyX
	 ZxVyZp5XBUrkEQUDz6HD6G3zs24odQinc37JDHqg=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Add support for HP Agusta using CS35L41" failed to apply to 5.15-stable tree
To: sbinding@opensource.cirrus.com,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:47:30 +0200
Message-ID: <2025052430-reoccupy-unbroken-8b7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7150d57c370f9e61b7d0e82c58002f1c5a205ac4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052430-reoccupy-unbroken-8b7d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


