Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0E172BFBB
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjFLKqx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjFLKqi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E2172AA
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A14C615BF
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9CAC433EF;
        Mon, 12 Jun 2023 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565867;
        bh=oKY9W+xsiqbWcBKaembfGQdQFmVdIcxkZBmUcBZj26M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PV+1yPsbn5R0nmXtes8n2WdljrjdA/wpW+X+uKv613MEZpkh3muaKqZHpQNEeSVKm
         Z2PDSv+SO37fuI2gUYX1fVhDDMir7IHhoFO5ju3EJUoVHj2nbkoNFN04ckHuoI7JS8
         HOH9NxESRKk0VBXxXoc9h+KPpxUHw7UKcVERDu0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ai Chao <aichao@kylinos.cn>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 22/45] ALSA: hda/realtek: Add a quirk for HP Slim Desktop S01
Date:   Mon, 12 Jun 2023 12:26:16 +0200
Message-ID: <20230612101655.567953748@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
References: <20230612101654.644983109@linuxfoundation.org>
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

From: Ai Chao <aichao@kylinos.cn>

commit 527c356b51f3ddee02c9ed5277538f85e30a2cdc upstream.

Add a quirk for HP Slim Desktop S01 to fixup headset MIC no presence.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230526094704.14597-1-aichao@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10345,6 +10345,7 @@ static const struct snd_pci_quirk alc662
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
+	SND_PCI_QUIRK(0x103c, 0x8768, "HP Slim Desktop S01", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x1043, 0x1080, "Asus UX501VW", ALC668_FIXUP_HEADSET_MODE),


