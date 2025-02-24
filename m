Return-Path: <stable+bounces-118848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B122AA41CDB
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463B5188C958
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC970268FEF;
	Mon, 24 Feb 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoEl2Ca9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636B025E469;
	Mon, 24 Feb 2025 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395965; cv=none; b=RGl+N2zEV2mOmqu0BgZW3DYV395p1z6zpX4Fg0JFKeR86smQOTOyagtejdpiOaFkN0lUUr8Hlokckyffdhocy5ewasKm7kTYpeg2LjPcDAPaW3gg/bBsO0s5aIefscHhqgunWQ19xW1tPwbqOl5wHaW5LRbZd9zNgoPL2jz1NQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395965; c=relaxed/simple;
	bh=Suy+oJnmjdy30oP0cF32fKmEf2wZyzGOcJY7b1UL07E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rikk6dZtUj9wJo2fOFjtKO9sYyphtS/JM4wsBJbj0x/rBEuArZ5hBlLa85fM7hHBqmC3AuIH20iSwwBvBRhqHI3GYYt1t4N5SPe72pbAnkmC4/650uiqhJqO/e4b1pKUz6kRjPHrCrARSKdfMAnEdLW6X3mOO/uR7hgSz6jMdLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoEl2Ca9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EF0C4CEE6;
	Mon, 24 Feb 2025 11:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395964;
	bh=Suy+oJnmjdy30oP0cF32fKmEf2wZyzGOcJY7b1UL07E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SoEl2Ca9NDg5VJKM+UTrlWJ9BG7kED4IDFk/jSbHvzUeLgSTuxzi4kgTnz3isbcOu
	 ydGfPIfj6m50zJIH6v/cug6w4idumyxBbPDzyw8ljums+2LbCHSi9PPGk7FqGosuAp
	 Bl2Km5B0euwdP/YHRn7rrIj7uTq9GDW73XlEXHlWirIcA0pgGdHKv0v4kiYBESWHAx
	 nuGNiFv9AlRs85HW5aaw8vFwhRoaoMRUDQu714Twcxu06c6v5Hp2bkKW9zteTV6V+G
	 K4aDxczCahz4QmQ16sUEha+cOUMgnaiyH5Xstv3o0OUWIb4+JMDu2vvsC2YXE9boTy
	 KUJ2ENbRoOEZQ==
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
Subject: [PATCH AUTOSEL 6.6 04/20] ALSA: hda/realtek: Limit mic boost on Positivo ARN50
Date: Mon, 24 Feb 2025 06:18:57 -0500
Message-Id: <20250224111914.2214326-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111914.2214326-1-sashal@kernel.org>
References: <20250224111914.2214326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.79
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
index abe3d5b9b84b3..caa1076f40f06 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10434,6 +10434,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0228, "Infinix ZERO BOOK 13", ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
-- 
2.39.5


