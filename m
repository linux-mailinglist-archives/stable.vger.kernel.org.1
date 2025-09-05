Return-Path: <stable+bounces-177900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E040B46559
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 23:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D04AA3A32
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 21:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BD61F30AD;
	Fri,  5 Sep 2025 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB5bmSJn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D9E55A
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107023; cv=none; b=cc6Ebp/c+MWd5kqJrdpQWhK8juw8PGv6SdFsLEyyZ8eUKNZySwL9ktMjOB9uh7rGd/gLEftgkiOGSJpm+0np4vSVrNcYqNVVsgqVhx7H0Nwy3A7JbctHOXhG3udzhmAlgGd5ALWBZZKW8/JD1ldH9xLwKX/hrKrj33gXaJ9wrY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107023; c=relaxed/simple;
	bh=xnxlCZykJCYHZpW6Pv62IUASJiAHnturkR/ldKwLJPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFzpuZ7jItx3utR7aK/JtkyJMjRs4RhS+KUq+XVo7i77JHZYI71655cq2BdRPYtOhUvCpXZnVrdDWUyVdmPje1kmJLcLkNy+xClt+yM4o5uY4Vp2W13U9e/fdgFjbpNArWZPd+iO8ViWSdTnvzIMKtqOkprgBE4ctGftnNL2bZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB5bmSJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92062C4CEF1;
	Fri,  5 Sep 2025 21:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757107023;
	bh=xnxlCZykJCYHZpW6Pv62IUASJiAHnturkR/ldKwLJPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oB5bmSJnpM1BBLVHnm42/mBtWFfY7L3OEk4tcAi+cesGbhRvKlcsR2UI149fs3kl4
	 NlE/c+dS4QD0E7NYfuPU3LKYASqz/bVQDDPFNDXTi4PGIM73SiiVp+Gd8BatoeVUgM
	 9eN+alRstMfg2m2BIKMO10m3cFutfb4tqSskrGrNd0r/fPnOVZR6Xi4CU6u5VLD71K
	 JokUUhmS207xx5ciBD+oZzfbZcMPpcehVbcKXD8ctKFw+77UpznlXBP8HFIpQNssNe
	 P45JY2dWivng/Lh7hGDO432uXokjX15VKen4dJalUGiQSOfMfLqipsiy4SBhGKXmcT
	 GvxVXLbiyq68w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Chiu <chris.chiu@canonical.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: hda/realtek - Add new HP ZBook laptop with micmute led fixup
Date: Fri,  5 Sep 2025 17:17:00 -0400
Message-ID: <20250905211700.3421432-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052415-fang-botanist-0180@gregkh>
References: <2025052415-fang-botanist-0180@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Chiu <chris.chiu@canonical.com>

[ Upstream commit f709b78aecab519dbcefa9a6603b94ad18c553e3 ]

New HP ZBook with Realtek HDA codec ALC3247 needs the quirk
ALC236_FIXUP_HP_GPIO_LED to fix the micmute LED.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250520132101.120685-1-chris.chiu@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d4bc80780a1f9..b47820105ead4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10249,6 +10249,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e1d, "HP ZBook X Gli 16 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x1054, "ASUS G614FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.50.1


