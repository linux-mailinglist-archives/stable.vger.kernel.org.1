Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113136FA8BE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjEHKpM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjEHKot (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:44:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE3C27F09
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:43:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF416286C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88549C433EF;
        Mon,  8 May 2023 10:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542600;
        bh=G4jpYYh9d3uOAR8wsseuD59NZ6p0UnHzYsK51NtaEoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATSnQVGcz996Y/4CnZGLG9Fx60HnvPS4ATPc51cJm70r01dLHcNtLfgtiyy/3bXK+
         p3azhierIC6MBYAHVK1B0VuPBZGLCSp1kJmQpdMFLwo5h7B27jKCYIXRFKQ+NSupcd
         YQSRfhshcn/j7W/WSkkgMX0e91GC+XoFaUkjEilE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 455/663] ASoC: soc-compress: Inherit atomicity from DAI link for Compress FE
Date:   Mon,  8 May 2023 11:44:41 +0200
Message-Id: <20230508094442.871750415@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Daniel Baluta <daniel.baluta@nxp.com>

[ Upstream commit 37b58becc1cee4d591024f2056d7ffa99c6089e0 ]

After commit bbf7d3b1c4f40 ("ASoC: soc-pcm: align BE 'atomicity' with
that of the FE") BE and FE atomicity must match.

In the case of Compress PCM there is a mismatch in atomicity between FE
and BE and we get errors like this:

[   36.434566]  sai1-wm8960-hifi: dpcm_be_connect: FE is atomic but BE
is nonatomic, invalid configuration
[   36.444278]  PCM Deep Buffer: ASoC: can't connect SAI1.OUT

In order to fix this we must inherit the atomicity from DAI link
associated with current PCM Compress FE.

Fixes: bbf7d3b1c4f4 ("ASoC: soc-pcm: align BE 'atomicity' with that of the FE")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230324124019.30826-1-daniel.baluta@oss.nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-compress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index e7aa6f360cabe..d649b0cf4744f 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -622,6 +622,9 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 			return ret;
 		}
 
+		/* inherit atomicity from DAI link */
+		be_pcm->nonatomic = rtd->dai_link->nonatomic;
+
 		rtd->pcm = be_pcm;
 		rtd->fe_compr = 1;
 		if (rtd->dai_link->dpcm_playback)
-- 
2.39.2



