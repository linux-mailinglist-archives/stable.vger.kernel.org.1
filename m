Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13152755642
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjGPUtV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjGPUtJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1A3E64
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C10160EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367E5C433C7;
        Sun, 16 Jul 2023 20:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540543;
        bh=f5Si9s2Az76eOV5ttNHDahJEuo+Akxu4IzStsP5Cb3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofLtBm8tZXpbbzwcdgvmcs4WHUL4sDQnquZA9HnxKRxEp/ulHA6dbC4eeml5NLA9g
         ePkwzPMZjwAyIq7xT/M/H0LB3+zpW+BQkCwlia5O6ac+wOdetZ6CgULK2ZkmJPOJuX
         JBjQSJ+A9bMQu7ZmGcgslCFliV8KzWfcn+CEBjgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Werner Sembach <wse@tuxedocomputers.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 373/591] ALSA: hda/realtek: Add quirk for Clevo NPx0SNx
Date:   Sun, 16 Jul 2023 21:48:32 +0200
Message-ID: <20230716194933.570558999@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Werner Sembach <wse@tuxedocomputers.com>

commit 22065e4214c1196b54fc164892c2e193a743caf3 upstream.

This applies a SND_PCI_QUIRK(...) to the Clevo NPx0SNx barebones fixing the
microphone not being detected on the headset combo port.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230628155434.584159-1-wse@tuxedocomputers.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9680,6 +9680,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1558, 0x971d, "Clevo N970T[CDF]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa500, "Clevo NL5[03]RU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa600, "Clevo NL50NU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0xa650, "Clevo NP[567]0SN[CD]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa671, "Clevo NP70SN[CDE]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb018, "Clevo NP50D[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb019, "Clevo NH77D[BE]Q", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),


