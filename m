Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7EE7CACA5
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjJPO5j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjJPO5i (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:57:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88228AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:57:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB796C433C8;
        Mon, 16 Oct 2023 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468257;
        bh=OyDrcTumj89Z2ydkQXKf56pCcFsnvgUsLkv+FquXkVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NevTfX26iC7cegOJRoUVdkVkv/CF05nqfwmGyYCZosS1favl4WYxHIS15+5h2Bu1a
         TGgb3R2llvE0jxo7VZvUGzl4HyoeFbSoIBVz+Q0n1mgiQ7y+W5BOGSP8l/8zX0XwLj
         jzQo4sgkXuhmE9/8Q9pWe9T7DHuK6FJgideO0Uwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.5 191/191] ALSA: hda/realtek - Fixed two speaker platform
Date:   Mon, 16 Oct 2023 10:42:56 +0200
Message-ID: <20231016084019.827467357@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit fb6254df09bba303db2a1002085f6c0b90a456ed upstream.

If system has two speakers and one connect to 0x14 pin, use this
function will disable it.

Fixes: e43252db7e20 ("ALSA: hda/realtek - ALC287 I2S speaker platform support")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/r/e3f2aac3fe6a47079d728a6443358cc2@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7004,8 +7004,10 @@ static void alc287_fixup_bind_dacs(struc
 	snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
 	spec->gen.preferred_dacs = preferred_pairs;
 	spec->gen.auto_mute_via_amp = 1;
-	snd_hda_codec_write_cache(codec, 0x14, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    0x0); /* Make sure 0x14 was disable */
+	if (spec->gen.autocfg.speaker_pins[0] != 0x14) {
+		snd_hda_codec_write_cache(codec, 0x14, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+					0x0); /* Make sure 0x14 was disable */
+	}
 }
 
 


