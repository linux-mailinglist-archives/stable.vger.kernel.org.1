Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196187A386D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbjIQTfa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbjIQTfR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:35:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439FDD9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:35:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A178C433C7;
        Sun, 17 Sep 2023 19:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979311;
        bh=LsMXOFyHSjtHb3B1ifJTBWtDnSe3UZkR3bbfpXEOmIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0qaQ0q1waXSt81+CwHZ6vFEKliZyp2uQAhVQKlk/9RU2Rae3yAfnu9j+lt3l0z/LE
         F3ZXd2AEKJ/YY1oy7Bh31CwY/ZmaxJEksXrQtOoE1SSyxhJdfIigDalELRHcmleHBK
         yaVVRp1V3VWvUgNnuWoW+QaCgS0FJ8DDrk14x/WY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Meng_Cai@novatek.com.cn,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 275/406] ALSA: pcm: Fix missing fixup call in compat hw_refine ioctl
Date:   Sun, 17 Sep 2023 21:12:09 +0200
Message-ID: <20230917191108.531861788@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 358040e3807754944dbddf948a23c6d914297ed7 upstream.

The update of rate_num/den and msbits were factored out to
fixup_unreferenced_params() function to be called explicitly after the
hw_refine or hw_params procedure.  It's called from
snd_pcm_hw_refine_user(), but it's forgotten in the PCM compat ioctl.
This ended up with the incomplete rate_num/den and msbits parameters
when 32bit compat ioctl is used.

This patch adds the missing call in snd_pcm_ioctl_hw_params_compat().

Reported-by: Meng_Cai@novatek.com.cn
Fixes: f9a076bff053 ("ALSA: pcm: calculate non-mask/non-interval parameters always when possible")
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230829134344.31588-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/pcm_compat.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -252,10 +252,14 @@ static int snd_pcm_ioctl_hw_params_compa
 		goto error;
 	}
 
-	if (refine)
+	if (refine) {
 		err = snd_pcm_hw_refine(substream, data);
-	else
+		if (err < 0)
+			goto error;
+		err = fixup_unreferenced_params(substream, data);
+	} else {
 		err = snd_pcm_hw_params(substream, data);
+	}
 	if (err < 0)
 		goto error;
 	if (copy_to_user(data32, data, sizeof(*data32)) ||


