Return-Path: <stable+bounces-6127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AD480D8F2
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2751F21BEB
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8A524BB;
	Mon, 11 Dec 2023 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aUhscs2A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55135102A;
	Mon, 11 Dec 2023 18:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8D6C433C7;
	Mon, 11 Dec 2023 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320585;
	bh=XgLLxZn9WbRYZzHpl3gyaLGLFD1C4dWydMn0bl+zeWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUhscs2Ar1s0a40UZf1ImXBuEJ2vomJI50TYnRzxauJDmUHBJYsz2DNzARK+sljOv
	 x2i6c4kOUJUOR0iSrfXWxBjed4yZImANFdL5370mLbq00CfidhM7uo6c72qkZAF1dY
	 DonFWOO1gtx62Oeiea6Xj7KV3C+JdOe91Tc/D5hY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Bosse <flinn@timbos.se>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 108/194] ALSA: hda/realtek: add new Framework laptop to quirks
Date: Mon, 11 Dec 2023 19:21:38 +0100
Message-ID: <20231211182041.284071787@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Bosse <flinn@timbos.se>

commit 33038efb64f7576bac635164021f5c984d4c755f upstream.

The Framework Laptop 13 (AMD Ryzen 7040Series) has an ALC295 with
a disconnected or faulty headset mic presence detect similar to the
previous models.  It works with the same quirk chain as
309d7363ca3d9fcdb92ff2d958be14d7e8707f68.  This model has a VID:PID
of f111:0006.

Signed-off-by: Tim Bosse <flinn@timbos.se>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20231206142629.388615-1-flinn@timbos.se
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10031,6 +10031,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
 	SND_PCI_QUIRK(0x8086, 0x3038, "Intel NUC 13", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0xf111, 0x0001, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0xf111, 0x0006, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 
 #if 0
 	/* Below is a quirk table taken from the old code.



