Return-Path: <stable+bounces-71532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D84964B94
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E063AB24E7A
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1261B29AD;
	Thu, 29 Aug 2024 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lQ4CScuV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14B195FD5
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948569; cv=none; b=CPIdjE2Hs33qk01XSRwFJbKhVDL/N6Wkjz38XfomizZ3BpKsx20BTaL1lL43E5Uzyx/OSLGr7DV11pIqgEJ7VEbmLTG7JbaicGItkHaws4G0i9q9hJmKw3733Zs4mUsxdeRGrkC/XaW8uxj0EUyKlF3daCKacpi9JPWrFf0A9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948569; c=relaxed/simple;
	bh=VDEt5mtkgvoq9tzZgrtj+Os0FNEY2rY+NKYNZgvQdOY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VKbOts0MajPtKYcpZmgokTGTKi/dgyFXVdzC6VncVad8jm4itGnLbgBe7cfzJGpTZUgRw3LZAzbbqcH/F6dXfKZ5yB3273Q7sI5cl6lVAb1pDDoPz3PINhdXY3EHE9k0qrlI9INg3Lyy7I7Fqz3AY3Gy+iXEmNLbOBEAfkDtfd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lQ4CScuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF86C4CEC1;
	Thu, 29 Aug 2024 16:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724948569;
	bh=VDEt5mtkgvoq9tzZgrtj+Os0FNEY2rY+NKYNZgvQdOY=;
	h=Subject:To:Cc:From:Date:From;
	b=lQ4CScuVgEIJpZoL7KUfQXnk3fGXyKVppkD9xggiDpnfBtiYFB54cQNZudTloYgg8
	 ZlKgY7ci58cbSiSpdJhLX2Kof9V4GujMIItaAXpfsFxBDsYowvWH7jHXzmtzd3mjmO
	 q11TUKDthDsN2YthMD+5jj9bM2w+KcvgkTpLIXA4=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy" failed to apply to 6.10-stable tree
To: neoelec@gmail.com,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 29 Aug 2024 18:22:45 +0200
Message-ID: <2024082945-closable-sighing-5d70@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 44ceabdec12f4e5938f5668c5a691aa3aac703d7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082945-closable-sighing-5d70@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

44ceabdec12f ("ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book3 Ultra")
dcfed708742c ("ALSA: hda/realtek: Implement sound init sequence for Samsung Galaxy Book3 Pro 360")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 44ceabdec12f4e5938f5668c5a691aa3aac703d7 Mon Sep 17 00:00:00 2001
From: YOUNGJIN JOO <neoelec@gmail.com>
Date: Sun, 25 Aug 2024 18:25:15 +0900
Subject: [PATCH] ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy
 Book3 Ultra

144d:c1cc requires the same workaround to enable the speaker amp
as other Samsung models with the ALC298 codec.

Signed-off-by: YOUNGJIN JOO <neoelec@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240825092515.28728-1-neoelec@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b5cc3417138c..c04eac6a5064 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10540,6 +10540,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xca03, "Samsung Galaxy Book2 Pro 360 (NP930QED)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc868, "Samsung Galaxy Book2 Pro (NP930XED)", ALC298_FIXUP_SAMSUNG_AMP),
 	SND_PCI_QUIRK(0x144d, 0xc1ca, "Samsung Galaxy Book3 Pro 360 (NP960QFG-KB1US)", ALC298_FIXUP_SAMSUNG_AMP2),
+	SND_PCI_QUIRK(0x144d, 0xc1cc, "Samsung Galaxy Book3 Ultra (NT960XFH-XD92G))", ALC298_FIXUP_SAMSUNG_AMP2),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),


