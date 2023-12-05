Return-Path: <stable+bounces-4025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F058045AF
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6454F1F21372
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42076FAF;
	Tue,  5 Dec 2023 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J2m9cQNR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748906AA0;
	Tue,  5 Dec 2023 03:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BF7C433C8;
	Tue,  5 Dec 2023 03:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746420;
	bh=IjjlSPklPqCcoz7aZNYmHbABt+zsr175VamGHI+nlQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2m9cQNRin1TxotPVw9IZEjN9+0XuWvBqwKv+TIv3SBcwCbrjf+Fgstut/ywHtAHt
	 qZN8aypmbuYklNThuhFpqiAKVQjh2+aevwdCYE8mZPpHL/SB/ZQLAZ32FvmubIL0Kw
	 u1v7r9aSqstfXE+MzbKEIXis1p9vc2yHzxZsZaI4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 018/134] ALSA: hda: Disable power-save on KONTRON SinglePC
Date: Tue,  5 Dec 2023 12:14:50 +0900
Message-ID: <20231205031536.492283960@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit a337c355719c42a6c5b67e985ad753590ed844fb upstream.

It's been reported that the runtime PM on KONTRON SinglePC (PCI SSID
1734:1232) caused a stall of playback after a bunch of invocations.
(FWIW, this looks like an timing issue, and the stall happens rather
on the controller side.)

As a workaround, disable the default power-save on this platform.

Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20231130151321.9813-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/hda_intel.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2218,6 +2218,8 @@ static const struct snd_pci_quirk power_
 	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugs.launchpad.net/bugs/1821663 */
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
+	/* KONTRON SinglePC may cause a stall at runtime resume */
+	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
 	{}
 };
 #endif /* CONFIG_PM */



