Return-Path: <stable+bounces-9878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F53B8255D3
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6FD1C21B7A
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CA518EB7;
	Fri,  5 Jan 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BZuCbFOq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED82D7B0;
	Fri,  5 Jan 2024 14:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA1AC433C8;
	Fri,  5 Jan 2024 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465779;
	bh=RKgYMsrELmm/AOHZ2lzCJ4uNKGZyEvFE3AtzATYwtrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BZuCbFOq4GAKn0gTZW3VXYO19Sp31epHqCJJ80lnoRtvqBMC45GbuMelZ/YVSVIvo
	 QI7e5L5otvid+bQyO8sNA0DAlbvFKbCaGlgQ3L9BtK5q+0WNzFaoJptHSNcHGq1tGE
	 fK2yQq3rQGmG9LUYtinA3y8auzjFe73I9ALUypQg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Saarinen <jani.saarinen@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 23/47] ALSA: hda/hdmi: add force-connect quirk for NUC5CPYB
Date: Fri,  5 Jan 2024 15:39:10 +0100
Message-ID: <20240105143816.420260585@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105143815.541462991@linuxfoundation.org>
References: <20240105143815.541462991@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 3b1ff57e24a7bcd2e2a8426dd2013a80d1fa96eb ]

Add one more older NUC model that requires quirk to force all pins to be
connected. The display codec pins are not registered properly without
the force-connect quirk. The codec will report only one pin as having
external connectivity, but i915 finds all three connectors on the
system, so the two drivers are not in sync.

Issue found with DRM igt-gpu-tools test kms_hdmi_inject@inject-audio.

Link: https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/issues/3
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Jani Saarinen <jani.saarinen@intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20231208132127.2438067-2-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index a0de66674faaf..ff81e6051773a 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1825,6 +1825,7 @@ static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x1043, 0x86ae, "ASUS", 1),  /* Z170 PRO */
 	SND_PCI_QUIRK(0x1043, 0x86c7, "ASUS", 1),  /* Z170M PLUS */
 	SND_PCI_QUIRK(0x1462, 0xec94, "MS-7C94", 1),
+	SND_PCI_QUIRK(0x8086, 0x2060, "Intel NUC5CPYB", 1),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", 1),
 	{}
 };
-- 
2.43.0




