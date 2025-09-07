Return-Path: <stable+bounces-178100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EEB47D40
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5650B17BF6B
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD5329ACC6;
	Sun,  7 Sep 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZctN+tms"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C21F09A5;
	Sun,  7 Sep 2025 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757275763; cv=none; b=nXa7Z1ekmXzELSHxFgL7ed2u/BOJwfHi8IVu5isHYi8D+uqdaRgvulvYuGKrc/i5iso343U3hhGBn7DIIIsHq4Hql4MVujvinnjDhY0gmbKgEhx5+FRgxrUQrGWNe/e4XC20OIdACCfuXUWOT3XshcPHYtOFMKTDhRr9MpIb0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757275763; c=relaxed/simple;
	bh=NqO1AYCPSLpBD0ma8XrARYVRu4rvqsmcXctWwwKz18I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4u+2NvvEJRFUDEO0mBABmyICsdgK9sc+Jm2sIZyVvD+wa0HxhwdIhm36OHT2c4IGzGcHrDupbjkNb2/nxPgXBlq0SO3oq7335csDCBN4xq7nEfFMmtTJ8nMENWkagviVSLTMzpdILf0c+MOalctpOPbIhAlWeWuDD0cAAwEZ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZctN+tms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35835C4CEF0;
	Sun,  7 Sep 2025 20:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757275763;
	bh=NqO1AYCPSLpBD0ma8XrARYVRu4rvqsmcXctWwwKz18I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZctN+tmsQgC9kxp/Klfel8MLJ5hIWCBtwYXXFhaXnh+2tREtbub75x6EuqkmkBnTy
	 cWbZ9LTlrXgdr75sqLMhiOk3wfLVhiB4w9E2cb1kboPqjmpCCL+DwgSgl6KtjC1KDD
	 K13mKeiKRtH+l156KojQDRX/vQr6LJlP4ArB2otg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 45/52] ALSA: hda/hdmi: Add pin fix for another HP EliteDesk 800 G4 model
Date: Sun,  7 Sep 2025 21:58:05 +0200
Message-ID: <20250907195603.272192697@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195601.957051083@linuxfoundation.org>
References: <20250907195601.957051083@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit bcd6659d4911c528381531472a0cefbd4003e29e upstream.

It was reported that HP EliteDesk 800 G4 DM 65W (SSID 103c:845a) needs
the similar quirk for enabling HDMI outputs, too.  This patch adds the
corresponding quirk entry.

Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250901115009.27498-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_hdmi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1965,6 +1965,7 @@ static int hdmi_add_cvt(struct hda_codec
 static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x103c, 0x83e2, "HP EliteDesk 800 G4", 1),
 	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
+	SND_PCI_QUIRK(0x103c, 0x845a, "HP EliteDesk 800 G4 DM 65W", 1),
 	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),



