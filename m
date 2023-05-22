Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D269D70C69C
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjEVTUI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjEVTUI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:20:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD3CCA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFF5462813
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A7FC433EF;
        Mon, 22 May 2023 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783206;
        bh=U3P9dNwB8DV/Rop6FMzC5XzKUBQRzhwDijTCPCD82u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+k2dTvxIKOHKZynMInSQIOMeXkOY9zEtDv6CFdDLqi+c6Rd07v+JM2jK4fD4PFTQ
         CGXQPquqnEIcmyyux9idQjLNe/sDBCXNjAITluB64PcR3P7PZcG0hDdZY8PNe6c5yf
         SS588GnMf6w2RcvKP9plxAT5c0ib/rq97BUisoVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ai Chao <aichao@kylinos.cn>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 173/203] ALSA: hda/realtek: Add a quirk for HP EliteDesk 805
Date:   Mon, 22 May 2023 20:09:57 +0100
Message-Id: <20230522190359.783679359@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Ai Chao <aichao@kylinos.cn>

commit 90670ef774a8b6700c38ce1222e6aa263be54d5f upstream.

Add a quirk for HP EliteDesk 805 to fixup ALC3867 headset MIC no sound.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230506022653.2074343-1-aichao@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11246,6 +11246,7 @@ static const struct snd_pci_quirk alc662
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
 	SND_PCI_QUIRK(0x103c, 0x870c, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
+	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP_HEADSET_MIC2),


