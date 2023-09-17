Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC957A37C7
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbjIQTYs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbjIQTYg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:24:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E85DB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:24:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBECC433C7;
        Sun, 17 Sep 2023 19:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978671;
        bh=27w9+pYL+wRDHqkaXkc3hZMXc8NO819ys1F9jEN0Jdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+/RoHXvBZORLFNnE8rFbmOEcC7y2AVXe1tcS479WNrTsG1nZh0Mml62B1d+6f9VC
         ViMOawgzWCJacDFU7H/P+13UD9P/uFFrAoNCJP6v6Ln6hfhCd7kXt1MAJTGQGnj9Vo
         0lS6iYbzmFLIV9M9yFvkySqXY9cG3LhlY7cM5Vew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 127/406] ASoC: stac9766: fix build errors with REGMAP_AC97
Date:   Sun, 17 Sep 2023 21:09:41 +0200
Message-ID: <20230917191104.501133413@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit c70064b96f509daa78f57992aeabcf274fb2fed4 ]

Select REGMAP_AC97 to fix these build errors:

ERROR: modpost: "regmap_ac97_default_volatile" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
ERROR: modpost: "__regmap_init_ac97" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!

Fixes: 6bbf787bb70c ("ASoC: stac9766: Convert to regmap")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
Link: https://lore.kernel.org/r/20230701044836.18789-1-rdunlap@infradead.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f1c9e563994b2..04a7070c78e28 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1295,6 +1295,7 @@ config SND_SOC_STA529
 config SND_SOC_STAC9766
 	tristate
 	depends on SND_SOC_AC97_BUS
+	select REGMAP_AC97
 
 config SND_SOC_STI_SAS
 	tristate "codec Audio support for STI SAS codec"
-- 
2.40.1



