Return-Path: <stable+bounces-46527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88938D0761
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B936A28B61D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67EF16C685;
	Mon, 27 May 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1zvNFYL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6277A16B749;
	Mon, 27 May 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825376; cv=none; b=Pcv9x4v+PGFa1cQJ7QIGrR0+eWHUKjTpVd98Jsnq7ExDAgQVK4ABwgjkDt0mDObkGuy9c1biB015E/baTYiyMwKDySTKHzs49u2I+9CG1D1AhtFQUvUbHv8zDinvpGVcN7NB2jxx0ttp0L6wx0olVU/VqHtYYk6CHRMBzgi6eSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825376; c=relaxed/simple;
	bh=280O8cUgyBf5hO6yQQgPCFGoEsR+SkZJJ87JtS/f/zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZay0chr2Gy4BDUtx6xUQbK/FY0UabkhE50WkIuhjxA8ZFSlkao2K1mu2HWYXXsC/Z/WwvfECRw61EyV3ZFHeC7qiVUPdoJew9tODKv7jMa/Gx6RL0F56+RR63TPRPjDs+lz/f+Aj2JQX1LgnMZT8LZuD0DHdUrymv50O9lgfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1zvNFYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43E5C32781;
	Mon, 27 May 2024 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825376;
	bh=280O8cUgyBf5hO6yQQgPCFGoEsR+SkZJJ87JtS/f/zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1zvNFYLUJie7GLCYXeO4BJ8WOxFAQqPwVcq0Qjx9QwnJFs6DePbM3fnuqIl4b3DI
	 b8RAWZcN58PIPBWsFTOaHyH2Flh77lPMDKfaUtN4UHLQPWFzdjOh9CmvcBIsJDDziw
	 Y+b1eu67V8u/n884gmbDHaluJtcv9qzcuUiNxna0iI7KWz7mmZ99Oc17cQujJ3MO5K
	 XuZIvssKd5Eq2lt/zxZs8hjz6Ynv3TY0MuAm4xNGWC3ZOKCQA4UIUliNf3bAdURRIa
	 KwOQYTncgXTysqxkUURe993NjX7rg2IGcwoJZIq+Mtxc2J5hRhIUKVna2zEzYm/Qzb
	 B/Ewp2OLg6WcQ==
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
Subject: [PATCH AUTOSEL 6.6 09/16] ALSA: hda/realtek: Add quirks for Lenovo 13X
Date: Mon, 27 May 2024 11:55:00 -0400
Message-ID: <20240527155541.3865428-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155541.3865428-1-sashal@kernel.org>
References: <20240527155541.3865428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index 47e404bde4241..bbbfa06d72071 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10254,6 +10254,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
+	SND_PCI_QUIRK(0x17aa, 0x3865, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x3866, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x387d, "Yoga S780-16 pro Quad AAC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_TAS2781_I2C),
-- 
2.43.0


