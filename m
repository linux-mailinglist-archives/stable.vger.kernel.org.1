Return-Path: <stable+bounces-82901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C4994F1F
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB12A2864F8
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AD01DF722;
	Tue,  8 Oct 2024 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bs5wYuOx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE631DEFE3;
	Tue,  8 Oct 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393809; cv=none; b=lavnFvm8iOPXU0kKBtliLNok7va4vZ00nlyJuzXHhJiaAZ8TatotsDlthnQehSbIvRvgdz5trzSTobl4JmsH3RAPydiJYjp1fcANbCZFEpRM5IS5LqMojL4c2meQYuYetPNv4+SK0wGPzM958fB4VuTa3qu2Bm5NCt60AYuf0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393809; c=relaxed/simple;
	bh=EtCnoGngnq4Uk51jnNScJDckquvZbYuWJzU46jb9g1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/wQYu1ZKzvVtfVxGGLIWoi3PbuH5KxG/yy4cOexPC4Xks5F2bm7WFNh/EZIQtL3QmhJzJJoOf034JE66RnCsg4R33yZq4FS8CWPtwW50QkgN35nFYdpQUsJIHh1hHOGKuLmohLqF4Tczkx9Irx7qi+02Yo60SyAr4cymRgVYmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bs5wYuOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539C0C4CEC7;
	Tue,  8 Oct 2024 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393808;
	bh=EtCnoGngnq4Uk51jnNScJDckquvZbYuWJzU46jb9g1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bs5wYuOxA09I1+c31Rmw7hOqikI95B1NA0Z4t/JZ4gzsaNqfvCoz4337PF/V7V7fn
	 LthnIdd56qEw+XR3y0gFPv+sfwvfYpnuS4fW+bZRfMmGT8fdqEWNziBafgsghVGU94
	 px2J1FmgVmAGn36vbKzSNIkHkDjU3ShRjat9qyPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abhishek Tamboli <abhishektamboli9@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 230/386] ALSA: hda/realtek: Add a quirk for HP Pavilion 15z-ec200
Date: Tue,  8 Oct 2024 14:07:55 +0200
Message-ID: <20241008115638.454574212@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

From: Abhishek Tamboli <abhishektamboli9@gmail.com>

commit d75dba49744478c32f6ce1c16b5f391c2d5cef5f upstream.

Add the quirk for HP Pavilion Gaming laptop 15z-ec200 for
enabling the mute led. The fix apply the ALC285_FIXUP_HP_MUTE_LED
quirk for this model.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219303
Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240930145300.4604-1-abhishektamboli9@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9923,6 +9923,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x88dd, "HP Pavilion 15z-ec200", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8902, "HP OMEN 16", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x890e, "HP 255 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8919, "HP Pavilion Aero Laptop 13-be0xxx", ALC287_FIXUP_HP_GPIO_LED),



