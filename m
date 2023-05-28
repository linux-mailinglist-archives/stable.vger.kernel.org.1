Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F485713F75
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjE1Tpj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjE1Tpi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D823A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D765F61F57
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BC6C433EF;
        Sun, 28 May 2023 19:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303136;
        bh=8ByAZKy5DMsr2uph0Wc/kn34/UfjKDDIZVS7PUpcEcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHjVY3GgZuajpNTU6AVMngSwg/dCrlMl3LNOs9vJTWZsEQv3ymjfWtgaC6apEwAPE
         iun3q3q68WCM+5Ci+q8vXO+vW2EXFvW0zhNODPOrM8+TPk9TntwqZrkLFkFnN2bLI9
         9xSRxk6rpZ/rZns/iXpV/Y19Ipxreufn0mL3iPyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Stylinski <kungfujesus06@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 168/211] ALSA: hda/ca0132: add quirk for EVGA X299 DARK
Date:   Sun, 28 May 2023 20:11:29 +0100
Message-Id: <20230528190847.672748228@linuxfoundation.org>
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

From: Adam Stylinski <kungfujesus06@gmail.com>

commit 7843380d07bbeffd3ce6504e73cf61f840ae76ca upstream.

This quirk is necessary for surround and other DSP effects to work
with the onboard ca0132 based audio chipset for the EVGA X299 dark
mainboard.

Signed-off-by: Adam Stylinski <kungfujesus06@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=67071
Link: https://lore.kernel.org/r/ZGopOe19T1QOwizS@eggsbenedict.adamsnet
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_ca0132.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1272,6 +1272,7 @@ static const struct snd_pci_quirk ca0132
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1038, "EVGA X99 Classified", QUIRK_R3DI),
+	SND_PCI_QUIRK(0x3842, 0x104b, "EVGA X299 Dark", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1055, "EVGA Z390 DARK", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0018, "Recon3D", QUIRK_R3D),


