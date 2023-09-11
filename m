Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE9279BDDA
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243176AbjIKU7Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbjIKOKV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:10:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C430E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:10:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7554C433C7;
        Mon, 11 Sep 2023 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441417;
        bh=0g62UUPreABlL3Kwo3bRHHKfsBCz9GyKjcn3UOOXPVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0b2e+mgyeLab9X+vp6WOSKyu8xMLZrsKKUcFpTFGkG+zJmSfgHvILgB8hsYMvr9R
         Ap6NVXxi4ENbBmY8i/dINlEMCMZTFR0Rhqy4kqkX+++/hJ3ctbGTLVlA/mgenkXjkB
         OQ2OHiV9+Zglb3t2+Lztjo0Qhig5k2uVNwtPZEMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Su Hui <suhui@nfschina.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 369/739] ALSA: ac97: Fix possible error value of *rac97
Date:   Mon, 11 Sep 2023 15:42:48 +0200
Message-ID: <20230911134701.465026925@linuxfoundation.org>
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
index 80a65b8ad7b9b..25f93e56cfc7a 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2069,10 +2069,9 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
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



