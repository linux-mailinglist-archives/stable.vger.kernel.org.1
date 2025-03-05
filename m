Return-Path: <stable+bounces-120850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1397A508B1
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034D71893B9B
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4E252915;
	Wed,  5 Mar 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wUg//yH4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E67252907;
	Wed,  5 Mar 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198153; cv=none; b=iT92BzyoF1XHeGXC0nzrpUNP9L4EbFOvIMD7w9zoJBKckjK/vCWSPEDCRly48rV9G6APiDJkdtLIfKG7x0KUDJn+qbMnPXNRtFPLKay+PQVH0EwNGEhIqr2S6OtTusfGdL0hmtqMFkCBP8hAvjHnPJnrmCbvmMHALIehs7S9fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198153; c=relaxed/simple;
	bh=sBl4dMOskKfvC06smnjw6DoDwQkuOIpT4qx8IG1qPo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QT7lH/tqIWHXDZm1iug30IcWTJH4t8+u7jQEXQDtFSS3Yy7lcNCzVXQwgbMuYpR+CURXEDniPw4dnqtoGgz1vIExrmXf59ThNxTKCHLFvBW3lWAguIpCapHyFhfHOqy5+PRbY+k2/ukQla4tQnDzK9v1TniBZ8i2aND9BZRlFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wUg//yH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B03C4CED1;
	Wed,  5 Mar 2025 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198153;
	bh=sBl4dMOskKfvC06smnjw6DoDwQkuOIpT4qx8IG1qPo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wUg//yH4yxq0lLGJYZqm7q9orJtAX/+h6nDAGqmc2qRuMgrIRg/6kiq+mHx3oy/x+
	 IY5slZCOU8lVSudCO24mPF4SBx1iubN48fWSPK95MW3EF47BuvOvlHB7cFN79jL8um
	 6JAZv6gTQz9XjqSVhikuhY7Pv+gUyP8/afkwG6zg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 051/150] ALSA: hda/realtek: Fix wrong mic setup for ASUS VivoBook 15
Date: Wed,  5 Mar 2025 18:48:00 +0100
Message-ID: <20250305174505.874275375@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174503.801402104@linuxfoundation.org>
References: <20250305174503.801402104@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 9e7c6779e3530bbdd465214afcd13f19c33e51a2 ]

ASUS VivoBook 15 with SSID 1043:1460 took an incorrect quirk via the
pin pattern matching for ASUS (ALC256_FIXUP_ASUS_MIC), resulting in
the two built-in mic pins (0x13 and 0x1b).  This had worked without
problems casually in the past because the right pin (0x1b) was picked
up as the primary device.  But since we fixed the pin enumeration for
other bugs, the bogus one (0x13) is picked up as the primary device,
hence the bug surfaced now.

For addressing the regression, this patch explicitly specifies the
quirk entry with ALC256_FIXUP_ASUS_MIC_NO_PRESENCE, which sets up only
the headset mic pin.

Fixes: 3b4309546b48 ("ALSA: hda: Fix headset detection failure due to unstable sort")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219807
Link: https://patch.msgid.link/20250225154540.13543-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9bf99fe6cd34d..63e22f5845f82 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10564,6 +10564,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZV/PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1460, "Asus VivoBook 15", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1463, "Asus GA402X/GA402N", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1473, "ASUS GU604VI/VC/VE/VG/VJ/VQ/VU/VV/VY/VZ", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1483, "ASUS GU603VQ/VU/VV/VJ/VI", ALC285_FIXUP_ASUS_HEADSET_MIC),
-- 
2.39.5




