Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AA272C110
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbjFLK4O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbjFLKz7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:55:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA6C5247
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68C7615CB
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6565C433D2;
        Mon, 12 Jun 2023 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566595;
        bh=Wrc/gc4ieIaMlL4SFsml1S7e/R+BzOjUV4gqdKlCF0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qd+5Cf3y/HpM0Lvx8+wJCHHzuMKg9M5HrjlGoC5AJr070QDU61+do4lf7e2lfgkKo
         9B0MKVRUaImlTGpn9r31FRWb+A2dhw8tGBblyQNZwPegptw5k+OVxN3GaYCg5X8J+r
         gJ7Pee97KTRj9kmxwEACuX02SVgqwVSmUPos8oBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 062/132] ALSA: hda: Fix kctl->id initialization
Date:   Mon, 12 Jun 2023 12:26:36 +0200
Message-ID: <20230612101713.092652503@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit 5c219a340850233aecbb444af964653ecd3d1370 upstream.

HD-audio core code replaces the kctl->id.index of SPDIF-related
controls after assigning via snd_ctl_add().  This doesn't work any
longer with the new Xarray lookup change.  The change of the kctl->id
content has to be done via snd_ctl_rename_id() helper, instead.

Fixes: c27e1efb61c5 ("ALSA: control: Use xarray for faster lookups")
Cc: <stable@vger.kernel.org>
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20230606093855.14685-5-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/hda_codec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 9f79c0ac2bda..bd19f92aeeec 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2458,10 +2458,14 @@ int snd_hda_create_dig_out_ctls(struct hda_codec *codec,
 		   type == HDA_PCM_TYPE_HDMI) {
 		/* suppose a single SPDIF device */
 		for (dig_mix = dig_mixes; dig_mix->name; dig_mix++) {
+			struct snd_ctl_elem_id id;
+
 			kctl = find_mixer_ctl(codec, dig_mix->name, 0, 0);
 			if (!kctl)
 				break;
-			kctl->id.index = spdif_index;
+			id = kctl->id;
+			id.index = spdif_index;
+			snd_ctl_rename_id(codec->card, &kctl->id, &id);
 		}
 		bus->primary_dig_out_type = HDA_PCM_TYPE_HDMI;
 	}
-- 
2.41.0



