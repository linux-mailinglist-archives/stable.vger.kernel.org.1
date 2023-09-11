Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBCC79BA97
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbjIKU7L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbjIKOYV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:24:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B761EDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:24:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACF7C433C8;
        Mon, 11 Sep 2023 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442257;
        bh=jkoQ726IpYcv50GTILbGDO3L70AmWus3FTa38P1t4JQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrELMHLNbDGrnEPeXXr7gV89IvFWuL9sl1SmClLlDwn3L0Gy/v0hcqe1fBFUCvxrK
         YgQEDMeboTZtPAFbpBCMoWMMj9W3VWnjVIogM9N6RYg000s+YXe2tyRfdkhrpJ1/o7
         VlxXIpib5ZV+z0mknzY3+mLp16xhYBGnXJqqmv9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.5 675/739] ALSA: usb-audio: Fix potential memory leaks at error path for UMP open
Date:   Mon, 11 Sep 2023 15:47:54 +0200
Message-ID: <20230911134709.956635132@linuxfoundation.org>
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

commit b1757fa30ef14f254f4719bf6f7d54a4c8207216 upstream.

The allocation and initialization errors at alloc_midi_urbs() that is
called at MIDI 2.0 / UMP device are supposed to be handled at the
caller side by invoking free_midi_urbs().  However, free_midi_urbs()
loops only for ep->num_urbs entries, and since ep->num_entries wasn't
updated yet at the allocation / init error in alloc_midi_urbs(), this
entry won't be released.

The intention of free_midi_urbs() is to release the whole elements, so
change the loop size to NUM_URBS to scan over all elements for fixing
the missed releases.

Also, the call of free_midi_urbs() is missing at
snd_usb_midi_v2_open().  Although it'll be released later at
reopen/close or disconnection, it's better to release immediately at
the error path.

Fixes: ff49d1df79ae ("ALSA: usb-audio: USB MIDI 2.0 UMP support")
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/r/fc275ed315b9157952dcf2744ee7bdb78defdb5f.1693746347.git.christophe.jaillet@wanadoo.fr
Link: https://lore.kernel.org/r/20230905054511.20502-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/midi2.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -265,7 +265,7 @@ static void free_midi_urbs(struct snd_us
 
 	if (!ep)
 		return;
-	for (i = 0; i < ep->num_urbs; ++i) {
+	for (i = 0; i < NUM_URBS; ++i) {
 		ctx = &ep->urbs[i];
 		if (!ctx->urb)
 			break;
@@ -279,6 +279,7 @@ static void free_midi_urbs(struct snd_us
 }
 
 /* allocate URBs for an EP */
+/* the callers should handle allocation errors via free_midi_urbs() */
 static int alloc_midi_urbs(struct snd_usb_midi2_endpoint *ep)
 {
 	struct snd_usb_midi2_urb *ctx;
@@ -351,8 +352,10 @@ static int snd_usb_midi_v2_open(struct s
 		return -EIO;
 	if (ep->direction == STR_OUT) {
 		err = alloc_midi_urbs(ep);
-		if (err)
+		if (err) {
+			free_midi_urbs(ep);
 			return err;
+		}
 	}
 	return 0;
 }


