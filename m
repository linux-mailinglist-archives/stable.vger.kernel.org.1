Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF786FAA2A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbjEHLAU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbjEHK7d (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27F12C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:58:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96D6D61E4B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9265DC433EF;
        Mon,  8 May 2023 10:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543480;
        bh=W9NoJiVh+l92EWH2uvdP7TDt5ze0DbnrYZ9sc7V56Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VMcfzJqoJz+enipJi5ZnrwSw2QIqTLIIq2O9Ff37JiYMy6UOtYPZh8P4aPKIBg479
         tRqGOEUvr4urfNQeOz6/URYcaip6XYqrvykmIFpGlzMMRRYmBhTE92lhpdBTs5e6mX
         dgQ2EWMKMiY9l/q7HRF/85hoDi1xZ6HpMX+N6F0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.3 103/694] ALSA: hda/realtek: Add quirk for ThinkPad P1 Gen 6
Date:   Mon,  8 May 2023 11:38:58 +0200
Message-Id: <20230508094435.832143255@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

commit 067eb084592819ad59d07afcb5de3e61cee2757c upstream.

Lenovo ThinkPad P1 Gen 6 laptop has 2 CS35L41 amplifies
on I2C bus connected to Realtek codec.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230427110452.13787-1-vitalyr@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9689,6 +9689,8 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x22f1, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x22f2, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x22f3, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x2316, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x2317, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2),


