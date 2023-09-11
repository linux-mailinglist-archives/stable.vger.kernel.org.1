Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5532F79BF16
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378817AbjIKWhc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbjIKPOR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:14:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CAAFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:14:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C6EC433C9;
        Mon, 11 Sep 2023 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445252;
        bh=supR92Z9KGuN5f00HhXtGV44TV5sBM+rNv8qyA13tEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DIaCk7E0lDORd6HTuAcdr9H8lSlJqqGTGlM91UWoFpSZJHI73BnzzH3irEY6s1lxD
         kBj9GoIYOWZU/HD+78dV0HQkfvrVlHvPXYEclKNLi+LUWYu1AnEOTqjHnIPWMM/yKP
         ZS2vGmL9MxYTTQMhtufQed7zVOcmR1liwRmwn+ZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 280/600] md/md-bitmap: remove unnecessary local variable in backlog_store()
Date:   Mon, 11 Sep 2023 15:45:13 +0200
Message-ID: <20230911134641.871267350@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit b4d129640f194ffc4cc64c3e97f98ae944c072e8 ]

Local variable is definied first in the beginning of backlog_store(),
there is no need to define it again.

Fixes: 8c13ab115b57 ("md/bitmap: don't set max_write_behind if there is no write mostly device")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20230706083727.608914-2-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-bitmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 8bbeeec70905c..8553f028825a1 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2504,8 +2504,6 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 			mddev_destroy_serial_pool(mddev, NULL, false);
 	} else if (backlog && !mddev->serial_info_pool) {
 		/* serial_info_pool is needed since backlog is not zero */
-		struct md_rdev *rdev;
-
 		rdev_for_each(rdev, mddev)
 			mddev_create_serial_pool(mddev, rdev, false);
 	}
-- 
2.40.1



