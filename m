Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C34787260
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbjHXOxL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbjHXOxA (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D1E10D7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED00F66E9D
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACD7C433C9;
        Thu, 24 Aug 2023 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888777;
        bh=cRTc8eRyLHrtCb90g9KlXfs0GJ+1q7rJi62JBEFsFQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKE6IKbMGloJuyJJT63v5kAhwof5LPI92D/5lq3M0GuxT7jZfOFtFTzWYJbdBxG7Z
         zATomX89EpGVsvNbQ2xaaaL189haqORbQ/O8mk4WH8x+3CMr9gNnA0EbmAu82dUj6K
         apiQajaRpa96IY4UQKKD9R9wtHGClag2jmntdtw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, BassCheck <bass@buaa.edu.cn>,
        Tuo Li <islituo@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 037/139] ALSA: hda: fix a possible null-pointer dereference due to data race in snd_hdac_regmap_sync()
Date:   Thu, 24 Aug 2023 16:49:20 +0200
Message-ID: <20230824145025.219549166@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tuo Li <islituo@gmail.com>

[ Upstream commit 1f4a08fed450db87fbb5ff5105354158bdbe1a22 ]

The variable codec->regmap is often protected by the lock
codec->regmap_lock when is accessed. However, it is accessed without
holding the lock when is accessed in snd_hdac_regmap_sync():

  if (codec->regmap)

In my opinion, this may be a harmful race, because if codec->regmap is
set to NULL right after the condition is checked, a null-pointer
dereference can occur in the called function regcache_sync():

  map->lock(map->lock_arg); --> Line 360 in drivers/base/regmap/regcache.c

To fix this possible null-pointer dereference caused by data race, the
mutex_lock coverage is extended to protect the if statement as well as the
function call to regcache_sync().

[ Note: the lack of the regmap_lock itself is harmless for the current
  codec driver implementations, as snd_hdac_regmap_sync() is only for
  PM runtime resume that is prohibited during the codec probe.
  But the change makes the whole code more consistent, so it's merged
  as is -- tiwai ]

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
Link: https://lore.kernel.org/r/20230703031016.1184711-1-islituo@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/hdac_regmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index fe3587547cfec..39610a15bcc98 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -597,10 +597,9 @@ EXPORT_SYMBOL_GPL(snd_hdac_regmap_update_raw_once);
  */
 void snd_hdac_regmap_sync(struct hdac_device *codec)
 {
-	if (codec->regmap) {
-		mutex_lock(&codec->regmap_lock);
+	mutex_lock(&codec->regmap_lock);
+	if (codec->regmap)
 		regcache_sync(codec->regmap);
-		mutex_unlock(&codec->regmap_lock);
-	}
+	mutex_unlock(&codec->regmap_lock);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_regmap_sync);
-- 
2.40.1



