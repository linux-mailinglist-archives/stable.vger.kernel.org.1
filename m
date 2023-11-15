Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AB07ED591
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbjKOVHk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbjKOVH0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:07:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE5611D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:07:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1565C116D7;
        Wed, 15 Nov 2023 20:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081313;
        bh=qRAOkC7/bknMd+lv1nYlVOMygNGfMbnM848E7RMKt+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppnZO83qXy4MlXzPtEhytEhrzCgDaMRV3uSuwQNQeFW7k1W43TiVoXwgq71sazkyg
         eot1iS0KqkdLUAOpCCCLfYk3hnxPXA+fcxEFNu0weXEUiqkKLGnV+VE1Xr2tWk/Nyp
         thMdA6cYH27fJtz7SDAxlhUpu7kQXsu+MkwWUK/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 051/244] regmap: debugfs: Fix a erroneous check after snprintf()
Date:   Wed, 15 Nov 2023 15:34:03 -0500
Message-ID: <20231115203551.429759615@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit d3601857e14de6369f00ae19564f1d817d175d19 ]

This error handling looks really strange.
Check if the string has been truncated instead.

Fixes: f0c2319f9f19 ("regmap: Expose the driver name in debugfs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/8595de2462c490561f70020a6d11f4d6b652b468.1693857825.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index ad684d37c2dae..6caed4b556365 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -48,7 +48,7 @@ static ssize_t regmap_name_read_file(struct file *file,
 		name = map->dev->driver->name;
 
 	ret = snprintf(buf, PAGE_SIZE, "%s\n", name);
-	if (ret < 0) {
+	if (ret >= PAGE_SIZE) {
 		kfree(buf);
 		return ret;
 	}
-- 
2.42.0



