Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC18879BFE9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355373AbjIKV56 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbjIKOIW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:08:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0B8E4B
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:08:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D50C433CB;
        Mon, 11 Sep 2023 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441297;
        bh=tMWgQqEr1Sgyldo3dTPb/PCST/k1EFhRqEdj5gnXdEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Weu7mechrfYCbf0+U+86+XCWJvLOQMZyo7NdIrzOVpRg7KpITkZm36uSwC9SjM5SY
         rjO4O9WyxRvMOSm3Kv4ZZN3ligfmvTuVV0IjTcvTiH+NcvuG0qCpyAngZoSidgH+cV
         g2RhcMWe14Mh5shrcU/tX/CQaK0gFYIArf/InQ1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 363/739] ASoC: pxa: merge DAI call back functions into ops
Date:   Mon, 11 Sep 2023 15:42:42 +0200
Message-ID: <20230911134701.287984009@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 98e268a7205706f809658345399eead7c7d1b8bb ]

ALSA SoC merges DAI call backs into .ops.
This patch merge these into one.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87msz1b0uq.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/pxa/mmp-sspa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index a1ed141b8795c..abfaf3cdf5bb6 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -340,6 +340,7 @@ static int mmp_sspa_probe(struct snd_soc_dai *dai)
 		SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops mmp_sspa_dai_ops = {
+	.probe		= mmp_sspa_probe,
 	.startup	= mmp_sspa_startup,
 	.shutdown	= mmp_sspa_shutdown,
 	.trigger	= mmp_sspa_trigger,
@@ -350,7 +351,6 @@ static const struct snd_soc_dai_ops mmp_sspa_dai_ops = {
 };
 
 static struct snd_soc_dai_driver mmp_sspa_dai = {
-	.probe = mmp_sspa_probe,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 128,
-- 
2.40.1



