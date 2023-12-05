Return-Path: <stable+bounces-4180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96266804667
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CEF281178
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AC36FB8;
	Tue,  5 Dec 2023 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xf17h2Mq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A36FAF;
	Tue,  5 Dec 2023 03:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E26DC433C7;
	Tue,  5 Dec 2023 03:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746835;
	bh=PBxoe4FQcv/AFLSDZYTAJxDIj5CrMHmVmBZvdVAuZKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xf17h2MqrBAMb2MR2aqKOHDFGkbobfaIqFXzuYX1dpb7mx6dp002u7npqZb5fbVVw
	 v1x98ePnTI5j5BOdJ3HRWHGvL/EQh5K8wWMfyqAQpWLxbcpqLX+LVOg5u2ujyfwK4r
	 /vFYvhW1WTZ801IOc7i+85rWOzJBVeBO2nRjp/lc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 37/71] ALSA: hda: Disable power-save on KONTRON SinglePC
Date: Tue,  5 Dec 2023 12:16:35 +0900
Message-ID: <20231205031520.005079482@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
References: <20231205031517.859409664@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2371,6 +2371,8 @@ static struct snd_pci_quirk power_save_b
 	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugs.launchpad.net/bugs/1821663 */
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
+	/* KONTRON SinglePC may cause a stall at runtime resume */
+	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
 	{}
 };
 #endif /* CONFIG_PM */



