Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9003772C219
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbjFLLCz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbjFLLC2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:02:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D069476BA
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61509624E7
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766ABC4339B;
        Mon, 12 Jun 2023 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566992;
        bh=ZxhYD46jxs/6H5aSRgy17QSu/iyspEVxgEOUai0CnW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7tHF0Riwp97mScskO1vBl6E1aBaFh0f3kqOVdAd4LaMPezoencnSSRa7bBpSq4hq
         x27SG9FX93Z3TJXpdRYnjuxK+MYKLNFXx9z3S7kaz5xbt20tsOKLEmCAB7Abj6laQu
         THO8eNDgRRxOuyFKeiwOJP2hu+zMGYHXj33HAIWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, RenHai <kean0048@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.3 082/160] ALSA: hda/realtek: Add Lenovo P3 Tower platform
Date:   Mon, 12 Jun 2023 12:26:54 +0200
Message-ID: <20230612101718.754106384@linuxfoundation.org>
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

From: RenHai <kean0048@gmail.com>

commit 7ca4c8d4d3f41c2cd9b4cf22bb829bf03dac0956 upstream.

Headset microphone on this platform does not work without
ALC897_FIXUP_HEADSET_MIC_PIN fixup.

Signed-off-by: RenHai <kean0048@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230602003604.975892-1-kean0048@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11717,6 +11717,7 @@ static const struct snd_pci_quirk alc662
 	SND_PCI_QUIRK(0x14cd, 0x5003, "USI", ALC662_FIXUP_USI_HEADSET_MODE),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC662_FIXUP_LENOVO_MULTI_CODECS),
 	SND_PCI_QUIRK(0x17aa, 0x1057, "Lenovo P360", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x1064, "Lenovo P3 Tower", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32ca, "Lenovo ThinkCentre M80", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),


