Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56379B183
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbjIKVRv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbjIKOJB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:09:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E34CE4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:08:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BE1C433C8;
        Mon, 11 Sep 2023 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441337;
        bh=kP5gGFho2MR1qqgHRjEk0+QdsuY0cvuQdr3G400AyJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uukeYsyFqbWfkCUzDMruSG1caIPnGu99SJTBYqIfx0h1xV7e0SXQKAsBkb7lSZPiV
         Qp1JVx3taOf897t8L50SJxihKaAFljD5HPOisMBZ2YhMuD/O/salAzLhYFB94G2j7q
         H84fjNrXt1y5an6IB3U3P8S+8UDoDu3n/XfMsQLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 370/739] ALSA: usb-audio: Attach legacy rawmidi after probing all UMP EPs
Date:   Mon, 11 Sep 2023 15:42:49 +0200
Message-ID: <20230911134701.494833706@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 5f11dd938fe7657899ca79b2ffc4d708e43f4737 ]

The legacy rawmidi devices are the shadows of the main UMP devices,
hence it's better to initialize them after all UMP Endpoints are
parsed.  Then, at the moment the legacy rawmidi is created, we already
know the static flag or the proper EP name string, and we can fill
those information at UMP core side instead of fiddling the attributes
at a later point.

Fixes: ec362b63c4b5 ("ALSA: usb-audio: Enable the legacy raw MIDI support")
Link: https://lore.kernel.org/r/20230824075108.29958-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/ump.c  |  2 ++
 sound/usb/midi2.c | 15 ++++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/sound/core/ump.c b/sound/core/ump.c
index 246348766ec16..2cffd36863390 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -1150,6 +1150,8 @@ int snd_ump_attach_legacy_rawmidi(struct snd_ump_endpoint *ump,
 	if (output)
 		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
 				    &snd_ump_legacy_output_ops);
+	snprintf(rmidi->name, sizeof(rmidi->name), "%s (MIDI 1.0)",
+		 ump->info.name);
 	rmidi->info_flags = ump->core.info_flags & ~SNDRV_RAWMIDI_INFO_UMP;
 	rmidi->ops = &snd_ump_legacy_ops;
 	rmidi->private_data = ump;
diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index ee28357414795..a27e244650c8a 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -990,7 +990,7 @@ static int parse_midi_2_0(struct snd_usb_midi2_interface *umidi)
 		}
 	}
 
-	return attach_legacy_rawmidi(umidi);
+	return 0;
 }
 
 /* is the given interface for MIDI 2.0? */
@@ -1059,12 +1059,6 @@ static void set_fallback_rawmidi_names(struct snd_usb_midi2_interface *umidi)
 			usb_string(dev, dev->descriptor.iSerialNumber,
 				   ump->info.product_id,
 				   sizeof(ump->info.product_id));
-#if IS_ENABLED(CONFIG_SND_UMP_LEGACY_RAWMIDI)
-		if (ump->legacy_rmidi && !*ump->legacy_rmidi->name)
-			snprintf(ump->legacy_rmidi->name,
-				 sizeof(ump->legacy_rmidi->name),
-				 "%s (MIDI 1.0)", ump->info.name);
-#endif
 	}
 }
 
@@ -1157,6 +1151,13 @@ int snd_usb_midi_v2_create(struct snd_usb_audio *chip,
 	}
 
 	set_fallback_rawmidi_names(umidi);
+
+	err = attach_legacy_rawmidi(umidi);
+	if (err < 0) {
+		usb_audio_err(chip, "Failed to create legacy rawmidi\n");
+		goto error;
+	}
+
 	return 0;
 
  error:
-- 
2.40.1



