Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665B675548D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjGPUbr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjGPUbo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:31:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7952E5C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7087760EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84431C433C7;
        Sun, 16 Jul 2023 20:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539489;
        bh=x+Sd5ueUO/aNEOa653HOCOQL6K/IBMhmM/aSlnIqtgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4KkLjto02WD7YEFKLjMb3/NaI3ygojSouyXSnwbSXC6Ab0tqSD53inEdqb3QxTWu
         SzaYQL2IvTAWd4NDuxd1z2PbSncg/ucS3fQ8ez1MpjwCWzCn1eRL9s9wXS7w2OlyYr
         IrJcO6m76VL64wIQlkZYsTeJNVcCmAqTG+2Sg5j4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 026/591] md/raid10: fix wrong setting of max_corr_read_errors
Date:   Sun, 16 Jul 2023 21:42:45 +0200
Message-ID: <20230716194924.542061636@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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
index 0c97531d35038..829e1bd9bcbf9 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4513,6 +4513,8 @@ max_corrected_read_errors_store(struct mddev *mddev, const char *buf, size_t len
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



