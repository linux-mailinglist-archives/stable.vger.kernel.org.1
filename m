Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0BE7A3812
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbjIQTal (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbjIQTad (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:30:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD29119
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D81C433C9;
        Sun, 17 Sep 2023 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979027;
        bh=reUJHxLcwvMbhnNo+n2WgtfOAlsO7t6GKQtTTlN+5Lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAa5QuALfAXyvSjthhNXBvicm7vEVAHh/KUrLOkNtnHUyd3N5ZM+MXhbQI6DJJk9p
         L+jFJEHRPZQ2ZHL0StOK65IJEjDz+/rD3xDpZ2ujH27GTG+ALlYVKPoLowO1TVRXrb
         rb7oZXoRaICw90Ukd0g/pIX96DhmxDafv4H+VsZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Su Hui <suhui@nfschina.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 168/406] ALSA: ac97: Fix possible error value of *rac97
Date:   Sun, 17 Sep 2023 21:10:22 +0200
Message-ID: <20230917191105.619208536@linuxfoundation.org>
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

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 67de40c9df94037769967ba28c7d951afb45b7fb ]

Before committing 79597c8bf64c, *rac97 always be NULL if there is
an error. When error happens, make sure *rac97 is NULL is safer.

For examble, in snd_vortex_mixer():
	err = snd_ac97_mixer(pbus, &ac97, &vortex->codec);
	vortex->isquad = ((vortex->codec == NULL) ?
		0 : (vortex->codec->ext_id&0x80));
If error happened but vortex->codec isn't NULL, this may cause some
problems.

Move the judgement order to be clearer and better.

Fixes: 79597c8bf64c ("ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer")
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20230823025212.1000961-1-suhui@nfschina.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/ac97/ac97_codec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index e18572eae5e01..d894dcdf38f4c 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2007,10 +2007,9 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 		.dev_disconnect =	snd_ac97_dev_disconnect,
 	};
 
-	if (!rac97)
-		return -EINVAL;
-	if (snd_BUG_ON(!bus || !template))
+	if (snd_BUG_ON(!bus || !template || !rac97))
 		return -EINVAL;
+	*rac97 = NULL;
 	if (snd_BUG_ON(template->num >= 4))
 		return -EINVAL;
 	if (bus->codec[template->num])
-- 
2.40.1



