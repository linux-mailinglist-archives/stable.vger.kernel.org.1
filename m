Return-Path: <stable+bounces-118793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6387A41C63
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C357A9145
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E974525D538;
	Mon, 24 Feb 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQqgksXW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A318A25A2CA;
	Mon, 24 Feb 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395826; cv=none; b=Cg0dB+6wqWPDh9wNnZ7q0OmLuKZ4rEHlL9+lgRskTN4oiPqLZx4+hEXGZVJRtANk9addOdekiBdln21SKrE4pMrI0xqy8bjS1Z13TKL1qF4RnnkMkXshXoB1bjerOBAOBfNUYBajj7gUW1+78wvU1fdtbUfPljHxZRyMr98J4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395826; c=relaxed/simple;
	bh=EM1fnh+2ktnufQk2T8b36HzM8BXgrRPOEnEkB6oWx04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PupvsgUDMqT2Nb4I8FeoVgMeznN9dueH1sN27CHpOFJYF1pqnlesZyyihlu2vXq32Msa00C+y/qlU4e2Z88g8HnompAvrU52xmo/Asqiaa3SF7FqPu6+J+Qu22k0szVGYwrTluXbquOFj/eZXFMVYUWt5Lo8R8OISMwDGOoDzIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQqgksXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8A4C4CED6;
	Mon, 24 Feb 2025 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395826;
	bh=EM1fnh+2ktnufQk2T8b36HzM8BXgrRPOEnEkB6oWx04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQqgksXW7yRAVcZtEuXGHnb9eWP1FWVNha7iQAqsYWDfRHcauOArXb79VLNR51Td1
	 9uSXq7enivehhYx3NGqo01BHtXkXiSPPDB1Lv0w1zNhNCvUFoP+AehrWO2mJGxMinn
	 BR9jzv7LmZCVIUFbznwVsDPUn4uuabXdklCYG/um6lpAztOVDnWAKhI9F/ZWuzkRta
	 b6jg5vTPkCmWho9tTpT3VnNfIuhEWu1XHF2cfvZzSdJkAjVQqpnJGwUY+QVwMjNrs7
	 Uz/djYT0/rzpWYq929TWLdok4X3x4cquQFwoWae6njv2pOe6C6C3ANY7RwlFGiVjk9
	 YbH52k1iN7CNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 09/32] ALSA: hda/realtek: Limit mic boost on Positivo ARN50
Date: Mon, 24 Feb 2025 06:16:15 -0500
Message-Id: <20250224111638.2212832-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit

From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

[ Upstream commit 76b0a22d4cf7dc9091129560fdc04e73eb9db4cb ]

The internal mic boost on the Positivo ARN50 is too high.
Fix this by applying the ALC269_FIXUP_LIMIT_INT_MIC_BOOST fixup to the machine
to limit the gain.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Link: https://patch.msgid.link/20250201143930.25089-1-edson.drosdeck@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6c352602987ba..f84ae43be4bf1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11017,6 +11017,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0228, "Infinix ZERO BOOK 13", ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
-- 
2.39.5


