Return-Path: <stable+bounces-61592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A58E793C512
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41BA0B20CD7
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA6619A29C;
	Thu, 25 Jul 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WmyODhuU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7556EFC18;
	Thu, 25 Jul 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918809; cv=none; b=q9Gd/IuAgwnz/Qhfq7bep3/s09lQ1hNZWsTc07Y+Nmgne+bOblaAyQuoqEmRP0U1v0vW0LVAKaVD7MAZ9W9uT27ynAWdhvh0lUPcTXyMcj2PalVf6XXj1Qy4oOpgpzlpRXNByx+X0GUr4rRvx54JsldUGO741Klh2hhbI14adA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918809; c=relaxed/simple;
	bh=jEXQWsAZ/LyOMBd+z8/trwGYzOaClt7bw1zO4KP/Szw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQGBNSuC+ga0KGqXuVshQTv7ZA/rvlwlYJ9eAtS8rVJIX/6mCm/xMFYeJZnGA7hPksAWw4LG1Vm4wk6v029hlY0FeOkDiNuGqIFTWPxnh6ijsDRqB99hgjdqwV+VRpSnKLY9M3SLJJh7gsTKLb7ysl1K1Tu0NBy/8PQ/LNXKj3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WmyODhuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13E4C116B1;
	Thu, 25 Jul 2024 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721918809;
	bh=jEXQWsAZ/LyOMBd+z8/trwGYzOaClt7bw1zO4KP/Szw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmyODhuUylnvkrDY/xPF9UlL3bDbBafcysU7Bf+57pZoal+zki1y2KVwKjstmORsr
	 2jkGMPkyYM/etJLJE6TNntNni8OKcyO8qyc3NfnorMwmOLCJWmcRp4SOSdEst95rtB
	 mF7dXqjNvFHQrRiZa67Y7mIVPSXSIIOxX64UhvNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shenghao Ding <shenghao-ding@ti.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.9 08/29] ALSA: hda/tas2781: Add new quirk for Lenovo Hera2 Laptop
Date: Thu, 25 Jul 2024 16:37:18 +0200
Message-ID: <20240725142731.993139234@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142731.678993846@linuxfoundation.org>
References: <20240725142731.678993846@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shenghao Ding <shenghao-ding@ti.com>

commit 1e5597e5ff18d452cf9afa847e904f301d1ac690 upstream.

Add new vendor_id and subsystem_id in quirk for Lenovo Hera2 Laptop.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240717115305.723-1-shenghao-ding@ti.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10488,6 +10488,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x231e, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
 	SND_PCI_QUIRK(0x17aa, 0x231f, "Thinkpad", ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318),
+	SND_PCI_QUIRK(0x17aa, 0x2326, "Hera2", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),



