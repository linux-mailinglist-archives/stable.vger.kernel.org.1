Return-Path: <stable+bounces-61459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2556693C469
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0B61F2094E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4237719D066;
	Thu, 25 Jul 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dD4NsatV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2593199E9F;
	Thu, 25 Jul 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918377; cv=none; b=PVSqgtdpeve7cZ3GZ4mBBaKjCNUjXSeTQOx06FzIW5Lj64VEpiOO1T4poZg6rMikokTys4u5AEnhSHjbGkOBDJvmeOYo30+h1x7H9GivaZ5fchl0yfy16iwTmeH7KfkFNa33vu0m1b/CkrYQ9v5deqUQaXcmIfrkh0rqwHJmjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918377; c=relaxed/simple;
	bh=T+/JarZQUqrcrIhU1f/R/ACzMUzk6PXiUQcyQENP4+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlAR3RuGGucBPdhHYKcqsoqxYwfJXcm0kr4/ecdg4lu0ZeOJ4qY+ciSsvusBNJIr/CXWuMBpS9/f+zvbShfORavfn4pRkCbEggILmTbtM629lR1TegCCY09IdS2QqyGDmDZH1RLQWqLfnkH1aItPTz6QoZommalLF3EqyAHsTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dD4NsatV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03828C116B1;
	Thu, 25 Jul 2024 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721918376;
	bh=T+/JarZQUqrcrIhU1f/R/ACzMUzk6PXiUQcyQENP4+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dD4NsatVTD0xhyV/R5wf1P5n8KrJTynZac58uYNpe8epbtvO6SzBOOvWLcAUhJ/Kq
	 wF5qI9fkoY7EN5fYzjH2iIfMOOjOwrxkKUCRGJOhq9HEM/2ekLwE1Ffv0WVKo70Oki
	 3Un4So4EVZwVb5+eFhXYgxcGDFt0oDdsWHZdS9zU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edson Juliano Drosdeck <edson.drosdeck@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.10 09/29] ALSA: hda/realtek: Enable headset mic on Positivo SU C1400
Date: Thu, 25 Jul 2024 16:36:25 +0200
Message-ID: <20240725142732.167377561@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142731.814288796@linuxfoundation.org>
References: <20240725142731.814288796@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

commit 8fc1e8b230771442133d5cf5fa4313277aa2bb8b upstream.

Positivo SU C1400 is equipped with ALC256, and it needs
ALC269_FIXUP_ASPIRE_HEADSET_MIC quirk to make its headset mic work.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240712180642.22564-1-edson.drosdeck@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10384,6 +10384,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
+	SND_PCI_QUIRK(0x10ec, 0x119e, "Positivo SU C1400", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10ec, 0x11bc, "VAIO VJFE-IL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x10ec, 0x1230, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x124c, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),



