Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8E378AC7D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjH1Kkb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjH1KkC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:40:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03A3A7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7772B6402B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CCCC433C8;
        Mon, 28 Aug 2023 10:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219198;
        bh=c0O7kvri/r7ooOd+xT3ljOqORVHCkXGZJq9EYtIj528=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOdWEMQrlTWefsAb6B9fiHl2WxqoEGBeLjpNsnGtx3m525BKOxS2sCJtI7ifdPuB4
         eyCekkgMMw446nY8qhxYhLDJ4QNljpJcIjh5OQq4o4cn9ErdsjipPceL7tnmk8fP8D
         qM/AGc1b503n0VcUivZpdJKwEZGQ4CyTaM/01bHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 109/158] ALSA: pcm: Set per-card upper limit of PCM buffer allocations
Date:   Mon, 28 Aug 2023 12:13:26 +0200
Message-ID: <20230828101200.977406987@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit d4cfb30fce03093ad944e0b44bd8f40bdad5330e ]

Currently, the available buffer allocation size for a PCM stream
depends on the preallocated size; when a buffer has been preallocated,
the max buffer size is set to that size, so that application won't
re-allocate too much memory.  OTOH, when no preallocation is done,
each substream may allocate arbitrary size of buffers as long as
snd_pcm_hardware.buffer_bytes_max allows -- which can be quite high,
HD-audio sets 1GB there.

It means that the system may consume a high amount of pages for PCM
buffers, and they are pinned and never swapped out.  This can lead to
OOM easily.

For avoiding such a situation, this patch adds the upper limit per
card.  Each snd_pcm_lib_malloc_pages() and _free_pages() calls are
tracked and it will return an error if the total amount of buffers
goes over the defined upper limit.  The default value is set to 32MB,
which should be really large enough for usual operations.

If larger buffers are needed for any specific usage, it can be
adjusted (also dynamically) via snd_pcm.max_alloc_per_card option.
Setting zero there means no chceck is performed, and again, unlimited
amount of buffers are allowed.

Link: https://lore.kernel.org/r/20200120124423.11862-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: bd55842ed998 ("ALSA: pcm: Fix potential data race at PCM memory allocation helpers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/core.h    |  3 ++
 sound/core/init.c       |  1 +
 sound/core/pcm_memory.c | 69 ++++++++++++++++++++++++++++++-----------
 3 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 8a80121811d94..e4b24dcb4b190 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -119,6 +119,9 @@ struct snd_card {
 	bool registered;		/* card_dev is registered? */
 	wait_queue_head_t remove_sleep;
 
+	size_t total_pcm_alloc_bytes;	/* total amount of allocated buffers */
+	struct mutex memory_mutex;	/* protection for the above */
+
 #ifdef CONFIG_PM
 	unsigned int power_state;	/* power state */
 	wait_queue_head_t power_sleep;
diff --git a/sound/core/init.c b/sound/core/init.c
index 45bbc4884ef0f..a127763ae5fbd 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -211,6 +211,7 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 	INIT_LIST_HEAD(&card->ctl_files);
 	spin_lock_init(&card->files_lock);
 	INIT_LIST_HEAD(&card->files_list);
+	mutex_init(&card->memory_mutex);
 #ifdef CONFIG_PM
 	init_waitqueue_head(&card->power_sleep);
 #endif
diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 9aea1d6fb0547..94bd5de01a4d0 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -26,6 +26,38 @@ MODULE_PARM_DESC(maximum_substreams, "Maximum substreams with preallocated DMA m
 
 static const size_t snd_minimum_buffer = 16384;
 
+static unsigned long max_alloc_per_card = 32UL * 1024UL * 1024UL;
+module_param(max_alloc_per_card, ulong, 0644);
+MODULE_PARM_DESC(max_alloc_per_card, "Max total allocation bytes per card.");
+
+static int do_alloc_pages(struct snd_card *card, int type, struct device *dev,
+			  size_t size, struct snd_dma_buffer *dmab)
+{
+	int err;
+
+	if (max_alloc_per_card &&
+	    card->total_pcm_alloc_bytes + size > max_alloc_per_card)
+		return -ENOMEM;
+	err = snd_dma_alloc_pages(type, dev, size, dmab);
+	if (!err) {
+		mutex_lock(&card->memory_mutex);
+		card->total_pcm_alloc_bytes += dmab->bytes;
+		mutex_unlock(&card->memory_mutex);
+	}
+	return err;
+}
+
+static void do_free_pages(struct snd_card *card, struct snd_dma_buffer *dmab)
+{
+	if (!dmab->area)
+		return;
+	mutex_lock(&card->memory_mutex);
+	WARN_ON(card->total_pcm_alloc_bytes < dmab->bytes);
+	card->total_pcm_alloc_bytes -= dmab->bytes;
+	mutex_unlock(&card->memory_mutex);
+	snd_dma_free_pages(dmab);
+	dmab->area = NULL;
+}
 
 /*
  * try to allocate as the large pages as possible.
@@ -36,16 +68,15 @@ static const size_t snd_minimum_buffer = 16384;
 static int preallocate_pcm_pages(struct snd_pcm_substream *substream, size_t size)
 {
 	struct snd_dma_buffer *dmab = &substream->dma_buffer;
+	struct snd_card *card = substream->pcm->card;
 	size_t orig_size = size;
 	int err;
 
 	do {
-		if ((err = snd_dma_alloc_pages(dmab->dev.type, dmab->dev.dev,
-					       size, dmab)) < 0) {
-			if (err != -ENOMEM)
-				return err; /* fatal error */
-		} else
-			return 0;
+		err = do_alloc_pages(card, dmab->dev.type, dmab->dev.dev,
+				     size, dmab);
+		if (err != -ENOMEM)
+			return err;
 		size >>= 1;
 	} while (size >= snd_minimum_buffer);
 	dmab->bytes = 0; /* tell error */
@@ -61,10 +92,7 @@ static int preallocate_pcm_pages(struct snd_pcm_substream *substream, size_t siz
  */
 static void snd_pcm_lib_preallocate_dma_free(struct snd_pcm_substream *substream)
 {
-	if (substream->dma_buffer.area == NULL)
-		return;
-	snd_dma_free_pages(&substream->dma_buffer);
-	substream->dma_buffer.area = NULL;
+	do_free_pages(substream->pcm->card, &substream->dma_buffer);
 }
 
 /**
@@ -129,6 +157,7 @@ static void snd_pcm_lib_preallocate_proc_write(struct snd_info_entry *entry,
 					       struct snd_info_buffer *buffer)
 {
 	struct snd_pcm_substream *substream = entry->private_data;
+	struct snd_card *card = substream->pcm->card;
 	char line[64], str[64];
 	size_t size;
 	struct snd_dma_buffer new_dmab;
@@ -150,9 +179,10 @@ static void snd_pcm_lib_preallocate_proc_write(struct snd_info_entry *entry,
 		memset(&new_dmab, 0, sizeof(new_dmab));
 		new_dmab.dev = substream->dma_buffer.dev;
 		if (size > 0) {
-			if (snd_dma_alloc_pages(substream->dma_buffer.dev.type,
-						substream->dma_buffer.dev.dev,
-						size, &new_dmab) < 0) {
+			if (do_alloc_pages(card,
+					   substream->dma_buffer.dev.type,
+					   substream->dma_buffer.dev.dev,
+					   size, &new_dmab) < 0) {
 				buffer->error = -ENOMEM;
 				goto unlock;
 			}
@@ -161,7 +191,7 @@ static void snd_pcm_lib_preallocate_proc_write(struct snd_info_entry *entry,
 			substream->buffer_bytes_max = UINT_MAX;
 		}
 		if (substream->dma_buffer.area)
-			snd_dma_free_pages(&substream->dma_buffer);
+			do_free_pages(card, &substream->dma_buffer);
 		substream->dma_buffer = new_dmab;
 	} else {
 		buffer->error = -EINVAL;
@@ -289,6 +319,7 @@ EXPORT_SYMBOL(snd_pcm_sgbuf_ops_page);
  */
 int snd_pcm_lib_malloc_pages(struct snd_pcm_substream *substream, size_t size)
 {
+	struct snd_card *card = substream->pcm->card;
 	struct snd_pcm_runtime *runtime;
 	struct snd_dma_buffer *dmab = NULL;
 
@@ -317,9 +348,10 @@ int snd_pcm_lib_malloc_pages(struct snd_pcm_substream *substream, size_t size)
 		if (! dmab)
 			return -ENOMEM;
 		dmab->dev = substream->dma_buffer.dev;
-		if (snd_dma_alloc_pages(substream->dma_buffer.dev.type,
-					substream->dma_buffer.dev.dev,
-					size, dmab) < 0) {
+		if (do_alloc_pages(card,
+				   substream->dma_buffer.dev.type,
+				   substream->dma_buffer.dev.dev,
+				   size, dmab) < 0) {
 			kfree(dmab);
 			return -ENOMEM;
 		}
@@ -340,6 +372,7 @@ EXPORT_SYMBOL(snd_pcm_lib_malloc_pages);
  */
 int snd_pcm_lib_free_pages(struct snd_pcm_substream *substream)
 {
+	struct snd_card *card = substream->pcm->card;
 	struct snd_pcm_runtime *runtime;
 
 	if (PCM_RUNTIME_CHECK(substream))
@@ -349,7 +382,7 @@ int snd_pcm_lib_free_pages(struct snd_pcm_substream *substream)
 		return 0;
 	if (runtime->dma_buffer_p != &substream->dma_buffer) {
 		/* it's a newly allocated buffer.  release it now. */
-		snd_dma_free_pages(runtime->dma_buffer_p);
+		do_free_pages(card, runtime->dma_buffer_p);
 		kfree(runtime->dma_buffer_p);
 	}
 	snd_pcm_set_runtime_buffer(substream, NULL);
-- 
2.40.1



