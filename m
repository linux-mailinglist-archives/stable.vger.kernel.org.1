Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD78783326
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjHUUJ0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjHUUJ0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:09:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07787130
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91CA264A73
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E030C433C8;
        Mon, 21 Aug 2023 20:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648559;
        bh=3q7p2bFw7kiWIpnQ6Cc3rtSTti6zo0yW21jZGNdzux4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gOaJPr8LXdwB8iC0qmiS/peb8Hbr7ScFwt81Zy7OqJhdF/0aimJaup+SselKNNh+p
         rT8XzhGvKFsR38hfx1kICc3jgdXMiqguGRRK8FFywBc6Vrd+VR7NmY3AaeIKx+PpZT
         4fmC3sG1rDKWwlukiUi5w1CmyszpezSzkXhu08AE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 189/234] ASoC: max98363: dont return on success reading revision ID
Date:   Mon, 21 Aug 2023 21:42:32 +0200
Message-ID: <20230821194137.188369740@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 385311101538b071a487a9245e01349e3a68ed2c ]

max98363_io_init needs to keep going when we read revision ID
successfully.

Fixes: 18c0af945fa3 ("ASoC: max98363: add soundwire amplifier driver")
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20230804034734.3848227-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/max98363.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98363.c b/sound/soc/codecs/max98363.c
index e6b84e222b504..169913ba76dd7 100644
--- a/sound/soc/codecs/max98363.c
+++ b/sound/soc/codecs/max98363.c
@@ -191,10 +191,10 @@ static int max98363_io_init(struct sdw_slave *slave)
 	pm_runtime_get_noresume(dev);
 
 	ret = regmap_read(max98363->regmap, MAX98363_R21FF_REV_ID, &reg);
-	if (!ret) {
+	if (!ret)
 		dev_info(dev, "Revision ID: %X\n", reg);
-		return ret;
-	}
+	else
+		goto out;
 
 	if (max98363->first_hw_init) {
 		regcache_cache_bypass(max98363->regmap, false);
@@ -204,10 +204,11 @@ static int max98363_io_init(struct sdw_slave *slave)
 	max98363->first_hw_init = true;
 	max98363->hw_init = true;
 
+out:
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
-	return 0;
+	return ret;
 }
 
 #define MAX98363_RATES SNDRV_PCM_RATE_8000_192000
-- 
2.40.1



