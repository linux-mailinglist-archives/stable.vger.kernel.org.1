Return-Path: <stable+bounces-118823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EDEA41CAF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E970F3A764C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBBE266186;
	Mon, 24 Feb 2025 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJFwNCvn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3B266180;
	Mon, 24 Feb 2025 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395900; cv=none; b=ZpicK8kxLvnodNLUCqoicCfbDoFs0cmO5DSBTKkI/zJfOopfJfx7CO8jpG1v1nurwPNGhZXdxA/9sxLQjky97ovRVfUrn3oU53zEZApPHaq9xPTUbjGNzZJ0ltvpyE2p+H4aE5PUwRgNHvc+h5aTUYWLwpnWq5KogMqVB9N7lT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395900; c=relaxed/simple;
	bh=i/7zdSp3AEI/oOO6ygb3szBu/IO/fuIvMd+6zKc9QZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jwt7EqaC8hmYftT60COBSa8l41Fxdf/kBkuRGM1OQBcc9T42HHXFuvK45XfU2LY19H29hKjDD7VkXf7u9NsKhx56uFLPRVo5uiuJdLG6bFRywTVs2Ey9KPXP70qqJoavBlMieXT8PhbL68XOWFkReyvxuDLSNE61qKeb6zyBWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJFwNCvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0515AC4CED6;
	Mon, 24 Feb 2025 11:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395900;
	bh=i/7zdSp3AEI/oOO6ygb3szBu/IO/fuIvMd+6zKc9QZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJFwNCvn+skscYK1khEpQfQMDgw95NlXlnX9Zw/hmAw7h6KObVmRxKQ4RKNLr/JkI
	 NlPogcv8AzdGbDTg5hcIcGLgDUkRz2dnbNPJYfGPrwYNFsxQn7qd1q1Q8jUrgXLT3n
	 VhvbmWKUelgiFpNt63aUEnofhNTxjE0vEqOsWEiKBDF27NZOovPnoQ2+Vd0hx5BeUV
	 VhWcAqEZsrMfvC1S1XUPHynMe9HkQTJdWwTNPyjxkhE2Eq+do0ATBGd/66KLDeT6K6
	 Ma13rHTIgPve1BZEL1nfYPv8P7fcZzdluioNxaDjPVJUpcunrN2zYtL3FIq0FM/rTY
	 2zcmMELNVc7gw==
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
Subject: [PATCH AUTOSEL 6.12 07/28] ALSA: hda/realtek: Limit mic boost on Positivo ARN50
Date: Mon, 24 Feb 2025 06:17:38 -0500
Message-Id: <20250224111759.2213772-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
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
index f3f849b96402d..2d91654bbeb82 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10985,6 +10985,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0228, "Infinix ZERO BOOK 13", ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
-- 
2.39.5


