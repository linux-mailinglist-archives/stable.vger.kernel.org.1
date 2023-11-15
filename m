Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175DB7ECECD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjKOTor (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjKOToo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9279E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2CDC433C7;
        Wed, 15 Nov 2023 19:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077480;
        bh=ZivbbkPgetW8pQM5R0D3o6HS7OtH6Lh9KKJWN6VXTdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AibM6F/cMFUlMlky9dlH5L8lAczp45VAzgS73ZHansW8AFkXEG+Stw63SboLS+btn
         GqK/L9cnRzvxjggo/GG1674JjVzrEGFZbqzX3zGr+xwJbhSsSkqYZcffvPyvtbpd5b
         wTXX/mO+oynLGKgKtq6gbe50QzcbkId47nQbsKgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 329/603] ASoC: cs35l41: Handle mdsync_down reg write errors
Date:   Wed, 15 Nov 2023 14:14:34 -0500
Message-ID: <20231115191636.274712767@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit a9a3f54a23d844971c274f352500dddeadb4412c ]

The return code of regmap_multi_reg_write() call related to "MDSYNC
down" sequence is shadowed by the subsequent
wait_for_completion_timeout() invocation, which is expected to time
timeout in case the write operation failed.

Let cs35l41_global_enable() return the correct error code instead of
-ETIMEDOUT.

Fixes: f5030564938b ("ALSA: cs35l41: Add shared boost feature")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20230907171010.1447274-2-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l41-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 4ec306cd2f476..a018f1d984286 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1243,7 +1243,7 @@ int cs35l41_global_enable(struct device *dev, struct regmap *regmap, enum cs35l4
 		cs35l41_mdsync_down_seq[2].def = pwr_ctrl1;
 		ret = regmap_multi_reg_write(regmap, cs35l41_mdsync_down_seq,
 					     ARRAY_SIZE(cs35l41_mdsync_down_seq));
-		if (!enable)
+		if (ret || !enable)
 			break;
 
 		if (!pll_lock)
-- 
2.42.0



