Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F847ECC69
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjKOTaO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjKOTaN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:30:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6AE9E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:30:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DACFC433C7;
        Wed, 15 Nov 2023 19:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076610;
        bh=r7hxSxgpBlWbidD1E+oGhXA+/B13aNazZmGj3gOIqlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBBH8mVDI+tlIRccU4k+4RDlszXGOU1Hawdrq2kCcmctAz0FlekWXNd7r+VCvqs27
         Ymt0Y03HaD+PiNeSMQdJISu5BoJ0io2vdYjFfstDCCT6/ZYlPpANK9/6Xun/XkagB6
         HhVtemMvdJJjq23VOQFAkPeedqsqvZWqj2qfNuMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hui Wang <hui.wang@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 338/550] ASoC: fsl-asoc-card: Add comment for mclk in the codec_priv
Date:   Wed, 15 Nov 2023 14:15:22 -0500
Message-ID: <20231115191624.186912857@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

[ Upstream commit fbfe616ad40c06d68b83b657a94cd2e709dda37b ]

Otherwise a warning will be detected as below:
warning: Function parameter or member 'mclk' not described in
'codec_priv'

Fixes: 1075df4bdeb3 ("ASoC: fsl-asoc-card: add nau8822 support")
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Link: https://lore.kernel.org/r/20231007040117.22446-1-hui.wang@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index bab7d34cf585b..5f181b89838ac 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -41,6 +41,7 @@
 
 /**
  * struct codec_priv - CODEC private data
+ * @mclk: Main clock of the CODEC
  * @mclk_freq: Clock rate of MCLK
  * @free_freq: Clock rate of MCLK for hw_free()
  * @mclk_id: MCLK (or main clock) id for set_sysclk()
-- 
2.42.0



