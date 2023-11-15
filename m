Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C4C7ED402
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbjKOU4S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343878AbjKOU4Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:56:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435ADB7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:56:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B151FC4E778;
        Wed, 15 Nov 2023 20:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081772;
        bh=uRTgqAGJL0/WcNGRCM8IwRX6TRNSIkeuiZDCaR6iOAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r69KkKqvIno/QFAFXeDCgxuI9y5HNaeBlu+iXpgwPJxsqTHL0DxJneVLxVEL1F8kn
         ZE8KeeaRZwbtigbNyh3n/uhCKS5vXnWVuw3xy2R1La5oyEx1rV43FftU01TmnQwaqs
         UEu20mxCDdN3xSkEsoQnBG68tw5FqUeWHTOr+PhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 116/191] ASoC: ams-delta.c: use component after check
Date:   Wed, 15 Nov 2023 15:46:31 -0500
Message-ID: <20231115204651.510914822@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit bd0f7498bc9084d8cccc5484cd004b40f314b763 ]

	static void cx81801_close()
	{
		...
(A)		struct snd_soc_dapm_context *dapm = &component->card->dapm;
		...
(B)		if (!component)
			return;
	}

(A) uses component before NULL check (B). This patch moves it after (B).

Fixes: d0fdfe34080c ("ASoC: cx20442: replace codec to component")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/3e608474-e99a-4866-ae98-3054a4221f09@moroto.mountain
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87ttqdq623.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/ams-delta.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 57feb473a579c..fbd75732a68b3 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -303,7 +303,7 @@ static int cx81801_open(struct tty_struct *tty)
 static void cx81801_close(struct tty_struct *tty)
 {
 	struct snd_soc_component *component = tty->disc_data;
-	struct snd_soc_dapm_context *dapm = &component->card->dapm;
+	struct snd_soc_dapm_context *dapm;
 
 	del_timer_sync(&cx81801_timer);
 
@@ -315,6 +315,8 @@ static void cx81801_close(struct tty_struct *tty)
 
 	v253_ops.close(tty);
 
+	dapm = &component->card->dapm;
+
 	/* Revert back to default audio input/output constellation */
 	snd_soc_dapm_mutex_lock(dapm);
 
-- 
2.42.0



