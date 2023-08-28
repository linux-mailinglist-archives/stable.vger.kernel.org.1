Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8849878AC7B
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjH1Kke (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjH1KkG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:40:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB40115
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53CC86402B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF9BC433C9;
        Mon, 28 Aug 2023 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219201;
        bh=2kvhohtT82iYXQo62LMH+I9RwLXOcivncsuwXj5rjfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=myPUX6UUTlU+sxLC/Pti0DS8u5TR4sbBmzD81BGQiYFLygAgPjGPp998d4JwopbRN
         XlyIhhcLnfMLqpXMN1KyIM9SCd4oQJEa9m0s1atyKL1NwmyRaDKytnoln1HsTIUR0J
         85oPsYrt0Fvu+wi4MAy7hQY8jZVIYIbbMjMbcCJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 110/158] ALSA: pcm: Use SG-buffer only when direct DMA is available
Date:   Mon, 28 Aug 2023 12:13:27 +0200
Message-ID: <20230828101201.006794656@linuxfoundation.org>
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

[ Upstream commit 3ad796cbc36a7bc8bfd4de191d791b9490bc112b ]

The DMA-coherent SG-buffer is tricky to use, as it does need the
mapping.  It used to work stably on x86 over years (and that's why we
had enabled SG-buffer on solely x86) with the default mmap handler and
vmap(), but our luck seems no forever success.  The chance of breakage
is high when the special DMA handling is introduced in the arch side.

In this patch, we change the buffer allocation to use the SG-buffer
only when the device in question is with the direct DMA.  It's a bit
hackish, but it's currently the only condition that may work (more or
less) reliably with the default mmap and vmap() for mapping the pages
that are deduced via virt_to_page().

In theory, we can apply the similar hack in the sound/core memory
allocation helper, too; but it's used by SOF for allocating SG pages
without re-mapping via vmap() or mmap, and it's fine to use it in that
way, so let's keep it and adds the workaround in PCM side.

Link: https://lore.kernel.org/r/20200615160045.2703-5-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: bd55842ed998 ("ALSA: pcm: Fix potential data race at PCM memory allocation helpers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_memory.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 94bd5de01a4d0..97b471d7b32e5 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -11,6 +11,7 @@
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <linux/export.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
@@ -38,6 +39,18 @@ static int do_alloc_pages(struct snd_card *card, int type, struct device *dev,
 	if (max_alloc_per_card &&
 	    card->total_pcm_alloc_bytes + size > max_alloc_per_card)
 		return -ENOMEM;
+
+	if (IS_ENABLED(CONFIG_SND_DMA_SGBUF) &&
+	    (type == SNDRV_DMA_TYPE_DEV_SG || type == SNDRV_DMA_TYPE_DEV_UC_SG) &&
+	    !dma_is_direct(get_dma_ops(dev))) {
+		/* mutate to continuous page allocation */
+		dev_dbg(dev, "Use continuous page allocator\n");
+		if (type == SNDRV_DMA_TYPE_DEV_SG)
+			type = SNDRV_DMA_TYPE_DEV;
+		else
+			type = SNDRV_DMA_TYPE_DEV_UC;
+	}
+
 	err = snd_dma_alloc_pages(type, dev, size, dmab);
 	if (!err) {
 		mutex_lock(&card->memory_mutex);
-- 
2.40.1



