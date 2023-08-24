Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6242B78735F
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbjHXPCl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242107AbjHXPCg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:02:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD091BCE
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF0D4615C7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1778C433C7;
        Thu, 24 Aug 2023 15:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889347;
        bh=cEYBMdT5eky+hxFtIVJee5tOmn7/ubLaNtWTulZgBnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLnRRWE4+KoDtx7YrC9+sUrhB8j/h2HMz4kehHTP1qveSXeUD7+OvXE51hOVpm/S5
         3dzD9BMeYrmxjx1cx717wsXpjAoLC2NUnioM/f6F42r8qCxP4ePuY5lsR3HE3zzhEj
         mulAueRWpztWSN7zc35cJZDvVcYZ1RH7c2tGPkzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 104/135] ALSA: hda/realtek - Remodified 3k pull low procedure
Date:   Thu, 24 Aug 2023 16:50:47 +0200
Message-ID: <20230824145031.471313769@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 46cdff2369cbdf8d78081a22526e77bd1323f563 ]

Set spec->en_3kpull_low default to true.
Then fillback ALC236 and ALC257 to false.

Additional note: this addresses a regression caused by the previous
fix 69ea4c9d02b7 ("ALSA: hda/realtek - remove 3k pull low procedure").
The previous workaround was applied too widely without necessity,
which resulted in the pop noise at PM again.  This patch corrects the
condition and restores the old behavior for the devices that don't
suffer from the original problem.

Fixes: 69ea4c9d02b7 ("ALSA: hda/realtek - remove 3k pull low procedure")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217732
Link: https://lore.kernel.org/r/01e212a538fc407ca6edd10b81ff7b05@realtek.com
Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 09a9e21675341..adfab80b8189d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10006,6 +10006,7 @@ static int patch_alc269(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->gen.shared_mic_vref_pin = 0x18;
 	codec->power_save_node = 0;
+	spec->en_3kpull_low = true;
 
 #ifdef CONFIG_PM
 	codec->patch_ops.suspend = alc269_suspend;
@@ -10088,14 +10089,16 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0; /* ALC256 does not have any loopback mixer path */
-		if (codec->bus->pci->vendor == PCI_VENDOR_ID_AMD)
-			spec->en_3kpull_low = true;
+		if (codec->core.vendor_id == 0x10ec0236 &&
+		    codec->bus->pci->vendor != PCI_VENDOR_ID_AMD)
+			spec->en_3kpull_low = false;
 		break;
 	case 0x10ec0257:
 		spec->codec_variant = ALC269_TYPE_ALC257;
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0;
+		spec->en_3kpull_low = false;
 		break;
 	case 0x10ec0215:
 	case 0x10ec0245:
-- 
2.40.1



