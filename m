Return-Path: <stable+bounces-119056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BEA42408
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C3917C981
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749A578F5F;
	Mon, 24 Feb 2025 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="clJO6Mx+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D1155308;
	Mon, 24 Feb 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408171; cv=none; b=Kn/6QbmrhaQCo3ygPiZIuOQbnKx7EMKpmXUCU0R0GVOKD8ApB9zcQo4bRXtdjh52Gbl102TLiDcR+MHVB2w5S87bRa6bQHRqdcSHRhY9Lb90gBzNgRybKdYuFHBLyU3gKpZtzb/Mx5RQnet18bpkJIDkZmE1VDJu5+xXdJOnzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408171; c=relaxed/simple;
	bh=IJgoU+1+QjzFMPHbw8+5yOAV5LU9ZOJAl0ixZilisHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXETOeLMsv36KknO69zzuFzIh9jFP1xybqMojWKfLczfoCHtcIPF5B5qDh+2ro0xxwoz2ECBSR0KtCpbwu2+MhzsNPoxyh4jH3kW1IkQ9pgHsGlv0+mt5P2DAczvCnmLQkF/8jx0zjlckA7UruHTSnKOe+ZaOmqFMeuf4RBeYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=clJO6Mx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4A9C4CED6;
	Mon, 24 Feb 2025 14:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408170;
	bh=IJgoU+1+QjzFMPHbw8+5yOAV5LU9ZOJAl0ixZilisHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=clJO6Mx+FQoA4i43D5lbXKzw9XUTtAJ4I54u7QnL7cUZRIksLdSV5XliimaVKg5vr
	 uJrxxIVM5lGcfPlIkSRKmnGA60nLqdtNl7Srkg39wLhQ16JdioU3p1Iw496bP3edCd
	 1Sm4XeamD1ZVGCQq1E5L94Qu0EyjB5FFxbLT9KlA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Veness <john-linux@pelago.org.uk>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 120/140] ALSA: hda/conexant: Add quirk for HP ProBook 450 G4 mute LED
Date: Mon, 24 Feb 2025 15:35:19 +0100
Message-ID: <20250224142607.732453929@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
References: <20250224142602.998423469@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Veness <john-linux@pelago.org.uk>

commit 6d1f86610f23b0bc334d6506a186f21a98f51392 upstream.

Allows the LED on the dedicated mute button on the HP ProBook 450 G4
laptop to change colour correctly.

Signed-off-by: John Veness <john-linux@pelago.org.uk>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/2fb55d48-6991-4a42-b591-4c78f2fad8d7@pelago.org.uk
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_conexant.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1084,6 +1084,7 @@ static const struct hda_quirk cxt5066_fi
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x822e, "HP ProBook 440 G4", CXT_FIXUP_MUTE_LED_GPIO),
+	SND_PCI_QUIRK(0x103c, 0x8231, "HP ProBook 450 G4", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),



