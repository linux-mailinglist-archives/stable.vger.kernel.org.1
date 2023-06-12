Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE4B72C224
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbjFLLDI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbjFLLCe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:02:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B285CBB
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BD19623BC
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EB6C433EF;
        Mon, 12 Jun 2023 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567013;
        bh=UUHWATXInQ719PnwDvtplB/g46UJwj/fh08kvBO7RDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=we6w36EoV8MDvLe2rjH9J30AgSL0GWBWKan2tL57b8m4mZPeedfv3/fp7EEzFTiX9
         CoHhHrNVvc7j8LHJmBiEcvM/OoJpeFI/q7+aNTdjSmfdAO3e7efNdmytd/lHLhvD/S
         vEBtY5nimldlXRhfveiWq1o3YxMdl8G9XjT7tbWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tim Crawford <tcrawford@system76.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.3 079/160] ALSA: hda/realtek: Add quirk for Clevo NS50AU
Date:   Mon, 12 Jun 2023 12:26:51 +0200
Message-ID: <20230612101718.636729375@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Tim Crawford <tcrawford@system76.com>

commit da209f7a80dd633a32cbcbafe9e9f778933119c1 upstream.

Fixes headset detection on Clevo NS50AU.

Signed-off-by: Tim Crawford <tcrawford@system76.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230605163834.24653-1-tcrawford@system76.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9636,6 +9636,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1558, 0x5101, "Clevo S510WU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x5157, "Clevo W517GU1", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x51a1, "Clevo NS50MU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x51b1, "Clevo NS50AU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x5630, "Clevo NP50RNJS", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70a1, "Clevo NB70T[HJK]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70b3, "Clevo NK70SB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),


