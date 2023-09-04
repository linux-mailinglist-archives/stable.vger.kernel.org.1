Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CCF791D11
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345666AbjIDSek (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbjIDSej (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:34:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D12CC8
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8112619A5
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042A4C433C7;
        Mon,  4 Sep 2023 18:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852475;
        bh=E6VghTFraR72BSc6SIrxuGrKn77Bdw6/6ht4fw3xKSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tl397s8zg+eoLqgvUOx8Gp2a39IrHnSJGPSyCy3RPrMcQgT86oRGI/OiPEhZpAWdO
         vn9Om0OACDpi9MxYlH16jXhsbvWi1DCg/pdajXv2jrXzq2dRJb7Dw2Hy/CG5J+YGV3
         fZnf4HMRVqmUVJRIKl9SRwqnNDZ4II/2hOHGVyFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH 6.1 13/31] ALSA: usb-audio: Fix init call orders for UAC1
Date:   Mon,  4 Sep 2023 19:30:21 +0100
Message-ID: <20230904182947.673871605@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
References: <20230904182946.999390199@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 5fadc941d07530d681f3b7ec91e56d8445bc3825 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/stream.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1093,6 +1093,7 @@ static int __snd_usb_parse_audio_interfa
 	int i, altno, err, stream;
 	struct audioformat *fp = NULL;
 	struct snd_usb_power_domain *pd = NULL;
+	bool set_iface_first;
 	int num, protocol;
 
 	dev = chip->dev;
@@ -1223,11 +1224,19 @@ static int __snd_usb_parse_audio_interfa
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


