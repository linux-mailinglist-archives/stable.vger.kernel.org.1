Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F53703898
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbjEORdY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244383AbjEORc5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE07120BC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF00762D39
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2258C433EF;
        Mon, 15 May 2023 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171853;
        bh=F4VmDvo9vhiaWp/qqDmfCbSrANSvjEq2IIoUGwzChOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Un62rheKXTiDgfuPJdHWu4uiOOdMWeWMX4OHdhdVKRT4ipA1OkJd7emS2pD6Hx9zc
         iKa2f1tGdZ4EGfGPptNlahd554SpB/ygxzl+w7EYsPqp78aiHuaN1Rx1l9a+oGXuGX
         rbhJbYLC3FJctkTCJXWucpjZKXT9DWH37U4MuHI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 5.15 099/134] ASoC: soc-pcm: Move debugfs removal out of spinlock
Date:   Mon, 15 May 2023 18:29:36 +0200
Message-Id: <20230515161706.435184021@linuxfoundation.org>
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

commit 9f620684c1ef5a002b6622ecc7b5818e81252f48 upstream.

The recent fix for DPCM locking also covered the loop in
dpcm_be_disconnect() with the FE stream lock.  This caused an
unexpected side effect, thought: calling debugfs_remove_recursive() in
the spinlock may lead to lockdep splats as the code there assumes the
SOFTIRQ-safe context.

For avoiding the problem, this patch changes the disconnection
procedure to two phases: at first, the matching entries are removed
from the linked list, then the resources are freed outside the lock.

Fixes: b7898396f4bb ("ASoC: soc-pcm: Fix and cleanup DPCM locking")
Reported-and-tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20220119155249.26754-3-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-pcm.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1289,6 +1289,7 @@ static void dpcm_be_reparent(struct snd_
 void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm, *d;
+	LIST_HEAD(deleted_dpcms);
 
 	snd_soc_dpcm_mutex_assert_held(fe);
 
@@ -1308,13 +1309,18 @@ void dpcm_be_disconnect(struct snd_soc_p
 		/* BEs still alive need new FE */
 		dpcm_be_reparent(fe, dpcm->be, stream);
 
-		dpcm_remove_debugfs_state(dpcm);
-
 		list_del(&dpcm->list_be);
+		list_move(&dpcm->list_fe, &deleted_dpcms);
+	}
+	snd_soc_dpcm_stream_unlock_irq(fe, stream);
+
+	while (!list_empty(&deleted_dpcms)) {
+		dpcm = list_first_entry(&deleted_dpcms, struct snd_soc_dpcm,
+					list_fe);
 		list_del(&dpcm->list_fe);
+		dpcm_remove_debugfs_state(dpcm);
 		kfree(dpcm);
 	}
-	snd_soc_dpcm_stream_unlock_irq(fe, stream);
 }
 
 /* get BE for DAI widget and stream */


