Return-Path: <stable+bounces-61628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 240E193C53A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53B51F25680
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B815219AD91;
	Thu, 25 Jul 2024 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ysLRpR6b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B25FC19;
	Thu, 25 Jul 2024 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918925; cv=none; b=uOeN28AoSo36KpCyKf1ES0qByfgfh0FnorgVWrRNW/O4XwLz8j9U84Kdia42igkO+XAatHC8jN4Rqa5+/HNSsVe3IRijqKQwGDuBKrESB0odsUQVHgoIC4fQa3V8LhcO9zptMJGpzvLp/clE40Li1CRHjP1ntwMcPGoznpb2HEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918925; c=relaxed/simple;
	bh=DT8wOBJ+v9hdcNpNb9QUqX1GQggPkR58VXsPPqgePtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlY+tnLUaIuILasVAQDzp11ri65UuGiwk428v8cucGjIcazhLPPtcnIeUoJfewoxUzgkgub0szoHZXlqwKlzzp/5jQA4CC6AnckZpgMfrhii1bNBYNuofnZQGNFzKqlw0tEsP0WmbBAxKhTz+918/qQ9rzGc3Rh87fMTNCZvllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ysLRpR6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F011DC116B1;
	Thu, 25 Jul 2024 14:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721918925;
	bh=DT8wOBJ+v9hdcNpNb9QUqX1GQggPkR58VXsPPqgePtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ysLRpR6bpklR20wwwReZYcaXWo+nlfVMdP/q7qPWnsuVbRAtAJio2DLS6ohrV9Mrb
	 rLNXcCkcueqR26j4AYOc6+ClQZcKeTt3u1xYqpGyZPV6CQWC2p/ayxupw35NDTyrql
	 3lSE+3nI5QGc5eAduYd+ix3uvqD1EBO6/fkXk4U4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aivaz Latypov <reichaivaz@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 31/59] ALSA: hda/relatek: Enable Mute LED on HP Laptop 15-gw0xxx
Date: Thu, 25 Jul 2024 16:37:21 +0200
Message-ID: <20240725142734.442147597@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142733.262322603@linuxfoundation.org>
References: <20240725142733.262322603@linuxfoundation.org>
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

From: Aivaz Latypov <reichaivaz@gmail.com>

[ Upstream commit 1d091a98c399c17d0571fa1d91a7123a698446e4 ]

This HP Laptop uses ALC236 codec with COEF 0x07 controlling
the mute LED. Enable existing quirk for this device.

Signed-off-by: Aivaz Latypov <reichaivaz@gmail.com>
Link: https://patch.msgid.link/20240625081217.1049-1-reichaivaz@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fdbc76eaf233e..5cc158c56d43e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9096,6 +9096,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f1, "HP ProBook 630 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.43.0




