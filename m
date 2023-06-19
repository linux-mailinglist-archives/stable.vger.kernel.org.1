Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5096073542E
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjFSKxd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjFSKw4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:52:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC033598
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12F3760B85
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EF1C433C8;
        Mon, 19 Jun 2023 10:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171900;
        bh=qPDBFRw2sWhuJQCvhj0jRbZhaBp7j2BkRd298yhzYk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvVhgEyNQkwevoySnGifrp6fb/oVDCc6DIzyDJuHdZyFMmc966MYp2QH09DJe9zUy
         ZEVIXrzqoEeOR8pqfnSl5rS2sWwOJ0HWdPO1Up3YsRG9qyLfObCslnU7aS/OxGy/fN
         xZ46+GdoCC3zkAJto8Skn+m6ykNURLBO4m07l1pM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Edson Juliano Drosdeck <edson.drosdeck@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 31/64] ALSA: hda/realtek: Add a quirk for Compaq N14JP6
Date:   Mon, 19 Jun 2023 12:30:27 +0200
Message-ID: <20230619102134.539719941@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

commit a2a871483161014f1bcc4e9a04354b01aa77cedb upstream.

Add a quirk for Compaq N14JP6 to fixup ALC897 headset MIC no sound.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230609201058.523499-1-edson.drosdeck@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10382,6 +10382,7 @@ static const struct snd_pci_quirk alc662
 	SND_PCI_QUIRK(0x1b0a, 0x01b8, "ACER Veriton", ALC662_FIXUP_ACER_VERITON),
 	SND_PCI_QUIRK(0x1b35, 0x1234, "CZC ET26", ALC662_FIXUP_CZC_ET26),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
+	SND_PCI_QUIRK(0x1c6c, 0x1239, "Compaq N14JP6-V2", ALC897_FIXUP_HP_HSMIC_VERB),
 
 #if 0
 	/* Below is a quirk table taken from the old code.


