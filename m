Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF62E72C115
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbjFLK4T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbjFLK4C (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:56:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192033C01
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D40615B7
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3E8C433D2;
        Mon, 12 Jun 2023 10:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566608;
        bh=9uX/cc6y8duaBTGXDeNfk2zHwNV+0pv3qgRDNLRnNmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZHGlDoZAE0MIGMtp1WYyGcu51+aTOnZEwn8vFmBVRvR0C4XPDa4o0oc51oB8xxbwG
         0FBnPPBuQKbQDZGNw6tatI7w37N68oh0a4u8ji1snm2aslxBO0P49wRE3lLW7525zj
         /PtDHQ8rn4gofr8uy8ioUBDVdHyhGaEcbB/SZdAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Zidek <zidek@master.cz>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        stable@kernel.org
Subject: [PATCH 6.1 067/132] ALSA: ice1712,ice1724: fix the kcontrol->id initialization
Date:   Mon, 12 Jun 2023 12:26:41 +0200
Message-ID: <20230612101713.321190207@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jaroslav Kysela <perex@perex.cz>

commit b9a4efd61b6b9f62f83752959e75a5dae20624fa upstream.

The new xarray lookup code requires to know complete kcontrol->id before
snd_ctl_add() call. Reorder the code to make the initialization properly.

Cc: stable@kernel.org # v5.19+
Reported-by: Martin Zidek <zidek@master.cz>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20230606073122.597491-1-perex@perex.cz
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/ice1712/aureon.c  |    7 ++++---
 sound/pci/ice1712/ice1712.c |   14 +++++++++-----
 sound/pci/ice1712/ice1724.c |   16 ++++++++++------
 3 files changed, 23 insertions(+), 14 deletions(-)

--- a/sound/pci/ice1712/aureon.c
+++ b/sound/pci/ice1712/aureon.c
@@ -1903,11 +1903,12 @@ static int aureon_add_controls(struct sn
 		else {
 			for (i = 0; i < ARRAY_SIZE(cs8415_controls); i++) {
 				struct snd_kcontrol *kctl;
-				err = snd_ctl_add(ice->card, (kctl = snd_ctl_new1(&cs8415_controls[i], ice)));
-				if (err < 0)
-					return err;
+				kctl = snd_ctl_new1(&cs8415_controls[i], ice);
 				if (i > 1)
 					kctl->id.device = ice->pcm->device;
+				err = snd_ctl_add(ice->card, kctl);
+				if (err < 0)
+					return err;
 			}
 		}
 	}
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2371,22 +2371,26 @@ int snd_ice1712_spdif_build_controls(str
 
 	if (snd_BUG_ON(!ice->pcm_pro))
 		return -EIO;
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_ice1712_spdif_default, ice));
+	kctl = snd_ctl_new1(&snd_ice1712_spdif_default, ice);
+	kctl->id.device = ice->pcm_pro->device;
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
+	kctl = snd_ctl_new1(&snd_ice1712_spdif_maskc, ice);
 	kctl->id.device = ice->pcm_pro->device;
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_ice1712_spdif_maskc, ice));
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
+	kctl = snd_ctl_new1(&snd_ice1712_spdif_maskp, ice);
 	kctl->id.device = ice->pcm_pro->device;
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_ice1712_spdif_maskp, ice));
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
+	kctl = snd_ctl_new1(&snd_ice1712_spdif_stream, ice);
 	kctl->id.device = ice->pcm_pro->device;
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_ice1712_spdif_stream, ice));
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
-	kctl->id.device = ice->pcm_pro->device;
 	ice->spdif.stream_ctl = kctl;
 	return 0;
 }
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2392,23 +2392,27 @@ static int snd_vt1724_spdif_build_contro
 	if (err < 0)
 		return err;
 
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_vt1724_spdif_default, ice));
+	kctl = snd_ctl_new1(&snd_vt1724_spdif_default, ice);
+	kctl->id.device = ice->pcm->device;
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
+	kctl = snd_ctl_new1(&snd_vt1724_spdif_maskc, ice);
 	kctl->id.device = ice->pcm->device;
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_vt1724_spdif_maskc, ice));
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
+	kctl = snd_ctl_new1(&snd_vt1724_spdif_maskp, ice);
 	kctl->id.device = ice->pcm->device;
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_vt1724_spdif_maskp, ice));
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
-	kctl->id.device = ice->pcm->device;
 #if 0 /* use default only */
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_vt1724_spdif_stream, ice));
+	kctl = snd_ctl_new1(&snd_vt1724_spdif_stream, ice);
+	kctl->id.device = ice->pcm->device;
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
-	kctl->id.device = ice->pcm->device;
 	ice->spdif.stream_ctl = kctl;
 #endif
 	return 0;


