Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E426713CEA
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjE1TT6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjE1TT5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:19:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3983A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F45561AAF
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D395C433D2;
        Sun, 28 May 2023 19:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301594;
        bh=hs0yN7OBybA8SMRvCaZzmnOGpY14uevurk2UC/iSmcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cPpHigHebrJh+Iigim+L2N/KTv2ruIxThJcB3WL3deuHTE9nmZRtrnzw6YxtUEWKY
         tc36ZWPgZIujKeYQ7GECiISWSsmHkhvAhrN6InQDGRqVlcVqKsS2ZT8jrK9rUypCdM
         Gd+SUgPfIMb8b6uUxpva06IINgsDO43qJrAQ9nE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        msd <msd.mmq@gmail.com>
Subject: [PATCH 4.19 092/132] ALSA: hda/realtek: Fix the mic type detection issue for ASUS G551JW
Date:   Sun, 28 May 2023 20:10:31 +0100
Message-Id: <20230528190836.432481429@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

[ Upstream commit a3fd1a986e499a06ac5ef95c3a39aa4611e7444c ]

We need to define the codec pin 0x1b to be the mic, but somehow
the mic doesn't support hot plugging detection, and Windows also has
this issue, so we set it to phantom headset-mic.

Also the determine_headset_type() often returns the omtp type by a
mistake when we plug a ctia headset, this makes the mic can't record
sound at all. Because most of the headset are ctia type nowadays and
some machines have the fixed ctia type audio jack, it is possible this
machine has the fixed ctia jack too. Here we set this mic jack to
fixed ctia type, this could avoid the mic type detection mistake and
make the ctia headset work stable.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214537
Reported-and-tested-by: msd <msd.mmq@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Link: https://lore.kernel.org/r/20211012114748.5238-1-hui.wang@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 90670ef774a8 ("ALSA: hda/realtek: Add a quirk for HP EliteDesk 805")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index faef696b17989..1f535504ee907 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8650,6 +8650,9 @@ enum {
 	ALC671_FIXUP_HP_HEADSET_MIC2,
 	ALC662_FIXUP_ACER_X2660G_HEADSET_MODE,
 	ALC662_FIXUP_ACER_NITRO_HEADSET_MODE,
+	ALC668_FIXUP_ASUS_NO_HEADSET_MIC,
+	ALC668_FIXUP_HEADSET_MIC,
+	ALC668_FIXUP_MIC_DET_COEF,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -9026,6 +9029,29 @@ static const struct hda_fixup alc662_fixups[] = {
 		.chained = true,
 		.chain_id = ALC662_FIXUP_USI_FUNC
 	},
+	[ALC668_FIXUP_ASUS_NO_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1b, 0x04a1112c },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC668_FIXUP_HEADSET_MIC
+	},
+	[ALC668_FIXUP_HEADSET_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_headset_mic,
+		.chained = true,
+		.chain_id = ALC668_FIXUP_MIC_DET_COEF
+	},
+	[ALC668_FIXUP_MIC_DET_COEF] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x15 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x0d60 },
+			{}
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -9060,6 +9086,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x15a7, "ASUS UX51VZH", ALC662_FIXUP_BASS_16),
 	SND_PCI_QUIRK(0x1043, 0x177d, "ASUS N551", ALC668_FIXUP_ASUS_Nx51),
 	SND_PCI_QUIRK(0x1043, 0x17bd, "ASUS N751", ALC668_FIXUP_ASUS_Nx51),
+	SND_PCI_QUIRK(0x1043, 0x185d, "ASUS G551JW", ALC668_FIXUP_ASUS_NO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1963, "ASUS X71SL", ALC662_FIXUP_ASUS_MODE8),
 	SND_PCI_QUIRK(0x1043, 0x1b73, "ASUS N55SF", ALC662_FIXUP_BASS_16),
 	SND_PCI_QUIRK(0x1043, 0x1bf3, "ASUS N76VZ", ALC662_FIXUP_BASS_MODE4_CHMAP),
-- 
2.39.2



