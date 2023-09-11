Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD4879B9C6
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348673AbjIKV3g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241771AbjIKPOF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:14:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58721FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:14:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FC2C433C7;
        Mon, 11 Sep 2023 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445241;
        bh=tOZ17t6pB35pMvo1zSSD+xb44FY1s/6ibZogNOFv6Gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEbs4f0P3hFd01VrN4qmPwbEWukoK59P1znuFysAMT1IVqnz0Jqb7AmJwgZXwiGft
         ahsknOyhhPkNZKx0VYlBSZH8uQGfjXbzq33uHsnOLjeyUbnC4yPvuaaffgusdlmqca
         oxeSYQDdGEf9mypTXVd5mHiIlEp9tXXZZhBgk3l0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 277/600] md: restore noio_flag for the last mddev_resume()
Date:   Mon, 11 Sep 2023 15:45:10 +0200
Message-ID: <20230911134641.782538304@linuxfoundation.org>
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

[ Upstream commit e24ed04389f9619e0aaef615a8948633c182a8b0 ]

memalloc_noio_save() is called for the first mddev_suspend(), and
repeated mddev_suspend() only increase 'suspended'. However,
memalloc_noio_restore() is also called for the first mddev_resume(),
which means that memory reclaim will be enabled before the last
mddev_resume() is called, while the array is still suspended.

Fix this problem by restore 'noio_flag' for the last mddev_resume().

Fixes: 78f57ef9d50a ("md: use memalloc scope APIs in mddev_suspend()/mddev_resume()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20230628012931.88911-3-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1c44294c625a4..443837fe6291e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -485,11 +485,13 @@ EXPORT_SYMBOL_GPL(mddev_suspend);
 
 void mddev_resume(struct mddev *mddev)
 {
-	/* entred the memalloc scope from mddev_suspend() */
-	memalloc_noio_restore(mddev->noio_flag);
 	lockdep_assert_held(&mddev->reconfig_mutex);
 	if (--mddev->suspended)
 		return;
+
+	/* entred the memalloc scope from mddev_suspend() */
+	memalloc_noio_restore(mddev->noio_flag);
+
 	percpu_ref_resurrect(&mddev->active_io);
 	wake_up(&mddev->sb_wait);
 	mddev->pers->quiesce(mddev, 0);
-- 
2.40.1



