Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0844C78ACEF
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjH1KoN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjH1Knu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AC7CC0
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A55D964121
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C22C433C7;
        Mon, 28 Aug 2023 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219407;
        bh=e5yipL7LhOvQVAGHMQzq/IjSk5Ku2NEQc0jz8cQh1mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y1jL1BZdyT21/R2A4F/7y0FbzEfMsCOQFWKVrGnXKkNuh1te9AH4wkMdI2nsNQ3qa
         8JQax3UfOIhnIMgz8LETl3g7rC4KV5QNszopuaCjzUoFyyL2dU4ZWMMR0Rixw7U+yr
         e1UKNIReh0L7nqxtqY1lX/4wcjIp8+Ph0JVWeLFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, BassCheck <bass@buaa.edu.cn>,
        Tuo Li <islituo@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 17/89] ALSA: pcm: Fix potential data race at PCM memory allocation helpers
Date:   Mon, 28 Aug 2023 12:13:18 +0200
Message-ID: <20230828101150.752276145@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit bd55842ed998a622ba6611fe59b3358c9f76773d ]

The PCM memory allocation helpers have a sanity check against too many
buffer allocations.  However, the check is performed without a proper
lock and the allocation isn't serialized; this allows user to allocate
more memories than predefined max size.

Practically seen, this isn't really a big problem, as it's more or
less some "soft limit" as a sanity check, and it's not possible to
allocate unlimitedly.  But it's still better to address this for more
consistent behavior.

The patch covers the size check in do_alloc_pages() with the
card->memory_mutex, and increases the allocated size there for
preventing the further overflow.  When the actual allocation fails,
the size is decreased accordingly.

Reported-by: BassCheck <bass@buaa.edu.cn>
Reported-by: Tuo Li <islituo@gmail.com>
Link: https://lore.kernel.org/r/CADm8Tek6t0WedK+3Y6rbE5YEt19tML8BUL45N2ji4ZAz1KcN_A@mail.gmail.com
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230703112430.30634-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_memory.c | 44 +++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index f1470590239e5..711e71016a7c3 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -31,20 +31,51 @@ static unsigned long max_alloc_per_card = 32UL * 1024UL * 1024UL;
 module_param(max_alloc_per_card, ulong, 0644);
 MODULE_PARM_DESC(max_alloc_per_card, "Max total allocation bytes per card.");
 
+static void __update_allocated_size(struct snd_card *card, ssize_t bytes)
+{
+	card->total_pcm_alloc_bytes += bytes;
+}
+
+static void update_allocated_size(struct snd_card *card, ssize_t bytes)
+{
+	mutex_lock(&card->memory_mutex);
+	__update_allocated_size(card, bytes);
+	mutex_unlock(&card->memory_mutex);
+}
+
+static void decrease_allocated_size(struct snd_card *card, size_t bytes)
+{
+	mutex_lock(&card->memory_mutex);
+	WARN_ON(card->total_pcm_alloc_bytes < bytes);
+	__update_allocated_size(card, -(ssize_t)bytes);
+	mutex_unlock(&card->memory_mutex);
+}
+
 static int do_alloc_pages(struct snd_card *card, int type, struct device *dev,
 			  size_t size, struct snd_dma_buffer *dmab)
 {
 	int err;
 
+	/* check and reserve the requested size */
+	mutex_lock(&card->memory_mutex);
 	if (max_alloc_per_card &&
-	    card->total_pcm_alloc_bytes + size > max_alloc_per_card)
+	    card->total_pcm_alloc_bytes + size > max_alloc_per_card) {
+		mutex_unlock(&card->memory_mutex);
 		return -ENOMEM;
+	}
+	__update_allocated_size(card, size);
+	mutex_unlock(&card->memory_mutex);
 
 	err = snd_dma_alloc_pages(type, dev, size, dmab);
 	if (!err) {
-		mutex_lock(&card->memory_mutex);
-		card->total_pcm_alloc_bytes += dmab->bytes;
-		mutex_unlock(&card->memory_mutex);
+		/* the actual allocation size might be bigger than requested,
+		 * and we need to correct the account
+		 */
+		if (dmab->bytes != size)
+			update_allocated_size(card, dmab->bytes - size);
+	} else {
+		/* take back on allocation failure */
+		decrease_allocated_size(card, size);
 	}
 	return err;
 }
@@ -53,10 +84,7 @@ static void do_free_pages(struct snd_card *card, struct snd_dma_buffer *dmab)
 {
 	if (!dmab->area)
 		return;
-	mutex_lock(&card->memory_mutex);
-	WARN_ON(card->total_pcm_alloc_bytes < dmab->bytes);
-	card->total_pcm_alloc_bytes -= dmab->bytes;
-	mutex_unlock(&card->memory_mutex);
+	decrease_allocated_size(card, dmab->bytes);
 	snd_dma_free_pages(dmab);
 	dmab->area = NULL;
 }
-- 
2.40.1



