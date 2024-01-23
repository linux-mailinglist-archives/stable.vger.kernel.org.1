Return-Path: <stable+bounces-14272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11515838056
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E463DB267BA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDC2657B9;
	Tue, 23 Jan 2024 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DNNEsD09"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79A4E1AD;
	Tue, 23 Jan 2024 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971623; cv=none; b=ZPRg6l6cOfZ5Dp9Ec0IRMG2Rouj7RYiW5tdbED1EeFH93R0jJWMXHy/eRRBS8RUf/XN4PbAVQwEP83rIdoUFUjyRIPV5DD6jFwpKTRjn9cw9a+XECRcOkjMjPaWJ48ppbdsGF03/aYMSNXj2vMBIHrfZKWOi4OHGOAUhG0El8Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971623; c=relaxed/simple;
	bh=HUqte7NVpcjRd9R9taCA/2B+KpS0bhmzwT2UUi50TGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtxssOn0JnVU9OfzgDFO4qD9DAOhH+ExUGzkZZuHCY3V/ZY27UiPN1HVhAQDGAGF4BHUvZ6VwbhsT8gUiHk95pqfPfHGQE/FIi0cujOtFBeR4zku9LWcS4e4mbW+C+Y9UDyaNS4eeamIlegeHyEjRLRxEkM48Yp6RC/cSMVJLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNNEsD09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F342C433C7;
	Tue, 23 Jan 2024 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971623;
	bh=HUqte7NVpcjRd9R9taCA/2B+KpS0bhmzwT2UUi50TGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNNEsD09MzVDRVSO1UFyanDJtvCPBa7dlAmLs3mkdPdBDv1aE58AIk2QLFlVAqFUq
	 0wu43TxZjBeKH9VLJ6/yAcXC67oeL2J7+CDgn+I6Yeus3+1NVlE3VVV4EJLtKB66N5
	 L03IGqJCyjzeQJMT2q+hWaNL662Brfiwd0l6GS7I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?=C3=87a=C4=9Fhan=20Demir?= <caghandemir@marun.edu.tr>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 280/417] ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq2xxx
Date: Mon, 22 Jan 2024 15:57:28 -0800
Message-ID: <20240122235801.545592045@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Çağhan Demir <caghandemir@marun.edu.tr>

commit bc7863d18677df66b2c7a0e172c91296ff380f11 upstream.

This HP Laptop uses ALC236 codec with COEF 0x07 idx 1 controlling
the mute LED. This patch enables the already existing quirk for
this device.

Signed-off-by: Çağhan Demir <caghandemir@marun.edu.tr>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240115172303.4718-1-caghandemir@marun.edu.tr
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9626,6 +9626,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f6, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
+	SND_PCI_QUIRK(0x103c, 0x87fe, "HP Laptop 15s-fq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8805, "HP ProBook 650 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),



