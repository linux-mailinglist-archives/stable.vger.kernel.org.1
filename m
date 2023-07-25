Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279257613A6
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjGYLMj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjGYLMK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71751FC9
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C874D6166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFEDC433CA;
        Tue, 25 Jul 2023 11:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283489;
        bh=PpraKKZXFUglXQbwlMyKTobyXN9962JMyVxjvvi+Rag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVotn2eBCTbOZOq2dgSSAS2WluJ4jkraxj7skm03igLd5h4Swb2XmDs4rqafnlo4u
         I7m4NKBi05UtQT7SuAZyn3qDR0xN34EyHIhDWPINAZJnl7beqGFJAF2Ib3ZWx+5bpP
         TW/aOPuvIX+j7+/S9HmFTCzMtwvVJH09aXx7tA1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 016/509] md/raid10: fix overflow of md/safe_mode_delay
Date:   Tue, 25 Jul 2023 12:39:15 +0200
Message-ID: <20230725104554.390026883@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index 1553c2495841b..204838a6d443e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3890,8 +3890,9 @@ int strict_strtoul_scaled(const char *cp, unsigned long *res, int scale)
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
@@ -3903,7 +3904,7 @@ safe_delay_store(struct mddev *mddev, const char *cbuf, size_t len)
 		return -EINVAL;
 	}
 
-	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0)
+	if (strict_strtoul_scaled(cbuf, &msec, 3) < 0 || msec > UINT_MAX / HZ)
 		return -EINVAL;
 	if (msec == 0)
 		mddev->safemode_delay = 0;
-- 
2.39.2



