Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5928974C227
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjGILRZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjGILRU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:17:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3830EB5
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:17:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA18660BCA
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FD4C433C8;
        Sun,  9 Jul 2023 11:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901438;
        bh=6jASle8N7hwxYiz01briRWzk6P4qr2XYRv9D6lpQADU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpUdFZYum+D+fWQGF3JZAedv1Ksz+lOj68Af96/rWpSbOTszu/WJbFJJ3MVO+dgGD
         +asRXRmQUpC3MYA5DNCkb4m0i5Hc0ZI0Oqt1Ixw1Q7zxUa+QqWmaD8TEowml/pWCmC
         w6cTVmazKXBk6V9U5t6wJQROt9ujEEt1TTIcOuDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 020/431] md/raid10: fix wrong setting of max_corr_read_errors
Date:   Sun,  9 Jul 2023 13:09:28 +0200
Message-ID: <20230709111451.577167715@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Nan <linan122@huawei.com>

[ Upstream commit f8b20a405428803bd9881881d8242c9d72c6b2b2 ]

There is no input check when echo md/max_read_errors and overflow might
occur. Add check of input number.

Fixes: 1e50915fe0bb ("raid: improve MD/raid10 handling of correctable read errors.")
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230522072535.1523740-3-linan666@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 61ad7dfe0e99a..2674cb1d699c0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4498,6 +4498,8 @@ max_corrected_read_errors_store(struct mddev *mddev, const char *buf, size_t len
 	rv = kstrtouint(buf, 10, &n);
 	if (rv < 0)
 		return rv;
+	if (n > INT_MAX)
+		return -EINVAL;
 	atomic_set(&mddev->max_corr_read_errors, n);
 	return len;
 }
-- 
2.39.2



