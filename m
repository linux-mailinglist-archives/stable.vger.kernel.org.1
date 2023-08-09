Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AEE775AF0
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjHILMy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjHILMx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6F6211C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A09756315C
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F31C433C7;
        Wed,  9 Aug 2023 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579569;
        bh=SGk7053RZ8775LHSIY5pWkrGx0Ox9U/TNZoFnu6Q2pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ejh+piDxFRQZ60W5wrHf5Im4aPAIiKSroEzPRZ85nZsYzWoBHLXaAwg3rVSO9AM9k
         E24cD5D5U52N+CT7Ft3cz/UUyVQf68yEacrpgOzJPuF9efYrOO3MwL+5pNfu7BWX+L
         25MVX3vE7hafBeWmW1Wiov158VDJut6twzjwG4pU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 010/323] md/raid10: fix overflow of md/safe_mode_delay
Date:   Wed,  9 Aug 2023 12:37:28 +0200
Message-ID: <20230809103658.566251217@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index f8c111b369928..ad3e666b9d735 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3671,8 +3671,9 @@ int strict_strtoul_scaled(const char *cp, unsigned long *res, int scale)
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
@@ -3684,7 +3685,7 @@ safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
 		return -EINVAL;
 	}
 
-	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0)
+	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0 || msec > UINT_MAX / HZ)
 		return -EINVAL;
 	if (msec == 0)
 		mddev->safemode_delay = 0;
-- 
2.39.2



