Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7037D75522F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjGPUEu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjGPUEu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:04:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5585B9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7B8460EAA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044DAC433C7;
        Sun, 16 Jul 2023 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537888;
        bh=96v5UnXev6154ikau+g+2DZOKnNm0Z2/OeNFYiDq3K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b40AYm59iCtY7ePIqqawKhJ1dH3gyKqWAxUj3tFxcUxkyARtJFF282vC6zlOkZPVt
         HLkDV9kM5TIwO+DvaOyc/le/dcahBbMBISRran2uInjVm0YZyDPpK1hv+w35txnv5e
         o8y6eGYlTWz0iT4omQpL6UORBbu0xSWZTpcWZpkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 257/800] ASoC: Intel: sof_sdw: start set codec init function with an adr index
Date:   Sun, 16 Jul 2023 21:41:50 +0200
Message-ID: <20230716194955.066375958@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit f0c8d83ab1a3532ebeb1a89acb649be01657aed8 ]

Currently, set_codec_init_func always start with link->adr_d[0] because
we assumed all adr_d on the same link are the same devices. The
assumption is no longer valid when different devices on the same sdw link
are supported.

Fixes: c8db7b50128b ("ASoC: Intel: sof_sdw: support different devices on the same sdw link")
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
Link: https://lore.kernel.org/r/20230512173305.65399-6-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index a33b7678bc3b8..5fa204897a52b 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -902,17 +902,20 @@ static int create_codec_dai_name(struct device *dev,
 static int set_codec_init_func(struct snd_soc_card *card,
 			       const struct snd_soc_acpi_link_adr *link,
 			       struct snd_soc_dai_link *dai_links,
-			       bool playback, int group_id)
+			       bool playback, int group_id, int adr_index)
 {
-	int i;
+	int i = adr_index;
 
 	do {
 		/*
 		 * Initialize the codec. If codec is part of an aggregated
 		 * group (group_id>0), initialize all codecs belonging to
 		 * same group.
+		 * The first link should start with link->adr_d[adr_index]
+		 * because that is the device that we want to initialize and
+		 * we should end immediately if it is not aggregated (group_id=0)
 		 */
-		for (i = 0; i < link->num_adr; i++) {
+		for ( ; i < link->num_adr; i++) {
 			int codec_index;
 
 			codec_index = find_codec_info_part(link->adr_d[i].adr);
@@ -928,9 +931,12 @@ static int set_codec_init_func(struct snd_soc_card *card,
 						dai_links,
 						&codec_info_list[codec_index],
 						playback);
+			if (!group_id)
+				return 0;
 		}
+		i = 0;
 		link++;
-	} while (link->mask && group_id);
+	} while (link->mask);
 
 	return 0;
 }
@@ -1180,7 +1186,7 @@ static int create_sdw_dailink(struct snd_soc_card *card,
 		dai_links[*link_index].nonatomic = true;
 
 		ret = set_codec_init_func(card, link, dai_links + (*link_index)++,
-					  playback, group_id);
+					  playback, group_id, adr_index);
 		if (ret < 0) {
 			dev_err(dev, "failed to init codec %d", codec_index);
 			return ret;
-- 
2.39.2



