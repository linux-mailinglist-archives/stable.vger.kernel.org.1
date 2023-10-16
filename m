Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BD17CA2C2
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjJPIyE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjJPIyD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:54:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10908E1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:54:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BDFC433C9;
        Mon, 16 Oct 2023 08:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446441;
        bh=XDEdgnyL9Ph138AHLY3YtWNFbMbObYhTfF/gqAV9ap4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCcBm/I70Q+oa9I10BalPNG8d2EfVHDyclnL64eIFD7NV9dCNTMnslYEhwoKuNGFB
         ze4ArArbQqz/hRF3bzJIX2k1DKZegqkLOTTaXWpTBlkEyyVcfL4A0DoTUXhg6IHIVa
         K3X6TBAuK9aTZG7HdSD4sxSeevKlTxL6UH1SsjfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, SungHwan Jung <onenowy@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/131] ALSA: hda/realtek: Add quirk for HP Victus 16-d1xxx to enable mute LED
Date:   Mon, 16 Oct 2023 10:40:12 +0200
Message-ID: <20231016084000.790431110@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SungHwan Jung <onenowy@gmail.com>

[ Upstream commit 93dc18e11b1ab2d485b69f91c973e6b83e47ebd0 ]

This quirk enables mute LED on HP Victus 16-d1xxx (8A25) laptops, which
use ALC245 codec.

Signed-off-by: SungHwan Jung <onenowy@gmail.com>
Link: https://lore.kernel.org/r/20230823114051.3921-1-onenowy@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: d93eeca627db ("ALSA: hda/realtek - ALC287 merge RTK codec with CS CS35L41 AMP")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 33fbf42fe502b..39d2ac6ae99a8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4639,6 +4639,22 @@ static void alc236_fixup_hp_mute_led_coefbit2(struct hda_codec *codec,
 	}
 }
 
+static void alc245_fixup_hp_mute_led_coefbit(struct hda_codec *codec,
+					  const struct hda_fixup *fix,
+					  int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0x0b;
+		spec->mute_led_coef.mask = 3 << 2;
+		spec->mute_led_coef.on = 2 << 2;
+		spec->mute_led_coef.off = 1 << 2;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
 				enum led_brightness brightness)
@@ -7227,6 +7243,7 @@ enum {
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
+	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9296,6 +9313,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
+	[ALC245_FIXUP_HP_MUTE_LED_COEFBIT] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_mute_led_coefbit,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9562,6 +9583,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x89c6, "Zbook Fury 17 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89ca, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x89d3, "HP EliteBook 645 G9 (MB 89D2)", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x8aa0, "HP ProBook 440 G9 (MB 8A9E)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.40.1



