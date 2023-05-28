Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E68713DD0
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjE1T3Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjE1T3N (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:29:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E91F3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA0D161D08
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C754EC433EF;
        Sun, 28 May 2023 19:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302144;
        bh=3Uf595Jknc3eLB79ThMn9PGVeA3zUR2SdQBQF6VlH5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYnRVsZrm52Mq7STBgO/cJsp/s/eJFkc3qKXE8HPC1w8kH5yGF1NNNNr4VfT1SOnu
         Wkl0dX1/kXUqPSETsIYmjFp4ivQ6zNcC0qs5PVqEHVlXmlHMgxNnjqBqrSOaX4ld0E
         nCIq4VnVEQvaUWXcsAi06Nj/8+OsMy/nN2UBZRM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Stylinski <kungfujesus06@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.3 017/127] ALSA: hda/ca0132: add quirk for EVGA X299 DARK
Date:   Sun, 28 May 2023 20:09:53 +0100
Message-Id: <20230528190836.786646303@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
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
@@ -1306,6 +1306,7 @@ static const struct snd_pci_quirk ca0132
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1038, "EVGA X99 Classified", QUIRK_R3DI),
+	SND_PCI_QUIRK(0x3842, 0x104b, "EVGA X299 Dark", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1055, "EVGA Z390 DARK", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0018, "Recon3D", QUIRK_R3D),


