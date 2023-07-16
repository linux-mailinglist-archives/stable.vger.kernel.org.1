Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D84675563A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjGPUs6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjGPUso (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:48:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A901721
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:48:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C69660EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315D8C433C7;
        Sun, 16 Jul 2023 20:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540512;
        bh=k5w8+zsXWCNX8K0FewWj5b6qoqwoyACqixVrjgGESBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=07Go0ZrKxn9CYOlo+cNAP7KBnuhRFQkwWL5ImG96swUa1xFilG7lKShIzbj6pwkZL
         WlImWKZhEao+0uWYvy0WLKxXPNuUFEcSGeDkYdmFgY0dlITkvD9aUy5uUGheW7Hy9L
         WspHlaStbOWDOYQ2E1K5uL3i6lXryYxCbJhKZGKg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andy Chi <andy.chi@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 372/591] ALSA: hda/realtek: Enable mute/micmute LEDs and limit mic boost on EliteBook
Date:   Sun, 16 Jul 2023 21:48:31 +0200
Message-ID: <20230716194933.542583833@linuxfoundation.org>
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

From: Andy Chi <andy.chi@canonical.com>

commit e94f1f96f108ba96c0ed8bf3fbdd8ee6a6703880 upstream.

On HP EliteBook 835/845/845W G10, the audio LEDs can be enabled by
ALC285_FIXUP_HP_MUTE_LED. So use it accordingly.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
Cc: <stable@vger.kernel.org>
Fixes: 3e10f6ca76c4 ("ALSA: hda/realtek: Add quirk for HP EliteBook G10 laptops")
Link: https://lore.kernel.org/r/20230626130301.301712-1-andy.chi@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dabfdecece26..f64dd09692b5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9490,9 +9490,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b63, "HP Elite Dragonfly 13.5 inch G4", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b65, "HP ProBook 455 15.6 inch G10 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b66, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
-	SND_PCI_QUIRK(0x103c, 0x8b70, "HP EliteBook 835 G10", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8b72, "HP EliteBook 845 G10", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8b74, "HP EliteBook 845W G10", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8b70, "HP EliteBook 835 G10", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b72, "HP EliteBook 845 G10", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b74, "HP EliteBook 845W G10", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b77, "HP ElieBook 865 G10", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8b7a, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b7d, "HP", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.41.0



