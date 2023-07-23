Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F88B75E1A6
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGWMCO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 08:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWMCN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 08:02:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC1E7C
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 05:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBF7D60CEB
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 12:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED8CC433C8;
        Sun, 23 Jul 2023 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690113731;
        bh=Xel4Rh674DgvGPBUQw1D+wNCJV8XAyINtB272XuIzaQ=;
        h=Subject:To:Cc:From:Date:From;
        b=F7t9WIj8i7t9iDDaGYVFw2fGfnhd/m9ENHx1IJno790rN+rRz0PTrYyQVMpegBPTA
         4RV1iaBfRPBhHpn9B94GObfsO9MnbdenMJua6ebVe53xNH105kJMd4GE3wM0LCdhmG
         pRIIlfuJHQEzb4eq6FHRWTYM3s3NCnPyuo1V6sH8=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek - remove 3k pull low procedure" failed to apply to 5.4-stable tree
To:     kailang@realtek.com, josephcsible@gmail.com,
        stable@vger.kernel.org, tiwai@suse.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 14:02:08 +0200
Message-ID: <2023072307-usage-safely-2a32@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 69ea4c9d02b7947cdd612335a61cc1a02e544ccd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072307-usage-safely-2a32@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

69ea4c9d02b7 ("ALSA: hda/realtek - remove 3k pull low procedure")
f30741cded62 ("ALSA: hda/realtek: Fix audio regression on Mi Notebook Pro 2020")
5aec98913095 ("ALSA: hda/realtek - ALC236 headset MIC recording issue")
92666d45adcf ("ALSA: hda/realtek - Fixed Dell AIO wrong sound tone")
9e885770277d ("ALSA: hda/realtek - HP Headset Mic can't detect after boot")
a0ccbc5319d5 ("ALSA: hda/realtek - Add supported mute Led for HP")
446b8185f0c3 ("ALSA: hda/realtek - Add supported for Lenovo ThinkPad Headset Button")
ef9ce66fab95 ("ALSA: hda/realtek - Enable headphone for ASUS TM420")
8a8de09cb2ad ("ALSA: hda/realtek - Fixed HP headset Mic can't be detected")
08befca40026 ("ALSA: hda/realtek - Add mute Led support for HP Elitebook 845 G7")
13468bfa8c58 ("ALSA: hda/realtek - set mic to auto detect on a HP AIO machine")
3f7424905782 ("ALSA: hda/realtek - Couldn't detect Mic if booting with headset plugged")
fc19d559b0d3 ("ALSA: hda/realtek - The Mic on a RedmiBook doesn't work")
23dc95868944 ("ALSA: hda/realtek: Add model alc298-samsung-headphone")
e2d2fded6bdf ("ALSA: hda/realtek: Fix pin default on Intel NUC 8 Rugged")
3b5d1afd1f13 ("Merge branch 'for-next' into for-linus")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 69ea4c9d02b7947cdd612335a61cc1a02e544ccd Mon Sep 17 00:00:00 2001
From: Kailang Yang <kailang@realtek.com>
Date: Thu, 13 Jul 2023 15:57:13 +0800
Subject: [PATCH] ALSA: hda/realtek - remove 3k pull low procedure

This was the ALC283 depop procedure.
Maybe this procedure wasn't suitable with new codec.
So, let us remove it. But HP 15z-fc000 must do 3k pull low. If it
reboot with plugged headset,
it will have errors show don't find codec error messages. Run 3k pull
low will solve issues.
So, let AMD chipset will run this for workarround.

Fixes: 5aec98913095 ("ALSA: hda/realtek - ALC236 headset MIC recording issue")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Reported-by: Joseph C. Sible <josephcsible@gmail.com>
Closes: https://lore.kernel.org/r/CABpewhE4REgn9RJZduuEU6Z_ijXNeQWnrxO1tg70Gkw=F8qNYg@mail.gmail.com/
Link: https://lore.kernel.org/r/4678992299664babac4403d9978e7ba7@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e2f8b608de82..afb4d82475b4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -122,6 +122,7 @@ struct alc_spec {
 	unsigned int ultra_low_power:1;
 	unsigned int has_hs_key:1;
 	unsigned int no_internal_mic_pin:1;
+	unsigned int en_3kpull_low:1;
 
 	/* for PLL fix */
 	hda_nid_t pll_nid;
@@ -3622,6 +3623,7 @@ static void alc256_shutup(struct hda_codec *codec)
 	if (!hp_pin)
 		hp_pin = 0x21;
 
+	alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x1); /* Low power */
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
 	if (hp_pin_sense)
@@ -3638,8 +3640,7 @@ static void alc256_shutup(struct hda_codec *codec)
 	/* If disable 3k pulldown control for alc257, the Mic detection will not work correctly
 	 * when booting with headset plugged. So skip setting it for the codec alc257
 	 */
-	if (codec->core.vendor_id != 0x10ec0236 &&
-	    codec->core.vendor_id != 0x10ec0257)
+	if (spec->en_3kpull_low)
 		alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
 
 	if (!spec->no_shutup_pins)
@@ -10682,6 +10683,8 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0; /* ALC256 does not have any loopback mixer path */
+		if (codec->bus->pci->vendor == PCI_VENDOR_ID_AMD)
+			spec->en_3kpull_low = true;
 		break;
 	case 0x10ec0257:
 		spec->codec_variant = ALC269_TYPE_ALC257;

