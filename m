Return-Path: <stable+bounces-127600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D03A7A668
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0985B7A4ECF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B684250C09;
	Thu,  3 Apr 2025 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AwJUeOLK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD024DFE8;
	Thu,  3 Apr 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693837; cv=none; b=TiOJdpthrsIJDDEhjE5cUdu2pd4OZphpB8LcL43WTmTM/XpteeYG43CEEAkyBglvOROfRUt04Ehq79Y8QHo21vnO7N0drVB40vl/SyGkE3dbsitYdbmRYG9ZWnmZGGE7kyyrPksZZHNPTQ19iWNfaJk8Puzrssob3Ma+3wYMI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693837; c=relaxed/simple;
	bh=JSgC1vWwNoATHuYemnQaXipqO3Tq9GOKfKflIxuLuHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJHmkwVdia5aYt0DvvG9l2MWjGXJzKFH+f6SSmNpJeR7/Dm2PxpWIr6eDbGibAK92OFqF6FxgzKabt2kpzYBDmQuhRq9tWGyjRRXzVX3//ZP7FPZDMszuKndGdEZSEKL73KwfA6JOh8qhIl8nBj/97UtgN2JyYo3TQCnarz4qPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AwJUeOLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459DCC4CEE3;
	Thu,  3 Apr 2025 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743693836;
	bh=JSgC1vWwNoATHuYemnQaXipqO3Tq9GOKfKflIxuLuHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AwJUeOLKFl8bSsrU86ZVr0yoI05dIG8ylaEh9h94QexPOXXLiiGIchIXweNDtgIfx
	 LnU54yARLBZw8BNqKJwgFUwege4TBKzwz8Xu847EGMEk4WQdyXGvogvtpl28sjahal
	 R0iL9rTxr9bEQcl2E8TmkCJhhCI9B/B3UzpEaPhA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andres Traumann <andres.traumann.01@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.14 07/21] ALSA: hda/realtek: Bass speaker fixup for ASUS UM5606KA
Date: Thu,  3 Apr 2025 16:20:11 +0100
Message-ID: <20250403151621.348600275@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403151621.130541515@linuxfoundation.org>
References: <20250403151621.130541515@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andres Traumann <andres.traumann.01@gmail.com>

commit be8cd366beb80c709adbc7688ee72750f5aee3ff upstream.

This patch applies the ALC294 bass speaker fixup (ALC294_FIXUP_BASS_SPEAKER_15),
previously introduced in commit a7df7f909cec ("ALSA: hda: improve bass
speaker support for ASUS Zenbook UM5606WA"), to the ASUS Zenbook UM5606KA.
This hardware configuration matches ASUS Zenbook UM5606WA, where DAC NID
0x06 was removed from the bass speaker (NID 0x15), routing both speaker
pins to DAC NID 0x03.

This resolves the bass speaker routing issue, ensuring correct audio
output on ASUS UM5606KA.

Signed-off-by: Andres Traumann <andres.traumann.01@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250325102535.8172-1-andres.traumann.01@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10784,6 +10784,7 @@ static const struct hda_quirk alc269_fix
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1da2, "ASUS UP6502ZA/ZD", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1df3, "ASUS UM5606WA", ALC294_FIXUP_BASS_SPEAKER_15),
+	SND_PCI_QUIRK(0x1043, 0x1264, "ASUS UM5606KA", ALC294_FIXUP_BASS_SPEAKER_15),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),



