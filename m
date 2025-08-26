Return-Path: <stable+bounces-174900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5376BB3658B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3758C8E5941
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F412AD04;
	Tue, 26 Aug 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vg7UYk2c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B731F4CA9;
	Tue, 26 Aug 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215613; cv=none; b=SdQTsh5LxVRHnSIJnFanJ+s5jQrPNuEMhGjm5/PHXb1JIn74Tc7HFQ37FRVFwDAflhSpxMlF5Kr/7tRocL3nlc/j7OUW6oMKmFN83+aFD6I9cFJhbGlYci/6EjyoznVuDgB4aX+2o4VwgvRlYNiOAI0Nr0+A6k0OIOYoG3BBfdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215613; c=relaxed/simple;
	bh=NNHMUlkd8IdHmDjHcqjEpmOQHXaJ+Wt+ScVu1OTYdNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EG8HsIMzAY/ygTv+Xw90UHABTXot5BZck6r8SeLwOZLqsZvCL6rh7Md4WsUlUO7c+SKTH6kiTJ1uf07in67nKpiXtscxBqm+Koy7K8kT8n3L/w2ni5PP/44pXfxZeQxNJ0ZeOk7j5Hx/3LdKWyk8ePp3utTeAMM0dQPigbV/FDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vg7UYk2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1891C4CEF1;
	Tue, 26 Aug 2025 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215613;
	bh=NNHMUlkd8IdHmDjHcqjEpmOQHXaJ+Wt+ScVu1OTYdNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vg7UYk2cGsltdaZ9EteMbDSh+b9rLpaMOxE78j4c88Xk7VUmqrWlKMonPXEUqJAsx
	 IL0wuvT3RGPw1dZvE1xA4c/zW7RcrtDJTP9AKjkFHhPB/CS1S7kg++3BXy5Ov4K36P
	 2b1dVX2comqeko0N5eM8lQ3eXhOQFJv8QA4VvwS8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dawid Rezler <dawidrezler.patches@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 092/644] ALSA: hda/realtek - Add mute LED support for HP Pavilion 15-eg0xxx
Date: Tue, 26 Aug 2025 13:03:03 +0200
Message-ID: <20250826110948.782693124@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dawid Rezler <dawidrezler.patches@gmail.com>

commit 9744ede7099e8a69c04aa23fbea44c15bc390c04 upstream.

The mute LED on the HP Pavilion Laptop 15-eg0xxx,
which uses the ALC287 codec, didn't work.
This patch fixes the issue by enabling the ALC287_FIXUP_HP_GPIO_LED quirk.

Tested on a physical device, the LED now works as intended.

Signed-off-by: Dawid Rezler <dawidrezler.patches@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250720154907.80815-2-dawidrezler.patches@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9350,6 +9350,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87cc, "HP Pavilion 15-eg0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87df, "HP ProBook 430 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),



