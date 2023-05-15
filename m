Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62327703896
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbjEORdT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242000AbjEORcv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:32:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB43B76B2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:30:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52F0C62D2A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46212C433EF;
        Mon, 15 May 2023 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171846;
        bh=V+fngvI28G9CXzCWZ3US6eKbYwbHWrI+F5H/6vW7t1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IA+5wMxya925MmtEWS/ahbCCqLJ3UafWyQtBuOWH9mQQLRsfqXXNWFv4Lr12eMlme
         FkncFzWUeRFZGdSj8Qr6NS/sMaI/E8HB499TpvYNX92Yj+c1by4kAHQZGMh63PhHvf
         QHXyB7BmK0e2UqziaPWvpQl0+xKUbPBX+YfBcOSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 5.15 097/134] ASoC: soc-pcm: Fix DPCM lockdep warning due to nested stream locks
Date:   Mon, 15 May 2023 18:29:34 +0200
Message-Id: <20230515161706.375603226@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 3c75c0ea5da749bd1efebd1387f2e5011b8c7d78 upstream.

The recent change for DPCM locking caused spurious lockdep warnings.
Actually the warnings are false-positive, as those are triggered due
to the nested stream locks for FE and BE.  Since both locks belong to
the same lock class, lockdep sees it as if a deadlock.

For fixing this, we need to take PCM stream locks for BE with the
nested lock primitives.  Since currently snd_pcm_stream_lock*() helper
assumes only the top-level single locking, a new helper function
snd_pcm_stream_lock_irqsave_nested() is defined for a single-depth
nested lock, which is now used in the BE DAI trigger that is always
performed inside a FE stream lock.

Fixes: b2ae80663008 ("ASoC: soc-pcm: serialize BE triggers")
Reported-and-tested-by: Hans de Goede <hdegoede@redhat.com>
Reported-and-tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/73018f3c-9769-72ea-0325-b3f8e2381e30@redhat.com
Link: https://lore.kernel.org/alsa-devel/9a0abddd-49e9-872d-2f00-a1697340f786@samsung.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20220119155249.26754-2-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/sound/pcm.h     |   15 +++++++++++++++
 sound/core/pcm_native.c |   13 +++++++++++++
 sound/soc/soc-pcm.c     |    6 +++---
 3 files changed, 31 insertions(+), 3 deletions(-)

--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -616,6 +616,7 @@ void snd_pcm_stream_unlock(struct snd_pc
 void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream);
 void snd_pcm_stream_unlock_irq(struct snd_pcm_substream *substream);
 unsigned long _snd_pcm_stream_lock_irqsave(struct snd_pcm_substream *substream);
+unsigned long _snd_pcm_stream_lock_irqsave_nested(struct snd_pcm_substream *substream);
 
 /**
  * snd_pcm_stream_lock_irqsave - Lock the PCM stream
@@ -635,6 +636,20 @@ void snd_pcm_stream_unlock_irqrestore(st
 				      unsigned long flags);
 
 /**
+ * snd_pcm_stream_lock_irqsave_nested - Single-nested PCM stream locking
+ * @substream: PCM substream
+ * @flags: irq flags
+ *
+ * This locks the PCM stream like snd_pcm_stream_lock_irqsave() but with
+ * the single-depth lockdep subclass.
+ */
+#define snd_pcm_stream_lock_irqsave_nested(substream, flags)		\
+	do {								\
+		typecheck(unsigned long, flags);			\
+		flags = _snd_pcm_stream_lock_irqsave_nested(substream); \
+	} while (0)
+
+/**
  * snd_pcm_group_for_each_entry - iterate over the linked substreams
  * @s: the iterator
  * @substream: the substream
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -172,6 +172,19 @@ unsigned long _snd_pcm_stream_lock_irqsa
 }
 EXPORT_SYMBOL_GPL(_snd_pcm_stream_lock_irqsave);
 
+unsigned long _snd_pcm_stream_lock_irqsave_nested(struct snd_pcm_substream *substream)
+{
+	unsigned long flags = 0;
+	if (substream->pcm->nonatomic)
+		mutex_lock_nested(&substream->self_group.mutex,
+				  SINGLE_DEPTH_NESTING);
+	else
+		spin_lock_irqsave_nested(&substream->self_group.lock, flags,
+					 SINGLE_DEPTH_NESTING);
+	return flags;
+}
+EXPORT_SYMBOL_GPL(_snd_pcm_stream_lock_irqsave_nested);
+
 /**
  * snd_pcm_stream_unlock_irqrestore - Unlock the PCM stream
  * @substream: PCM substream
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -46,8 +46,8 @@ static inline void snd_soc_dpcm_stream_l
 	snd_pcm_stream_lock_irq(snd_soc_dpcm_get_substream(rtd, stream));
 }
 
-#define snd_soc_dpcm_stream_lock_irqsave(rtd, stream, flags) \
-	snd_pcm_stream_lock_irqsave(snd_soc_dpcm_get_substream(rtd, stream), flags)
+#define snd_soc_dpcm_stream_lock_irqsave_nested(rtd, stream, flags) \
+	snd_pcm_stream_lock_irqsave_nested(snd_soc_dpcm_get_substream(rtd, stream), flags)
 
 static inline void snd_soc_dpcm_stream_unlock_irq(struct snd_soc_pcm_runtime *rtd,
 						  int stream)
@@ -2109,7 +2109,7 @@ int dpcm_be_dai_trigger(struct snd_soc_p
 		be = dpcm->be;
 		be_substream = snd_soc_dpcm_get_substream(be, stream);
 
-		snd_soc_dpcm_stream_lock_irqsave(be, stream, flags);
+		snd_soc_dpcm_stream_lock_irqsave_nested(be, stream, flags);
 
 		/* is this op for this BE ? */
 		if (!snd_soc_dpcm_be_can_update(fe, be, stream))


