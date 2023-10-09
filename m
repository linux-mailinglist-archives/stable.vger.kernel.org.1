Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D87BDEC8
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376414AbjJINXC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376434AbjJINXB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:23:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C49D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:22:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35237C433C8;
        Mon,  9 Oct 2023 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857779;
        bh=5LDjwo6Gfn/Oo7jI76wZ+laqWtVyqNy9Sg+VbGGozBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTEjJ2wOjAPvVM2E2TPvMWV0nR6ZWGzbg/Jf/OjJUfcAfyQ8dNail8r/PR+eFYhiA
         8DcTkYDfa78nooc7n+7CAa4YmPAFEyn5y49lZbA3laSwpUd91yzUeZKqLqu3eKXzjE
         W6uzf5FyeYEisjm2Cvxe6ZG1j+wERzdfb5Syo5I4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 153/162] ALSA: hda/realtek - Fixed two speaker platform
Date:   Mon,  9 Oct 2023 15:02:14 +0200
Message-ID: <20231009130127.137710684@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -7062,8 +7062,10 @@ static void alc287_fixup_bind_dacs(struc
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
 
 


