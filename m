Return-Path: <stable+bounces-7182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C9681714E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3F2283583
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1151D15E;
	Mon, 18 Dec 2023 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p/Jn2MyD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D411D150;
	Mon, 18 Dec 2023 13:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD99C433C7;
	Mon, 18 Dec 2023 13:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907783;
	bh=4IJn61JuwPiZCoTTD+VF3dzzZ4bCO/YDRIc1sFpIlzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/Jn2MyDAip4HUympu3A2IafspmsIIdGXMF+8iWyesk6tRuJJvAXlUnpoIASo0gEC
	 QtYJq4dgB5UWEoQTdVX4jirx49skWTU2DFN5cFvGtmVbrEnzg73uPWfIwdyQPQQxVj
	 w5ppZNK0YRVT0f8JRuLRPwqVuALG6spzbSHtqY4o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Saarinen <jani.saarinen@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 045/106] ALSA: hda/hdmi: add force-connect quirk for NUC5CPYB
Date: Mon, 18 Dec 2023 14:50:59 +0100
Message-ID: <20231218135056.946182738@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

commit 3b1ff57e24a7bcd2e2a8426dd2013a80d1fa96eb upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_hdmi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1994,6 +1994,7 @@ static const struct snd_pci_quirk force_
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8715, "HP", 1),
 	SND_PCI_QUIRK(0x1462, 0xec94, "MS-7C94", 1),
+	SND_PCI_QUIRK(0x8086, 0x2060, "Intel NUC5CPYB", 1),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", 1),
 	{}
 };



