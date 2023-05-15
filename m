Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4391470389A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244276AbjEORdc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244286AbjEORdQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD0813281
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:31:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07B3762D3B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B275C433D2;
        Mon, 15 May 2023 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171859;
        bh=QI2K0loe8k3M28BNuCxhp4xyfKlRNfUnnoBlg1EQw4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjEKgqiZ+s8XFq1+JWX+j/ZaBEkkcl9En2sORl0zJQSw/UcvwZ4b1Och8PrnUw4qj
         Z7vjO7RdjVjaWmRi83PTJMX3W/0zJXfs75MnpNZbFuaz+1/IIbWq6MZxelLFkjeeWJ
         04Ei1gYFiyPDbw0ZesDDS/kKOAwDA7z8/bH1+bFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 101/134] ASoC: soc-pcm.c: call __soc_pcm_close() in soc_pcm_close()
Date:   Mon, 15 May 2023 18:29:38 +0200
Message-Id: <20230515161706.494629358@linuxfoundation.org>
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

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 6bbabd28805f36baf6d0f3eb082db032a638f612 upstream.

commit b7898396f4bbe16 ("ASoC: soc-pcm: Fix and cleanup DPCM locking")
added __soc_pcm_close() for non-lock version of soc_pcm_close().
But soc_pcm_close() is not using it. It is no problem, but confusable.

	static int __soc_pcm_close(...)
	{
=>		return soc_pcm_clean(rtd, substream, 0);
	}

	static int soc_pcm_close(...)
	{
		...
		snd_soc_dpcm_mutex_lock(rtd);
=>		soc_pcm_clean(rtd, substream, 0);
		snd_soc_dpcm_mutex_unlock(rtd);
		return 0;
	}

This patch use it.

Fixes: b7898396f4bbe16 ("ASoC: soc-pcm: Fix and cleanup DPCM locking")
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87czctgg3w.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-pcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -723,7 +723,7 @@ static int soc_pcm_close(struct snd_pcm_
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 
 	snd_soc_dpcm_mutex_lock(rtd);
-	soc_pcm_clean(rtd, substream, 0);
+	__soc_pcm_close(rtd, substream);
 	snd_soc_dpcm_mutex_unlock(rtd);
 	return 0;
 }


