Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D2B713CED
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjE1TUF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjE1TUF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:20:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3051BA6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C35E561ACE
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD966C433D2;
        Sun, 28 May 2023 19:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301603;
        bh=Ek4GUMJdDbIT12TepGUa01WBJkRHCgpsCWMohRwkovo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZq2xkLXuU78AM60+CtG9Pd1l1fKXVg/nvSmqJeDu5DO87cZc1l4GdReK1jgAsIQy
         i0kK2xvuL3i1emNYyAOgSqQ9/WCVnXXD+uMGlSHiGuORYtHiK25pudzq4manPPy93/
         dIA11TsZ+wNVD3Mq9U2qiU8BSqqNDLZVCNqUrXsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ai Chao <aichao@kylinos.cn>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 095/132] ALSA: hda/realtek: Add a quirk for HP EliteDesk 805
Date:   Sun, 28 May 2023 20:10:34 +0100
Message-Id: <20230528190836.548577451@linuxfoundation.org>
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

From: Ai Chao <aichao@kylinos.cn>

[ Upstream commit 90670ef774a8b6700c38ce1222e6aa263be54d5f ]

Add a quirk for HP EliteDesk 805 to fixup ALC3867 headset MIC no sound.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230506022653.2074343-1-aichao@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cf76c3159d584..ea3e9b6925204 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9121,6 +9121,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x069f, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
+	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x1043, 0x1080, "Asus UX501VW", ALC668_FIXUP_HEADSET_MODE),
 	SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_ASUS_Nx50),
-- 
2.39.2



