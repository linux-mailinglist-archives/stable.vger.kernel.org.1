Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EA4733F8A
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 10:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjFQIQI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 04:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjFQIQH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 04:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2916A1FF6
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 01:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB22B60A5A
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20B8C433C8;
        Sat, 17 Jun 2023 08:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686989766;
        bh=vpjO3cZ0qrcVcNrd7uZ+cnLWsgK5x6GOOVSlQrh9T5Q=;
        h=Subject:To:Cc:From:Date:From;
        b=iXMWpenWtVoVEEcLLkB4gWX+wHGGtxwg/UmZC+Kh4RnMHQf5KrWWGOIaTRH/p7Auu
         /Kr+AC1mgMTd27GGw9J+gM2RKuA1VZHTA0/Xn0YrzWQT/mLS5jZqOEMbXgena8yVWQ
         AE9+ZUQ2lmIVFaufSNPZi8ccf6p+h2Z0tlpw+pZw=
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Fix broken resume due to UAC3 power state" failed to apply to 5.4-stable tree
To:     tiwai@suse.de, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 17 Jun 2023 10:16:01 +0200
Message-ID: <2023061700-canon-game-2b28@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8ba61c9f6c9bdfbf9d197b0282641d24ae909778
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061700-canon-game-2b28@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ba61c9f6c9bdfbf9d197b0282641d24ae909778 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 12 Jun 2023 15:28:18 +0200
Subject: [PATCH] ALSA: usb-audio: Fix broken resume due to UAC3 power state

As reported in the bugzilla below, the PM resume of a UAC3 device may
fail due to the incomplete power state change, stuck at D1.  The
reason is that the driver expects the full D0 power state change only
at hw_params, while the normal PCM resume procedure doesn't call
hw_params.

For fixing the bug, we add the same power state update to D0 at the
prepare callback, which is certainly called by the resume procedure.

Note that, with this change, the power state change in the hw_params
becomes almost redundant, since snd_usb_hw_params() doesn't touch the
parameters (at least it tires so).  But dropping it is still a bit
risky (e.g. we have the media-driver binding), so I leave the D0 power
state change in snd_usb_hw_params() as is for now.

Fixes: a0a4959eb4e9 ("ALSA: usb-audio: Operate UAC3 Power Domains in PCM callbacks")
Cc: <stable@vger.kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217539
Link: https://lore.kernel.org/r/20230612132818.29486-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index eec5232f9fb2..08bf535ed163 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -650,6 +650,10 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 		goto unlock;
 	}
 
+	ret = snd_usb_pcm_change_state(subs, UAC3_PD_STATE_D0);
+	if (ret < 0)
+		goto unlock;
+
  again:
 	if (subs->sync_endpoint) {
 		ret = snd_usb_endpoint_prepare(chip, subs->sync_endpoint);

