Return-Path: <stable+bounces-123954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C64A5C859
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212BA3B8EC0
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A1125E820;
	Tue, 11 Mar 2025 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wyaf9BXY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048C255E37;
	Tue, 11 Mar 2025 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707441; cv=none; b=XEfCTiBl79EthRXMc4zaO/1sdxk3C3a6sKRHiVsQlLcF12YRI4Xq+w8ZXjngGbHJxHQq9lYuZEx5dTw8cieoVeFyh9qvpL5Kb8bYl8rh3m/BTAMCOuPUKt6tB6ldxuhea6y3UdmvQFu2QEi0XFO9xR2z0mqDTMB8S4X+1blKGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707441; c=relaxed/simple;
	bh=NnqodH5BUV9T96sCQJ5EJ+io0jBphEtsWXsjR87UPb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiqfid8b7jwhaHQA6zwjM430iqxNTdSQUgSC3LN58bnXh6qeJwSdE8uK+omN5NSsXbJpHoRcWkjvyRxOchBDnFT1Aryjv7m0aA9Aa9PpFmRD4q11W21bVhneGMcjeG706cE05E4n798nfzAksESEdV4tyV7AHmGsE9KhHkYzJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wyaf9BXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270DCC4CEE9;
	Tue, 11 Mar 2025 15:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741707441;
	bh=NnqodH5BUV9T96sCQJ5EJ+io0jBphEtsWXsjR87UPb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wyaf9BXYj9OTARXKDpvzWQ2sdNSzPomnCa+5mV7Cp5HWbbDoxrv9t4WGBZ+mTAfBD
	 NniaWsYOLLCg44Xw17IbUHW2UhMdJYk6pqcjOfYHgDLgtVC1q8hXsI8TRXUY1dbyr2
	 NCXyqt/kOI5KkqlQZwIU5orPR1w97bFB5bNX4Ezk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hoku Ishibe <me@hokuishi.be>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 391/462] ALSA: hda: intel: Add Dell ALC3271 to power_save denylist
Date: Tue, 11 Mar 2025 16:00:57 +0100
Message-ID: <20250311145813.784614105@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hoku Ishibe <me@hokuishi.be>

commit 1ee5aa765c22a0577ec552d460bf2035300b4b51 upstream.

Dell XPS 13 7390 with the Realtek ALC3271 codec experiences
persistent humming noise when the power_save mode is enabled.
This issue occurs when the codec enters power saving mode,
leading to unwanted noise from the speakers.

This patch adds the affected model (PCI ID 0x1028:0x0962) to the
power_save denylist to ensure power_save is disabled by default,
preventing power-off related noise issues.

Steps to Reproduce
1. Boot the system with `snd_hda_intel` loaded.
2. Verify that `power_save` mode is enabled:
```sh
cat /sys/module/snd_hda_intel/parameters/power_save
````
output: 10 (default power save timeout)
3. Wait for the power save timeout
4. Observe a persistent humming noise from the speakers
5. Disable `power_save` manually:
```sh
echo 0 | sudo tee /sys/module/snd_hda_intel/parameters/power_save
````
6. Confirm that the noise disappears immediately.

This issue has been observed on my system, and this patch
successfully eliminates the unwanted noise. If other users
experience similar issues, additional reports would be helpful.

Signed-off-by: Hoku Ishibe <me@hokuishi.be>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250224020517.51035-1-me@hokuishi.be
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/hda_intel.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2280,6 +2280,8 @@ static const struct snd_pci_quirk power_
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
 	/* KONTRON SinglePC may cause a stall at runtime resume */
 	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
+	/* Dell ALC3271 */
+	SND_PCI_QUIRK(0x1028, 0x0962, "Dell ALC3271", 0),
 	{}
 };
 #endif /* CONFIG_PM */



