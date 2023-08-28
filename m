Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3240F78ACC3
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjH1KmP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjH1Klz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693DF10D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF22261943
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2E3C433C8;
        Mon, 28 Aug 2023 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219312;
        bh=6T1EYa6ScFFCq3Czktnc5qPp13Yc9CnxG59iNx/3mIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=124CYyWta+BTEQh0jbp+YQp79wZfNhv9V5hDi+IaJsCsjN8nU2PF3NKIFibr3vitd
         aozn25auZwPlMrclK2ba/0jHfKmQqrFVXPMfUeTrN3CijyJNKAcsHNHJjOtfEAhnQI
         lVcngiPSxwq6ymw8YiH6Rj9iyrfryvw05wDEhY/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 149/158] Revert "ALSA: pcm: Use SG-buffer only when direct DMA is available"
Date:   Mon, 28 Aug 2023 12:14:06 +0200
Message-ID: <20230828101202.695378560@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 7d50b295c4af16f814ee82369c4a234df5228801 upstream.

This reverts commit 3ad796cbc36a ("ALSA: pcm: Use SG-buffer only when
direct DMA is available") also the modification commit 467fd0e82b62
("ALSA: pcm: Fix build error on m68k and others").

Poking the DMA internal helper is a layer violation, so we should
avoid that.  Meanwhile the actual bug has been addressed by the
Kconfig fix in commit dbed452a078d ("dma-pool: decouple DMA_REMAP from
DMA_COHERENT_POOL"), so we can live without this hack.

Link: https://lore.kernel.org/r/20200717064130.22957-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/pcm_memory.c |   14 --------------
 1 file changed, 14 deletions(-)

--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -11,7 +11,6 @@
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <linux/export.h>
-#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
@@ -66,19 +65,6 @@ static int do_alloc_pages(struct snd_car
 	__update_allocated_size(card, size);
 	mutex_unlock(&card->memory_mutex);
 
-
-#ifdef CONFIG_SND_DMA_SGBUF
-	if ((type == SNDRV_DMA_TYPE_DEV_SG || type == SNDRV_DMA_TYPE_DEV_UC_SG) &&
-	    !dma_is_direct(get_dma_ops(dev))) {
-		/* mutate to continuous page allocation */
-		dev_dbg(dev, "Use continuous page allocator\n");
-		if (type == SNDRV_DMA_TYPE_DEV_SG)
-			type = SNDRV_DMA_TYPE_DEV;
-		else
-			type = SNDRV_DMA_TYPE_DEV_UC;
-	}
-#endif /* CONFIG_SND_DMA_SGBUF */
-
 	err = snd_dma_alloc_pages(type, dev, size, dmab);
 	if (!err) {
 		/* the actual allocation size might be bigger than requested,


