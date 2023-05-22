Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5672670C968
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjEVTrs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbjEVTrr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4A0A9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77BFF62AB0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86609C433EF;
        Mon, 22 May 2023 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784865;
        bh=C2Vzp/NVBrQQ5oy+2ry83pGOZXgwfb5NVjN/F4OK8RU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aAOhdNO/D+8FgzaEMyuCmxhXZCKdSLh2IYjbn8PyTBUqopgBJYc5nGhrkL6xY8bKg
         eJY/uyIyDxgAHp3zK2MujN+E5LcOyfSpGDjRss+mP1z67ySt4ZcUCo6STI4/6gKh6P
         LQ4m4ixcteBNk/JisF1W33CTVa2wG9zw1yTOciug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ryan Underwood <nemesis@icequake.net>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 228/364] ALSA: hda/realtek: Apply HP B&O top speaker profile to Pavilion 15
Date:   Mon, 22 May 2023 20:08:53 +0100
Message-Id: <20230522190418.399758980@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ryan C. Underwood <nemesis@icequake.net>

[ Upstream commit 92553ee03166ef8fa978e7683f9f4af30c9c4e6b ]

The Pavilion 15 line has B&O top speakers similar to the x360 and
applying the same profile produces good sound.  Without this, the
sound would be tinny and underpowered without either applying
model=alc295-hp-x360 or booting another OS first.

Signed-off-by: Ryan Underwood <nemesis@icequake.net>
Fixes: 563785edfcef ("ALSA: hda/realtek - Add quirk entry for HP Pavilion 15")
Link: https://lore.kernel.org/r/ZF0mpcMz3ezP9KQw@icequake.net
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 172ffc2c332b7..5d78d4ba1c959 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9363,7 +9363,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x802f, "HP Z240", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8077, "HP", ALC256_FIXUP_HP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x103c, 0x8158, "HP", ALC256_FIXUP_HP_HEADSET_MIC),
-	SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x8256, "HP", ALC221_FIXUP_HP_FRONT_MIC),
 	SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x827f, "HP x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
-- 
2.39.2



