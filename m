Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A61A726B87
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjFGU0W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjFGU0S (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:26:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B994212B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC82164461
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFE7C433EF;
        Wed,  7 Jun 2023 20:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169538;
        bh=TgTl3mDlQ6yoJSSu128ki5gVsp6gBpM9OvTuxcF6Iv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMO9R1OCB+VCq10/9BJV6Nu44wAnOgpkvC0620DVNdHtwvLn+wFQ0oIHH41G8G8Z+
         O9Xr5hRJkhYyRYwvDYOMuc90jzMdzBZZB+9+Pj2+RQMcIMeyw15V7aPio1IC5adhJD
         pVBCUwQmwYk7kyL93A901wMjVD/9dpn3TapIf2IE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 118/286] ASoC: SOF: amd: Fix NULL pointer crash in acp_sof_ipc_msg_data function
Date:   Wed,  7 Jun 2023 22:13:37 +0200
Message-ID: <20230607200926.938000734@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>

[ Upstream commit 051d71e073614a72ad423d6dacba37a7eeff274d ]

Check substream and runtime variables before assigning.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com
Link: https://lore.kernel.org/r/20230508070510.6100-1-Vsujithkumar.Reddy@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp-ipc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 4e0c48a361599..749e856dc6011 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -209,7 +209,12 @@ int acp_sof_ipc_msg_data(struct snd_sof_dev *sdev, struct snd_sof_pcm_stream *sp
 		acp_mailbox_read(sdev, offset, p, sz);
 	} else {
 		struct snd_pcm_substream *substream = sps->substream;
-		struct acp_dsp_stream *stream = substream->runtime->private_data;
+		struct acp_dsp_stream *stream;
+
+		if (!substream || !substream->runtime)
+			return -ESTRPIPE;
+
+		stream = substream->runtime->private_data;
 
 		if (!stream)
 			return -ESTRPIPE;
-- 
2.39.2



