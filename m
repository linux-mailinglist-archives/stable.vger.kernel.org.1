Return-Path: <stable+bounces-150516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 990ECACB842
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EECB1BC57F0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6E5221F24;
	Mon,  2 Jun 2025 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XX1reeSj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5BF221DB3;
	Mon,  2 Jun 2025 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877367; cv=none; b=Gx1/Bsz6n2DH5oOWSkPK4f1o704tWNKHAt2u0WBhn0NYvz2DSOMT46nE2RzrI9kEljtz+h9kHUbzWwZTPH2P44ZSWFaQje7siRPljBzEMVIe35Ch4AA3sNyknfjcElZVi4cDCIvMp68h+COm59202meekkTieuJnJGl96nChM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877367; c=relaxed/simple;
	bh=Xh4mC0LkEX9Sq3l6a6cj4oPPrhMc4IAlT/oJV4/v0L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5udWBCBR3ueWEgZGyjZ+ms/ANP8jbTvgTTVPWYhcKnv/vpqNP1u7FeHnc/47mVEzc+/IGDfhehi/Qun+xTEFVh2ZOoO9QbuhnyEskPaVANaRZpmz7TlfUaTLgjzLZ3snOm7mal1Q5V7GCA1dcCZmYRl5BpmA62oerDHBqNOgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XX1reeSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2BBC4CEEE;
	Mon,  2 Jun 2025 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877367;
	bh=Xh4mC0LkEX9Sq3l6a6cj4oPPrhMc4IAlT/oJV4/v0L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XX1reeSj6t2O255zTA1t/NhdTpCCEvxDW/EStrXOYefJdgwA2Xq+1VClJlMM0CFWF
	 Mye2BvcB00F96fBVL2r6NKArGVeIVQ8vDOFtoWvskGrNLhQjHBy5AqUMPicYvpN9qH
	 Sanf4SEqz+rvnbz4+6OjR6cP9yYDF/BPY+cdV8+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ed Burcher <git@edburcher.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 256/325] ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14ASP10
Date: Mon,  2 Jun 2025 15:48:52 +0200
Message-ID: <20250602134330.175927733@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ed Burcher <git@edburcher.com>

commit 8d70503068510e6080c2c649cccb154f16de26c9 upstream.

Lenovo Yoga Pro 7 (gen 10) with Realtek ALC3306 and combined CS35L56
amplifiers need quirk ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN to
enable bass

Signed-off-by: Ed Burcher <git@edburcher.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250519224907.31265-2-git@edburcher.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10379,6 +10379,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x3866, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x390d, "Lenovo Yoga Pro 7 14ASP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),



