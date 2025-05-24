Return-Path: <stable+bounces-146242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA52BAC302B
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA28189CB27
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEC31DE3C4;
	Sat, 24 May 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jah2Dz4Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7BE18787A
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748101639; cv=none; b=n81AH1qz7jeC+ksFbW4C3GT+cOQgm+fT9ehb5koyY/kEbCm9J0aFyJoTY+vkCtl715TFebDaBC067djbyFDd9Gpd6bc491H5b4f0vPK/rzPUAHG1Qp98pvMN1bYJB0Gd1Epc2w53O2TZ8hNlxHipe+QqkDj6c7SMQuhrh/TURe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748101639; c=relaxed/simple;
	bh=Puhx5YR18JwczzayYahWfqIEjdXqwOG3GnuwyCpPXbM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZV1lR6VC9KhKSjP+jh0UFtWG7BVkSUqFo07dxCD95r/s4EwZv2ki9ljwWp6wAHEwraBDuOOWbM2xzSUzi1bdNM5i+JabjBA00X6slU8ylJrtfiYZTxCd96e3YgpoR/k3HPX8IJqzOmmKdn9T/vXihKAj1om/x2z5FrxOTBBFwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jah2Dz4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A412C4CEE4;
	Sat, 24 May 2025 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748101637;
	bh=Puhx5YR18JwczzayYahWfqIEjdXqwOG3GnuwyCpPXbM=;
	h=Subject:To:Cc:From:Date:From;
	b=Jah2Dz4Ya4EKjIGqKL6aKnGHE26h5+DdkxXdQg+GtDl2FF7/h9FMjgYdStNJpmYMz
	 pG2TuEpuXiS0DO2Y+5gAkhRyEUC6uDuGqWc9lNw544Tx3zkbKWFSd4L7M4loNFXmiQ
	 9iPGiXwJmylFdhdx1OlHAuwnHsRpfniY9UjNmkkA=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek - Add new HP ZBook laptop with micmute led" failed to apply to 6.14-stable tree
To: chris.chiu@canonical.com,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:47:14 +0200
Message-ID: <2025052414-rubbed-footing-28ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x f709b78aecab519dbcefa9a6603b94ad18c553e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052414-rubbed-footing-28ca@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f709b78aecab519dbcefa9a6603b94ad18c553e3 Mon Sep 17 00:00:00 2001
From: Chris Chiu <chris.chiu@canonical.com>
Date: Tue, 20 May 2025 21:21:01 +0800
Subject: [PATCH] ALSA: hda/realtek - Add new HP ZBook laptop with micmute led
 fixup

New HP ZBook with Realtek HDA codec ALC3247 needs the quirk
ALC236_FIXUP_HP_GPIO_LED to fix the micmute LED.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250520132101.120685-1-chris.chiu@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 69788dd9a1ec..20ab1fb2195f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10885,6 +10885,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
 	SND_PCI_QUIRK(0x103c, 0x8e1b, "HP EliteBook G12", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
 	SND_PCI_QUIRK(0x103c, 0x8e1c, "HP EliteBook G12", ALC245_FIXUP_HP_ZBOOK_FIREFLY_G12A),
+	SND_PCI_QUIRK(0x103c, 0x8e1d, "HP ZBook X Gli 16 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e2c, "HP EliteBook 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e36, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e37, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),


