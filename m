Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB3878ACC5
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjH1KmR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjH1KmB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:42:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD23B9
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A19B63F14
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD97AC433C7;
        Mon, 28 Aug 2023 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219318;
        bh=kzgVQzeWszVhHHLjIpy6sNxFjSs2zVQXSaa9aq+9AoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yJ+OvAkoycBjrFwkvJZ6KtwmBYC35PHCL8TKxKTBNaR5Bq2XWh9kZWwLQ/Lu5einn
         ox3LGaGZAt9zGbFMqocS7Hd8545XIbgyUlJbUtcdM1QGbBmz5k7oHjN7QsUjmH257j
         2x0dFhlS2WaD4cop74x65/nyEIxYwZp7+a2PRhw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Colin Ian King <colin.i.king@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 151/158] ALSA: pcm: Check for null pointer of pointer substream before dereferencing it
Date:   Mon, 28 Aug 2023 12:14:08 +0200
Message-ID: <20230828101202.794821211@linuxfoundation.org>
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

From: Colin Ian King <colin.i.king@gmail.com>

commit 011b559be832194f992f73d6c0d5485f5925a10b upstream.

Pointer substream is being dereferenced on the assignment of pointer card
before substream is being null checked with the macro PCM_RUNTIME_CHECK.
Although PCM_RUNTIME_CHECK calls BUG_ON, it still is useful to perform the
the pointer check before card is assigned.

Fixes: d4cfb30fce03 ("ALSA: pcm: Set per-card upper limit of PCM buffer allocations")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Link: https://lore.kernel.org/r/20220424205945.1372247-1-colin.i.king@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/pcm_memory.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -401,7 +401,6 @@ EXPORT_SYMBOL(snd_pcm_lib_malloc_pages);
  */
 int snd_pcm_lib_free_pages(struct snd_pcm_substream *substream)
 {
-	struct snd_card *card = substream->pcm->card;
 	struct snd_pcm_runtime *runtime;
 
 	if (PCM_RUNTIME_CHECK(substream))
@@ -410,6 +409,8 @@ int snd_pcm_lib_free_pages(struct snd_pc
 	if (runtime->dma_area == NULL)
 		return 0;
 	if (runtime->dma_buffer_p != &substream->dma_buffer) {
+		struct snd_card *card = substream->pcm->card;
+
 		/* it's a newly allocated buffer.  release it now. */
 		do_free_pages(card, runtime->dma_buffer_p);
 		kfree(runtime->dma_buffer_p);


