Return-Path: <stable+bounces-44881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3698C54CB
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA0A1C237A7
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E78C6D1A0;
	Tue, 14 May 2024 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pu5GFMdF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C76E615;
	Tue, 14 May 2024 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687448; cv=none; b=Uf9qNbJBR3J3YCNxCltlwa2XdLyvddt3dAU/OgijmmtXd45ARRxdH/1blPXgSh8BOy2MVFQCaz6gEcO497bxHMZkSWus4RSiq8fy+8Uz1y6+qYDjwW04LzVkVQuvh8JCnd4mCeZ1QY0kgnoN/VUhYrFF0kT4xX3jAEtAOSC05bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687448; c=relaxed/simple;
	bh=ypwNzl2IWmKrmgllOHd4Kb6GlWvtCtcJ2MRQ8cXd6Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7t1nD5+q4yaE2kjN1F2Z0/w0r3c9NjvuCpzF5VookJ6Verx8MfF9O0pS7ct+nTACUKOK96BeYiw/XnLJVfEpFcey0NdcfjkLLDvK7Jw4SuPNdp/27hg73Txd0qEg3WORp82nEfluq3Nd4a9toz7ymOp+o4z4dtPaUpSlZtAQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pu5GFMdF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB486C2BD10;
	Tue, 14 May 2024 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687448;
	bh=ypwNzl2IWmKrmgllOHd4Kb6GlWvtCtcJ2MRQ8cXd6Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pu5GFMdFSjrxzLIkrsHcsD/o8HeV1wWze2Z5nkS+TUTv/L3w3+czW0ogKbqcGgSSn
	 rXVeLLsd7Cbw6YfV9uUtvA9yBGXcvRc53RPWw5tUVJcz84vIpAypewhOUwwqSybMDp
	 7NhNDr5pm9HbvN04FMrbMp4M7yNxpzldr43bz7OU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aman Dhoot <amandhoot12@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 100/111] ALSA: hda/realtek: Fix mute led of HP Laptop 15-da3001TU
Date: Tue, 14 May 2024 12:20:38 +0200
Message-ID: <20240514101000.932525805@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
References: <20240514100957.114746054@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aman Dhoot <amandhoot12@gmail.com>

commit 2d5af3ab9e6f1cf1468b2a5221b5c1f7f46c3333 upstream.

This patch simply add SND_PCI_QUIRK for HP Laptop 15-da3001TU to fixed
mute led of laptop.

Signed-off-by: Aman Dhoot <amandhoot12@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/CAMTp=B+3NG65Z684xMwHqdXDJhY+DJK-kuSw4adn6xwnG+b5JA@mail.gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9066,6 +9066,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x86c1, "HP Laptop 15-da3001TU", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENVY_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x86e7, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x86e8, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),



