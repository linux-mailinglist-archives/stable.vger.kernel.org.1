Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC86C7B8812
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243944AbjJDSMM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243957AbjJDSML (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:12:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69308D8
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:12:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC4DC433CA;
        Wed,  4 Oct 2023 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443127;
        bh=WKIG0RgnjzfpU+uSw7Ob/TuBHkHC7+D7G79s+Y0yqoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZuyYdgQB+jKNbPZfY2nitof9VZvbPeaOrGecu6tBwlvyO67extf6N0nYYyqLZ74g
         goM0VbWeYLXivju0wezayPv3a+aZJutuxGmN4plFBaASJaMillGxihrD4wRxvEO3c8
         O1B5ffeNcA8Nh+c1mYfkQEO6aHpvxJIHFnWnQKDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chen Ni <nichen@iscas.ac.cn>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 046/259] ASoC: hdaudio.c: Add missing check for devm_kstrdup
Date:   Wed,  4 Oct 2023 19:53:39 +0200
Message-ID: <20231004175219.563677061@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit c04efbfd76d23157e64e6d6147518c187ab4233a ]

Because of the potential failure of the devm_kstrdup(), the
dl[i].codecs->name could be NULL.
Therefore, we need to check it and return -ENOMEM in order to transfer
the error.

Fixes: 97030a43371e ("ASoC: Intel: avs: Add HDAudio machine board")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230915021344.3078-1-nichen@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/boards/hdaudio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/avs/boards/hdaudio.c b/sound/soc/intel/avs/boards/hdaudio.c
index 073663ba140d0..a65939f30ac47 100644
--- a/sound/soc/intel/avs/boards/hdaudio.c
+++ b/sound/soc/intel/avs/boards/hdaudio.c
@@ -54,6 +54,9 @@ static int avs_create_dai_links(struct device *dev, struct hda_codec *codec, int
 			return -ENOMEM;
 
 		dl[i].codecs->name = devm_kstrdup(dev, cname, GFP_KERNEL);
+		if (!dl[i].codecs->name)
+			return -ENOMEM;
+
 		dl[i].codecs->dai_name = pcm->name;
 		dl[i].num_codecs = 1;
 		dl[i].num_cpus = 1;
-- 
2.40.1



