Return-Path: <stable+bounces-101545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B559EECD5
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C6C284675
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C8217F34;
	Thu, 12 Dec 2024 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cdYOqO+J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A26F2FE;
	Thu, 12 Dec 2024 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017932; cv=none; b=WXhGS2lnauDW+JM/apV+ral3aWsC6I25L+fxfe89tlNCw+D0b+PNKKiEBhS0vAddG5hQAjVORc9AXmkm+yR6BkdJIISdU+K+7zaHM7RByG+Suog+ixTu4+Iv46UjkFExgd1kGxx756bePuZpq28NjjIoUPwnqIysXFsUsGcuJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017932; c=relaxed/simple;
	bh=G1X4aMz4gtAKz7xfWD3BvZ1k+OUSaYdXi3mRWBw2Ke0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1kD6KpKD9xOandZtGjyofvmU6b4hJfKqNsBMQvwYq8PeAt1jRAktQ05Zn3WmeEW8tL/aSnGCpkp8OsdScLYYYwQ0wBMoFHEk9Xk87AXgKQDZH8S0/bo05Kq1ud9XVSP9Rge16GwfHCr7LqQDy/MpGGET270ktRt4IkjRgoDPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cdYOqO+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E49C4CECE;
	Thu, 12 Dec 2024 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017932;
	bh=G1X4aMz4gtAKz7xfWD3BvZ1k+OUSaYdXi3mRWBw2Ke0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdYOqO+JFvOkYrJmfTQ5w/f1Xhrrib1HMNQWwlIfeKzvLbHbcdpf1E/xqTYn5Bj5T
	 oKAJneV/uCo4QG7hDJa6osvNzjEX6GWzhaTbXJf1dgk7LR16+60fNVxX1NRUsgH5jh
	 /J5PUFy/5P/rNW9Z7y/8CINEduWfUTurCX5cvE5A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sahas Leelodharry <sahas.leelodharry@mail.mcgill.ca>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 151/356] ALSA: hda/realtek: Add support for Samsung Galaxy Book3 360 (NP730QFG)
Date: Thu, 12 Dec 2024 15:57:50 +0100
Message-ID: <20241212144250.606508521@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

From: Sahas Leelodharry <sahas.leelodharry@mail.mcgill.ca>

commit e2974a220594c06f536e65dfd7b2447e0e83a1cb upstream.

Fixes the 3.5mm headphone jack on the Samsung Galaxy Book 3 360
NP730QFG laptop.
Unlike the other Galaxy Book3 series devices, this device only needs
the ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET quirk.
Verified changes on the device and compared with codec state in Windows.

[ white-space fixes by tiwai ]

Signed-off-by: Sahas Leelodharry <sahas.leelodharry@mail.mcgill.ca>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/QB1PR01MB40047D4CC1282DB7F1333124CC352@QB1PR01MB4004.CANPRD01.PROD.OUTLOOK.COM
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10180,6 +10180,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x144d, 0xc830, "Samsung Galaxy Book Ion (NT950XCJ-X716A)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc832, "Samsung Galaxy Book Flex Alpha (NP730QCJ)", ALC256_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xca03, "Samsung Galaxy Book2 Pro 360 (NP930QED)", ALC298_FIXUP_SAMSUNG_AMP),
+	SND_PCI_QUIRK(0x144d, 0xca06, "Samsung Galaxy Book3 360 (NP730QFG)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc868, "Samsung Galaxy Book2 Pro (NP930XED)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),



