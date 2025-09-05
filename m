Return-Path: <stable+bounces-177907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98BEB46750
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 01:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928863AC347
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 23:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4931E5B7C;
	Fri,  5 Sep 2025 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRx+1Q9P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB70BA4A
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116117; cv=none; b=FIg6nO80Kyf2OODx/L8Sqp2jb81tjj5BxIfUq09QBwIHUwUAYOIV+RcvmLS5eq4txap2ewMHdSvgV+njJLJNB5fQpkTWvN096XTaQXfYzHAbBWHbEropC86IwX/OVntIhewPdRcJGMbxZR3j3ijWETRHKH9Z2Lxl96jEAgnRFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116117; c=relaxed/simple;
	bh=Uedx31EWjLAew3rOSoSpP4sN1oSxKxuFJpI9mXSNdw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WS+28meeIB3DUeQ82qWIx3zDZqyxiyJSN4g/jr57ZABWjhXc5dsCfk1wBZe3omRBAtMdkaAGRvpkZjvvhcxKq9qAP6FrnQPclWpmmsgMqRoo0hu2j6015gzHQBAsIhOtY1C6I8WBkHdKz15Ha+3DRmH1xjHdG9Nj8HLe5gwiOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRx+1Q9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD92EC4CEF1;
	Fri,  5 Sep 2025 23:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757116116;
	bh=Uedx31EWjLAew3rOSoSpP4sN1oSxKxuFJpI9mXSNdw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRx+1Q9P3pwMFzzrhwRKiFb5LGVqpLmbWJpH83ft7Q9tHvF3dkb7LgPsMDnPliiIc
	 focT7PthxnyfP1qdPtBbErjkge58V3uYpe2dct1q53zAahEcKqzBnN/jWMM5vH50yx
	 sz/nsCrpzzZulL5r9A0UUtr+X7jvssOSt7CJwu/RbNyUrxQNxb4Kaaa0Oq69iqD+Mx
	 VmNIkrPSqxnug+d/Xn5Q+pXJPVKzvuyUP043Ta9CNHrOAFLFEDLTO5nul6AUQizpzT
	 K5/SzxyGw2jzssxmtV0MQR1K6G2E/pF01XMM5P5FhcewE2iXP78a4Jt4fQS1lIluxM
	 umP6+dbucDm4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Chiu <chris.chiu@canonical.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: hda/realtek - Add new HP ZBook laptop with micmute led fixup
Date: Fri,  5 Sep 2025 19:48:33 -0400
Message-ID: <20250905234833.3571460-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052421-document-satirical-8e58@gregkh>
References: <2025052421-document-satirical-8e58@gregkh>
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
index a78ca3f97967a..84dde97424080 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9322,6 +9322,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x89aa, "HP EliteBook 630 G9", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e1d, "HP ZBook X Gli 16 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.50.1


