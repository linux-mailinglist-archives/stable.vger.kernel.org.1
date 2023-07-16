Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1131975548B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjGPUbr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjGPUbo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:31:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB3E48
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BFC060E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF848C433C8;
        Sun, 16 Jul 2023 20:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539487;
        bh=V++/1YvsTGe1qL1C69TFz0cI8wPj3OPBlzzBQu73Mnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0py2cGPddrWZy+KjA4tebFwgzf7pzSTzQyuvFP8lnAiFOvfV4qiM6v4kXglRVkR6
         uaKL2RvWpyX1WOvqC8k/9uy0BxAzD/+RprUOXb+yLKVUOXsQ60C8mdBd6BGogEUbHi
         IAk9gBUzdYAQlzbj4B9Mgv5RA5KjhEWnOZiKAwbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 025/591] md/raid10: fix overflow of md/safe_mode_delay
Date:   Sun, 16 Jul 2023 21:42:44 +0200
Message-ID: <20230716194924.515773984@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Li Nan <linan122@huawei.com>

[ Upstream commit 6beb489b2eed25978523f379a605073f99240c50 ]

There is no input check when echo md/safe_mode_delay in safe_delay_store().
And msec might also overflow when HZ < 1000 in safe_delay_show(), Fix it by
checking overflow in safe_delay_store() and use unsigned long conversion in
safe_delay_show().

Fixes: 72e02075a33f ("md: factor out parsing of fixed-point numbers")
Signed-off-by: Li Nan <linan122@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230522072535.1523740-2-linan666@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index bb73a541bb193..0c97531d35038 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3830,8 +3830,9 @@ int strict_strtoul_scaled(const char *cp, unsigned long *res, int scale)
 static ssize_t
 safe_delay_show(struct mddev *mddev, char *page)
 {
-	int msec = (mddev->safemode_delay*1000)/HZ;
-	return sprintf(page, "%d.%03d\n", msec/1000, msec%1000);
+	unsigned int msec = ((unsigned long)mddev->safemode_delay*1000)/HZ;
+
+	return sprintf(page, "%u.%03u\n", msec/1000, msec%1000);
 }
 static ssize_t
 safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
@@ -3843,7 +3844,7 @@ safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
 		return -EINVAL;
 	}
 
-	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0)
+	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0 || msec > UINT_MAX / HZ)
 		return -EINVAL;
 	if (msec == 0)
 		mddev->safemode_delay = 0;
-- 
2.39.2



