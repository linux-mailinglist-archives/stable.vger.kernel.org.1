Return-Path: <stable+bounces-91327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 178449BED7D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39FC1F251B7
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA11E766F;
	Wed,  6 Nov 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nTkArMht"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C09D1E1036;
	Wed,  6 Nov 2024 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898409; cv=none; b=lkvYp8vaAragDuBixMrGDpK0SQVulXSUfver7Yi1yzvagbKgHwqiN9McE43L199N6EHR7cke5Fky3YzC6ADQM8l1ZLb2EA/HIYUI5bsXRH29SRTdItJbV4RUS/Jh1uigyN8Kxwgl1xYeWn/GYLQLhs3cSQ/EyIvSc6iErQ63sdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898409; c=relaxed/simple;
	bh=Wye2Bg0tzn1shVnSXGs7RFIi0JaBoXSOTWIVOEqkFMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0ti2eFXJ79bZx5ocxKdGLAW9aQmFigo0XdTP5CeUaCsdIe0LNcCFSvua50J+QD9hGXwB5PXeEnFnkaqGAQisbNXsJI5YZoKqrwDYbC41smT0nQVA/sbLf21lSB74AUB62LhNHmb13DNPuNTyZvSaCQfIv5PwJAmTiMLCyPrw3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nTkArMht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D5BC4CECD;
	Wed,  6 Nov 2024 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898408;
	bh=Wye2Bg0tzn1shVnSXGs7RFIi0JaBoXSOTWIVOEqkFMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nTkArMhtIG8hkA1L9TVfmtnubuvy2dythBMVflPkTO4I0J8iV7Cvp2BfzIr1PctZ2
	 ATNEaoClgH7LniO1hfsMrmLvNOSfYFNA4Q2Tkzti9yZL2fSvk8E/1OR6NH2fksOLRJ
	 Scwl61OmZJ+YgCi+fjU8dQ62ICCZtzl7eUfE0aFo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Heusel <christian@heusel.eu>,
	Jerry <jerryluo225@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 192/462] ALSA: hda/conexant: Fix conflicting quirk for System76 Pangolin
Date: Wed,  6 Nov 2024 13:01:25 +0100
Message-ID: <20241106120336.256752627@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit b3ebb007060f89d5a45c9b99f06a55e36a1945b5 ]

We received a regression report for System76 Pangolin (pang14) due to
the recent fix for Tuxedo Sirius devices to support the top speaker.
The reason was the conflicting PCI SSID, as often seen.

As a workaround, now the codec SSID is checked and the quirk is
applied conditionally only to Sirius devices.

Fixes: 4178d78cd7a8 ("ALSA: hda/conexant: Add pincfg quirk to enable top speakers on Sirius devices")
Reported-by: Christian Heusel <christian@heusel.eu>
Reported-by: Jerry <jerryluo225@gmail.com>
Closes: https://lore.kernel.org/c930b6a6-64e5-498f-b65a-1cd5e0a1d733@heusel.eu
Link: https://patch.msgid.link/20241004082602.29016-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_conexant.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index d0f26d7ed8611..5c0a40083342f 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -717,6 +717,23 @@ static const struct hda_pintbl cxt_pincfg_sws_js201d[] = {
 	{}
 };
 
+/* pincfg quirk for Tuxedo Sirius;
+ * unfortunately the (PCI) SSID conflicts with System76 Pangolin pang14,
+ * which has incompatible pin setup, so we check the codec SSID (luckily
+ * different one!) and conditionally apply the quirk here
+ */
+static void cxt_fixup_sirius_top_speaker(struct hda_codec *codec,
+					 const struct hda_fixup *fix,
+					 int action)
+{
+	/* ignore for incorrectly picked-up pang14 */
+	if (codec->core.subsystem_id == 0x278212b3)
+		return;
+	/* set up the top speaker pin */
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		snd_hda_codec_set_pincfg(codec, 0x1d, 0x82170111);
+}
+
 static const struct hda_fixup cxt_fixups[] = {
 	[CXT_PINCFG_LENOVO_X200] = {
 		.type = HDA_FIXUP_PINS,
@@ -873,11 +890,8 @@ static const struct hda_fixup cxt_fixups[] = {
 		.v.pins = cxt_pincfg_sws_js201d,
 	},
 	[CXT_PINCFG_TOP_SPEAKER] = {
-		.type = HDA_FIXUP_PINS,
-		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x1d, 0x82170111 },
-			{ }
-		},
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_sirius_top_speaker,
 	},
 };
 
-- 
2.43.0




