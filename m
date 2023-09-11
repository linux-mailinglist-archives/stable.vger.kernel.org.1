Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32579AD46
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358316AbjIKWId (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240285AbjIKOkg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:40:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0825FF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:40:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1FDC433C7;
        Mon, 11 Sep 2023 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443231;
        bh=dJdWS+DXbQGTp81XfIF1HUleIs0Ryaj7Ys7zr6oyqEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ttBOlENYQMGuOE3bC0KQj90RPHdZ2V5p0W39X85xuldF7LEWo+ngAgOQlD/DuNdi4
         YG/rJxsY3nWPzHhZM8MDYMbDSIU/eecX4/u460u+jZaesVzrMW7GnmzSjVVHsfwyFJ
         qVEzl+M7Qy5O1Xt3puMahGSZBZhcZ7vsuhN9pjBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, yixuanjiang <yixuanjiang@google.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 268/737] ASoC: soc-compress: Fix deadlock in soc_compr_open_fe
Date:   Mon, 11 Sep 2023 15:42:07 +0200
Message-ID: <20230911134658.067369916@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yixuanjiang <yixuanjiang@google.com>

[ Upstream commit 2222214749a9969e09454b9ba7febfdfb09c1c8d ]

Modify the error handling flow by release lock.
The require mutex will keep holding if open fail.

Fixes: aa9ff6a4955f ("ASoC: soc-compress: Reposition and add pcm_mutex")
Signed-off-by: yixuanjiang <yixuanjiang@google.com>
Link: https://lore.kernel.org/r/20230619033127.2522477-1-yixuanjiang@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index d8715db5e415e..2117fd61cf8f3 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -194,6 +194,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	snd_soc_dai_compr_shutdown(cpu_dai, cstream, 1);
 out:
 	dpcm_path_put(&list);
+	snd_soc_dpcm_mutex_unlock(fe);
 be_err:
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
 	snd_soc_card_mutex_unlock(fe->card);
-- 
2.40.1



