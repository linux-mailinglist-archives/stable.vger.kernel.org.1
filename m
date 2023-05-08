Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B1A6FA614
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjEHKQB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjEHKQA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:16:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39BB3ACD3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:15:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B19F6246C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E440C4339C;
        Mon,  8 May 2023 10:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540958;
        bh=5rgFYt5rQfHMzQmBNPOJUTeaF/OHTedFDXZoJjCXzJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1OC6zh4e/CdCykuYu1uN58fxom3ANMpCGBdjV4k2YCXY8SRDinCNUdi9xF+5zFZDy
         RYK+cyquGKDXHR+JpA8EIAGsmoqxvQdWqY5ifuZwysAYDjVs4dhip95MAk2rbVdhyE
         V0V73V6JGEfrvvf4CR1IOHHtyaC6dxxNEpLa2U/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Asselstine <asselsm@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 563/611] ALSA: hda/realtek: Add quirk for ASUS UM3402YAR using CS35L41
Date:   Mon,  8 May 2023 11:46:45 +0200
Message-Id: <20230508094440.270503449@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Mark Asselstine <asselsm@gmail.com>

commit 7e2d06628aab6324e1ac885910a52f4c038d4043 upstream.

This Asus Zenbook laptop uses Realtek HDA codec combined with
2xCS35L41 Amplifiers using I2C with External Boost.

Signed-off-by: Mark Asselstine <asselsm@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230501231346.54979-1-asselsm@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9500,6 +9500,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
+	SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1740, "ASUS UX430UA", ALC295_FIXUP_ASUS_DACS),


