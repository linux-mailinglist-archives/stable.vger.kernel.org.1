Return-Path: <stable+bounces-22433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F5E85DC00
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD6AB23FCD
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5610978B50;
	Wed, 21 Feb 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="whQdZpRy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138244D5B7;
	Wed, 21 Feb 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523287; cv=none; b=FsQ8T0qVeWdgzjwP3uMmzgdLVDC8UuA+OqTXCeq56iQOoi9hRVv03aGQX3Ydv9ThVW+1CKxUzVLOPUsZMWvSWWacfxOkCf+n4P3SODjl/QTPTbf+GYCKnYtUocsV4JzFtEphBskIY2dfmAAcUZjl/AdA1vs7F50ITUPhNydekzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523287; c=relaxed/simple;
	bh=ExaYNAbiUjGsIe96ev+rXTx0F6SsNWrTQOivoqiAAEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLmFPr/saa3s28tBp8TBxZhdUx0mXXgLEo5T8HdMEjfpaYNWrki94OLV12UMSgedrS6UDP2Bi70pia7ESoDt/GMsq8Mf4+dgq6fLXbZn3suQam8XkycDv3UCtfV3cdBfMFGxJ5nIKJt1KOe+Mr2Yqat8I9NhPm7F1PhlFF2w/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=whQdZpRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715F0C433F1;
	Wed, 21 Feb 2024 13:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523286;
	bh=ExaYNAbiUjGsIe96ev+rXTx0F6SsNWrTQOivoqiAAEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=whQdZpRys+E38zq/g3A+Nup7wVevNKBuxexr1uNmedfNmoIDAJKXO2Hc5xUtpDdex
	 7xWPXalw2CTTG8i7nvk3Yd8Nr729Z8DgwpaWXJsmItzV1hfQ40GTw+yOFpAl4EQ4x3
	 aIVqYN1G6qsPGlnIO0hi5i1EO9AfjtlaE0O3uvYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luka Guzenko <l.guzenko@web.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 361/476] ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx
Date: Wed, 21 Feb 2024 14:06:52 +0100
Message-ID: <20240221130021.341426530@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luka Guzenko <l.guzenko@web.de>

commit f0d78972f27dc1d1d51fbace2713ad3cdc60a877 upstream.

This HP Laptop uses ALC236 codec with COEF 0x07 controlling the
mute LED. Enable existing quirk for this device.

Signed-off-by: Luka Guzenko <l.guzenko@web.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240128155704.2333812-1-l.guzenko@web.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9090,6 +9090,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x8786, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8787, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),



