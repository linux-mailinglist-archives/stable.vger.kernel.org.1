Return-Path: <stable+bounces-56192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A3391D56E
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7A81F21C3C
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A8115B96D;
	Mon,  1 Jul 2024 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKee5f1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF6748E;
	Mon,  1 Jul 2024 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792923; cv=none; b=Rqk76jI5ik8qhYM1Ffb6moVpRq2RLX3eRbE9725tPgmYAnEv8pfPwE/G1g3SA4D2B0aQWIhcnJd5bONvjAv6l+tzUNpXMiwY4g2qccgUisBIUkJRTC3XblROsxY/8Ogodri1ce9I1XCY0kkI7TcFDeV0wJh0blak0b0AUCfkccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792923; c=relaxed/simple;
	bh=iJ14qfumv3LX6dr7VKaBc547Tx0oeU74P7uhca7wfg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM9wLMkVClfnjvhcXMKpPN9GSpJ8ZU0s7rTc9GCtR/nhm7GKl4ILRpNsXNd82MfoBUppDMGnncaOBioBPt9TbDA5DBVYUNTe+D+1oIRg8w97w1pAntUIWYI1yAx1nFrlN7bds/O/TJWVqXBuouBU91CJp7uo59ejYJt4K3/1gqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKee5f1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210F0C32786;
	Mon,  1 Jul 2024 00:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792922;
	bh=iJ14qfumv3LX6dr7VKaBc547Tx0oeU74P7uhca7wfg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKee5f1Jlno72pog4wkNXB9skoK+QdQfeW+cDf8fxRo2ikTh1e1d15QqvsDriFjC8
	 JQURyw9nCQWgHz3vErFSMci2b9SCIkqCGe1vlNAwZwJhgumYVvpj6mlT70sC3pKj9d
	 lVrAwdrjJtxYG/KvB5AdFXiQKtNRIhTmQ/7/IwpPn8cCb9B5MfIhTwaApg3v9FIIf5
	 a4Fx2SkyPkqdWfYS1UbWQHzIG/jwYsz0Mv23a+ivANHLpEK4FH954BSa1285cp91XT
	 8vhLptxPmFkV9gg+UP2e8odspxMKGlx+tH66+iwx2nNoICEOcVR+ykDyzotaP0xo95
	 UcI1fcu25Ra4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/4] ALSA: hda/realtek: Add more codec ID to no shutup pins list
Date: Sun, 30 Jun 2024 20:15:08 -0400
Message-ID: <20240701001514.2921545-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001514.2921545-1-sashal@kernel.org>
References: <20240701001514.2921545-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.278
Content-Transfer-Encoding: 8bit

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 70794b9563fe011988bcf6a081af9777e63e8d37 ]

If it enter to runtime D3 state, it didn't shutup Headset MIC pin.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/r/8d86f61e7d6f4a03b311e4eb4e5caaef@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bf9a4d5f8555d..3632a0c9d56be 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -520,10 +520,14 @@ static void alc_shutup_pins(struct hda_codec *codec)
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 	case 0x10ec0283:
+	case 0x10ec0285:
 	case 0x10ec0286:
+	case 0x10ec0287:
 	case 0x10ec0288:
+	case 0x10ec0295:
 	case 0x10ec0298:
 		alc_headset_mic_no_shutup(codec);
 		break;
-- 
2.43.0


