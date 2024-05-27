Return-Path: <stable+bounces-46491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF6F8D06D9
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB471C216AA
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4640A1607AA;
	Mon, 27 May 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3w/oQEA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE7155C95;
	Mon, 27 May 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825149; cv=none; b=Z/elTwFm9dxh1lo2O0HtP5fbzXoVeoWKC6EfwQRJqHZP5TNSto0q3jmZ423ITYEuS0sQdpughYJzTy8DXzK74Xy1/gzEYmSI7hL8y4t34bcDhnopgC2eJfleUzCKDdCtzbS0EzaYk3nUoyaI9aR9r7a6Zxtp/z3O6grvXgGxRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825149; c=relaxed/simple;
	bh=aP01REaY0U5NhQcqlGF9TQdVEzrJM8SPPIWI1PGJt5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PH7FaJMScIo4cGBbft6MQD6XA/1WcY+VIX5WmXb6oK1revl/c4YBs7mxgGSR9VoPwH8quj2+ak1mYhfGEPLGMPcKNLgy+b/3LY+idKYjN80SP+JbsmlDUS7MR0/Av+OMhsfCNNTCipJec5kRTiGqPOEPbpbtJiq0MF80MxU/q60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3w/oQEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463F0C2BBFC;
	Mon, 27 May 2024 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825148;
	bh=aP01REaY0U5NhQcqlGF9TQdVEzrJM8SPPIWI1PGJt5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3w/oQEAX6/vOEgoB+2od0Bb2mhCUCtLGWV6AoAlf5l1J36mcofSQ+IlMfKslmU2i
	 7wBgbr/k418GfNEbUG8C6y7qvoQAAlzO1qBZSvKvmeaikaIuzwsaWs8NIUecxdP4nn
	 ZvGgdy3GuVjnMPl112WUmmhCtJ77f04n29vjhKWl38ZZrmJnBR2V4ZKoLwsGv9bK04
	 32pOjV8VwUeTOALkO1b4pXmd4w4fOFiRap4dIAt4Gu9vWDM2UeL0DeK7Yozy/SBHmK
	 +wF5EH5HJddCkRCSlPO7fVC7vMcRqeD93WpAcNgCXerpB0YSGT3oayGyIwjLnYK/Rx
	 C/lAisxE8+UjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 16/23] ALSA: hda/realtek: Add quirks for Lenovo 13X
Date: Mon, 27 May 2024 11:50:17 -0400
Message-ID: <20240527155123.3863983-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155123.3863983-1-sashal@kernel.org>
References: <20240527155123.3863983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit 25f46354dca912c84f1f79468fd636a94b8d287a ]

Add laptop using CS35L41 HDA.
This laptop does not have _DSD, so require entries in property
configuration table for cs35l41_hda driver.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Message-ID: <20240423162303.638211-3-sbinding@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cee387aa458f4..0e56ddc365765 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10499,6 +10499,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
+	SND_PCI_QUIRK(0x17aa, 0x3865, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x3866, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion Pro 7/7i", ALC287_FIXUP_LENOVO_LEGION_7),
 	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA7_14ARB7_I2C),
-- 
2.43.0


