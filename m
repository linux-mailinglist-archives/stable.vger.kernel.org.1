Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F579064E
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 10:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351840AbjIBIi4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 04:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbjIBIi4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 04:38:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E08010F4
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 01:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27DEAB8275F
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 08:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DFFC433C8;
        Sat,  2 Sep 2023 08:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693643930;
        bh=UpsYOJSDJ8/2BwePBK88hnAdUoea6aspk6PsR6NKylA=;
        h=Subject:To:Cc:From:Date:From;
        b=aqrTly4CVp9k3nSAHrVsRVtQdyHZdTI3FWVnfH38wgFysYq5fNT0xxuX+mmyK63SN
         fenvKuaAY9ZFjEd4E3jToKC3rijaUDacWdCgF5K13pp3sr/gDSNfE40exIGpcLxivM
         0p+pEiEmacTYUiHfjAxoY2ThQ4Qrpizim5x3GbSQ=
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Fix init call orders for UAC1" failed to apply to 4.14-stable tree
To:     tiwai@suse.de, joakim.tjernlund@infinera.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 02 Sep 2023 10:38:42 +0200
Message-ID: <2023090242-concept-gooey-79d6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 5fadc941d07530d681f3b7ec91e56d8445bc3825
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090242-concept-gooey-79d6@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5fadc941d07530d681f3b7ec91e56d8445bc3825 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 21 Aug 2023 13:18:57 +0200
Subject: [PATCH] ALSA: usb-audio: Fix init call orders for UAC1

There have been reports of USB-audio driver spewing errors at the
probe time on a few devices like Jabra and Logitech.  The suggested
fix there couldn't be applied as is, unfortunately, because it'll
likely break other devices.

But, the patch suggested an interesting point: looking at the current
init code in stream.c, one may notice that it does initialize
differently from the device setup in endpoint.c.  Namely, for UAC1, we
should call snd_usb_init_pitch() and snd_usb_init_sample_rate() after
setting the interface, while the init sequence at parsing calls them
before setting the interface blindly.

This patch changes the init sequence at parsing for UAC1 (and other
devices that need a similar behavior) to be aligned with the rest of
the code, setting the interface at first.  And, this fixes the
long-standing problems on a few UAC1 devices like Jabra / Logitech,
as reported, too.

Reported-and-tested-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Closes: https://lore.kernel.org/r/202bbbc0f51522e8545783c4c5577d12a8e2d56d.camel@infinera.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230821111857.28926-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index f10f4e6d3fb8..3d4add94e367 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1093,6 +1093,7 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 	int i, altno, err, stream;
 	struct audioformat *fp = NULL;
 	struct snd_usb_power_domain *pd = NULL;
+	bool set_iface_first;
 	int num, protocol;
 
 	dev = chip->dev;
@@ -1223,11 +1224,19 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 				return err;
 		}
 
+		set_iface_first = false;
+		if (protocol == UAC_VERSION_1 ||
+		    (chip->quirk_flags & QUIRK_FLAG_SET_IFACE_FIRST))
+			set_iface_first = true;
+
 		/* try to set the interface... */
 		usb_set_interface(chip->dev, iface_no, 0);
+		if (set_iface_first)
+			usb_set_interface(chip->dev, iface_no, altno);
 		snd_usb_init_pitch(chip, fp);
 		snd_usb_init_sample_rate(chip, fp, fp->rate_max);
-		usb_set_interface(chip->dev, iface_no, altno);
+		if (!set_iface_first)
+			usb_set_interface(chip->dev, iface_no, altno);
 	}
 	return 0;
 }

