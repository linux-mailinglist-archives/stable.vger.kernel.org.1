Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F98713F2B
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjE1Tmk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjE1Tmj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:42:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469D69B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBCB161EF5
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C6EC433EF;
        Sun, 28 May 2023 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302957;
        bh=3JLio6VA4QytsxY3q3DUlzcNhxuzV6Kpo1cHeeZwHl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmsZ/RazVewutKumDXubdCyHwYIi1KRGueJr2oDw6auHlxk008h5PNeo/E2ReOssS
         iXEFqVMYwyIo5+Wt9V7SDbphYmz6G89zGkwbzGf+oL5fBQ6ovFOXP8171vMZKpwE6x
         JxmPOzK5m5hq1dFseojYbFPVqPNbDWaBZ3e40Cu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ryan Underwood <nemesis@icequake.net>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 096/211] ALSA: hda/realtek: Apply HP B&O top speaker profile to Pavilion 15
Date:   Sun, 28 May 2023 20:10:17 +0100
Message-Id: <20230528190845.984641851@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 18309fa17fb87..c7e25d19c9d92 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8944,7 +8944,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
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



