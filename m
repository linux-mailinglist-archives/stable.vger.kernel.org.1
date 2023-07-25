Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396BD7615BD
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjGYLce (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjGYLce (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:32:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E3F2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D435361654
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2128C433C8;
        Tue, 25 Jul 2023 11:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284752;
        bh=Udq6luzFCYdwtoHw5SqQw/3Ia3PXXOY2Yie7rp2sUh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atgupHwiP0x+cNjjXn8ZRglkJ/k364XQUaodkdom+1NdHCcElLwNQh9Emojr+2EUD
         lHi2EHSAt2FUB5SniiXdvqtfi3i5SUG6WZJq1YyNAx1ac+0+Oz9Utpu+sVdhg3hMyM
         WE+spVP5PN4/oq5HxeQ5BuT6iO5oQfRAR2aqWxlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kailang Yang <kailang@realtek.com>,
        "Joseph C. Sible" <josephcsible@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 440/509] ALSA: hda/realtek - remove 3k pull low procedure
Date:   Tue, 25 Jul 2023 12:46:19 +0200
Message-ID: <20230725104613.884840028@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 69ea4c9d02b7947cdd612335a61cc1a02e544ccd upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -121,6 +121,7 @@ struct alc_spec {
 	unsigned int ultra_low_power:1;
 	unsigned int has_hs_key:1;
 	unsigned int no_internal_mic_pin:1;
+	unsigned int en_3kpull_low:1;
 
 	/* for PLL fix */
 	hda_nid_t pll_nid;
@@ -3617,6 +3618,7 @@ static void alc256_shutup(struct hda_cod
 	if (!hp_pin)
 		hp_pin = 0x21;
 
+	alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x1); /* Low power */
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
 	if (hp_pin_sense)
@@ -3633,8 +3635,7 @@ static void alc256_shutup(struct hda_cod
 	/* If disable 3k pulldown control for alc257, the Mic detection will not work correctly
 	 * when booting with headset plugged. So skip setting it for the codec alc257
 	 */
-	if (codec->core.vendor_id != 0x10ec0236 &&
-	    codec->core.vendor_id != 0x10ec0257)
+	if (spec->en_3kpull_low)
 		alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
 
 	if (!spec->no_shutup_pins)
@@ -10065,6 +10066,8 @@ static int patch_alc269(struct hda_codec
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0; /* ALC256 does not have any loopback mixer path */
+		if (codec->bus->pci->vendor == PCI_VENDOR_ID_AMD)
+			spec->en_3kpull_low = true;
 		break;
 	case 0x10ec0257:
 		spec->codec_variant = ALC269_TYPE_ALC257;


