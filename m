Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98D77599B
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjHILCA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjHILB5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:01:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362702103
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:01:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA5C6630D7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F3CC433C8;
        Wed,  9 Aug 2023 11:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578916;
        bh=xbSIp34dYYSYHFp77J0JcqfudBeVm7WjxLqFCBdZGjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1Kt0TljsnsG80m97KewkUPyTp/MaTS0b/fmKBj0BqPEQax7VeeoARWAZYEDUtAMl
         mGwEE/Cvp7EMOZEe+8F9jbCT7y4NAvc4aTbLqjOw6R3flzVPJvkmD1IW+8lFwnYCc4
         EYPZyhjfV8l66upKiU72KT9w5a6n3OLiuvwv8NkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
        Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 010/204] md/raid10: fix wrong setting of max_corr_read_errors
Date:   Wed,  9 Aug 2023 12:39:08 +0200
Message-ID: <20230809103642.926760784@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
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
index f2f3b42e44287..12392a4fb9c0d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4313,6 +4313,8 @@ max_corrected_read_errors_store(struct mddev *mddev, const char *buf, size_t len
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



