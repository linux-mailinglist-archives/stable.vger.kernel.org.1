Return-Path: <stable+bounces-157396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BA6AE53D6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE021894E6B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41F9223714;
	Mon, 23 Jun 2025 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AoSexVac"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8326B223316;
	Mon, 23 Jun 2025 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715763; cv=none; b=Q00Xv0CmdTTYYy6Csorh3bFsSF6c2+dgxDRbAxkisrjpVVZuMxJUoyy+/75vQ3B8Um8rSXRfNmpOoWgY6oLx2WpwXphpA6b74eEDyFsz1XmVVJfZ8YEL+YyX4Hwxg/Vm/ja9EuO1w/PUkEZ4GB1U4A3RzLVBJM4478aclf+WdkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715763; c=relaxed/simple;
	bh=wTerhwoUCUbwz7qaGl5ACG3z3A0iBMoZH53LEtSEn2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMTQXcdGZl6uSN/dgmZwxCZHE97YrKeZEvS8a65W6OIW03f8CMpoz0XImKMQhPsQF7D8Pbj/DrpuASSGT1YJZmBMRO0NXpUkqMi0njlde6LJxXHIsYolH8QTV4iNt9kQxq/wFGWBwrvqpRMAKwND3fo9vmjrtZJQ4NK2kIzyOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AoSexVac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B168C4CEEA;
	Mon, 23 Jun 2025 21:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715763;
	bh=wTerhwoUCUbwz7qaGl5ACG3z3A0iBMoZH53LEtSEn2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoSexVacZj6NwbB+1ZS2mChgsAro/xVqxQgPRhbICRgmvUH+7+T8To3tldpEkjGXF
	 wn1EyhBRcGN4pNdoJc22XCa6SIoI+ozl6cQ2fj2Ku4DdrAiExfIt0G4sYrq3OIFMFx
	 LAHZJAJoksvvy8yQC7KuNMQtJtjWEeXxWYdEF424=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 295/355] ALSA: hda/intel: Add Thinkpad E15 to PM deny list
Date: Mon, 23 Jun 2025 15:08:16 +0200
Message-ID: <20250623130635.644679921@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit c987a390f1b3b8bdac11031d7004e3410fe259bd upstream.

Lenovo Thinkpad E15 with Conexant CX8070 codec seems causing ugly
noises after runtime-PM suspend.  Disable the codec runtime PM as a
workaround.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220210
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250608091415.21170-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/hda_intel.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2295,6 +2295,8 @@ static const struct snd_pci_quirk power_
 	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
 	/* Dell ALC3271 */
 	SND_PCI_QUIRK(0x1028, 0x0962, "Dell ALC3271", 0),
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=220210 */
+	SND_PCI_QUIRK(0x17aa, 0x5079, "Lenovo Thinkpad E15", 0),
 	{}
 };
 #endif /* CONFIG_PM */



